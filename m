Return-Path: <linux-kernel+bounces-758442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39082B1CF2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0C6722ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D27230BF6;
	Wed,  6 Aug 2025 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="DhLWq+tb"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1521CC4E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754520698; cv=none; b=PLq66bvimkqan9j6XZGG5i6K73Ml971mlaUedCYo4oXp0sSSNoLSK/suB/JQeLZ7rqasvw7i4TtL3NzZzKaBXNs1pXcerNdqBdsZUiCGhmDZGYhhlgHh30KRbO9WlIZPaBq47bKp2dxYXFJuseQDO/ioOZoXtjzaWbBhxB8W7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754520698; c=relaxed/simple;
	bh=z+Dkz5RU7j6W/YO6mH6YymkiHvcLoGucWDB+G05SloA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBYWazWngECKm71rE0oLamKKs29aA/MR7Zl0DHE56x14XcIPNV8ueBSDARypmcGFrr9VzM0d9InDsAsamV+CN5IUbyrXAWRURmYeU1sKOYJ1E/MIQZFtlBTKtjBof92yYvwTw/YY1Q5pYlGsYX4wvDoJwmpoHL1mDWdGTBp1HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=DhLWq+tb; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7430835eae1so247640a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754520695; x=1755125495; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XI3wvYS/lnXeNfSoy/Za4DMu5n2poOYMyXxpU/vc4tU=;
        b=DhLWq+tbbWr0WzLA1XI5RlayJjXXU9N4dQ6W5DW+A+a5NN2cTpOgRRauDcNbk1aVBu
         uBUsStrIVaXa2oa3LWva/+SjNFE2HxWissiZtDVZJ5IaKBAkqSRlceg6RPYO83jbdisc
         diMYl9cJd/g8Uhl2QEQtYgi4DNNFtRwYcjD0d3AmbxrfTOUOuK+MXQfzxYP7e7O0rZYI
         kViuHb2KKMefSZqSY47gYRI+ecBdRFTYgaHXjukfgFVlkuVHIPwr175BKzCDGcWYxy28
         kYqR+XLnc0riggc8710wVfhDVdThW9+AP7zLQ4tEiysa/pxRYy67n+wz6G/xaN49YHHu
         tOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754520695; x=1755125495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XI3wvYS/lnXeNfSoy/Za4DMu5n2poOYMyXxpU/vc4tU=;
        b=J/11Z60QXO31wkgjOuaJ/Y7EBz4/8AzQdMpRSwRLLtpPSbxBvM+L/N0I0nMlqkxQ1/
         h21RxIw4S+vGlLnUw/pRWox9DeeYM1RiOMeHUN0tlqNGTpej8c5KJ+/tINEixWHMTSTz
         d6MRav0GoqSa5a8E8njcGvvoQD2Yu/61Eck/CR9v4LDJdEag6ppgGgZIFsv7+to8RVkN
         m4uOFkiDPNz4w4rfpy7OV43gTwzvTLDgQXXKMW35I8FLHUh0QlDMgzdIgGqr2D79P26I
         0+VnqpE0q8tVZLG9a7LdfXQsQSdQRyYUg7GcrNH3gJsAQzCTaYXpk0GUKKZsTOXMnI2h
         eGSw==
X-Forwarded-Encrypted: i=1; AJvYcCVizM+DmMoohuY6vadMc7IfLQCNEIBrYAGIluXBE7lrPA0xil7VlQsHpUGsBmKTkQ4LqpL9JIPn91x3DyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyebG+t+09WQM3EFrsEqLENAsVHlxYRwhvcGQE+ntyabh1bDTr1
	G1kxh3ugXDNyeQrKWt+WZp460WQuAkj3lL6oaOeYylMeAaBMtqcPFRRaJY8eB3N8XeI=
X-Gm-Gg: ASbGncuCCX7dapaJK8m5FZeoBwEnOC3hOyhZe/8keczOlCoHAYSOCBuB1CRm5uG4AMJ
	DqYqDrPN+iVmx0gACuneHNvts4JD95YBgH+wdVZaTs5+Xe6tLMXthanGIeiEWd0s9WIXN2pLHYc
	taMgpgUiZ7uVGOPLnXLIwhfhLGfH73y2qDpP7IHi35fAyziyZmNu0MmntnZ0h9ifteAwgcgJaDx
	cfaxXo/z9zQnc+kI+SqDNh3RQgqN09fo9RDRB55xMQCUNRIBGbCywLkXRvg8AtV+FgMCeO8JMqy
	9e3NuBF9kD9HXXBe8QyvbY++/63QmSmYg3yEvDAzpc0QdiipgotsmUd21FzfyGXLsawEdZ+SMMo
	pl48LMjv0Hf54zHJx0rFIngzc3n0rcbrtbIZJ
