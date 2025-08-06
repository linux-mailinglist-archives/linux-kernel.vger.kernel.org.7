Return-Path: <linux-kernel+bounces-758302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9CDB1CD5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B79AB3A2EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7A61D47B4;
	Wed,  6 Aug 2025 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZmWbirNb"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBA2F2D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511582; cv=none; b=MNYJkici+o+KIFcLMc+Ddnm3BNbeHtg0qm7hkjYeERQHmcnXgAqVnd6fX0XwCGoRsEM3qopo/byR2bjFbvxTkrLgxTFwYYGa3zkqfGiajm18KrpN0TCfw6yIb34WxfdohzcN4ViQqF+8elTmbSIGerByQ98QL7OKDsIh+mapFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511582; c=relaxed/simple;
	bh=Wcdc/26I5BmJnoiZLyDV/lotBvY/N+6/ilAlxwyoWEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrr4o2XUwXOKsoN9XVguJRjPNDH3WrxGK08dUqXfwUNtrRCG0NsYl6lVlsfGhiq0GmoXtTFMcb9FaNoiuIldVVNfu1AlalDxgJv2bzNWzpBLe+XRZ9goikuUFafCFe0uLrmxmFS/Sz4/izahwLr4JAeOtzpH/1LgD+DBSFhFSno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZmWbirNb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7073075c767so4052256d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754511579; x=1755116379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pu4L65U8wOuasCJPhXb5iYXoeJQWLyeADLRMPnInAU=;
        b=ZmWbirNbHvD/EL8WCTkhBM7CglnsuOjLGXaqPvEkSQFWjyDoHbnSRFhjzISaUR4cCR
         jc2NJ7ZjIFNbR2IxAp4U7tPWVwTmLCzCn42LUxCVHzY6YfVI6fLvLMuGWbhvCZBeR9qg
         QNlrJ1HtDWycnfs8CtX5p0EPg35ttyfByO0EIevXTz8Tw3WpEIZKqDiFJC02aLRbtZub
         yBcsnYfiW80FZxw0LM7hLhyQuRXZttROE2wtl54Rrmz1NzpU2SC2H45FFpBQa8xHM+xj
         iuwX1LRzrGkKvQmX2Iw+Fa+wcZV+yljD7xkYP3pQb3Ze0OM+MBy8x5uukUf/w2yBuLoD
         CWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511579; x=1755116379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pu4L65U8wOuasCJPhXb5iYXoeJQWLyeADLRMPnInAU=;
        b=AqwrNNGXuHO+A6eAQRnNJAG4UB/2GfmZh+EK3YINkOJCfuHHakIueYV8HXoEfnzN69
         LXWXbZCccSnFmrwnzd3fINtNTzrv8VLLZZwSWWQY0DRWlJhWyV1lapWfgkLAJ1JoZZ42
         LLMFX0Jd2/7GrwAhMAQN+lo0zzwISVwqwY37bs+akeunTyYf6XePmlgnDSWFWwGgY0NO
         AzkYHbuHQYLxV8dtEJS85spJ9FxLEFiDTpMjTTXxds7kPzL1vUGpd47Pu4Wy1piDSYBE
         TUDw7aBYuYQS85MAYSuhkAauaj47qJZZBuOc5ITrC+Yx814kw0PItLS99Njc4dJF6ZQI
         mXpg==
X-Forwarded-Encrypted: i=1; AJvYcCUn2gBb4Fr6iiCdunkHu9O995MPVb4GctBpv4qYx6ASck1cQYtd+sZX4WjcVZCaU12neKaBXKQFfBR5Ng4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAs4ZTN3JgKDHiPadpHvJ3XwdrG8NeM6j7c1cwDxwHHeOKyRwK
	dWe1pMfflpK4DWptrq9HRJx5EGtHQ47AxKwaPcvNL5ItJBTp+XdGtqL1FscZWo6TlcilewjOeHX
	lpWFOQWhI766L4C8bh5GB9U+UOluUwb2e2d6ZCpFZqQ==
