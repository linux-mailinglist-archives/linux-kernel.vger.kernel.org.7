Return-Path: <linux-kernel+bounces-800840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B7B43CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95A158566E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCE60DCF;
	Thu,  4 Sep 2025 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BLMQ8FSb"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865C519006B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991744; cv=none; b=e+n5cGiTMxe97LKXYaf0QeW/22kZ6na2GzKDrAVs5DP6yQQfOIxAxahgxV9ZE7u2D/6pxspaZF57kNai2M3vIBkEHGYtKk6Rk10FApkx8jpZ9cATZlFi8cMFBD2XBGmlampq8LmRmdvf7YVef+HTarQ1OlbRyL6J0owpJ8x8/PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991744; c=relaxed/simple;
	bh=CoeAzI0fKvJPdWZVvZ5pCR7mtsucacBqXi849vxNA3Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=WRxLcwk8+rVHyBSqNH2woyM8JnV4anzb+/i89VXEYV6lSNmihyjRUA6C+ogkfLCCPHJbCrxXj2EIpDGwWbSaBvODksRxDXP+4gAawQbUm1FmCnDTyfj3FM45nWH/HTj9xvgpalKgqB+wxQQS7XYWz7tI0gU87Qi2jqk6g0d5SMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BLMQ8FSb; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250904131539epoutp0127c4a08ef57af161733b97ba404d5ae9~iFq2xKb291793917939epoutp01L
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:15:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250904131539epoutp0127c4a08ef57af161733b97ba404d5ae9~iFq2xKb291793917939epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756991739;
	bh=JTG7qchiHqeqMFWuTMOT+gd1Ea0jVcixNMJtGw+oY0A=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BLMQ8FSbfQ91l7vyXTL8w/v8fv8SAMr/Fsk8SGsXM5eXT1Qu0An22RULOcd6X6wtn
	 vj/o0YobavLKg6ak5iJY6tpJg7WtmGVKBjCUU/EhwxX1sM2at6e161ds3oJxC9s5V4
	 DThVud16RTY5uyQOVuDaAZdTO8+I/8Zg9f36c0Wg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250904131538epcas5p486a8856f505d224a648a60508c13ab7e~iFq15YM1e0207602076epcas5p4q;
	Thu,  4 Sep 2025 13:15:38 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cHg2d6Nydz6B9m4; Thu,  4 Sep
	2025 13:15:37 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250904131537epcas5p4118d6ba9cee9c0ed472b423c33f12023~iFq0MP_KJ0207602076epcas5p4o;
	Thu,  4 Sep 2025 13:15:37 +0000 (GMT)
Received: from INBRO000519 (unknown [107.122.1.150]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250904131535epsmtip2d279d32747258521bfc1fb18051f45d3~iFqybtU1v0228702287epsmtip2I;
	Thu,  4 Sep 2025 13:15:35 +0000 (GMT)
From: "Faraz Ata" <faraz.ata@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <andi.shyti@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<alim.akhtar@samsung.com>
Cc: <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <rosa.pila@samsung.com>,
	<pritam.sutar@samsung.com>, <dev.tailor@samsung.com>
In-Reply-To: <5643d3e6-a034-4e2a-babd-d82fb3d58e9d@kernel.org>
Subject: RE: [PATCH] dt-bindings: i2c: exynos5: add exynosautov920-hsi2c
 compatible
Date: Thu, 4 Sep 2025 18:45:08 +0530
Message-ID: <08cd01dc1d9e$00d416d0$027c4470$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMyl6jZ32DHOO134xOI05SqoiCOxQG1dU1GAuUAJa2xsTgNkA==
Content-Language: en-us
X-CMS-MailID: 20250904131537epcas5p4118d6ba9cee9c0ed472b423c33f12023
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904071941epcas5p1ffa00f3f1cb69f7a10d08c1e96174cf1
References: <CGME20250904071941epcas5p1ffa00f3f1cb69f7a10d08c1e96174cf1@epcas5p1.samsung.com>
	<20250904072844.358759-1-faraz.ata@samsung.com>
	<5643d3e6-a034-4e2a-babd-d82fb3d58e9d@kernel.org>

Hi Krzysztof,

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, September 4, 2025 1:35 PM
> To: Faraz Ata <faraz.ata@samsung.com>; andi.shyti@kernel.org;
> robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com
> Cc: linux-i2c@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org; rosa.pila@samsung.com;
> pritam.sutar@samsung.com; dev.tailor@samsung.com
> Subject: Re: [PATCH] dt-bindings: i2c: exynos5: add exynosautov920-hsi2c
> compatible
> 
> On 04/09/2025 09:28, Faraz Ata wrote:
> > Add "samsung,exynosautov920-hsi2c" dedicated compatible for HSI2C
> > found in ExynosAutov920 SoC.
> >
> > Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
> > ---
> 
> Where is any user of it? I looked on lore and found nothing.
> 
I will send dt patch shortly.

> Best regards,
> Krzysztof


