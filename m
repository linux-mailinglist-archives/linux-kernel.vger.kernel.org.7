Return-Path: <linux-kernel+bounces-751357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D84B16837
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454BD3A65BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E70821B9E5;
	Wed, 30 Jul 2025 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GbSxMTOC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C744A01
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910322; cv=none; b=WqeR7RfGvtAFWTEwsBomfowBvf5NfVGm+XqDaUksfVUi11nWCqH45h4cd/MfcxJ2VBQo5TI2r/Lhd57MJvCvENZF6AY3Jk79204kimkQnoCawn2dVBJMEn2vyoPfoqoUaSK95NjBr+9E+Ef/8zBaZD5OxZid46RyugY/s8SlG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910322; c=relaxed/simple;
	bh=D2Nq/p4SX3CI5eELVvjCpxgAGY8QseMTG+xXtOqB39s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK7tmpvlTEzdcGYK80deuVXZmM0Jm9dzpikABXsCfPZGD/jJfZgWsqm6f22/tZLTj/dBiTvDbKuW+BkmYTQZqDRermUZ3RlRUx0yyCbE5Ew6rAws20PjVUUDf+yNvc5a+DdMK8mtWDrMMR2VhSwaIGtSdqBgrvBFy97MPDujXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GbSxMTOC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbBTm012971
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iTFx0yIQGaBEsSA2eGgyHdUl
	KsnDAMC5gY3BAJpA+RQ=; b=GbSxMTOCwrl1hTY9C7BjObrlN+PFJ07P/PSFUhJc
	0xhbEJubm1TUJBz2Gqn+JKIxuAe6GbxQUsHaEoruqO0ckfSnd/jqCypnTD0K4c+I
	ZWHqdIzE/DmXmWZ+FuxGLHuQ2TCz0PVJJklZ1vSxFIbfHkvZHXXPgoVNVTiGLgg0
	VAZShFL1feE6AJLfLGKR3IAfAM19EsLD/YfxLKu1FyV13px/rU0ocFVLeQ3VThRo
	1M4ZSrGTUF3ww4gliP33Jgo3F9UYpKgAZoZX8nbk9BVGvrRYzlDS596BVYzhIZ5j
	PA2n33FIuRSUd0Vzrh0gmcOHbnVZmydSAf2anQQYKXU3ug==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm2n8nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:18:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70734e02839so4503246d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910319; x=1754515119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTFx0yIQGaBEsSA2eGgyHdUlKsnDAMC5gY3BAJpA+RQ=;
        b=GycL4VBf2OWRKhfxtOAxR1JvozqcifvgDlTE9JET1MAkLboHh0yZmrO8gBZXGwltje
         +is9Itf8LSTnGAP4u6yimsUeSefE2x+m8XGEReU0I4mGnJWQIFbMamo//YLriM32EBGa
         3U4OW0i32M9kr4ALHhoMKt2Nnp77pB2HAyD03+F37upmj7q/RLBvGnnNDC+vOsf+UMra
         h7UkGcUTfVHHux3tOrrcEwt7J4+PyYFPxTp7qVTwAGTsz7jM0WN6tBWFz3tv7NkLtl0j
         G3vGGZ6qDFlOtN3i8aQ2Wat1abebrXo7t26U92bdDqTmEExUpZNIT7IUi0xYvYr2m9Dd
         x5ew==
X-Forwarded-Encrypted: i=1; AJvYcCX9k4KWYzXWsBuds9/VLIKy7PQPwf29uEtSuUUvIMZOdxp7j1uKKCuZG9b19EYr0gEZSDKQVnE2BX6WgdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoih1y08zmrPCJOKAcwRSM42Rtz3AhPCP51+I5fbKOZAL/KR7b
	8KwcjTqwZm3tL6ALHNLqgO8AHIILSVpxCxjctES363mNUKNDHS6MAhrRDbY7p1QeSfwsTRg9C97
	+7JfES1dgEUaHHXM0tGvpBhnDFxASTQau6xTV/A+dbxBiGTqYzxAnHpXMmyfZX49V5Uc=
