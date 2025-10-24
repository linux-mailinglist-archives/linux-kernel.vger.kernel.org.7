Return-Path: <linux-kernel+bounces-868253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E141C04B39
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CC52501341
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429329E10B;
	Fri, 24 Oct 2025 07:22:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4584E2D3233
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290525; cv=none; b=pjl6XwK2u8Lo2XYFyGbeJVOynvw8Ryu5cWcFSPz7CMwBsC1KmpiTX+H6re1cC0Xuj0NQyM2cHhSUzzq5DpQnjExvkxa28bFw430jIpDX4+LXuo8ImcetFRZ88MDdst2yvyHuxe2KJNd23bAESxwtAz+RSwiqdKAPKYJuxaqrTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290525; c=relaxed/simple;
	bh=8hCjhy8KNhwqQafbH2UimrJYPYXw4BFzCrhy31BLZ+E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=csN9+OPbw4CnJj0H8ElTpYvMxdSZe1fa/M8jZQLaJA4VlYM/A7l/JUa1b6GJcyRaNpCzf4yh/GjUXSGSbAeruXSXcG5IzI6eyu38+2HzcM4yClSdMyjxpr4S9Rt45Pl2AticiUuKPUp/4tBraVc+1YlIcAGo6zWtZ51cZGLv3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8839f138so169216739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761290522; x=1761895322;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNCCY2wlckldqr+nNGFVOFWLihRS3wAHLWt4/NqNtHQ=;
        b=IGg3e7F1mSeU3gCnY4hUSCgF4Fsog/+tafxfOEDgrhY2mhuVGDtY5hZwE42hLAh+nT
         niac3wFQN6DKH/w1kKcdU8DQ58bPNsoMZnlK0YkNQugOAVk5wRZ08a4v/aVNGmtvs2TT
         os7JLtX+hB+hTFGYYrDQpecH8H+rmCcobhA7o7TMgEEQOxDRD1KOn/ZSyzlt8QCLriML
         Wtz97pNs7NeK6t3bEPRc1/cO6Z/MVc27oy2JXdukgq3SCAJ7N/kgcLZcdcOOv0nOZpE1
         cezvI4ZGwUTMY4JotwuEpXsPYRVYStLRz7CxvJoP6lTVFgmrms5TkdB9zhE9gZetx5xM
         CU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWewhDU1YvZ3aFDKfp2267gemk7ZP9OpQfDlE+Luv3dMS3Nhe8Mbu0xe9c/L5DEwajGjNDiFHh1SZfkyO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+kJItc4DB+fT3Gc5U0ByFjt0kzbCoHVgv6CVv7JtSe3efg6RV
	uXz0JS71TaM96zaktEsZwf1ghA7gbODuMIhVBdcM2aTqjCwjs2/xlOqpmjXn0sOdE7tnyQ9QMJL
	C4HI+OySGo8uWJFsuCcr0FkM3MwQS74nwKEMEhwZ3EOj7y/1FwQL8HY9Fh7U=
X-Google-Smtp-Source: AGHT+IG6uqcrA1niZ7tT0WM6du/pbabj+4KbZhUdxwVYKJYa7FGnzNWRxPluQhgdkAvqFhG91WDBn7spRDdij4duoIdeuZv8LGRp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f0b:b0:431:d7da:ee5d with SMTP id
 e9e14a558f8ab-431ebe040c0mr18934665ab.9.1761290522390; Fri, 24 Oct 2025
 00:22:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:22:02 -0700
