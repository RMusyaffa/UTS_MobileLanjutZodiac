// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

@TestOn('vm')
library;

import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:file_testing/file_testing.dart';
import 'package:platform/platform.dart';
import 'package:test/test.dart';

void main() {
  const FileSystem localFs = LocalFileSystem();
  final _FlutterRootUnderTest flutterRoot = _FlutterRootUnderTest.findWithin();

  late Directory tmpDir;
  late _FlutterRootUnderTest testRoot;
  late Map<String, String> environment;

  void printIfNotEmpty(String prefix, String string) {
    if (string.isNotEmpty) {
      string.split(io.Platform.lineTerminator).forEach((String s) {
        print('$prefix:>$s<');
      });
    }
  }

  io.ProcessResult run(String executable, List<String> args, {String? workingPath}) {
    print('Running "$executable ${args.join(" ")}"');
    final io.ProcessResult result = io.Process.runSync(
      executable,
      args,
      environment: environment,
      workingDirectory: workingPath ?? testRoot.root.absolute.path,
      includeParentEnvironment: false,
    );
    if (result.exitCode != 0) {
      print('exitCode: ${result.exitCode}');
    }
    printIfNotEmpty('stdout', (result.stdout as String).trim());
    printIfNotEmpty('stderr', (result.stderr as String).trim());
    return result;
  }

  setUp(() async {
    tmpDir = localFs.systemTempDirectory.createTempSync('update_engine_version_test.');
    testRoot = _FlutterRootUnderTest.fromPath(tmpDir.childDirectory('flutter').path);

    environment = <String, String>{};
    environment.addAll(io.Platform.environment);
    environment.remove('FLUTTER_PREBUILT_ENGINE_VERSION');

    // Copy the update_engine_version script and create a rough directory structure.
    flutterRoot.binInternalUpdateEngineVersion.copySyncRecursive(
      testRoot.binInternalUpdateEngineVersion.path,
    );
  });

  tearDown(() {
    tmpDir.deleteSync(recursive: true);
  });

  io.ProcessResult runUpdateEngineVersion() {
    final (String executable, List<String> args) =
        const LocalPlatform().isWindows
            ? ('powershell', <String>[testRoot.binInternalUpdateEngineVersion.path])
            : (testRoot.binInternalUpdateEngineVersion.path, <String>[]);
    return run(executable, args);
  }

  void setupRepo({required String branch}) {
    for (final File f in <File>[testRoot.deps, testRoot.engineSrcGn]) {
      f.createSync(recursive: true);
    }

    run('git', <String>['init', '--initial-branch', 'master']);
    run('git', <String>['add', '.']);
    run('git', <String>['commit', '-m', 'Initial commit']);
    if (branch != 'master') {
      run('git', <String>['checkout', '-b', branch]);
    }
  }

  const String engineVersionTrackedContents = 'already existing contents';
  void setupTrackedEngineVersion() {
    testRoot.binInternalEngineVersion.writeAsStringSync(engineVersionTrackedContents);
    run('git', <String>['add', '-f', 'bin/internal/engine.version']);
    run('git', <String>['commit', '-m', 'tracking engine.version']);
  }

  void setupRemote({required String remote, String? rootPath}) {
    run('git', <String>[
      'remote',
      'add',
      remote,
      rootPath ?? testRoot.root.path,
    ], workingPath: rootPath);
    run('git', <String>['fetch', remote], workingPath: rootPath);
  }

  void initGitRepoWithBlankInitialCommit({String? workingPath}) {
    run('git', <String>['init', '--initial-branch', 'master'], workingPath: workingPath);
    run('git', <String>[
      'config',
      '--local',
      'user.email',
      'test@example.com',
    ], workingPath: workingPath);
    run('git', <String>['config', '--local', 'user.name', 'Test User'], workingPath: workingPath);
    run('git', <String>['add', '.'], workingPath: workingPath);
    run('git', <String>[
      'commit',
      '--allow-empty',
      '-m',
      'Initial commit',
    ], workingPath: workingPath);
  }

  group('GIT_DIR', () {
    late Directory externalGit;
    late String externalHead;
    setUp(() {
      externalGit = localFs.systemTempDirectory.createTempSync('GIT_DIR_test.');
      initGitRepoWithBlankInitialCommit(workingPath: externalGit.path);
      setupRemote(remote: 'upstream', rootPath: externalGit.path);

      externalHead =
          (run('git', <String>['rev-parse', 'HEAD'], workingPath: externalGit.path).stdout
                  as String)
              .trim();
    });

    test('un-sets environment variables', () {
      // Needs to happen before GIT_DIR is set
      initGitRepoWithBlankInitialCommit();
      setupRemote(remote: 'upstream');

      environment['GIT_DIR'] = '${externalGit.path}/.git';
      environment['GIT_INDEX_FILE'] = '${externalGit.path}/.git/index';
      environment['GIT_WORK_TREE'] = externalGit.path;

      runUpdateEngineVersion();

      final String engineStamp = testRoot.binInternalEngineVersion.readAsStringSync().trim();
      expect(engineStamp, isNot(equals(externalHead)));
    });

    tearDown(() {
      externalGit.deleteSync(recursive: true);
    });
  });

  group('if FLUTTER_PREBUILT_ENGINE_VERSION is set', () {
    setUp(() {
      environment['FLUTTER_PREBUILT_ENGINE_VERSION'] = '123abc';
      setupRepo(branch: 'master');
    });

    test('writes it to engine.version with no git interaction', () async {
      runUpdateEngineVersion();

      expect(testRoot.binInternalEngineVersion, exists);
      expect(
        testRoot.binInternalEngineVersion.readAsStringSync(),
        equalsIgnoringWhitespace('123abc'),
      );
    });
  });

  test('writes nothing, even if files are set, if we are on "stable"', () async {
    setupRepo(branch: 'stable');
    setupTrackedEngineVersion();
    setupRemote(remote: 'upstream');

    runUpdateEngineVersion();

    expect(testRoot.binInternalEngineVersion, exists);
    expect(
      testRoot.binInternalEngineVersion.readAsStringSync(),
      equalsIgnoringWhitespace(engineVersionTrackedContents),
    );
  });

  test('writes nothing, even if files are set, if we are on "3.29.0"', () async {
    setupRepo(branch: '3.29.0');
    setupTrackedEngineVersion();
    setupRemote(remote: 'upstream');

    runUpdateEngineVersion();

    expect(testRoot.binInternalEngineVersion, exists);
    expect(
      testRoot.binInternalEngineVersion.readAsStringSync(),
      equalsIgnoringWhitespace(engineVersionTrackedContents),
    );
  });

  test('writes nothing, even if files are set, if we are on "beta"', () async {
    setupRepo(branch: 'beta');
    setupTrackedEngineVersion();
    setupRemote(remote: 'upstream');

    runUpdateEngineVersion();

    expect(testRoot.binInternalEngineVersion, exists);
    expect(
      testRoot.binInternalEngineVersion.readAsStringSync(),
      equalsIgnoringWhitespace(engineVersionTrackedContents),
    );
  });

  group('if DEPS and engine/src/.gn are present, engine.version is derived from', () {
    setUp(() async {
      setupRepo(branch: 'master');
    });

    test('merge-base HEAD upstream/master on non-LUCI when upstream is set', () async {
      setupRemote(remote: 'upstream');

      final io.ProcessResult mergeBaseHeadUpstream = run('git', <String>[
        'merge-base',
        'HEAD',
        'upstream/master',
      ]);
      runUpdateEngineVersion();

      expect(testRoot.binInternalEngineVersion, exists);
      expect(
        testRoot.binInternalEngineVersion.readAsStringSync(),
        equalsIgnoringWhitespace(mergeBaseHeadUpstream.stdout as String),
      );
    });

    test('merge-base HEAD origin/master on non-LUCI when upstream is not set', () async {
      setupRemote(remote: 'origin');

      final io.ProcessResult mergeBaseHeadOrigin = run('git', <String>[
        'merge-base',
        'HEAD',
        'origin/master',
      ]);
      runUpdateEngineVersion();

      expect(testRoot.binInternalEngineVersion, exists);
      expect(
        testRoot.binInternalEngineVersion.readAsStringSync(),
        equalsIgnoringWhitespace(mergeBaseHeadOrigin.stdout as String),
      );
    });

    test('rev-parse HEAD when running on LUCI', () async {
      environment['LUCI_CONTEXT'] = '_NON_NULL_AND_NON_EMPTY_STRING';
      runUpdateEngineVersion();

      final io.ProcessResult revParseHead = run('git', <String>['rev-parse', 'HEAD']);
      expect(testRoot.binInternalEngineVersion, exists);
      expect(
        testRoot.binInternalEngineVersion.readAsStringSync(),
        equalsIgnoringWhitespace(revParseHead.stdout as String),
      );
    });
  });

  group('if DEPS or engine/src/.gn are omitted', () {
    setUp(() {
      for (final File f in <File>[testRoot.deps, testRoot.engineSrcGn]) {
        f.createSync(recursive: true);
      }
      setupRepo(branch: 'master');
      setupRemote(remote: 'origin');
    });

    test('[DEPS] engine.version is blank', () async {
      testRoot.deps.deleteSync();

      runUpdateEngineVersion();

      expect(testRoot.binInternalEngineVersion, exists);
      expect(testRoot.binInternalEngineVersion.readAsStringSync(), equalsIgnoringWhitespace(''));
    });

    test('[engine/src/.gn] engine.version is blank', () async {
      testRoot.engineSrcGn.deleteSync();

      runUpdateEngineVersion();

      expect(testRoot.binInternalEngineVersion, exists);
      expect(testRoot.binInternalEngineVersion.readAsStringSync(), equalsIgnoringWhitespace(''));
    });
  });
}

