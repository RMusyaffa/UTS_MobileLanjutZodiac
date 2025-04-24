// lib/models/zodiac.dart
enum Zodiac {
  capricorn,
  aquarius,
  pisces,
  aries,
  taurus,
  gemini,
  cancer,
  leo,
  virgo,
  libra,
  scorpio,
  sagittarius,
}

extension ZodiacExtension on Zodiac {
  String get name {
    switch (this) {
      case Zodiac.capricorn: return 'Capricorn';
      case Zodiac.aquarius: return 'Aquarius';
      case Zodiac.pisces: return 'Pisces';
      case Zodiac.aries: return 'Aries';
      case Zodiac.taurus: return 'Taurus';
      case Zodiac.gemini: return 'Gemini';
      case Zodiac.cancer: return 'Cancer';
      case Zodiac.leo: return 'Leo';
      case Zodiac.virgo: return 'Virgo';
      case Zodiac.libra: return 'Libra';
      case Zodiac.scorpio: return 'Scorpio';
      case Zodiac.sagittarius: return 'Sagittarius';
    }
  }

  String get dateRange {
    switch (this) {
      case Zodiac.capricorn: return '21 Desember – 19 Januari';
      case Zodiac.aquarius: return '20 Januari – 18 Februari';
      case Zodiac.pisces: return '19 Februari – 20 Maret';
      case Zodiac.aries: return '21 Maret – 20 April';
      case Zodiac.taurus: return '21 April – 20 Mei';
      case Zodiac.gemini: return '21 Mei – 20 Juni';
      case Zodiac.cancer: return '21 Juni – 20 Juli';
      case Zodiac.leo: return '21 Juli – 21 Agustus';
      case Zodiac.virgo: return '22 Agustus – 22 September';
      case Zodiac.libra: return '23 September – 22 Oktober';
      case Zodiac.scorpio: return '23 Oktober – 22 November';
      case Zodiac.sagittarius: return '23 November – 20 Desember';
    }
  }

