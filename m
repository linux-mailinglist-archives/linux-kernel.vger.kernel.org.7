Return-Path: <linux-kernel+bounces-868366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F7FC050BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC953189141F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E793054DD;
	Fri, 24 Oct 2025 08:31:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C9B302756
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294666; cv=none; b=mFbfLP9H+zlonbRuLJ//toV3DGIQr6AbYCsaXP/vSIjEu+qggbJYXGPxikjS8TxUXmxEe6AlulJGTH/6uVcmZqeNgUZVDwqPPvecrJ4lerwn8eZNdh0YfquIyq1IfSTUkyauzUH/r9anJXnQZKpKyjp2iMLYi2+u0FH++aX4lzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294666; c=relaxed/simple;
	bh=HwALYkoFaeyo0c9bNvT2P6hS1JDI4tY7OSstGsoneas=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B1JERRqRfkaImdyfmC8qeCkKk8wmwr8HeXgyDbzFEjWVn9dvcxpOwbykJ/3LrGX4bqpAk7RoM4MC2YtN/Ol9rXFEqTblqIo2C5D3VUq2CBxejBq+TRwKAEhPSPULeSVlDENfpS8RlaXcgd2JV68bnlTnMgIeTCGL7WODwEFX5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d8643856so70464035ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761294663; x=1761899463;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9QQY8Vot0CdwXzA9okbAeGsE1//z9g7mVQdm7DDHf4=;
        b=temRE/L07yaZ1ZYGTtpduksyJ4NTh6ttgxn6NGCV1kKsAHJUNT/gvZHPuDpp10t4vj
         Z3+sdlurnotv/yecN/YK+i/YHgIIosrqO8aLaXKs02YBnIUtbMzy3IgXDMFR3jb0QYec
         B9WhpYGipDpLUtSUPiWB2jGWpOvi0sZooZPY+wTidsN9Frm0thFAOPN8S/v28Q+PkFPY
         qqMjuWh2l6+OhTjKo+UbZAdV58DggQYaMOlrkoJrh3ngyA39HTaXl0KwEeLO/9bhb/Xx
         v6IX9dp1xm/8LnqyuFFRUjbCbuQnv2NDxz381Cw1O7J/qvYObamhQ/Si+zBZbg0gZAft
         Fl7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBix8UMT141ssge/TX8pxYaAS9r8bm/rUfVRHQZJOr0rGIkbmARqnZOSYWUPUcHyT/vPo3Yd2k16pXxpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsvmU+7eQk1iuKgf0GNXBALFgQc3dU5p9q4FzqY2m4zs5ObKl
	t1H0JP3+qFCD7GHXUuTjbnwfsimfC3tyXBu9gx8CW2IRRIHlZnn1xS7OLO2ua3FABDnzAC3Fv4X
	cAd6XeX2S/0yYpsfURAKJE8OGf5/ZYPyyJHR5PVAcLFh0VFn3TUaTqTvfcmM=
X-Google-Smtp-Source: AGHT+IE7CMR/3LsTbX+j2iyxZeP8K6zT9g3ZdEWMD0F+sYGFr1bLdA+q6Tk3O5CGXY+LbXwzZPuYi7MtMdnPK3nPsZWw0Ky65wfO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3287:b0:430:a3b0:8458 with SMTP id
 e9e14a558f8ab-431dc139f2cmr89582705ab.3.1761294663602; Fri, 24 Oct 2025
 01:31:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 01:31:03 -0700
In-Reply-To: <20251024071153.WcJfz%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb3947.a70a0220.3bf6c6.015f.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

UBSAN: signed-integer-overflow in ip_idents_reserve

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
UBSAN: signed-integer-overflow in ./arch/x86/include/asm/atomic.h:165:11
-1399202697 + -1961381633 cannot be represented in type 'int'
CPU: 1 PID: 27 Comm: kworker/u4:2 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/02/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:148
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x468/0x850 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inlin=
e]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:5=
1
 process_one_work+0x85e/0xff0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x386/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 27 Comm: kworker/u4:2 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/02/2025
