Return-Path: <linux-kernel+bounces-875346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAEAC18BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8AF4E387A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6668930F93A;
	Wed, 29 Oct 2025 07:43:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6392330101A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723785; cv=none; b=gzeAibdCBYvD8oPHVZZz8DTlKk2L8IXT2N4Q/QrCsx8FXseHjv1n9fEz/bMP/DOd41Rn+jCqkLUXQZu+Idn0Lztw1FqE3Cv+sxztDIimAE/YQrDD5PFWOIUfq12koS4przjn6Zz/0ImHNTat2Y1DOPvfgeisqq6H29NPCCDlwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723785; c=relaxed/simple;
	bh=6KnledUjZjMzCYFgTePJHJMrKsAnYFOkECJeqAdvfTg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SFABRFE17ZwKAy/hK6dgFj5a0ZQQlJRvy9EosPjrsrSU2lL6aWjAxB51mWI9X8O1s2ZHzPiFOhtaQFTJ28BOS9hqmE/BJY9U47uMq3/EgDrlD+9R+mdO69KK0FPHIiNklFXeY4Ms9yHaM5T8ner57iC1e+/UQKSRKBR6TFEkPIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e7ece2ff4so2164304439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723781; x=1762328581;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdJiNmBT34YeZ6G47mFcuULOqKHfUt7KNuvyFohwWLg=;
        b=cRx3iZRuqVoM2FOvGWphcq7Rw+NMCru161OCS73bNWW3sYa17GyF5sjvyoEyzn5UEt
         PxDUhRmFa7FDZd8GdLZen7EVchukMvN3dyIDke89TNeXSbMmQOCFluR6aZxVQ5tethYG
         L3xnQ+tnMlPpnPhbELZ7HrGa/Enhx0M1VDikoejnU7gZjXiyMDL/RJk7ffbNh6JQGF6G
         VeV1iUqdxK+dnWCY4VH2JWevzx3jLw0bKuYSgkjJY5mSqvMUrOyFzTUSktM+bk02rq/U
         jADTkWdiCI1or0OR9QVyIfoU+XiRQaur47Cx+oY1GOPzoVQhLXo/kItSEhNfzC2IGMpM
         c6rg==
X-Forwarded-Encrypted: i=1; AJvYcCUJVlhSf+mkTwqcCcUlocWPE2XPr+QJ0pDX78EJEeHhYLVx8A5LGs8BQSWA+la+k716yg+xtpSnc2or7xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbdXf4xxVmlrEugfOPsOEdJiOaaKWNPRV34AwM/wf2elzAelwf
	FvzeUkI22FlUva3lzYWk/vvgrZC17QHWmzkmmLEkCZJrW4BKexHnpRUcEfhWrk17mDC7mhhgOA9
	JCHggP2jd9MFAoxLxnuwe+MbUu6e3zazrbamr7gdelC+jONqtM6jlCWG1YWQ=
X-Google-Smtp-Source: AGHT+IFYbRJavNzbGqER2hc7C6l4gnVWcQO1YoUpIj9NcpyjCcma+j7D4Q1+LnWMb1ARWBNQYrvituXT1PDsiot/AYsS3K2C9kjz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48f:b0:945:ab31:b274 with SMTP id
 ca18e2360f4ac-945c98c95e0mr283581739f.18.1761723781582; Wed, 29 Oct 2025
 00:43:01 -0700 (PDT)