  String get description {
    switch (this) {
      case Zodiac.capricorn:
        return 'Orang yang lahir pada tanggal antara 21 Desember sampai 19 Januari berada di bawah pengaruh zodiak Capricorn, yang berlambang kambing. Orang yang berzodiak Capricorn mengutamakan kesuksesan, status, posisi, reputasi, loyalitas, konsentrasi, pemecahan masalah, bertanggung jawab, memperlihatkan kebijaksanaan, dan keseriusan belajar melalui pengalaman.';
      case Zodiac.aquarius:
        return 'Orang yang lahir pada tanggal antara 20 Januari sampai 18 Febuari berada di bawah pengaruh zodiak Aquarius, yang berlambang gelombang (alur air). Orang Aquarius tertarik dengan petualangan, berjiwa kemanusiaan, ingin tahu, ada semangat berontak, bersikap spontan, progesif, persahabatan, hak asasi, kelompok, dan mampu memberi manfaat untuk sekitar.';
      case Zodiac.pisces:
        return 'Orang yang lahir antara tanggal 19 Febuari sampai 20 Maret dikatakan bernaung di bawah zodiak Pisces, yang berlambang ikan. Pisces mengutamakan cinta universal, bersifat manja, selalu mencari ilham, memperlihatkan kepercayaan, ada kesepahaman, berjiwa puitis, menyukai musik, beragama, bersifat setia, mampu menghibur diri, mengutamakan kerohanian, dan tidak mudah mengaku kalah.';
      case Zodiac.aries:
        return 'Orang yang lahir pada tanggal antara 21 Maret sampai 20 April dikatakan bernaung di bawah zodiak Aries, yang berlambang Biri-biri jantan. Dengan demikian, Aries seorang yang berani, yakin, inisiatif, mengutamakan tindakan, ada pertahanan diri, ada rasa merintis, ada daya juang, dan pencinta / memperjuangkan nasib.';
      case Zodiac.taurus:
        return 'Orang yang lahir pada tanggal antara 21 April sampai 20 Mei dikatakan bernaung di bawah zodiak Taurus, yang berlambang Lembu Jantan. Dengan demikian, Taurus mengutamakan kekayaan, ketinggian spiritual, kaut daya rasa, loyalitas, gemar berpelesiran, kesuburan, terlalu praktis, murah rezeki dan ketabahan.';
      case Zodiac.gemini:
        return 'Orang yang lahir pada tanggal antara 21 Mei sampai 20 Juni dikatakan bernaung di bawah zodiak Gemini, yang berlambang Saudara Kembar. Dengan demikian, Gemini terampil berkomunikasi, suka bepergian, serbaguna, cerdas, ada kekuatan berbicara, mampu menulis, kedekatan pada sanak saudara dan tetangga, gemar migrasi, dan bersikap terbuka.';
      case Zodiac.cancer:
        return 'Orang yang lahir pada tanggal antara 21 Juni sampai 20 Juli dikatakan bernaung di bawah zodiak Cancer, yang berlambang Kepiting. Dengan demikian, Cancer menyukai rumah tangga, keluarga, kesehatan, makanan, ada rasa simpati, memberi perlindungan, agak sensitif, punya kesabaran, kejujuran, dan kecerdasan. Namun, ada kalanya Cancer bersikap kekanak-kanakan, berbolak-balik, berpura-pura, tidak aman, terlalu bertahan dan takut pada perpisahan.';
      case Zodiac.leo:
        return 'Orang yang lahir pada tanggal antara 21 Juli sampai 21 Agustus dikatakan bernaung di bawah zodiak Leo, yang berlambang Singa. Anda mengutamakan rasa cinta, ramah, bersifat pemurah, ada daya kepemimpinan, menonjolkan kemegahan, selalu hidup, menyoroti keagungan, keberanian, kemampuan, dekat dengan anak-anak, berbakat dan suka pada hiburan.';
      case Zodiac.virgo:
        return 'Orang yang lahir pada tanggal antara 22 Agustus hingga 22 September dikatakan bernaung di bawah zodiak Virgo, yang berlambang Seorang Gadis. Dengan demikian, Virgo suka pada kerja, hasil kerja sempurna, punya pahlawan diri, suci, mengutamakan kesehatan, ada kesadaran, memberikan konsentrasi berdisiplin, praktis, siap melayani dan komprehensif.';
      case Zodiac.libra:
        return 'Orang yang lahir pada tanggal antara 23 September sampai 22 Oktober dikatakan bernaung di bawah zodiak Libra, yang berlambang Alat Penimbang (Dacin). Dengan demikian, orang yang berzodiak Libra biasanya berciri-ciri harmonis, seimbang, menyukai pernikahan, mendapati perhubungan, mengutamakan kesetaraan, aliansi, diplomasi, berseni, suka membantu, selalu dalam keadaan ceria, dapat menjadi pasangan yang ideal dan menyukai keadilan.';
      case Zodiac.scorpio:
        return 'Orang yang lahir pada tanggal antara 23 Oktober sampai 22 November dikatakan bernaung di bawah zodiak Scorpio, yang berlambang kalajengking. Scorpio memiliki kemewahan, kreatif, ada keinginan yang kuat, punya stamina, daya sensual yang tinggi dan ada bakat menyembuhkan.';
      case Zodiac.sagittarius:
        return 'Orang yang lahir pada tanggal antara 23 November sampai 20 Desember dikatakan bernaung di bawah zodiak Sagitarius, yang berlambang Pemanah. Sagitarius suka minat belajar, bersikap optimis, pemanjat, pemahaman diri, bercita-cita tinggi, memiliki hati nurani, berpegang pada agama, psikologi, suka pada kesenangan, bijaksana, selalu ada keberuntungan, gemar eksplorasi dan ada berbagai impian.';
    }
  }

