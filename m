Return-Path: <linux-kernel+bounces-615347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7367A97BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6961189DE03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 00:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CE225744A;
	Wed, 23 Apr 2025 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qXVxu9fj"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3651257423
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369969; cv=none; b=t4khOF2DlDbBQB6jqHHWTGz8rV2ZcvLnDEvBLDKN7vJ/4i0n5IiTHCNJ5JuzJr2h7OR3QzDRT6JM4iF2lgwf6aMfwdjiM9GOyrX/O4ODwjcANmRsQOvBDkQszZnREqydV3Bsa3UD+ib4bP3Wom1RaRVeKqqWg/2q+4VKtmtQJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369969; c=relaxed/simple;
	bh=V6ztsUA+eAokShdcpCUOewiM9eddy9endAMo3wt7Qqo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=L8VKF2NtVe1hvVSpb0mvfL4QERhI/NbQVOOKGwjtCwNe8FIN1a3JYiMOxuwrbErDVYrxdQV81xJI8vaRkGYrJgkKbkGgfQD/YF5baRjmeCsW7fxQZbIoK8x9ItrnkwAS5ZVuKS99G/aq5p2h/wjjWoY/v6YrcfUlFjK9b3Csr5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qXVxu9fj; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250423005925epoutp02fe011289ab13e272d796eac52a08aab7~4zLyKU3Fr1523115231epoutp02E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:59:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250423005925epoutp02fe011289ab13e272d796eac52a08aab7~4zLyKU3Fr1523115231epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1745369965;
	bh=V6ztsUA+eAokShdcpCUOewiM9eddy9endAMo3wt7Qqo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=qXVxu9fjxOJfg6GrOgKCGfC1LVs2wpesQZ746HTo1+xllJAGwu9k+Uv4yNz/3jBRy
	 wStYpMVkETR3zRoJ+2qGcBpmFpzCm3IYQ/5KRpfRl1PZV+mY5IlBkeHmpSgQajR41q
	 Kpmm4oKzyanOulDfPNEuyHxh37ScBxe5SoqvC/U4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20250423005925epcas2p1007d645e84480bc60750f8824e524dbf~4zLxk0CVr1610216102epcas2p14;
	Wed, 23 Apr 2025 00:59:25 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.70]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4Zj13056mhz6B9m6; Wed, 23 Apr
	2025 00:59:24 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20250423005923epcas2p4edb8b1de0f83043a1c78ec638a30fb9d~4zLwcXtXG0929009290epcas2p4p;
	Wed, 23 Apr 2025 00:59:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250423005923epsmtrp2b9d4b73722e715865a8dd7c432bef4e4~4zLwaxtL60362803628epsmtrp2x;
	Wed, 23 Apr 2025 00:59:23 +0000 (GMT)
