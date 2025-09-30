Return-Path: <linux-kernel+bounces-838146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E4CBAE8C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5353C7B64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D62267F58;
	Tue, 30 Sep 2025 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cOGafGbM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1829823D7CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264348; cv=none; b=J/lrNbKQak8qMsdzIyCBxyZOVIa6NYVsQXQ3P6HvgKDsz1yPMt4qMSrZGvRtJP/rqAL17N9ExlJMpN7RSNyN1tB2JHwt4GA2Rsz/6t0o8oveSO22o0naxZejHQipTS3g7WDStpJqLHENZmGmU9AN9Fg19hDPkGmQkD3GOgMEKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264348; c=relaxed/simple;
	bh=N+B6oZWZlGACcgCKE91/I5EsJwXOd2f0A3VW+CBf6Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLnZ1yO/Z0AZkkGJQZjnJeQuHLE4u2J0B9Hye0aBMnkNDWOsyns/ltmgA6nxCT0U+grYMk7dgB+fezfUXWkdfj1okam1sQUyr+NR+zocRAVnaXQYsEsR/tJo/rFIZoHyp65byKdkFehiLnzHvewTmFUqmk+NUgLqxWGgHl1b0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cOGafGbM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBlaEX009336
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aQIv8HbSGU/ItL07DFk6fn1p
	HIrebqBCTmh7KKahI5w=; b=cOGafGbMemrEy2Yp9eUfawzJXf6Q3VhICbNjmOkF
	ZQlv89/gJcQ7aiAnGhnt7WtH9I94mOdfDhXrfWQ7cYlIKq8ZwyhqFIEP7gxNScp+
	HKS1hy/sLSced/c5RpJZFqqrGC/XYZ0lcT6/CYa5dktC2CdtUeLXlnMATvI+iqKG
	7a/vhWiA+zZuxZU/vUq+EP6h2Py0g/SttYNjLwE95YkMubbYblZz3b11AuSF2bdm
	gVPCIpzCK6b9PyUK/v9b0XNC0L8tbhuo81DoZb85/IJVoNsainh6NwDE9gJi6dp6
	/+mr7+cL+r5c6nDDV2XPfMl+/jyVqfLWLlRceevEMNtY/w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977t53q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:32:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4de4fb840abso7682391cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759264345; x=1759869145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQIv8HbSGU/ItL07DFk6fn1pHIrebqBCTmh7KKahI5w=;
        b=akFSxRNX3qauxXB2Rt1zxiORqemsOyrDskpB3KtCMOoG04DlTj4qLBq1WE3yFnvtKh
         hDS5ecOc5g5z0iovxO/hg5ydT5aQwL2VUcSt1C7e6TnrBISpjvrb5GU0eHncp7T/Glg7
         JTkrwn+t/+oADVGqH54l/Isp6GnA/3nkOnkRYH8jYE7moU8lRPKFZPMxaqOsbQf6egej
         R2Bd3FlXZVRvJNSMUotLFpmNT98OJhR4WDc2iRdFAj1z/bf4p3/C9CfxH3oQgaTxRByu
         qo2yrbGR7H6qL3nOM2dhRDjvdRaQGIWtbUrBJKEDy96OjgMSo3xCxVjUhFOwSXryuZLt
         B2QA==
X-Forwarded-Encrypted: i=1; AJvYcCV4es1aX/YyavcXMt8K4MYBEmMoX6PKbhkF1cU1NxPozT+R0Qcek/C/IH+/eUBKnZCeotrY5LNC1/lKmSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhe7DPUOJTCy6Tg+4LfyHlpSMdm31lnEKR8UYCn7LyuqLvDod5
	wi25RwMrektXLOi4Q5jM0H7bZ0NYwLRzbaCosalStaJGSeMCozIGFqXt5q2HK0e9F1cBZKgfteM
	MTi1nphknB1gtkJ1D9XmWlq16vaK41dKMCVB/y+HgbNSPT8LaG3lmuMrZgm0b3Xm+Xv0=