X-Gm-Gg: ASbGncvJts22GgJkmoLAd2v+pAqbgeP7qnjocZ0DrA0EIUSgYThszSaEUnbv6a3ccqh
	PW/fzLYQ58eNn3J2cpghMWcdYFyXc7d/PRiiq18i5Jujt/T1EKHu4UFG3KbXCgBplOorHLfRxzh
	7hrNYEl3aYlWHabmm93R9o7xv46YfNX+SHDSRlAEA1GcHinWoQ11rvyrhhElPsqEQhl/+QlcUPa
	+vb+sNZtQ/PXfHHLORfdYM=
X-Google-Smtp-Source: AGHT+IFRaoLG0WQjwYx9aC48rsqDGwtmkMtgs1NcPhbTny4FlhemZNgyzau+gN21awz/1jx6kCly128YO0S3biliNLY=
X-Received: by 2002:a05:6214:62a:b0:707:14d5:ee7a with SMTP id
 6a1803df08f44-709796a0ecemr74028556d6.36.1754511578703; Wed, 06 Aug 2025
 13:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJO3q8JiVXKewMjW@CMGLRV3>
In-Reply-To: <aJO3q8JiVXKewMjW@CMGLRV3>
From: Fred Lawler <fred@cloudflare.com>
Date: Wed, 6 Aug 2025 15:19:02 -0500
X-Gm-Features: Ac12FXzfQa89zi-vRPF2T06E5BJTlevo2VUcfjUzp3w5PPs08oViOzHPvZf4IJ4
Message-ID: <CA+QrTELaLFRGn1ynG5dG+KB_40aPA31hU5QgLn7ikh2Zbk3Hpg@mail.gmail.com>
Subject: Re: [BUG] ipmi_si: watchdog: Watchdog detected hard LOCKUP
To: Corey Minyard <corey@minyard.net>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ CC: Corey Minyard <corey@minyard.net>

Misspelled the email address.

On Wed, Aug 6, 2025 at 3:14=E2=80=AFPM Frederick Lawler <fred@cloudflare.co=
m> wrote:
>
> Hi Corey,
>
> In kernel 6.12.y, while resetting the BMC, we can sometimes hit a hard LO=
CKUP
> watchdog event, especially so while querying the BMC for basic device
> information via sysfs.
>
> I havn't been able to create a consistent reproducer yet, but I suspect
> that these occur during high traffic, BMC is resetting, and reading
> from the sysfs files in parallel. We're also using KCS to interface
> with the BMC.
>
> I can consistently reproduce hung tasks trivially with the following,
> during a BMC reset:
>
> while true; do cat aux_firmware_revision &>/dev/null; done &
>
> I tried also tried to load the CPUs with stress-ng, but the best I can do
> are the hung tasks.
>
> I identified that sni_send()[1] could be locked behind the
> spin_lock_irqsave() and within the KCS send handler, there's another irq
> save lock. I suspect this is where we're getting hung up. Below is a
> sample stack trace + log output.
>
> I'm happy to provide traces and additional information, let me know.
>
> Links:
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tre=
e/drivers/char/ipmi/ipmi_msghandler.c?h=3Dlinux-6.12.y#n1899
>
> [  499.564572] [  T27255] ip6_tunnel: pni_gre_814 xmit: Local address not=
 yet configured!
> [  499.588176] [  T27255] ip6_tunnel: pni_gre_868 xmit: Local address not=
 yet configured!
> [  499.605284] [  T27255] ip6_tunnel: pni_gre_871 xmit: Local address not=
 yet configured!
> [  805.906999] [  T12765] usb 1-1: USB disconnect, device number 2
> [  845.346020] [  T12765] usb 1-1: new high-speed USB device number 3 usi=
ng xhci_hcd
> [  845.485453] [  T12765] usb 1-1: New USB device found, idVendor=3D1d6b,=
 idProduct=3D0107, bcdDevice=3D 1.00
