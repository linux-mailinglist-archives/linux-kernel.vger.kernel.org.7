Return-Path: <linux-kernel+bounces-875277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC2C18934
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4B319C7F63
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646D2FB0BE;
	Wed, 29 Oct 2025 07:01:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502A26F463
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721264; cv=none; b=J+R2Rnkz/lg1SPFafWrsR7RD9OyofLvNvPawiZ9AIf8wL8sKYXv5MjE82bTr6Jhe4y0hsUgS8AzAjTU4ja0Uyeo+VqW3ogCkpO5MWe2yeU4Mi2a0iepV/3c4TFxgGIQRrHFGh1np3XM2llqJyC2Pf8egYOzgyLRu3po2RxXuygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721264; c=relaxed/simple;
	bh=k1cukd7hbQXFTLWf0l4OLZDgi7dOOjKXqfolNpyt7uQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pyzuxfK0MvLGurk93lJJVvW4mEblzvHFE8n136zYCi0caIOCf6ZMSYuJc1tRY71m0iPhIj4MK+aj+KcMoVYncG4jPCljEitemcJjJDQLkz1vlVueBgzJ6f+XbPFxBm4I7qoydm/57U5KpyAnM7mK96VTC88GRiBuf4Z8MrZ3uhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-431d84fdb91so200677545ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761721262; x=1762326062;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcrI9uNCC70IrglPKj0P6PuwObxX3vvMVlJlR7SDlk0=;
        b=nSNPx1GKAJTC05vwiUSJteUOAG+m7+7RxXnfBKsMs5iYtkFDQkNlj9jJ0dWN3cBo3l
         rFY/Bh5zYGa95qKQZ+C62xE3adQ8xITe8m2C0ipSSaSzcByQPBaD9d1z2OBeXuth7062
         1gajGMeLeEQ5xSdCSCJzCfLhGmvcujWYYFZe2/TR/9vA96CmsG4ir07/i/ccKSCL036R
         5uEZidvlWIAeFDNRQhrE7lc8J4ou68a3PPm3AJqknT9It5K/UMgG7AC80P3NEJ0fWCmI
         Jk01Ab0kgg1CPKhX2/zOtgkDYcQo4qrGpgygIaktNoEzoxrThqXGZgy5HVR2uAr/ZAnq
         U64w==
X-Forwarded-Encrypted: i=1; AJvYcCW4TyI5tcAg54fQ2Q2tQleT+UgIxZOReplMGXdMmqCvZvx7mtM0AK0ufr3n+fsjE2zMYxmXvRqH5ToUKjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMhQhcDr4GxtFHlnHgkJoCn0D+5LzAfn/DncE65PMp/Akj1Sp
	Ie4yhOhfk/+LJtJjXlfBrVo19Ya5RL0OAJtNQzbnhc6YcaY/iWcoMhRmJTmUIZ6yA5LN0Xwfzif
	n2RO5knw6J4WhG4+CmnRTzs/7H/V20/V0GXWOlWXh635KXF5+pQI8mHcl0QI=
X-Google-Smtp-Source: AGHT+IGP2zMgnwCTd5mQkT4w6xaYo4KP+CdhVBbNypQKS77IuQgPaOTNJVWg5IIxqfo00veUfPrIGGuL8p7885hmjuonP53HweuQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1805:b0:426:2f95:31a5 with SMTP id
 e9e14a558f8ab-432f9066ed8mr29192605ab.29.1761721262117; Wed, 29 Oct 2025
 00:01:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 00:01:02 -0700
