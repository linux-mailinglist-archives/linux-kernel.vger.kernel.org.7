Return-Path: <linux-kernel+bounces-761515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E61B1FB44
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DD3B3185
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F6A253939;
	Sun, 10 Aug 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FKvLxyrB"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803B33DF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754845750; cv=none; b=LnDfoR0CXppSufT1LdmWuW2xc6My+0ghPUG8YSDCgSh/BYnm5Oz/7wswJux5+GYDIDa+9F/aGXsH7im+PoU4i6XySsSjcPhP/bar0/dawgNPEqx858Dz1Bi+MUwMd7s262PRVgoqh3pdftJ3tA1llumcKG6R35kXsjoTtQh6Y3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754845750; c=relaxed/simple;
	bh=UEKm3wpqsdvvoDFu9yL230QU0pUZYiqHasZGU5o4q4g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dzxI6QaWi9K/n/7k0eSCq/0oMnlv5URMgbGwwvYfcHWC4W11ezV/D9oY+GzNpd6YrwtIWLTM+Bm3D+21aKBH2lpmsObL+Q9F836GatvUrNipy5mDQyvU3JBoqqdZTX+gK/R4wQtdJbZN8c9mjt6M/Sqvny9bez0K23Zb0Q3cupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FKvLxyrB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-af925cbd73aso705866566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754845745; x=1755450545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=265MiA65cidSNyLUVRZnT9h1MdYxn9SqH5Ul2Hxhq/w=;
        b=FKvLxyrBO5jZvjnXRen6Qk3Asdt/TDPDNxgLJqXLe5wH8nO+4EiK5JrClWP2uNMogI
         gJVqADkJ9/1g6Sz4KwTYZwigeP81/HlC9ZkJ0pGffeMX65gdJoByzvnBxaJ5sytbxRf8
         K8fPAE5q0xU55+bbNJIUU1/2vxtRlPzeEbsxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754845745; x=1755450545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=265MiA65cidSNyLUVRZnT9h1MdYxn9SqH5Ul2Hxhq/w=;
        b=W9m3WJJveLeOINIwyRDej76lZqjPdaYTOCmGbmYt4gu+kF1fJjcA4XsfF3QZzhIrEk
         DHNhsUHVWXuGbWVJBnD0sBg6SYwS+7XhRN/Vb6xnHgLhc8q2vQgGI5cHPlSh5bwh1nu3
         Rt5AQSmDBj4zaBEagDoWc1H+haS0/Ll5ZX8MHb3KzP3fFDrWrT2aBq0ClezAwNfm9+c0
         yBmnrdEqsJxE85vgBEWngEtBF2cVu6jX+Cin9oZczUtZzd4RO1w7VhLhJt2jbK+XuBOi
         Nlv+Fv99GEPcPl+DoxsFV2nH4XiTzEIARqI4t1VQ41lHjovNMAVTnGBk5hDQZM38b1Mq
         wz5Q==
X-Gm-Message-State: AOJu0Yz6FV/Pb8D3fDl7iDz6T64WWXLFuUj8lv69ev6+Fs5yq5QI5r+2
	U3Aer0SUd/QVVZXRODF0aGjFEgrxbJJbof9x79kZa0w2TSVwadbdROeF7jEOsuGG9lcvsm8GJ9p
	oqWJ4sKiYsA==
X-Gm-Gg: ASbGncs1WraiG3cEyegptGn4F0RvgU4CmbmMCXbvIZk9bqkTvR2U8thrgdDPFtyK6+3
	FhZAmi5a+faEhgWkBYr+79fRkGyuPjynCh+G5SBq8m4BKBgO+jYXCxu2pse2qLTUqQQTfDlRsvD
	90cewobVtcqJsqPQ2iAq94isq6Uw7hn1Db3UwbCHch1Bai4DZvWgj7u9dQUnA90TA3rcksnhwxI
	uXw4TunxD6Ai63UhgkQpgRcD5fVOTthSlJk30xImvbU2RVwsmGAd/jBPAoQuZXpn7h4avYWkufC
	tognaTOsyu3HwDNYRnuhuZAboKgs+jAUmISeuwey2Lg23iKrNUvP7g8IuK7WJ58hOh9FMqy2kws
	GWdNypeSWV9TAU67I9CLiCZ17S1nP0SKEyZ81c6qQaiSWngFoDoS0XiGzQDmplRBQrSKof6xh
