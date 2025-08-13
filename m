Return-Path: <linux-kernel+bounces-765875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68546B23F65
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410CF1AA2D12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D8523D7FC;
	Wed, 13 Aug 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="t1MKbTX7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C61A9F94
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 04:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755058543; cv=none; b=kLYKbMbqBmWs0tM2TxrTpG72kZoC0hpYY7agOfOPcC3sUaXUVX852Zwq3xrCa29EQI8w4R4MEQUGf0xhcyLe0W/ODoXhTNtcEn1YqBXtQIhFR4Zt803CqI8uUgU2mEuiZVJAGcSL/Iz4ih+HFwKA2SWKXn22ZmUpww/yL9jyTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755058543; c=relaxed/simple;
	bh=JJlNurtq9ZuBDAnkQpjt934Tcwy4zThN2OvI7/xvHFw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=LpUWaAkIPmR149xJaMCyHo2f1MmCSm2B0XQv+OgKjoIEj9z9LFlRaxlv+7P73Of5HWmCeMDgz99fVjuNHobI9bGcPyUZOEX2hwl9BiClvKHYXEYmJrPl5JnBFVCz5PbD2XnYoaWW8/TyY4DVq03TioXIx8fR5iPa434RijcdWGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=t1MKbTX7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755058537; x=1755663337; i=efault@gmx.de;
	bh=smOFMOBK3OqwbF9fj13v5zOhs6Zoz8Bib51TbNDXqI0=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t1MKbTX7SMqrkInXRQyi/79Oelr14Bp3QuImenJ8mLWVd++UpE2w8VJmC3xXIF0a
	 bu7+0RnEB98C+syXrKkTqcCBqj+vNxOV4U2+mIaqY+EJGWhcloc9Zfc14vVEYXu+a
	 Io2wRfNFlQPpDX1alAcP0yMxfrBN6wW5W9QPjraPlT4MXZtnxBT82VHVqfvnWIM/v
	 6ZoYIjD6mUbPjqG0M6bQTHWxMXyb2CuVUkHCEObL+akabVJlwj9YJYigVo6vvuZvh
	 amWjil3WFTflX60PqAXy25WzlddxMRrmmZwGt2JD1P3YW0zIuHVPerjP6tpKCVo3k
	 El6ymR/Z3x4txQR7ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.70]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPokD-1v07dz3jZz-00NExa; Wed, 13
 Aug 2025 06:15:36 +0200
Message-ID: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
Subject: netconsole:  HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>
Date: Wed, 13 Aug 2025 06:14:36 +0200
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:dkrkqHvuhm+aAmgG1IJYAoFVicmcJ+Pyp1wd1PBRswwGfOC2+5s
 51FWJT9oVoHCjBj8yNVFXwEk0fKh7FsMKWjZ3Eq1iad9NkAJx7EyynzJZX7nG7oalv40YFL
 068lM4pNlsXsZqCTHNhPU+3EoWYXVqmo8utNSzv9WN85Vuu2Fp3wJdKdmwuBt16JCjBvZhI
 hvnmw4j1LUJ74hzgiFfnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BGK1lmrejJY=;Iz1XGPKKTgEx1D1RMpQQn9ZidZ0
 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
 HT+3hvfc7Hw==

Greetings,

Netconsole works peachy for my r8169 equipped desktop box, but HP lappy
with Intel wireless grumbles w/wo lockdep enabled (see mutterings below
lock order complaint).

bart:/root # hwinfo --netcard
11: PCI 200.0: 0282 WLAN controller                            =20
  [Created at pci.387]
  Unique ID: y9sn.0LuFraIuP2D
  Parent ID: qTvu.sUcXY2K9Kn9
  SysFS ID: /devices/pci0000:00/0000:00:1c.1/0000:02:00.0
  SysFS BusID: 0000:02:00.0
  Hardware Class: network
  Device Name: "Intel Stone Peak 2  7265 Combo /NON-vPro NGFF Combo Wireles=
s-AC 7265"
  Model: "Intel Dual Band Wireless-AC 7265"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x095a "Wireless 7265"
  SubVendor: pci 0x8086 "Intel Corporation"
  SubDevice: pci 0x5010 "Dual Band Wireless-AC 7265"

[  106.798290] netconsole: network logging started
[  106.806110] netconsole: network logging has already stopped
[  107.969494] printk: legacy console [netcon0] enabled
[  107.969759] netconsole: netconsole: local port 6665
[  107.969831] netconsole: netconsole: local IPv4 address 192.168.178.4
[  107.969871] netconsole: netconsole: interface name 'wlan0'
[  107.969904] netconsole: netconsole: local ethernet address '00:00:00:00:=
00:00'
[  107.969945] netconsole: netconsole: remote port 6666
[  107.969977] netconsole: netconsole: remote IPv4 address 192.168.178.3
[  107.970014] netconsole: netconsole: remote ethernet address d4:3d:7e:fc:=
4f:09
[  107.983276] netconsole: network logging started

[  107.983687] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[  107.983689] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[  107.983692] 6.17.0.g8742b2d8-master #195 Tainted: G          I       =
=20
[  107.983695] -----------------------------------------------------
[  107.983696] netconsole.sh/4031 [HC0[0]:SC0[2]:HE0:SE0] is trying to acqu=
ire:
[  107.983700] ffff8a0101b80f58 (&fq->lock){+.-.}-{3:3}, at: ieee80211_queu=
e_skb+0xfd/0x350 [mac80211]
[  107.983855]=20
               and this task is already holding:
[  107.983856] ffffffffc1ab9ad8 (target_list_lock){....}-{3:3}, at: write_m=
sg+0x4c/0x120 [netconsole]
[  107.983869] which would create a new lock dependency:
[  107.983870]  (target_list_lock){....}-{3:3} -> (&fq->lock){+.-.}-{3:3}
[  107.983876]=20
               but this new dependency connects a HARDIRQ-irq-safe lock:
[  107.983878]  (console_owner){-...}-{0:0}
[  107.983880]=20
               ... which became HARDIRQ-irq-safe at:
[  107.983882]   __lock_acquire+0x3d6/0xbc0
[  107.983889]   lock_acquire.part.0+0xa1/0x210
[  107.983893]   console_lock_spinning_enable+0x5e/0x60
[  107.983899]   console_emit_next_record+0xde/0x250
[  107.983904]   console_flush_all+0x24d/0x370
[  107.983909]   console_unlock+0x66/0x130
[  107.983914]   vprintk_emit+0x142/0x360
[  107.983918]   dev_vprintk_emit+0x4e/0x70
[  107.983923]   dev_printk_emit+0x51/0x70
[  107.983927]   _dev_warn+0x6f/0x85
[  107.983931]   atkbd_receive_byte.cold+0x96/0xe5
[  107.983935]   ps2_interrupt+0x9e/0x1a0
[  107.983941]   serio_interrupt+0x44/0x90
[  107.983945]   i8042_handle_data+0x108/0x260
[  107.983949]   i8042_interrupt+0x11/0x30
[  107.983953]   __handle_irq_event_percpu+0x81/0x280
[  107.983957]   handle_irq_event+0x38/0x80
[  107.983960]   handle_edge_irq+0xd9/0x1c0
[  107.983965]   __common_interrupt+0x70/0x180
[  107.983971]   common_interrupt+0xb7/0xe0
[  107.983976]   asm_common_interrupt+0x26/0x40
[  107.983979]   ___slab_alloc+0x291/0xe60
[  107.983983]   __slab_alloc.isra.0+0x52/0x90
[  107.983985]   kmem_cache_alloc_noprof+0xc9/0x470
[  107.983988]   vm_area_dup+0x25/0x170
[  107.983992]   dup_mmap+0x29c/0x860
[  107.983995]   dup_mm.constprop.0+0x65/0x130
[  107.983998]   copy_process+0x105f/0x1a90
[  107.984000]   kernel_clone+0x98/0x410
[  107.984003]   __do_sys_clone+0x65/0x90
[  107.984005]   do_syscall_64+0x94/0xa10
[  107.984010]   entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.984013]=20
               to a HARDIRQ-irq-unsafe lock:
[  107.984014]  (&fq->lock){+.-.}-{3:3}
[  107.984017]=20
               ... which became HARDIRQ-irq-unsafe at:
[  107.984018] ...
[  107.984019]   __lock_acquire+0x3d6/0xbc0
[  107.984023]   lock_acquire.part.0+0xa1/0x210
[  107.984027]   _raw_spin_lock_bh+0x38/0x50
[  107.984030]   ieee80211_get_txq_stats+0x30/0x190 [mac80211]
[  107.984161]   nl80211_send_iface+0x369/0x820 [cfg80211]
[  107.984295]   nl80211_notify_iface+0x4c/0xb0 [cfg80211]
[  107.984403]   cfg80211_register_netdevice+0x6f/0xe0 [cfg80211]
[  107.984514]   ieee80211_if_add+0x3ba/0x670 [mac80211]
[  107.984640]   ieee80211_register_hw+0xca6/0xcd0 [mac80211]
[  107.984757]   iwl_mvm_mac_setup_register+0xbe6/0xde0 [iwlmvm]
[  107.984789]   iwl_mvm_start_post_nvm+0x5f/0xd0 [iwlmvm]
[  107.984819]   iwl_op_mode_mvm_start+0xbc5/0xca0 [iwlmvm]
[  107.984846]   _iwl_op_mode_start.isra.0+0x3f/0xb0 [iwlwifi]
[  107.984880]   iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[  107.984909]   cmac_clone_tfm+0x18/0x30 [cmac]
[  107.984914]   do_one_initcall+0x57/0x370
[  107.984920]   do_init_module+0x60/0x220
[  107.984924]   init_module_from_file+0x85/0xc0
[  107.984927]   idempotent_init_module+0x104/0x300
[  107.984930]   __x64_sys_finit_module+0x6d/0xd0
[  107.984933]   do_syscall_64+0x94/0xa10
[  107.984938]   entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.984941]=20
               other info that might help us debug this:

[  107.984942] Chain exists of:
                 console_owner --> target_list_lock --> &fq->lock

[  107.984947]  Possible interrupt unsafe locking scenario:

[  107.984948]        CPU0                    CPU1
[  107.984949]        ----                    ----
[  107.984950]   lock(&fq->lock);
[  107.984952]                                local_irq_disable();
[  107.984952]                                lock(console_owner);
[  107.984954]                                lock(target_list_lock);
[  107.984956]   <Interrupt>
[  107.984957]     lock(console_owner);
[  107.984959]=20
                *** DEADLOCK ***

[  107.984959] 12 locks held by netconsole.sh/4031:
[  107.984962]  #0: ffff8a010e32e428 (sb_writers#14){.+.+}-{0:0}, at: ksys_=
write+0x69/0xe0
[  107.984972]  #1: ffff8a0105152d88 (&buffer->mutex){+.+.}-{4:4}, at: conf=
igfs_write_iter+0x2e/0x120 [configfs]
[  107.984983]  #2: ffff8a01142ae5b8 (&p->frag_sem){.+.+}-{4:4}, at: config=
fs_write_iter+0x9b/0x120 [configfs]
[  107.984991]  #3: ffffffffc1ab9688 (dynamic_netconsole_mutex){+.+.}-{4:4}=
, at: enabled_store+0x42/0x300 [netconsole]
[  107.985001]  #4: ffffffff9076e800 (console_lock){+.+.}-{0:0}, at: _print=
k+0x5b/0x80
[  107.985009]  #5: ffffffff9076e850 (console_srcu){....}-{0:0}, at: consol=
e_flush_all+0x3b/0x370
[  107.985018]  #6: ffffffff9068e440 (console_owner){-...}-{0:0}, at: conso=
le_lock_spinning_enable+0x42/0x60
[  107.985026]  #7: ffffffff9068e3c0 (printk_legacy_map-wait-type-override)=
{....}-{4:4}, at: console_emit_next_record+0x1de/0x250
[  107.985034]  #8: ffffffffc1ab9ad8 (target_list_lock){....}-{3:3}, at: wr=
ite_msg+0x4c/0x120 [netconsole]
[  107.985042]  #9: ffffffff907713c0 (rcu_read_lock){....}-{1:3}, at: __net=
poll_send_skb+0x4a/0x3b0
[  107.985049]  #10: ffff8a0107196918 (_xmit_ETHER#2){+.-.}-{3:3}, at: __ne=
tpoll_send_skb+0x2e0/0x3b0
[  107.985056]  #11: ffffffff907713c0 (rcu_read_lock){....}-{1:3}, at: __ie=
ee80211_subif_start_xmit+0xb2/0x3d0 [mac80211]
[  107.985189]=20
               the dependencies between HARDIRQ-irq-safe lock and the holdi=
