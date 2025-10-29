Return-Path: <linux-kernel+bounces-875818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FD1C19E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5182318980A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0E62DC76B;
	Wed, 29 Oct 2025 10:48:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11102E6CC5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734885; cv=none; b=AEeDfCSqoq1BtZHe1P9sATo3qYiTvXQWjcSyBwdrDsQzcN4au0OMKlstgnUG1BQl5aUFSlNVjPDu5hhfV1WkS66fejJt+wPp+upf4VR0CWJg3iPPBfDN5DAyQNOWtUHydvhBx42F+gmkexWhOfRsbYbbBKoLVyJFyEcYzjPU0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734885; c=relaxed/simple;
	bh=FpLffjjjTeLAXmA4WLelJXzcOovwWhhmAJSl0Mfi0Cs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NAQt7rTxfgKD/2EvmT3naxqGe4SDBB9mulJaZM/HsXf/IjYhS/J0KtdxaS1sa3fdcCIPeJB5yW2FMudsawvybnhwI79v2LObUMAAw8J2LWtH3EAgADpUNLkl4BA4sgZnNszwxKOzP67pN3Vc51dFcNVRr/vDuCoHMEP0jpgNiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430da49fcbbso90224465ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734883; x=1762339683;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aubd/xQBNetFLf05GqtVCv9QvEwTq6mwI7xzIIz30LE=;
        b=HiUwV7y0QH/mxd5mNSTMH5MNGGc8q+tcOv7p7AeYgZWgBZppsXVRfVv4LhR5CDxUVL
         ZXgh38iK5mxt/Ev1x5j9lqBYITk/R1BRmMBC7uqxSIaVKubdVa1IkhUUyv5wgP07gXw9
         jqw8zME+fKnfp61Kfe1rS6hpgxzwOLwfVAqYT/fBwWILJ14OBXNJKLZFNsthRM6TjMa4
         XaVhtNImzo6miJ/P/N8pTxzeQIs54dwkUaLYXFl8b1S0dviPCpkh2IwaIgd+GulLknVc
         qDvo/nuH+hXHiLi1BEevzvAGi2CfT1LnrdWOzi8oTq127w+W80kqLZwfgPvM4v7AeEJY
         r40w==
X-Forwarded-Encrypted: i=1; AJvYcCVIXHfGyhO1TVYKf+Rk7jk4w2cg6HvwEhfEk8goK1ZDYnzejHelVStRvLByd9W0RjkTz08HNzAq/GdWJ90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVVxD7w74pHxkoPEkFybFico/iGB50JpgiIFtFsAkkWTgfQsb
	/bP00WPTvbh/t8aZLkVvHoTykPb91f2qshTiu8KS66b0m0noQ+UcBDqOTwglne7WkLX14NTUEbo
	UkNoAvKkcCZusWgDeEp7T0U+6yMcwSX9GmirnLHigVs1oyppVLxJAre4uhtg=
X-Google-Smtp-Source: AGHT+IH70ChmC7HV8qANNtomLPc9ur+MeXhaw1ksixPyuhXrIvBjWfjyxGxfyLj24Bjb01LFFNLlFd2oYre0eV0iJLeJXuxdj/2T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2602:b0:430:adcd:37df with SMTP id
 e9e14a558f8ab-432f903b0a5mr35497005ab.18.1761734882760; Wed, 29 Oct 2025
 03:48:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 03:48:02 -0700
In-Reply-To: <20251029062154.55JsK%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901f0e2.050a0220.32483.020b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

omes ready
[   58.948418][ T1019] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   58.956145][ T6370] device veth0_vlan entered promiscuous mode
[   58.970007][ T6370] device veth1_vlan entered promiscuous mode
[   58.988166][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   58.996279][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   59.004239][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_macvtap: link b=
ecomes ready
[   59.012641][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   59.022364][ T6370] device veth0_macvtap entered promiscuous mode
[   59.033758][ T6370] device veth1_macvtap entered promiscuous mode
[   59.047533][ T6370] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   59.057709][ T6370] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   59.065252][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   59.073242][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): macsec0: link becomes=
 ready