X-Google-Smtp-Source: AGHT+IEER8SNjUkk+XQ+0FQIHWebX8c2pQMO4swBsvdjUELKc5qZLOWV1REwTtQBYBWnkaeBK04Ddg==
X-Received: by 2002:a05:6830:668d:b0:742:f88c:925b with SMTP id 46e09a7af769-7431938c55bmr1186905a34.12.1754520694617;
        Wed, 06 Aug 2025 15:51:34 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:bf4a:88b3:3a0c:4264])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742fb03407asm1211957a34.41.2025.08.06.15.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 15:51:34 -0700 (PDT)
Date: Wed, 6 Aug 2025 17:51:29 -0500
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [BUG] ipmi_si: watchdog: Watchdog detected hard LOCKUP
Message-ID: <aJPccSayM2nXk891@mail.minyard.net>
Reply-To: corey@minyard.net
References: <aJO3q8JiVXKewMjW@CMGLRV3>
 <CA+QrTELaLFRGn1ynG5dG+KB_40aPA31hU5QgLn7ikh2Zbk3Hpg@mail.gmail.com>
 <aJPGItElGBN3nilX@mail.minyard.net>
 <aJPK6Vuxc1jL-uu_@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aJPK6Vuxc1jL-uu_@CMGLRV3>

On Wed, Aug 06, 2025 at 04:36:41PM -0500, Frederick Lawler wrote:
> On Wed, Aug 06, 2025 at 04:16:18PM -0500, Corey Minyard wrote:
> > On Wed, Aug 06, 2025 at 03:19:02PM -0500, Fred Lawler wrote:
> > > + CC: Corey Minyard <corey@minyard.net>
> > >=20
>=20
> > I'm wondering if something is happening with the BMC resetting and
> > interactions with ACPI involved in that.  Adding the extra part of
> > trying to talk to the BMC while it's being reset could cause the BMC to
> > get confused and do bad things?
> >=20
>=20
> Sure, it's a possibility we explored. We have a lot of automation.
> Predominately of which is a prometheus module exporting IPMI information
> from the sysfs files. And we also have config management that's querying
> sysfs files to regulate updates etc... Sometimes, the config management
> automation will attempt to reset the BMC.

Ok.  I have tests that do BMC resets, but I can't run at the scale you
do, and I'm running in a simulator so it's not going to be have the
same.

The other possibility is the processor goes into the idle code while
interrupts are off, but I think the kernel has checks all around that.
I can't think of how else a processor would get stuck in idle.

>=20
> > > >
> > > > I tried also tried to load the CPUs with stress-ng, but the best I =
can do
> > > > are the hung tasks.
> > > >
> > > > I identified that sni_send()[1] could be locked behind the
> > > > spin_lock_irqsave() and within the KCS send handler, there's anothe=
r irq
> > > > save lock. I suspect this is where we're getting hung up. Below is a
> > > > sample stack trace + log output.
> >=20
> > Yeah, I don't see that in the traceback.  There is a lock in the KCS
> > sender, but I don't see how that could do anything.
> >=20
> > Maybe you could try changing the cpuidle handler?  That would be at
> > least something to try.
> >=20
>=20
> Would that help in forming a reproducer? I'd need to deploy any kernel
> modifications fleet wide to cast a wide enough net. The lockups arn't
> extremely consistent. We may get a couple or more a week.

Ah, so this isn't readily reproducable.  Bummer.

If the problem goes away if you change the cpuidle handler to something
non-ACPI, that would be a big clue that it's an ACPI issue.

>=20
> Lastly, I have the rate limit patch backported. I'll be able to start
> testing with that tomorrow, and same with loading the IPMI watchdog
> module.

Ok.  I don't have much hope for it making much difference, but it's safe
and will be coming in the next kernel release.

-corey

>=20
> > -corey
> >=20
> > > >
> > > > I'm happy to provide traces and additional information, let me know.
> > > >
> > > > Links:
> > > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.g=
it/tree/drivers/char/ipmi/ipmi_msghandler.c?h=3Dlinux-6.12.y#n1899
> > > >
> > > > [  499.564572] [  T27255] ip6_tunnel: pni_gre_814 xmit: Local addre=
ss not yet configured!
> > > > [  499.588176] [  T27255] ip6_tunnel: pni_gre_868 xmit: Local addre=
ss not yet configured!
> > > > [  499.605284] [  T27255] ip6_tunnel: pni_gre_871 xmit: Local addre=
ss not yet configured!
> > > > [  805.906999] [  T12765] usb 1-1: USB disconnect, device number 2
> > > > [  845.346020] [  T12765] usb 1-1: new high-speed USB device number=
 3 using xhci_hcd