> [  845.496823] [  T12765] usb 1-1: New USB device strings: Mfr=3D3, Produ=
ct=3D2, SerialNumber=3D1
> [  845.507242] [  T12765] usb 1-1: Product: USB Virtual Hub
> [  845.514946] [  T12765] usb 1-1: Manufacturer: Aspeed
> [  845.522363] [  T12765] usb 1-1: SerialNumber: 00000000
> [  845.530454] [  T12765] usb 1-1: Device is not authorized for usage
> [  853.774910] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.783794] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.792649] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.801461] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.810291] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.819069] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.827816] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.836581] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.845326] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.854074] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  853.862813] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> [  863.934436] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> [  863.943420] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> [  863.952363] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> [  863.961296] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> [  878.616336] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> [  878.624905] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> [  878.633427] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> [  878.641954] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> [  880.310112] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> [  880.318682] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> [  880.327083] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> [  880.335483] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> [  904.196122] [     C33] watchdog: Watchdog detected hard LOCKUP on cpu =
33
> [  904.196127] [     C97] Uhhuh. NMI received for unknown reason 3d on CP=
U 97.
> [  904.196126] [      C6] Uhhuh. NMI received for unknown reason 3d on CP=
U 6.
> [  904.196130] [     C33] Modules linked in:
> [  904.196129] [    C101] Uhhuh. NMI received for unknown reason 3d on CP=
U 101.
> [  904.196131] [     C97] Dazed and confused, but trying to continue
> [  904.196131] [     C33]  nft_fwd_netdev
> [  904.196131] [     C99] Uhhuh. NMI received for unknown reason 2d on CP=
U 99.
> [  904.196133] [      C6] Dazed and confused, but trying to continue
> [  904.196133] [    C102] Uhhuh. NMI received for unknown reason 2d on CP=
U 102.
> [  904.196134] [     C33]  nf_dup_netdev
> [  904.196134] [     C35] Uhhuh. NMI received for unknown reason 2d on CP=
U 35.
> [  904.196135] [    C101] Dazed and confused, but trying to continue
> [  904.196137] [     C99] Dazed and confused, but trying to continue
> [  904.196137] [     C33]  xfrm_interface
> [  904.196136] [     C69] Uhhuh. NMI received for unknown reason 2d on CP=
U 69.
> [  904.196140] [    C102] Dazed and confused, but trying to continue
> [  904.196140] [     C33]  xfrm6_tunnel
> [  904.196138] [    C121] Uhhuh. NMI received for unknown reason 2d on CP=
U 121.
> [  904.196140] [    C123] Uhhuh. NMI received for unknown reason 2d on CP=
U 123.
> [  904.196142] [     C35] Dazed and confused, but trying to continue
> [  904.196143] [     C69] Dazed and confused, but trying to continue
> [  904.196143] [     C33]  nft_numgen
> [  904.196143] [     C61] Uhhuh. NMI received for unknown reason 2d on CP=
U 61.
> [  904.196144] [     C62] Uhhuh. NMI received for unknown reason 3d on CP=
U 62.
> [  904.196146] [    C123] Dazed and confused, but trying to continue
> [  904.196147] [    C121] Dazed and confused, but trying to continue
> [  904.196148] [     C58] Dazed and confused, but trying to continue
> [  904.196150] [     C33]  nft_log nft_limit sit dummy ipip tunnel4 ip_gr=
e gre xfrm_user xfrm_algo tls mpls_iptunnel mpls_router nft_ct nf_tables ip=
table_raw iptable_nat iptable_mangle ipt_REJECT nf_reject_ipv4 ip6table_sec=
urity xt_CT ip6table_raw xt_nat ip6table_nat nf_nat xt_TCPMSS xt_owner xt_D=
SCP xt_NFLOG xt_connbytes xt_connlabel xt_statistic xt_connmark ip6table_ma=
ngle xt_limit xt_LOG nf_log_syslog xt_mark xt_conntrack ip6t_REJECT nf_reje=
ct_ipv6 xt_multiport xt_set xt_tcpmss xt_comment xt_tcpudp ip6table_filter =
ip6_tables nfnetlink_log udp_diag dm_thin_pool dm_persistent_data dm_bio_pr=
ison dm_bufio iptable_filter veth tcp_diag inet_diag mpls_gso act_mpls cls_=
flower cls_bpf sch_ingress ip_set_hash_ip ip_set_hash_net ip_set tcp_bbr sc=
h_fq tun xt_bpf nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fou6 fou ip_tunn=
el ip6_udp_tunnel udp_tunnel ip6_tunnel tunnel6 nvme_fabrics raid0 md_mod e=
ssiv dm_crypt trusted asn1_encoder tee dm_mod dax 8021q garp mrp stp llc ip=
mi_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclmul crc32c_intel
> [  904.196247] [     C33]  sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_int=
el crypto_simd xhci_pci binfmt_misc acpi_ipmi cryptd ipmi_si nvme rapl ipmi=
_devintf i2c_piix4 tiny_power_button bnxt_en xhci_hcd nvme_core ccp i2c_smb=
us ipmi_msghandler button fuse configfs nfnetlink efivarfs ip_tables x_tabl=
es bcmcrypt(O)
> [  904.196281] [     C33] CPU: 33 UID: 0 PID: 0 Comm: swapper/33 Kdump: l=
oaded Tainted: G           O       6.12.34-cloudflare-2025.6.9 #1
> [  904.196286] [     C33] Tainted: [O]=3DOOT_MODULE
> [  904.196287] [     C33] Hardware name: GIGABYTE R162-Z12-CD-G11P5/MZ12-=
HD4-CD, BIOS M10-sig 02/17/2025
> [  904.196290] [     C33] RIP: 0010:io_idle+0x3/0x30
> [  904.196298] [     C33] Code: 8b 00 a8 08 75 07 e8 2c e4 ff ff 90 fa e9=
 c0 b3 1a 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 89 fa ec <48> 8b 05 96 42 d4 01 a9 00 00 00 80 75 11 80 3d 4a 42 d4 01 00 =
