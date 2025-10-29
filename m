Return-Path: <linux-kernel+bounces-875274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B39C18915
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E240034C152
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C741CAA7D;
	Wed, 29 Oct 2025 06:59:12 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4A30B525
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721151; cv=none; b=TkOQoySoC5L68ivHZXoag5bEPRECJcv9Dr6E2DzRlcrGSVvJfV1XkET9wUkWFWAu/LN57ENdFZv5QIRpXgGpTaVnsOOSprQLrS1bRLjijMGESBRDledvNsEsDwMKTTyrwb03+L322ribacYYRa5kHdEJQxjDGxmUWjL2JLnghhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721151; c=relaxed/simple;
	bh=eVX6KcPRFRkvwfsj8UvLJlK0rGvaobMYjQSerGqFcqo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cv+9+TmfRD2RVuUq/JUky9KWU/hmGkbBuquuctAJ23uLqDyNgvlfFastEhB6DuGrpKWnFTzPe2tBR2ns+04JldbA3tHohxAzOiaZbjuLxjz2GqlzxPrqfbv6rXLYb1HRNGmX5kk6uRQZQnXgkSiiSKgoxRG/qAOG7jz/zFYvwlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430d1adb32aso69801285ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721148; x=1762325948;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBfDEeejjYxvS8aT9LIqwsdFhMKitQcqxVABLTUZkYU=;
        b=SBU1/7nRsbYFSh9thXRi/kf0p3Z6PKDnrirTRhbB3UxnPl/AYtV55ext7sCg+Tmahj
         /6huhPvTF8rbqb/Y0c8BUHW4faBDhiC65RxfcIWkgDZVymWkrrVoaBnDEMa+nckk06CK
         Ip7bDMWrVE1yYPRsJM1yMvldt84u54utsPxvzVtsIK/aJIlWGJDtwybP/KHgvGJZEyGG
         voV3sb3E/7hIbdhAFsVFxAOAO86KlMi/UdLsppLjYuo7/BPXMuB7gvveFndDwUTOn5fz
         yf6p601cc4r6VDsuG25QdmCkBdn3tjVcKrhNyghMbEWsXhb8FsBaxuqry00ltNlWNJH/
         KuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkZmkKv2uOYQwmgjibCT/0X3WkDr0ves9k2qkb4DxH3su7qScozgxOTPjwAVdg+LsBOSud71QbKYfslpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLLM+0jGOeWfUoa8ebS31qQ7w6MRU4fHHm0ZoFMHuJ/t3cmcDq
	krg4j3LDJb/sQP8wCKDdjU6zwF0V2lUjxYGoBpv4wlSZhtEyQdxjac1g4T6bJo5JJRWIL/iQeeA
	wAMurJCU4t7zKyuj3JxccK/CNzzCg49G+nEzKshDYM0RSHfZjIdvXjzd/U8E=
X-Google-Smtp-Source: AGHT+IHYLoT2lI1mRc79jaHgSIajQVx4DaPcLm9K6LD6tCVPa451AxfTJshEUsjf1ZO5B5RQh7kDybtMbjXTimAn3lctco5jVh6/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:430:bee3:34a with SMTP id
 e9e14a558f8ab-432f903c878mr23296755ab.20.1761721148493; Tue, 28 Oct 2025
 23:59:08 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:59:08 -0700
In-Reply-To: <20251029062154.D092K%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901bb3c.050a0220.3344a1.0410.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

