Return-Path: <linux-kernel+bounces-868311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA84C04DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD319403479
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9702EDD4D;
	Fri, 24 Oct 2025 07:50:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295912E8B6F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292206; cv=none; b=BHB3N7BIbUA6oXpQ1Yi45FalQo8iCoRSrpk3h84Vmr35eNXCP0pLYvbFmAg8Fk08SlfCGAHz5sof1fPUMCMvGYDeS+dwd0xubPaJzBDi1mLHno1+eJLKpJaFbYjYjwHZuuD7BtVux8umSVbo55tfoY5fCK8cYbccbmIGQW9BU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292206; c=relaxed/simple;
	bh=hxUucIHdKdJ31/irsEnOTLY/6MiYyX/c42giX4p5IJA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B0n757M/GypdvOT/9+BEzmJcdsRaVEuf9/EfwiQUmtO8Vcbr6YEXFf6ByO0VER9q7utwmjxBRz0pV3TuLlH4/+QaxlZTLxJvjOxqeKDqeWNenZgQBm3blrJm+ESj/TWmiJHSRCzrjmLAfT8RaknYTSN6U6TmgSBEUjjrjh7xwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d1adb32aso17489225ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292203; x=1761897003;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85eyGgMSF8dab3XxoJKZV3CuBI8tjuDI/Z3JZ7sgOjo=;
        b=SqNZ7PjHqbyxnCrXEg2PHBFvI1mne8Qn1XQBlg83Y+IdH8geIBJ0+0KN2Zvg8JDgSx
         ufdAr7xhcits3wM3jTbknh7v02TFYYH6Y0L/LFlHRyxL0DZzMIE5ZhmUsT4W2C9IMJNW
         VQEyN9DUMCTUO5XyLdSfEDdW98GVIc6P5nUPdUThD1/GzApPbfVwGPVykgeBJBqczlmT
         PrKrxz0UP2JlXlPgwBBrixpK/DaK2sKnhLiVLFtKyplJHxLCkVtgUYurVets9Bi6tgnO
         TqBP1MZxUmAMW/EzXNGs6LSmq+7rpzuwq5LNLnim0jYIq4ioXVQlpjF+LscV9q0WrfIQ
         ZYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTw2+hv+a7EFb3U0q7yYJ8lVpeIY8kuGb2Zo6GNbkZazh6gi1C8aka8wkC9YTJ/YQk9YElBMacKyKHEnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aLJ5KSaSQijtgUqQkQ7qNqQRLwgnDCpCYAVqE1+TgNQXeYVG
	0WcEdm0TJsLgRoLCUheONuWpwJoMpNBBFnqiGAAt3BwnYkM8w5l28celqeucxebykvAjXq0w8yj
	NttmF/6onMXB1ZHjfls0MIzC4JHJfQPLUzFi7rrvVJ6mB33AIhJ2vaFEW6sc=
X-Google-Smtp-Source: AGHT+IEryOD2MYUoB5nkindvGNbGo8Fi9GkqPLH9Fvnr5E/t7Ih5tEo+Bpdo/fsNk0bqAad7NQ/cwrqnTE4GyTHnxPpCReIAWVt0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348f:b0:431:da5b:9ef3 with SMTP id
 e9e14a558f8ab-431da5ba0a2mr92776425ab.27.1761292203198; Fri, 24 Oct 2025
 00:50:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:50:03 -0700