75
> [  904.196301] [     C33] RSP: 0018:ffff9afa88307e70 EFLAGS: 00000093
> [  904.196304] [     C33] RAX: 0000000000000000 RBX: ffff8abdf2b5d898 RCX=
: 0000000000000040
> [  904.196306] [     C33] RDX: 0000000000000814 RSI: ffff8abdf2b5d800 RDI=
: 0000000000000814
> [  904.196308] [     C33] RBP: 0000000000000002 R08: ffffffffa9dff860 R09=
: 0000000000000007
> [  904.196309] [     C33] R10: 000000e65239d580 R11: 071c71c71c71c71c R12=
: ffffffffa9dff860
> [  904.196311] [     C33] R13: ffffffffa9dff948 R14: 0000000000000002 R15=
: 0000000000000000
> [  904.196313] [     C33] FS:  0000000000000000(0000) GS:ffff8aadcf680000=
(0000) knlGS:0000000000000000
> [  904.196316] [     C33] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
> [  904.196318] [     C33] CR2: 00005632ce239000 CR3: 0000003944f72004 CR4=
: 0000000000770ef0
> [  904.196320] [     C33] PKRU: 55555554
> [  904.196322] [     C33] Call Trace:
> [  904.196324] [     C33]  <TASK>
> [  904.196326] [     C33]  acpi_idle_do_entry+0x22/0x50
> [  904.196336] [     C33]  acpi_idle_enter+0x7b/0xd0
> [  904.196340] [     C33]  cpuidle_enter_state+0x79/0x420
> [  904.196345] [     C33]  cpuidle_enter+0x2d/0x40
> [  904.196352] [     C33]  do_idle+0x176/0x1c0
> [  904.196358] [     C33]  cpu_startup_entry+0x29/0x30
> [  904.196362] [     C33]  start_secondary+0xf7/0x100
> [  904.196366] [     C33]  common_startup_64+0x13e/0x141
> [  904.196374] [     C33]  </TASK>
> [  904.196377] [     C33] Kernel panic - not syncing: Hard LOCKUP
> [  904.196379] [     C33] CPU: 33 UID: 0 PID: 0 Comm: swapper/33 Kdump: l=
oaded Tainted: G           O       6.12.34-cloudflare-2025.6.9 #1
> [  904.196383] [     C33] Tainted: [O]=3DOOT_MODULE
> [  904.196384] [     C33] Hardware name: GIGABYTE R162-Z12-CD-G11P5/MZ12-=
HD4-CD, BIOS M10-sig 02/17/2025
> [  904.196385] [     C33] Call Trace:
> [  904.196387] [     C33]  <NMI>
> [  904.196389] [     C33]  dump_stack_lvl+0x4b/0x70
> [  904.196394] [     C33]  panic+0x106/0x2c4
> [  904.196401] [     C33]  nmi_panic.cold+0xc/0xc
> [  904.196404] [     C33]  watchdog_hardlockup_check.cold+0xc6/0xe8
> [  904.196409] [     C33]  __perf_event_overflow+0x15a/0x450
> [  904.196416] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  904.196421] [     C33]  x86_pmu_handle_irq+0x18a/0x1c0
> [  904.196436] [     C33]  ? set_pte_vaddr+0x40/0x50
> [  904.196439] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  904.196442] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  904.196445] [     C33]  ? native_set_fixmap+0x63/0xb0
> [  904.196448] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  904.196451] [     C33]  ? ghes_copy_tofrom_phys+0x7a/0x100
> [  904.196457] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  904.196460] [     C33]  ? __ghes_peek_estatus.isra.0+0x49/0xa0
> [  904.196465] [     C33]  amd_pmu_handle_irq+0x4b/0xc0
> [  904.196469] [     C33]  perf_event_nmi_handler+0x2a/0x50
> [  904.196473] [     C33]  nmi_handle.part.0+0x59/0x110
> [  904.196479] [     C33]  default_do_nmi+0x127/0x180
> [  904.196483] [     C33]  exc_nmi+0x103/0x180
> [  904.196486] [     C33]  end_repeat_nmi+0xf/0x53
> [  904.196489] [     C33] RIP: 0010:io_idle+0x3/0x30
> [  904.196493] [     C33] Code: 8b 00 a8 08 75 07 e8 2c e4 ff ff 90 fa e9=
 c0 b3 1a 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 89 fa ec <48> 8b 05 96 42 d4 01 a9 00 00 00 80 75 11 80 3d 4a 42 d4 01 00 =
