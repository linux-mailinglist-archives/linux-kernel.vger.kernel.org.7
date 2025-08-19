Return-Path: <linux-kernel+bounces-775104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB15B2BB44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E60E3AD6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52323112AF;
	Tue, 19 Aug 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AxHxocTu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0FB2F9C3E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590379; cv=none; b=hCY/Xwtz7Xx458O7FYu67UbM6T8ERspZ+oq681f1nuQtllMJG+w7s7INHK/eclPaDImRhRw98br3Zjw2lIIDsvg71ywWLapXxAZFkra4tveFcgk4Wy6wq7iT76VTaVuzqbf8a5ys3n3Z+YxazTDZ12b2fmc5gpmfpcWmSNNBm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590379; c=relaxed/simple;
	bh=TmIqGmZD3H9vgCSTYIgWGkAwUVmyYjcneDo8YIQjEzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhZTwMfBphkfBTGIjFVoh7L6lyEPZvuPIprf9q5tTLnmCXHWAVgXdVSJaj8WzBHHa4Ip1MVBIQFDe42Ij7ayBnkznyXuFF5/E9LOTgH8YodfFdlh3e9s1mjMdEK7eOY2QuxCpLMwS/Dj/Am1yzXTI1goQyP9Rv7XbLcIwnVxKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AxHxocTu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J1iUnC009007
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3vU6X6UmptKEeubZXKONa3UV
	WPBKyO0rvUIh820/nkI=; b=AxHxocTuLdMKi6qPApw02H8p2uKc9/gCfFXp6JIk
	Wxrg9EWZNdMQHKdQ/GGv2JYKe7qTS8dWUR+Rtq93OIlUSzsxpfRzW3p3XtVepfcX
	JpVfAr7f4hw1dJaVE0fuIuL6Na32UrtXQ1xJPFyzQomZHGJ2ialZ88e659HAadkN
	LPlO8t4dh/z0HIlDM/3GgStv0OZoihhuG0ZlG/jvLX0V4dDByjjU2F15jWqb5D7h
	P/JPGcAxltYQo8Y1D+X47NJx3vaEa7Ij643UlrkqccUo0l/EoJ/d1n//w26XENCm
	PF0mlMyRL+L94jXit2BEne4DdAtI+3tEKqM9ks2bk3fpAg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jh077qyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:59:36 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a9f6346f8so107867906d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755590376; x=1756195176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vU6X6UmptKEeubZXKONa3UVWPBKyO0rvUIh820/nkI=;
        b=WfdHMtqiTwv1ujxiD+wJyLJwKc/KIxDzwiZmv7XbNWl7ar6MnGL4lrEOHKrjuK3PSs
         CzgYKUfKh5MJEhKkSb8hoTILICz+IU2xL93i2rojsLIkYTq0UGFFoQ+AAQFG121ZTXzw
         hPi5Hl2oTJFYwwRgsWpJ0c/6kirPkYsDHRO0T2cB1YsVlPI/yzUbj0Wxe35/HhQF4hBH
         5hcc5UWJHpZCZmPjFZEvJg8GMaqEjmTqoiIegdE//Wuafp9CDgOtpQ7WMYlcjNm/rQE4
         EICm+fdV/2UFXWRn8Pa8ayy8A738i6eBIufsYTr/vHIceRQQc8XSqvbiRvKSPyyvrOPf
         Ef8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUGmEDH7GxzW8ublAyvu98icn8PKCmRuQ+CIw5mvLZO0O25Kuxtzk8WehMES4OFKGI+aZgS62VX13Xi7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwotmKkaGvbpZ/PYQQKGSSEMQhFmQFSbjU6urgF9aEDJ7uE6Arc
	n9TnzhL4/vEjT66/ej9N8YvpWCSjkBTkcG47uhqyL2W9LY0RUL9ZaxywgRgjLGn/VquCCaDTCOI
	acRc1Tqoil379VxFAB+Y2DGr9eEA4JKekFPXRwEjnHst5xUT8kyNDZ87m/BGhoN7HaeE=