ng lock:
[  107.985191]  -> (console_owner){-...}-{0:0} {
[  107.985195]     IN-HARDIRQ-W at:
[  107.985196]                       __lock_acquire+0x3d6/0xbc0
[  107.985201]                       lock_acquire.part.0+0xa1/0x210
[  107.985205]                       console_lock_spinning_enable+0x5e/0x60
[  107.985210]                       console_emit_next_record+0xde/0x250
[  107.985215]                       console_flush_all+0x24d/0x370
[  107.985220]                       console_unlock+0x66/0x130
[  107.985224]                       vprintk_emit+0x142/0x360
[  107.985229]                       dev_vprintk_emit+0x4e/0x70
[  107.985234]                       dev_printk_emit+0x51/0x70
[  107.985237]                       _dev_warn+0x6f/0x85
[  107.985241]                       atkbd_receive_byte.cold+0x96/0xe5
[  107.985245]                       ps2_interrupt+0x9e/0x1a0
[  107.985250]                       serio_interrupt+0x44/0x90
[  107.985254]                       i8042_handle_data+0x108/0x260
[  107.985258]                       i8042_interrupt+0x11/0x30
[  107.985262]                       __handle_irq_event_percpu+0x81/0x280
[  107.985266]                       handle_irq_event+0x38/0x80
[  107.985269]                       handle_edge_irq+0xd9/0x1c0
[  107.985274]                       __common_interrupt+0x70/0x180
[  107.985279]                       common_interrupt+0xb7/0xe0
[  107.985285]                       asm_common_interrupt+0x26/0x40
[  107.985287]                       ___slab_alloc+0x291/0xe60
[  107.985290]                       __slab_alloc.isra.0+0x52/0x90
[  107.985292]                       kmem_cache_alloc_noprof+0xc9/0x470
[  107.985295]                       vm_area_dup+0x25/0x170
[  107.985299]                       dup_mmap+0x29c/0x860
[  107.985303]                       dup_mm.constprop.0+0x65/0x130
[  107.985305]                       copy_process+0x105f/0x1a90
[  107.985308]                       kernel_clone+0x98/0x410
[  107.985310]                       __do_sys_clone+0x65/0x90
[  107.985313]                       do_syscall_64+0x94/0xa10
[  107.985317]                       entry_SYSCALL_64_after_hwframe+0x4b/0x=
53
[  107.985321]     INITIAL USE at:
[  107.985322]                      __lock_acquire+0x3d6/0xbc0
[  107.985326]                      lock_acquire.part.0+0xa1/0x210
[  107.985329]                      console_lock_spinning_enable+0x5e/0x60
[  107.985334]                      console_emit_next_record+0x1cc/0x250
[  107.985339]                      console_flush_all+0x24d/0x370
[  107.985344]                      console_unlock+0x66/0x130
[  107.985348]                      vprintk_emit+0x142/0x360
[  107.985353]                      _printk+0x5b/0x80
[  107.985358]                      register_console.cold+0x46/0xaa
[  107.985363]                      con_init+0x237/0x240
[  107.985367]                      console_init+0x11c/0x1a0
[  107.985371]                      start_kernel+0x33f/0x470
[  107.985376]                      x86_64_start_reservations+0x24/0x30
[  107.985379]                      x86_64_start_kernel+0xce/0xd0
[  107.985382]                      common_startup_64+0x13e/0x141
[  107.985385]   }
[  107.985386]   ... key      at: [<ffffffff9068e440>] console_owner_dep_ma=
p+0x0/0x40
[  107.985391] -> (target_list_lock){....}-{3:3} {
[  107.985394]    INITIAL USE at:
[  107.985396]                    __lock_acquire+0x3d6/0xbc0
[  107.985400]                    lock_acquire.part.0+0xa1/0x210
[  107.985403]                    _raw_spin_lock_irqsave+0x3f/0x60
[  107.985406]                    make_netconsole_target+0xd8/0x1b0 [netcon=
sole]
[  107.985412]                    configfs_mkdir+0x1c8/0x510 [configfs]
[  107.985419]                    vfs_mkdir+0x19d/0x270
[  107.985423]                    do_mkdirat+0x13c/0x180
[  107.985426]                    __x64_sys_mkdir+0x46/0x60
[  107.985430]                    do_syscall_64+0x94/0xa10
[  107.985434]                    entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.985437]  }
[  107.985438]  ... key      at: [<ffffffffc1ab9ad8>] target_list_lock+0x18=
/0xffffffffffe48540 [netconsole]
[  107.985445]  ... acquired at:
[  107.985446]    __lock_acquire+0x550/0xbc0
[  107.985450]    lock_acquire.part.0+0xa1/0x210
[  107.985453]    _raw_spin_lock_irqsave+0x3f/0x60
[  107.985455]    write_msg+0x4c/0x120 [netconsole]
[  107.985460]    console_emit_next_record+0x203/0x250
[  107.985465]    console_flush_all+0x24d/0x370
[  107.985470]    console_unlock+0x66/0x130
[  107.985474]    vprintk_emit+0x142/0x360
[  107.985479]    _printk+0x5b/0x80
[  107.985483]    register_console.cold+0x46/0xaa
[  107.985488]    enabled_store+0x23c/0x300 [netconsole]
[  107.985493]    configfs_write_iter+0xbd/0x120 [configfs]
[  107.985498]    vfs_write+0x213/0x520
[  107.985504]    ksys_write+0x69/0xe0
[  107.985506]    do_syscall_64+0x94/0xa10
[  107.985510]    entry_SYSCALL_64_after_hwframe+0x4b/0x53

[  107.985513]=20
               the dependencies between the lock to be acquired
[  107.985514]  and HARDIRQ-irq-unsafe lock:
[  107.985531] -> (&fq->lock){+.-.}-{3:3} {
[  107.985535]    HARDIRQ-ON-W at:
[  107.985537]                     __lock_acquire+0x3d6/0xbc0
[  107.985540]                     lock_acquire.part.0+0xa1/0x210
[  107.985544]                     _raw_spin_lock_bh+0x38/0x50
[  107.985546]                     ieee80211_get_txq_stats+0x30/0x190 [mac8=
0211]
[  107.985671]                     nl80211_send_iface+0x369/0x820 [cfg80211=
]
[  107.985785]                     nl80211_notify_iface+0x4c/0xb0 [cfg80211=
]
[  107.985888]                     cfg80211_register_netdevice+0x6f/0xe0 [c=
fg80211]
[  107.985998]                     ieee80211_if_add+0x3ba/0x670 [mac80211]
[  107.986122]                     ieee80211_register_hw+0xca6/0xcd0 [mac80=
211]
[  107.986237]                     iwl_mvm_mac_setup_register+0xbe6/0xde0 [=
iwlmvm]
[  107.986267]                     iwl_mvm_start_post_nvm+0x5f/0xd0 [iwlmvm=
]
[  107.986296]                     iwl_op_mode_mvm_start+0xbc5/0xca0 [iwlmv=
m]
[  107.986322]                     _iwl_op_mode_start.isra.0+0x3f/0xb0 [iwl=
wifi]
[  107.986353]                     iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[  107.986382]                     cmac_clone_tfm+0x18/0x30 [cmac]
[  107.986385]                     do_one_initcall+0x57/0x370
[  107.986390]                     do_init_module+0x60/0x220
[  107.986393]                     init_module_from_file+0x85/0xc0
[  107.986396]                     idempotent_init_module+0x104/0x300
[  107.986400]                     __x64_sys_finit_module+0x6d/0xd0
[  107.986403]                     do_syscall_64+0x94/0xa10
[  107.986407]                     entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.986410]    IN-SOFTIRQ-W at:
[  107.986412]                     __lock_acquire+0x3d6/0xbc0
[  107.986416]                     lock_acquire.part.0+0xa1/0x210
[  107.986419]                     _raw_spin_lock_bh+0x38/0x50
[  107.986422]                     ieee80211_queue_skb+0xfd/0x350 [mac80211=
]
[  107.986548]                     __ieee80211_xmit_fast+0x202/0x360 [mac80=
211]
[  107.986666]                     ieee80211_xmit_fast+0xfb/0x1f0 [mac80211=
]
[  107.986774]                     __ieee80211_subif_start_xmit+0x14e/0x3d0=
 [mac80211]
