Return-Path: <linux-kernel+bounces-843080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B16BBE5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D318993BE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4B2D5410;
	Mon,  6 Oct 2025 14:39:10 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A12836A3
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759761549; cv=none; b=Ida4aiQSxf+dkfTRZyNCEJcFipbOzs1q18QG3essgZoCzlzjjbX5JYMiJvwTfxtYuYb0WCsm7zJ4Edrf84IYNpmkbzv53F4f4cYN5xLemnhFvNslDSzjQ7RL0NEnSC/aXezxaHeYmp1HEd5cYFL3rpgmM1zJnJ00Rp3Z4jncHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759761549; c=relaxed/simple;
	bh=X9knVRoF/Hyf1dOnx1Icu5u95zuQOg6GtbbDzKE73Fk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NPHQUa9J7GcRSCeztd32QnlL6+93dusFSB8TSjxbNvkkSB+Alt4VUFJlMBd6k0TsAsUCZ3gqq6tEC1yfKFNaNX5P2kifUCUkxlJnZX4bW/og3LXLfwhsFvAXieuGjI/8qyo3AjyFTQauT5WzqQp7yuwiyf6d+/VsUPMCJlA8RWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90c806bc886so543472539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759761543; x=1760366343;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilq9RSS2U3e93OC8/VmmqNQm/+YVkOKf6SXBU6dySg0=;
        b=L635RSDwbld6pXdwQ2hNSnJsxt/7NToGljmn/y0LAUrUk3+IgwjaerNl9fjY2PH96F
         VdQ9+K0EM+RMxrMulIyQVncYcSI3Aal+qe2nJ4UPfyAKSYvWXdHa6Njmqw0N4zZFy0wT
         vpsTfQcO/TDvJQa/2bOSPNIOJDwmKVYcDHQ6+13sTMzsJzdYtfg0HZiQam3/OGeJ+Jro
         gQlKqS/FBTsDgUekWTYCfq8XSGGCZvdE1YGuZeucC9XmRLbuS+F0AKfEsvMAJffBWvY+
         7jZ7z0sLdmYuLzZhtABfFCI1971w6YgsqLo0ZKFXeNGCH9N5eIOCR1cn4mKWvglou3qX
         14Yg==
X-Gm-Message-State: AOJu0Yy4DYAhyfPYvTGu6FEm0nMvjKZEcla+/b9bKaiakeEOTtFtMFny
	ib+/iOU1Tv6Rdv7gMyzH2OlVvUdUUWoE5mCQymGgdY9CIheI+fHAl2dDXZ1nNB5ElsNPHZO5U61
	y4VF1DyrkqsMzyIY8KcJnJ01qOATnXyuGS618qAR2tumwdZEgHn9TGuQns5w=
X-Google-Smtp-Source: AGHT+IF4RqnINBK5/2XjrJj41ADarcl+2ApzsLaJbGz/rs70xpKKPPSzif5JTqyKHI16N2D2j44T9dImJ/ZzyquDeQRVKSlscwbn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c02:b0:424:6c8e:617f with SMTP id
 e9e14a558f8ab-42e7ad18b7bmr176039915ab.8.1759761543339; Mon, 06 Oct 2025
 07:39:03 -0700 (PDT)
Date: Mon, 06 Oct 2025 07:39:03 -0700
In-Reply-To: <CABGqKE0FCWJ0EjzV5irNWtnLe5n9SGeqfmMEHPzWtsXhfUXXvg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3d487.a70a0220.160221.0002.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in attr_set_size
From: syzbot <syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