X-Gm-Gg: ASbGncsP3Ga8tcqm6DtZzuowARKX3EaWzHeSDpr4X0K9vFbW59/RV0JGJoL4LA9Ksi+
	CrJxJwNjodlhHDj5tE/S9X+O5Bn1pRQzYf1SoZxyVcX7sJhJVdqLhl9u0qa4ku4rrm9z2u/EfP2
	oxIsyahSNFi4WvioAher83IAkkM0x8iONeIWzfCfY+cw641XGhjHfQXGHAZdb2Oi4EAz87WSJOO
	Ujgw6qjvgnFbLK7mQ7VtAEg8xcgNKtlMo953loQsCVt+OO3NgaSTb1RF1i9l7hoW1lPe1vWHgvn
	j4OfUSCMCbAMuTPRlJ4Iu9K9zJ7ndKQeS3wuFST98KfzbMuEv94tMH9ozrPrxTsdn2xAwgj6SbQ
	wDUYy9JJP/NVUpUox6HHRAsASrKGYADQx3SAmG8yM/7rKWwad95I16ktadw==
X-Received: by 2002:a05:622a:245:b0:4be:9bf7:74f6 with SMTP id d75a77b69052e-4e27d7c5f55mr67499241cf.4.1759264344573;
        Tue, 30 Sep 2025 13:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjMsa1KUO+Xb2y8JXrARVlbLY0nhFqxX54cw9WXubdWIf7Qf3oigc8c9WVQu/MUBv6yKFVYQ==
X-Received: by 2002:a05:622a:245:b0:4be:9bf7:74f6 with SMTP id d75a77b69052e-4e27d7c5f55mr67498601cf.4.1759264344072;
        Tue, 30 Sep 2025 13:32:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139fab10sm5324346e87.45.2025.09.30.13.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:32:21 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:32:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
        dianders@chromium.org, m.szyprowski@samsung.com,
        luca.ceresoli@bootlin.com, jani.nikula@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 16/18] drm/bridge: analogix_dp: Attach the next bridge
 in analogix_dp_bridge_attach()
Message-ID: <qqomsrix67lmx7rth7tg44bxjltw2d7s4dwojqd26duf45uf32@krpb756s6q6q>
References: <20250930094251.131314-1-damon.ding@rock-chips.com>
 <20250930094251.131314-3-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930094251.131314-3-damon.ding@rock-chips.com>
X-Proofpoint-GUID: i1spOwTmxF3XMyDGOJ4HVFwoGkADUZxI
X-Proofpoint-ORIG-GUID: i1spOwTmxF3XMyDGOJ4HVFwoGkADUZxI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXyrIQUaCQwMNu
 p4x96T0dcvazN/+khs6X9fmAXM6tgPtoXZop1z9PcKiI6IX566RIOX2qv47G86RMbp2Fz/bAnLY
 fY878Wz1X6IGJrY7iozdIX35eYXhMIggT4bJXLu3MYDIs6OtZgggB4uVG5s2TLsOdTPIdYKJE56
 1XslA9kHd8ZoR2kRhxLgq22DzNCFVfAhoMzxWLhNcMBwhO/tLDiOZ1sMQ/TPVQTWhmfiwF4pyA5
 gRWrMwVbBavLZ3yZsRp6rusUItgPPj9GidF6f0S4IcR3UPF6bSstTHlYqIzo9/pK+pt/A7qFi0/
 115vj8rOWhh2r/IRsD0tTLXcyi5ea6c6avMF9gQiMERuj16a6IPYv/A8cjaRnKr+99iHPouSOh+
 iQAzUInW81Hao/KMiKQQ+XoLMjSHtw==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dc3e5a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=z1Cm9R5qtz1vL6CzoToA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Tue, Sep 30, 2025 at 05:42:49PM +0800, Damon Ding wrote:
> Uniformly, move the next bridge attachment to the Analogix side
> rather than scattered on Rockchip and Exynos sides. It can also
> help get rid of the callback &analogix_dp_plat_data.attach() and
> make codes more concise.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ------
> 
> Changes in v6:
> - Move the next bridge attachment to the Analogix side rather than
>   scattered on Rockchip and Exynos sides.
> ---
>  .../gpu/drm/bridge/analogix/analogix_dp_core.c |  7 ++++---
>  drivers/gpu/drm/exynos/exynos_dp.c             | 18 ------------------
>  include/drm/bridge/analogix_dp.h               |  1 -
>  3 files changed, 4 insertions(+), 22 deletions(-)
> 

So, here is the rest of the series. In-Reply-To header is different for
some reason.

Anyway,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