> > > > [  845.485453] [  T12765] usb 1-1: New USB device found, idVendor=
=3D1d6b, idProduct=3D0107, bcdDevice=3D 1.00
> > > > [  845.496823] [  T12765] usb 1-1: New USB device strings: Mfr=3D3,=
 Product=3D2, SerialNumber=3D1
> > > > [  845.507242] [  T12765] usb 1-1: Product: USB Virtual Hub
> > > > [  845.514946] [  T12765] usb 1-1: Manufacturer: Aspeed
> > > > [  845.522363] [  T12765] usb 1-1: SerialNumber: 00000000
> > > > [  845.530454] [  T12765] usb 1-1: Device is not authorized for usa=
ge
> > > > [  853.774910] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.783794] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.792649] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.801461] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.810291] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.819069] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.827816] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.836581] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.845326] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.854074] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  853.862813] [    C119] ipmi_si IPI0001:00: KCS in invalid state 6
> > > > [  863.934436] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  863.943420] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  863.952363] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  863.961296] [ T124929] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  878.616336] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  878.624905] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  878.633427] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  878.641954] [ T126542] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  880.310112] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  880.318682] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  880.327083] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  880.335483] [ T126681] ipmi_si IPI0001:00: KCS in invalid state 7
> > > > [  904.196122] [     C33] watchdog: Watchdog detected hard LOCKUP o=
n cpu 33
> > > > [  904.196127] [     C97] Uhhuh. NMI received for unknown reason 3d=
 on CPU 97.
> > > > [  904.196126] [      C6] Uhhuh. NMI received for unknown reason 3d=
 on CPU 6.
> > > > [  904.196130] [     C33] Modules linked in:
> > > > [  904.196129] [    C101] Uhhuh. NMI received for unknown reason 3d=
 on CPU 101.
> > > > [  904.196131] [     C97] Dazed and confused, but trying to continue
> > > > [  904.196131] [     C33]  nft_fwd_netdev
> > > > [  904.196131] [     C99] Uhhuh. NMI received for unknown reason 2d=
 on CPU 99.
> > > > [  904.196133] [      C6] Dazed and confused, but trying to continue
> > > > [  904.196133] [    C102] Uhhuh. NMI received for unknown reason 2d=
 on CPU 102.
> > > > [  904.196134] [     C33]  nf_dup_netdev
> > > > [  904.196134] [     C35] Uhhuh. NMI received for unknown reason 2d=
 on CPU 35.
> > > > [  904.196135] [    C101] Dazed and confused, but trying to continue
> > > > [  904.196137] [     C99] Dazed and confused, but trying to continue
> > > > [  904.196137] [     C33]  xfrm_interface
> > > > [  904.196136] [     C69] Uhhuh. NMI received for unknown reason 2d=
 on CPU 69.
> > > > [  904.196140] [    C102] Dazed and confused, but trying to continue
> > > > [  904.196140] [     C33]  xfrm6_tunnel
> > > > [  904.196138] [    C121] Uhhuh. NMI received for unknown reason 2d=
 on CPU 121.
> > > > [  904.196140] [    C123] Uhhuh. NMI received for unknown reason 2d=
 on CPU 123.
> > > > [  904.196142] [     C35] Dazed and confused, but trying to continue
> > > > [  904.196143] [     C69] Dazed and confused, but trying to continue
> > > > [  904.196143] [     C33]  nft_numgen
> > > > [  904.196143] [     C61] Uhhuh. NMI received for unknown reason 2d=
 on CPU 61.
> > > > [  904.196144] [     C62] Uhhuh. NMI received for unknown reason 3d=
 on CPU 62.
> > > > [  904.196146] [    C123] Dazed and confused, but trying to continue
> > > > [  904.196147] [    C121] Dazed and confused, but trying to continue
> > > > [  904.196148] [     C58] Dazed and confused, but trying to continue
> > > > [  904.196150] [     C33]  nft_log nft_limit sit dummy ipip tunnel4=
 ip_gre gre xfrm_user xfrm_algo tls mpls_iptunnel mpls_router nft_ct nf_tab=