dule.
[    8.288207][    T1] RPC: Registered udp transport module.
[    8.289931][    T1] RPC: Registered tcp transport module.
[    8.291845][    T1] RPC: Registered tcp-with-tls transport module.
[    8.293772][    T1] RPC: Registered tcp NFSv4.1 backchannel transport mo=
dule.
[    8.331348][    T1] NET: Registered PF_XDP protocol family
[    8.333135][    T1] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 windo=
w]
[    8.336032][    T1] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff windo=
w]
[    8.338411][    T1] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bff=
ff window]
[    8.340200][    T1] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfef=
ff window]
[    8.347159][    T1] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    8.350898][    T1] PCI: CLS 0 bytes, default 64
[    8.352908][    T1] PCI-DMA: Using software bounce buffering for IO (SWI=
OTLB)
[    8.355024][    T1] software IO TLB: mapped [mem 0x00000000bbffd000-0x00=
000000bfffd000] (64MB)
[    8.358033][    T1] ACPI: bus type thunderbolt registered
[    8.387288][   T61] kworker/u8:1 (61) used greatest stack depth: 11960 b=
ytes left
[    8.495149][    T1] RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters=
, 10737418240 ms ovfl timer
[    8.648953][    T1] kvm_amd: CPU 1 isn't AMD or Hygon
[    8.650444][    T1] clocksource: tsc: mask: 0xffffffffffffffff max_cycle=
s: 0x1fb6c80a799, max_idle_ns: 440795272342 ns
[    9.016382][    T1] clocksource: Switched to clocksource tsc
[    9.019550][   T62] kworker/u8:3 (62) used greatest stack depth: 11816 b=
ytes left
[   34.691907][    T1] Initialise system trusted keyrings
[   34.701905][    T1] workingset: timestamp_bits=3D40 max_order=3D21 bucke=
t_order=3D0
[   34.713356][    T1] DLM installed
[   34.727734][    T1] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[   34.757434][    T1] NFS: Registering the id_resolver key type
[   34.763850][    T1] Key type id_resolver registered
[   34.768945][    T1] Key type id_legacy registered
[   34.774737][    T1] nfs4filelayout_init: NFSv4 File Layout Driver Regist=
ering...
[   34.782570][    T1] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Drive=
r Registering...
[   34.816751][    T1] Key type cifs.spnego registered
[   34.822596][    T1] Key type cifs.idmap registered
[   34.835867][    T1] ntfs3: Enabled Linux POSIX ACLs support
[   34.841823][    T1] ntfs3: Read-only LZX/Xpress compression included
[   34.848915][    T1] efs: 1.0a - http://aeschi.ch.eu.org/efs/
[   34.855288][    T1] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[   34.861326][    T1] QNX4 filesystem 0.2.3 registered.
[   34.867988][    T1] qnx6: QNX6 filesystem 1.0.0 registered.
[   34.875504][    T1] fuse: init (API version 7.45)
[   34.886866][    T1] orangefs_debugfs_init: called with debug mask: :none=
: :0:
[   34.895794][    T1] orangefs_init: module version upstream loaded
[   34.904152][    T1] JFS: nTxBlock =3D 8192, nTxLock =3D 65536
[   34.948833][    T1] SGI XFS with ACLs, security attributes, realtime, qu=
ota, no debug enabled
[   34.965946][    T1] 9p: Installing v9fs 9p2000 file system support
[   34.973347][    T1] NILFS version 2 loaded
[   34.977862][    T1] befs: version: 0.9.3
[   34.983005][    T1] ocfs2: Registered cluster interface o2cb
[   34.991273][    T1] ocfs2: Registered cluster interface user
[   34.998495][    T1] OCFS2 User DLM kernel interface loaded
[   35.017803][    T1] gfs2: GFS2 installed
[   35.059251][    T1] ceph: loaded (mds proto 32)
[   35.806968][    T1] NET: Registered PF_ALG protocol family
[   35.813312][    T1] xor: automatically using best checksumming function =
  avx      =20
