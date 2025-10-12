Return-Path: <linux-kernel+bounces-849744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C572BD0C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B603BEEF3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4671231832;
	Sun, 12 Oct 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IJYg1Vl5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296722259D
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760303095; cv=none; b=l3CYQ+omma7HdqD0ZokIeEMsUDQ6MM+qh9N69egGO13HnK2BxpeKMRaAAiB3/E61EiR5qShFJ39eHGkxn7PmM/GdZmw1Uh6R0d3CY1GTKHD+T8G2M09ugyAx5FdQauOeEcUV+dJ3cO7nSL8cquXtTQTnbDlZBq5fw9TLUGQDQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760303095; c=relaxed/simple;
	bh=Wsx81Jwr40pBRc5fpPdkjW/CW8fnr+YziZRR1JW5Pc4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kQE4t5DjIjodBkehg5U0IiWuWx4RqQgMO6dwJYDLV1/S+SgJ+kwE8tghfzG/oEdE3lUey/iNQmZSmdcqCipf9F3yGB++2buaAr5ZlOLWjhpZoBgHwvzRq2+4YxaZir7cBSPI3ux9BqoiWKZg6c/poPB81pvrJEPsKtuByzAo0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IJYg1Vl5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b00a9989633so658418466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760303090; x=1760907890; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wZJZQb+xzAg+0vfNtGb3WvHkTKEVL9ZwMdnB6mWyBDI=;
        b=IJYg1Vl5zlU0Kt+B/jv4r7nhr6FKcgvRQc5VK4vH3xB1iWHKRFwMN77zk0VS3tM8ZV
         ChXAemzzYLuWjsSeI/U+3ytkw5MzGoRB1K4kX5CfDk0hsn180c8XuLsrjtxUBvJXHMb3
         rboNHGCC6BUXn/DcVb2KORjfSxHLhlnx2gAAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760303090; x=1760907890;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZJZQb+xzAg+0vfNtGb3WvHkTKEVL9ZwMdnB6mWyBDI=;
        b=dLvca2cVJKrlcSabfRWOL9Oyvw4Tf5zQ23/SVP6sGxp5rRip2A2sk/HsjYKRE/tegF
         OtAdFMt9srQABcCnv+HHm5+SL87fkHXbxXJCum98MfPqwIFMcpNzmX3SV3beBhtxCjIA
         lsP7Kb4uudTqPDsKOWlbANVATB7E8yei4+4iAFbGYuJH16zQ0m4yloEH/9PZn9LJBtBE
         i0N7KBMkaVrHSlruIqbjpIy6GbhdopSngGYZ5jh8zt1bmq4nDJeinjbtvhcNhYqFMJuX
         LL3fA0sDvnfQ2vjc1xzqYow3mz04RWJl9o7IId1KbIXuf0ctUUWvY87bj//UNbKMre/A
         yPPw==
X-Gm-Message-State: AOJu0Yx8MSbsC+g5dgscdosVDXRvx6Y1oOk0Ffy5IcOD6FLPfeXmEOSt
	AoI87woSh4x7kaY/VSjnxjSxBH5Dkkxg0gcpjR1WQ9/l9tPbaL6aDNnxvDVw1s89BG/ZPoAT9ju
	vT1n3sO4=
X-Gm-Gg: ASbGncv0oRFoxHlqcbijHNJfoVVgnjf3x8rvjOOHIqi2F3pQSNUHEwDbAONqgsLahIV
	CHmZD9Iyd2NRAcFYvRSBqjDHgo/C22daNm12Y96GH2LTT0gGl53Vx4A1h9EIwip7nc3eHhpqgSL
	r+0RZQcN9hdyJbyYner0FmeGE03uHgLWr4PGI/fcNR8IHMAnMlZDEErFVSIFl/4hvE4Y6mLWg62
	h744cQF6ToyouH4LJUFp2ly9ygRaQkxTiobiXFJ4hzpPDzxeyFK0emhg8joQ0QkL0TF65FyL/jq
	Dgex8w67EsFFOZjj0V7UwpVQk5g0t4s0+/WqJQ8zvsrjOJeVjX20T2cPJ63YLotEAwTHDWeQitj
	KNIkb6WXUeKKE4NPJng6SQCINsetyQkNmCfI6knARboelXfCzcQvSe3O0Roc3ZY5U45ETYXLXH5
	tuxFtXv4kYiOwR/rw=