/// A FrUT, or "Flutter Root"-Under Test (parallel to a SUT, System Under Test).
///
/// For the intent of this test case, the "Flutter Root" is a directory
/// structure with the following elements:
///
/// ```txt
/// ├── bin
/// │   ├── internal
/// │   │   ├── engine.version
/// │   │   ├── engine.realm
/// │   │   └── update_engine_version.{sh|ps1}
/// │   └── engine
/// │       └── src
/// │           └── .gn
/// └── DEPS
/// ```
final class _FlutterRootUnderTest {
  /// Creates a root-under test using [path] as the root directory.
  ///
  /// It is assumed the files already exist or will be created if needed.
  factory _FlutterRootUnderTest.fromPath(
    String path, {
    FileSystem fileSystem = const LocalFileSystem(),
    Platform platform = const LocalPlatform(),
  }) {
    final Directory root = fileSystem.directory(path);
    return _FlutterRootUnderTest._(
      root,
      deps: root.childFile('DEPS'),
      engineSrcGn: root.childFile(fileSystem.path.join('engine', 'src', '.gn')),
      binInternalEngineVersion: root.childFile(
        fileSystem.path.join('bin', 'internal', 'engine.version'),
      ),
      binInternalEngineRealm: root.childFile(
        fileSystem.path.join('bin', 'internal', 'engine.realm'),
      ),
      binInternalUpdateEngineVersion: root.childFile(
        fileSystem.path.join(
          'bin',
          'internal',
          'update_engine_version.${platform.isWindows ? 'ps1' : 'sh'}',
        ),
      ),
    );
  }

