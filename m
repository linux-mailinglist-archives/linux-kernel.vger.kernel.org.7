Return-Path: <linux-kernel+bounces-790107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8AB39F87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C145639F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DF30F7EA;
	Thu, 28 Aug 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="f9t2+7cB"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8E30F817
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389577; cv=none; b=e1CPXQFISConYCz+vwCboZSUD2FNl6Up9h9Juo9q3Dj4gDp6U8gM9F/Frx+5/r5EbrhBTf6fBYT2AADX51RLZuOojehbpOnAa6bohfeaA+09dFAf2pr5Rbvrl7O8EC4UuKJmYEe/WFqDiUrr7DdbFbOjjJ3Nd4qN0oUVIeH5SXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389577; c=relaxed/simple;
	bh=HzJnptqnSj3+bY+YEVWA8RGXFuOW+6S1VvbjIcEaIxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jnS6Cr36iLiYSu/n3Cfwb633EJB5jrkPtZtE9sdW8ocz0PFozqXttByAqS3NTBQ3mK58fVRhwRwE/LwXNc3TxJ9l0WUp24uOSw5OhOFhD/edJcxQGk3BEG3y1DI05D6gYcVwXoFOsE3McEpIE8/MvuidxkOJzbOXk+uyqaxhOio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=f9t2+7cB; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCB6Wo027035;
	Thu, 28 Aug 2025 15:59:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	AsNuu9CqZFnBU/rKLRncHHCAvG7dZ93NWIpdKa0+iIs=; b=f9t2+7cB81Pe7zi8
	nvF1FcT5DHLMeaZpL/4wM3sTZLKtbUKAuWN1dejpw1Pk5U33vU41fcLhLPgFtO20
	5YZYokRD3gCNaX2Pi6LPA2q5XgA4KMBmKWHt5hrhn/PHYxCJq5YIU/mGPPrgPngC
	sNlAUojHQ85OKnpk852IxhITDw3PTJjW9JMzoleCBGd0OjwcCQdhdUPNiUBZS7Hv
	CI1C94xfmpktIBxBKqGDTgEE+8hjfD4lUhk//iUqkWktojgZj9M9xGZlyiNP07MR
	6CGIaJl63GwaeC1ksjA/95N8QuA9lZ8LjO0CBuA6jjsdrBg6aI1vaEB7wplNy4JG
	G52t5g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48qq74b3kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 15:59:20 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DD9264004C;
	Thu, 28 Aug 2025 15:58:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8850475040E;
	Thu, 28 Aug 2025 15:57:49 +0200 (CEST)
Received: from [10.48.86.145] (10.48.86.145) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 28 Aug
 2025 15:57:48 +0200
Message-ID: <b55efa1f-d2a6-3e02-b7d7-7985e0610679@foss.st.com>
Date: Thu, 28 Aug 2025 15:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/stm: ltdc: unify log system
Content-Language: en-US
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250825132951.547899-1-raphael.gallais-pou@foss.st.com>
From: Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20250825132951.547899-1-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01



On 8/25/25 15:29, Raphael Gallais-Pou wrote:
> DRM_ERROR and similar are deprecated.  Use drm_dev based logging.
> 
> Link: https://lore.kernel.org/r/20250821130356.883553-1-raphael.gallais-pou@foss.st.com
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
> Changes in v2:
> - Fix kernel test robot's warnings
> https://lore.kernel.org/all/202508250637.nLxtkS26-lkp@intel.com/
> - Rebased onto latest drm-misc-next
> - Remove Yannick's acked-by since the patch changed
> ---
>   drivers/gpu/drm/stm/ltdc.c | 139 +++++++++++++++++++------------------
>   1 file changed, 70 insertions(+), 69 deletions(-)

Hi Raphael,

Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>

Thanks
Philippe :-)