X-Google-Smtp-Source: AGHT+IGTEfjngl+GPhdzeFrY1bPJXXZu/BIFx1ksv4p82VDjFUBXXzBF8TNZKgP2ANV/wyRz5RCwIg==
X-Received: by 2002:a17:907:d7ca:b0:b07:e348:8278 with SMTP id a640c23a62f3a-b4f4310677amr2180758666b.25.1760303089927;
        Sun, 12 Oct 2025 14:04:49 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d5c2bsm777407066b.37.2025.10.12.14.04.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 14:04:49 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso8121354a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:04:49 -0700 (PDT)
X-Received: by 2002:aa7:d45a:0:b0:62f:8bad:76e5 with SMTP id
 4fb4d7f45d1cf-639baf07534mr16070266a12.5.1760303088539; Sun, 12 Oct 2025
 14:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 Oct 2025 14:04:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
X-Gm-Features: AS18NWB5mfb-hQFMFYtdzU3goTWhdIDz5JCKJ0B0n4EHVDD3WJB5HrQ4Pv_YsO0
Message-ID: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
Subject: Linux 6.18-rc1
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.

Things look fairly normal: size-wise this is pretty much right in the
middle of the pack, and nothing particular stands out in the shortlog
of merges this merge window appended below. About half the diff is
drivers, with the res being all over: vfs and filesystems, arch
updates (although much of that is actually devicetree stuff, so it's
arguably more driver-related), tooling, rust support etc etc.

This was one of the good merge windows where I didn't end up having to
bisect any particular problem on nay of the machines I was testing.
Let's hope that success mostly translates to the bigger picture too.

                 Linus

---

Al Viro (7):
    vfs mount updates
    fs_context updates
    nfsctl updates
    finish_no_open updates
    d_name audit update
    misc non-vfs updates
    file->f_path constification

Alex Williamson (2):
    VFIO updates
    more VFIO updates

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

Amir Goldstein (1):
    overlayfs updates

Andreas Gruenbacher (1):
    gfs2 updates

Andreas Hindborg (1):
    configfs update

Andreas Larsson (1):
    sparc updates

Andrew Morton (5):
    MM updates
    non-MM updates
    more MM updates
    misc fixes
    more updates

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (1):
    EFI updates

Arnaldo Carvalho de Melo (1):
    perf tools updates

Arnd Bergmann (7):
    new SoC support
    SoC dt updates
    SoC defconfig updates
    SoC driver updates
    ARM SoC updates
    asm-generic updates
    SoC build fix

Bartosz Golaszewski (2):
    gpio updates
    gpio fixes

Benjamin Tissoires (1):
    HID updates

Bjorn Andersson (2):
    remoteproc updates
    rpmsg updates

Bjorn Helgaas (2):
    pci updates
    pci fix

Borislav Petkov (13):
    EDAC updates
    x86 instruction decoder update
    x86 build updates
    x86 asm update
    x86 microcode loading updates
    x86 RAS updates
    x86 mitigation updates
    x86 cpuid updates
    x86 resource control updates
    x86 SEV and apic updates
    x86 cleanups
    more x86 updates
    irq fixes

Carlos Maiolino (1):
    xfs updates

Christian Brauner (12):
    misc vfs updates
    vfs mount updates
    vfs inode updates
    vfs iomap updates
    pidfs updates
    vfs rust updates
    vfs workqueue updates
    copy_process updates
    afs updates
    namespace updates
    vfs writeback updates
    vfs async directory updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (2):
    ata updates
    zonefs update

Daniel Thompson (1):
    kgdb updates

Danilo Krummrich (1):
    driver core updates

Dave Airlie (3):
    drm updates
    drm fixes
    more drm fixes

Dave Hansen (3):
    x86 TDX updates
    x86 mm update
    x86 entry updates

Dave Jiang (1):
    CXL updates

Dave Kleikamp (1):
    jfs updates

David Sterba (2):
    btrfs updates
    btrfs fixes

David Teigland (1):
    dlm updates

