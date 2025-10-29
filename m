Return-Path: <linux-kernel+bounces-875280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DAC18969
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AFE1A23CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372B71F9F47;
	Wed, 29 Oct 2025 07:08:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9AC2FC031
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721687; cv=none; b=W9fpcBOyIpte6aqwtgcv1AXCiZunpAtH2vfYqFa2UKdpHUhWDRPXVtrKXpk8Y/7JwHwXw+MxntqbIRtRnL/nMpapAzsEIZ5bPcn16nvZActxjYi8YsvXbraZ+hrhNjnSS0kd9ujVzaOXD3V9Flry8m5Ks8AJISnjlsxDiBaW1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721687; c=relaxed/simple;
	bh=kM+HgtfdGKgCP9FhORJi6vyvmPrCC2r26jFoThertAs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gUwoQluW7SvDMIQa7cqUAV1ge6aTUKhZgfJSOwLAhg4EoZaPgycguOE0XHqf7QPk4Hik7nfma+WmvDLe/IRpU9r5w14CySLho6dfDURStZRcK8JSXgoi+S/Zz31KNZb7K3X6N4J8P6rvLeGyt/EqeKAp9LCXDm1IF9xlAydezWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c684035eso8403995ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721684; x=1762326484;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5WPkgVB9VgCR68wvwFpvhoArwULd0FfPO9B1YEHsKQ=;
        b=KnrjXCKRutfz475CqmV0hHRgMhtkonCaP83xc7kzGrXDCjFspkrSa79H6htn/x+wNR
         Sbk1M9Sxo53IaNheoJYL6Gqt/acp9oXP4SAyeoddMKA8PlbBtQpbHMZoiJN9ZwHxYN0p
         grWExiWH+waT39aW/QfIxf/mgkTH828ijjvLEdjg1pvq8zTzDfayr6b+Oez/Rz//evpP
         YZtjJikK1cCtcZT15+c+r2++L26Fa16XpM34iygCb5BLJXD7wm+gcxsVXoL0wRiEqrhg
         Hkh9d/FGX9DLpU4pMCWaMgWRx5imnUTRbYUMlZYF0vRqo+KbYqV3enGrOZsbrZEq7kj7
         Ds2w==
X-Forwarded-Encrypted: i=1; AJvYcCVaVIGBSQq08dReVkCoxACWW4zZ+Vr+I51/lIMZKxr660dC1PAxfS4LvCKRezV637t3CS/jKb58guYnumM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlyPI9Hh133MEqb/38P63IC1VKrKw0P5HQBtLSNRoGQokNlLcv
	aKUB+VNsgJvYvgTVnVAzb6uA/Y7u38d5ozIfGe85sYDJxQrrGSu9wIaDskjomQLsZPpUtBI6m4d
	tPD4baBD56FbuHhyuduHFeeohNiFrew0SiiUaZOyWy1D4Ss2q5aAPmtoMJjs=
X-Google-Smtp-Source: AGHT+IHd/fPPAOgs8RJJ+llCsNOuTplQSNq/64DbC3Uju45tzht/IqQWY2wUfUUNd1D46Qu280Cj7ippdJpgWjLKrL2MoJ0jyEWa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:42f:94f5:4684 with SMTP id
 e9e14a558f8ab-432f8db63bdmr24962205ab.5.1761721684205; Wed, 29 Oct 2025
 00:08:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 00:08:04 -0700
In-Reply-To: <20251029062156.pGggr%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901bd54.050a0220.3344a1.0412.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] divide error in ocfs2_block_group_fill (3)
From: syzbot <syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

NGE): bond0: link becomes ready
[   67.659882][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes r=
eady
[   67.668876][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   67.678299][ T5618] 8021q: adding VLAN 0 to HW filter on device team0
[   67.696904][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link=
 becomes ready
[   67.706412][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   67.713355][ T3025] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   67.719917][ T3025] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   67.737997][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): bridge0: link becomes=
 ready
