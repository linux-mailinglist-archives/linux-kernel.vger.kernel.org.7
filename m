Return-Path: <linux-kernel+bounces-868740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D8EC0601C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391971C2817B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9F320A17;
	Fri, 24 Oct 2025 11:15:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A0320A1A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304506; cv=none; b=d5owb67s8kKGG/lpfeDJ4RaxD6u1usWShAxwXGBNFU51bxSQhIIUV6oFWDTcmNwzJB6kIQ8p+l/jAQrZ6Ej5i1Hu5XYSQlY+6beitg+ifpeVFB3nDFHuSG58b5enGhhAMIurkB/CAueInP080A4m+aE8X7NDYE606Fhjt8oUda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304506; c=relaxed/simple;
	bh=zdHS1GuMnIzsFvem+iETYFToqvQxaju67PasYY+oWs4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nAFaliLHPZ4TT+c2aoPmO+NmNH5lAovpcg0AsEiLEydgg2eRTP8iMoxG2Wz/kvaUSNPUhuywPHk5mMyeE4wtJ6yWcFRSVhhvAJjBYHSCRU/tj7eGGAUeMqegVwnYRKR7lly14Z2S6lzVFKmQht4gx4UxGFO5rklxgFhEKOcKb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430e67e2427so26946485ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304503; x=1761909303;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqeKOjN2q5r/D4gWmyhpfdR8gweyWglRhUQ0SNYCwC4=;
        b=dKjqbeLVJSF0CrGkRwEtczKGygv3hGStypGEL47qZC/BjTQxJUMGT9+FrvZp5Bd5Os
         UjaEZ1Utbvhjo4C57mgbenDDblAPtRnSxwfY73WceWptkloP/YE9L0uRW2EbdywvFiOf
         6CEEqvEOYfoNmQqN+bc6qQAFBPgyCOTfgqCt5kT9esO/lCJjvsogREViLrAxhix4W1Uf
         bEL1n7/tjV0uVi3MJHwxEZdlE+DE1DxEHuW8DI8tYc1WM/xhWv7BMDhxyjdqDvOcNG/S
         Y0d9XAUKntBbxbzPfkpRnMaN1iGp1V7ncUVO54iJbXhFeFjwZaeaHTb5W4rdN/S+4QMr
         VKOg==
X-Forwarded-Encrypted: i=1; AJvYcCV7xmXK/YsDfXPX9I9sP0gBqZxS0Legk2JxHNuotjxvXdl5mvY2xPrSwyMtGe5QCufPGrNi3XhvG2RgBQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCuoo0LIV4+L+38LX8MhNzgZL5DIznicAY+Ieh1nIR6CziNS/
	o27OQvKI/3m2W7z2StHMbOI75CHsBPDHPxK4odBHk6nNsj5cgCBAl10QFM8s6O8Y5gCyB9AWXrH
	RqNyBUSZVpicl7gvgWkiayYyInF1UQoTqjFJNANgzm/h9koCQ1y5uoJqVnYM=
X-Google-Smtp-Source: AGHT+IFp7W7JBPoi63/XhkQQ8MUPJghWgQJYpTtSBCFQLyGwYoPsHSsi5ERHw8QBIjYkkkf2JoiaG91seQ0RSIUWUzLTs2bX+UtT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154a:b0:426:e20b:f5d4 with SMTP id
 e9e14a558f8ab-430c52200admr410633735ab.10.1761304503145; Fri, 24 Oct 2025
 04:15:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 04:15:03 -0700
In-Reply-To: <20251024071156.ZjWKu%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb5fb7.a70a0220.3bf6c6.019e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

50.688447][ T6310] device veth1_vlan entered promiscuous mode
[   50.706746][ T1035] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   50.714583][ T1035] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   50.722574][ T1035] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_macvtap: link b=
ecomes ready
[   50.731116][ T1035] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   50.741832][ T6310] device veth0_macvtap entered promiscuous mode
[   50.752332][ T6310] device veth1_macvtap entered promiscuous mode
[   50.767297][ T6310] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   50.774561][   T44] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   50.782673][   T44] IPv6: ADDRCONF(NETDEV_CHANGE): macsec0: link becomes=
 ready