[   35.821495][    T1] async_tx: api initialized (async)
[   35.826889][    T1] Key type asymmetric registered
[   35.831892][    T1] Asymmetric key parser 'x509' registered
[   35.837768][    T1] Asymmetric key parser 'pkcs8' registered
[   35.843909][    T1] Key type pkcs7_test registered
[   35.850310][    T1] Block layer SCSI generic (bsg) driver version 0.4 lo=
aded (major 239)
[   35.860582][    T1] io scheduler mq-deadline registered
[   35.866502][    T1] io scheduler kyber registered
[   35.871959][    T1] io scheduler bfq registered
[   35.891367][    T1] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN=
:00/input/input0
[   35.902076][  T140] kworker/u8:2 (140) used greatest stack depth: 10968 =
bytes left
[   35.911355][    T1] ACPI: button: Power Button [PWRF]
[   35.919612][    T1] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN=
:00/input/input1
[   35.930796][    T1] ACPI: button: Sleep Button [SLPF]
[   35.957609][    T1] ioatdma: Intel(R) QuickData Technology Driver 5.00
[   36.038568][    T1] ACPI: \_SB_.LNKC: Enabled at IRQ 11
[   36.044867][    T1] virtio-pci 0000:00:03.0: virtio_pci: leaving for leg=
acy driver
[   36.123929][    T1] ACPI: \_SB_.LNKD: Enabled at IRQ 10
[   36.129736][    T1] virtio-pci 0000:00:04.0: virtio_pci: leaving for leg=
acy driver
[   36.208303][    T1] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   36.214188][    T1] virtio-pci 0000:00:06.0: virtio_pci: leaving for leg=
acy driver
[   36.273080][    T1] virtio-pci 0000:00:07.0: virtio_pci: leaving for leg=
acy driver
[   37.416353][    T1] N_HDLC line discipline registered with maxframe=3D40=
96
[   37.425415][    T1] Serial: 8250/16550 driver, 4 ports, IRQ sharing enab=
led
[   37.437763][    T1] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D =
115200) is a 16550A
[   37.472838][    T1] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D =
115200) is a 16550A
[   37.510114][    T1] 00:05: ttyS2 at I/O 0x3e8 (irq =3D 6, base_baud =3D =
115200) is a 16550A
[   37.542088][    T1] 00:06: ttyS3 at I/O 0x2e8 (irq =3D 7, base_baud =3D =
115200) is a 16550A
[   37.596348][    T1] Non-volatile memory driver v1.3
[   37.622619][    T1] Linux agpgart interface v0.103
[   37.636015][    T1] usbcore: registered new interface driver xillyusb
[   37.652287][    T1] ACPI: bus type drm_connector registered
[   37.677443][    T1] [drm] Initialized vgem 1.0.0 for vgem on minor 0
[   37.700372][    T1] [drm] Initialized vkms 1.0.0 for vkms on minor 1
[   38.011203][    T1] Console: switching to colour frame buffer device 128=
x48
[   38.099833][    T1] faux_driver vkms: [drm] fb0: vkmsdrmfb frame buffer =
device
[   38.108152][    T1] usbcore: registered new interface driver udl
[   38.119676][    T1] usbcore: registered new interface driver gm12u320
[   38.127305][    T1] usbcore: registered new interface driver gud
[   38.279542][    T1] brd: module loaded
[   38.672678][    T1] loop: module loaded
[   38.970689][    T1] zram: Added device: zram0
[   38.996271][    T1] null_blk: disk nullb0 created
[   39.001274][    T1] null_blk: module loaded
[   39.008475][    T1] Guest personality initialized and is inactive
[   39.016196][    T1] VMCI host device registered (name=3Dvmci, major=3D10=
, minor=3D265)
[   39.024148][    T1] Initialized host personality
[   39.029706][    T1] usbcore: registered new interface driver rtsx_usb
[   39.042104][    T1] usbcore: registered new interface driver viperboard
[   39.050349][    T1] usbcore: registered new interface driver dln2
[   39.058525][    T1] usbcore: registered new interface driver pn533_usb
[   39.072218][    T1] nfcsim 0.2 initialized
[   39.077348][    T1] usbcore: registered new interface driver port100
[   39.084860][    T1] usbcore: registered new interface driver nfcmrvl
[   39.102738][    T1] Loading iSCSI transport class v2.0-870.
[   39.144075][    T1] virtio_scsi virtio0: 1/0/0 default/read/poll queues
[   39.180630][    T1] scsi host0: Virtio SCSI HBA
[   39.707208][    T1] st: Version 20160209, fixed bufsize 32768, s/g segs =
256
[   39.726184][   T35] scsi 0:0:1:0: Direct-Access     Google   PersistentD=
isk   1    PQ: 0 ANSI: 6
[   39.759242][   T35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   39.767633][   T35] BUG: KMSAN: use-after-free in scsi_get_vpd_buf+0x4cc=
/0x720
[   39.776263][   T35]  scsi_get_vpd_buf+0x4cc/0x720
[   39.781276][   T35]  scsi_attach_vpd+0x974/0xe70
[   39.787803][   T35]  scsi_probe_and_add_lun+0x6933/0x7f20
[   39.788235][    T1] Rounding down aligned max_sectors from 4294967295 to=
 4294967288
