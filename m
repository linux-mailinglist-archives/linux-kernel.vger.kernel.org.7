Return-Path: <linux-kernel+bounces-868504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0D7C05596
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E88B4ED57C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070030ACF2;
	Fri, 24 Oct 2025 09:32:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A831BA3D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298325; cv=none; b=rhCX5ESxLhAg0a3lQov97ew5CLnMXVguMqabz7K9OvUisI8r0WdjGvXgC2WaJkgrZFC4VJcr0H65CZrwhySt6/4gI/HN2OwAV5SagVp9+rnhZ7zg0E52wwilibNaQMDY1Nlc7hZR6yBmuPY0X0yLfkpKrW0MW86d9WNxuTm3nEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298325; c=relaxed/simple;
	bh=QLhAbdrCeDcyaMr1aqTHEVEP3A4YPLLsN05MXMLvl58=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fXl9X5nK82fXDI+gLFysM0x6c8yEo51xwH8S+oC/Uz3bp4uClAVF5nZl9aiOJBNYbxYUDowj9GnQ+dNrUNpsY/hf395DJKjR8CfNW/I4wGQzNPXzWzgphHoNqOm1Ls76F2457QnONj/VLcBR9VYzcmCCm2tJQhrkUk78pyrxrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db5635d6so24136245ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761298322; x=1761903122;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f33cBqIbs1P/bvUtVFAzZtw/lSm851N0Pyx3c4vUn+k=;
        b=Yu/zE2NFE55oshJtkeHQwjNInL+OoVr3NAX09dw1hal+Nv7MUTW4lUWRF9bfcK9bHw
         scKj3sKrgh/0vYK3D4tLRfcfZpiZ5Z8z5/hhC0G8Gf2uvSajk3wt6kjyOIEVfVLZy31d
         i23BxhoMwDFTSd5eYyCqi0yLKX6Ey+Vb1gnZNZC/QSNobLmeU5jssCqb7lVTz4vZYa1w
         nMbTHl019vmkctHCaU4dgWdDAIP7mQ2E6D088tBrpMvxGzjrw0d05/gX/PDBU00Jp+gR
         +62NNpsQSHvXddd2C4Hlcul9oM90yXD3t/60HOrbNz0tzBK5zxF6/d5mTPDFaG34kDyd
         W5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXKfNkY1VOHSCcK81wbt7JENK5MUgwlGaArzSNAqovzknV1Tz50HrFwqmTn8lxSgSYxAm2lpes6i3C+Wf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLWTKJhG33t9FpKKomC/1TmUJohQr+VrWUdC8whnY2yDQLFMd
	U3Oi/Eng6J73gUz2SBYau9T6QUCXRZDERPvyJFA9AIr931qvhdGiRNQeEDnHn0m1Ml2ojwBhrrQ
	/zmGX0EZe/sAuVHhA0dSE6pHWSt63YknbvZkJhGKaHM/gZ2NnB20Xtlc2kRI=
X-Google-Smtp-Source: AGHT+IH+IK/Cj/eDem1DfATPVYIc5ycn0k8BTP/mBCXOj2uBmgQoXBv/JkcTwaBguLY2vvD4Ks8i2djh2qlP5/rFrrnGWIoOqoYB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380f:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-430c525f609mr435312935ab.12.1761298322466; Fri, 24 Oct 2025
 02:32:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 02:32:02 -0700