[   50.790547][   T44] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_0: link =
becomes ready
[   50.799051][   T44] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   50.809245][ T6310] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   50.819680][   T44] IPv6: ADDRCONF(NETDEV_CHANGE): batadv_slave_1: link =
becomes ready
[   50.828323][   T44] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   50.839843][ T6310] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.848757][ T6310] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.857500][ T6310] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.866296][ T6310] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.905760][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   50.915055][    C0] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   50.923684][    C0] -1416465042 + -1732037041 cannot be represented in t=
ype 'int'
[   50.931326][    C0] CPU: 0 PID: 6310 Comm: syz-executor Not tainted syzk=
aller #0
[   50.938841][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   50.948878][    C0] Call Trace:
[   50.952150][    C0]  <IRQ>
[   50.954981][    C0]  dump_stack+0xfd/0x16e
[   50.959197][    C0]  ubsan_epilogue+0xa/0x30
[   50.963586][    C0]  handle_overflow+0x192/0x1b0
[   50.968326][    C0]  ? do_syscall_64+0x34/0x50
[   50.972883][    C0]  ? prandom_u32+0x1d/0x1f0
[   50.977354][    C0]  ip_idents_reserve+0x14a/0x170
[   50.982259][    C0]  __ip_select_ident+0xe4/0x1c0
[   50.987096][    C0]  iptunnel_xmit+0x466/0x7b0
[   50.991696][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   50.996806][    C0]  geneve_xmit+0x1d05/0x2140
[   51.001464][    C0]  dev_hard_start_xmit+0x294/0x780
[   51.006575][    C0]  __dev_queue_xmit+0x1678/0x28b0
[   51.011592][    C0]  ip6_finish_output2+0x1020/0x1490
[   51.016769][    C0]  NF_HOOK+0x45/0x2c0
[   51.020719][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   51.024936][    C0]  mld_sendpack+0x5f9/0xa70
[   51.029434][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   51.034621][    C0]  ? lock_acquire+0x78/0x310
[   51.039193][    C0]  ? lock_release+0x69/0x610
[   51.043762][    C0]  ? debug_object_deactivate+0x9b/0x250
[   51.049287][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.054413][    C0]  call_timer_fn+0x105/0x440
[   51.059120][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.064234][    C0]  __run_timers+0x5d8/0x7a0
[   51.068809][    C0]  ? __do_softirq+0x164/0x8ae
[   51.073463][    C0]  run_timer_softirq+0x19/0x30
[   51.078690][    C0]  __do_softirq+0x23c/0x8ae
[   51.083286][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   51.088488][    C0]  asm_call_irq_on_stack+0xf/0x20
[   51.093513][    C0]  </IRQ>
[   51.096429][    C0]  do_softirq_own_stack+0x6d/0xb0
[   51.101437][    C0]  __irq_exit_rcu+0x1e1/0x1f0
[   51.106105][    C0]  irq_exit_rcu+0x5/0x20
[   51.110371][    C0]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   51.116111][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   51.122091][    C0] RIP: 0010:truncate_inode_pages_final+0x2/0xd0
[   51.128319][    C0] Code: fe e8 62 7a da ff 4c 89 f7 48 89 de 48 c7 c2 f=
f ff ff ff 5b 41 5e e9 ad e5 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 4=
1 57 <41> 56 53 48 89 fb 49 bf 00 00 00 00 00 fc ff df e8 29 7a da ff 48
[   51.147990][    C0] RSP: 0018:ffffc90001cff658 EFLAGS: 00000293
[   51.154043][    C0] RAX: ffffffff81b9ba30 RBX: ffff888038e835a0 RCX: fff=
f88801b1cd040
[   51.161995][    C0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
f888038e837c8
[   51.170256][    C0] RBP: ffff888038e83678 R08: dffffc0000000000 R09: fff=
fed10071d06c6
[   51.178204][    C0] R10: ffffed10071d06c6 R11: 1ffff110071d06c5 R12: dff=
ffc0000000000
[   51.186161][    C0] R13: ffffffff893efaf0 R14: 0000000000000000 R15: fff=
f888038e83628
[   51.194208][    C0]  ? evict+0x410/0x860
[   51.198252][    C0]  evict+0x41c/0x860
[   51.202557][    C0]  ? _raw_spin_unlock+0x1a/0x30
[   51.207377][    C0]  ? iput+0x6d9/0x890
[   51.211339][    C0]  __dentry_kill+0x436/0x660
[   51.215919][    C0]  dentry_kill+0xb9/0x2d0
[   51.220305][    C0]  dput+0xd5/0x1b0
[   51.224008][    C0]  simple_recursive_removal+0x295/0x8e0
[   51.229524][    C0]  ? debugfs_remove+0x70/0x70
[   51.234238][    C0]  debugfs_remove+0x56/0x70
[   51.238760][    C0]  ieee80211_debugfs_remove_netdev+0x4e/0xb0
[   51.244718][    C0]  ieee80211_if_change_type+0x215/0xe60
[   51.250235][    C0]  ? trace_rdev_return_void+0x7a/0x190
[   51.255665][    C0]  ? ieee80211_set_cqm_rssi_range_config+0x220/0x220
[   51.262453][    C0]  ? cfg80211_mgmt_registrations_update+0x5dc/0x7d0
[   51.269031][    C0]  ieee80211_change_iface+0x57/0x420
[   51.274298][    C0]  cfg80211_change_iface+0x73c/0xe50
[   51.279558][    C0]  nl80211_set_interface+0x43e/0x750
[   51.285004][    C0]  genl_rcv_msg+0xb22/0xdd0
[   51.289582][    C0]  ? nl80211_dump_interface+0x630/0x630
[   51.295106][    C0]  netlink_rcv_skb+0x187/0x390
[   51.299927][    C0]  ? genl_bind+0x2c0/0x2c0
[   51.304331][    C0]  genl_rcv+0x24/0x40
[   51.308316][    C0]  netlink_unicast+0x7b7/0x9b0
[   51.313154][    C0]  netlink_sendmsg+0x968/0xb50
[   51.317999][    C0]  ? netlink_getsockopt+0x4f0/0x4f0
[   51.323270][    C0]  __sock_sendmsg+0x15c/0x170
[   51.328024][    C0]  __sys_sendto+0x323/0x430
[   51.332498][    C0]  __x64_sys_sendto+0xda/0xf0
[   51.337178][    C0]  do_syscall_64+0x34/0x50
[   51.341745][    C0]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   51.347795][    C0] RIP: 0033:0x7f971276aa3c
[   51.352206][    C0] Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c=
5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0=
f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
[   51.371869][    C0] RSP: 002b:00007ffd4d7d3b30 EFLAGS: 00000293 ORIG_RAX=
: 000000000000002c
[   51.380254][    C0] RAX: ffffffffffffffda RBX: 00007f97134de620 RCX: 000=
07f971276aa3c
[   51.388206][    C0] RDX: 0000000000000024 RSI: 00007f97134de670 RDI: 000=
0000000000003
[   51.396360][    C0] RBP: 0000000000000000 R08: 00007ffd4d7d3b84 R09: 000=
000000000000c
[   51.404329][    C0] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000003
[   51.412277][    C0] R13: 0000000000000000 R14: 00007f97134de670 R15: 000=
0000000000000
[   51.420284][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   51.425412][ T6054] Bluetooth: hci0: command 0x0409 tx timeout
[   51.429678][    C0] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   51.442783][    C0] CPU: 0 PID: 6310 Comm: syz-executor Not tainted syzk=
aller #0
[   51.450297][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   51.460336][    C0] Call Trace:
[   51.463600][    C0]  <IRQ>
[   51.466429][    C0]  dump_stack+0xfd/0x16e
[   51.470817][    C0]  panic+0x2f0/0x9c0
[   51.474691][    C0]  check_panic_on_warn+0x95/0xe0
[   51.479688][    C0]  handle_overflow+0x192/0x1b0
[   51.484421][    C0]  ? do_syscall_64+0x34/0x50
[   51.488983][    C0]  ? prandom_u32+0x1d/0x1f0
[   51.493463][    C0]  ip_idents_reserve+0x14a/0x170
[   51.498392][    C0]  __ip_select_ident+0xe4/0x1c0
[   51.503215][    C0]  iptunnel_xmit+0x466/0x7b0
[   51.507794][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   51.512893][    C0]  geneve_xmit+0x1d05/0x2140
[   51.517470][    C0]  dev_hard_start_xmit+0x294/0x780
[   51.522562][    C0]  __dev_queue_xmit+0x1678/0x28b0
[   51.527566][    C0]  ip6_finish_output2+0x1020/0x1490
[   51.532737][    C0]  NF_HOOK+0x45/0x2c0
[   51.536699][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   51.540927][    C0]  mld_sendpack+0x5f9/0xa70
[   51.545417][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   51.550595][    C0]  ? lock_acquire+0x78/0x310
[   51.555163][    C0]  ? lock_release+0x69/0x610
[   51.559730][    C0]  ? debug_object_deactivate+0x9b/0x250
[   51.565246][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.570327][    C0]  call_timer_fn+0x105/0x440
[   51.575081][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.580163][    C0]  __run_timers+0x5d8/0x7a0
[   51.584647][    C0]  ? __do_softirq+0x164/0x8ae
[   51.589330][    C0]  run_timer_softirq+0x19/0x30
[   51.594067][    C0]  __do_softirq+0x23c/0x8ae
[   51.598568][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   51.603833][    C0]  asm_call_irq_on_stack+0xf/0x20
[   51.608831][    C0]  </IRQ>
[   51.611742][    C0]  do_softirq_own_stack+0x6d/0xb0
[   51.616739][    C0]  __irq_exit_rcu+0x1e1/0x1f0
[   51.621421][    C0]  irq_exit_rcu+0x5/0x20
[   51.625666][    C0]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   51.631392][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   51.637422][    C0] RIP: 0010:truncate_inode_pages_final+0x2/0xd0
[   51.643641][    C0] Code: fe e8 62 7a da ff 4c 89 f7 48 89 de 48 c7 c2 f=
f ff ff ff 5b 41 5e e9 ad e5 ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 4=
1 57 <41> 56 53 48 89 fb 49 bf 00 00 00 00 00 fc ff df e8 29 7a da ff 48
[   51.663214][    C0] RSP: 0018:ffffc90001cff658 EFLAGS: 00000293
[   51.669401][    C0] RAX: ffffffff81b9ba30 RBX: ffff888038e835a0 RCX: fff=
f88801b1cd040
[   51.677381][    C0] RDX: 0000000000000000 RSI: 0000000000000004 RDI: fff=
f888038e837c8
[   51.685334][    C0] RBP: ffff888038e83678 R08: dffffc0000000000 R09: fff=
fed10071d06c6
[   51.693282][    C0] R10: ffffed10071d06c6 R11: 1ffff110071d06c5 R12: dff=
ffc0000000000
[   51.701226][    C0] R13: ffffffff893efaf0 R14: 0000000000000000 R15: fff=
f888038e83628
[   51.709190][    C0]  ? evict+0x410/0x860
[   51.713328][    C0]  evict+0x41c/0x860
[   51.717195][    C0]  ? _raw_spin_unlock+0x1a/0x30
[   51.722026][    C0]  ? iput+0x6d9/0x890
[   51.725979][    C0]  __dentry_kill+0x436/0x660
[   51.730536][    C0]  dentry_kill+0xb9/0x2d0
[   51.734907][    C0]  dput+0xd5/0x1b0
[   51.738655][    C0]  simple_recursive_removal+0x295/0x8e0
[   51.744283][    C0]  ? debugfs_remove+0x70/0x70
[   51.748935][    C0]  debugfs_remove+0x56/0x70
[   51.753415][    C0]  ieee80211_debugfs_remove_netdev+0x4e/0xb0
[   51.759395][    C0]  ieee80211_if_change_type+0x215/0xe60
[   51.765032][    C0]  ? trace_rdev_return_void+0x7a/0x190
[   51.770486][    C0]  ? ieee80211_set_cqm_rssi_range_config+0x220/0x220
[   51.777136][    C0]  ? cfg80211_mgmt_registrations_update+0x5dc/0x7d0
[   51.783695][    C0]  ieee80211_change_iface+0x57/0x420
[   51.788958][    C0]  cfg80211_change_iface+0x73c/0xe50
[   51.794219][    C0]  nl80211_set_interface+0x43e/0x750
[   51.799488][    C0]  genl_rcv_msg+0xb22/0xdd0
[   51.803966][    C0]  ? nl80211_dump_interface+0x630/0x630
[   51.809481][    C0]  netlink_rcv_skb+0x187/0x390
[   51.814303][    C0]  ? genl_bind+0x2c0/0x2c0
[   51.818688][    C0]  genl_rcv+0x24/0x40
[   51.822639][    C0]  netlink_unicast+0x7b7/0x9b0
[   51.827389][    C0]  netlink_sendmsg+0x968/0xb50
[   51.832154][    C0]  ? netlink_getsockopt+0x4f0/0x4f0
[   51.837345][    C0]  __sock_sendmsg+0x15c/0x170
[   51.842085][    C0]  __sys_sendto+0x323/0x430
[   51.846568][    C0]  __x64_sys_sendto+0xda/0xf0
[   51.851220][    C0]  do_syscall_64+0x34/0x50
[   51.855606][    C0]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
[   51.861556][    C0] RIP: 0033:0x7f971276aa3c
[   51.866054][    C0] Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c=
5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0=
f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
[   51.885718][    C0] RSP: 002b:00007ffd4d7d3b30 EFLAGS: 00000293 ORIG_RAX=
: 000000000000002c
[   51.894103][    C0] RAX: ffffffffffffffda RBX: 00007f97134de620 RCX: 000=
07f971276aa3c
[   51.902132][    C0] RDX: 0000000000000024 RSI: 00007f97134de670 RDI: 000=
0000000000003
[   51.910076][    C0] RBP: 0000000000000000 R08: 00007ffd4d7d3b84 R09: 000=
000000000000c
[   51.918102][    C0] R10: 0000000000000000 R11: 0000000000000293 R12: 000=
0000000000003
[   51.926045][    C0] R13: 0000000000000000 R14: 00007f97134de670 R15: 000=
0000000000000
[   51.934253][    C0] Kernel Offset: disabled
[   51.938567][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build210064581=3D/tmp/go-build -gno-record-gcc=
-switches'
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
/usr/bin/ld: /tmp/cczDeOCJ.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14e3db04580000


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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D13bc77345800=
00