In-Reply-To: <20251024071155.yng5I%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb2fab.050a0220.346f24.00af.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/=
2014
[   71.223454][    C0] Call Trace:
[   71.226203][    C0]  <IRQ>
[   71.228612][    C0]  dump_stack+0xfd/0x16e
[   71.232139][    C0]  panic+0x2f0/0x9c0
[   71.235407][    C0]  check_panic_on_warn+0x95/0xe0
[   71.239403][    C0]  handle_overflow+0x192/0x1b0
[   71.243198][    C0]  ip_idents_reserve+0x14a/0x170
[   71.247319][    C0]  __ip_select_ident+0xe4/0x1c0
[   71.251220][    C0]  iptunnel_xmit+0x468/0x850
[   71.254960][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   71.259256][    C0]  geneve_xmit+0x1d03/0x2130
[   71.263053][    C0]  dev_hard_start_xmit+0x2a8/0x7f0
[   71.267280][    C0]  __dev_queue_xmit+0x1690/0x2970
[   71.271468][    C0]  ip6_finish_output2+0x101e/0x1490
[   71.275766][    C0]  NF_HOOK+0x45/0x2c0
[   71.278968][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   71.282508][    C0]  mld_sendpack+0x5f7/0xa60
[   71.286156][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   71.290462][    C0]  ? lock_acquire+0x78/0x330
[   71.294191][    C0]  ? lock_release+0x69/0x640
[   71.298036][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   71.302006][    C0]  call_timer_fn+0x103/0x490
[   71.305730][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   71.309993][    C0]  __run_timers+0x5d8/0x7a0
[   71.313911][    C0]  run_timer_softirq+0x63/0xf0
[   71.318015][    C0]  __do_softirq+0x267/0x92e
[   71.322055][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   71.326339][    C0]  asm_call_irq_on_stack+0xf/0x20
[   71.330564][    C0]  </IRQ>
[   71.333015][    C0]  do_softirq_own_stack+0x9b/0xe0
[   71.337179][    C0]  __irq_exit_rcu+0x227/0x230
[   71.341102][    C0]  irq_exit_rcu+0x5/0x20
[   71.344621][    C0]  sysvec_apic_timer_interrupt+0xea/0x100
[   71.349764][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   71.354894][    C0] RIP: 0010:stack_trace_consume_entry+0x7/0x270
[   71.360059][    C0] Code: 00 00 48 3b 4c 24 18 75 09 48 83 c4 20 e9 91 6=
c df 07 e8 1c 54 9d 07 66 66 2e 0f 1f 84 00 00 00 00 00 90 55 41 57 41 56 4=
1 55 <41> 54 53 48 83 ec 18 48 ba 00 00 00 00 00 fc ff df 4c 8d 47 10 4c
[   71.376154][    C0] RSP: 0018:ffffc90008aaebf8 EFLAGS: 00000286
[   71.381241][    C0] RAX: ffffffff8783c2d8 RBX: ffffc90008aaecb8 RCX: 0a3=
c4b9e92682801
[   71.387858][    C0] RDX: ffffc90008aaec01 RSI: ffffffff8783c2d8 RDI: fff=
fc90008aaecb8
[   71.394430][    C0] RBP: ffffc90008aaeca8 R08: dffffc0000000000 R09: fff=
fc90008aaec70
[   71.401018][    C0] R10: fffff52001155d90 R11: ffffffff81611e60 R12: fff=
f88801e074380
[   71.407617][    C0] R13: ffffed100845e940 R14: ffffffff81611e60 R15: fff=
fc90008aaec20
[   71.414438][    C0]  ? stack_trace_save+0x70/0x70
[   71.418552][    C0]  ? stack_trace_save+0x70/0x70
[   71.422558][    C0]  ? netlink_sendmsg+0x968/0xb50
[   71.426642][    C0]  ? netlink_sendmsg+0x968/0xb50
[   71.430694][    C0]  ? stack_trace_save+0x70/0x70
[   71.434615][    C0]  arch_stack_walk+0x108/0x150
[   71.438527][    C0]  ? netlink_sendmsg+0x968/0xb50
[   71.442631][    C0]  stack_trace_save+0x42/0x70
[   71.446538][    C0]  __kasan_kmalloc+0x106/0x140
[   71.450364][    C0]  ? __kasan_kmalloc+0x106/0x140
[   71.454549][    C0]  ? slab_post_alloc_hook+0x3a/0x300
[   71.458983][    C0]  ? kmem_cache_alloc+0x191/0x320
[   71.463020][    C0]  ? sock_alloc_inode+0x17/0xb0
[   71.467007][    C0]  ? new_inode_pseudo+0x63/0x220
[   71.471116][    C0]  ? __sock_create+0x129/0x900
[   71.475108][    C0]  ? udp_sock_create6+0x67/0x540
[   71.479152][    C0]  ? wg_socket_init+0x54c/0x930
[   71.483309][    C0]  ? wg_open+0x24b/0x420
[   71.486904][    C0]  ? __dev_open+0x252/0x400
[   71.490620][    C0]  ? __dev_change_flags+0x20a/0x6e0
[   71.494962][    C0]  ? dev_change_flags+0x82/0x1a0
[   71.499149][    C0]  ? do_setlink+0xae5/0x39b0
[   71.502955][    C0]  ? rtnl_newlink+0x1190/0x1520
[   71.507503][    C0]  ? rtnetlink_rcv_msg+0x9a1/0xe10
[   71.511787][    C0]  ? netlink_rcv_skb+0x185/0x390
[   71.515716][    C0]  ? netlink_unicast+0x7b7/0x9b0
[   71.520611][    C0]  ? lock_release+0x69/0x640
[   71.525149][    C0]  slab_post_alloc_hook+0x3a/0x300
[   71.529525][    C0]  ? get_obj_cgroup_from_current+0x2c3/0x2f0
[   71.534522][    C0]  ? sock_alloc_inode+0x17/0xb0
[   71.538475][    C0]  kmem_cache_alloc+0x191/0x320
[   71.542291][    C0]  ? sockfs_init_fs_context+0xb0/0xb0
[   71.546753][    C0]  sock_alloc_inode+0x17/0xb0
[   71.550639][    C0]  ? sockfs_init_fs_context+0xb0/0xb0
[   71.555015][    C0]  new_inode_pseudo+0x63/0x220
[   71.558724][    C0]  __sock_create+0x129/0x900
[   71.562532][    C0]  ? wg_socket_init+0x4bb/0x930
[   71.566440][    C0]  udp_sock_create6+0x67/0x540
[   71.571248][    C0]  wg_socket_init+0x54c/0x930
[   71.575826][    C0]  ? wg_socket_init+0x930/0x930
[   71.579730][    C0]  wg_open+0x24b/0x420
[   71.583114][    C0]  __dev_open+0x252/0x400
[   71.586652][    C0]  __dev_change_flags+0x20a/0x6e0
[   71.590743][    C0]  dev_change_flags+0x82/0x1a0
[   71.594640][    C0]  do_setlink+0xae5/0x39b0
[   71.598275][    C0]  ? rtnl_newlink+0x75/0x1520
[   71.601891][    C0]  rtnl_newlink+0x1190/0x1520
[   71.605709][    C0]  ? rtnl_newlink+0x2a1/0x1520
[   71.609651][    C0]  ? rtnl_setlink+0x380/0x380
[   71.613270][    C0]  rtnetlink_rcv_msg+0x9a1/0xe10
[   71.617249][    C0]  ? rcu_lock_release+0x9/0x20
[   71.621186][    C0]  ? rcu_is_watching+0x11/0xb0
[   71.625149][    C0]  ? rcu_lock_release+0x9/0x20
[   71.629135][    C0]  ? __local_bh_enable_ip+0xe6/0x160
[   71.633276][    C0]  ? local_bh_enable+0x5/0x20
[   71.637099][    C0]  ? local_bh_enable+0x5/0x20
[   71.640740][    C0]  ? __local_bh_enable_ip+0xe6/0x160
[   71.644941][    C0]  ? __dev_queue_xmit+0x1848/0x2970
[   71.649034][    C0]  ? skb_clone+0x1f3/0x360
[   71.652609][    C0]  netlink_rcv_skb+0x185/0x390
[   71.656760][    C0]  ? rtnetlink_bind+0x80/0x80
[   71.660615][    C0]  netlink_unicast+0x7b7/0x9b0
[   71.664322][    C0]  netlink_sendmsg+0x968/0xb50
[   71.668182][    C0]  ? netlink_getsockopt+0x4f0/0x4f0
[   71.672318][    C0]  __sock_sendmsg+0x15e/0x170
[   71.676187][    C0]  __sys_sendto+0x323/0x430
[   71.680048][    C0]  __x64_sys_sendto+0xda/0xf0
[   71.683928][    C0]  do_syscall_64+0x32/0x50
[   71.687634][    C0]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   71.692636][    C0] RIP: 0033:0x7f23b2f027bc
[   71.696317][    C0] Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c=
5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0=
f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
[   71.712052][    C0] RSP: 002b:00007ffc654628e0 EFLAGS: 00000293 ORIG_RAX=
: 000000000000002c
[   71.719689][    C0] RAX: ffffffffffffffda RBX: 00007f23b3c56620 RCX: 000=
07f23b2f027bc
[   71.727574][    C0] RDX: 0000000000000020 RSI: 00007f23b3c56670 RDI: 000=
0000000000003
[   71.734042][    C0] RBP: 0000000000000000 R08: 00007ffc65462934 R09: 000=
000000000000c
[   71.740589][    C0] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000003
[   71.746882][    C0] R13: 0000000000000000 R14: 00007f23b3c56670 R15: 000=
0000000000000
[   71.753763][    C0] Kernel Offset: disabled
[   71.757459][    C0] Rebooting in 86400 seconds..