X-Gm-Gg: ASbGnctZCBh+V4tBWt/CT6bEzHJjRKh2c4j0QabdF6t+CGWa6uRVVhrXZplxWsmmn1K
	HL60mpoSlqPjofOmAKhp05GEIcgfTTsbKogjvMBpFEBNmzdNdNCrM8xRBSeaYVuDFn+zQFk0pyn
	U36HdMUbCNzcRTBcAEF4mQ3ORhVjCkzxEfMWcV7PPPJSO73VAdwN5LY1bwODXCEP8/KAyybeZ2t
	JWnW43FZ2SNyDxQ0iocCXR/wPYRU6DSKwaYwb8OLa6d7J54Ij6aMFi+41dOX7EtZjP0KePRjvFX
	43MoAmYbsuI++va7gfS+rLVO/uhrlLEVtS5vIn8y6fcX77mRxfImE9gEZowW9cCtntoqBhkfomA
	/HwEj0QU5mB/rk14d4hnXyIb5eJakUvfisED/00f/iIdIVHE53mmf
X-Received: by 2002:ad4:5763:0:b0:707:5df5:c719 with SMTP id 6a1803df08f44-70767478e57mr83213476d6.17.1753910319136;
        Wed, 30 Jul 2025 14:18:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm3RE9Af2E65UYXRV0BUAaT+4TSql/ZAXgKWlWoCrKvSZ6wgC6yly65rnstuTjmAzh0HHFHQ==
X-Received: by 2002:ad4:5763:0:b0:707:5df5:c719 with SMTP id 6a1803df08f44-70767478e57mr83213176d6.17.1753910318773;
        Wed, 30 Jul 2025 14:18:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b73f14178sm973838e87.80.2025.07.30.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 14:18:37 -0700 (PDT)
Date: Thu, 31 Jul 2025 00:18:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Heidelberg <david@ixit.cz>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2 RESEND] drm: bridge: Add support for Solomon
 SSD2825 RGB/DSI bridge
Message-ID: <p4svegtwyrjdcmq75d5qh55f3g4632sgwzontrp4adcvrs32m4@v3x3fvhncshd>
References: <20250730055424.6718-1-clamor95@gmail.com>
 <20250730055424.6718-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730055424.6718-3-clamor95@gmail.com>
X-Proofpoint-GUID: Tp8kuUmbrDtGHwvkks8w5bI3jMGyVL3S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1NCBTYWx0ZWRfX4tJ2Cy0YO9E5
 7cICxALv8BikIFdi83kN03s9EAdoC87Q9AcZ1aXt5expnZAG2y9T1snYMrQwX8pO8cCMkF3Vxkp
 3xp6i4QNvFkLcss4NRRIJhTn+mHSu1uwImu8HODNdRp4KfcEolRDb11U6/AJPMXsbKxEzKX4lqD
 VkBOSmcyKfpQqmqmtQC5UEQhxzMb4/7ryFUHJOirn0P97/HfLjPA/38F/spumab36FrahJT815v
 aAQRNfD4QLMsDC9EuIdqfMRg/IjCPgPmNKufCq1Pg8pLLFmRlxo4eS9L7ywdrXox5anEbGPfI4w
 oUME6CltQO/AALXIldJhM8y7oINx6IAfD0637R3YB8f6cus+B2SUmJEs8hUQaji8OLoK3mSV3tI
 n1i/18y0ykjrpQZjNDZPdODZlNnZ3HAAO/uN/3IQlgFy1D3cyjpnEvhDAys+dTUzOc7vZZTZ
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=688a8c30 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=73frPc2hRq-d4gq3JOcA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: Tp8kuUmbrDtGHwvkks8w5bI3jMGyVL3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=755 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300154

On Wed, Jul 30, 2025 at 08:54:24AM +0300, Svyatoslav Ryhel wrote:
> SSD2825 is a cost-effective MIPI Bridge Chip solution targeting mainly
> smartphones. It can convert 24bit RGB interface into 4-lane MIPI-DSI
> interface to drive display modules of up to 800 x 1366, while supporting
> AMOLED, a-si LCD or LTPS panel technologies for smartphone applications.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig   |  13 +
>  drivers/gpu/drm/bridge/Makefile  |   1 +
>  drivers/gpu/drm/bridge/ssd2825.c | 775 +++++++++++++++++++++++++++++++
>  3 files changed, 789 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ssd2825.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