In-Reply-To: <20251024071150.SJlVy%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb291a.050a0220.346f24.00ab.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 T5709] bridge0: port 1(bridge_slave_0) entered forwarding state
[   68.240298][ T5709] 8021q: adding VLAN 0 to HW filter on device bond0
[   68.252314][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   68.259280][ T3052] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   68.266321][ T3052] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   68.273111][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes r=
eady
[   68.283113][ T5709] 8021q: adding VLAN 0 to HW filter on device team0
[   68.292693][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   68.299864][ T3052] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   68.306738][ T3052] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   68.323464][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   68.330362][ T3052] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   68.336215][ T3052] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   68.345510][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   68.360723][ T5709] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   68.370569][ T5709] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   68.383585][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   68.390265][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   68.397595][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   68.404843][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   68.419136][ T3052] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   68.475464][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   68.482714][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   68.492279][ T5709] 8021q: adding VLAN 0 to HW filter on device batadv0
[   68.504284][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   68.518322][ T5709] device veth0_vlan entered promiscuous mode
[   68.524533][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   68.532452][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   68.538937][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   68.548991][ T5709] device veth1_vlan entered promiscuous mode
[   68.561923][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   68.577076][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   68.584768][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   68.593467][ T5709] device veth0_macvtap entered promiscuous mode
[   68.600185][ T5709] device veth1_macvtap entered promiscuous mode
[   68.612225][ T5709] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   68.618206][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   68.627196][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   68.636160][ T5709] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   68.642694][ T3020] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   68.650882][ T5709] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.658395][ T5709] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.666616][ T5709] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.674870][ T5709] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.687772][ T3020] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   68.695596][ T3020] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   68.703028][ T3020] 1496745227 + 1827093953 cannot be represented in typ=
e 'int'
[   68.710244][ T3020] CPU: 0 PID: 3020 Comm: kworker/u2:4 Not tainted syzk=
aller #0
[   68.716579][ T3020] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   68.725798][ T3020] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   68.731523][ T3020] Call Trace:
[   68.734230][ T3020]  dump_stack+0xfd/0x16e
[   68.737665][ T3020]  ubsan_epilogue+0xa/0x30
[   68.741273][ T3020]  handle_overflow+0x192/0x1b0
[   68.745235][ T3020]  ? prandom_u32+0x217/0x260
[   68.748968][ T3020]  ip_idents_reserve+0x14a/0x170
[   68.753042][ T3020]  __ip_select_ident+0xe4/0x1c0
[   68.757100][ T3020]  iptunnel_xmit+0x468/0x850
[   68.760939][ T3020]  udp_tunnel_xmit_skb+0x1ba/0x290
[   68.765181][ T3020]  send4+0x5d4/0xaf0
[   68.768350][ T3020]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   68.772983][ T3020]  wg_packet_handshake_send_worker+0x16b/0x280
[   68.778059][ T3020]  process_one_work+0x85e/0xff0
[   68.782159][ T3020]  worker_thread+0xa9b/0x1430
[   68.786018][ T3020]  ? rcu_lock_release+0x20/0x20
[   68.790096][ T3020]  kthread+0x386/0x410
[   68.793572][ T3020]  ? rcu_lock_release+0x20/0x20
[   68.797547][ T3020]  ? kthread_blkcg+0xd0/0xd0
[   68.801233][ T3020]  ret_from_fork+0x1f/0x30
[   68.805017][ T3020] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   68.812880][ T3020] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   68.818697][ T3020] CPU: 0 PID: 3020 Comm: kworker/u2:4 Not tainted syzk=
aller #0
[   68.824803][ T3020] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   68.833531][ T3020] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   68.839263][ T3020] Call Trace:
[   68.841987][ T3020]  dump_stack+0xfd/0x16e
[   68.845483][ T3020]  panic+0x2f0/0x9c0
[   68.848723][ T3020]  check_panic_on_warn+0x95/0xe0
[   68.852928][ T3020]  handle_overflow+0x192/0x1b0
[   68.856879][ T3020]  ? prandom_u32+0x217/0x260
[   68.860645][ T3020]  ip_idents_reserve+0x14a/0x170
[   68.864734][ T3020]  __ip_select_ident+0xe4/0x1c0
[   68.868721][ T3020]  iptunnel_xmit+0x468/0x850
[   68.872545][ T3020]  udp_tunnel_xmit_skb+0x1ba/0x290
[   68.876778][ T3020]  send4+0x5d4/0xaf0
[   68.879994][ T3020]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   68.884597][ T3020]  wg_packet_handshake_send_worker+0x16b/0x280
[   68.889687][ T3020]  process_one_work+0x85e/0xff0
[   68.893658][ T3020]  worker_thread+0xa9b/0x1430
[   68.897487][ T3020]  ? rcu_lock_release+0x20/0x20
[   68.901443][ T3020]  kthread+0x386/0x410
[   68.904823][ T3020]  ? rcu_lock_release+0x20/0x20
[   68.908761][ T3020]  ? kthread_blkcg+0xd0/0xd0
[   68.912531][ T3020]  ret_from_fork+0x1f/0x30
[   68.916474][ T3020] Kernel Offset: disabled
[   68.920027][ T3020] Rebooting in 86400 seconds..