  String get monthPersonality {
    switch (this) {
      case Zodiac.capricorn:
      case Zodiac.aquarius:
        if (this == Zodiac.capricorn) {
          return 'Desember, Si Kuat yang Inspiratif: Mereka yang lahir bulan Desember senang menjadi pusat perhatian dan cenderung aktif. Hal ini mengindikasikan bahwa kamu tidak suka hanya berdiam diri di rumah dan tidak melakukan apapun.';
        } else {
          return 'Januari, Si Ambisius: Mereka yang lahir bulan Januari biasanya memiliki sifat keras kepala dalam hal tindakan maupun keinginan. Individu yang lahir pada bulan Januari juga dinilai memiliki sifat ambisius dalam kehidupan karir.';
        }
      case Zodiac.aquarius:
      case Zodiac.pisces:
        if (this == Zodiac.aquarius) {
          return 'Januari, Si Ambisius: Mereka yang lahir bulan Januari biasanya memiliki sifat keras kepala dalam hal tindakan maupun keinginan. Individu yang lahir pada bulan Januari juga dinilai memiliki sifat ambisius dalam kehidupan karir.';
        } else {
          return 'Februari, Si Pemikir yang Filosofis: Jika kamu lahir bulan Februari, kamu cenderung memiliki bakat artistik dan juga kreatifitas alami. Mereka yang lahir pada bulan Februari juga cenderung memiliki otak yang cerdas.';
        }
      case Zodiac.pisces:
      case Zodiac.aries:
        if (this == Zodiac.pisces) {
          return 'Februari, Si Pemikir yang Filosofis: Jika kamu lahir bulan Februari, kamu cenderung memiliki bakat artistik dan juga kreatifitas alami. Mereka yang lahir pada bulan Februari juga cenderung memiliki otak yang cerdas.';
        } else {
          return 'Maret, Si Penengah Konflik: Individu yang lahir pada bulan Maret cenderung pemalu dalam hal keterbukaan diri. Ini membuat mereka tidak mudah untuk menunjukkan jati diri atau personality mereka kepada sembarang orang.';
        }
      case Zodiac.aries:
      case Zodiac.taurus:
        if (this == Zodiac.aries) {
          return 'Maret, Si Penengah Konflik: Individu yang lahir pada bulan Maret cenderung pemalu dalam hal keterbukaan diri. Ini membuat mereka tidak mudah untuk menunjukkan jati diri atau personality mereka kepada sembarang orang.';
        } else {
          return 'April, Si Penyuka Tantangan: Kesan kuat dan atletis biasanya melekat pada mereka yang lahir pada bulan April. Individu kelahiran bulan April cenderung akan cepat merasa senang jika mendapat perhatian dari banyak pihak.';
        }
      case Zodiac.taurus:
      case Zodiac.gemini:
        if (this == Zodiac.taurus) {
          return 'April, Si Penyuka Tantangan: Kesan kuat dan atletis biasanya melekat pada mereka yang lahir pada bulan April. Individu kelahiran bulan April cenderung akan cepat merasa senang jika mendapat perhatian dari banyak pihak.';
        } else {
          return 'Mei, Si Cerdas yang Atraktif: Banyak individu yang lahir pada bulan Mei dikenal sangat atraktif, baik secara fisik maupun personality. Mereka cenderung lebih menggunakan otak kiri, yang berarti bahwa sifat orang-orang kelahiran bulan Mei ini lebih logis dibanding kreatif.';
        }
      case Zodiac.gemini:
      case Zodiac.cancer:
        if (this == Zodiac.gemini) {
          return 'Mei, Si Cerdas yang Atraktif: Banyak individu yang lahir pada bulan Mei dikenal sangat atraktif, baik secara fisik maupun personality. Mereka cenderung lebih menggunakan otak kiri, yang berarti bahwa sifat orang-orang kelahiran bulan Mei ini lebih logis dibanding kreatif.';
        } else {
          return 'Juni, Si Kalem: Sensitif dan peka, dua kesan inilah yang paling sering menempel pada mereka yang lahir pada bulan Juni. Hal yang unik adalah mereka tidak akan memberitahu kita apakah mereka tengah merasa sedih ataupun tersakiti.';
        }
      case Zodiac.cancer:
      case Zodiac.leo:
        if (this == Zodiac.cancer) {
          return 'Juni, Si Kalem: Sensitif dan peka, dua kesan inilah yang paling sering menempel pada mereka yang lahir pada bulan Juni. Hal yang unik adalah mereka tidak akan memberitahu kita apakah mereka tengah merasa sedih ataupun tersakiti.';
        } else {
          return 'Juli, Si Extrovert: Orang-orang yang lahir pada bulan Juli kebanyakan memiliki sifat asli yang enerjik, artinya mereka asyik untuk diajak hangout. Mereka juga punya satu pesona tersendiri yang membuat orang lain merasa ingin lebih dekat dengan mereka.';
        }
      case Zodiac.leo:
      case Zodiac.virgo:
        if (this == Zodiac.leo) {
          return 'Juli, Si Extrovert: Orang-orang yang lahir pada bulan Juli kebanyakan memiliki sifat asli yang enerjik, artinya mereka asyik untuk diajak hangout. Mereka juga punya satu pesona tersendiri yang membuat orang lain merasa ingin lebih dekat dengan mereka.';
        } else {
          return 'Agustus, Si Pemimpin Alami: Karakteristik individu yang lahir bulan Agustus memiliki kesamaan dengan mereka yang lahir pada bulan Juli dari segi selera humor. Mereka juga senang tertawa dan membuat lelucon.';
        }
      case Zodiac.virgo:
      case Zodiac.libra:
        if (this == Zodiac.virgo) {
          return 'Agustus, Si Pemimpin Alami: Karakteristik individu yang lahir bulan Agustus memiliki kesamaan dengan mereka yang lahir pada bulan Juli dari segi selera humor. Mereka juga senang tertawa dan membuat lelucon.';
        } else {
          return 'September, Si Penyuka Detail: Detail oriented mungkin merupakan kata yang tepat untuk menggambarkan karakteristik orang-orang yang lahir pada bulan September. Hal ini dikarenakan mereka cenderung perfeksionis dalam memandang sesuatu.';
        }
      case Zodiac.libra:
      case Zodiac.scorpio:
        if (this == Zodiac.libra) {
          return 'September, Si Penyuka Detail: Detail oriented mungkin merupakan kata yang tepat untuk menggambarkan karakteristik orang-orang yang lahir pada bulan September. Hal ini dikarenakan mereka cenderung perfeksionis dalam memandang sesuatu.';
        } else {
          return 'Oktober, Si Penebar Aura Positif: Individu yang lahir pada bulan Oktober cenderung bersifat carefree, artinya mereka tidak suka kehidupan mereka diatur ataupun dikekang. Mereka juga punya sifat alami yakni independen dan selalu fokus untuk melihat sisi positif dari suatu hal.';
        }
      case Zodiac.scorpio:
      case Zodiac.sagittarius:
        if (this == Zodiac.scorpio) {
          return 'Oktober, Si Penebar Aura Positif: Individu yang lahir pada bulan Oktober cenderung bersifat carefree, artinya mereka tidak suka kehidupan mereka diatur ataupun dikekang. Mereka juga punya sifat alami yakni independen dan selalu fokus untuk melihat sisi positif dari suatu hal.';
        } else {
          return 'November, Si Pengamat yang Misterius: Mereka yang lahir pada bulan November punya kecenderungan sifat keras kepala dan sangat secretive. Maksud dari secretive ini artinya mereka selalu menyimpan rahasia mereka rapat-rapat dan tak menceritakannya pada orang lain.';
        }
      case Zodiac.sagittarius:
      case Zodiac.capricorn:
        if (this == Zodiac.sagittarius) {
          return 'November, Si Pengamat yang Misterius: Mereka yang lahir pada bulan November punya kecenderungan sifat keras kepala dan sangat secretive. Maksud dari secretive ini artinya mereka selalu menyimpan rahasia mereka rapat-rapat dan tak menceritakannya pada orang lain.';
        } else {
          return 'Desember, Si Kuat yang Inspiratif: Mereka yang lahir bulan Desember senang menjadi pusat perhatian dan cenderung aktif. Hal ini mengindikasikan bahwa kamu tidak suka hanya berdiam diri di rumah dan tidak melakukan apapun.';
        }
    }
  }
}