Workqueue: wg-kex-wg0 wg_packet_handshake_send_worker
Call Trace:
 dump_stack+0xfd/0x16e lib/dump_stack.c:118
 panic+0x2f0/0x9c0 kernel/panic.c:308
 check_panic_on_warn+0x95/0xe0 kernel/panic.c:228
 handle_overflow+0x192/0x1b0 lib/ubsan.c:180
 arch_atomic_add_return arch/x86/include/asm/atomic.h:165 [inline]
 atomic_add_return include/asm-generic/atomic-instrumented.h:73 [inline]
 ip_idents_reserve+0x14a/0x170 net/ipv4/route.c:521
 __ip_select_ident+0xe4/0x1c0 net/ipv4/route.c:538
 iptunnel_xmit+0x468/0x850 net/ipv4/ip_tunnel_core.c:80
 udp_tunnel_xmit_skb+0x1ba/0x290 net/ipv4/udp_tunnel_core.c:190
 send4+0x5d4/0xaf0 drivers/net/wireguard/socket.c:85
 wg_socket_send_skb_to_peer+0xcd/0x1c0 drivers/net/wireguard/socket.c:175
 wg_packet_send_handshake_initiation drivers/net/wireguard/send.c:40 [inlin=
e]
 wg_packet_handshake_send_worker+0x16b/0x280 drivers/net/wireguard/send.c:5=
1
 process_one_work+0x85e/0xff0 kernel/workqueue.c:2282
 worker_thread+0xa9b/0x1430 kernel/workqueue.c:2428
 kthread+0x386/0x410 kernel/kthread.c:328
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
Kernel Offset: disabled
Rebooting in 86400 seconds..