les iptable_raw iptable_nat iptable_mangle ipt_REJECT nf_reject_ipv4 ip6tab=
le_security xt_CT ip6table_raw xt_nat ip6table_nat nf_nat xt_TCPMSS xt_owne=
r xt_DSCP xt_NFLOG xt_connbytes xt_connlabel xt_statistic xt_connmark ip6ta=
ble_mangle xt_limit xt_LOG nf_log_syslog xt_mark xt_conntrack ip6t_REJECT n=
f_reject_ipv6 xt_multiport xt_set xt_tcpmss xt_comment xt_tcpudp ip6table_f=
ilter ip6_tables nfnetlink_log udp_diag dm_thin_pool dm_persistent_data dm_=
bio_prison dm_bufio iptable_filter veth tcp_diag inet_diag mpls_gso act_mpl=
s cls_flower cls_bpf sch_ingress ip_set_hash_ip ip_set_hash_net ip_set tcp_=
bbr sch_fq tun xt_bpf nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 fou6 fou i=
p_tunnel ip6_udp_tunnel udp_tunnel ip6_tunnel tunnel6 nvme_fabrics raid0 md=
_mod essiv dm_crypt trusted asn1_encoder tee dm_mod dax 8021q garp mrp stp =
llc ipmi_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclmul crc32c_intel
> > > > [  904.196247] [     C33]  sha512_ssse3 sha256_ssse3 sha1_ssse3 aes=
ni_intel crypto_simd xhci_pci binfmt_misc acpi_ipmi cryptd ipmi_si nvme rap=
l ipmi_devintf i2c_piix4 tiny_power_button bnxt_en xhci_hcd nvme_core ccp i=
2c_smbus ipmi_msghandler button fuse configfs nfnetlink efivarfs ip_tables =
x_tables bcmcrypt(O)
> > > > [  904.196281] [     C33] CPU: 33 UID: 0 PID: 0 Comm: swapper/33 Kd=
ump: loaded Tainted: G           O       6.12.34-cloudflare-2025.6.9 #1
> > > > [  904.196286] [     C33] Tainted: [O]=3DOOT_MODULE
> > > > [  904.196287] [     C33] Hardware name: GIGABYTE R162-Z12-CD-G11P5=
/MZ12-HD4-CD, BIOS M10-sig 02/17/2025
> > > > [  904.196290] [     C33] RIP: 0010:io_idle+0x3/0x30
> > > > [  904.196298] [     C33] Code: 8b 00 a8 08 75 07 e8 2c e4 ff ff 90=
 fa e9 c0 b3 1a 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 90 90 89 fa ec <48> 8b 05 96 42 d4 01 a9 00 00 00 80 75 11 80 3d 4a 42 d4 =
