Return-Path: <linux-kernel+bounces-875236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90094C187BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20D43A52EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667C1E0083;
	Wed, 29 Oct 2025 06:32:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FF2AD20
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761719525; cv=none; b=R/oRkQ6AYnLIINQjIJsWkOH+8VvltL4uKgwQD5yR7SlE28eJxlOuVYA6l2StPNPKgw2Gz5kVlZDW53I+800mta/L0trHR7P5E8gp3/rjMX8GDkLpzr+p7pnqmSFcYwHhekt8MWkJ+O14ApLB/tIGjnEVEcEoFB3K8AWl7e7E4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761719525; c=relaxed/simple;
	bh=YbXNGvJfoD/6XG1BTfqiciu8cQ1steBVw1ukaEv2rnA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FfSYvTB7pcjn8sFRySqNDWLXtYagwSpfkea4s6p+SzWoV0C1ld0kjtEBSxuZcJ90OVqPp1QqnH7x1cTtjRYC66C4Wqj+0xBlCglvf5DQDTZqjaBzRx5X/Zcjo6ZRu2qLzUsM3uymOpuWYNn8n2s/Y13p9v2IrZKdS+QSMoNMNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so2078758939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761719523; x=1762324323;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6l++t5jILGsa54w0GUzv9xtNsLoEtsoaHLKTqpxYqs=;
        b=fueu1oeAFoeIl9CwAq04AYxxQXDQjPwgoyCjY1buI50HqMMa5bLhWCfdbWlvFuPySJ
         HxGDJZVmX/R9+9twlXkR7A/Ld0pEOwbKJhhmviaCNZaG6++ndUzgsUQa8qdjs4wN63E2
         y4jZqVyAsz817FXhn2GFGLlwJ+K0MMpErH13xje0J+OTreXRyAnIX9MQ0sKRvndJah1V
         f0SEuxU1C8l8kVmnzHomcPmk7iOR6C32CLKgT9zsKMYrH78VZNxKSnlxsssgT7470m8U
         RQKboMQ91zRsj0xS2ZnlF2WJy3EdMA3I0Jclp3XsfOVHcU2hz58cpv7VbzsTvCv7ljFK
         4D2A==
X-Forwarded-Encrypted: i=1; AJvYcCXTaCTq1Gc/1BOc47Rp6aJLeRZguETDZL4TbZTp+DZihoyxH4i1vBFSLvCOxCBN9Cic/8lP+LU1knXQW4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnJbZVRRGkpZTFrZFAbZirryMc2yYWTgTZqvJYdE9gTCsdtiL0
	iRJfypLi5enN9IDo8nt5rAOUIGpTGknx07O92oalAEpTbufkdRbtn0x4EonpHxR+bmAhgPyBeo5
	OkFgn3BGLIZTFqqtU4+dbvF5rW50u0jIKz9cfi3Vgjvidpu1wHzPYFMiXT7k=
X-Google-Smtp-Source: AGHT+IEbsqqmcCj0yZ+YqyaDD3H2CfoDdtos9oiAuL9du6A9yzz+Vgda/mPvQC7xE6AB0u+Fz4pYwvx81Hgz1ZDsEUI6i29dm2Ry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:430:d2fe:cbf3 with SMTP id
 e9e14a558f8ab-432f9066439mr27228875ab.29.1761719522935; Tue, 28 Oct 2025
 23:32:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:32:02 -0700
In-Reply-To: <20251029062150.d06jg%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901b4e2.a70a0220.5b2ed.0011.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 67.405772][  T138] bridge0: port 1(bridge_slave_0) entered forwarding stat=
e
[   67.422310][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): bridge0: link becomes=
 ready
[   67.428814][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link=
 becomes ready
[   67.436709][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   67.444616][  T138] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   67.450434][  T138] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   67.457539][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bond: link b=
ecomes ready
[   67.464951][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bond: link b=
ecomes ready
[   67.472504][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_team: link b=
ecomes ready
[   67.479592][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   67.486473][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_team: link b=
ecomes ready
[   67.495730][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   67.506916][ T5650] hsr0: Slave A (hsr_slave_0) is not up; please bring =
it up to get a fully working HSR network
[   67.515281][ T5650] hsr0: Slave B (hsr_slave_1) is not up; please bring =
it up to get a fully working HSR network
[   67.528862][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   67.536372][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   67.542979][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   67.557870][  T138] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   67.610902][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   67.617048][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   67.627882][ T5650] 8021q: adding VLAN 0 to HW filter on device batadv0
[   67.640213][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   67.654490][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   67.662159][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   67.668580][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   67.677187][ T5650] device veth0_vlan entered promiscuous mode
[   67.691806][ T5650] device veth1_vlan entered promiscuous mode
[   67.706055][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   67.713533][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   67.720200][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   67.729527][ T5650] device veth0_macvtap entered promiscuous mode
[   67.749810][ T5650] device veth1_macvtap entered promiscuous mode
[   67.761853][ T5650] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   67.767891][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   67.776673][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0: link =
becomes ready
[   67.784850][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   67.793939][ T5650] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   67.801258][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link =
becomes ready
[   67.808485][   T18] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   67.817996][ T5650] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   67.828026][ T5650] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   67.835828][ T5650] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   67.843642][ T5650] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   67.857737][   T18] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.865522][   T18] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   67.872603][   T18] 995543531 + 1319321246 cannot be represented in type=
 'int'