Date: Wed, 29 Oct 2025 00:43:01 -0700
In-Reply-To: <20251029062152.Ai6wl%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901c585.050a0220.32483.0201.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

] bridge0: port 2(bridge_slave_1) entered disabled state
[   56.957882][ T6076] 8021q: adding VLAN 0 to HW filter on device bond0
[   56.968605][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes r=
eady
[   56.976718][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   56.985854][ T6076] 8021q: adding VLAN 0 to HW filter on device team0
[   57.000775][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link=
 becomes ready
[   57.009397][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   57.017915][   T23] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   57.024986][   T23] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   57.034664][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link=
 becomes ready
[   57.043651][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   57.052353][   T23] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   57.059422][   T23] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   57.069264][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link b=
ecomes ready
[   57.086208][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link b=
ecomes ready
[   57.096392][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link b=
ecomes ready
[   57.105116][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   57.113880][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   57.128986][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link b=
ecomes ready
[   57.137517][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   57.148336][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_hsr: link be=
comes ready
[   57.156564][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   57.167288][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_hsr: link be=
comes ready
[   57.175546][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   57.185362][ T6076] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   57.245154][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   57.253095][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   57.262418][ T6076] 8021q: adding VLAN 0 to HW filter on device batadv0
[   57.280281][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_virt_wifi: link=
 becomes ready
[   57.289126][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   57.310768][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_vlan: link beco=
mes ready
[   57.319606][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   57.328599][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   57.336290][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   57.345386][ T6076] device veth0_vlan entered promiscuous mode
[   57.356188][ T6076] device veth1_vlan entered promiscuous mode
[   57.380237][ T6076] device veth0_macvtap entered promiscuous mode
[   57.388136][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   57.397218][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   57.405258][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_macvtap: link b=
ecomes ready
[   57.414356][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   57.422971][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   57.434451][ T6076] device veth1_macvtap entered promiscuous mode
[   57.451925][ T6076] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   57.459716][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): macsec0: link becomes=
 ready
[   57.467942][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0: link =
becomes ready
[   57.476921][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   57.487661][ T6076] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   57.497109][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link =
becomes ready
[   57.505841][   T23] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   57.515082][ T6076] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.524045][ T6076] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.532999][ T6076] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.542687][ T6076] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   57.596174][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   57.605482][    C1] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   57.614205][    C1] 1648931972 + 931318806 cannot be represented in type=
 'int'
[   57.621709][    C1] CPU: 1 PID: 5335 Comm: udevd Not tainted syzkaller #=
0
[   57.628644][    C1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   57.636275][ T6103] IPVS: ftp: loaded support on port[0] =3D 21
[   57.638698][    C1] Call Trace:
[   57.647934][    C1]  <IRQ>
[   57.650792][    C1]  dump_stack+0xfd/0x16e
[   57.655044][    C1]  ubsan_epilogue+0xa/0x30
[   57.659458][    C1]  handle_overflow+0x192/0x1b0
[   57.664231][    C1]  ip_idents_reserve+0x14a/0x170
[   57.669170][    C1]  __ip_select_ident+0xe4/0x1c0
[   57.674024][    C1]  iptunnel_xmit+0x468/0x850
[   57.678608][    C1]  udp_tunnel_xmit_skb+0x1ba/0x290
[   57.683784][    C1]  geneve_xmit+0x1d03/0x2130
[   57.688362][    C1]  dev_hard_start_xmit+0x2a8/0x7f0
[   57.693468][    C1]  __dev_queue_xmit+0x1690/0x2970
[   57.698490][    C1]  ip6_finish_output2+0x101e/0x1490
[   57.703901][    C1]  NF_HOOK+0x45/0x2c0
[   57.707879][    C1]  ? NF_HOOK+0x2c0/0x2c0
[   57.712114][    C1]  mld_sendpack+0x5f7/0xa60
[   57.716612][    C1]  mld_ifc_timer_expire+0x7e1/0x990
[   57.721953][    C1]  ? lock_acquire+0x78/0x330
[   57.726523][    C1]  ? lock_release+0x69/0x640
[   57.731103][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   57.736194][    C1]  call_timer_fn+0x103/0x490
[   57.740767][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   57.745873][    C1]  __run_timers+0x5d8/0x7a0
[   57.750375][    C1]  run_timer_softirq+0x63/0xf0
[   57.755140][    C1]  __do_softirq+0x267/0x92e
[   57.759637][    C1]  ? asm_call_irq_on_stack+0xf/0x20
[   57.764814][    C1]  asm_call_irq_on_stack+0xf/0x20
[   57.769809][    C1]  </IRQ>
[   57.772727][    C1]  do_softirq_own_stack+0x9b/0xe0
[   57.777734][    C1]  __irq_exit_rcu+0x227/0x230
[   57.782383][    C1]  irq_exit_rcu+0x5/0x20
[   57.786602][    C1]  sysvec_apic_timer_interrupt+0xea/0x100
[   57.792290][    C1]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   57.798260][    C1] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60
[   57.804302][    C1] Code: 66 2e 0f 1f 84 00 00 00 00 00 be 0d 00 00 00 4=
8 c7 c7 20 b4 54 8b e8 8f 64 3e 00 c3 cc cc cc cc 00 00 cc cc 00 00 cc cc 0=
0 00 <48> 8b 04 24 65 48 8b 0d 34 d7 90 7e 65 8b 15 39 d7 90 7e f7 c2 00
[   57.823981][    C1] RSP: 0018:ffffc90000f5fbe8 EFLAGS: 00000287
[   57.830031][    C1] RAX: ffffffff8354fa11 RBX: ffff8880242ccfda RCX: 000=
0000000000000
[   57.837990][    C1] RDX: ffff88802e700000 RSI: 000000000000000e RDI: 000=
000000000005e
[   57.845980][    C1] RBP: 000000000000000e R08: 0000000059ee1630 R09: 000=
0000004ea9dbc
[   57.854015][    C1] R10: 00000000e66b8ec4 R11: 1ffffffff1964e1d R12: 000=
000000000002f
[   57.862094][    C1] R13: 0000000000000023 R14: 0000000000000000 R15: fff=
f888019809300
[   57.870056][    C1]  ? tomoyo_encode2+0x261/0x480
[   57.874883][    C1]  tomoyo_encode2+0x26c/0x480
[   57.879536][    C1]  tomoyo_realpath_from_path+0x5ce/0x620
[   57.885172][    C1]  tomoyo_path_perm+0x15b/0x450
[   57.890017][    C1]  security_inode_getattr+0xd2/0x130
[   57.895302][    C1]  __x64_sys_newfstat+0xa7/0x160
[   57.900235][    C1]  do_syscall_64+0x34/0x50
[   57.904801][    C1]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   57.910696][    C1] RIP: 0033:0x7f14545d9ad7
[   57.915097][    C1] Code: 73 01 c3 48 8b 0d 21 f3 0d 00 f7 d8 64 89 01 4=
8 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 05 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8
[   57.934686][    C1] RSP: 002b:00007ffe7f42e5c8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000005
[   57.943080][    C1] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 000=
07f14545d9ad7
[   57.951032][    C1] RDX: 0000000000090800 RSI: 00007ffe7f42e5d0 RDI: 000=
000000000000d
[   57.958980][    C1] RBP: 00007ffe7f42e5d0 R08: 0000000000000000 R09: 000=
0000000000001
[   57.966947][    C1] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
055a2452227b0
[   57.974897][    C1] R13: 00000000000000ff R14: 000055a2354e0be0 R15: 000=
07ffe7f42e8f0
[   57.982917][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   57.992234][    C1] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   57.999416][    C1] CPU: 1 PID: 5335 Comm: udevd Not tainted syzkaller #=
0
[   58.006329][    C1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   58.016454][    C1] Call Trace:
[   58.019807][    C1]  <IRQ>
[   58.022646][    C1]  dump_stack+0xfd/0x16e
[   58.026862][    C1]  panic+0x2f0/0x9c0
[   58.030733][    C1]  check_panic_on_warn+0x95/0xe0
[   58.035656][    C1]  handle_overflow+0x192/0x1b0
[   58.040394][    C1]  ip_idents_reserve+0x14a/0x170
[   58.045333][    C1]  __ip_select_ident+0xe4/0x1c0
[   58.050526][    C1]  iptunnel_xmit+0x468/0x850
[   58.055096][    C1]  udp_tunnel_xmit_skb+0x1ba/0x290
[   58.060281][    C1]  geneve_xmit+0x1d03/0x2130
[   58.064858][    C1]  dev_hard_start_xmit+0x2a8/0x7f0
[   58.069947][    C1]  __dev_queue_xmit+0x1690/0x2970
[   58.074997][    C1]  ip6_finish_output2+0x101e/0x1490
[   58.080172][    C1]  NF_HOOK+0x45/0x2c0
[   58.084137][    C1]  ? NF_HOOK+0x2c0/0x2c0
[   58.088358][    C1]  mld_sendpack+0x5f7/0xa60
[   58.092843][    C1]  mld_ifc_timer_expire+0x7e1/0x990
[   58.098027][    C1]  ? lock_acquire+0x78/0x330
[   58.102587][    C1]  ? lock_release+0x69/0x640
[   58.107152][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   58.112240][    C1]  call_timer_fn+0x103/0x490
[   58.116802][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   58.121880][    C1]  __run_timers+0x5d8/0x7a0
[   58.126446][    C1]  run_timer_softirq+0x63/0xf0
[   58.131181][    C1]  __do_softirq+0x267/0x92e
[   58.135655][    C1]  ? asm_call_irq_on_stack+0xf/0x20
[   58.140924][    C1]  asm_call_irq_on_stack+0xf/0x20
[   58.146007][    C1]  </IRQ>
[   58.148951][    C1]  do_softirq_own_stack+0x9b/0xe0
[   58.153948][    C1]  __irq_exit_rcu+0x227/0x230
[   58.158601][    C1]  irq_exit_rcu+0x5/0x20
[   58.162816][    C1]  sysvec_apic_timer_interrupt+0xea/0x100
[   58.168517][    C1]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   58.174470][    C1] RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60
[   58.180507][    C1] Code: 66 2e 0f 1f 84 00 00 00 00 00 be 0d 00 00 00 4=
8 c7 c7 20 b4 54 8b e8 8f 64 3e 00 c3 cc cc cc cc 00 00 cc cc 00 00 cc cc 0=
0 00 <48> 8b 04 24 65 48 8b 0d 34 d7 90 7e 65 8b 15 39 d7 90 7e f7 c2 00
[   58.200096][    C1] RSP: 0018:ffffc90000f5fbe8 EFLAGS: 00000287
[   58.206224][    C1] RAX: ffffffff8354fa11 RBX: ffff8880242ccfda RCX: 000=
0000000000000
[   58.214171][    C1] RDX: ffff88802e700000 RSI: 000000000000000e RDI: 000=
000000000005e
[   58.222116][    C1] RBP: 000000000000000e R08: 0000000059ee1630 R09: 000=
0000004ea9dbc
[   58.230069][    C1] R10: 00000000e66b8ec4 R11: 1ffffffff1964e1d R12: 000=
000000000002f
[   58.238112][    C1] R13: 0000000000000023 R14: 0000000000000000 R15: fff=
f888019809300
[   58.246077][    C1]  ? tomoyo_encode2+0x261/0x480
[   58.250921][    C1]  tomoyo_encode2+0x26c/0x480
[   58.255576][    C1]  tomoyo_realpath_from_path+0x5ce/0x620
[   58.261186][    C1]  tomoyo_path_perm+0x15b/0x450
[   58.266035][    C1]  security_inode_getattr+0xd2/0x130
[   58.271303][    C1]  __x64_sys_newfstat+0xa7/0x160
[   58.276216][    C1]  do_syscall_64+0x34/0x50
[   58.280633][    C1]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   58.286497][    C1] RIP: 0033:0x7f14545d9ad7
[   58.290886][    C1] Code: 73 01 c3 48 8b 0d 21 f3 0d 00 f7 d8 64 89 01 4=
8 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 05 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8
[   58.310729][    C1] RSP: 002b:00007ffe7f42e5c8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000005
[   58.319116][    C1] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 000=
07f14545d9ad7
[   58.327065][    C1] RDX: 0000000000090800 RSI: 00007ffe7f42e5d0 RDI: 000=
000000000000d
[   58.335014][    C1] RBP: 00007ffe7f42e5d0 R08: 0000000000000000 R09: 000=
0000000000001
[   58.342967][    C1] R10: 0000000000000000 R11: 0000000000000202 R12: 000=
055a2452227b0
[   58.350913][    C1] R13: 00000000000000ff R14: 000055a2354e0be0 R15: 000=
07ffe7f42e8f0
[   58.359252][    C1] Kernel Offset: disabled
[   58.363605][    C1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3025266266=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at b6605ba8b96
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Db6605ba8b96835063c5eb766c38d27fac98b84d4 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251013-102005"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Db6605ba8b96835063c5eb766c38d27fac98b84d4 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251013-102005"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Db6605ba8b96835063c5eb766c38d27fac98b84d4 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251013-102005"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"b6605ba8b96835063c5eb766c38d27fac9=
8b84d4\"
/usr/bin/ld: /tmp/ccYc8exG.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D13f7f614580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6e4052b2d7feb09=
2
dashboard link: https://syzkaller.appspot.com/bug?extid=3D77026564530dbc29b=
854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13cbf6145800=
00


