Return-Path: <linux-kernel+bounces-884806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE6C31371
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA4234F7926
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC329320CA2;
	Tue,  4 Nov 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0pQ6eeBd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8F2F5A02
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262443; cv=none; b=JJMjUp0cQ99DxWpeXxECdAe6HC6ofHVLqqeUduENVQl6dDOmPu7fCzo+xovpkiCltAKDPgyUw1CCLwhDq0uNYBn1f3+P4azdCizXiB+c/hDRBTd/YCuBlC4WFTPbcVs9DOWc12YeEFLe3pKg4f1omB00kKkwULEtajXIU5UzMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262443; c=relaxed/simple;
	bh=muJjyL1ZUkCFIRMnJVcw6jPbIc63lMLSCsSak2Qjrsk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXc2cG93Je85DAZoKQv5zZklnAFbVdOombq1CCULUW9BGQDEz5fxkzeSZ3zFMJfg6rLZ1nZPINjjaZZOms4ayVpIY/FjFwTDDUY/CEylbpxpE2026oVulpXm1D+i8sa7wJfTnpS0w8zlz/wzZl2tJwF3s5ajrdbHlo2QzT8wsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0pQ6eeBd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762262441; x=1793798441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=muJjyL1ZUkCFIRMnJVcw6jPbIc63lMLSCsSak2Qjrsk=;
  b=0pQ6eeBdk0RoTFSbizEXvGVt09wVQPthsd2iD591mFQQjoUmSJZbKLDL
   wmQknAhtxlj4Ec6nG+/i80Irbjt16AuBYYlBCpHplIhLlsxwpmR1zsNXx
   OFRsuuYg7tAPIrC+8jOAFxXz4ATbzoPIDn019hTi+wRXFb47qHklKBV42
   82AZQ+nmqTk1MIBNqf9tx5eOLgVbt2G5EZsT4iIYgRGzpPPFCKXRmxG4Q
   dGE9PkejG45Yywh2jK8adhoh79bKftEVUYnLCR/qq5uJOl1oIT8XnHZfm
   BxyPqbba0AV7BJkkjFWWN/wdi2mvx/q6qez8pQBL+9P790KIgU4Fpxot6
   g==;
X-CSE-ConnectionGUID: /qRgm63OQfmsM8NexuLh2A==
X-CSE-MsgGUID: p+23sVE3RPWPANVT5ApTEg==
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="asc'?scan'208";a="280036531"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 06:20:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 06:19:54 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 06:19:52 -0700
Date: Tue, 4 Nov 2025 13:18:09 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
CC: "conor@kernel.org" <conor@kernel.org>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "cfu@wavecomp.com"
	<cfu@wavecomp.com>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>
Subject: Re: [PATCH] riscv: Update MIPS vendor id to 0x127.
Message-ID: <20251104-iciness-ranting-29dd93fe6a7e@wendy>
References: <20251103-tabby-laurel-bc895f236a69@spud>
 <e0e4d521-cf50-4384-8461-e87b15044089@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SlwtsFVMIDtSsTYq"
Content-Disposition: inline
In-Reply-To: <e0e4d521-cf50-4384-8461-e87b15044089@htecgroup.com>

--SlwtsFVMIDtSsTYq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 11:53:49AM +0000, Aleksa Paunovic wrote:
> On 11/3/25 23:07, Conor Dooley wrote:
> > On Mon, Nov 03, 2025 at 04:05:48PM +0100, Aleksa Paunovic wrote:
> >> From: Chao-ying Fu <cfu@wavecomp.com>
> >>
> >> [1] defines MIPS vendor id as 0x127.
> >>
> >> [1] https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Refe=
rence_Manual_Rev1.84_5-31-2025.pdf
> >>
> >> Fixes: a8fed1bc03ace27902338e4f0d318335883ac847 ("riscv: Add xmipsexec=
tl as a vendor extension")
> > Incorrect format for fixes tags!
>=20
> Will fix that in v2.
>=20
> >
> >> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> >> ---
> >>  arch/riscv/include/asm/vendorid_list.h | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/inclu=
de/asm/vendorid_list.h
> >> index 3b09874d7a6dfb8f8aa45b0be41c20711d539e78..55205f7938055ba2b744db=
a5118bba935bcac008 100644
> >> --- a/arch/riscv/include/asm/vendorid_list.h
> >> +++ b/arch/riscv/include/asm/vendorid_list.h
> >> @@ -9,6 +9,6 @@
> >>  #define MICROCHIP_VENDOR_ID	0x029
> >>  #define SIFIVE_VENDOR_ID	0x489
> >>  #define THEAD_VENDOR_ID		0x5b7
> >> -#define MIPS_VENDOR_ID		0x722
> >> +#define MIPS_VENDOR_ID		0x127
> > How was this ever wrong? Do devices exist with this old ID? Do we need
> > to support both as vendor IDs for MIPS?
>=20
> I'm not sure how it first started, but since we worked on qemu as well, w=
e never noticed any issues while testing.=A0
> It shouldn't cause any problems in the future though.

So all the hardware uses the 0x127 id? Where did 0x722 come from?
I recall qemu defaults to 0x0, so were none of the mips code paths
tested, or were they tested with a qemu modified to use 0x722?

--SlwtsFVMIDtSsTYq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQn9EQAKCRB4tDGHoIJi
0tImAQC24un7hBWLjAJmz+RBM0YsVlVpiVuTx3AbwR0sFqC6twD+MM4CSYrlS+Wy
c1uRH+D7LVnyYsRmLzAdccel8p4iFQA=
=+1Y4
-----END PGP SIGNATURE-----

--SlwtsFVMIDtSsTYq--