75
> [  904.196495] [     C33] RSP: 0018:ffff9afa88307e70 EFLAGS: 00000093
> [  904.196497] [     C33] RAX: 0000000000000000 RBX: ffff8abdf2b5d898 RCX=
: 0000000000000040
> [  904.196499] [     C33] RDX: 0000000000000814 RSI: ffff8abdf2b5d800 RDI=
: 0000000000000814
> [  904.196501] [     C33] RBP: 0000000000000002 R08: ffffffffa9dff860 R09=
: 0000000000000007
> [  904.196502] [     C33] R10: 000000e65239d580 R11: 071c71c71c71c71c R12=
: ffffffffa9dff860
> [  904.196504] [     C33] R13: ffffffffa9dff948 R14: 0000000000000002 R15=
: 0000000000000000
> [  904.196510] [     C33]  ? io_idle+0x3/0x30
> [  904.196515] [     C33]  ? io_idle+0x3/0x30
> [  904.196519] [     C33]  </NMI>
> [  904.196520] [     C33]  <TASK>
> [  904.196521] [     C33]  acpi_idle_do_entry+0x22/0x50
> [  904.196526] [     C33]  acpi_idle_enter+0x7b/0xd0
> [  904.196529] [     C33]  cpuidle_enter_state+0x79/0x420
> [  904.196535] [     C33]  cpuidle_enter+0x2d/0x40
> [  904.196539] [     C33]  do_idle+0x176/0x1c0
> [  904.196544] [     C33]  cpu_startup_entry+0x29/0x30
> [  904.196548] [     C33]  start_secondary+0xf7/0x100
> [  904.196552] [     C33]  common_startup_64+0x13e/0x141
> [  904.196559] [     C33]  </TASK>
>
> Best, Fred

