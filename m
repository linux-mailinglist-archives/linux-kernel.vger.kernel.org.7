Return-Path: <linux-kernel+bounces-813857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04AB54B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417D81C830D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E013302775;
	Fri, 12 Sep 2025 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvQWuptq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F6A302743
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677683; cv=none; b=tRRqfAB4dSHxSWvEUN1XRx1RUubcsG3lGCfGTQLLhsJWT7/H5R/j3VCKOlWxreVBsp3ifg1zttSzPG8zY27hRcjwrjIDORhmXN0NWvsqWRdpnUvZ7tP5mbnCRA+fXqNy1IjdJaN8JaLdjfMyFrxbMrfFZRP9Z+jhc2nsu1fCVTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677683; c=relaxed/simple;
	bh=dwEOCDuz8pHP9PSRzykN4SseAntCzLGGuNq+yxAvNyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSiu1MC/MUtlmY97fEl9RjO2REhrtsXDhJF+Dh36D1SDEDrxiopk8zt9tI9bbnPipQ+tW2Yb+grQnCWGfqRBtuqUYHrasDFu2o6tPmBuD3aQZwZZ+vlzHS2V1TKx7J3E+yOpmfKMlF++TjOUUBS0dX47M3UXVpFP7kdAqWoJot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvQWuptq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBCAbh019810
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GToV4QE6cCKItMQsLrIeSPhG
	neO7K5k2i2q1jGRtV+I=; b=UvQWuptqKdBsydqZVnOxBAy2NHjQMB4PcIhj2s2J
	hP5GPM73YQX3/bjE5eZENftiDyxAixdB0O0kORIFVnWbNcel7vpUsB7I44qnUNeZ
	NepM9rpBTdNPOBDUc4r60Nfc10odNSPIYR2Mr6V35b6He5QVTRMBKARIJHv/83TL
	jvGUlhIaz6uMhi0xU5ftuM6X+JgGzW45ctb55uf7DMhF5wESOseibbdKRq0/LgKo
	KpLeR3ZDWc9YxuJUof2mr5zf7WIn8eO6GdtTCy2Fh9qBvSChNarq2nDlI/5BzSwv
	tSNjHnIkxYu+YKkA+aYUhfj9eWVMHmWHPpYDUTZYEe9wQA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494jdx034f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:47:59 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-726a649957dso39616306d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677679; x=1758282479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GToV4QE6cCKItMQsLrIeSPhGneO7K5k2i2q1jGRtV+I=;
        b=cTzO7j8Fr0PAg1zJFNunKg5KFz7Dbz826fXQ1QwtTYws3F9eaNgcO3JYBDw3MEqcIQ
         l72X9P4JIUD1HLlCslb8qzJ5OPA/sW6IH5aZRIsyQyYx5/9NYQK7jeFBwMU8ElM2QqrA
         czMMe3JgC0Ex+Z9pGE08xN8O2q8yR7dGYnTrhTpIRZuJFWedy/KAczAJFfnA9bWZKeij
         OC4NRYmdIoHyMKQ2v88Ozz0V/8kNAI7OJzxglwY/hDxRVEy6nMDWrA+c5xzMcGiMEbui
         Zkr2KTTG99EUDhdWzPYa6nnn8V+8p5KS8POZDEoUAWWEI5DZxaRlG15jYd6O9rb3GqFL
         CVNw==
X-Forwarded-Encrypted: i=1; AJvYcCU6t9BEuDZ/2cikgxJtQ0suL1lxdtzPPnjFS/6SBoes4zSiIHboiVH1zEFIxdg+KWMmNx8T7g7BqrH1pbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP47vBMN6YzyBH+H7kiPoNP5sCdJ6m60Ps0FnonNQ67VmRGY8Q
	j1QxARRyjeicpNU1GgD06V3ZjrlO8X8mULdLGKJ7Ik94VnN8evFgk5gq0Sfo+koktRl+d9s7P2k
	gdzoAZtxyP8D3vG/P3M6wWJ0162zb9LWv2XkwlyazlkAVYi642rXyQS6y/LY1qBlqZX4=
