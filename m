Return-Path: <linux-kernel+bounces-790100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC71BB39F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83852200E16
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3212BEFF6;
	Thu, 28 Aug 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EVO/iMIX"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6391CDFD5;
	Thu, 28 Aug 2025 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389336; cv=none; b=Cf9QkzkNa32Lfx/XPtwbhQ5ETqij3dznjoKQ2oBJEgs6dfKSvEKzi14g76Mdqv0p2bxjCau4ls+iN2qECSXNhvacpSwHdWK1kMgEfXpSTp8WfdW/YTsoFM10UjVRVJtjqChaxg++5+xWOAEO2VAirF87wVhiB7BV2bBhDFRdxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389336; c=relaxed/simple;
	bh=YAvdXxHh2rpt5FskBvNy1ApAU//S+nHuPPXKhEc1gJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MTn592TCUmg0ujbdTtkiO1Ta9L8snDMqOCVRLVrcPq2FK40zvvhy+ltW/j8N62jZS/wq4rx3/lNvXXUEtTklHjJOa4rqt151Q2Pv0vOqQDfU3skZ9PHjzI4UTmtC5sRbx4NspCcNvFbxIOP/cafLb5aSkPuJIWJRjFAjJ5h4r9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EVO/iMIX; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SDVqW3002446;
	Thu, 28 Aug 2025 15:55:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zf8R4cRAPWNdmfhyp97wma8/1c9gyToPc7q5r6rl40Y=; b=EVO/iMIX7GfAEX00
	p5TgoxK0mGcrLe0wu60+tA4ZQgYiKonSW4Wz4Nr59A+uqiR40ZJ7ZbJuE5HNDvEd
	Ut4HfHX7vz7SQYUeJc/gNTDjPOL1F8a7bNM9qiNzPpjcRRGevujK/3FtIiHJLP8Q
	kN0aHW3DNCcbJN9TGyQcbssqWEieiP8O58sZ1hz/Y9Iy81cdAo//8RIqFW09V0m1
	nwCM2vnSRfT2p5EkNOxzRLdD6xLd4n7uIScurMP+fqNbMNvOzs8qhTAkTowHU6P+
	kGOWddfmoe67rnkPqgvkoTvGVvGHbfsK6uDAMNbX20IQziu7OC1mD44UktFpTtly
	ebJAVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qq74b366-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 15:55:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E87B240045;
	Thu, 28 Aug 2025 15:53:56 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D247D74F6CE;
	Thu, 28 Aug 2025 15:52:59 +0200 (CEST)
Received: from [10.48.86.145] (10.48.86.145) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 28 Aug
 2025 15:52:58 +0200
Message-ID: <de0c6b86-a26a-f5eb-03e5-e2a4983cc326@foss.st.com>
Date: Thu, 28 Aug 2025 15:52:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 07/13] drm/stm: ltdc: support new hardware version for
 STM32MP25 SoC
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250822-drm-misc-next-v5-0-9c825e28f733@foss.st.com>
 <20250822-drm-misc-next-v5-7-9c825e28f733@foss.st.com>
From: Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20250822-drm-misc-next-v5-7-9c825e28f733@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01



On 8/22/25 16:34, Raphael Gallais-Pou wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> STM32MP25 SoC features a new version of the LTDC IP.  Add its compatible
> to the list of device to probe and implement its quirks.
> 
> This hardware supports a pad frequency of 150MHz and a peripheral bus
> clock.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/gpu/drm/stm/drv.c  | 12 +++++++++++-
>   drivers/gpu/drm/stm/ltdc.c | 38 +++++++++++++++++++++++++++++++++++---
>   drivers/gpu/drm/stm/ltdc.h |  5 +++++
>   3 files changed, 51 insertions(+), 4 deletions(-)

Hi Raphael,

Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>

Thank you
Philippe :-)

