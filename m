Return-Path: <linux-kernel+bounces-746801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3234B12B59
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19165545FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E2D23C512;
	Sat, 26 Jul 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cLCLH7lO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A721348
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545978; cv=none; b=Yt28sA2oaR4OFz6RKbx+MNC0uprrNWIYMRpxZfAIHquTkELvFnpI9MmkHVF4jGzRmdxMwjridhormGxz75Yt3st3qM4JTLsoZLTOuag+LwpF2ntBPImviu/xiusXWYks5aQmixHRLiXwZ9aIdUy1RDFvfh0DOuLXaoHD76rM8ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545978; c=relaxed/simple;
	bh=iYxjjRHm1mw+vTKhRXS38zIcOMlWzIY3qu4+t3rrbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdbC7JDQ8294Df/S3PYlPdXCRupz+JuKJtqf2xHTJPRnmrMGkxPxnoUod3Q/jRSt8/q5n2+UfLn2B5z+tEYBEuttv0Pjr4c0ME6dgOU9WglzRjeZy++mRD5JWW5ZUf1PT7GR++BY49ObEw1CQJIqv7Yuzbk5iYfUVkkoA2n6f7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cLCLH7lO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QDQ9E2027526
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7xqGhQFqvyN6IUSPs/7i5JwG
	WwgRKW2CZhmcIs4v2MY=; b=cLCLH7lOta8Ow3hwgQdU7GL5cN4S0X7sVodHkPGP
	UO/WvJVtshJrcDStbZyqRrkpdd4YdzdMFJM7rRJGl3MaiwonEmvVUTBTZpCUwaPy
	KKVHt/HSXnSbAFb4bKi2zG29BSx5ugkabX3Xos2+i608VkzTEkQBWGEQ3M8ZLHXr
	8US5xWaFriq6PQ/8t7fo/rBV/Sumu3acKvCWWykl3/ohtqJ9uE/CkcYVrSHDjJAN
	hczulA/NYtZSo3XfHgXpQGjp4AHyJNhpNUKPEmpgUMZBVA2KgInC6TZIPF8uNamI
	NvE9foD4VtmpcVhh631/Wl9Lkgv1o4OHFsGVrHMUvqq7og==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85rtvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:06:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fe182a48acso68902516d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753545975; x=1754150775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xqGhQFqvyN6IUSPs/7i5JwGWwgRKW2CZhmcIs4v2MY=;
        b=sMVZboj9EsvoROATJDz06067+KEW6zvfMK69O6CofDRvnnshUhxpiijkIz8bdv7aRM
         EQzx3SuCiPFH9aD+jugHbhrWc/vjzAlAFcGdrfmYcx3NOQEtQaA6cyVRSpAXUh6+jmiN
         11Q/KqLA4wVAXqFJgTVH3Uah4scaULeYKkjkHn1wH9RyG016rEVz4k9OxiJSVrbE4pX8
         lcgifjxC6XD6C0dndOtcYYpXC2t4vnx7QY1Vk9Mp7RYvL/9h73sKMzqyLQsCMTHtSGkQ
         FFmHMLJH8ilOB30DMbKMxQaC2GbEZudUEc0cXubPgqLP9RcWZoRO+SGUzRuFoq2UbeDC
         Ucnw==
X-Forwarded-Encrypted: i=1; AJvYcCV004Y/U2FNCIjbi4CMNMYd6EYVzbcljWYuwaQObS/mSZKrO7748bcr6l5VcNLr5ItsPRhGTL49O7GOW2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdaQbOivC5PdraedOlrwF3P1gA2miiDcGwAPiA7BRWWspvGck
	RyLGezPBa763czo2TajMKU5nTGjvihiyTRqhNHxpa/55Psa62sSgJEPLQ4GYypDB7jDFWL2uSHv
	kYwpfTYy38baA3nsCeyaXkJVyty6Encb8Bb+kleala3h0XYSFLtoMLlYzDWLH2p/7DHc=
X-Gm-Gg: ASbGncssDUay7o8q/7WzGhcqLkANXIKSa5fb/3Fj4R4eZbd64eBERSEwV2wTS7kjYMV
	50f79zJFRQUtGymH22VHlq/E3nY6QGjkR9IPGY2ogELDKUnzAl5fVJuo7umpIhe6j82HC+7k4en
	jZq49yj0NSn7B8QtU4nhtxvCSIWi5Cgaj7KbLIQUhp0fFzGMFGRpk3xnvJVYszeAwB0/fd51GwK
	6ojv9U/cFQTmnwRg4kNvjEXs8UrPC8QZTt/isyfmpfWPSiPBL+Jqi7uZ6zUxP8sSvIjEEVseIIN
	MCH1jsYGOCdgXK3yJHwc/gRgub4CQp1cqwB/zxNCo3n5yHE8bX7Q3PzzuvtpSZlT8rRZSMuV7gK
	lsBho77D0lDrf5tjL7bODNaQcZS5N2Kjpp9uJzYOUMWw3okEh4iEO
X-Received: by 2002:a05:6214:21e1:b0:704:7dfa:3fd with SMTP id 6a1803df08f44-7071fdc0d1fmr71998836d6.4.1753545974684;
        Sat, 26 Jul 2025 09:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj8127nMgWUnDZ+4c5uybplDoEBkbdUcB78Wr7iZNnU8dO2Qz1zMWTz3UJJVsx5Vcj3awxyQ==
X-Received: by 2002:a05:6214:21e1:b0:704:7dfa:3fd with SMTP id 6a1803df08f44-7071fdc0d1fmr71998466d6.4.1753545974266;
        Sat, 26 Jul 2025 09:06:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4235902sm5021511fa.63.2025.07.26.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:06:12 -0700 (PDT)
