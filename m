Return-Path: <linux-kernel+bounces-781858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4FB317C7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492291C257CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04D2E1F13;
	Fri, 22 Aug 2025 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="eU7Rkse6"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B51E51D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865681; cv=none; b=u+rsPHwdUxngicRUC5/PrR3katgo60mrgGt6TQ66ghCpru91PKIlB767jbHzPA+QUY4JgYkYjz+g8IWHUhduaCbRoXZtB7sdVvvIcnu2XMoleNsGSwLUTsSDLR1kduH1iPI9LXL5HQz7lY5tbC4/r2oa9eaaaUGG3NCctfH+awQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865681; c=relaxed/simple;
	bh=n5xgv3Quc+USBLbZPbbXiLHJsfAIvUmEYJ8piqWwIfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VN8rUgXl0k/iw1713UFQ25cfREgquOmZjUwwy0cJb2f2tPiX9byGuQxWRdKl4SJAyncHMgd3UFXXT8UV8tmkLEE4Ob/WujjqIIZExXK8RHAmwSxgTQfDZhRqeQg+IfYdVzVaioOwv+Z8mPxI8yP98cZoWyt6+orwihhJwBUERrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=eU7Rkse6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MC4SMI030214;
	Fri, 22 Aug 2025 14:27:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	T6mgh6btBywzlp/e+SiWkYAG5i8x7Ry7OTIJ2BWMvmI=; b=eU7Rkse6g+EGMn01
	HitdPnhSEHnufAZ0JgTvzgW3Q/AOoAGt0d8wfy/t2cVf4Uzi1VHgxgFB1FG9Ofkh
	mcMd+97Jbj23wfYuU3kWa6kYvetNs0GCmMXsGFLS2Fo8M8f4AAkxXK2ZOGTApndd
	0V/9DwWrgCsoA7ukdSLCipC+T67sIzhZb2sxnIkVGji/SJdaaf/y1viFsk4wWmrf
	+guu1XtiLFvvKsiUIOeDG3t39bwpHfwNmo8HhPSlQhsfxYHhoNeSmxlerNEb3qeU
	P6LnZwkc39bpjgzn2awbLDDAFnxK8MuscdQEfcU2Ft7oNqqSqyDWavmoNq+RNFIL
	a7f0cA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n81wtnr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:27:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E456240044;
	Fri, 22 Aug 2025 14:26:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A698F71CE44;
	Fri, 22 Aug 2025 14:25:40 +0200 (CEST)
Received: from [10.48.87.178] (10.48.87.178) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 14:25:40 +0200
Message-ID: <2f0186da-89ad-4c56-b8e9-928226b95f10@foss.st.com>
Date: Fri, 22 Aug 2025 14:25:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/stm: ltdc: unify log system
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
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
References: <20250821130356.883553-1-raphael.gallais-pou@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250821130356.883553-1-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>


Le 21/08/2025 à 15:03, Raphael Gallais-Pou a écrit :
> -	DRM_DEBUG_DRIVER("\n");
> +	drm_dbg_driver(ddev, "\n");

