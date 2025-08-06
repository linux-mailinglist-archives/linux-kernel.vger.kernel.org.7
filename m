Return-Path: <linux-kernel+bounces-758297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5846CB1CD4F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3050F3B425E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DA2BCF7F;
	Wed,  6 Aug 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bvh9ziR/"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E11E25ED
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511280; cv=none; b=efs2W5aSYGAuvzVw/d/Jg0dyrh0vrGKuLph+j5AgcZ3nSwnlay+LNjMDUEAIItLzy3gkIilgwKKUg6VEqfLkaWJX1AyLLgBuu8UqpTCPimsFQmmLe8gtNgwqDR75SEYvieW5X9wGaLFDEueEXozzeeUkG4lPGShBp2l10R0m6uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511280; c=relaxed/simple;
	bh=dCxqB//gwUwgTR12Qoho75B28ViZx3tykADK91mU/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bJ1h1IAtkVw9/Vp39YrLopUlVYyJ/SGIvTKMcW19dBdMVcXZwCB/nmyu2cIxOthKyf06goylqNhzx5iLzbOi6stnsnJy57GJH90J8bIBgzaL20YvY0D7oKB59tokJPKzHiKoqWNUPvIJiyHmnFp2AYyih4FXo+8NK+aeioVSGGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bvh9ziR/; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e5128c53abso1669035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754511278; x=1755116078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aWxeIE7clpNj3Kg2wErxbmnJsmkohsNyCbg7cDHykI=;
        b=bvh9ziR/wqvi+hKBoGNvQ5FQbYsseQ9Vs7Ih6EpOJCXJuzIX1XJxNC4pU9PoWcw4W8
         1LQh1nO1OmFVvCYnU5DrGa6F1cJNeVmXKhSPkbKO2BXh4ifjE8oR6Yne3HPUgF2ulbKS
         NZwOTePNTb8ioS5qic+WIzXKjzYMWst3ECtYqph4rtlxIvq97RIZ5Rvxss7BX+fQQo2q
         HW55/tSjowcq4Cnl+pYCMXLgxyVDz/hZwLJWdBdJ0vot3nH7LPUMCTJcitC00/2Lmj62
         qLs8hWio2PyT3KmsM3BJeRnD8URVMbE+JXKUPH7/WFKbymU5wqb4/v4LMWFePJslxe+I
         T3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511278; x=1755116078;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aWxeIE7clpNj3Kg2wErxbmnJsmkohsNyCbg7cDHykI=;
        b=BrHo+uBYXF4mTBCb+SYeXShZZEzzh5aD2IesyQOlBr8GSm7ihJT+fe4TudsROvJ2b5
         v96ITqbUlEd0HicvaMi4EJEMdiDQy/c4VyN4YHDBCvfy643VqiO7M3+3GLtwAxsl/h8S
         TTZ/jVh+yaX4B9YW7wlVtp68nXiQCYRAYCd7q+b6NpuC9DvAeADEjFhLCZGSRARJkIwD
         n2cgE75NJu1B8OxcLPYCZdrwiXZBIfQo9j1Y/GLRO46tpUjMKGKVNDoqyDrtLn9tXI2J
         K3IxXA1of5LmXsV2Pz1omypVSXot/QNpPXcuoF/u8AWgY6M+pT+a+yBZEeRWReIfB19m
         SKHw==
X-Forwarded-Encrypted: i=1; AJvYcCV6YYVYokmm4IlQbcOy7QHBpVTHk8aWmmPrfz6wIDQyoYpN2dHs+Q/T0y0rMEhvi/6p8O80Po6SZ/yYMvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ecGpJCjgOJtnRshSsUSK/e+huKq8E36DBFauFlmCGjEZxCNQ
	7vNHneDwASlVbvfxJ+IIPOH/SsxLpxZt1yEx9ZmzAj33Kg5D3do6biqnr2aN6jJijwZRFCVPRh8
	axetdD/8=