VM DIAGNOSIS:
07:21:42  Registers:
info registers vcpu 0

CPU#0
RAX=3D1ffffffff2c2d760 RBX=3D00000000000003fd RCX=3D0000000000000000 RDX=3D=
00000000000003fd
RSI=3D0000000000000000 RDI=3D0000000000000020 RBP=3D0000000000000020 RSP=3D=
ffffc900018d7488
R8 =3Ddffffc0000000000 R9 =3Dfffff5200031ae9e R10=3Dfffff5200031ae9e R11=3D=
ffffffff83f6a420
R12=3Ddffffc0000000000 R13=3D1ffffffff2ad0463 R14=3Dffffffff9616bde0 R15=3D=
0000000000000000
RIP=3Dffffffff83f6a493 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
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
CR0=3D80050033 CR2=3D00007f70fa315e9c CR3=3D00000000552ec000 CR4=3D00350ef0
DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000 DR3=3D=
0000000000000000=20
DR6=3D00000000fffe0ff0 DR7=3D0000000000000400
EFER=3D0000000000000d01
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
Opmask00=3D0000000004222200 Opmask01=3D0000000000000fff Opmask02=3D00000000=
ffffffef Opmask03=3D0000000000000000
Opmask04=3D0000000000000000 Opmask05=3D0000000000000000 Opmask06=3D00000000=
00000000 Opmask07=3D0000000000000000
ZMM00=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 cdbdb4c6f9b3cfa9 ccfdd53f3940cda9
ZMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 61f8e5020c5491fa 26bc4e1f9a76504d
ZMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 d36be18d52e74008 92e0425df8168802
ZMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 646f3db649b453b8 e19fc6320e65a175
ZMM04=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 00000000ffffffff 00000000000000b4
ZMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000034
ZMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 b7184e26892817da 642e11a230cac1df
ZMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 027c24cb4c152817 0000000000000000
ZMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 64b81aac9d6a7288 bca2e73a631a5a4e
ZMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 8e994ecd00000000 f2462c1638d210f8
ZMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 b60ba1988284cefc 87c3fed8a05ffd9a
ZMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 eae31e2d506dbe72 ca832c4f00373649
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
 6c6c255b20642523 00202c0028732520 3e2d205d736d756c 6c255b2064252300
ZMM19=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 4949005b05410006 000509000d560005 1b08055d56485049 49005b0541000600
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
 -ffile-prefix-map=3D/tmp/go-build1635881792=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 001c90610fb
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D001c90610fb2f2ac7cbbc9cd6af3f547b821a8ad -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20250926-171341"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D001c90610fb2f2ac7cbbc9cd6af3f547b821a8ad -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20250926-171341"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D001c90610fb2f2ac7cbbc9cd6af3f547b821a8ad -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250926-171341"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"001c90610fb2f2ac7cbbc9cd6af3f547b8=
21a8ad\"
/usr/bin/ld: /tmp/ccZqxKJx.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11068c92580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7c6f4ecbfb251fb
dashboard link: https://syzkaller.appspot.com/bug?extid=3D30b53487d00b4f7f0=
922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D144e63cd9800=
00