[  107.986881]                     ieee80211_subif_start_xmit+0x46/0x230 [m=
ac80211]
[  107.986983]                     dev_hard_start_xmit+0xa9/0x290
[  107.986989]                     __dev_queue_xmit+0x1bc/0xc20
[  107.986995]                     ip_finish_output2+0x1f7/0x800
[  107.986999]                     ip_output+0xb3/0x3c0
[  107.987002]                     igmp_ifc_timer_expire+0x21/0xf0
[  107.987005]                     call_timer_fn+0xa5/0x250
[  107.987009]                     __run_timers+0x1f2/0x2c0
[  107.987011]                     run_timer_base+0x46/0x60
[  107.987014]                     run_timer_softirq+0x1a/0x30
[  107.987017]                     handle_softirqs+0xdb/0x3f0
[  107.987020]                     __irq_exit_rcu+0xc1/0x130
[  107.987022]                     irq_exit_rcu+0xe/0x30
[  107.987025]                     sysvec_apic_timer_interrupt+0xa1/0xd0
[  107.987028]                     asm_sysvec_apic_timer_interrupt+0x1a/0x2=
0
[  107.987031]                     lock_is_held_type+0xee/0x120
[  107.987034]                     mem_cgroup_from_task+0x6c/0xb0
[  107.987039]                     handle_mm_fault+0x272/0x440
[  107.987045]                     do_user_addr_fault+0x207/0x680
[  107.987048]                     exc_page_fault+0x85/0x210
[  107.987051]                     asm_exc_page_fault+0x26/0x30
[  107.987054]    INITIAL USE at:
[  107.987055]                    __lock_acquire+0x3d6/0xbc0
[  107.987059]                    lock_acquire.part.0+0xa1/0x210
[  107.987063]                    _raw_spin_lock_bh+0x38/0x50
[  107.987065]                    ieee80211_get_txq_stats+0x30/0x190 [mac80=
211]
[  107.987191]                    nl80211_send_iface+0x369/0x820 [cfg80211]
[  107.987306]                    nl80211_notify_iface+0x4c/0xb0 [cfg80211]
[  107.987411]                    cfg80211_register_netdevice+0x6f/0xe0 [cf=
g80211]
[  107.987520]                    ieee80211_if_add+0x3ba/0x670 [mac80211]
[  107.987644]                    ieee80211_register_hw+0xca6/0xcd0 [mac802=
11]
[  107.987759]                    iwl_mvm_mac_setup_register+0xbe6/0xde0 [i=
wlmvm]
[  107.987788]                    iwl_mvm_start_post_nvm+0x5f/0xd0 [iwlmvm]
[  107.987817]                    iwl_op_mode_mvm_start+0xbc5/0xca0 [iwlmvm=
]
[  107.987843]                    _iwl_op_mode_start.isra.0+0x3f/0xb0 [iwlw=
ifi]
[  107.987874]                    iwl_opmode_register+0x6f/0xe0 [iwlwifi]
[  107.987903]                    cmac_clone_tfm+0x18/0x30 [cmac]
[  107.987906]                    do_one_initcall+0x57/0x370
[  107.987911]                    do_init_module+0x60/0x220
[  107.987914]                    init_module_from_file+0x85/0xc0
[  107.987917]                    idempotent_init_module+0x104/0x300
[  107.987920]                    __x64_sys_finit_module+0x6d/0xd0
[  107.987923]                    do_syscall_64+0x94/0xa10
[  107.987928]                    entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.987931]  }
[  107.987932]  ... key      at: [<ffffffffc1742030>] __key.11+0x0/0x10 [ma=
c80211]
[  107.988053]  ... acquired at:
[  107.988054]    check_prev_add+0xfb/0xca0
[  107.988058]    validate_chain+0x48c/0x530
[  107.988061]    __lock_acquire+0x550/0xbc0
[  107.988064]    lock_acquire.part.0+0xa1/0x210
[  107.988068]    _raw_spin_lock_bh+0x38/0x50
[  107.988070]    ieee80211_queue_skb+0xfd/0x350 [mac80211]
[  107.988198]    __ieee80211_xmit_fast+0x202/0x360 [mac80211]
[  107.988314]    ieee80211_xmit_fast+0xfb/0x1f0 [mac80211]
[  107.988424]    __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211]
[  107.988530]    ieee80211_subif_start_xmit+0x46/0x230 [mac80211]
[  107.988634]    netpoll_start_xmit+0x8b/0xd0
[  107.988638]    __netpoll_send_skb+0x329/0x3b0
[  107.988641]    write_msg+0x104/0x120 [netconsole]
[  107.988647]    console_emit_next_record+0x203/0x250
[  107.988652]    console_flush_all+0x24d/0x370
[  107.988657]    console_unlock+0x66/0x130
[  107.988662]    vprintk_emit+0x142/0x360
[  107.988666]    _printk+0x5b/0x80
[  107.988671]    enabled_store.cold+0x7e/0x83 [netconsole]
[  107.988677]    configfs_write_iter+0xbd/0x120 [configfs]
[  107.988683]    vfs_write+0x213/0x520
[  107.988689]    ksys_write+0x69/0xe0
[  107.988691]    do_syscall_64+0x94/0xa10
[  107.988695]    entry_SYSCALL_64_after_hwframe+0x4b/0x53

[  107.988699]=20
               stack backtrace:
[  107.988703] CPU: 0 UID: 0 PID: 4031 Comm: netconsole.sh Kdump: loaded Ta=
inted: G          I         6.17.0.g8742b2d8-master #195 PREEMPT(lazy)  b30=
3cf59d81e6fee2841762da0be977f2e8b800d
[  107.988711] Tainted: [I]=3DFIRMWARE_WORKAROUND
[  107.988712] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[  107.988714] Call Trace:
[  107.988716]  <TASK>
[  107.988720]  dump_stack_lvl+0x5b/0x80
[  107.988727]  print_bad_irq_dependency+0x2ba/0x2c0
[  107.988735]  check_irq_usage+0x36c/0x430
[  107.988745]  ? check_noncircular+0x81/0x150
[  107.988753]  ? check_prev_add+0xfb/0xca0
[  107.988757]  check_prev_add+0xfb/0xca0
[  107.988763]  validate_chain+0x48c/0x530
[  107.988769]  __lock_acquire+0x550/0xbc0
[  107.988776]  lock_acquire.part.0+0xa1/0x210
[  107.988781]  ? ieee80211_queue_skb+0xfd/0x350 [mac80211 6e705e26db77cf4a=
b5101c61ecbd7b898fac9e56]
[  107.988896]  ? rcu_is_watching+0x11/0x40
[  107.988903]  ? lock_acquire+0xee/0x130
[  107.988909]  _raw_spin_lock_bh+0x38/0x50
[  107.988912]  ? ieee80211_queue_skb+0xfd/0x350 [mac80211 6e705e26db77cf4a=
b5101c61ecbd7b898fac9e56]
[  107.989021]  ieee80211_queue_skb+0xfd/0x350 [mac80211 6e705e26db77cf4ab5=
101c61ecbd7b898fac9e56]
[  107.989128]  __ieee80211_xmit_fast+0x202/0x360 [mac80211 6e705e26db77cf4=
ab5101c61ecbd7b898fac9e56]
[  107.989239]  ? __skb_get_hash_net+0x54/0x1f0
[  107.989245]  ? __skb_get_hash_net+0x54/0x1f0
[  107.989254]  ieee80211_xmit_fast+0xfb/0x1f0 [mac80211 6e705e26db77cf4ab5=
101c61ecbd7b898fac9e56]
[  107.989362]  __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211 6e705e26=
db77cf4ab5101c61ecbd7b898fac9e56]
[  107.989465]  ? __lock_acquire+0x550/0xbc0
[  107.989474]  ieee80211_subif_start_xmit+0x46/0x230 [mac80211 6e705e26db7=
7cf4ab5101c61ecbd7b898fac9e56]
[  107.989576]  ? lock_acquire.part.0+0xb1/0x210
[  107.989584]  netpoll_start_xmit+0x8b/0xd0
[  107.989589]  __netpoll_send_skb+0x329/0x3b0
[  107.989595]  write_msg+0x104/0x120 [netconsole 641ec3b0b2ff98f93fe3092a7=
f84ed3654235c84]
[  107.989603]  ? console_emit_next_record+0x1de/0x250
[  107.989610]  console_emit_next_record+0x203/0x250
[  107.989615]  ? console_emit_next_record+0x1de/0x250
[  107.989624]  console_flush_all+0x24d/0x370
[  107.989629]  ? console_flush_all+0x3b/0x370
[  107.989637]  console_unlock+0x66/0x130
[  107.989644]  vprintk_emit+0x142/0x360
[  107.989652]  _printk+0x5b/0x80
[  107.989661]  enabled_store.cold+0x7e/0x83 [netconsole 641ec3b0b2ff98f93f=
e3092a7f84ed3654235c84]
[  107.989671]  configfs_write_iter+0xbd/0x120 [configfs fddadc1058896f4b55=
fcdc7e57d7a9a452005598]
[  107.989680]  vfs_write+0x213/0x520
[  107.989691]  ksys_write+0x69/0xe0
[  107.989695]  do_syscall_64+0x94/0xa10
[  107.989701]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.989704]  ? lockdep_hardirqs_on+0x78/0x100
[  107.989708]  ? do_syscall_64+0x139/0xa10
[  107.989713]  ? exc_page_fault+0x85/0x210
[  107.989716]  ? __lock_release.isra.0+0x5d/0x180
[  107.989721]  ? exc_page_fault+0x85/0x210
[  107.989724]  ? exc_page_fault+0x85/0x210
[  107.989726]  ? lock_release+0x86/0x150
[  107.989731]  ? exc_page_fault+0x116/0x210
[  107.989737]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.989740] RIP: 0033:0x7ff02f721000
[  107.989745] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  107.989748] RSP: 002b:00007ffd43e35dc8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[  107.989754] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff02f7=
21000
[  107.989757] RDX: 0000000000000002 RSI: 00005646d313ed00 RDI: 00000000000=
00001
[  107.989759] RBP: 00005646d313ed00 R08: 0000000000000000 R09: 00000000000=
00000
[  107.989761] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  107.989763] R13: 00007ff02f8005c0 R14: 00007ff02f7fdf60 R15: 00005646d31=
438e0
[  107.989772]  </TASK>
[  107.989850] ------------[ cut here ]------------
[  107.989852] WARNING: CPU: 0 PID: 4031 at net/mac80211/tx.c:3814 ieee8021=
1_tx_dequeue+0x71c/0x7e0 [mac80211]
[  107.989974] Modules linked in: netconsole ccm nf_nat_tftp nf_conntrack_t=
ftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rejec=
t_ipv4 nf_reject_ipv6 nft_reject nft_ct af_packet nft_chain_nat nf_nat nf_c=
onntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set nfnetlink cmac algi=
f_hash algif_skcipher af_alg iwlmvm binfmt_misc mac80211 snd_hda_codec_hdmi=
 snd_hda_codec_conexant snd_hda_codec_generic libarc4 intel_rapl_msr uvcvid=
eo intel_rapl_common snd_hda_intel btusb snd_intel_dspcfg x86_pkg_temp_ther=
mal btrtl intel_powerclamp uvc snd_hda_codec iwlwifi btbcm snd_hwdep videob=
uf2_vmalloc coretemp iTCO_wdt btintel nls_iso8859_1 mei_pxp snd_hda_core vi=
deobuf2_memops intel_pmc_bxt videobuf2_v4l2 nls_cp437 kvm_intel mei_hdcp iT=
CO_vendor_support snd_pcm videobuf2_common mfd_core bluetooth cfg80211 vide=
odev snd_timer kvm mc irqbypass mei_me snd i2c_i801 pcspkr rfkill soundcore=
 i2c_smbus mei thermal battery tiny_power_button ac button acpi_pad joydev =
sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[  107.990064]  dm_mod fuse configfs dmi_sysfs hid_multitouch hid_generic u=
sbhid i915 i2c_algo_bit drm_buddy drm_client_lib drm_display_helper polyval=
_clmulni ghash_clmulni_intel drm_kms_helper cec rc_core video ttm xhci_pci =
xhci_hcd ahci drm libahci usbcore libata wmi serio_raw sd_mod scsi_dh_emc s=
csi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio=
_mmio virtio virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 =
aesni_intel
[  107.990109] CPU: 0 UID: 0 PID: 4031 Comm: netconsole.sh Kdump: loaded Ta=
inted: G          I         6.17.0.g8742b2d8-master #195 PREEMPT(lazy)  b30=
3cf59d81e6fee2841762da0be977f2e8b800d
[  107.990115] Tainted: [I]=3DFIRMWARE_WORKAROUND
[  107.990116] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[  107.990118] RIP: 0010:ieee80211_tx_dequeue+0x71c/0x7e0 [mac80211]
[  107.990241] Code: 84 00 fc ff ff 48 8b 44 24 20 48 8b bc 24 a0 00 00 00 =
31 d2 48 8d 70 0a e8 51 6d ff ff 84 c0 0f 85 87 fa ff ff e9 db fb ff ff <0f=
> 0b e9 32 f9 ff ff e8 58 2b 97 cd 85 c0 0f 85 9c fb ff ff e8 eb
[  107.990244] RSP: 0018:ffffd21786b8b6d0 EFLAGS: 00010246
[  107.990247] RAX: 0000000000000002 RBX: ffff8a010ba768e0 RCX: 00000000000=
00002
[  107.990249] RDX: ffffffffc159fee9 RSI: ffff8a0129034168 RDI: ffff8a0101b=
80e60
[  107.990251] RBP: ffff8a0129034168 R08: 0000000000000000 R09: 00000000000=
00000
[  107.990253] R10: ffffffffc159fee9 R11: 0000000000000003 R12: 00000000000=
00002
[  107.990254] R13: ffff8a0129034000 R14: ffff8a0101b80e60 R15: ffff8a0101b=
830a8
[  107.990257] FS:  00007ff02f99e740(0000) GS:ffff8a02ddc30000(0000) knlGS:=
0000000000000000
[  107.990260] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.990262] CR2: 00007fd965d88560 CR3: 00000001155ef001 CR4: 00000000003=
726f0
[  107.990265] Call Trace:
[  107.990267]  <TASK>
[  107.990271]  ? rcu_is_watching+0x11/0x40
[  107.990279]  ? rcu_is_watching+0x11/0x40
[  107.990284]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  107.990289]  ? rcu_is_watching+0x11/0x40
[  107.990295]  ? lock_acquire+0xee/0x130
[  107.990299]  ? iwl_mvm_mac_itxq_xmit+0x59/0x1f0 [iwlmvm 0ca4634732a6b637=
e7b0ee22fbce9d6f1340b022]
[  107.990332]  iwl_mvm_mac_itxq_xmit+0xb3/0x1f0 [iwlmvm 0ca4634732a6b637e7=
b0ee22fbce9d6f1340b022]
[  107.990362]  ieee80211_queue_skb+0x21b/0x350 [mac80211 6e705e26db77cf4ab=
5101c61ecbd7b898fac9e56]
[  107.990480]  __ieee80211_xmit_fast+0x202/0x360 [mac80211 6e705e26db77cf4=
ab5101c61ecbd7b898fac9e56]
[  107.990596]  ? __skb_get_hash_net+0x54/0x1f0
[  107.990602]  ? __skb_get_hash_net+0x54/0x1f0
[  107.990611]  ieee80211_xmit_fast+0xfb/0x1f0 [mac80211 6e705e26db77cf4ab5=
101c61ecbd7b898fac9e56]
[  107.990723]  __ieee80211_subif_start_xmit+0x14e/0x3d0 [mac80211 6e705e26=
db77cf4ab5101c61ecbd7b898fac9e56]
[  107.990829]  ? __lock_acquire+0x550/0xbc0
[  107.990837]  ieee80211_subif_start_xmit+0x46/0x230 [mac80211 6e705e26db7=
7cf4ab5101c61ecbd7b898fac9e56]
[  107.990942]  ? lock_acquire.part.0+0xb1/0x210
[  107.990950]  netpoll_start_xmit+0x8b/0xd0
[  107.990955]  __netpoll_send_skb+0x329/0x3b0
[  107.990961]  write_msg+0x104/0x120 [netconsole 641ec3b0b2ff98f93fe3092a7=
f84ed3654235c84]
[  107.990970]  ? console_emit_next_record+0x1de/0x250
[  107.990976]  console_emit_next_record+0x203/0x250
[  107.990981]  ? console_emit_next_record+0x1de/0x250
[  107.990990]  console_flush_all+0x24d/0x370
[  107.990995]  ? console_flush_all+0x3b/0x370
[  107.991003]  console_unlock+0x66/0x130
[  107.991011]  vprintk_emit+0x142/0x360
[  107.991019]  _printk+0x5b/0x80
[  107.991028]  enabled_store.cold+0x7e/0x83 [netconsole 641ec3b0b2ff98f93f=
e3092a7f84ed3654235c84]
[  107.991037]  configfs_write_iter+0xbd/0x120 [configfs fddadc1058896f4b55=
fcdc7e57d7a9a452005598]
[  107.991046]  vfs_write+0x213/0x520
[  107.991058]  ksys_write+0x69/0xe0
[  107.991062]  do_syscall_64+0x94/0xa10
[  107.991067]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.991070]  ? lockdep_hardirqs_on+0x78/0x100
[  107.991074]  ? do_syscall_64+0x139/0xa10
[  107.991080]  ? exc_page_fault+0x85/0x210
[  107.991082]  ? __lock_release.isra.0+0x5d/0x180
[  107.991088]  ? exc_page_fault+0x85/0x210
[  107.991090]  ? exc_page_fault+0x85/0x210
[  107.991093]  ? lock_release+0x86/0x150
[  107.991098]  ? exc_page_fault+0x116/0x210
[  107.991104]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.991107] RIP: 0033:0x7ff02f721000
[  107.991110] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  107.991125] RSP: 002b:00007ffd43e35dc8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[  107.991131] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff02f7=
21000
[  107.991134] RDX: 0000000000000002 RSI: 00005646d313ed00 RDI: 00000000000=
00001
[  107.991137] RBP: 00005646d313ed00 R08: 0000000000000000 R09: 00000000000=
00000
[  107.991139] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  107.991142] R13: 00007ff02f8005c0 R14: 00007ff02f7fdf60 R15: 00005646d31=
438e0
[  107.991158]  </TASK>
[  107.991160] irq event stamp: 11319
[  107.991161] hardirqs last  enabled at (11317): [<ffffffff8ee014ea>] asm_=
sysvec_call_function+0x1a/0x20
[  107.991167] hardirqs last disabled at (11318): [<ffffffff8f1a57e2>] cons=
ole_emit_next_record+0x1c2/0x250
[  107.991173] softirqs last  enabled at (11068): [<ffffffff8f09a97c>] rest=
ore_fpregs_from_user+0x8c/0x180
[  107.991177] softirqs last disabled at (11319): [<ffffffffc184aded>] ieee=
80211_queue_skb+0xfd/0x350 [mac80211]
[  107.991296] ---[ end trace 0000000000000000 ]---
[  107.991343] ------------[ cut here ]------------
[  107.991345] netpoll_send_skb_on_dev(): wlan0 enabled interrupts in poll =
(ieee80211_subif_start_xmit+0x0/0x230 [mac80211])
[  107.991475] WARNING: CPU: 0 PID: 4031 at net/core/netpoll.c:359 __netpol=
l_send_skb+0x382/0x3b0
[  107.991481] Modules linked in: netconsole ccm nf_nat_tftp nf_conntrack_t=
ftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rejec=
t_ipv4 nf_reject_ipv6 nft_reject nft_ct af_packet nft_chain_nat nf_nat nf_c=
onntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set nfnetlink cmac algi=
f_hash algif_skcipher af_alg iwlmvm binfmt_misc mac80211 snd_hda_codec_hdmi=
 snd_hda_codec_conexant snd_hda_codec_generic libarc4 intel_rapl_msr uvcvid=