[   67.746170][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link=
 becomes ready
[   67.753255][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   67.761424][ T3025] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   67.767981][ T3025] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   67.776501][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   67.789834][ T5618] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   67.801676][ T5618] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   67.811910][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   67.819404][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   67.826626][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   67.833692][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   67.844888][ T3025] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   67.896486][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   67.902785][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   67.913137][ T5618] 8021q: adding VLAN 0 to HW filter on device batadv0
[   67.926115][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   67.939812][ T5618] device veth0_vlan entered promiscuous mode
[   67.946170][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   67.953459][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   67.960715][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   67.970061][ T5618] device veth1_vlan entered promiscuous mode
[   67.976977][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   67.992070][ T5618] device veth0_macvtap entered promiscuous mode
[   67.998994][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   68.006989][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   68.014090][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   68.022742][ T5618] device veth1_macvtap entered promiscuous mode
[   68.035409][ T5618] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   68.042220][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   68.052325][ T5618] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   68.060379][ T3027] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   68.069464][ T5618] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.077570][ T5618] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.087228][ T5618] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.094986][ T5618] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   68.108021][ T3027] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   68.115942][ T3027] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   68.123034][ T3027] 1282323313 + 2084770655 cannot be represented in typ=
e 'int'
[   68.130978][ T3027] CPU: 0 PID: 3027 Comm: kworker/u2:5 Not tainted syzk=
aller #0
[   68.137549][ T3027] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   68.146666][ T3027] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   68.152603][ T3027] Call Trace:
[   68.155328][ T3027]  dump_stack+0xfd/0x16e
[   68.158916][ T3027]  ubsan_epilogue+0xa/0x30
[   68.162641][ T3027]  handle_overflow+0x192/0x1b0
[   68.166622][ T3027]  ? prandom_u32+0x217/0x260
[   68.170495][ T3027]  ip_idents_reserve+0x14a/0x170
[   68.174600][ T3027]  __ip_select_ident+0xe4/0x1c0
[   68.178693][ T3027]  iptunnel_xmit+0x468/0x850
[   68.182482][ T3027]  udp_tunnel_xmit_skb+0x1ba/0x290
[   68.186731][ T3027]  send4+0x5d4/0xaf0
[   68.189985][ T3027]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   68.194732][ T3027]  wg_packet_handshake_send_worker+0x16b/0x280
[   68.200781][ T3027]  process_one_work+0x85e/0xff0
[   68.204929][ T3027]  worker_thread+0xa9b/0x1430
[   68.208868][ T3027]  ? rcu_lock_release+0x20/0x20
[   68.212846][ T3027]  kthread+0x386/0x410
[   68.216206][ T3027]  ? rcu_lock_release+0x20/0x20
[   68.220336][ T3027]  ? kthread_blkcg+0xd0/0xd0
[   68.224057][ T3027]  ret_from_fork+0x1f/0x30
[   68.227707][ T3027] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   68.235718][ T3027] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   68.242148][ T3027] CPU: 0 PID: 3027 Comm: kworker/u2:5 Not tainted syzk=
aller #0
[   68.248871][ T3027] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   68.258217][ T3027] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   68.264036][ T3027] Call Trace:
[   68.266727][ T3027]  dump_stack+0xfd/0x16e
[   68.270510][ T3027]  panic+0x2f0/0x9c0
[   68.273874][ T3027]  check_panic_on_warn+0x95/0xe0
[   68.277943][ T3027]  handle_overflow+0x192/0x1b0
[   68.281940][ T3027]  ? prandom_u32+0x217/0x260
[   68.285754][ T3027]  ip_idents_reserve+0x14a/0x170
[   68.289821][ T3027]  __ip_select_ident+0xe4/0x1c0
[   68.293511][ T3027]  iptunnel_xmit+0x468/0x850
[   68.297020][ T3027]  udp_tunnel_xmit_skb+0x1ba/0x290
[   68.301331][ T3027]  send4+0x5d4/0xaf0
[   68.304697][ T3027]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   68.309587][ T3027]  wg_packet_handshake_send_worker+0x16b/0x280
[   68.314737][ T3027]  process_one_work+0x85e/0xff0
[   68.318718][ T3027]  worker_thread+0xa9b/0x1430
[   68.322372][ T3027]  ? rcu_lock_release+0x20/0x20
[   68.326207][ T3027]  kthread+0x386/0x410
[   68.329499][ T3027]  ? rcu_lock_release+0x20/0x20
[   68.333489][ T3027]  ? kthread_blkcg+0xd0/0xd0
[   68.337061][ T3027]  ret_from_fork+0x1f/0x30
[   68.340939][ T3027] Kernel Offset: disabled
[   68.344406][ T3027] Rebooting in 86400 seconds..

VM DIAGNOSIS:
07:07:22  Registers:
info registers vcpu 0

CPU#0
RAX=3D1ffffffff2c32060 RBX=3D00000000000003fd RCX=3D0000000000000000 RDX=3D=
00000000000003fd
RSI=3D0000000000000000 RDI=3D0000000000000020 RBP=3D0000000000000020 RSP=3D=
ffffc90000a1f488
R8 =3Ddffffc0000000000 R9 =3Dfffff52000143e9e R10=3Dfffff52000143e9e R11=3D=
ffffffff83f95e70
R12=3Ddffffc0000000000 R13=3D1ffffffff2ad4c63 R14=3Dffffffff961903c0 R15=3D=
0000000000000000
RIP=3Dffffffff83f95ee3 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
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
CR0=3D80050033 CR2=3D00007fc76d01b6b0 CR3=3D000000003bbb8000 CR4=3D00350ef0
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
 0000000000000000 0000000000000000 4fbe43ac9f8dee1f 13ce8330a1ae1a97
ZMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 72ec250c5763c9fd 529fd701c037efee
ZMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 c1f3a78accefb53d 505a38d2fce3eab4
ZMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 5c4df8ddb4770ea3 dbe5344bbf7daa56
ZMM04=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 00000000ffffffff 00000000000000b4
ZMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000034
ZMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 a077df95440950b9 0c00cc7265aa82be
ZMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 d81ebb973342967d 0000000000000000
ZMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 8efeaa65cdb9a13e d150fd9eae3be657
ZMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 ddc10fdc00000000 e4660e17edb0aedd
ZMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 a0e979bdc8075c8b a5c0b2d4b44f4d4b
ZMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 345505ce4c1a3a43 40c8945a3b014bfb
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
 -ffile-prefix-map=3D/tmp/go-build2361257849=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at c0460fcde70
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Dc0460fcde7051a8d07612ec2a17718d3c3019bb0 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251022-142038"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Dc0460fcde7051a8d07612ec2a17718d3c3019bb0 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251022-142038"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc0460fcde7051a8d07612ec2a17718d3c3019bb0 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251022-142038"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c0460fcde7051a8d07612ec2a17718d3c3=
019bb0\"
/usr/bin/ld: /tmp/ccCE9RT8.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D102fc32f980000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7686d7adbdbe480
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfd8af97c7227fe605=
d95
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D123a99325800=
00