In-Reply-To: <20251029062151.JL5ts%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901bbae.050a0220.3344a1.0411.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 be fragmented on layer2 which could impact the performance. Setting the MT=
U to 1560 would solve the problem.
[   50.603759][ T6071] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   50.628055][ T6071] device hsr_slave_0 entered promiscuous mode
[   50.634560][ T6071] device hsr_slave_1 entered promiscuous mode
[   50.690268][ T6071] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   50.700195][ T6071] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   50.709781][ T6071] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   50.722637][ T6071] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   50.757730][ T6071] 8021q: adding VLAN 0 to HW filter on device bond0
[   50.772305][  T680] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes r=
eady
[   50.781426][  T680] IPv6: ADDRCONF(NETDEV_CHANGE): veth1: link becomes r=
eady
[   50.789385][  T680] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes r=
eady
[   50.801728][ T6071] 8021q: adding VLAN 0 to HW filter on device team0
[   50.812600][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_bridge: link=
 becomes ready
[   50.821807][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_0: link =
becomes ready
[   50.831543][  T495] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.838798][  T495] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   50.847790][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): bridge0: link becomes=
 ready
[   50.857308][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_bridge: link=
 becomes ready
[   50.866275][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): bridge_slave_1: link =
becomes ready
[   50.874998][  T495] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.882080][  T495] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   50.908369][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_0: link be=
comes ready
[   50.917270][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): team_slave_1: link be=
comes ready
[   50.926633][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_0: link bec=
omes ready
[   50.935710][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): hsr_slave_1: link bec=
omes ready
[   50.945718][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): team0: link becomes r=
eady
[   50.954815][ T6071] IPv6: ADDRCONF(NETDEV_CHANGE): hsr0: link becomes re=
ady
[   51.012168][  T843] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan1: link becomes =
ready
[   51.020300][  T843] IPv6: ADDRCONF(NETDEV_CHANGE): vxcan0: link becomes =
ready
[   51.030927][ T6071] 8021q: adding VLAN 0 to HW filter on device batadv0
[   51.044963][  T843] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_virt_wifi: link=
 becomes ready
[   51.063818][  T843] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_vlan: link beco=
mes ready
[   51.073031][  T843] IPv6: ADDRCONF(NETDEV_CHANGE): vlan0: link becomes r=
eady
[   51.080851][  T843] IPv6: ADDRCONF(NETDEV_CHANGE): vlan1: link becomes r=
eady
[   51.090327][ T6071] device veth0_vlan entered promiscuous mode
[   51.100297][ T6071] device veth1_vlan entered promiscuous mode
[   51.115040][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan0: link become=
s ready
[   51.123244][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): macvlan1: link become=
s ready
[   51.131473][  T495] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_macvtap: link b=
ecomes ready
[   51.141583][ T6071] device veth0_macvtap entered promiscuous mode
[   51.149837][ T6071] device veth1_macvtap entered promiscuous mode
[   51.162533][ T6071] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   51.170055][  T680] IPv6: ADDRCONF(NETDEV_CHANGE): veth0_to_batadv: link=
 becomes ready
[   51.179726][  T680] IPv6: ADDRCONF(NETDEV_CHANGE): macvtap0: link become=
s ready
[   51.190174][ T6071] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   51.198081][  T680] IPv6: ADDRCONF(NETDEV_CHANGE): veth1_to_batadv: link=
 becomes ready
[   51.210537][ T6071] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   51.219647][ T6071] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   51.228883][ T6071] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   51.237581][ T6071] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   51.286123][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   51.295816][    C0] UBSAN: signed-integer-overflow in ./arch/x86/include=
/asm/atomic.h:165:11
[   51.304667][    C0] 1999955851 + 717459701 cannot be represented in type=
 'int'
