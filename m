Return-Path: <linux-kernel+bounces-728876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1197B02E51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5714A0759
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9B828E0F;
	Sun, 13 Jul 2025 01:05:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DD2E3714
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752368706; cv=none; b=Ui3htGKrSxvIF1WjC22jH1i3DZvxmwVLj6+FXe4QN+O6D/OFzZjTvvoG5SowteGjVUTZTenZ6Ggxmu1JfJF8C4GWK/1rTmKaBy4DDYVORKW1eiGUMhfROjacdlWX6wVjX0dmf1pfRRFfkw5RLBefeLDSQRjaaB+bBKp+7Mr9Bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752368706; c=relaxed/simple;
	bh=j4WvjMJZo37hI3UdfcRxPq1LfagE6eniR8QvQJIAZ4M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FDe0i6nOvPSObLipUjNHYBrq/GhGs6BNNLjfpR3zvhZuJK00OvRS9nv8ilANln0yF8Y/0sJADBj+Kc0cjZMoDZPjEPpNABvLtcRT7G0WvopJiN7KdLYXwwpT/VqPqlMezrOJkkpk8VXJ+ow+Q8LBdPhNDGV2FDPSj/a3Mxx9sIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d01ff56ebso554691239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752368703; x=1752973503;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lnzr3nFgD4m4rR1gIsecnMYb0FDh8HyVFU3+VoUeYes=;
        b=EApZx16I9mYwryyh0cOJdlcymRTaVVpKCvR+Tn5Ah9f84bjSTU4EA7bS1cEG+1SXpm
         u+PdBV6iwi8rw4iSyOwEWI0/afGHxxfcRZBOWIFH7lv3/9TeNHaYU6bG212CqD1cNuTm
         CM/SfUlNziLltj1NMSPQyExyZS0FpIyimvePdsPsL8cKtnkVuofrT+iqxJ0buDsjXg6s
         yo9N9GzUAHJ0anfXuwfdR0QZgVSMqT27YVldGszqCizg5nvEV9VFo5ll/iaFLkddFpZK
         82dFV0Rni4JqsDRMnMRspikJZWWUqr6xrMU8v1JAJvhjYQaypUFXO082KDDN71D1XyVW
         MGPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlUvbYmquDODHNlP2cY9iPfj7b5n4m0W5cL1cLIM1/5bDViNtXUPIPOtcBXfGRjPstLdonFwVzlFoKZNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ9FjRfl9I9ezh4ud6wpKvBCQl68aBis3vD6xSZQYPBvvFFexJ
	2GHDaiKoRO10/dTMIJLkRlGdLSNsORWwK2pgfWmcN6Of0sOKwb/q6FRvo5DueB8cwncdXHwDsjo
	S1JpKxK9vwuM9AqipIncuN6JUnQcPFYMvzLqjnaBfAnJbNOjJTBPrQMtlljM=
X-Google-Smtp-Source: AGHT+IGKavLzOZZtrPboO3iDF5LmOjBR0vW/HWhWZeo2v8S4cQSQRCN5fBhSXHiqAABVXkaqPE6uYtJ3BSKm65xwT13zbjDE5zRA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd2:b0:875:acf6:20f with SMTP id
 ca18e2360f4ac-8797883d111mr915458639f.10.1752368703439; Sat, 12 Jul 2025
 18:05:03 -0700 (PDT)
