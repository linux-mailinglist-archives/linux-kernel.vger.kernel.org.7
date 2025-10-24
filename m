Return-Path: <linux-kernel+bounces-868287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 89121C04C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C711C35A69D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41F62E8DFA;
	Fri, 24 Oct 2025 07:41:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3032E764E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291670; cv=none; b=nOSpvZIGJcbYhS4QXZ9m/jMpFquRpiWtjdX7LTVmWyNqAYN/ahTcvaEzkD7eO/Tu4yFqWnIG72s4fmEuX+0aXlN30jpRAzVEA+YwNt2PRGbc1zs2Tpu/iHSBEXeBUdYH7t/5uoA8U2yo6jieBA1F7CA3pMRSjzqmuEVyIVrX4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291670; c=relaxed/simple;
	bh=lzpaUplrCHF9olKACFhJg6dFyfdBL5Fslceg8xxCgmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QO+y76ggA8Hv+30wRHyaYTGFIUT+e0PNQKsomVUaIIq/YkNi/+Q1TSS+fXfhw0l7FOdIOA81IVtBa/RJSzjmEKnXKHT3QqeeyA/T6mcFzJtmy00c5D8C8JRqlFQjTdSdYuY7jab4N6wp2clmXs5FJtrr/ByvVXbXJ5eQcD2t+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431d84fdb91so51078695ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761291667; x=1761896467;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLcjvQzS/DKCv60hZAIV5yiYMhGV7OOllvxKnrvZi1E=;
        b=PQIK5C+rkXxUX886FaDX6qPuL6idV1eqI6EsD6PgVOjeR8mkkJSpCIA1Ao/7ZNvdD6
         qTqyLQjR+Dtem7emm2rd8i2+BzSZoSfs6Qa5M+6qmMqxmuzz5piGvc9krsGqISOR90iR
         bQ5c/2o/PejPl8crNvK+zd0P6pjf44jnKVcSEEjfIRLpFJ5JKPF4F9kfMpMdbMqnx1JZ
         Uixp9H2qiBnuoTNy5z2UGH6vr4gTxbDJn55jbqSXGMlLWzT88Prl2xJbrdkmx7XHCsvs
         oG/dp7Liq+J+cRcOWkuBABmDIixpVi9IGHjx1oPWTYJQnD4vGy4XFk4XnO+LL/26VbX9
         Wn5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2jbxA3GP6toHuoZWjyd9sLw7VzmSS36IEqUM27nMb1NqRp757j+Pdsc/EZ5VzD1XsK6yaF/7NQlQ3BBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPcsERngxhEIpYrcd345VT/vokDDW+j+N0LgcFwR6b3KOSK6U
	R3u8VDzP1EXFTf7qspOz2q66WPSradYdxq5IptTgJV+qCXMxEL5S6FcrdHBcxJfIMg2HTMMoZ6w
	0ZuKYBxrzAE0aTyC74kwg5+4GQPqudUCpSNUNm/Ck73xOfuZy1TUPF4Kk/2I=
X-Google-Smtp-Source: AGHT+IGuxP+fTijy8r5756Oj57hYHsoFLcHiukETuSPqCYIU81UMrlVOXpuwpQ4c6c3pKVVco4lCxywlk7VkojmpxUQM9SxgrnB3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348e:b0:425:951f:52fa with SMTP id
 e9e14a558f8ab-431dc169e8fmr81664135ab.14.1761291667577; Fri, 24 Oct 2025
 00:41:07 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:41:07 -0700
In-Reply-To: <20251024071154.8nS9W%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb2d93.a70a0220.3bf6c6.014a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