[   51.312050][    C0] CPU: 0 PID: 6087 Comm: modprobe Not tainted syzkalle=
r #0
[   51.319308][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   51.329714][    C0] Call Trace:
[   51.333454][    C0]  <IRQ>
[   51.336393][    C0]  dump_stack+0xfd/0x16e
[   51.340707][    C0]  ubsan_epilogue+0xa/0x30
[   51.345100][    C0]  handle_overflow+0x192/0x1b0
[   51.350225][    C0]  ? prandom_u32+0x1d/0x1f0
[   51.354817][    C0]  ip_idents_reserve+0x14a/0x170
[   51.359753][    C0]  __ip_select_ident+0xe4/0x1c0
[   51.364781][    C0]  iptunnel_xmit+0x466/0x7b0
[   51.369445][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   51.374631][    C0]  geneve_xmit+0x1d05/0x2140
[   51.379381][    C0]  dev_hard_start_xmit+0x294/0x780
[   51.384692][    C0]  __dev_queue_xmit+0x1678/0x28b0
[   51.390007][    C0]  ip6_finish_output2+0x1020/0x1490
[   51.395956][    C0]  NF_HOOK+0x45/0x2c0
[   51.400108][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   51.404792][    C0]  mld_sendpack+0x5f9/0xa70
[   51.409535][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   51.415000][    C0]  ? lock_acquire+0x78/0x310
[   51.419746][    C0]  ? lock_release+0x69/0x610
[   51.424991][    C0]  ? debug_object_deactivate+0x9b/0x250
[   51.430534][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.435630][    C0]  call_timer_fn+0x105/0x440
[   51.440234][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.445680][    C0]  __run_timers+0x5d8/0x7a0
[   51.450943][    C0]  ? __do_softirq+0x164/0x8ae
[   51.455910][    C0]  run_timer_softirq+0x19/0x30
[   51.460883][    C0]  __do_softirq+0x23c/0x8ae
[   51.465518][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   51.471090][    C0]  asm_call_irq_on_stack+0xf/0x20
[   51.476189][    C0]  </IRQ>
[   51.479317][    C0]  do_softirq_own_stack+0x6d/0xb0
[   51.484818][    C0]  __irq_exit_rcu+0x1e1/0x1f0
[   51.489844][    C0]  irq_exit_rcu+0x5/0x20
[   51.494403][    C0]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   51.500226][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   51.506392][    C0] RIP: 0010:find_next_bit+0x4d/0x100
[   51.512330][    C0] Code: 49 39 de 0f 83 c9 00 00 00 49 bd 00 00 00 00 0=
0 fc ff df 4c 89 f0 48 c1 e8 06 4d 8d 24 c7 4c 89 e0 48 c1 e8 03 42 80 3c 2=
8 00 <74> 08 4c 89 e7 e8 69 40 2b fe 4d 8b 24 24 44 89 f1 49 d3 ec 49 d3
[   51.532540][    C0] RSP: 0000:ffffc9000197fb88 EFLAGS: 00000246
[   51.539059][    C0] RAX: 1ffff1100369cd09 RBX: 0000000000000008 RCX: fff=
f88802a750000
[   51.548074][    C0] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000=
0000000000000
[   51.557334][    C0] RBP: 00007fbce0785000 R08: dffffc0000000000 R09: fff=
ffbfff1843df6
[   51.565473][    C0] R10: fffffbfff1843df6 R11: 1ffffffff1843df5 R12: fff=
f88801b4e6848
[   51.573525][    C0] R13: dffffc0000000000 R14: 0000000000000000 R15: fff=
f88801b4e6848
[   51.581589][    C0]  ? find_next_bit+0x23/0x100
[   51.586345][    C0]  ? cpumask_any_but+0x34/0x240
[   51.591189][    C0]  cpumask_any_but+0x4f/0x240
[   51.596049][    C0]  ? flush_tlb_mm_range+0x201/0x380
[   51.601359][    C0]  flush_tlb_mm_range+0x215/0x380
[   51.606382][    C0]  ptep_clear_flush+0x112/0x150
[   51.611245][    C0]  wp_page_copy+0x9d6/0x1460
[   51.616083][    C0]  handle_mm_fault+0xe2f/0x2930
[   51.620923][    C0]  ? lock_acquire+0x78/0x310
[   51.625527][    C0]  do_user_addr_fault+0x468/0xa50
[   51.630531][    C0]  ? asm_exc_page_fault+0x8/0x30
[   51.635455][    C0]  exc_page_fault+0x67/0x100
[   51.640033][    C0]  asm_exc_page_fault+0x1e/0x30
[   51.644957][    C0] RIP: 0033:0x7fbce0a8d418
[   51.649464][    C0] Code: fe ff ff 0f 1f 80 00 00 00 00 48 85 f6 0f 84 a=
f 00 00 00 41 f6 85 56 03 00 00 20 0f 85 a1 00 00 00 49 8b 45 60 48 85 c0 7=
4 04 <48> 01 70 08 49 8b 45 58 48 85 c0 74 04 48 01 70 08 49 8b 45 68 48
[   51.669510][    C0] RSP: 002b:00007fff1b7ea470 EFLAGS: 00010206
[   51.675853][    C0] RAX: 00007fbce0784e48 RBX: 0000000000000030 RCX: 000=
07fbce0787100
[   51.684075][    C0] RDX: 00007fbce0784f78 RSI: 00007fbce077d000 RDI: 000=
000006fffffff
[   51.692270][    C0] RBP: 00007fff1b7ea5c0 R08: 0000000000000006 R09: 000=
00000effffef5
[   51.700403][    C0] R10: 0000000070000029 R11: 00007fff1b7ea6a8 R12: 000=
07fff1b7ea320
[   51.708359][    C0] R13: 00007fbce07870c0 R14: 00007fff1b7ea660 R15: 000=
07fbce0786000
[   51.716524][    C0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   51.726370][    C0] Kernel panic - not syncing: UBSAN: panic_on_warn set=
 ...