Date: Sat, 12 Jul 2025 18:05:03 -0700
In-Reply-To: <20250712235411.3747-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6873063f.a70a0220.3b380f.0018.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 TLB invalidation policy: strict mode
[    2.352183][    T1] SCSI subsystem initialized
[    2.360380][    T1] ACPI: bus type USB registered
[    2.362285][    T1] usbcore: registered new interface driver usbfs
[    2.364183][    T1] usbcore: registered new interface driver hub
[    2.365927][    T1] usbcore: registered new device driver usb
[    2.370494][    T1] mc: Linux media interface: v0.10
[    2.372105][    T1] videodev: Linux video capture interface: v2.00
[    2.376020][    T1] pps_core: LinuxPPS API ver. 1 registered
[    2.377461][    T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 =
Rodolfo Giometti <giometti@linux.it>
[    2.380182][    T1] PTP clock support registered
[    2.382794][    T1] EDAC MC: Ver: 3.0.0
[    2.385715][    T1] scmi_core: SCMI protocol bus registered
[    2.388640][    T1] efivars: Registered efivars operations
[    2.396158][    T1] FPGA manager framework
[    2.398997][    T1] Advanced Linux Sound Architecture Driver Initialized=
.
[    2.411759][    T1] Bluetooth: Core ver 2.22
[    2.414872][    T1] NET: Registered PF_BLUETOOTH protocol family
[    2.416439][    T1] Bluetooth: HCI device and connection manager initial=
ized
[    2.420096][    T1] Bluetooth: HCI socket layer initialized
[    2.421639][    T1] Bluetooth: L2CAP socket layer initialized
[    2.423218][    T1] Bluetooth: SCO socket layer initialized
[    2.424759][    T1] NET: Registered PF_ATMPVC protocol family
[    2.426267][    T1] NET: Registered PF_ATMSVC protocol family
[    2.428023][    T1] NetLabel: Initializing
[    2.428055][    T1] NetLabel:  domain hash size =3D 128
[    2.428069][    T1] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    2.428360][    T1] NetLabel:  unlabeled traffic allowed by default
[    2.437111][    T1] nfc: nfc_init: NFC Core ver 0.1
[    2.438676][    T1] NET: Registered PF_NFC protocol family
[    2.440229][    T1] mctp: management component transport protocol core
[    2.441941][    T1] NET: Registered PF_MCTP protocol family
[    2.444342][    T1] vgaarb: loaded
[    2.446639][    T1] clocksource: Switched to clocksource arch_sys_counte=
r
[    2.450295][    T1] VFS: Disk quotas dquot_6.6.0
[    2.451639][    T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4=
096 bytes)
[    2.455139][    T1] netfs: FS-Cache loaded
[    2.457259][    T1] CacheFiles: Loaded
[    2.458649][    T1] TOMOYO: 2.6.0
[    2.459571][    T1] Mandatory Access Control activated.
[    2.461363][    T1] pnp: PnP ACPI init
[    2.464028][    T1] system 00:00: [mem 0x3f000000-0x3fffffff window] cou=
ld not be reserved
[    2.466882][    T1] pnp: PnP ACPI: found 1 devices
[    2.502617][    T1] NET: Registered PF_INET protocol family
[    2.504588][    T1] IP idents hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[    2.512476][    T1] BUG: sleeping function called from invalid context a=
t net/core/sock.c:3754
[    2.512522][    T1] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pi=
d: 1, name: swapper/0
[    2.512539][    T1] preempt_count: 201, expected: 0
[    2.512551][    T1] RCU nest depth: 0, expected: 0
[    2.512562][    T1] 2 locks held by swapper/0/1:
[    2.512574][    T1]  #0: ffff0000c30701d8 (k-slock-AF_INET/1){+...}-{3:3=
}, at: smack_netlbl_add+0x78/0x158
[    2.512655][    T1]  #1: ffff0000c3070258 (k-sk_lock-AF_INET){+...}-{0:0=
}, at: netlbl_sock_setattr+0x34/0x344
[    2.512720][    T1] Preemption disabled at:
[    2.512728][    T1] [<ffff800082c874a8>] local_bh_disable+0x28/0x34
[    2.512751][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
6.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT=20
[    2.512765][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[    2.512773][    T1] Call trace:
[    2.512777][    T1]  show_stack+0x2c/0x3c (C)
[    2.512789][    T1]  __dump_stack+0x30/0x40
[    2.512803][    T1]  dump_stack_lvl+0xd8/0x12c
[    2.512816][    T1]  dump_stack+0x1c/0x28
[    2.512829][    T1]  __might_resched+0x348/0x4c4
[    2.512842][    T1]  __might_sleep+0x94/0x110
[    2.512854][    T1]  sockopt_lock_sock+0x94/0x144
[    2.512866][    T1]  netlbl_sock_setattr+0x34/0x344
[    2.512879][    T1]  smack_netlbl_add+0xa8/0x158
[    2.512892][    T1]  smack_socket_post_create+0xa8/0x158
[    2.512905][    T1]  security_socket_post_create+0xc0/0x348
[    2.512916][    T1]  __sock_create+0x4c8/0x91c
[    2.512928][    T1]  sock_create_kern+0x4c/0x64
[    2.512940][    T1]  inet_ctl_sock_create+0xa4/0x1f0
[    2.512953][    T1]  nat_keepalive_sk_init+0xfc/0x2c0
[    2.512965][    T1]  xfrm_nat_keepalive_init+0x64/0xb4
[    2.512975][    T1]  xfrm_init+0x48/0x54
[    2.512989][    T1]  ip_rt_init+0x2ec/0x3e0
[    2.513001][    T1]  ip_init+0x14/0x28
[    2.513011][    T1]  inet_init+0x3f8/0x55c
[    2.513022][    T1]  do_one_initcall+0x250/0x990
[    2.513032][    T1]  do_initcall_level+0x154/0x214
[    2.513046][    T1]  do_initcalls+0x84/0xf4
[    2.513058][    T1]  do_basic_setup+0x8c/0xa0
[    2.513070][    T1]  kernel_init_freeable+0x2dc/0x444
[    2.513092][    T1]  kernel_init+0x24/0x1dc
[    2.513105][    T1]  ret_from_fork+0x10/0x20
[    2.513136][    T1] BUG: spinlock recursion on CPU#0, swapper/0/1
[    2.513149][    T1]  lock: 0xffff0000c30701c0, .magic: dead4ead, .owner:=
 swapper/0/1, .owner_cpu: 0
[    2.513170][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     =
   W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT=20
[    2.513186][    T1] Tainted: [W]=3DWARN
[    2.513190][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[    2.513196][    T1] Call trace:
[    2.513199][    T1]  show_stack+0x2c/0x3c (C)
[    2.513209][    T1]  __dump_stack+0x30/0x40
[    2.513222][    T1]  dump_stack_lvl+0xd8/0x12c
[    2.513235][    T1]  dump_stack+0x1c/0x28
[    2.513247][    T1]  spin_dump+0x104/0x1ec
[    2.513259][    T1]  do_raw_spin_lock+0x1e0/0x2cc
[    2.513273][    T1]  _raw_spin_lock_bh+0x50/0x60
[    2.513284][    T1]  sockopt_lock_sock+0x9c/0x144
[    2.513294][    T1]  netlbl_sock_setattr+0x34/0x344
[    2.513318][    T1]  smack_netlbl_add+0xa8/0x158
[    2.513331][    T1]  smack_socket_post_create+0xa8/0x158
[    2.513343][    T1]  security_socket_post_create+0xc0/0x348
[    2.513354][    T1]  __sock_create+0x4c8/0x91c
[    2.513366][    T1]  sock_create_kern+0x4c/0x64
[    2.513377][    T1]  inet_ctl_sock_create+0xa4/0x1f0
[    2.513390][    T1]  nat_keepalive_sk_init+0xfc/0x2c0
[    2.513400][    T1]  xfrm_nat_keepalive_init+0x64/0xb4
[    2.513410][    T1]  xfrm_init+0x48/0x54
[    2.513422][    T1]  ip_rt_init+0x2ec/0x3e0
[    2.513433][    T1]  ip_init+0x14/0x28
[    2.513443][    T1]  inet_init+0x3f8/0x55c
[    2.513454][    T1]  do_one_initcall+0x250/0x990
[    2.513464][    T1]  do_initcall_level+0x154/0x214
[    2.513477][    T1]  do_initcalls+0x84/0xf4
[    2.513489][    T1]  do_basic_setup+0x8c/0xa0
[    2.513500][    T1]  kernel_init_freeable+0x2dc/0x444
[    2.513513][    T1]  kernel_init+0x24/0x1dc
[    2.513524][    T1]  ret_from_fork+0x10/0x20
[   28.336626][    C0] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [s=
wapper/0:1]
[   28.336646][    C0] Modules linked in:
[   28.336653][    C0] irq event stamp: 644898
[   28.340018][    C0] hardirqs last  enabled at (644898): [<ffff80008aef9a=
e4>] exit_to_kernel_mode+0xc0/0xf0
[   28.342013][    C0] hardirqs last disabled at (644897): [<ffff80008aef6f=
24>] el1_interrupt+0x24/0x54
[   28.343894][    C0] softirqs last  enabled at (644786): [<ffff8000892251=
40>] local_bh_enable+0x10/0x34
[   28.345849][    C0] softirqs last disabled at (644814): [<ffff800082c874=
90>] local_bh_disable+0x10/0x34
[   28.347802][    C0] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     =
   W           6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT=20
[   28.347820][    C0] Tainted: [W]=3DWARN
[   28.347823][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[   28.347829][    C0] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
[   28.347840][    C0] pc : queued_spin_lock_slowpath+0x138/0xaec
[   28.347851][    C0] lr : queued_spin_lock_slowpath+0x144/0xaec
[   28.347860][    C0] sp : ffff8000979d71e0
[   28.347864][    C0] x29: ffff8000979d7280 x28: 1fffe0001860e039 x27: 1ff=
fe0001833a002
[   28.347880][    C0] x26: ffff0000c19d0000 x25: dfff800000000000 x24: fff=
f700012f3ae40
[   28.347895][    C0] x23: 0000000000000000 x22: ffff0000c19d0010 x21: fff=
f0000c30701c8
[   28.347908][    C0] x20: ffff0000c30701d0 x19: ffff0000c30701c0 x18: 000=
00000ffffffff
[   28.347922][    C0] x17: 312f302f72657070 x16: ffff8000802155d0 x15: 000=
0000000000001
[   28.347936][    C0] x14: 1fffe0001860e038 x13: 0000000000000000 x12: 000=
0000000000000
[   28.347949][    C0] x11: ffff60001860e039 x10: dfff800000000000 x9 : 000=
0000000000000
[   28.347963][    C0] x8 : 0000000000000001 x7 : 0000000000000001 x6 : fff=
f80008055ab90
[   28.347976][    C0] x5 : 0000000000000000 x4 : 0000000000000000 x3 : fff=
f80008af1e7f0
[   28.347989][    C0] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 000=
0000000000001
[   28.348001][    C0] Call trace:
[   28.348005][    C0]  queued_spin_lock_slowpath+0x138/0xaec (P)
[   28.348017][    C0]  do_raw_spin_lock+0x2a8/0x2cc
[   28.348029][    C0]  _raw_spin_lock_bh+0x50/0x60
[   28.348039][    C0]  sockopt_lock_sock+0x9c/0x144
[   28.348050][    C0]  netlbl_sock_setattr+0x34/0x344
[   28.348063][    C0]  smack_netlbl_add+0xa8/0x158
[   28.348075][    C0]  smack_socket_post_create+0xa8/0x158
[   28.348096][    C0]  security_socket_post_create+0xc0/0x348
[   28.348106][    C0]  __sock_create+0x4c8/0x91c
[   28.348117][    C0]  sock_create_kern+0x4c/0x64
[   28.348128][    C0]  inet_ctl_sock_create+0xa4/0x1f0
[   28.348146][    C0]  nat_keepalive_sk_init+0xfc/0x2c0
[   28.348156][    C0]  xfrm_nat_keepalive_init+0x64/0xb4
[   28.348166][    C0]  xfrm_init+0x48/0x54
[   28.348179][    C0]  ip_rt_init+0x2ec/0x3e0
[   28.348189][    C0]  ip_init+0x14/0x28
[   28.348198][    C0]  inet_init+0x3f8/0x55c
[   28.348208][    C0]  do_one_initcall+0x250/0x990
[   28.348219][    C0]  do_initcall_level+0x154/0x214
[   28.348232][    C0]  do_initcalls+0x84/0xf4
[   28.348243][    C0]  do_basic_setup+0x8c/0xa0
[   28.348254][    C0]  kernel_init_freeable+0x2dc/0x444
[   28.348265][    C0]  kernel_init+0x24/0x1dc
[   28.348277][    C0]  ret_from_fork+0x10/0x20
[   28.348289][    C0] Kernel panic - not syncing: softlockup: hung tasks
[   28.396972][    C0] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     =
   W    L      6.16.0-rc5-syzkaller-00067-gec4801305969-dirty #0 PREEMPT=20
[   28.399322][    C0] Tainted: [W]=3DWARN, [L]=3DSOFTLOCKUP
[   28.400262][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 05/07/2025
[   28.402010][    C0] Call trace:
[   28.402616][    C0]  show_stack+0x2c/0x3c (C)
[   28.403440][    C0]  __dump_stack+0x30/0x40
[   28.404226][    C0]  dump_stack_lvl+0x30/0x12c
[   28.405041][    C0]  dump_stack+0x1c/0x28
[   28.405796][    C0]  panic+0x2bc/0x7ac
[   28.406498][    C0]  softlockup_fn+0x0/0x120
[   28.407308][    C0]  __hrtimer_run_queues+0x3ec/0xb78
[   28.408244][    C0]  hrtimer_interrupt+0x2b8/0xb50
[   28.409119][    C0]  arch_timer_handler_virt+0x74/0x88
[   28.410058][    C0]  handle_percpu_devid_irq+0x174/0x308
[   28.411034][    C0]  generic_handle_domain_irq+0xe0/0x140
[   28.412032][    C0]  gic_handle_irq+0x6c/0x190
[   28.412871][    C0]  call_on_irq_stack+0x24/0x30
[   28.413727][    C0]  do_interrupt_handler+0xd4/0x138
[   28.414644][    C0]  el1_interrupt+0x34/0x54
[   28.415456][    C0]  el1h_64_irq_handler+0x18/0x24
[   28.416359][    C0]  el1h_64_irq+0x6c/0x70
[   28.417119][    C0]  queued_spin_lock_slowpath+0x138/0xaec (P)
[   28.418204][    C0]  do_raw_spin_lock+0x2a8/0x2cc
[   28.419055][    C0]  _raw_spin_lock_bh+0x50/0x60
[   28.419902][    C0]  sockopt_lock_sock+0x9c/0x144
[   28.420801][    C0]  netlbl_sock_setattr+0x34/0x344
[   28.421690][    C0]  smack_netlbl_add+0xa8/0x158
[   28.422559][    C0]  smack_socket_post_create+0xa8/0x158
[   28.423541][    C0]  security_socket_post_create+0xc0/0x348
[   28.424580][    C0]  __sock_create+0x4c8/0x91c
[   28.425423][    C0]  sock_create_kern+0x4c/0x64
[   28.426266][    C0]  inet_ctl_sock_create+0xa4/0x1f0
[   28.427186][    C0]  nat_keepalive_sk_init+0xfc/0x2c0
[   28.428116][    C0]  xfrm_nat_keepalive_init+0x64/0xb4
[   28.429043][    C0]  xfrm_init+0x48/0x54
[   28.429782][    C0]  ip_rt_init+0x2ec/0x3e0
[   28.430586][    C0]  ip_init+0x14/0x28
[   28.431297][    C0]  inet_init+0x3f8/0x55c
[   28.432039][    C0]  do_one_initcall+0x250/0x990
[   28.432880][    C0]  do_initcall_level+0x154/0x214
[   28.433778][    C0]  do_initcalls+0x84/0xf4
[   28.434572][    C0]  do_basic_setup+0x8c/0xa0
[   28.435396][    C0]  kernel_init_freeable+0x2dc/0x444
[   28.436331][    C0]  kernel_init+0x24/0x1dc
[   28.437097][    C0]  ret_from_fork+0x10/0x20
[   28.437870][    C0] SMP: stopping secondary CPUs
[   28.438775][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2629924031=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 4f67c4aece
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Darm64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D4f67c4aece4f5794be20c6bc99c177e44b1320e8 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250704-175521"  -o ./bi=
n/linux_arm64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_arm64
aarch64-linux-gnu-g++ -o ./bin/linux_arm64/syz-executor executor/executor.c=
c \
	-O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wframe-l=
arger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-format-ove=
rflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -stati=
c-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH_arm6=
4=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"4f67c4aece4f5794be20c6bc99c177e44b=
1320e8\"
/usr/lib/gcc-cross/aarch64-linux-gnu/12/../../../../aarch64-linux-gnu/bin/l=
d: /tmp/cc4tXqkl.o: in function `Connection::Connect(char const*, char cons=
t*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0xd8): warning: Using 'gethostbyname' in statically linked applicati=
ons requires at runtime the shared libraries from the glibc version used fo=
r linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11ac4e8c580000


Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9e99b6fcd403d05=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D40bf00346c3fe40f9=
0f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13521d825800=
00