X-Gm-Gg: ASbGnctkdJmz1yNqPZAvWhN5ST02sWw30aMQUqS0WMUDgyQQSTLplEpRfFnKpbBCzsD
	NJn/j8OY/GxJ83AMTBNoMt5FsltvvmLSNdIAiS56ebDdd4SmEvKy2mBKVeg3vUA1aENylxWi/gL
	drvmtY7qVeg0imcIJcEHY+wllKXTIVjUtE9COBUOTSDsU4//1yLIEaQ11Uj+QCIxcgfTTHNe/aN
	P9qhfnRwRzQp1iTWuWI2HvP6bqmh8+WniXEPHR9LmEgsG+AlSR59eR8DsCrtpex5YweUSz5w3Pr
	/V4WcupTlh6K11c3fZmSsecu+cAyyww3tRS7wzapmBg2PJBEtoroIqVq9bjhu3QK2Xfv0u4L2B5
	E3w==
X-Google-Smtp-Source: AGHT+IEg5SaCs6h4UqYkteW0vvnDB6L6c5niiqchQ55MRZyLoT+gYdHShcCNtC47ANZUSOz/ovYBLQ==
X-Received: by 2002:a05:6e02:2284:b0:3e3:bcd7:590 with SMTP id e9e14a558f8ab-3e51b892f60mr71014875ab.7.1754511277631;
        Wed, 06 Aug 2025 13:14:37 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:8255:4e6::7d:4b])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e402b12e8asm65199675ab.48.2025.08.06.13.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:14:37 -0700 (PDT)
Date: Wed, 6 Aug 2025 15:14:35 -0500
From: Frederick Lawler <fred@cloudflare.com>
To: Corey Minyard <cory@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [BUG] ipmi_si: watchdog: Watchdog detected hard LOCKUP
Message-ID: <aJO3q8JiVXKewMjW@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Corey,

In kernel 6.12.y, while resetting the BMC, we can sometimes hit a hard LOCK=
UP
watchdog event, especially so while querying the BMC for basic device
information via sysfs.

I havn't been able to create a consistent reproducer yet, but I suspect
that these occur during high traffic, BMC is resetting, and reading
=66rom the sysfs files in parallel. We're also using KCS to interface
with the BMC.

I can consistently reproduce hung tasks trivially with the following,
during a BMC reset:

while true; do cat aux_firmware_revision &>/dev/null; done &

I tried also tried to load the CPUs with stress-ng, but the best I can do
are the hung tasks.

I identified that sni_send()[1] could be locked behind the
spin_lock_irqsave() and within the KCS send handler, there's another irq
save lock. I suspect this is where we're getting hung up. Below is a
sample stack trace + log output.

I'm happy to provide traces and additional information, let me know.

Links:
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/=
drivers/char/ipmi/ipmi_msghandler.c?h=3Dlinux-6.12.y#n1899

[  499.564572] [  T27255] ip6_tunnel: pni_gre_814 xmit: Local address not y=
et configured!
[  499.588176] [  T27255] ip6_tunnel: pni_gre_868 xmit: Local address not y=
et configured!
[  499.605284] [  T27255] ip6_tunnel: pni_gre_871 xmit: Local address not y=
et configured!
[  805.906999] [  T12765] usb 1-1: USB disconnect, device number 2
[  845.346020] [  T12765] usb 1-1: new high-speed USB device number 3 using=
 xhci_hcd