  factory _FlutterRootUnderTest.findWithin([
    String? path,
    FileSystem fileSystem = const LocalFileSystem(),
  ]) {
    path ??= fileSystem.currentDirectory.path;
    Directory current = fileSystem.directory(path);
    while (!current.childFile('DEPS').existsSync()) {
      if (current.path == current.parent.path) {
        throw ArgumentError.value(path, 'path', 'Could not resolve flutter root');
      }
      current = current.parent;
    }
    return _FlutterRootUnderTest.fromPath(current.path);
  }

  const _FlutterRootUnderTest._(
    this.root, {
    required this.deps,
    required this.engineSrcGn,
    required this.binInternalEngineVersion,
    required this.binInternalEngineRealm,
    required this.binInternalUpdateEngineVersion,
  });

  final Directory root;

  /// `DEPS`.
  ///
  /// The presenence of this file is an indicator we are in a fused (mono) repo.
  final File deps;

  /// `engine/src/.gn`.
  ///
  /// The presenence of this file is an indicator we are in a fused (mono) repo.
  final File engineSrcGn;

  /// `bin/internal/engine.version`.
  ///
  /// This file contains a SHA of which engine binaries to download.
  final File binInternalEngineVersion;

  /// `bin/internal/engine.realm`.
  ///
  /// It is a mystery what this file contains, but it's set by `FLUTTER_REALM`.
  final File binInternalEngineRealm;

  /// `bin/internal/update_engine_version.{sh|ps1}`.
  ///
  /// This file contains a shell script that conditionally writes, on execution:
  /// - [binInternalEngineVersion]
  /// - [binInternalEngineRealm]
  final File binInternalUpdateEngineVersion;
}

extension on File {
  void copySyncRecursive(String newPath) {
    fileSystem.directory(fileSystem.path.dirname(newPath)).createSync(recursive: true);
    copySync(newPath);
  }
}