EV_CHANGE): bridge0: link becomes ready
[   70.519322][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link=
 becomes ready
[   70.530517][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   70.544647][ T3064] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   70.550487][ T3064] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   70.571038][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link b=
ecomes ready
[   70.589277][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link b=
ecomes ready
[   70.609215][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link b=
ecomes ready
[   70.622557][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   70.645088][ T5642] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   70.659370][ T5642] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   70.680648][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   70.693499][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link b=
ecomes ready
[   70.710380][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   70.729176][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_hsr: link be=
comes ready
[   70.735975][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   70.748332][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_hsr: link be=
comes ready
[   70.755431][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   70.767133][ T3064] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   70.851896][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   70.858310][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   70.903168][ T5642] 8021q: adding VLAN 0 to HW filter on device batadv0
[   70.924407][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_virt_wifi: link=
 becomes ready
[   70.939773][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   70.965961][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_vlan: link beco=
mes ready
[   70.979808][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   70.990815][ T5642] device veth0_vlan entered promiscuous mode
[   71.009168][ T5642] device veth1_vlan entered promiscuous mode
[   71.020626][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   71.027572][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   71.034919][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   71.050903][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_macvtap: link b=
ecomes ready
[   71.069164][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   71.077341][ T5642] device veth0_macvtap entered promiscuous mode
[   71.091361][ T5642] device veth1_macvtap entered promiscuous mode
[   71.114348][ T5642] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   71.129562][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   71.149254][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): macsec0: link becomes=
 ready
[   71.174019][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0: link =
becomes ready
[   71.182444][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   71.192075][ T5642] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   71.199436][ T5552] Bluetooth: hci0: command 0x0409 tx timeout
[   71.207401][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link =
becomes ready
[   71.216600][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   71.225130][ T5642] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   71.232611][ T5642] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   71.240594][ T5642] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   71.247798][ T5642] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   71.261221][   T18] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   71.269106][   T18] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   71.276219][   T18] -2019885640 + -807740059 cannot be represented in ty=
pe 'int'
[   71.283786][   T18] CPU: 0 PID: 18 Comm: kworker/u2:1 Not tainted syzkal=
ler #0
[   71.289828][   T18] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   71.298954][   T18] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   71.304794][   T18] Call Trace:
[   71.307563][   T18]  dump_stack+0xfd/0x16e
[   71.311161][   T18]  ubsan_epilogue+0xa/0x30
[   71.314861][   T18]  handle_overflow+0x192/0x1b0
[   71.318888][   T18]  ? prandom_u32+0x217/0x260
[   71.322642][   T18]  ip_idents_reserve+0x14a/0x170
[   71.326669][   T18]  __ip_select_ident+0xe4/0x1c0
[   71.330707][   T18]  iptunnel_xmit+0x468/0x850
[   71.334195][   T18]  udp_tunnel_xmit_skb+0x1ba/0x290
[   71.339230][   T18]  send4+0x5d4/0xaf0
[   71.342867][   T18]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   71.347693][   T18]  wg_packet_handshake_send_worker+0x16b/0x280
[   71.352663][   T18]  process_one_work+0x85e/0xff0
[   71.356884][   T18]  worker_thread+0xa9b/0x1430
[   71.360897][   T18]  ? rcu_lock_release+0x20/0x20
[   71.364935][   T18]  kthread+0x386/0x410
[   71.368482][   T18]  ? rcu_lock_release+0x20/0x20
[   71.372390][   T18]  ? kthread_blkcg+0xd0/0xd0
[   71.375781][   T18]  ret_from_fork+0x1f/0x30
[   71.379566][   T18] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   71.387217][   T18] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   71.393104][   T18] CPU: 0 PID: 18 Comm: kworker/u2:1 Not tainted syzkal=
ler #0
[   71.399114][   T18] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   71.408160][   T18] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   71.414156][   T18] Call Trace:
[   71.417188][   T18]  dump_stack+0xfd/0x16e
[   71.420967][   T18]  panic+0x2f0/0x9c0
[   71.424430][   T18]  check_panic_on_warn+0x95/0xe0
[   71.428743][   T18]  handle_overflow+0x192/0x1b0
[   71.432930][   T18]  ? prandom_u32+0x217/0x260
[   71.436898][   T18]  ip_idents_reserve+0x14a/0x170
[   71.441112][   T18]  __ip_select_ident+0xe4/0x1c0
[   71.445312][   T18]  iptunnel_xmit+0x468/0x850
[   71.449115][   T18]  udp_tunnel_xmit_skb+0x1ba/0x290
[   71.453280][   T18]  send4+0x5d4/0xaf0
[   71.456201][   T18]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   71.460527][   T18]  wg_packet_handshake_send_worker+0x16b/0x280
[   71.465615][   T18]  process_one_work+0x85e/0xff0
[   71.469572][   T18]  worker_thread+0xa9b/0x1430
[   71.473324][   T18]  ? rcu_lock_release+0x20/0x20
[   71.477283][   T18]  kthread+0x386/0x410
[   71.480523][   T18]  ? rcu_lock_release+0x20/0x20
[   71.484387][   T18]  ? kthread_blkcg+0xd0/0xd0
[   71.488208][   T18]  ret_from_fork+0x1f/0x30
[   71.492146][   T18] Kernel Offset: disabled
[   71.495730][   T18] Rebooting in 86400 seconds..

VM DIAGNOSIS:
06:58:23  Registers:
info registers vcpu 0

CPU#0
RAX=3D0000000000000035 RBX=3D0000000000000035 RCX=3D0000000000000000 RDX=3D=
00000000000003f8
RSI=3D0000000000000000 RDI=3D0000000000000020 RBP=3D00000000000003f8 RSP=3D=
ffffc900004474e0
R8 =3Ddffffc0000000000 R9 =3Dfffff52000088e9e R10=3Dfffff52000088e9e R11=3D=
ffffffff83f79a10
R12=3Ddffffc0000000000 R13=3D1ffffffff2acda63 R14=3Dffffffff96156de0 R15=3D=
0000000000000000
RIP=3Dffffffff83f79a88 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
=3D0 HLT=3D0
ES =3D0000 0000000000000000 ffffffff 00c00000
CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
DS =3D0000 0000000000000000 ffffffff 00c00000
FS =3D0000 0000000000000000 ffffffff 00c00000
GS =3D0000 ffff888020600000 ffffffff 00c00000
LDT=3D0000 0000000000000000 ffffffff 00c00000
TR =3D0040 fffffe0000003000 00004087 00008b00 DPL=3D0 TSS64-busy
GDT=3D     fffffe0000001000 0000007f
IDT=3D     fffffe0000000000 00000fff
CR0=3D80050033 CR2=3D000055ec27667138 CR3=3D0000000043634000 CR4=3D00350ef0
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
 0000000000000000 0000000000000000 f355cd647307d4c2 51d4b723dcb325af
ZMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 26195827148f8856 4d1b0056103add89
ZMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 2c6ab98a59c84769 0c19a67f179cb7b0
ZMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 98f8c731bc7af26e 50572e4e173ad50d
ZMM04=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 00000000ffffffff 00000000000000b4
ZMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000034
ZMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 23b200baf12ac9b1 29de2f777b44f240
ZMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 cf80a9126fe300a7 0000000000000000
ZMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 18ccb5714dc74210 2bba947427f4907b
ZMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 3173397400000000 1cc648d34cadc558
ZMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 aaf6f61383f4a386 0071d80388ad288b
ZMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 8923c588afb379c3 f77fbc576435674e
ZMM12=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM13=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
ZMM14=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 a54ff53a3c6ef372 bb67ae856a09e667
ZMM15=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 5be0cd191f83d9ab 9b05688c510e527f
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
 -ffile-prefix-map=3D/tmp/go-build2970195748=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/ccWtMwwi.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D12476704580000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D102bf6145800=
00


