Return-Path: <linux-kernel+bounces-884896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C375DC31764
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606C94650BC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D58327783;
	Tue,  4 Nov 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SGa4XxJ0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D452221FCC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265505; cv=none; b=Roy9wMAUtNpeQcG1FoKxD18BYlOD2WYtIcbq6FiProfz8G+YHQRpB311rSuzqnKwVk82GodqDTY77Iy7Unx+Jw4EE9HVbMsQvRwHivvpH0SgnFAXK8UpdsnlEOeZcw0NUF8SkkWGvKclgfD+7HNLD3LrfN4IV0VjibCWm+loa0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265505; c=relaxed/simple;
	bh=Ex8XdeL/8Gi1LCfuPJxHKOEhuXFMFx5Il6pVqKcnCAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er79kZdTrGrQbg0TdKPkTWFiOgZY9CxElNegPiHlMPkuHYkILlG1lGeap/mDKEP/UyAkNewy8knz+nf7lD+2g7f4A1ifXcJaCl3zN6wCcXNp2MLtg0nw31ADT2CT39Euk1FceN+LrdODpsxq1eFPRyhvjl6gnTZ1h0yi8ESQLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SGa4XxJ0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762265503; x=1793801503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ex8XdeL/8Gi1LCfuPJxHKOEhuXFMFx5Il6pVqKcnCAI=;
  b=SGa4XxJ0dVGiRVQCbVatBLOfAy3eNgEKoMxhHA2iS+cuqlVh/dbZRDX0
   fhEYHkndgr6l3H2//WTNLK6vyhKV0bPD+wwO5KYGu7wkLm82nuqWXosbj
   iOJQbMrTPHR2/cP5kOb0HgCM4GZSwgpfqcVD+7EQBX3yP65iqWRrqqzIw
   DlPBDtcGTMzV2rbtIM11zgTqQedbacU1zUs1cX43vrEm9jTk/G1mOLP8Y
   x6X3LaFtBl+o0tV4Ot61mwY3l+yOyufgx0tCEcfo95NX3nfGZ+QYpTa7H
   XpiWnE6OUVkY/GIXkbPR4pVyUVBxASRt1O5ZHDEBc4Uer4Lrx4BzWCFEC
   Q==;
X-CSE-ConnectionGUID: 6jdsD7f5TPqVV8cNAt/ljg==
X-CSE-MsgGUID: veeYOFsNTXukUHMFtEd39g==
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="asc'?scan'208";a="48029652"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2025 07:11:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Nov 2025 07:10:55 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 07:10:52 -0700
Date: Tue, 4 Nov 2025 14:09:08 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"cfu@wavecomp.com" <cfu@wavecomp.com>, "conor@kernel.org" <conor@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>
Subject: Re: [PATCH] riscv: Update MIPS vendor id to 0x127.
Message-ID: <20251104-reclining-eskimo-9ab425c708d3@wendy>
References: <20251104-iciness-ranting-29dd93fe6a7e@wendy>
 <bb3a2237-6dde-4231-a016-faf190f9a877@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZDEVGWACkCSeSg9+"
Content-Disposition: inline
In-Reply-To: <bb3a2237-6dde-4231-a016-faf190f9a877@htecgroup.com>

--ZDEVGWACkCSeSg9+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 02:06:31PM +0000, Aleksa Paunovic wrote:
> On 11/4/25 14:18, Conor Dooley wrote:
>=20
> > On Tue, Nov 04, 2025 at 11:53:49AM +0000, Aleksa Paunovic wrote:
> >> On 11/3/25 23:07, Conor Dooley wrote:
> >>> On Mon, Nov 03, 2025 at 04:05:48PM +0100, Aleksa Paunovic wrote:
> >>>> From: Chao-ying Fu <cfu@wavecomp.com>

While I am here, you have a From: header with Chao-ying it it, but the
patch has not been signed off by them.

> >>>>
> >>>> [1] defines MIPS vendor id as 0x127.
> >>>>
> >>>> [1] https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Re=
ference_Manual_Rev1.84_5-31-2025.pdf
> >>>>
> >>>> Fixes: a8fed1bc03ace27902338e4f0d318335883ac847 ("riscv: Add xmipsex=
ectl as a vendor extension")
> >>> Incorrect format for fixes tags!
> >> Will fix that in v2.
> >>
> >>>> Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
> >>>> ---
> >>>>  arch/riscv/include/asm/vendorid_list.h | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/inc=
lude/asm/vendorid_list.h
> >>>> index 3b09874d7a6dfb8f8aa45b0be41c20711d539e78..55205f7938055ba2b744=
dba5118bba935bcac008 100644
> >>>> --- a/arch/riscv/include/asm/vendorid_list.h
> >>>> +++ b/arch/riscv/include/asm/vendorid_list.h
> >>>> @@ -9,6 +9,6 @@
> >>>>  #define MICROCHIP_VENDOR_ID	0x029
> >>>>  #define SIFIVE_VENDOR_ID	0x489
> >>>>  #define THEAD_VENDOR_ID		0x5b7
> >>>> -#define MIPS_VENDOR_ID		0x722
> >>>> +#define MIPS_VENDOR_ID		0x127
> >>> How was this ever wrong? Do devices exist with this old ID? Do we need
> >>> to support both as vendor IDs for MIPS?
> >> I'm not sure how it first started, but since we worked on qemu as well=
, we never noticed any issues while testing.=A0
> >> It shouldn't cause any problems in the future though.
> > So all the hardware uses the 0x127 id? Where did 0x722 come from?
> > I recall qemu defaults to 0x0, so were none of the mips code paths
> > tested, or were they tested with a qemu modified to use 0x722?
>=20
>=20
> That is correct, all hardware uses the 0x127 id.=A0
>=20
> I'm not sure where we got 0x722 from - perhaps I or someone else misread =
the value=A0
>=20
> (0x27 and 0x2 are both mentioned in the Programmer's Guide mvendorid bit =
descriptions).
>=20
>=20
> Everything was tested with qemu modified to use 0x722. Please see [1], fo=
r example.
>=20
>=20
> [1] https://patchew.org/QEMU/20250717093833.402237-1-djordje.todorovic@ht=
ecgroup.com/20250717093833.402237-4-djordje.todorovic@htecgroup.com/

Okay, cool. Can you put this information into the commit message? It
should really explain what went wrong and what is impacted by the
change.

--ZDEVGWACkCSeSg9+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQoJBAAKCRB4tDGHoIJi
0veVAP9aIWLMy4lMYIWj0uj8Yn4S4IWNd55ETr8Jmh178uAVJwEAxgR20BCN+zgr
Jb6U3+MUM5nAeAPCsgYzRrV5uPZetgQ=
=1G5I
-----END PGP SIGNATURE-----

--ZDEVGWACkCSeSg9+--