Date: Sat, 26 Jul 2025 19:06:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        venkata.valluru@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com
Subject: Re: [PATCH] drm/bridge: lt9611uxc: extend mode valid checks
Message-ID: <4vndrym4m7ql3lwbhqedukzcxb5qmtkyzaht66ps4fbjrvnwif@oqwnybnutx4h>
References: <20250725-lt9611uxc-modes-v1-1-6a13b181927d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725-lt9611uxc-modes-v1-1-6a13b181927d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEzOCBTYWx0ZWRfX63rdGdKr0/g4
 ORsw7d8XvZBHoBSc21qg2CB4E8OpDljz/VqPIbvtxF/zkaLLRjv956ERelez9Z+YYfcGfEZw+ob
 5rwaCBHb5YMK/g41fROWSGy+1aXPWYUzbQjzRc50aooYNIwezY+nmfQNN35i1gMfYrJ5rTcnGwV
 10+jk8gJHLAWwfPdM19pB87Aj5XaKQQEe0pwe29sSNFF4BeQHuAQmENVPB979VcrhbsxRcrXJfG
 iYwbwvMr0BQMMKdhGgeqxp1X4e93WHweS4xyHbZLy8Xl8r1981URFDTLrwYo9f4IE7WEHTZWok+
 RKrj+Z3CBKsCE34Yb+yP8PezJIWZEuBFwxjhTFixQ6aqaDCmfsObWH0SO3QZg906Yucmr9eQ1jD
 1iZvMJy/I0zyJvp9ZOa3CoP0Qo9kKPy6ju2jC0IlRcIZpN1ucg1jmsuX+/efu1CSiSa9yPOF
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6884fcf8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dA2U1Bku73MRG1Xy9NsA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: jxCudaSrofCg7lRQe_pN4ZLu44bnwlvq
X-Proofpoint-GUID: jxCudaSrofCg7lRQe_pN4ZLu44bnwlvq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=953 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507260138

On Fri, Jul 25, 2025 at 01:48:38PM +0530, Nilesh Laad wrote:
> Currently valid mode checks are only for hdisplay and vdisplay,
> add htotal and vtotal to filter only specific modes.

Why?

> 
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 36 +++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 38fb8776c0f4..cfe389b4c25c 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -89,7 +89,9 @@ static const struct regmap_config lt9611uxc_regmap_config = {
>  
>  struct lt9611uxc_mode {
>  	u16 hdisplay;
> +	u16 htotal;
>  	u16 vdisplay;
> +	u16 vtotal;
>  	u8 vrefresh;
>  };
>  
> @@ -98,22 +100,22 @@ struct lt9611uxc_mode {
>   * Enumerate them here to check whether the mode is supported.
>   */
>  static struct lt9611uxc_mode lt9611uxc_modes[] = {
> -	{ 1920, 1080, 60 },
> -	{ 1920, 1080, 30 },
> -	{ 1920, 1080, 25 },
> -	{ 1366, 768, 60 },
> -	{ 1360, 768, 60 },
> -	{ 1280, 1024, 60 },
> -	{ 1280, 800, 60 },
> -	{ 1280, 720, 60 },
> -	{ 1280, 720, 50 },
> -	{ 1280, 720, 30 },
> -	{ 1152, 864, 60 },
> -	{ 1024, 768, 60 },
> -	{ 800, 600, 60 },
> -	{ 720, 576, 50 },
> -	{ 720, 480, 60 },
> -	{ 640, 480, 60 },
> +	{ 1920, 2200, 1080, 1125, 60 },
> +	{ 1920, 2200, 1080, 1125, 30 },
> +	{ 1920, 2640, 1080, 1125, 25 },
> +	{ 1366, 1792, 768, 798, 60 },
> +	{ 1360, 1792, 768, 795, 60 },
> +	{ 1280, 1688, 1024, 1066, 60 },
> +	{ 1280, 1680, 800, 831, 60 },
> +	{ 1280, 1650, 720, 750, 60 },
> +	{ 1280, 1980, 720, 750, 50 },
> +	{ 1280, 3300, 720, 750, 30 },
> +	{ 1152, 1600, 864, 900, 60 },
> +	{ 1024, 1344, 768, 806, 60 },
> +	{ 800, 1056, 600, 628, 60 },
> +	{ 720, 864, 576, 625, 50 },
> +	{ 720, 858, 480, 525, 60 },
> +	{ 640, 800, 480, 525, 60 },
>  };
>  
>  static struct lt9611uxc *bridge_to_lt9611uxc(struct drm_bridge *bridge)
> @@ -237,7 +239,9 @@ static struct lt9611uxc_mode *lt9611uxc_find_mode(const struct drm_display_mode
>  
>  	for (i = 0; i < ARRAY_SIZE(lt9611uxc_modes); i++) {
>  		if (lt9611uxc_modes[i].hdisplay == mode->hdisplay &&
> +		    lt9611uxc_modes[i].htotal == mode->htotal &&
>  		    lt9611uxc_modes[i].vdisplay == mode->vdisplay &&
> +		    lt9611uxc_modes[i].vtotal == mode->vtotal &&
>  		    lt9611uxc_modes[i].vrefresh == drm_mode_vrefresh(mode)) {
>  			return &lt9611uxc_modes[i];
>  		}
> 
> ---
> base-commit: e48123c607a0db8b9ad02f83c8c3d39918dbda06
> change-id: 20250725-lt9611uxc-modes-d59bd4d49442
> 
> Best regards,
> --  
> Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> 

-- 
With best wishes
Dmitry