eo intel_rapl_common snd_hda_intel btusb snd_intel_dspcfg x86_pkg_temp_ther=
mal btrtl intel_powerclamp uvc snd_hda_codec iwlwifi btbcm snd_hwdep videob=
uf2_vmalloc coretemp iTCO_wdt btintel nls_iso8859_1 mei_pxp snd_hda_core vi=
deobuf2_memops intel_pmc_bxt videobuf2_v4l2 nls_cp437 kvm_intel mei_hdcp iT=
CO_vendor_support snd_pcm videobuf2_common mfd_core bluetooth cfg80211 vide=
odev snd_timer kvm mc irqbypass mei_me snd i2c_i801 pcspkr rfkill soundcore=
 i2c_smbus mei thermal battery tiny_power_button ac button acpi_pad joydev =
sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[  107.991550]  dm_mod fuse configfs dmi_sysfs hid_multitouch hid_generic u=
sbhid i915 i2c_algo_bit drm_buddy drm_client_lib drm_display_helper polyval=
_clmulni ghash_clmulni_intel drm_kms_helper cec rc_core video ttm xhci_pci =
xhci_hcd ahci drm libahci usbcore libata wmi serio_raw sd_mod scsi_dh_emc s=
csi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio=
_mmio virtio virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 =
aesni_intel
[  107.991588] CPU: 0 UID: 0 PID: 4031 Comm: netconsole.sh Kdump: loaded Ta=
inted: G        W I         6.17.0.g8742b2d8-master #195 PREEMPT(lazy)  b30=
3cf59d81e6fee2841762da0be977f2e8b800d
[  107.991594] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[  107.991596] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[  107.991597] RIP: 0010:__netpoll_send_skb+0x382/0x3b0
[  107.991601] Code: 0f 85 65 ff ff ff 49 8b 44 24 08 49 8d b4 24 20 01 00 =
00 48 c7 c7 d8 cd 30 90 c6 05 3d 4b d7 00 01 48 8b 50 20 e8 be fd 5d ff <0f=
> 0b e9 3a ff ff ff 9c 58 f6 c4 02 0f 84 a5 fd ff ff 80 3d 1b 4b
[  107.991604] RSP: 0018:ffffd21786b8ba98 EFLAGS: 00010282
[  107.991607] RAX: 0000000000000000 RBX: ffff8a0258b64000 RCX: 00000000000=
00000
[  107.991609] RDX: 0000000000000004 RSI: 0000000000000001 RDI: 00000000fff=
fffff
[  107.991610] RBP: ffff8a012a7bb148 R08: 0000000000000000 R09: ffffd21786b=
8b860
[  107.991612] R10: ffffffff9073e628 R11: 0000000000000003 R12: ffff8a010ba=
74000
[  107.991614] R13: ffff8a010ee4ae00 R14: ffff8a0107196800 R15: 00000000000=
00000
[  107.991616] FS:  00007ff02f99e740(0000) GS:ffff8a02ddc30000(0000) knlGS:=
0000000000000000
[  107.991618] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  107.991621] CR2: 00007fd965d88560 CR3: 00000001155ef001 CR4: 00000000003=
726f0
[  107.991623] Call Trace:
[  107.991624]  <TASK>
[  107.991629]  write_msg+0x104/0x120 [netconsole 641ec3b0b2ff98f93fe3092a7=
f84ed3654235c84]
[  107.991638]  ? console_emit_next_record+0x1de/0x250
[  107.991646]  console_emit_next_record+0x203/0x250
[  107.991651]  ? console_emit_next_record+0x1de/0x250
[  107.991660]  console_flush_all+0x24d/0x370
[  107.991665]  ? console_flush_all+0x3b/0x370
[  107.991672]  console_unlock+0x66/0x130
[  107.991680]  vprintk_emit+0x142/0x360
[  107.991688]  _printk+0x5b/0x80
[  107.991697]  enabled_store.cold+0x7e/0x83 [netconsole 641ec3b0b2ff98f93f=
e3092a7f84ed3654235c84]
[  107.991707]  configfs_write_iter+0xbd/0x120 [configfs fddadc1058896f4b55=
fcdc7e57d7a9a452005598]
[  107.991715]  vfs_write+0x213/0x520
[  107.991726]  ksys_write+0x69/0xe0
[  107.991731]  do_syscall_64+0x94/0xa10
[  107.991736]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.991739]  ? lockdep_hardirqs_on+0x78/0x100
[  107.991743]  ? do_syscall_64+0x139/0xa10
[  107.991749]  ? exc_page_fault+0x85/0x210
[  107.991751]  ? __lock_release.isra.0+0x5d/0x180
[  107.991756]  ? exc_page_fault+0x85/0x210
[  107.991759]  ? exc_page_fault+0x85/0x210
[  107.991762]  ? lock_release+0x86/0x150
[  107.991767]  ? exc_page_fault+0x116/0x210
[  107.991773]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  107.991776] RIP: 0033:0x7ff02f721000
[  107.991778] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  107.991781] RSP: 002b:00007ffd43e35dc8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[  107.991784] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff02f7=
21000
[  107.991786] RDX: 0000000000000002 RSI: 00005646d313ed00 RDI: 00000000000=
00001
[  107.991788] RBP: 00005646d313ed00 R08: 0000000000000000 R09: 00000000000=
00000
[  107.991790] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  107.991792] R13: 00007ff02f8005c0 R14: 00007ff02f7fdf60 R15: 00005646d31=
438e0
[  107.991801]  </TASK>
[  107.991802] irq event stamp: 11319
[  107.991803] hardirqs last  enabled at (11317): [<ffffffff8ee014ea>] asm_=
sysvec_call_function+0x1a/0x20
[  107.991808] hardirqs last disabled at (11318): [<ffffffff8f1a57e2>] cons=
ole_emit_next_record+0x1c2/0x250
[  107.991813] softirqs last  enabled at (11068): [<ffffffff8f09a97c>] rest=
ore_fpregs_from_user+0x8c/0x180
[  107.991817] softirqs last disabled at (11319): [<ffffffffc184aded>] ieee=
80211_queue_skb+0xfd/0x350 [mac80211]
[  107.991940] ---[ end trace 0000000000000000 ]---
[  108.006632] ------------[ cut here ]------------
[  108.006635] WARNING: CPU: 0 PID: 4031 at net/core/netpoll.c:505 netpoll_=
send_udp+0x3b3/0x3c0
[  108.006642] Modules linked in: netconsole ccm nf_nat_tftp nf_conntrack_t=
ftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rejec=
t_ipv4 nf_reject_ipv6 nft_reject nft_ct af_packet nft_chain_nat nf_nat nf_c=
onntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables ip_set nfnetlink cmac algi=
f_hash algif_skcipher af_alg iwlmvm binfmt_misc mac80211 snd_hda_codec_hdmi=
 snd_hda_codec_conexant snd_hda_codec_generic libarc4 intel_rapl_msr uvcvid=