Dinh Nguyen (1):
    NIOS2 updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eric Biggers (4):
    fscrypt updates
    CRC updates
    crypto library updates
    interleaved SHA-256 hashing support

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (7):
    tty/serial updates
    USB / Thunderbolt updates
    staging driver updates
    Char/Misc/IIO/Binder updates
    tty driver fix
    staging driver fixes
    char/misc fixes

Guenter Roeck (1):
    hwmon updates

Helge Deller (2):
    fbdev updates
    parisc updates

Herbert Xu (3):
    crypto updates
    crypto fixes
    crypto fixes

Huacai Chen (1):
    LoongArch updates

Ilpo J=C3=A4rvinen (1):
    x86 platform driver updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (3):
    scheduler updates
    performance events updates
    locking updates

Ira Weiny (1):
    libnvdimm updates

Jaegeuk Kim (1):
    f2fs updates

James Bottomley (2):
    SCSI updates
    SCSI fixes

Jan Kara (2):
    fsnotify updates
    udf and quota updates

Jarkko Sakkinen (2):
    keys updates
    tpm updates

Jason Gunthorpe (3):
    fwctl updates
    iommufd updates
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (4):
    io_uring updates
    block updates
    io_uring fixes
    block fixes

Joerg Roedel (1):
    iommu updates

Johannes Berg (1):
    uml updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (6):
    ffs const-attribute cleanups
    execve updates
    seccomp update
    hardening updates
    tiny pstore update
    hardening fixes

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (3):
    MFD updates
    LED updates
    backlight updates

Linus Walleij (1):
    pin control updates

Madhavan Srinivasan (1):
    powerpc updates

Marco Elver (1):
    Kernel Concurrency Sanitizer (KCSAN) update

Marek Szyprowski (2):
    dma-mapping updates
    dma-mapping fixes

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masami Hiramatsu (1):
    probe fix

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    Xtensa updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Miguel Ojeda (1):
    rust updates

Mike Marshall (1):
    orangefs updates

Mike Rapoport (1):
    mm-init update

Miklos Szeredi (1):
    fuse updates

Mikulas Patocka (2):
    device mapper updates
    hpfs updates

Mimi Zohar (1):
    integrity updates

Miquel Raynal (1):
    MTD updates

Namjae Jeon (1):
    exfat updates

Nathan Chancellor (2):
    Kbuild updates
    Kbuild fixes

Paolo Abeni (2):
    networking updates
     networking fixes

Paolo Bonzini (2):
    kvm updates
    x86 kvm updates

Paul McKenney (1):
    RCU updates

Paul Moore (3):
    audit updates
    selinux updates
    lsm updates

Paul Walmsley (1):
    more RISC-V updates

Paul Walmsley
 (1):
    RISC-V updates

Petr Mladek (1):
    printk updates

Rafael Wysocki (6):
    power management updates
    ACPI updates
    thermal control updates
    more power management updates
    more ACPI updates
    more thermal control updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (1):
    ARM development updates

Sebastian Reichel (2):
    HSI update
    power supply and reset updates

Shuah Khan (2):
    kunit updates
    kselftest updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (4):
    smb restructuring updates
    smb server fixes
    smb client updates
    more smb client updates

Steven Rostedt (3):
    tracing updates
    tracing clean up and fixes
    tracing fixes

Steven Rostedt
 (1):
    tracing tools updates

Takashi Iwai (2):
    sound updates
    sound fixes

Takashi Sakamoto (1):
    firewire updates

Ted Ts'o (1):
    ext4 updates

Tejun Heo (3):
    sched_ext updates
    workqueue updates
    cgroup updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (9):
    TIF bit unification updates
    rseq updates
    irq core updates
    irq chip driver updates
    smp doc fixlet
    futex updates
    timer core updates
    clocksource updates
    VDSO updates

Thomas Wei=C3=9Fschuh (1):
    nolibc updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (2):
    pmdomain updates
    MMC updates

Uwe Kleine-K=C3=B6nig (1):
    pwm updates

Viacheslav Dubeyko (1):
    hfs updates

Vinod Koul (3):
    soundwire updates
    phy updates
    dmaengine updates

Vlastimil Babka (3):
    slab updates
    slab fixes
    slab fix

Wei Liu (1):
    hyperv updates

Will Deacon (2):
    arm64 updates
    arm64 fixes

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (3):
    i2c updates
    more i2c updates
    i2c fix

Yury Norov (1):
    bitmap updates