VM DIAGNOSIS:
07:49:05  Registers:
info registers vcpu 0

CPU#0
RAX=3D0000000000000030 RBX=3D0000000000000030 RCX=3D0000000000000000 RDX=3D=
00000000000003f8
RSI=3D0000000000000000 RDI=3D0000000000000020 RBP=3D00000000000003f8 RSP=3D=
ffffc90000007200
R8 =3Ddffffc0000000000 R9 =3Dfffff52000000e42 R10=3Dfffff52000000e42 R11=3D=
ffffffff83f79850
R12=3Ddffffc0000000000 R13=3D1ffffffff2acda63 R14=3Dffffffff96156de0 R15=3D=
0000000000000000
RIP=3Dffffffff83f798c8 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0000 0000000000000000 ffffffff 00c00000
CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
DS =3D0000 0000000000000000 ffffffff 00c00000
FS =3D0000 00005555604e7500 ffffffff 00c00000
GS =3D0000 ffff888020600000 ffffffff 00c00000
LDT=3D0000 0000000000000000 ffffffff 00c00000
TR =3D0040 fffffe0000003000 00004087 00008b00 DPL=3D0 TSS64-busy
GDT=3D     fffffe0000001000 0000007f
IDT=3D     fffffe0000000000 00000fff
CR0=3D80050033 CR2=3D00007ffed664f118 CR3=3D000000003ec9e000 CR4=3D00350ef0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000=20
DR6=3D00000000fffe0ff0 DR7=3D0000000000000400
EFER=3D0000000000000d01
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
Opmask00=3D0000000040410888 Opmask01=3D0000000000000fff Opmask02=3D00000000=
ffffffef Opmask03=3D0000000000000000
Opmask04=3D0000000000000000 Opmask05=3D0000000000000000 Opmask06=3D00000000=
00000000 Opmask07=3D0000000000000000
ZMM00=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000100000001 0000001900000000
ZMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83ae7
ZMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83adf
ZMM04=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83b12
ZMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83b1f
ZMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83b19
ZMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83b2d
ZMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83bb3
ZMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 00007f23b2f83c91
ZMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM12=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM13=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM14=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM15=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM16=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM17=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 2525252525252525 2525252525252525 2525252525252525 2525252525252525
ZMM18=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 00306e6170737265 0030657267367069 00306c6e74367069 00306974765f3670
ZMM19=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 6900306974765f70 6900306c6e757400 3074697300326777 0031677700306777
ZMM20=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM21=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM22=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM23=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM24=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM25=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM26=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM27=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM28=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM29=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM30=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM31=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000


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
 -ffile-prefix-map=3D/tmp/go-build1145845823=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
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
HEAD detached at 6b6b5f21aad
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
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D6b6b5f21aadcc3fc3ccd91da0b782a4307229d70 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250604-135810"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"6b6b5f21aadcc3fc3ccd91da0b782a4307=
229d70\"
/usr/bin/ld: /tmp/ccDhSuvv.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17442d2f980000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd82f68054e55cf8=
c
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dded9116588a7b73c3=
4bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D17cd6d425800=
00