[   59.081462][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0: link =
becomes ready
[   59.090049][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   59.098646][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link =
becomes ready
[   59.107144][ T1121] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   59.117076][ T6370] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   59.126016][ T6370] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   59.134732][ T6370] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   59.143399][ T6370] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   59.174329][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   59.183666][    C0] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   59.192488][    C0] 1175525299 + 1358810344 cannot be represented in typ=
e 'int'
[   59.200063][    C0] CPU: 0 PID: 6370 Comm: syz-executor Not tainted syzk=
aller #0
[   59.207691][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   59.217852][    C0] Call Trace:
[   59.221135][    C0]  <IRQ>
[   59.223999][    C0]  dump_stack+0xfd/0x16e
[   59.228248][    C0]  ubsan_epilogue+0xa/0x30
[   59.232700][    C0]  handle_overflow+0x192/0x1b0
[   59.237472][    C0]  ? __sys_sendto+0x323/0x430
[   59.242160][    C0]  ? prandom_u32+0x1d/0x1f0
[   59.246674][    C0]  ip_idents_reserve+0x14a/0x170
[   59.251640][    C0]  __ip_select_ident+0xe4/0x1c0
[   59.256503][    C0]  iptunnel_xmit+0x466/0x7b0
[   59.261103][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   59.266427][    C0]  geneve_xmit+0x1d05/0x2140
[   59.271032][    C0]  dev_hard_start_xmit+0x294/0x780
[   59.276150][    C0]  __dev_queue_xmit+0x1678/0x28b0
[   59.281177][    C0]  ip6_finish_output2+0x1020/0x1490
[   59.286390][    C0]  NF_HOOK+0x45/0x2c0
[   59.290567][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   59.294813][    C0]  mld_sendpack+0x5f9/0xa70
[   59.299323][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   59.304526][    C0]  ? lock_acquire+0x78/0x310
[   59.309234][    C0]  ? lock_release+0x69/0x610
[   59.313846][    C0]  ? debug_object_deactivate+0x9b/0x250
[   59.319401][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   59.324524][    C0]  call_timer_fn+0x105/0x440
[   59.329120][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   59.334331][    C0]  __run_timers+0x5d8/0x7a0
[   59.338941][    C0]  ? __do_softirq+0x164/0x8ae
[   59.343624][    C0]  run_timer_softirq+0x19/0x30
[   59.348392][    C0]  __do_softirq+0x23c/0x8ae
[   59.352911][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   59.358118][    C0]  asm_call_irq_on_stack+0xf/0x20
[   59.363137][    C0]  </IRQ>
[   59.366089][    C0]  do_softirq_own_stack+0x6d/0xb0
[   59.371295][    C0]  __irq_exit_rcu+0x1e1/0x1f0
[   59.375980][    C0]  irq_exit_rcu+0x5/0x20
[   59.380251][    C0]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   59.385992][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   59.392003][    C0] RIP: 0010:memset_erms+0xb/0x20
[   59.396940][    C0] Code: 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 e9 bd e=
1 3a 05 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 f9 40 88 f0 48 89 d1 f=
3 aa <4c> 89 c8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 49
[   59.416545][    C0] RSP: 0018:ffffc90001a4f468 EFLAGS: 00000202
[   59.422707][    C0] RAX: 0000000000000000 RBX: ffff8880376f2648 RCX: 000=
0000000000000
[   59.430762][    C0] RDX: 0000000000000010 RSI: 0000000000000000 RDI: fff=
f8880376f2658
[   59.438798][    C0] RBP: 0000000000040cd0 R08: dffffc0000000000 R09: fff=
f8880376f2648
[   59.446750][    C0] R10: ffffed1006ede4cb R11: 1ffff11006ede4c9 R12: 000=
0000000000007
[   59.454709][    C0] R13: 0000000000000002 R14: ffff8880376f2760 R15: dff=
ffc0000000000
[   59.462719][    C0]  init_once+0x237/0x260
[   59.466946][    C0]  setup_object+0x40/0x130
[   59.471344][    C0]  new_slab+0x1b0/0x4a0
[   59.475471][    C0]  ? mempolicy_slab_node+0x124/0x2f0
[   59.480818][    C0]  ___slab_alloc+0x3d1/0x580
[   59.485389][    C0]  ? new_inode_pseudo+0x7d/0x220
[   59.490301][    C0]  ? new_inode_pseudo+0x7d/0x220
[   59.495230][    C0]  kmem_cache_alloc+0x131/0x2e0
[   59.500058][    C0]  new_inode_pseudo+0x7d/0x220
[   59.504986][    C0]  new_inode+0x25/0x1c0
[   59.509118][    C0]  ? start_creating+0x1fc/0x310
[   59.513937][    C0]  __debugfs_create_file+0x148/0x520
[   59.519204][    C0]  ieee80211_debugfs_add_netdev+0xd6a/0xe50
[   59.525082][    C0]  ieee80211_if_add+0x717/0x16a0
[   59.529995][    C0]  ieee80211_register_hw+0x2be1/0x3bf0
[   59.535437][    C0]  mac80211_hwsim_new_radio+0x2c63/0x4300
[   59.541143][    C0]  hwsim_new_radio_nl+0xb4f/0xd50
[   59.546143][    C0]  genl_rcv_msg+0xb22/0xdd0
[   59.550632][    C0]  ? hwsim_tx_info_frame_received_nl+0xef0/0xef0
[   59.556941][    C0]  netlink_rcv_skb+0x187/0x390
[   59.561683][    C0]  ? genl_bind+0x2c0/0x2c0
[   59.566088][    C0]  genl_rcv+0x24/0x40
[   59.570249][    C0]  netlink_unicast+0x7b7/0x9b0
[   59.575081][    C0]  netlink_sendmsg+0x968/0xb50
[   59.579913][    C0]  ? netlink_getsockopt+0x4f0/0x4f0
[   59.585124][    C0]  __sock_sendmsg+0x15c/0x170
[   59.589822][    C0]  __sys_sendto+0x323/0x430
[   59.594319][    C0]  __x64_sys_sendto+0xda/0xf0
[   59.599079][    C0]  do_syscall_64+0x34/0x50
[   59.603471][    C0]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   59.609433][    C0] RIP: 0033:0x7f378254ea3c
[   59.614162][    C0] Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c=
5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0=
f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
[   59.633920][    C0] RSP: 002b:00007ffde7bb18f0 EFLAGS: 00000293 ORIG_RAX=
: 000000000000002c
[   59.642418][    C0] RAX: ffffffffffffffda RBX: 00007f37832c2620 RCX: 000=
07f378254ea3c
[   59.650377][    C0] RDX: 0000000000000024 RSI: 00007f37832c2670 RDI: 000=
0000000000003
[   59.658358][    C0] RBP: 0000000000000000 R08: 00007ffde7bb1944 R09: 000=
000000000000c
[   59.666342][    C0] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000003
[   59.674343][    C0] R13: 0000000000000000 R14: 00007f37832c2670 R15: 000=
0000000000000
[   59.682356][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   59.691756][    C0] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   59.698933][    C0] CPU: 0 PID: 6370 Comm: syz-executor Not tainted syzk=
aller #0
[   59.706521][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   59.716551][    C0] Call Trace:
[   59.719834][    C0]  <IRQ>
[   59.722667][    C0]  dump_stack+0xfd/0x16e
[   59.726892][    C0]  panic+0x2f0/0x9c0
[   59.730778][    C0]  check_panic_on_warn+0x95/0xe0
[   59.735693][    C0]  handle_overflow+0x192/0x1b0
[   59.740430][    C0]  ? __sys_sendto+0x323/0x430
[   59.745387][    C0]  ? prandom_u32+0x1d/0x1f0
[   59.749884][    C0]  ip_idents_reserve+0x14a/0x170
[   59.754830][    C0]  __ip_select_ident+0xe4/0x1c0
[   59.759747][    C0]  iptunnel_xmit+0x466/0x7b0
[   59.764421][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   59.769531][    C0]  geneve_xmit+0x1d05/0x2140
[   59.774139][    C0]  dev_hard_start_xmit+0x294/0x780
[   59.779336][    C0]  __dev_queue_xmit+0x1678/0x28b0
[   59.784338][    C0]  ip6_finish_output2+0x1020/0x1490
[   59.789515][    C0]  NF_HOOK+0x45/0x2c0
[   59.793575][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   59.797891][    C0]  mld_sendpack+0x5f9/0xa70
[   59.802474][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   59.804690][ T6333] Bluetooth: hci0: command 0x0409 tx timeout
[   59.808108][    C0]  ? lock_acquire+0x78/0x310
[   59.818844][    C0]  ? lock_release+0x69/0x610
[   59.823619][    C0]  ? debug_object_deactivate+0x9b/0x250
[   59.829328][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   59.834428][    C0]  call_timer_fn+0x105/0x440
[   59.839004][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   59.844183][    C0]  __run_timers+0x5d8/0x7a0
[   59.848682][    C0]  ? __do_softirq+0x164/0x8ae
[   59.853362][    C0]  run_timer_softirq+0x19/0x30
[   59.858110][    C0]  __do_softirq+0x23c/0x8ae
[   59.863190][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   59.868486][    C0]  asm_call_irq_on_stack+0xf/0x20
[   59.873488][    C0]  </IRQ>
[   59.876458][    C0]  do_softirq_own_stack+0x6d/0xb0
[   59.881487][    C0]  __irq_exit_rcu+0x1e1/0x1f0
[   59.886306][    C0]  irq_exit_rcu+0x5/0x20
[   59.890662][    C0]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   59.896277][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   59.902237][    C0] RIP: 0010:memset_erms+0xb/0x20
[   59.907244][    C0] Code: 0f af c6 f3 48 ab 89 d1 f3 aa 4c 89 c8 e9 bd e=
1 3a 05 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 f9 40 88 f0 48 89 d1 f=
3 aa <4c> 89 c8 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 49
[   59.927609][    C0] RSP: 0018:ffffc90001a4f468 EFLAGS: 00000202
[   59.933668][    C0] RAX: 0000000000000000 RBX: ffff8880376f2648 RCX: 000=
0000000000000
[   59.941718][    C0] RDX: 0000000000000010 RSI: 0000000000000000 RDI: fff=
f8880376f2658
[   59.949681][    C0] RBP: 0000000000040cd0 R08: dffffc0000000000 R09: fff=
f8880376f2648
[   59.957856][    C0] R10: ffffed1006ede4cb R11: 1ffff11006ede4c9 R12: 000=
0000000000007
[   59.965825][    C0] R13: 0000000000000002 R14: ffff8880376f2760 R15: dff=
ffc0000000000
[   59.973791][    C0]  init_once+0x237/0x260
[   59.978011][    C0]  setup_object+0x40/0x130
[   59.982784][    C0]  new_slab+0x1b0/0x4a0
[   59.986926][    C0]  ? mempolicy_slab_node+0x124/0x2f0
[   59.992196][    C0]  ___slab_alloc+0x3d1/0x580
[   59.996877][    C0]  ? new_inode_pseudo+0x7d/0x220
[   60.001809][    C0]  ? new_inode_pseudo+0x7d/0x220
[   60.006736][    C0]  kmem_cache_alloc+0x131/0x2e0
[   60.011696][    C0]  new_inode_pseudo+0x7d/0x220
[   60.016537][    C0]  new_inode+0x25/0x1c0
[   60.020675][    C0]  ? start_creating+0x1fc/0x310
[   60.025875][    C0]  __debugfs_create_file+0x148/0x520
[   60.031153][    C0]  ieee80211_debugfs_add_netdev+0xd6a/0xe50
[   60.037336][    C0]  ieee80211_if_add+0x717/0x16a0
[   60.042289][    C0]  ieee80211_register_hw+0x2be1/0x3bf0
[   60.047757][    C0]  mac80211_hwsim_new_radio+0x2c63/0x4300
[   60.053624][    C0]  hwsim_new_radio_nl+0xb4f/0xd50
[   60.058638][    C0]  genl_rcv_msg+0xb22/0xdd0
[   60.063514][    C0]  ? hwsim_tx_info_frame_received_nl+0xef0/0xef0
[   60.069828][    C0]  netlink_rcv_skb+0x187/0x390
[   60.074571][    C0]  ? genl_bind+0x2c0/0x2c0
[   60.078969][    C0]  genl_rcv+0x24/0x40
[   60.082939][    C0]  netlink_unicast+0x7b7/0x9b0
[   60.087778][    C0]  netlink_sendmsg+0x968/0xb50
[   60.092704][    C0]  ? netlink_getsockopt+0x4f0/0x4f0
[   60.098109][    C0]  __sock_sendmsg+0x15c/0x170
[   60.102765][    C0]  __sys_sendto+0x323/0x430
[   60.107339][    C0]  __x64_sys_sendto+0xda/0xf0
[   60.111995][    C0]  do_syscall_64+0x34/0x50
[   60.116391][    C0]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   60.122269][    C0] RIP: 0033:0x7f378254ea3c
[   60.126659][    C0] Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c=
5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0=
f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
[   60.146280][    C0] RSP: 002b:00007ffde7bb18f0 EFLAGS: 00000293 ORIG_RAX=
: 000000000000002c
[   60.154692][    C0] RAX: ffffffffffffffda RBX: 00007f37832c2620 RCX: 000=
07f378254ea3c
[   60.162662][    C0] RDX: 0000000000000024 RSI: 00007f37832c2670 RDI: 000=
0000000000003
[   60.170623][    C0] RBP: 0000000000000000 R08: 00007ffde7bb1944 R09: 000=
000000000000c
[   60.178672][    C0] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000003
[   60.186632][    C0] R13: 0000000000000000 R14: 00007f37832c2670 R15: 000=
0000000000000
[   60.194884][    C0] Kernel Offset: disabled
[   60.199222][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2528876832=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/ccKwcYCP.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D175fdfe2580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D39182a54870857e=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3Db20bbf680bb0f2ece=
dae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16983e7c5800=
00


