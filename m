Return-Path: <linux-kernel+bounces-819692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6404CB7DD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959313B9E28
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94273323F5A;
	Tue, 16 Sep 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="oqzIvYd8"
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D92330C620
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061538; cv=none; b=p+gRf7GOgmYdMFVJ57ksUa++4TTat1XpZTe2jiGzwlHla/Cnbf+w5vNN05BXkSxek64YEH1KA/NWaVH9kRFNkoV0ONEphadPPb3snc1ngw+AlnI9jDChgCO+zocnjiV/KdDMAWEFLZPVkDZLm4VVkM3mMR2Rukw0JWG+v1pbzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061538; c=relaxed/simple;
	bh=DcQN3jpZ58OvkXflUctpG1jB5yvUEqg+t50tVLvoogk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNskRpg+CEJ2vB7fV7hcJFe2TJFpXKx8KEk0HRRcQiUhgT9WSNy9qUipggGkX2HKCAxAethjud7C1duXzw+XGOrb+siAItPGmXR1wTD2ShI4FVGrHGRlA1KicUPrOftuqtAV3e9xrLfNOnylruoR2szSW1/17ejCM3cbvPoJYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=oqzIvYd8; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EpnzCP8uSc8b5yaT1O27jIs9rdJQpLF3MRQKCDW0kmg=; b=oqzIvYd87kYcLEuUk2b2Qxsr7n
	qktNtNiL5V1ttnaxOOly/JG+6gQfKC/liziphY10g5MeQgS6OYWYLCvKz5uc5mnVr6Imi068vXEEe
	WA4dRGyWJn+PqxNIM1earWyF85v0IymWB5cmCx963Npz1oJRa4fuOf/VsM2LmK7fPsLMHTdQjJ2I5
	4u5IJETf+S+jhrYuUm85mc13kUAy1QMqtgzYx+RS6PUjyOGD3Pymb0c5nGcL6vEPag4iIVGwo7lil
	6TnO2KJFqJALrP+mtCFRNxUfnXaFOFcUur2ODFbYdSEg39ae9A/SRKsvbdTw3xJmX9dLqgfHqFDrk
	k4Bow7/A==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1uye6p-0000000017J-1HX2;
	Tue, 16 Sep 2025 18:25:11 -0400
Message-ID: <40b0f059bbb62e4bd6fed33b3990def3d2aed124.camel@surriel.com>
Subject: Re: [RFC PATCH 04/12] mm/cma: keep a global sorted list of CMA
 ranges
From: Rik van Riel <riel@surriel.com>
To: Frank van der Linden <fvdl@google.com>, akpm@linux-foundation.org, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: hannes@cmpxchg.org, david@redhat.com, roman.gushchin@linux.dev
Date: Tue, 16 Sep 2025 18:25:11 -0400
In-Reply-To: <20250915195153.462039-5-fvdl@google.com>
References: <20250915195153.462039-1-fvdl@google.com>
	 <20250915195153.462039-5-fvdl@google.com>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 19:51 +0000, Frank van der Linden wrote:
> In order to walk through CMA areas efficiently, it is useful
> to keep a global sorted list of ranges.
>=20
> Create this list when activating the areas.
>=20
> Since users of this list may want to reference the CMA area
> the range came from, there needs to be a link from the range
> to that area. So, store a pointer to the CMA structure in
> the cma_memrange structure. This also reduces the number
> of arguments to a few internal functions.
>=20
> Signed-off-by: Frank van der Linden <fvdl@google.com>
>=20

> =C2=A0static int __init cma_init_reserved_areas(void)
> =C2=A0{
> -	int i;
> +	int i, r, nranges;
> +	struct cma *cma;
> +	struct cma_memrange *cmr;
> +
> +	nranges =3D 0;
> +	for (i =3D 0; i < cma_area_count; i++) {
> +		cma =3D &cma_areas[i];
> +		nranges +=3D cma->nranges;
> +		cma_activate_area(cma);
> +	}
> +
> +	cma_ranges =3D kcalloc(nranges, sizeof(*cma_ranges),
> GFP_KERNEL);
> +	cma_nranges =3D 0;
> +	for (i =3D 0; i < cma_area_count; i++) {
> +		cma =3D &cma_areas[i];
> +		for (r =3D 0; r < cma->nranges; r++) {
> +			cmr =3D &cma->ranges[r];
> +			cma_ranges[cma_nranges++] =3D cmr;
> +		}
> +	}
> =C2=A0
> -	for (i =3D 0; i < cma_area_count; i++)
> -		cma_activate_area(&cma_areas[i]);
> +	sort(cma_ranges, cma_nranges, sizeof(*cma_ranges), cmprange,
> NULL);
>=20

I am guessing that this is safe because cma_init_reserved_areas
is an initcall, which is only called once?

Is that correct?

Is it worth documenting why this function creates
a sorted array of CMA ranges?

> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
>=20


--=20
All Rights Reversed.