[   39.795150][   T35]  __scsi_scan_target+0x2fb/0x2050
[   39.804255][    T1] db_root: cannot open: /etc/target
[   39.806728][   T35]  scsi_scan_host_selected+0x68f/0x9a0
[   39.817463][   T35]  do_scan_async+0x1ad/0xdc0
[   39.822216][   T35]  async_run_entry_fn+0x90/0x570
[   39.827441][   T35]  process_scheduled_works+0xb91/0x1d80
[   39.833182][   T35]  worker_thread+0xedf/0x1590
[   39.838088][   T35]  kthread+0xd59/0xf00
[   39.842300][   T35]  ret_from_fork+0x230/0x380
[   39.847156][   T35]  ret_from_fork_asm+0x1a/0x30
[   39.852097][   T35]=20
[   39.854573][   T35] Uninit was created at:
[   39.859003][   T35]  kfree+0x254/0x1460
[   39.863131][   T35]  call_usermodehelper_exec_async+0x666/0x6f0
[   39.869451][   T35]  ret_from_fork+0x230/0x380
[   39.874294][   T35]  ret_from_fork_asm+0x1a/0x30
[   39.879336][   T35]=20
[   39.881773][   T35] CPU: 1 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted=
 syzkaller #0 PREEMPT(none)=20
[   39.891297][   T35] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/18/2025
[   39.891399][    T1] eql: Equalizer2002: Simon Janes (simon@ncm.com) and =
David S. Miller (davem@redhat.com)
[   39.901579][   T35] Workqueue: async async_run_entry_fn
[   39.917166][   T35] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   39.924258][   T35] Disabling lock debugging due to kernel taint
[   39.930495][   T35] Kernel panic - not syncing: kmsan.panic set ...
[   39.934188][   T35] CPU: 1 UID: 0 PID: 35 Comm: kworker/u8:2 Tainted: G =
   B               syzkaller #0 PREEMPT(none)=20