X-Gm-Gg: ASbGncuRqfBzW8f8Gd6JlSFxHSkbtGLunmqOUZam/kNO8BNriamTbQqVsRU00ZTKJ4u
	4pl/QqiBuJqkPuio+Xh3KETd5mimKOswddeFXflvmw2IPtXTaB8CScfy5JQtPcOqJJ0844v8TL1
	0BFRnJR5tgtI9D+cdrAHI8aUSvvUuI738D+/MvWMzDSDghflrAeAyipY0JJk0Nz+Rf+nGTFuYjU
	hEzctQv9u3Xx/cNSMXBZfSZAClxhnozvAlOpW6d78Fok3z89u5zoJDoVZkhByNs0rsDViOiHbJ5
	USo0S8tAXfY7aIzDX7gIYAgrsWFzMeiOikxamGywLL8Tw38hzPYtdtpbHT41X5n2b2JJy0p6uuD
	DmwQaI2W4t4MjeJyiwkj19baAsx3isNfOQVzhk5TYpYTpKnwNGVq4
X-Received: by 2002:a05:6214:2428:b0:715:94ad:6add with SMTP id 6a1803df08f44-767c3772553mr34660746d6.47.1757677679102;
        Fri, 12 Sep 2025 04:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOipAh7umVQHV6wn1IWs32WNBot8nat+cTmZungdIIqqFVBnoEtURSnSYREkpzlbIAflY9Sg==
X-Received: by 2002:a05:6214:2428:b0:715:94ad:6add with SMTP id 6a1803df08f44-767c3772553mr34660316d6.47.1757677678632;
        Fri, 12 Sep 2025 04:47:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c014cb1sm8425911fa.62.2025.09.12.04.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:47:57 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:47:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] drm/msm/dp: Add DisplayPort support for SM6150
Message-ID: <budeqnh65mcmtc5rscbgvy2nz3woptxnht6sddzg7jhttsnx5f@bwf3kyvbrfaj>
References: <20250912-add-dp-controller-support-for-sm6150-v1-0-02b34b7b719d@oss.qualcomm.com>
 <20250912-add-dp-controller-support-for-sm6150-v1-2-02b34b7b719d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-add-dp-controller-support-for-sm6150-v1-2-02b34b7b719d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwNiBTYWx0ZWRfX0yUxkZlyd/ag
 1Hhuo4Mor0pb4Qwt3g9t7ZkrnsJs28qCtGoOusB95i+qK45sugO++c2F5lOBWe43TtVnGkfz8hO
 iS2p8G+0TPjdbvyfh/NL0qjgTASxWM76tN8UMI7SGluJAMantmTGOqbUjMWZTJu3Hz6Awab99+s
 of5Tk21bRFg5Oy30n86CMAp6Nv4SBNfI/1jibztkvw0AKmnmy5p3Xd0VuVLT/RgTRlY3O1pIVKF
 qJ318OieipiKJ9kh8EPU0foC7spi7ttjqKdhGs8dtlU7abwoDhB2abLh0KSy+2jZd0grvwZimoI
 r95LJXh7JrIe+SgLUXUdQwU/2yK51Nnu09iIOuOHQdZOd2Yz/xVia29a04uGU+pE12COGkgYch6
 dSsHKqWS
X-Proofpoint-GUID: NJsvOgv7mgOszMf6wZR4Kg5Wl9ppsTDV
X-Authority-Analysis: v=2.4 cv=JMM7s9Kb c=1 sm=1 tr=0 ts=68c4086f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=2HRO-YaP1JHyyBiP0YUA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: NJsvOgv7mgOszMf6wZR4Kg5Wl9ppsTDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509120106

On Fri, Sep 12, 2025 at 07:39:17PM +0800, Xiangxu Yin wrote:
> Add support for SM6150 DisplayPort controller, which shares base offset
> and configuration with SC7180. While SM6150 lacks some SC7180 features
> (e.g. HBR3, MST), current msm_dp_desc_sc7180 data is sufficient. Listing it

SM6150 supports MST as far as I can see.

> explicitly ensures future compatibility.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d87d47cc7ec3eb757ac192c411000bc50b824c59..ddb22b50490035779904d4cab20e2fee7e0f9657 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -196,6 +196,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
>  	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
>  	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
>  	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sdm845 },
> +	{ .compatible = "qcom,sm6150-dp", .data = &msm_dp_desc_sc7180 },
>  	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
>  	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
>  	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