[  845.485453] [  T12765] usb 1-1: New USB device found, idVendor=3D1d6b, i=
dProduct=3D0107, bcdDevice=3D 1.00
[  845.496823] [  T12765] usb 1-1: New USB device strings: Mfr=3D3, Product=
=3D2, SerialNumber=3D1
[  845.507242] [  T12765] usb 1-1: Product: USB Virtual Hub
[  845.514946] [  T12765] usb 1-1: Manufacturer: Aspeed
[  845.522363] [  T12765] usb 1-1: SerialNumber: 00000000
[  845.530454] [  T12765] usb 1-1: Device is not authorized for usage
[  853.774910] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.783794] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.792649] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.801461] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.810291] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.819069] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.827816] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.836581] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.845326] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.854074] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  853.862813] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
[  863.934436] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
[  863.943420] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
[  863.952363] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
[  863.961296] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
[  878.616336] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
[  878.624905] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
[  878.633427] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
[  878.641954] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
[  880.310112] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
[  880.318682] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
[  880.327083] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
[  880.335483] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
[  904.196122] [     C33] watchdog: Watchdog detected hard LOCKUP on cpu 33
[  904.196127] [     C97] Uhhuh. NMI received for unknown reason 3d on CPU =
97.
[  904.196126] [      C6] Uhhuh. NMI received for unknown reason 3d on CPU =
6.
[  904.196130] [     C33] Modules linked in:
[  904.196129] [    C101] Uhhuh. NMI received for unknown reason 3d on CPU =
101.
[  904.196131] [     C97] Dazed and confused, but trying to continue
[  904.196131] [     C33]  nft_fwd_netdev
[  904.196131] [     C99] Uhhuh. NMI received for unknown reason 2d on CPU =
99.
[  904.196133] [      C6] Dazed and confused, but trying to continue
[  904.196133] [    C102] Uhhuh. NMI received for unknown reason 2d on CPU =
102.
[  904.196134] [     C33]  nf_dup_netdev
[  904.196134] [     C35] Uhhuh. NMI received for unknown reason 2d on CPU =
35.
[  904.196135] [    C101] Dazed and confused, but trying to continue
[  904.196137] [     C99] Dazed and confused, but trying to continue
[  904.196137] [     C33]  xfrm_interface
[  904.196136] [     C69] Uhhuh. NMI received for unknown reason 2d on CPU =
69.
[  904.196140] [    C102] Dazed and confused, but trying to continue
[  904.196140] [     C33]  xfrm6_tunnel
[  904.196138] [    C121] Uhhuh. NMI received for unknown reason 2d on CPU =
121.
[  904.196140] [    C123] Uhhuh. NMI received for unknown reason 2d on CPU =
123.
[  904.196142] [     C35] Dazed and confused, but trying to continue
[  904.196143] [     C69] Dazed and confused, but trying to continue
[  904.196143] [     C33]  nft_numgen
[  904.196143] [     C61] Uhhuh. NMI received for unknown reason 2d on CPU =
61.
[  904.196144] [     C62] Uhhuh. NMI received for unknown reason 3d on CPU =
62.
[  904.196146] [    C123] Dazed and confused, but trying to continue
[  904.196147] [    C121] Dazed and confused, but trying to continue
[  904.196148] [     C58] Dazed and confused, but trying to continue
[  904.196150] [     C33]  nft_log nft_limit sit dummy ipip tunnel4 ip_gre =
gre xfrm_user xfrm_algo tls mpls_iptunnel mpls_router nft_ct nf_tables ipta=
ble_raw iptable_nat iptable_mangle ipt_REJECT nf_reject_ipv4 ip6table_secur=
ity xt_CT ip6table_raw xt_nat ip6table_nat nf_nat xt_TCPMSS xt_owner xt_DSC=
P xt_NFLOG xt_connbytes xt_connlabel xt_statistic xt_connmark ip6table_mang=
le xt_limit xt_LOG nf_log_syslog xt_mark xt_conntrack ip6t_REJECT nf_reject=
_ipv6 xt_multiport xt_set xt_tcpmss xt_comment xt_tcpudp ip6table_filter ip=
6_tables nfnetlink_log udp_diag dm_thin_pool dm_persistent_data dm_bio_pris=
on dm_bufio iptable_filter veth tcp_diag inet_diag mpls_gso act_mpls cls_fl=
ower cls_bpf sch_ingress ip_set_hash_ip ip_set_hash_net ip_set tcp_bbr sch_=
fq tun xt_bpf nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fou6 fou ip_tunnel=
 ip6_udp_tunnel udp_tunnel ip6_tunnel tunnel6 nvme_fabrics raid0 md_mod ess=