In-Reply-To: <20251024071154.COzwR%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb4792.050a0220.346f24.00b8.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ace will be fragmented on layer2 which could impact the performance. Settin=
g the MTU to 1560 would solve the problem.
[   47.395182][ T5971] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   47.416728][ T5971] device hsr_slave_0 entered promiscuous mode
[   47.423245][ T5971] device hsr_slave_1 entered promiscuous mode
[   47.471639][ T5971] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   47.480389][ T5971] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   47.489086][ T5971] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   47.497565][ T5971] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   47.513466][ T5971] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   47.520632][ T5971] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   47.528003][ T5971] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   47.535131][ T5971] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   47.561198][ T5971] 8021q: adding VLAN 0 to HW filter on device bond0
[   47.573567][   T43] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   47.582072][   T43] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   47.589977][   T43] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   47.597565][   T43] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes r=
eady
[   47.607679][ T5971] 8021q: adding VLAN 0 to HW filter on device team0
[   47.616985][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   47.625385][  T677] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   47.632487][  T677] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   47.642855][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   47.651418][  T677] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   47.658498][  T677] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   47.672523][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   47.681721][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   47.691754][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   47.702417][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   47.713153][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   47.723012][ T5971] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   47.769360][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   47.776980][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   47.788069][ T5971] 8021q: adding VLAN 0 to HW filter on device batadv0
[   47.802087][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   47.817286][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   47.825559][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   47.833747][  T786] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   47.843065][ T5971] device veth0_vlan entered promiscuous mode
[   47.853007][ T5971] device veth1_vlan entered promiscuous mode
[   47.868131][  T608] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   47.876210][  T608] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   47.884528][  T608] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   47.894414][ T5971] device veth0_macvtap entered promiscuous mode
[   47.903703][ T5971] device veth1_macvtap entered promiscuous mode
[   47.916303][ T5971] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   47.924143][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   47.932868][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   47.943246][ T5971] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   47.950987][  T677] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   47.961028][ T5971] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   47.969989][ T5971] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   47.978838][ T5971] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   47.987799][ T5971] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   48.035897][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   48.045345][    C1] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   48.053952][    C1] 1251854394 + 1856889025 cannot be represented in typ=
e 'int'
[   48.061418][    C1] CPU: 1 PID: 5984 Comm: modprobe Not tainted syzkalle=
r #0
[   48.068591][    C1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   48.078727][    C1] Call Trace:
[   48.081999][    C1]  <IRQ>
[   48.084847][    C1]  dump_stack+0xfd/0x16e
[   48.089084][    C1]  ubsan_epilogue+0xa/0x30
[   48.093473][    C1]  handle_overflow+0x192/0x1b0
[   48.098230][    C1]  ? prandom_u32+0x1d/0x1f0
[   48.102709][    C1]  ip_idents_reserve+0x14a/0x170
[   48.107672][    C1]  __ip_select_ident+0xe4/0x1c0
[   48.112497][    C1]  iptunnel_xmit+0x466/0x7b0
[   48.117065][    C1]  udp_tunnel_xmit_skb+0x1ba/0x290
[   48.122153][    C1]  geneve_xmit+0x1d05/0x2140
[   48.126729][    C1]  dev_hard_start_xmit+0x294/0x780
[   48.132192][    C1]  __dev_queue_xmit+0x1678/0x28b0
[   48.137274][    C1]  ip6_finish_output2+0x1020/0x1490
[   48.142557][    C1]  NF_HOOK+0x45/0x2c0
[   48.146551][    C1]  ? NF_HOOK+0x2c0/0x2c0
[   48.150889][    C1]  mld_sendpack+0x5f9/0xa70
[   48.155387][    C1]  mld_ifc_timer_expire+0x7e1/0x990
[   48.160579][    C1]  ? lock_acquire+0x78/0x310
[   48.165155][    C1]  ? lock_release+0x69/0x610
[   48.169820][    C1]  ? debug_object_deactivate+0x9b/0x250
[   48.175350][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   48.180456][    C1]  call_timer_fn+0x105/0x440
[   48.185031][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   48.190128][    C1]  __run_timers+0x5d8/0x7a0
[   48.194970][    C1]  ? __do_softirq+0x164/0x8ae
[   48.199635][    C1]  run_timer_softirq+0x19/0x30
[   48.204496][    C1]  __do_softirq+0x23c/0x8ae
[   48.208985][    C1]  ? asm_call_irq_on_stack+0xf/0x20
[   48.214251][    C1]  asm_call_irq_on_stack+0xf/0x20
[   48.219386][    C1]  </IRQ>
[   48.222309][    C1]  do_softirq_own_stack+0x6d/0xb0
[   48.227317][    C1]  __irq_exit_rcu+0x1e1/0x1f0
[   48.231975][    C1]  irq_exit_rcu+0x5/0x20
[   48.236201][    C1]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   48.241991][    C1]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   48.247952][    C1] RIP: 0010:xas_next_entry+0x96/0x3d0
[   48.253418][    C1] Code: b6 04 18 84 c0 0f 85 19 03 00 00 41 0f b6 2c 2=
4 31 ff 89 ee e8 1b 31 de ff 85 ed 0f 85 f5 02 00 00 4c 89 64 24 18 49 8d 4=
f 12 <48> 89 0c 24 48 c1 e9 03 48 89 4c 24 20 0f b6 04 19 84 c0 0f 85 fc
[   48.273552][    C1] RSP: 0000:ffffc900018ffc60 EFLAGS: 00000246
[   48.279869][    C1] RAX: ffffffff81918485 RBX: dffffc0000000000 RCX: fff=
fc900018ffd2a
[   48.287824][    C1] RDX: ffff888021f18000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   48.295956][    C1] RBP: 0000000000000000 R08: dffffc0000000000 R09: fff=
ff940000ad161
[   48.304003][    C1] R10: fffff940000ad161 R11: 1ffffd40000ad160 R12: fff=
f8880245a3180
[   48.312223][    C1] R13: dffffc0000000000 R14: 0000000000000000 R15: fff=
fc900018ffd18
[   48.320216][    C1]  ? xas_next_entry+0x85/0x3d0
[   48.324967][    C1]  ? unlock_page+0x17c/0x210
[   48.329645][    C1]  filemap_map_pages+0x5fe/0xa30
[   48.334573][    C1]  handle_mm_fault+0x16b8/0x2930
[   48.339498][    C1]  do_user_addr_fault+0x468/0xa50
[   48.344635][    C1]  ? asm_exc_page_fault+0x8/0x30
[   48.349551][    C1]  exc_page_fault+0x67/0x100
[   48.354134][    C1]  asm_exc_page_fault+0x1e/0x30
[   48.359062][    C1] RIP: 0033:0x7f8f0a2e0a55
[   48.363612][    C1] Code: d2 39 c1 0f 8f 7c 00 00 00 2d 80 0f 00 00 0f 8=
6 a8 fc ff ff 45 31 c0 83 e8 60 0f 8f 8d 00 00 00 0f 1f 44 00 00 c5 fe 6f 0=
4 17 <c5> fd 74 0c 16 c5 85 74 d0 c5 ed df c9 c5 fd d7 c9 ff c1 75 28 83
[   48.383203][    C1] RSP: 002b:00007ffe9e48a9e8 EFLAGS: 00010283
[   48.389369][    C1] RAX: 00000000ffffffbf RBX: 0000560d57518000 RCX: 000=
00000000003f0
[   48.397494][    C1] RDX: 0000000000000000 RSI: 00007f8f0a4003f0 RDI: 000=
07ffe9e48af9f
[   48.405577][    C1] RBP: 00007ffe9e48ab38 R08: 0000000000000000 R09: 000=
07f8f0a42fa60
[   48.413539][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[   48.421495][    C1] R13: 00007ffe9e48ab60 R14: 00007f8f0a460000 R15: 000=
0560d57519d98
[   48.429493][    C1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   48.438917][    C1] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   48.446229][    C1] CPU: 1 PID: 5984 Comm: modprobe Not tainted syzkalle=
r #0
[   48.453574][    C1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   48.463620][    C1] Call Trace:
[   48.466930][    C1]  <IRQ>
[   48.469786][    C1]  dump_stack+0xfd/0x16e
[   48.474260][    C1]  panic+0x2f0/0x9c0
[   48.478304][    C1]  check_panic_on_warn+0x95/0xe0
[   48.483324][    C1]  handle_overflow+0x192/0x1b0
[   48.488166][    C1]  ? prandom_u32+0x1d/0x1f0
[   48.492648][    C1]  ip_idents_reserve+0x14a/0x170
[   48.497566][    C1]  __ip_select_ident+0xe4/0x1c0
[   48.502403][    C1]  iptunnel_xmit+0x466/0x7b0
[   48.507007][    C1]  udp_tunnel_xmit_skb+0x1ba/0x290
[   48.512102][    C1]  geneve_xmit+0x1d05/0x2140
[   48.516699][    C1]  dev_hard_start_xmit+0x294/0x780
[   48.521904][    C1]  __dev_queue_xmit+0x1678/0x28b0
[   48.526917][    C1]  ip6_finish_output2+0x1020/0x1490
[   48.532265][    C1]  NF_HOOK+0x45/0x2c0
[   48.536362][    C1]  ? NF_HOOK+0x2c0/0x2c0
[   48.540600][    C1]  mld_sendpack+0x5f9/0xa70
[   48.545084][    C1]  mld_ifc_timer_expire+0x7e1/0x990
[   48.550256][    C1]  ? lock_acquire+0x78/0x310
[   48.554818][    C1]  ? lock_release+0x69/0x610
[   48.559386][    C1]  ? debug_object_deactivate+0x9b/0x250
[   48.564916][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   48.570159][    C1]  call_timer_fn+0x105/0x440
[   48.574730][    C1]  ? mld_gq_timer_expire+0xe0/0xe0
[   48.580362][    C1]  __run_timers+0x5d8/0x7a0
[   48.584876][    C1]  ? __do_softirq+0x164/0x8ae
[   48.589741][    C1]  run_timer_softirq+0x19/0x30
[   48.594575][    C1]  __do_softirq+0x23c/0x8ae
[   48.599107][    C1]  ? asm_call_irq_on_stack+0xf/0x20
[   48.604286][    C1]  asm_call_irq_on_stack+0xf/0x20
[   48.609288][    C1]  </IRQ>
[   48.612210][    C1]  do_softirq_own_stack+0x6d/0xb0
[   48.617294][    C1]  __irq_exit_rcu+0x1e1/0x1f0
[   48.621954][    C1]  irq_exit_rcu+0x5/0x20
[   48.626175][    C1]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   48.631799][    C1]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   48.637759][    C1] RIP: 0010:xas_next_entry+0x96/0x3d0
[   48.643107][    C1] Code: b6 04 18 84 c0 0f 85 19 03 00 00 41 0f b6 2c 2=
4 31 ff 89 ee e8 1b 31 de ff 85 ed 0f 85 f5 02 00 00 4c 89 64 24 18 49 8d 4=
f 12 <48> 89 0c 24 48 c1 e9 03 48 89 4c 24 20 0f b6 04 19 84 c0 0f 85 fc
[   48.662984][    C1] RSP: 0000:ffffc900018ffc60 EFLAGS: 00000246
[   48.669035][    C1] RAX: ffffffff81918485 RBX: dffffc0000000000 RCX: fff=
fc900018ffd2a
[   48.677198][    C1] RDX: ffff888021f18000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   48.685542][    C1] RBP: 0000000000000000 R08: dffffc0000000000 R09: fff=
ff940000ad161
[   48.693603][    C1] R10: fffff940000ad161 R11: 1ffffd40000ad160 R12: fff=
f8880245a3180
[   48.701553][    C1] R13: dffffc0000000000 R14: 0000000000000000 R15: fff=
fc900018ffd18
[   48.709709][    C1]  ? xas_next_entry+0x85/0x3d0
[   48.714730][    C1]  ? unlock_page+0x17c/0x210
[   48.719314][    C1]  filemap_map_pages+0x5fe/0xa30
[   48.724318][    C1]  handle_mm_fault+0x16b8/0x2930
[   48.729240][    C1]  do_user_addr_fault+0x468/0xa50
[   48.734236][    C1]  ? asm_exc_page_fault+0x8/0x30
[   48.739360][    C1]  exc_page_fault+0x67/0x100
[   48.743925][    C1]  asm_exc_page_fault+0x1e/0x30
[   48.748752][    C1] RIP: 0033:0x7f8f0a2e0a55
[   48.753345][    C1] Code: d2 39 c1 0f 8f 7c 00 00 00 2d 80 0f 00 00 0f 8=
6 a8 fc ff ff 45 31 c0 83 e8 60 0f 8f 8d 00 00 00 0f 1f 44 00 00 c5 fe 6f 0=
4 17 <c5> fd 74 0c 16 c5 85 74 d0 c5 ed df c9 c5 fd d7 c9 ff c1 75 28 83
[   48.773588][    C1] RSP: 002b:00007ffe9e48a9e8 EFLAGS: 00010283
[   48.779672][    C1] RAX: 00000000ffffffbf RBX: 0000560d57518000 RCX: 000=
00000000003f0
[   48.787743][    C1] RDX: 0000000000000000 RSI: 00007f8f0a4003f0 RDI: 000=
07ffe9e48af9f
[   48.796300][    C1] RBP: 00007ffe9e48ab38 R08: 0000000000000000 R09: 000=
07f8f0a42fa60
[   48.804330][    C1] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
0000000000000
[   48.812278][    C1] R13: 00007ffe9e48ab60 R14: 00007f8f0a460000 R15: 000=
0560d57519d98
[   48.820381][    C1] Kernel Offset: disabled
[   48.824731][    C1] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3457238269=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at e2beed91937
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3De2beed91937c0ace342f19a2e9afb67adb3a828a -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20250911-084951"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3De2beed91937c0ace342f19a2e9afb67adb3a828a -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20250911-084951"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3De2beed91937c0ace342f19a2e9afb67adb3a828a -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250911-084951"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e2beed91937c0ace342f19a2e9afb67adb=
3a828a\"
/usr/bin/ld: /tmp/cciE1xKJ.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D166e93e2580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D39182a54870857e=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7aef76bdb53b83d62=
a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D111d0be25800=
00


