Return-Path: <linux-kernel+bounces-810135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFFCB51678
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C9C1C819A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041528C869;
	Wed, 10 Sep 2025 12:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HznxM6Zq"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBAD2848A0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757505765; cv=none; b=fvexUSh050/JsnimE65STU5afOIuxNE2z6ZA7QzOV71ieXJfX3XXf3howSHgt3H3zSdvMcaGgUHD11t+t87P+IUkXS84PtNIfOGK+WtRnqmzHdcHkLKx231VQ/vaExAC95nRjRuY6DcRoMF2lFz9Br1ovWSx2dAmo2x5mhUhDZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757505765; c=relaxed/simple;
	bh=jxew0vf7RuEzFnDze3/ICM1/y+QsIW5w3xJ75Vrwjdo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=eQLrXk53GDL0qkTvETtq8PYB5PwkWBjBaqLUTtvsHoxhq9fVYj4ust/d8/6Fui4bGYsBDaFbTM5QdJgXrDO6eVfZ17Q1U1BP/9EOox3IWb3V/u4BSN8ayMRsUKRjfbaa1sGy6u/LF8/3YuFlOcdjwPeeLKYvPeoSsu/rmFHUZFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HznxM6Zq; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250910120241epoutp01f1a1e3259c1f92b237e69b36dba8d6ac~j6i27F0v21454614546epoutp01d
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:02:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250910120241epoutp01f1a1e3259c1f92b237e69b36dba8d6ac~j6i27F0v21454614546epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757505761;
	bh=zBxS2L/AuWYp7TGtZwdzdWsLouc3JAEYP1TBSrBikwY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HznxM6ZqLvci8L6Fon5wk1dUzrTk9jICGqO3u4qDrQz0AocTt8sC1cKqenHC3p0lx
	 4IgWFBYHA7nq+E6+YgMQcI1rIfAvQP27cSK++ClEkI7UDDqtQWzqH9pq16PqZwvWIY
	 tigdfvkS/cRB3W0hCKgpJF+juD3t8PxrD2Gje0WE=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250910120240epcas5p1248fc9324e5ae8caa7f23ce34d0842de~j6i2Oht0y2148721487epcas5p1h;
	Wed, 10 Sep 2025 12:02:40 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cMK7h0VPcz2SSKY; Wed, 10 Sep
	2025 12:02:40 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250910120239epcas5p108aec1b642bf599978295ab7fd7e8721~j6i03PBiy2614626146epcas5p1K;
	Wed, 10 Sep 2025 12:02:39 +0000 (GMT)
Received: from INBRO002198 (unknown [107.122.5.156]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250910120237epsmtip19c210334904b3e1396315bc66436d0a6~j6iyj4SMI2315323153epsmtip1j;
	Wed, 10 Sep 2025 12:02:36 +0000 (GMT)
From: "Raghav Sharma" <raghav.s@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <s.nawrocki@samsung.com>,
	<cw00.choi@samsung.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <sunyeal.hong@samsung.com>,
	<shin.son@samsung.com>, <alim.akhtar@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dev.tailor@samsung.com>,
	<chandan.vn@samsung.com>, <karthik.sun@samsung.com>
In-Reply-To: <f8ad7883-d879-47ce-aafc-7c5f741f3c18@kernel.org>
Subject: RE: [PATCH v1 3/3] arm64: dts: exynosautov920: add CMU_M2M clock DT
 nodes
Date: Wed, 10 Sep 2025 17:32:25 +0530
Message-ID: <08fe01dc224a$cde7ff50$69b7fdf0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL0VUKk+u5fQqVv+k+NmjKuZqPkUAF92JyxAaWVb6EA7wl7+7I7Vh2g
Content-Language: en-us
X-CMS-MailID: 20250910120239epcas5p108aec1b642bf599978295ab7fd7e8721
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250808141247epcas5p2c254f35146a6ea35b5c49c4316ba30a3
References: <20250808142146.3181062-1-raghav.s@samsung.com>
	<CGME20250808141247epcas5p2c254f35146a6ea35b5c49c4316ba30a3@epcas5p2.samsung.com>
	<20250808142146.3181062-4-raghav.s@samsung.com>
	<f8ad7883-d879-47ce-aafc-7c5f741f3c18@kernel.org>

Hi Krzysztof

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: Monday, August 11, 2025 12:19 PM
> To: Raghav Sharma <raghav.s=40samsung.com>; s.nawrocki=40samsung.com;
> cw00.choi=40samsung.com; mturquette=40baylibre.com; sboyd=40kernel.org;
> robh=40kernel.org; conor+dt=40kernel.org; sunyeal.hong=40samsung.com;
> shin.son=40samsung.com; alim.akhtar=40samsung.com
> Cc: linux-samsung-soc=40vger.kernel.org; linux-clk=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> kernel=40vger.kernel.org; dev.tailor=40samsung.com; chandan.vn=40samsung.=
com;
> karthik.sun=40samsung.com
> Subject: Re: =5BPATCH v1 3/3=5D arm64: dts: exynosautov920: add CMU_M2M c=
lock
> DT nodes
>=20
> On 08/08/2025 16:21, Raghav Sharma wrote:
> > Add required dt node for CMU_M2M block, which provides clocks for M2M
> > IP
> >
> > Signed-off-by: Raghav Sharma <raghav.s=40samsung.com>
> > ---
> >  arch/arm64/boot/dts/exynos/exynosautov920.dtsi =7C 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > index 0fdf2062930a..086d6bbc18b8 100644
> > --- a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> > =40=40 -1454,6 +1454,19 =40=40 pinctrl_aud: pinctrl=401a460000 =7B
> >  			reg =3D <0x1a460000 0x10000>;
> >  		=7D;
> >
> > +		cmu_m2m: clock-controller=400x1a800000 =7B
>=20
>=20
> Are you sure this satisfies tests required by Samsung SoC maintainer prof=
ile?
>=20
Sorry for delay in reply, I was off for some time.=20
I understood the requirement here and thanks for your guidance on the other=
 thread.=20
I shall post the new version post fixing the compilation warnings.

> Best regards,
> Krzysztof


