Return-Path: <linux-kernel+bounces-734588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DD6B08378
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 413277A68EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8491E98E3;
	Thu, 17 Jul 2025 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rYxxtGvP"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7C191F6A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752723287; cv=none; b=Ws1Bbmeamvr7IVy0nLaFMyk+K0n40VvkwgjXWylTmETQLrjg2jTJAhwS0qLSLSEAFxQTySdn83eXhtYBQZMmqvIC5aDzCmNO0mXHUTkMzRwOA7VQ3g9qo0OyR0gAQNj8/oBIjw8wFVm0t+7GviD4uzI3bVWA6b/W5ceZWBcT+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752723287; c=relaxed/simple;
	bh=xKe2b2AWM0uJcuKoyka5AkqwvwRKwneLKMPTasEVc8Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=tnVPbnduqPO33iRU0hh3w9UTWohEZMKmKclacdv2g9A9Qks9qJsH3dlrV99xXCfntGfn5bCUzYcWFiqx134GfCdXTvRbY7k5UmZE3/snV2f2RfOtYFvDTubSz2aOknjZeNr9cerWPdG1D7UC0RdaqoWtwSKjC/y6nGf7YuEicRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rYxxtGvP; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250717033438epoutp02a4a23a282dea126d68f50acb2bcd823f~S7IkcNYpZ1315413154epoutp02l
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:34:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250717033438epoutp02a4a23a282dea126d68f50acb2bcd823f~S7IkcNYpZ1315413154epoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752723278;
	bh=sDmYy/hmdzV5QjF0o/JqsoId7qEw6SvTssQ6hQyMMiE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rYxxtGvPZEl0CQMKM/SXFMGSFKg0mOi858UKxI3SAp4mS24zpEJdTsgi8svZphPz/
	 oJnirVBIcO20Tcme6Ljs3z7XRb2NDQzosSIHORYSNI9zAIa3qi+yvzbuamhYRV3mnp
	 JLtHakpu6L8wfRUNng6QK7mTSc6yJCmJs32ONmGU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250717033437epcas5p1ea0faed5971a620ae04c5d69cb017870~S7IjxDTts2317323173epcas5p1P;
	Thu, 17 Jul 2025 03:34:37 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bjJSr6Mb1z6B9m7; Thu, 17 Jul
	2025 03:34:36 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250717033436epcas5p29b5631667254501490cc3587918555b0~S7IiVaBtw0270202702epcas5p2P;
	Thu, 17 Jul 2025 03:34:36 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250717033435epsmtip221398bdf18ea9bf92c5bdcaec1cf9028~S7IhER6UI0245302453epsmtip26;
	Thu, 17 Jul 2025 03:34:34 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Sowon Na'" <sowon.na@samsung.com>, <robh@kernel.org>,
	<krzk@kernel.org>, <conor+dt@kernel.org>, <vkoul@kernel.org>,
	<kishon@kernel.org>
Cc: <krzk+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20250702013316.2837427-3-sowon.na@samsung.com>
Subject: RE: [PATCH 2/5] dt-bindings: ufs: exynos: add ExynosAutov920
 compatible string
Date: Thu, 17 Jul 2025 09:04:33 +0530
Message-ID: <1e9101dbf6cb$b7e2f520$27a8df60$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQKcRDJWwAug8EBOlN5S0ESXxoAVsAI4Dt0PAYv0MEyylu5yAA==
X-CMS-MailID: 20250717033436epcas5p29b5631667254501490cc3587918555b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250702013332epcas2p4fe456c285c96c143d96f98b31d9b5255
References: <20250702013316.2837427-1-sowon.na@samsung.com>
	<CGME20250702013332epcas2p4fe456c285c96c143d96f98b31d9b5255@epcas2p4.samsung.com>
	<20250702013316.2837427-3-sowon.na@samsung.com>



> -----Original Message-----
> From: Sowon Na <sowon.na@samsung.com>
> Sent: Wednesday, July 2, 2025 7:03 AM
> To: robh@kernel.org; krzk@kernel.org; conor+dt@kernel.org;
> vkoul@kernel.org; alim.akhtar@samsung.com; kishon@kernel.org
> Cc: krzk+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-samsung-soc@vger.kernel.org;
> sowon.na@samsung.com
> Subject: [PATCH 2/5] dt-bindings: ufs: exynos: add ExynosAutov920
> compatible string
> 
> Add samsung,exynosautov920-ufs compatible for ExynosAutov920 SoC.
> 
> Signed-off-by: Sowon Na <sowon.na@samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>