iv dm_crypt trusted asn1_encoder tee dm_mod dax 8021q garp mrp stp llc ipmi=
_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclmul crc32c_intel
[  904.196247] [     C33]  sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel=
 crypto_simd xhci_pci binfmt_misc acpi_ipmi cryptd ipmi_si nvme rapl ipmi_d=
evintf i2c_piix4 tiny_power_button bnxt_en xhci_hcd nvme_core ccp i2c_smbus=
 ipmi_msghandler button fuse configfs nfnetlink efivarfs ip_tables x_tables=
 bcmcrypt(O)
[  904.196281] [     C33] CPU: 33 UID: 0 PID: 0 Comm: swapper/33 Kdump: loa=
ded Tainted: G           O       6.12.34-cloudflare-2025.6.9 #1
[  904.196286] [     C33] Tainted: [O]=3DOOT_MODULE
[  904.196287] [     C33] Hardware name: GIGABYTE R162-Z12-CD-G11P5/MZ12-HD=
4-CD, BIOS M10-sig 02/17/2025
[  904.196290] [     C33] RIP: 0010:io_idle+0x3/0x30
[  904.196298] [     C33] Code: 8b 00 a8 08 75 07 e8 2c e4 ff ff 90 fa e9 c=
0 b3 1a 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 8=
9 fa ec <48> 8b 05 96 42 d4 01 a9 00 00 00 80 75 11 80 3d 4a 42 d4 01 00 75
[  904.196301] [     C33] RSP: 0018:ffff9afa88307e70 EFLAGS: 00000093
[  904.196304] [     C33] RAX: 0000000000000000 RBX: ffff8abdf2b5d898 RCX: =
0000000000000040
[  904.196306] [     C33] RDX: 0000000000000814 RSI: ffff8abdf2b5d800 RDI: =
0000000000000814
[  904.196308] [     C33] RBP: 0000000000000002 R08: ffffffffa9dff860 R09: =
0000000000000007
[  904.196309] [     C33] R10: 000000e65239d580 R11: 071c71c71c71c71c R12: =
ffffffffa9dff860
[  904.196311] [     C33] R13: ffffffffa9dff948 R14: 0000000000000002 R15: =
0000000000000000
[  904.196313] [     C33] FS:  0000000000000000(0000) GS:ffff8aadcf680000(0=
000) knlGS:0000000000000000
[  904.196316] [     C33] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  904.196318] [     C33] CR2: 00005632ce239000 CR3: 0000003944f72004 CR4: =
0000000000770ef0
[  904.196320] [     C33] PKRU: 55555554
[  904.196322] [     C33] Call Trace:
[  904.196324] [     C33]  <TASK>
[  904.196326] [     C33]  acpi_idle_do_entry+0x22/0x50
[  904.196336] [     C33]  acpi_idle_enter+0x7b/0xd0
[  904.196340] [     C33]  cpuidle_enter_state+0x79/0x420
[  904.196345] [     C33]  cpuidle_enter+0x2d/0x40
[  904.196352] [     C33]  do_idle+0x176/0x1c0
[  904.196358] [     C33]  cpu_startup_entry+0x29/0x30
[  904.196362] [     C33]  start_secondary+0xf7/0x100
[  904.196366] [     C33]  common_startup_64+0x13e/0x141
[  904.196374] [     C33]  </TASK>
[  904.196377] [     C33] Kernel panic - not syncing: Hard LOCKUP
[  904.196379] [     C33] CPU: 33 UID: 0 PID: 0 Comm: swapper/33 Kdump: loa=
ded Tainted: G           O       6.12.34-cloudflare-2025.6.9 #1
[  904.196383] [     C33] Tainted: [O]=3DOOT_MODULE
[  904.196384] [     C33] Hardware name: GIGABYTE R162-Z12-CD-G11P5/MZ12-HD=
4-CD, BIOS M10-sig 02/17/2025
[  904.196385] [     C33] Call Trace:
[  904.196387] [     C33]  <NMI>
[  904.196389] [     C33]  dump_stack_lvl+0x4b/0x70
[  904.196394] [     C33]  panic+0x106/0x2c4
[  904.196401] [     C33]  nmi_panic.cold+0xc/0xc
[  904.196404] [     C33]  watchdog_hardlockup_check.cold+0xc6/0xe8
[  904.196409] [     C33]  __perf_event_overflow+0x15a/0x450
[  904.196416] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
[  904.196421] [     C33]  x86_pmu_handle_irq+0x18a/0x1c0
[  904.196436] [     C33]  ? set_pte_vaddr+0x40/0x50
[  904.196439] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
[  904.196442] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
[  904.196445] [     C33]  ? native_set_fixmap+0x63/0xb0
[  904.196448] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
[  904.196451] [     C33]  ? ghes_copy_tofrom_phys+0x7a/0x100
[  904.196457] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
[  904.196460] [     C33]  ? __ghes_peek_estatus.isra.0+0x49/0xa0
[  904.196465] [     C33]  amd_pmu_handle_irq+0x4b/0xc0
[  904.196469] [     C33]  perf_event_nmi_handler+0x2a/0x50
[  904.196473] [     C33]  nmi_handle.part.0+0x59/0x110
[  904.196479] [     C33]  default_do_nmi+0x127/0x180
[  904.196483] [     C33]  exc_nmi+0x103/0x180
[  904.196486] [     C33]  end_repeat_nmi+0xf/0x53
[  904.196489] [     C33] RIP: 0010:io_idle+0x3/0x30
[  904.196493] [     C33] Code: 8b 00 a8 08 75 07 e8 2c e4 ff ff 90 fa e9 c=
0 b3 1a 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 8=
9 fa ec <48> 8b 05 96 42 d4 01 a9 00 00 00 80 75 11 80 3d 4a 42 d4 01 00 75
[  904.196495] [     C33] RSP: 0018:ffff9afa88307e70 EFLAGS: 00000093
[  904.196497] [     C33] RAX: 0000000000000000 RBX: ffff8abdf2b5d898 RCX: =
0000000000000040
[  904.196499] [     C33] RDX: 0000000000000814 RSI: ffff8abdf2b5d800 RDI: =
0000000000000814
[  904.196501] [     C33] RBP: 0000000000000002 R08: ffffffffa9dff860 R09: =
0000000000000007
[  904.196502] [     C33] R10: 000000e65239d580 R11: 071c71c71c71c71c R12: =
ffffffffa9dff860
[  904.196504] [     C33] R13: ffffffffa9dff948 R14: 0000000000000002 R15: =
0000000000000000
[  904.196510] [     C33]  ? io_idle+0x3/0x30
[  904.196515] [     C33]  ? io_idle+0x3/0x30
[  904.196519] [     C33]  </NMI>
[  904.196520] [     C33]  <TASK>
[  904.196521] [     C33]  acpi_idle_do_entry+0x22/0x50
[  904.196526] [     C33]  acpi_idle_enter+0x7b/0xd0
[  904.196529] [     C33]  cpuidle_enter_state+0x79/0x420
[  904.196535] [     C33]  cpuidle_enter+0x2d/0x40
[  904.196539] [     C33]  do_idle+0x176/0x1c0
[  904.196544] [     C33]  cpu_startup_entry+0x29/0x30
[  904.196548] [     C33]  start_secondary+0xf7/0x100
[  904.196552] [     C33]  common_startup_64+0x13e/0x141
[  904.196559] [     C33]  </TASK>

Best, Fred