01 00 75
> > > > [  904.196301] [     C33] RSP: 0018:ffff9afa88307e70 EFLAGS: 000000=
93
> > > > [  904.196304] [     C33] RAX: 0000000000000000 RBX: ffff8abdf2b5d8=
98 RCX: 0000000000000040
> > > > [  904.196306] [     C33] RDX: 0000000000000814 RSI: ffff8abdf2b5d8=
00 RDI: 0000000000000814
> > > > [  904.196308] [     C33] RBP: 0000000000000002 R08: ffffffffa9dff8=
60 R09: 0000000000000007
> > > > [  904.196309] [     C33] R10: 000000e65239d580 R11: 071c71c71c71c7=
1c R12: ffffffffa9dff860
> > > > [  904.196311] [     C33] R13: ffffffffa9dff948 R14: 00000000000000=
02 R15: 0000000000000000
> > > > [  904.196313] [     C33] FS:  0000000000000000(0000) GS:ffff8aadcf=
680000(0000) knlGS:0000000000000000
> > > > [  904.196316] [     C33] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> > > > [  904.196318] [     C33] CR2: 00005632ce239000 CR3: 0000003944f720=
04 CR4: 0000000000770ef0
> > > > [  904.196320] [     C33] PKRU: 55555554
> > > > [  904.196322] [     C33] Call Trace:
> > > > [  904.196324] [     C33]  <TASK>
> > > > [  904.196326] [     C33]  acpi_idle_do_entry+0x22/0x50
> > > > [  904.196336] [     C33]  acpi_idle_enter+0x7b/0xd0
> > > > [  904.196340] [     C33]  cpuidle_enter_state+0x79/0x420
> > > > [  904.196345] [     C33]  cpuidle_enter+0x2d/0x40
> > > > [  904.196352] [     C33]  do_idle+0x176/0x1c0
> > > > [  904.196358] [     C33]  cpu_startup_entry+0x29/0x30
> > > > [  904.196362] [     C33]  start_secondary+0xf7/0x100
> > > > [  904.196366] [     C33]  common_startup_64+0x13e/0x141
> > > > [  904.196374] [     C33]  </TASK>
> > > > [  904.196377] [     C33] Kernel panic - not syncing: Hard LOCKUP
> > > > [  904.196379] [     C33] CPU: 33 UID: 0 PID: 0 Comm: swapper/33 Kd=
ump: loaded Tainted: G           O       6.12.34-cloudflare-2025.6.9 #1
> > > > [  904.196383] [     C33] Tainted: [O]=3DOOT_MODULE
> > > > [  904.196384] [     C33] Hardware name: GIGABYTE R162-Z12-CD-G11P5=
/MZ12-HD4-CD, BIOS M10-sig 02/17/2025
> > > > [  904.196385] [     C33] Call Trace:
> > > > [  904.196387] [     C33]  <NMI>
> > > > [  904.196389] [     C33]  dump_stack_lvl+0x4b/0x70
> > > > [  904.196394] [     C33]  panic+0x106/0x2c4
> > > > [  904.196401] [     C33]  nmi_panic.cold+0xc/0xc
> > > > [  904.196404] [     C33]  watchdog_hardlockup_check.cold+0xc6/0xe8
> > > > [  904.196409] [     C33]  __perf_event_overflow+0x15a/0x450
> > > > [  904.196416] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > [  904.196421] [     C33]  x86_pmu_handle_irq+0x18a/0x1c0
> > > > [  904.196436] [     C33]  ? set_pte_vaddr+0x40/0x50
> > > > [  904.196439] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > [  904.196442] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > [  904.196445] [     C33]  ? native_set_fixmap+0x63/0xb0
> > > > [  904.196448] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > [  904.196451] [     C33]  ? ghes_copy_tofrom_phys+0x7a/0x100
> > > > [  904.196457] [     C33]  ? srso_alias_return_thunk+0x5/0xfbef5
> > > > [  904.196460] [     C33]  ? __ghes_peek_estatus.isra.0+0x49/0xa0
> > > > [  904.196465] [     C33]  amd_pmu_handle_irq+0x4b/0xc0
> > > > [  904.196469] [     C33]  perf_event_nmi_handler+0x2a/0x50
> > > > [  904.196473] [     C33]  nmi_handle.part.0+0x59/0x110
> > > > [  904.196479] [     C33]  default_do_nmi+0x127/0x180
> > > > [  904.196483] [     C33]  exc_nmi+0x103/0x180
> > > > [  904.196486] [     C33]  end_repeat_nmi+0xf/0x53
> > > > [  904.196489] [     C33] RIP: 0010:io_idle+0x3/0x30
> > > > [  904.196493] [     C33] Code: 8b 00 a8 08 75 07 e8 2c e4 ff ff 90=
 fa e9 c0 b3 1a 00 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90=
 90 90 89 fa ec <48> 8b 05 96 42 d4 01 a9 00 00 00 80 75 11 80 3d 4a 42 d4 =
01 00 75
> > > > [  904.196495] [     C33] RSP: 0018:ffff9afa88307e70 EFLAGS: 000000=
93
> > > > [  904.196497] [     C33] RAX: 0000000000000000 RBX: ffff8abdf2b5d8=
98 RCX: 0000000000000040
> > > > [  904.196499] [     C33] RDX: 0000000000000814 RSI: ffff8abdf2b5d8=
00 RDI: 0000000000000814
> > > > [  904.196501] [     C33] RBP: 0000000000000002 R08: ffffffffa9dff8=
60 R09: 0000000000000007
> > > > [  904.196502] [     C33] R10: 000000e65239d580 R11: 071c71c71c71c7=
1c R12: ffffffffa9dff860
> > > > [  904.196504] [     C33] R13: ffffffffa9dff948 R14: 00000000000000=
02 R15: 0000000000000000
> > > > [  904.196510] [     C33]  ? io_idle+0x3/0x30
> > > > [  904.196515] [     C33]  ? io_idle+0x3/0x30
> > > > [  904.196519] [     C33]  </NMI>
> > > > [  904.196520] [     C33]  <TASK>
> > > > [  904.196521] [     C33]  acpi_idle_do_entry+0x22/0x50
> > > > [  904.196526] [     C33]  acpi_idle_enter+0x7b/0xd0
> > > > [  904.196529] [     C33]  cpuidle_enter_state+0x79/0x420
> > > > [  904.196535] [     C33]  cpuidle_enter+0x2d/0x40
> > > > [  904.196539] [     C33]  do_idle+0x176/0x1c0
> > > > [  904.196544] [     C33]  cpu_startup_entry+0x29/0x30
> > > > [  904.196548] [     C33]  start_secondary+0xf7/0x100
> > > > [  904.196552] [     C33]  common_startup_64+0x13e/0x141
> > > > [  904.196559] [     C33]  </TASK>
> > > >
> > > > Best, Fred