[   39.934188][   T35] Tainted: [B]=3DBAD_PAGE
[   39.934188][   T35] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 08/18/2025
[   39.954023][   T35] Workqueue: async async_run_entry_fn
[   39.954023][   T35] Call Trace:
[   39.954023][   T35]  <TASK>
[   39.954023][   T35]  __dump_stack+0x26/0x30
[   39.954023][   T35]  dump_stack_lvl+0x53/0x270
[   39.983756][   T35]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   39.984028][   T35]  dump_stack+0x1e/0x25
[   39.984028][   T35]  vpanic+0x435/0xd30
[   39.984028][   T35]  panic+0x15d/0x160
[   39.984028][   T35]  kmsan_report+0x31c/0x320
[   39.984028][   T35]  ? __msan_warning+0x1b/0x30
[   39.984028][   T35]  ? scsi_get_vpd_buf+0x4cc/0x720
[   39.984028][   T35]  ? scsi_attach_vpd+0x974/0xe70
[   39.984028][   T35]  ? scsi_probe_and_add_lun+0x6933/0x7f20
[   40.024987][   T35]  ? __scsi_scan_target+0x2fb/0x2050
[   40.031990][   T35]  ? scsi_scan_host_selected+0x68f/0x9a0
[   40.031990][   T35]  ? do_scan_async+0x1ad/0xdc0
[   40.031990][   T35]  ? async_run_entry_fn+0x90/0x570
[   40.031990][   T35]  ? process_scheduled_works+0xb91/0x1d80
[   40.031990][   T35]  ? worker_thread+0xedf/0x1590
[   40.031990][   T35]  ? kthread+0xd59/0xf00
[   40.031990][   T35]  ? ret_from_fork+0x230/0x380
[   40.031990][   T35]  ? ret_from_fork_asm+0x1a/0x30
[   40.074129][   T35]  ? blk_mq_free_request+0x3b6/0x600
[   40.074129][   T35]  ? scsi_execute_cmd+0x1add/0x1c70
[   40.074129][   T35]  ? kmsan_get_metadata+0xfb/0x160
[   40.103719][   T35]  __msan_warning+0x1b/0x30
[   40.103719][   T35]  scsi_get_vpd_buf+0x4cc/0x720
[   40.103719][   T35]  scsi_attach_vpd+0x974/0xe70
[   40.103719][   T35]  scsi_probe_and_add_lun+0x6933/0x7f20
[   40.133877][   T35]  __scsi_scan_target+0x2fb/0x2050
[   40.133877][   T35]  ? kmsan_internal_set_shadow_origin+0x7a/0x110
[   40.133877][   T35]  ? _raw_spin_unlock_irqrestore+0x3f/0x60
[   40.133877][   T35]  ? __pm_runtime_resume+0x1f7/0x230
[   40.133877][   T35]  ? kmsan_get_metadata+0xfb/0x160
[   40.163605][   T35]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   40.163605][   T35]  scsi_scan_host_selected+0x68f/0x9a0
[   40.163605][   T35]  do_scan_async+0x1ad/0xdc0
[   40.163605][   T35]  ? ktime_get+0x530/0x590
[   40.163605][   T35]  ? kmsan_get_metadata+0xfb/0x160
[   40.163605][   T35]  async_run_entry_fn+0x90/0x570
[   40.193576][   T35]  ? kmsan_get_metadata+0xfb/0x160
[   40.193576][   T35]  ? __pfx_do_scan_async+0x10/0x10
[   40.193576][   T35]  ? kmsan_get_shadow_origin_ptr+0x4a/0xb0
[   40.193576][   T35]  ? __pfx_async_run_entry_fn+0x10/0x10
[   40.193576][   T35]  process_scheduled_works+0xb91/0x1d80
[   40.223593][   T35]  worker_thread+0xedf/0x1590
[   40.223593][   T35]  kthread+0xd59/0xf00
[   40.223593][   T35]  ? __pfx_worker_thread+0x10/0x10
[   40.223593][   T35]  ? __pfx_kthread+0x10/0x10
[   40.223593][   T35]  ret_from_fork+0x230/0x380
[   40.223593][   T35]  ? __pfx_kthread+0x10/0x10
[   40.223593][   T35]  ret_from_fork_asm+0x1a/0x30
[   40.223593][   T35]  </TASK>
[   40.223593][   T35] Kernel Offset: disabled
[   40.223593][   T35] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build4190601459=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 49379ee008e
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D49379ee008e5f2af6e551c2e23fcd6b1ebb4d5c2 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251002-084935"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D49379ee008e5f2af6e551c2e23fcd6b1ebb4d5c2 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251002-084935"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D49379ee008e5f2af6e551c2e23fcd6b1ebb4d5c2 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251002-084935"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"49379ee008e5f2af6e551c2e23fcd6b1eb=
b4d5c2\"
/usr/bin/ld: /tmp/ccqyzhm0.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12999a7c580000


Tested on:

commit:         fd94619c Merge tag 'zonefs-6.18-rc1' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dad506767107aacd=
a
dashboard link: https://syzkaller.appspot.com/bug?extid=3D83c9dd5c0dcf6184f=
dbf
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D122bd0925800=
00