X-Gm-Gg: ASbGnctaxQNa+ReVF3F1aNPQQc2xqm+NRsTopa4NqeAUzgkrINm33sQeGwhxvhT1c1S
	IhXkDYKfkATf6dOtcrKreAwkp9WVvdZUR2CMPl7M+crWoVR+s6wEkBMRK28+3qF9OKsorF0MSDa
	oA6N6dh5w7qA19mFAWrUJIJOUIex+ojezwLGlDh4GtVmJtsV4I6zXvo/AwDMEBDqswPjpZeNFpt
	217WO+MmYT885b7zf21KsORwt162vkJ29G6To1prQbtJN9oFAHionNd7T+grYfGcTnhFCG13o33
	kpviO/c25eGHu4vZuk4hblCj93i4grIQc8Qc/WOUBPQYB3Nr6EyuiJlKp+ikL9hptMCXE91mXUH
	qIp1JSIKR+76pN0znypjrZa8tKrglaKChJbk2NahVy6QwXc08JfLx
X-Received: by 2002:a05:6214:2249:b0:709:8742:e46e with SMTP id 6a1803df08f44-70c35c1f06amr21420906d6.45.1755590375806;
        Tue, 19 Aug 2025 00:59:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiMVGZQHvFNLcaq5/1TlbULCLv9YgylRXF8bOeajYtu4DRaeBUMTeUknrqEQR/YcjE19k0Pg==
X-Received: by 2002:a05:6214:2249:b0:709:8742:e46e with SMTP id 6a1803df08f44-70c35c1f06amr21420206d6.45.1755590374394;
        Tue, 19 Aug 2025 00:59:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3932sm1968059e87.109.2025.08.19.00.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 00:59:33 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:59:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
Message-ID: <brculyyu3dgc5nkj2cuzv3jkjzcouljy5o4jwr6mw33r6i7gt7@j6ur7yvwmky5>
References: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
 <20250819-qcs8300_mdss-v7-6-49775ef134f4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-qcs8300_mdss-v7-6-49775ef134f4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: jiSDSOsLl4iBdqlzOP_lbAouzIoOJLq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyMCBTYWx0ZWRfX606y2bF6+829
 yqcPyPikac+aGqEQ66dHMkUpECyvocAP3R1sCGG8hIk9838CHIgdJIXm8ZY/5dfxDtUBBdNDmrI
 y+sxR8IrNL36ChPMWpaLpJvKsDM0pZF8XeSSqM0ksTNC0DlxugFW+iTZSYAtuBYYmUzT9ya7aUG
 O/539Rj1M2kOiDURInOz9+iFZ3BedkquVMJ2iLpWCtBOU+c6WTR26B+qVzRXlrjq+35wGm4CLd5
 7ximYFvxJDrKTh5SOrgM6W6ONnaLqv361QYqKW58ltKq94i9FLjT4OS9d4U6On34Gn3NhV6StOs
 HPSrmopKF+KKXO0ZVo5kEJ8x8Hn+eUCM+iclhGtLCot6e8SSdYwyVby/x5ftOA0tajatUG9+4+i
 X6U+EjZq
X-Authority-Analysis: v=2.4 cv=a+Mw9VSF c=1 sm=1 tr=0 ts=68a42ee8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Yr_zk0diUUozgDP3y_gA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: jiSDSOsLl4iBdqlzOP_lbAouzIoOJLq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160020

On Tue, Aug 19, 2025 at 11:33:33AM +0800, Yongxing Mou wrote:
> The Qualcomm QCS8300 platform comes with one DisplayPort controller
> with same base offset as SM8650. But it requires new compatible string
> because QCS8300 controller supports 4 MST streams. 4 MST streams will
> be enabled as part of MST feature support. Currently, using SM8650 as
> fallback to enable SST on QCS8300.

Hmm, no, you are not using SM8650 as a fallback. You are using the data
structure for SM8650 for QCS8300. That's a different thing. It would
have been using SM8650 as fallback, if you had declared device with two
compatibles, qcom,qcs8300-dp and qcom,sm8650-dp, and then relied on the
second entry (only) to provide a match and data.

Exactly the same comment applies to the UBWC patch.

> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d87d47cc7ec3eb757ac192c411000bc50b824c59..bb4660585849d1a67921a28e7e12422e0c327ab2 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -187,6 +187,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
>  };
>  
>  static const struct of_device_id msm_dp_dt_match[] = {
> +	{ .compatible = "qcom,qcs8300-dp", .data = &msm_dp_desc_sm8650 },
>  	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
>  	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
>  	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

