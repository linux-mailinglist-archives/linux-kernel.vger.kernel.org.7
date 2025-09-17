Return-Path: <linux-kernel+bounces-820618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434DCB7CE70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F9D3AAF03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BF32BC14;
	Wed, 17 Sep 2025 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UPwF2a5S"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7833A32BBED
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111204; cv=none; b=iBP/DhWOmk7mb4H9r2tucOvY2TFiuYD4Li3JUZfv7QM7fXzMlyjuaIpqSvDlkzSopCsjhVo1kQBj3/cdukMfMT7y1V1oLig0Dz3tx8vcq2Llbk/xkKaxd9CcRti9neqP3BKpkNnjIwAXmc2aIDKUfSdGixSa1pBhnGNqjw/WdKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111204; c=relaxed/simple;
	bh=QVQvfdGN+VbeGJ3ydv2cpGn+023kF+CLj4SqEQdHinY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=X/FjKu31JWMyucGVrclzMztSv9QBsw8nx27FK7ycc8uZumSFFhIXGfz8AfWBLwgirdl9NkdlaX9g3AZKm8+NPLf9YKDhQJE2166efBprcnDKsk1mGgUoOpo/NOEak3qzJGEEpTIS2RK9FeSrRpX1+HMyzxzcQGuFIFonhCMo+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UPwF2a5S; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250917121320epoutp043246c5171c9e587c6d5e14a90f2826e7~mENJ6IrYi2648526485epoutp04U
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:13:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250917121320epoutp043246c5171c9e587c6d5e14a90f2826e7~mENJ6IrYi2648526485epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758111200;
	bh=qSnds/EOg7L746Y8nkQXIh4LVhTtDw7d3MtsrX3fuKQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=UPwF2a5S4GqksDYK+QuouRSyFSbpyDFKESV+RgbpH9IEMV/QibYLcyntjWKl27MmU
	 S3MRj5CLDdrpy7t5JmqCb9DYPikSmLCFkc15Aa88ZrL0mKRpNQgFUkFqx7cc1xatXB
	 mVq+uSMmiSZFfiMVuHeqVA1Wxa1FnG68JeQUsaFA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250917121319epcas5p25c498ccd9ea2a74ee9706993b994168e~mENI-E74b0556205562epcas5p2A;
	Wed, 17 Sep 2025 12:13:19 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cRd2k5S3Rz3hhT3; Wed, 17 Sep
	2025 12:13:18 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250917121317epcas5p487667022e0a7bbdc5c73914faad97d52~mENHFzn9V0908209082epcas5p4L;
	Wed, 17 Sep 2025 12:13:17 +0000 (GMT)
Received: from FDSFTE196 (unknown [107.116.189.214]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250917121313epsmtip119c1f773089a96736001c687a7a229c4~mENC35rJG2521825218epsmtip1H;
	Wed, 17 Sep 2025 12:13:12 +0000 (GMT)
From: "Inbaraj E" <inbaraj.e@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <rmfrfs@gmail.com>, <laurent.pinchart@ideasonboard.com>,
	<martink@posteo.de>, <kernel@puri.sm>, <mchehab@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>, <pankaj.dubey@samsung.com>,
	<ravi.patel@samsung.com>, <shradha.t@samsung.com>
In-Reply-To: <20250901-rousing-orange-crab-c05fdf@kuoka>
Subject: RE: [PATCH v3 2/7] dt-bindings: media: fsd: Add CSIS video capture
 interface
Date: Wed, 17 Sep 2025 17:43:10 +0530
Message-ID: <025001dc27cc$72be7b90$583b72b0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIBSJFzUA8Lz5NCh/Whmc1GwVh24gLl1U6/AmrqmSQCCHSfRbQSPXgQ
Content-Language: en-in
X-CMS-MailID: 20250917121317epcas5p487667022e0a7bbdc5c73914faad97d52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250828085930epcas5p1719c7db08074bf1540dc85b71736a6c5
References: <20250828085911.81266-1-inbaraj.e@samsung.com>
	<CGME20250828085930epcas5p1719c7db08074bf1540dc85b71736a6c5@epcas5p1.samsung.com>
	<20250828085911.81266-3-inbaraj.e@samsung.com>
	<20250901-rousing-orange-crab-c05fdf@kuoka>

Hi Krzysztof,

Thanks for the review.

> > +title: Tesla FSD SoC MIPI CSI-2 video capture interface(Bridge device)=
.
>=20
> Drop final full stop. Also missing space before (

Will take care in next patchset.

>=20
>=20
> > +
> > +maintainers:
> > +  - Inbaraj E <inbaraj.e=40samsung.com>
> > +
> > +description:
> > +  The Tesla FSD CSIS has an internal video capture interface to
> > +capture
> > +
> > +examples:
> > +  - =7C
> > +    =23include <dt-bindings/clock/fsd-clk.h>
> > +    =23include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    csis0: csis=4012641000 =7B
>=20
> Incorrect unit address.

Thanks for pointing out.
Unit address is correct. Address in reg is wrong here I'll fix in next patc=
hset.

>=20
> > +        compatible =3D =22tesla,fsd-csis-media=22;
> > +        reg =3D <0x12661000 0x44c>;
>=20
>=20

Regards,
Inbaraj E