eo intel_rapl_common snd_hda_intel btusb snd_intel_dspcfg x86_pkg_temp_ther=
mal btrtl intel_powerclamp uvc snd_hda_codec iwlwifi btbcm snd_hwdep videob=
uf2_vmalloc coretemp iTCO_wdt btintel nls_iso8859_1 mei_pxp snd_hda_core vi=
deobuf2_memops intel_pmc_bxt videobuf2_v4l2 nls_cp437 kvm_intel mei_hdcp iT=
CO_vendor_support snd_pcm videobuf2_common mfd_core bluetooth cfg80211 vide=
odev snd_timer kvm mc irqbypass mei_me snd i2c_i801 pcspkr rfkill soundcore=
 i2c_smbus mei thermal battery tiny_power_button ac button acpi_pad joydev =
sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace sunrpc
[  108.006697]  dm_mod fuse configfs dmi_sysfs hid_multitouch hid_generic u=
sbhid i915 i2c_algo_bit drm_buddy drm_client_lib drm_display_helper polyval=
_clmulni ghash_clmulni_intel drm_kms_helper cec rc_core video ttm xhci_pci =
xhci_hcd ahci drm libahci usbcore libata wmi serio_raw sd_mod scsi_dh_emc s=
csi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat virtio_blk virtio=
_mmio virtio virtio_ring ext4 crc16 mbcache jbd2 loop msr efivarfs autofs4 =
aesni_intel
[  108.006729] CPU: 0 UID: 0 PID: 4031 Comm: netconsole.sh Kdump: loaded Ta=
inted: G        W I         6.17.0.g8742b2d8-master #195 PREEMPT(lazy)  b30=
3cf59d81e6fee2841762da0be977f2e8b800d
[  108.006735] Tainted: [W]=3DWARN, [I]=3DFIRMWARE_WORKAROUND
[  108.006736] Hardware name: HP HP Spectre x360 Convertible/804F, BIOS F.4=
7 11/22/2017
[  108.006737] RIP: 0010:netpoll_send_udp+0x3b3/0x3c0
[  108.006740] Code: 0c 13 71 10 48 8d 49 04 ff ca 75 f5 83 d6 00 89 f2 c1 =
ee 10 66 01 d6 83 d6 00 f7 d6 66 89 70 0a b8 08 00 00 00 e9 a4 fe ff ff <0f=
> 0b e9 75 fc ff ff 66 0f 1f 44 00 00 f3 0f 1e fa 0f 1f 44 00 00
[  108.006743] RSP: 0018:ffffd21786b8ba88 EFLAGS: 00010202
[  108.006745] RAX: 0000000000000296 RBX: ffff8a012a7bb148 RCX: 00000000000=
00000
[  108.006747] RDX: 0000000000000028 RSI: ffffffff91aa2428 RDI: ffff8a012a7=
bb148
[  108.006748] RBP: ffffd21786b8bac8 R08: 0000000000000000 R09: 00000000000=
00000
[  108.006750] R10: ffffffffc159fee9 R11: 0000000000000000 R12: 00000000000=
00410
[  108.006751] R13: 0000000000000028 R14: ffff8a012a7bb148 R15: ffffffff91a=
a2428
[  108.006752] FS:  00007ff02f99e740(0000) GS:ffff8a02ddc30000(0000) knlGS:=
0000000000000000
[  108.006754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  108.006756] CR2: 00007fd965d88560 CR3: 00000001155ef001 CR4: 00000000003=
726f0
[  108.006757] Call Trace:
[  108.006760]  <TASK>
[  108.006763]  ? __netpoll_send_skb+0xc9/0x3b0
[  108.006769]  write_msg+0x104/0x120 [netconsole 641ec3b0b2ff98f93fe3092a7=
f84ed3654235c84]
[  108.006777]  ? console_emit_next_record+0x1de/0x250
[  108.006782]  console_emit_next_record+0x203/0x250
[  108.006786]  ? console_emit_next_record+0x1de/0x250
[  108.006791]  console_flush_all+0x24d/0x370
[  108.006795]  ? console_flush_all+0x3b/0x370
[  108.006799]  console_unlock+0x66/0x130
[  108.006804]  vprintk_emit+0x142/0x360
[  108.006809]  _printk+0x5b/0x80
[  108.006816]  enabled_store.cold+0x7e/0x83 [netconsole 641ec3b0b2ff98f93f=
e3092a7f84ed3654235c84]
[  108.006823]  configfs_write_iter+0xbd/0x120 [configfs fddadc1058896f4b55=
fcdc7e57d7a9a452005598]
[  108.006829]  vfs_write+0x213/0x520
[  108.006836]  ksys_write+0x69/0xe0
[  108.006839]  do_syscall_64+0x94/0xa10
[  108.006843]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  108.006845]  ? lockdep_hardirqs_on+0x78/0x100
[  108.006848]  ? do_syscall_64+0x139/0xa10
[  108.006852]  ? exc_page_fault+0x85/0x210
[  108.006853]  ? __lock_release.isra.0+0x5d/0x180
[  108.006857]  ? exc_page_fault+0x85/0x210
[  108.006859]  ? exc_page_fault+0x85/0x210
[  108.006861]  ? lock_release+0x86/0x150
[  108.006864]  ? exc_page_fault+0x116/0x210
[  108.006868]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  108.006870] RIP: 0033:0x7ff02f721000
[  108.006873] Code: 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 80 3d 09 ca 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[  108.006875] RSP: 002b:00007ffd43e35dc8 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000001
[  108.006877] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ff02f7=
21000
[  108.006879] RDX: 0000000000000002 RSI: 00005646d313ed00 RDI: 00000000000=
00001
[  108.006880] RBP: 00005646d313ed00 R08: 0000000000000000 R09: 00000000000=
00000
[  108.006881] R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000=
00002
[  108.006882] R13: 00007ff02f8005c0 R14: 00007ff02f7fdf60 R15: 00005646d31=
438e0
[  108.006888]  </TASK>
[  108.006889] irq event stamp: 11319
[  108.006890] hardirqs last  enabled at (11317): [<ffffffff8ee014ea>] asm_=
sysvec_call_function+0x1a/0x20
[  108.006893] hardirqs last disabled at (11318): [<ffffffff8f1a57e2>] cons=
ole_emit_next_record+0x1c2/0x250
[  108.006896] softirqs last  enabled at (11068): [<ffffffff8f09a97c>] rest=
ore_fpregs_from_user+0x8c/0x180
[  108.006899] softirqs last disabled at (11319): [<ffffffffc184aded>] ieee=
80211_queue_skb+0xfd/0x350 [mac80211]
[  108.006991] ---[ end trace 0000000000000000 ]---
[  130.992035] netfs: FS-Cache loaded
[  131.108351] Key type dns_resolver registered
[  131.408618] NFS: Registering the id_resolver key type
[  131.408693] Key type id_resolver registered
[  131.408728] Key type id_legacy registered