X-AuditID: b6c32a2a-d63ff70000002265-d7-68083b6b0a9d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.1D.08805.B6B38086; Wed, 23 Apr 2025 09:59:23 +0900 (KST)
Received: from KORCO115296 (unknown [12.36.150.221]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250423005923epsmtip1237a991dc36e4fd2bd9798c4d4302602~4zLwK_7F80987709877epsmtip1K;
	Wed, 23 Apr 2025 00:59:23 +0000 (GMT)
From: =?UTF-8?B?7IaQ7Iug?= <shin.son@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, "'Sylwester Nawrocki'"
	<s.nawrocki@samsung.com>, "'Chanwoo Choi'" <cw00.choi@samsung.com>, "'Alim
 Akhtar'" <alim.akhtar@samsung.com>, "'Michael Turquette'"
	<mturquette@baylibre.com>, "'Stephen Boyd'" <sboyd@kernel.org>, "'Rob
 Herring'" <robh@kernel.org>, "'Conor Dooley'" <conor+dt@kernel.org>,
	"'Sunyeal Hong'" <sunyeal.hong@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <6de6030a-af26-4fda-8d49-fa8ac65a672f@kernel.org>
Subject: RE: [PATCH 2/3] clk: samsung: exynosautov920: add cpucl0 clock
 support
Date: Wed, 23 Apr 2025 09:59:23 +0900
Message-ID: <003701dbb3ea$f42360c0$dc6a2240$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGPEGrsijGqefHqKZlvX6MGGm+h1AGZ4wO8AVHQIBQCbFZfi7Qe8T3w
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSnG62NUeGwY4NhhYP5m1js1iz9xyT
	xfUvz1kt5h85x2px/vwGdotNj6+xWnzsucdqcXnXHDaLGef3MVlcPOVq8X/PDnaLw2/aWS3+
	XdvIYtG0bD2TA5/H+xut7B6bVnWyeWxeUu/Rt2UVo8fnTXIBrFFcNimpOZllqUX6dglcGQve
	/WYpuMhVcfX7beYGxg8cXYycHBICJhKTDvxh6WLk4hAS2M0oMfvaJmaIhITE4RkTGCFsYYn7
	LUdYIYqeM0ps7ZzHApJgEzCUWPVjOxNIQkRgIrPEpQ8XwEYxC2xilDi3+yYbSJWQwHtGiSsT
	qkBsTgE7iUP3f7OD2MIC/hKtdxeArWMRUJXYtPcT0AoODl4BS4klawVBwrwCghInZz4BW8Ys
	oC3R+7CVEcZetvA11KUKErs/HWUFsUUE3CTmzOljh6gRkZjd2cY8gVF4FpJRs5CMmoVk1Cwk
	LQsYWVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgTHpJbWDsY9qz7oHWJk4mA8xCjB
	wawkwvvLjT1DiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6p
	BiZrrmkxS2b8Sn3/wa+7js8g7/bZNXMLXPamHVptZsi3VjDyhGFX5EIvA+vJ9c8L35uVS38u
	V3G79qbh8kbXzpzt3ApZu/7s+K2kV3Dpg8DlEyF3TorFWBxbW1in/VBk2rnH9/4opfyZflpg
	d4nU0Ysfwv2VjWXN7MWsgvucZq/8VPTgWG+vh/uKG4ovl/k/8Z/HtmpWr/T3X87TFb5nqu1K
	yn4bc3q/hqm9fsa2ssn69w/KXNK98k484c+92193nNgdOfPQ3k9VDArX1eau9nZLm8Gf2Bhc
	v3O/bcTkpU1u14v5jyRsc162/a26Q3Ufz5mQk3qMsqw+DfP7ju46IvTs9ipRDuXDD3I+lU88
	6dCixFKckWioxVxUnAgAStCikjgDAAA=
X-CMS-MailID: 20250423005923epcas2p4edb8b1de0f83043a1c78ec638a30fb9d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250418061515epcas2p138fa2f5edacbfba8f73b40182fb8d83f
References: <20250418061500.1629200-1-shin.son@samsung.com>
	<CGME20250418061515epcas2p138fa2f5edacbfba8f73b40182fb8d83f@epcas2p1.samsung.com>
	<20250418061500.1629200-3-shin.son@samsung.com>
	<6de6030a-af26-4fda-8d49-fa8ac65a672f@kernel.org>

Hello Krzysztof Kozlowski,

> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzk=40kernel.org=5D
> Sent: Tuesday, April 22, 2025 4:59 PM
> To: Shin Son <shin.son=40samsung.com>; Sylwester Nawrocki
> <s.nawrocki=40samsung.com>; Chanwoo Choi <cw00.choi=40samsung.com>; Alim
> Akhtar <alim.akhtar=40samsung.com>; Michael Turquette
> <mturquette=40baylibre.com>; Stephen Boyd <sboyd=40kernel.org>; Rob Herri=
ng
> <robh=40kernel.org>; Conor Dooley <conor+dt=40kernel.org>; Sunyeal Hong
> <sunyeal.hong=40samsung.com>
> Cc: linux-samsung-soc=40vger.kernel.org; linux-clk=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> kernel=40vger.kernel.org
> Subject: Re: =5BPATCH 2/3=5D clk: samsung: exynosautov920: add cpucl0 clo=
ck
> support
>=20
> On 18/04/2025 08:14, Shin Son wrote:
> > Register compatible and cmu_info data to support clock CMU_CPUCL0,
> > this provides clock for CPUCL0_SWTICH/DBG/CLUSTER.
> >
>=20
> Explain why this is needed as clk of declare, instead of platform driver.
>=20
>=20
>=20
> Best regards,
> Krzysztof

CPUCL0 refers CPU Cluster 0.
Since the CPU clocks need to be available as early as possible, I used CLK_=
OF_DECLARE instead of a platform driver.

I'll update the commit message and add a comment in the code to clarify thi=
s.

Best regards,
Shin Son