Warning: Permanently added '10.128.1.176' (ED25519) to the list of known ho=
sts.
2025/10/24 08:30:04 parsed 1 programs
[   48.013663][ T6013] cgroup: Unknown subsys name 'net'
[   48.170944][ T6013] cgroup: Unknown subsys name 'rlimit'
[   49.896812][ T6013] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   50.802412][ T6020] IPVS: ftp: loaded support on port[0] =3D 21
[   50.981218][ T6026] IPVS: ftp: loaded support on port[0] =3D 21
[   51.070963][ T6031] IPVS: ftp: loaded support on port[0] =3D 21
[   51.212304][ T6037] IPVS: ftp: loaded support on port[0] =3D 21
[   51.298209][ T6042] IPVS: ftp: loaded support on port[0] =3D 21
[   51.396045][ T6047] IPVS: ftp: loaded support on port[0] =3D 21
[   51.445463][ T6047] chnl_net:caif_netlink_parms(): no params data found
[   51.483834][ T6047] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   51.491355][ T6047] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   51.499426][ T6047] device bridge_slave_0 entered promiscuous mode
[   51.507218][ T6047] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   51.514361][ T6047] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   51.521916][ T6047] device bridge_slave_1 entered promiscuous mode
[   51.540701][ T6047] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   51.551842][ T6047] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   51.567750][ T6047] team0: Port device team_slave_0 added
[   51.574571][ T6047] team0: Port device team_slave_1 added
[   51.586442][ T6047] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   51.593515][ T6047] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   51.619504][ T6047] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   51.631289][ T6047] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   51.638275][ T6047] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   51.664460][ T6047] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   51.688501][ T6047] device hsr_slave_0 entered promiscuous mode
[   51.695170][ T6047] device hsr_slave_1 entered promiscuous mode
[   51.745737][ T6047] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   51.754100][ T6047] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   51.762823][ T6047] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   51.771249][ T6047] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   51.786410][ T6047] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   51.793485][ T6047] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   51.800980][ T6047] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   51.808073][ T6047] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   51.835190][ T6047] 8021q: adding VLAN 0 to HW filter on device bond0
[   51.846473][  T178] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   51.855767][  T178] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   51.863380][  T178] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   51.871161][  T178] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes r=
eady
[   51.886989][ T6047] 8021q: adding VLAN 0 to HW filter on device team0
[   51.896287][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   51.904678][   T27] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   51.911755][   T27] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   51.928140][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   51.936459][   T27] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   51.943545][   T27] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   51.951785][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   51.968045][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   51.976221][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   51.986689][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   51.997233][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   52.007405][ T6047] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   52.064410][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   52.072318][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   52.083417][ T6047] 8021q: adding VLAN 0 to HW filter on device batadv0
[   52.097534][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   52.116942][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   52.125424][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   52.133639][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   52.144186][ T6047] device veth0_vlan entered promiscuous mode
[   52.158944][ T6047] device veth1_vlan entered promiscuous mode
[   52.173076][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   52.181468][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   52.189866][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   52.205170][ T6047] device veth0_macvtap entered promiscuous mode
[   52.213384][ T6047] device veth1_macvtap entered promiscuous mode
[   52.226086][ T6047] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   52.233924][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   52.242748][   T27] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   52.257429][ T6047] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   52.264976][  T178] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   52.275526][ T6047] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.284833][ T6047] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.293537][ T6047] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.302445][ T6047] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   52.318876][   T27] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   52.328195][   T27] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   52.336760][   T27] -1399202697 + -1961381633 cannot be represented in t=
ype 'int'
[   52.344421][   T27] CPU: 1 PID: 27 Comm: kworker/u4:2 Not tainted syzkal=
ler #0
[   52.351780][   T27] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   52.361832][   T27] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   52.368761][   T27] Call Trace:
[   52.372032][   T27]  dump_stack+0xfd/0x16e
[   52.376247][   T27]  ubsan_epilogue+0xa/0x30
[   52.380663][   T27]  handle_overflow+0x192/0x1b0
[   52.385400][   T27]  ? prandom_u32+0x217/0x260
[   52.390240][   T27]  ip_idents_reserve+0x14a/0x170
[   52.395164][   T27]  __ip_select_ident+0xe4/0x1c0
[   52.400000][   T27]  iptunnel_xmit+0x468/0x850
[   52.404585][   T27]  udp_tunnel_xmit_skb+0x1ba/0x290
[   52.409691][   T27]  send4+0x5d4/0xaf0
[   52.413573][   T27]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   52.419181][   T27]  wg_packet_handshake_send_worker+0x16b/0x280
[   52.425312][   T27]  process_one_work+0x85e/0xff0
[   52.430173][   T27]  worker_thread+0xa9b/0x1430
[   52.434940][   T27]  ? rcu_lock_release+0x20/0x20
[   52.439765][   T27]  kthread+0x386/0x410
[   52.443809][   T27]  ? rcu_lock_release+0x20/0x20
[   52.448664][   T27]  ? kthread_blkcg+0xd0/0xd0
[   52.453322][   T27]  ret_from_fork+0x1f/0x30
[   52.457765][   T27] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   52.467065][   T27] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   52.474261][   T27] CPU: 1 PID: 27 Comm: kworker/u4:2 Not tainted syzkal=
ler #0
[   52.481603][   T27] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   52.491670][   T27] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   52.498580][   T27] Call Trace:
[   52.501854][   T27]  dump_stack+0xfd/0x16e
[   52.506080][   T27]  panic+0x2f0/0x9c0
[   52.509954][   T27]  check_panic_on_warn+0x95/0xe0
[   52.514870][   T27]  handle_overflow+0x192/0x1b0
[   52.519633][   T27]  ? prandom_u32+0x217/0x260
[   52.524228][   T27]  ip_idents_reserve+0x14a/0x170
[   52.529235][   T27]  __ip_select_ident+0xe4/0x1c0
[   52.534066][   T27]  iptunnel_xmit+0x468/0x850
[   52.538633][   T27]  udp_tunnel_xmit_skb+0x1ba/0x290
[   52.543721][   T27]  send4+0x5d4/0xaf0
[   52.547604][   T27]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   52.553417][   T27]  wg_packet_handshake_send_worker+0x16b/0x280
[   52.559562][   T27]  process_one_work+0x85e/0xff0
[   52.564387][   T27]  worker_thread+0xa9b/0x1430
[   52.569136][   T27]  ? rcu_lock_release+0x20/0x20
[   52.574052][   T27]  kthread+0x386/0x410
[   52.578096][   T27]  ? rcu_lock_release+0x20/0x20
[   52.582913][   T27]  ? kthread_blkcg+0xd0/0xd0
[   52.587475][   T27]  ret_from_fork+0x1f/0x30
[   52.592191][   T27] Kernel Offset: disabled
[   52.596510][   T27] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1315598195=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/cccF2O1E.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16982d2f9800=
00