[   51.733553][    C0] CPU: 0 PID: 6087 Comm: modprobe Not tainted syzkalle=
r #0
[   51.741165][    C0] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   51.751296][    C0] Call Trace:
[   51.754602][    C0]  <IRQ>
[   51.757794][    C0]  dump_stack+0xfd/0x16e
[   51.762149][    C0]  panic+0x2f0/0x9c0
[   51.766043][    C0]  check_panic_on_warn+0x95/0xe0
[   51.771275][    C0]  handle_overflow+0x192/0x1b0
[   51.776058][    C0]  ? prandom_u32+0x1d/0x1f0
[   51.780668][    C0]  ip_idents_reserve+0x14a/0x170
[   51.785686][    C0]  __ip_select_ident+0xe4/0x1c0
[   51.790861][    C0]  iptunnel_xmit+0x466/0x7b0
[   51.795429][    C0]  udp_tunnel_xmit_skb+0x1ba/0x290
[   51.800528][    C0]  geneve_xmit+0x1d05/0x2140
[   51.805139][    C0]  dev_hard_start_xmit+0x294/0x780
[   51.810503][    C0]  __dev_queue_xmit+0x1678/0x28b0
[   51.815601][    C0]  ip6_finish_output2+0x1020/0x1490
[   51.820885][    C0]  NF_HOOK+0x45/0x2c0
[   51.825036][    C0]  ? NF_HOOK+0x2c0/0x2c0
[   51.829388][    C0]  mld_sendpack+0x5f9/0xa70
[   51.833972][    C0]  mld_ifc_timer_expire+0x7e1/0x990
[   51.839158][    C0]  ? lock_acquire+0x78/0x310
[   51.843815][    C0]  ? lock_release+0x69/0x610
[   51.848385][    C0]  ? debug_object_deactivate+0x9b/0x250
[   51.854001][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.859287][    C0]  call_timer_fn+0x105/0x440
[   51.863873][    C0]  ? mld_gq_timer_expire+0xe0/0xe0
[   51.869096][    C0]  __run_timers+0x5d8/0x7a0
[   51.873677][    C0]  ? __do_softirq+0x164/0x8ae
[   51.878688][    C0]  run_timer_softirq+0x19/0x30
[   51.883527][    C0]  __do_softirq+0x23c/0x8ae
[   51.888285][    C0]  ? asm_call_irq_on_stack+0xf/0x20
[   51.893620][    C0]  asm_call_irq_on_stack+0xf/0x20
[   51.898854][    C0]  </IRQ>
[   51.901776][    C0]  do_softirq_own_stack+0x6d/0xb0
[   51.907074][    C0]  __irq_exit_rcu+0x1e1/0x1f0
[   51.911821][    C0]  irq_exit_rcu+0x5/0x20
[   51.916139][    C0]  sysvec_apic_timer_interrupt+0x9d/0xb0
[   51.922175][    C0]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[   51.928546][    C0] RIP: 0010:find_next_bit+0x4d/0x100
[   51.934285][    C0] Code: 49 39 de 0f 83 c9 00 00 00 49 bd 00 00 00 00 0=
0 fc ff df 4c 89 f0 48 c1 e8 06 4d 8d 24 c7 4c 89 e0 48 c1 e8 03 42 80 3c 2=
8 00 <74> 08 4c 89 e7 e8 69 40 2b fe 4d 8b 24 24 44 89 f1 49 d3 ec 49 d3
[   51.954297][    C0] RSP: 0000:ffffc9000197fb88 EFLAGS: 00000246
[   51.961947][    C0] RAX: 1ffff1100369cd09 RBX: 0000000000000008 RCX: fff=
f88802a750000
[   51.970379][    C0] RDX: 0000000000000000 RSI: 0000000000000008 RDI: 000=
0000000000000
[   51.978484][    C0] RBP: 00007fbce0785000 R08: dffffc0000000000 R09: fff=
ffbfff1843df6
[   51.987016][    C0] R10: fffffbfff1843df6 R11: 1ffffffff1843df5 R12: fff=
f88801b4e6848
[   51.995520][    C0] R13: dffffc0000000000 R14: 0000000000000000 R15: fff=
f88801b4e6848
[   52.003868][    C0]  ? find_next_bit+0x23/0x100
[   52.008862][    C0]  ? cpumask_any_but+0x34/0x240
[   52.014719][    C0]  cpumask_any_but+0x4f/0x240
[   52.020280][    C0]  ? flush_tlb_mm_range+0x201/0x380
[   52.026063][    C0]  flush_tlb_mm_range+0x215/0x380
[   52.032125][    C0]  ptep_clear_flush+0x112/0x150
[   52.037062][    C0]  wp_page_copy+0x9d6/0x1460
[   52.041758][    C0]  handle_mm_fault+0xe2f/0x2930
[   52.046829][    C0]  ? lock_acquire+0x78/0x310
[   52.051409][    C0]  do_user_addr_fault+0x468/0xa50
[   52.056512][    C0]  ? asm_exc_page_fault+0x8/0x30
[   52.061484][    C0]  exc_page_fault+0x67/0x100
[   52.066226][    C0]  asm_exc_page_fault+0x1e/0x30
[   52.071050][    C0] RIP: 0033:0x7fbce0a8d418
[   52.075555][    C0] Code: fe ff ff 0f 1f 80 00 00 00 00 48 85 f6 0f 84 a=
f 00 00 00 41 f6 85 56 03 00 00 20 0f 85 a1 00 00 00 49 8b 45 60 48 85 c0 7=
4 04 <48> 01 70 08 49 8b 45 58 48 85 c0 74 04 48 01 70 08 49 8b 45 68 48
[   52.095670][    C0] RSP: 002b:00007fff1b7ea470 EFLAGS: 00010206
[   52.101714][    C0] RAX: 00007fbce0784e48 RBX: 0000000000000030 RCX: 000=
07fbce0787100
[   52.109674][    C0] RDX: 00007fbce0784f78 RSI: 00007fbce077d000 RDI: 000=
000006fffffff
[   52.117882][    C0] RBP: 00007fff1b7ea5c0 R08: 0000000000000006 R09: 000=
00000effffef5
[   52.126099][    C0] R10: 0000000070000029 R11: 00007fff1b7ea6a8 R12: 000=
07fff1b7ea320
[   52.134305][    C0] R13: 00007fbce07870c0 R14: 00007fff1b7ea660 R15: 000=
07fbce0786000
[   52.142669][    C0] Kernel Offset: disabled
[   52.147032][    C0] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build2982762739=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at 7368264b463
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
/syzkaller/prog.GitRevision=3D7368264b463a401571d2eb381f50ea2a758e9d05 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250801-160258"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"7368264b463a401571d2eb381f50ea2a75=
8e9d05\"
/usr/bin/ld: /tmp/ccSiEudZ.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14449c92580000


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linu=
x.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D39182a54870857e=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D5054473a31f78f735=
416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D145b67045800=
00