[   67.879702][   T18] CPU: 0 PID: 18 Comm: kworker/u2:1 Not tainted syzkal=
ler #0
[   67.886045][   T18] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   67.895362][   T18] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   67.901364][   T18] Call Trace:
[   67.904328][   T18]  dump_stack+0xfd/0x16e
[   67.908005][   T18]  ubsan_epilogue+0xa/0x30
[   67.911778][   T18]  handle_overflow+0x192/0x1b0
[   67.915876][   T18]  ? prandom_u32+0x217/0x260
[   67.919849][   T18]  ip_idents_reserve+0x14a/0x170
[   67.924126][   T18]  __ip_select_ident+0xe4/0x1c0
[   67.928256][   T18]  iptunnel_xmit+0x468/0x850
[   67.932244][   T18]  udp_tunnel_xmit_skb+0x1ba/0x290
[   67.936638][   T18]  send4+0x5d4/0xaf0
[   67.939990][   T18]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   67.944630][   T18]  wg_packet_handshake_send_worker+0x16b/0x280
[   67.949906][   T18]  process_one_work+0x85e/0xff0
[   67.954046][   T18]  worker_thread+0xa9b/0x1430
[   67.958082][   T18]  ? rcu_lock_release+0x20/0x20
[   67.962220][   T18]  kthread+0x386/0x410
[   67.965686][   T18]  ? rcu_lock_release+0x20/0x20
[   67.969859][   T18]  ? kthread_blkcg+0xd0/0xd0
[   67.973836][   T18]  ret_from_fork+0x1f/0x30
[   67.977674][   T18] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   67.985359][   T18] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   67.991361][   T18] CPU: 0 PID: 18 Comm: kworker/u2:1 Not tainted syzkal=
ler #0
[   67.997465][   T18] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   68.006318][   T18] Workqueue: wg-kex-wg0 wg_packet_handshake_send_worke=
r
[   68.012069][   T18] Call Trace:
[   68.014829][   T18]  dump_stack+0xfd/0x16e
[   68.018379][   T18]  panic+0x2f0/0x9c0
[   68.021631][   T18]  check_panic_on_warn+0x95/0xe0
[   68.025741][   T18]  handle_overflow+0x192/0x1b0
[   68.029775][   T18]  ? prandom_u32+0x217/0x260
[   68.033699][   T18]  ip_idents_reserve+0x14a/0x170
[   68.037834][   T18]  __ip_select_ident+0xe4/0x1c0
[   68.042016][   T18]  iptunnel_xmit+0x468/0x850
[   68.045881][   T18]  udp_tunnel_xmit_skb+0x1ba/0x290
[   68.050153][   T18]  send4+0x5d4/0xaf0
[   68.053501][   T18]  wg_socket_send_skb_to_peer+0xcd/0x1c0
[   68.058253][   T18]  wg_packet_handshake_send_worker+0x16b/0x280
[   68.063426][   T18]  process_one_work+0x85e/0xff0
[   68.067469][   T18]  worker_thread+0xa9b/0x1430
[   68.071345][   T18]  ? rcu_lock_release+0x20/0x20
[   68.075396][   T18]  kthread+0x386/0x410
[   68.078889][   T18]  ? rcu_lock_release+0x20/0x20
[   68.083007][   T18]  ? kthread_blkcg+0xd0/0xd0
[   68.086908][   T18]  ret_from_fork+0x1f/0x30
[   68.090956][   T18] Kernel Offset: disabled
[   68.094683][   T18] Rebooting in 86400 seconds..

VM DIAGNOSIS:
06:30:55  Registers:
info registers vcpu 0

CPU#0
RAX=3D0000000000000039 RBX=3D0000000000000039 RCX=3D0000000000000000 RDX=3D=
00000000000003f8
RSI=3D0000000000000000 RDI=3D0000000000000020 RBP=3D00000000000003f8 RSP=3D=
ffffc900004474e0
R8 =3Ddffffc0000000000 R9 =3Dfffff52000088e9e R10=3Dfffff52000088e9e R11=3D=
ffffffff83f6a690
R12=3Ddffffc0000000000 R13=3D1ffffffff2ad0463 R14=3Dffffffff9616bde0 R15=3D=
0000000000000000
RIP=3Dffffffff83f6a708 RFL=3D00000002 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=
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
CR0=3D80050033 CR2=3D00005649c4ac8168 CR3=3D000000003cee0000 CR4=3D00350ef0
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
 0000000000000000 0000000000000000 34c0e75a57eedab6 df075a43b3530442
ZMM01=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 cd93e3d1997b1ad0 ac02d2502393cada
ZMM02=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 739bb957f0df0046 e893118a65186997
ZMM03=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 dcce5dad54d123ff 05ce08a3fac4eb3e
ZMM04=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 00000000ffffffff 00000000000000b4
ZMM05=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0000000000000000 0000000000000034
ZMM06=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 0ad426484b0072e0 3ee4763b2d2ad138
ZMM07=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 542de23f41d7d499 0000000000000000
ZMM08=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 64f818e79afcdfd0 39f02c83a206bdbb
ZMM09=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 3caa366800000000 8c2d7c3421c3af63
ZMM10=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 2a1a2c77e3ec1418 ef53c166bcfc26d7
ZMM11=3D0000000000000000 0000000000000000 0000000000000000 0000000000000000=
 0000000000000000 0000000000000000 5689bc5aba259e21 eb51e68077b68e8f
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
 -ffile-prefix-map=3D/tmp/go-build1854730157=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/ccDmF0ws.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D11583e7c580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7c6f4ecbfb251fb
dashboard link: https://syzkaller.appspot.com/bug?extid=3D30b53487d00b4f7f0=
922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D145b6fe25800=
00