X-Google-Smtp-Source: AGHT+IFuX4u+oT1/7zGYA9niBmWboQvynNqCdF91mWCLmD71jn+xKkVBJo3YBn9dt3yDP6ngGoUhng==
X-Received: by 2002:a17:907:3e8e:b0:ace:d710:a8d1 with SMTP id a640c23a62f3a-af9c645bf8emr864910366b.24.1754845745448;
        Sun, 10 Aug 2025 10:09:05 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0a4sm1880967166b.109.2025.08.10.10.09.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 10:09:04 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-617b36cc489so7114191a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 10:09:04 -0700 (PDT)
X-Received: by 2002:a05:6402:270e:b0:618:87:bb1d with SMTP id
 4fb4d7f45d1cf-6180087bfb4mr6245347a12.25.1754845743981; Sun, 10 Aug 2025
 10:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Aug 2025 20:08:47 +0300
X-Gmail-Original-Message-ID: <CAHk-=wgb=B_pGPSTw9y4Fw82y5V_mvzJp_0XcWanz7YRR5vkXA@mail.gmail.com>
X-Gm-Features: Ac12FXx_1UcsTJnML6dGBr651chTmV4r8WEAvf05xuxAjaZnfcAqoqcj-Hg7Ay4
Message-ID: <CAHk-=wgb=B_pGPSTw9y4Fw82y5V_mvzJp_0XcWanz7YRR5vkXA@mail.gmail.com>
Subject: Linux 6.17-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So two weeks have passed, and depending on how you see it, rc1 is
either earlier than usual (it's only Sunday morning back home in the
usual timezone) or later than usual (because it's getting to be Sunday
evening here in Finland where I'm cutting the release). I decided to
basically split the difference on my usual "early Sunday afternoon"
schedule.

Anyway, due to travels, I wanted to do most of the heavy lifting the
first week, and I can happily report that that part worked out well. I
wouldn't want to do this most merge windows, but the bulk of the work
was done before travel, and that meant that the straggler pulls were
manageable while traveling. Thanks to everybody who got their pulls in
early - you know who you are.

And the late stragglers then got a slightly more annoyed Linus as a
result. Sorry about that.

Anyway, the merge window did end up looking fairly healthy, despite me
having to go through a couple of bisections for trouble spots (one
during travels with a laptop - not optimal, but thankfully it was at
least one of the "reliable symptoms that bisect right to the culprit"
kind). The stats look pretty normal both in patch size and in number
of commits. That number being large enough that - as always - you only
get the mergelog below as a kind of "view from 10,000ft" of the
development process this time around.

Please do get started testing and fixing,

              Linus


---

Al Viro (9):
    asm/param cleanup
    dentry d_flags updates
    simple_recursive_removal() update
    rpc_pipefs updates
    securityfs updates
    misc VFS updates
    ceph dentry->d_name fixes
    CLASS(fd) update
    vfs mount updates

Alex Williamson (1):
    VFIO updates

Alexander Gordeev (2):
    s390 updates
    more s390 updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Alexei Starovoitov (3):
    bpf updates
    bpf fixes
    bpf fixes

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    MM updates
    non-MM updates
    more MM updates

Ard Biesheuvel (1):
    EFI updates

Arnd Bergmann (6):
    SoC devicetree updates
    SoC driver updates
    new SoC support
    SoC defconfig updates
    ARM SoC code updates
    SoC fixes

Bartosz Golaszewski (3):
    gpio updates
    power sequencing updates
    gpio updates

Bjorn Andersson (1):
    remoteproc updates

Bjorn Helgaas (2):
    PCI updates
    pci fix

Borislav Petkov (9):
    EDAC updates
    x86 CPU mitigation updates
    x86 cpu updates
    x86 microcode loader update
    x86 SEV updates
    locking fix
    x86 fixes
    irq fixes
    smp fixes

Carlos Maiolino (1):
    xfs updates

Catalin Marinas (1):
    arm64 updates

Christian Brauner (14):
    misc VFS updates
    coredump updates
    overlayfs updates
    namespace updates
    async directory updates
    fallocate updates
    mmap_prepare updates
    pidfs updates
    vfs bpf updates
    vfs rust updates
    vfs 'protection info' updates
    fileattr updates
    superblock callback update
    vfs iomap updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    ipmi updates

Damien Le Moal (3):
    zonefs update
    ata updates
    ata fixes

Daniel Gomez (1):
    module updates

Danilo Krummrich (1):
    driver core updates

Dave Airlie (3):
    drm updates
    drm fixes
    drm fixes

Dave Jiang (1):
    CXL updates

Dave Kleikamp (1):
    jfs updates

David Sterba (2):
    btrfs updates
    btrfs fix

Dmitry Torokhov (1):
    input updates

Eric Biggers (5):
    CRC updates
    crypto library updates
    crypto library test updates
    crypto library conversions
    fscrypt updates

Fan Wu (1):
    ipe update

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    char / misc / IIO / other driver updates
    staging updates
    tty / serial driver updates
    USB / Thunderbolt updates
    LICENSES update
    TTY fix

Guenter Roeck (1):
    hwmon updates

Helge Deller (2):
    parisc updates
    fbdev updates

Herbert Xu (2):
    crypto update
    crypto fix

Huacai Chen (1):
    LoongArch updates

Ilpo J=C3=A4rvinen (1):
    x86 platform drivers

Ingo Molnar (9):
    scheduler updates
    x86 performance events updates
    locking updates
    x86 boot updates
    x86 cleanups
    x86 cpu update
    x86 FPU updates
    x86 kconfig updates
    x86 platform updates

Ira Weiny (1):
    libnvdimm updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    udf and ext2 updates
    fsnotify updates

Jarkko Sakkinen (1):
    tpm updates

Jason Gunthorpe (3):
    rdma updates
    iommufd updates
    rdma fix

Jassi Brar (1):
    mailbox updates

Jens Axboe (4):
    io_uring updates
    block updates
    io_uring fixes
    more block updates

Jiri Kosina (1):
    HID updates

Joel Granados (1):
    sysctl updates

Johan Hovold (1):
    GNSS update

Johannes Berg (1):
    uml updates

John Johansen (1):
    apparmor updates

John Paul Adrian Glaubitz (1):
    sh update

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (3):
    execve updates
    hardening updates
    hardening fixes

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (2):
    MFD updates
    LED updates

Len Brown (1):
    turbostat updates

Linus Walleij (1):
    pin control updates

Madhavan Srinivasan (2):
    powerpc updates
    powerpc fixes

Marco Elver (1):
    Kernel Concurrency Sanitizer (KCSAN) update

Mark Brown (6):
    regmap updates
    regulator updates
    spi updates
    regmap fixes
    regulator fix
    spi fixes

Masahiro Yamada (1):
    Kbuild updates

Masami Hiramatsu (3):
    bootconfig updates
    probes fix
    probes updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa update

Michael Tsirkin (2):
    virtio updates
    vhost fix

Micka=C3=ABl Sala=C3=BCn (1):
    landlock update

Miguel Ojeda (1):
    Rust updates

Mike Marshall (1):
    orangefs updates

Mikulas Patocka (1):
    device mapper updates

Mimi Zohar (1):
    integrity update

Miquel Raynal (1):
    mtd updates

Namhyung Kim (1):
    perf tools updates

Namjae Jeon (1):
    exfat updates

Neeraj Upadhyay (1):
    RCU updates

Paolo Bonzini (1):
    kvm updates

Paul McKenney (3):
    lkmm documentation update
    ratelimit test updates
    stop-machine documentation updates

Paul Moore (3):
    lsm updates
    selinux updates
    audit update

Petr Mladek (1):
    printk updates

Rafael Wysocki (3):
    power management updates
    ACPI updates
    thermal control updates

Richard Weinberger (1):
    UBI and UBIFS updates

Rob Herring (1):
    devicetree updates

Russell King (1):
    ARM update

Sebastian Reichel (1):
    power supply and reset updates

Serge Hallyn (1):
    capabilities update

Shuah Khan (2):
    kunit updates
    kselftest updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (4):
    smb server updates
    smb client updates
    smb server fixes
    more smb client updates

Steven Rostedt (9):
    ktest updates
    ftrace updates
    ring-buffer updates
    runtime verification updates
    tracepoint cleanup
    initial deferred unwind infrastructure
    tracing tools updates
    tracing updates
    more tracing updates

Takashi Iwai (3):
    sound updates
    more sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    workqueue updates
    cgroup updates
    sched_ext updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (11):
    MSI update
    irq updates
    smp updates
    interrupt chip driver updates
    timer cleanups
    timer core updates
    timekeeping and VDSO updates
    futex updates
    VDSO selftest updates
    generic entry code updates
    perf fixes

Thomas Wei=C3=9Fschuh (1):
    nolibc updates

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (2):
    pmdomain updates
    MMC updates

Uwe Kleine-K=C3=B6nig (2):
    pwm updates
    pwm fixes

Viacheslav Dubeyko (1):
    hfs/hfsplus updates

Vinod Koul (3):
    soundwire updates
    phy updates
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Will Deacon (1):
    iommu updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (2):
    i2c updates
    more i2c updates

Yury Norov (1):
    bitmap updates