im0 netdevsim3: renamed from eth3
[   65.498461][ T5570] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   65.504458][ T5570] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   65.510598][ T5570] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   65.516333][ T5570] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   65.547747][ T5570] 8021q: adding VLAN 0 to HW filter on device bond0
[   65.558428][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   65.566437][ T3031] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   65.573305][ T3031] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   65.581116][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes r=
eady
[   65.590723][ T5570] 8021q: adding VLAN 0 to HW filter on device team0
[   65.605138][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   65.617739][ T3031] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   65.624264][ T3031] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   65.632411][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   65.641431][ T3031] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   65.647421][ T3031] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   65.665596][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   65.675817][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   65.688046][ T5570] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   65.699422][ T5570] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   65.712142][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   65.719124][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   65.726668][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   65.743599][ T3031] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   65.795967][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   65.803090][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   65.812250][ T5570] 8021q: adding VLAN 0 to HW filter on device batadv0
[   65.826943][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   65.840970][ T5570] device veth0_vlan entered promiscuous mode
[   65.846214][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   65.853729][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   65.859777][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   65.869781][ T5570] device veth1_vlan entered promiscuous mode
[   65.876428][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   65.893202][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   65.901517][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   65.909785][ T5570] device veth0_macvtap entered promiscuous mode
[   65.919316][ T5570] device veth1_macvtap entered promiscuous mode
[   65.932694][ T5570] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   65.938869][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   65.947434][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   65.956647][ T5570] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   65.963867][ T3061] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   65.973107][ T5570] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   65.981275][ T5570] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   65.988383][ T5570] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   65.996540][ T5570] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   66.009412][ T3061] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   66.017125][ T3061] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   66.024329][ T3061] -163290563 + -2098288399 cannot be represented in ty=
pe 'int'
[   66.031757][ T3061] CPU: 0 PID: 3061 Comm: kworker/u2:8 Not tainted syzk=
aller #0
[   66.038134][ T3061] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   66.048130][ T3061] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   66.053893][ T3061] Call Trace:
[   66.057427][ T3061]  dump_stack+0xfd/0x16e
[   66.060951][ T3061]  ubsan_epilogue+0xa/0x30
[   66.064639][ T3061]  handle_overflow+0x192/0x1b0
[   66.068437][ T3061]  ? prandom_u32+0x217/0x260
[   66.072280][ T3061]  ip_idents_reserve+0x14a/0x170
[   66.076197][ T3061]  __ip_select_ident+0xe4/0x1c0
[   66.080020][ T3061]  iptunnel_xmit+0x468/0x850
[   66.083815][ T3061]  udp_tunnel_xmit_skb+0x1ba/0x290
[   66.088108][ T3061]  send4+0x5d4/0xaf0
[   66.091339][ T3061]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   66.095883][ T3061]  wg_packet_handshake_send_worker+0x16b/0x280
[   66.100935][ T3061]  process_one_work+0x85e/0xff0
[   66.104997][ T3061]  worker_thread+0xa9b/0x1430
[   66.108751][ T3061]  ? lock_release+0x69/0x640
[   66.112517][ T3061]  ? rcu_lock_release+0x20/0x20
[   66.116506][ T3061]  kthread+0x386/0x410
[   66.119891][ T3061]  ? rcu_lock_release+0x20/0x20
[   66.124100][ T3061]  ? kthread_blkcg+0xd0/0xd0
[   66.127889][ T3061]  ret_from_fork+0x1f/0x30
[   66.131580][ T3061] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   66.138816][ T3061] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   66.144565][ T3061] CPU: 0 PID: 3061 Comm: kworker/u2:8 Not tainted syzk=
aller #0
[   66.150499][ T3061] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   66.159482][ T3061] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   66.165195][ T3061] Call Trace:
[   66.167897][ T3061]  dump_stack+0xfd/0x16e
[   66.171471][ T3061]  panic+0x2f0/0x9c0
[   66.174602][ T3061]  check_panic_on_warn+0x95/0xe0
[   66.178727][ T3061]  handle_overflow+0x192/0x1b0
[   66.182743][ T3061]  ? prandom_u32+0x217/0x260
[   66.186508][ T3061]  ip_idents_reserve+0x14a/0x170
[   66.190664][ T3061]  __ip_select_ident+0xe4/0x1c0
[   66.194678][ T3061]  iptunnel_xmit+0x468/0x850
[   66.198320][ T3061]  udp_tunnel_xmit_skb+0x1ba/0x290
[   66.202576][ T3061]  send4+0x5d4/0xaf0
[   66.205845][ T3061]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   66.210583][ T3061]  wg_packet_handshake_send_worker+0x16b/0x280
[   66.215775][ T3061]  process_one_work+0x85e/0xff0
[   66.219866][ T3061]  worker_thread+0xa9b/0x1430
[   66.223801][ T3061]  ? lock_release+0x69/0x640
[   66.227824][ T3061]  ? rcu_lock_release+0x20/0x20
[   66.231900][ T3061]  kthread+0x386/0x410
[   66.235406][ T3061]  ? rcu_lock_release+0x20/0x20
[   66.239449][ T3061]  ? kthread_blkcg+0xd0/0xd0
[   66.243419][ T3061]  ret_from_fork+0x1f/0x30
[   66.247485][ T3061] Kernel Offset: disabled
[   66.251127][ T3061] Rebooting in 86400 seconds..

VM DIAGNOSIS:
07:40:09  Registers:
info registers vcpu 0

CPU#0
RAX=3D0000000000000036 RBX=3D0000000000000036 RCX=3D0000000000000000 RDX=3D=
00000000000003f8
RSI=3D0000000000000000 RDI=3D0000000000000020 RBP=3D00000000000003f8 RSP=3D=
ffffc9000172f4e0
R8 =3Ddffffc0000000000 R9 =3Dfffff520002e5e9e R10=3Dfffff520002e5e9e R11=3D=
ffffffff83f79850
R12=3Ddffffc0000000000 R13=3D1ffffffff2ad2063 R14=3Dffffffff96179de0 R15=3D=
0000000000000000
RIP=3Dffffffff83f798c8 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
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
CR0=3D80050033 CR2=3D00007f9d25c90e9c CR3=3D000000003f184000 CR4=3D00350ef0
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
 0000000000000000 0000000000000000 b8a5606d93fbf234 4e6d6128c1c61247
ZMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 e69291a55adf1a4d bc79a80ad3c0fce0
ZMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 be6cebfbb543848d 5148acc6845117c5
ZMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 4a118d849a30d684 02106ca1c36d1727
ZMM04=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 00000000ffffffff 00000000000000b4
ZMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000034
ZMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 f280979acd555a03 dd619a0e2b11f92c
ZMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 4db1fdda4413481c 0000000000000000
ZMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 9675387fceff6377 c2b3d307affe2114
ZMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 d99f887700000000 25c03f609d700a96
ZMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 15ad1dc2a12d429b 71118e54ff6cdf2d
ZMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 fbb4f24384a52b52 900c1a64c85601c3
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
 -ffile-prefix-map=3D/tmp/go-build317169965=3D/tmp/go-build -gno-record-gcc=
-switches'
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
HEAD detached at d7384b6d0bf
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
/syzkaller/prog.GitRevision=3Dd7384b6d0bff77c60aad349866f126ab16ce5296 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250710-085248"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"d7384b6d0bff77c60aad349866f126ab16=
ce5296\"
/usr/bin/ld: /tmp/ccf2gjJF.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17bd0be2580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D768d3f2193745e7=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc24237f0eee59c0c2=
abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D167282585800=
00


