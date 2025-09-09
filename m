Return-Path: <linux-kernel+bounces-808391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2BB4FF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA7A1884E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD0342C98;
	Tue,  9 Sep 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FHfDzJzF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630A2192EE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427563; cv=none; b=c2wS+mD7OpdDpoPFw80DraNnTigHcTbeeu9qAp6GoFq3YAttklzAzKyxAA7iTDegMV8/sEjDn7YDwaj8UTprgmBSnaTL9+pPPI15InKXbusEtYwPFVeUWkNCLHldtiK1Ub1X7Ln6KGHBmCov4RiN1pwXtRUTz43aIJix56Tt+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427563; c=relaxed/simple;
	bh=s9hJ+BVBz6d6wFfh5Nj/mV5nUoATxWWP2RUxcEkU5sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mszKOzqbRHcTHm3xnkpJGcRvStltKtTGl1RYqOXJip6koFDmbaNn4kDyQ057qxtcrPLpdz+nsp49pnpnrLREpb/DLIxrkNZt1Jwo7hrEtsAgBhWbBRMmruIercnEYuB4z7zv5u5zxbdbio6U+O6zYnsNquRuc8IorMDf6PEE2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FHfDzJzF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LUYi031528
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YeTPR1k+vZU309IbiC+EpuyW
	WbQULc9ECz+ibWI8mA0=; b=FHfDzJzFEl8h7G9RZyps3VseA37OKrkpWMIL4s1q
	/WTgfpefcoHBPxIiJSBEYyCl3Qb01pR2D4oeCRHXN4tTqdjJ0TTUQwFI9AJ+H96S
	Lujkogr4D/m3Lrx/C4sohlt6QZKV32dD7uouqLjmFpvx6glOYIyCcX4nM15rzXzR
	bDy2YfJuEjngqe7j0uQXECGxyQDYS5eatpJEVNnsBAnQnS9gJiRg1YYrjp/M40M+
	Qc0vks98ad5HkYGURUCGgMRnZJMVyOxpDADR30qG4xHwiTMIrDhnW/rhDrtPSzAS
	k/YGkJlFKcm601EIN+q+zpisT097dS5bSnQV1/bhPtYBGw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws8kw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:19:21 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddadde46bso117195936d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427560; x=1758032360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeTPR1k+vZU309IbiC+EpuyWWbQULc9ECz+ibWI8mA0=;
        b=WDi793KCdSuOYy957xeWRBtV2Dux5Y0OysN8/m4gYvmC+gwaihuxOQifU3fxJyr5Rw
         c4ETpw5g0GhnhqJ0HfWCooUxEZD00zRfJWeBsncmrNPz2cY556/Jj/eHc1uOgRBcvYIz
         z1G4PP++KR0cRCr0HRlagSWoRJL88HqADqVIo385ex0N0BwaWhmezHxBaEycjnFIRfL8
         2jb5jJZfhh6n4+gKKrChtw05klR7nBE6ijE0QFPB24ZRbZqz9Q6bwSWNBLoIeb8uD16q
         i0XPV0dp1xGf8wSJspu/urc1P83sqgLUU7HPa/hNsoN5YoBHyOQypI+QbJuDTx5ZswpH
         RCSw==
X-Forwarded-Encrypted: i=1; AJvYcCWncaE9rGvhQtrkMd8CluabsZ1xenDN65FAC3dsL62H4WN8Run78G+fSWGW9jqoxQ9VOhDqhwvaxwvmr0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxBeso2j753TlRC82XZEMvqug1QNxSQyp7HK3SwUYD6DV+UkM
	NNDzliOsZwBzFbSbJs45cw4KPdxloKBtqxkq7+UFBr6WConh9DFdazD624BNCiby72OA13uyydI
	3oSR5dVter53Q1+AggRRNnBdfVTLUJvhSk+JVP5ysbaxw7LwYOBAxOFBMR5pCfNZREzA=
X-Gm-Gg: ASbGncvc2s/JCplnSk2yvrtx/oSljIeAK643YmZhatKRgxLIrXuKlqHDJE4EKlLAM28
	X55fIGQfJDgd/qcAn5lJmSMCi+edKjcpuGgKj8lM4gTBlW0audBO3YIH/aDU5KXc7NqyCM+H3vo
	AxBd/z86SflPKfHy2NgWePGduhxuk3s8lAldDqTvPkEBedGO4TKLKIeq1x/nbBdzZHoeckdkjDg
	4dJtvZQjrMTke+PK3xx2+8b+7Vc9M11B2rDeVffBsF84wVGFxwEPwJ6B0QXd9D08JNBsmG+yzZ7
	w0hvszrKLa+hJ1/5tKz0yJOPBzRPMACjujB9SoVhEbpbeyvz0EbUmosZcg1Zv2P02UIFKIhvXwl
	Uy6mIUPjI8F8LLOLUS+iuvhqDKoLN/1HpwsSCR4vvuCrVxt9GBeSb
X-Received: by 2002:a05:6214:4c8a:b0:741:52cf:a104 with SMTP id 6a1803df08f44-74152deead4mr117448626d6.5.1757427559534;
        Tue, 09 Sep 2025 07:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMDQ+c0Z+2OHKURnsCRqbskK4wF5XETdbqofGHwdn68wRh2A/5/TcMfO4/wpV2hv1CVSa5Gg==
X-Received: by 2002:a05:6214:4c8a:b0:741:52cf:a104 with SMTP id 6a1803df08f44-74152deead4mr117448126d6.5.1757427559011;
        Tue, 09 Sep 2025 07:19:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cce88dcsm561199e87.47.2025.09.09.07.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:19:18 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:19:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panel: Add Sharp LQ079L1SX01 support
Message-ID: <varcinx2i3jtuu4jfsnfpyuh66mdvqe3caolddpsnw23ummpjf@yji57dunb22t>
References: <20250909073831.91881-1-clamor95@gmail.com>
 <20250909073831.91881-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909073831.91881-3-clamor95@gmail.com>
X-Proofpoint-ORIG-GUID: IWIN0QPuZsnyKrCYoFHy800GTRiXR9WU
X-Proofpoint-GUID: IWIN0QPuZsnyKrCYoFHy800GTRiXR9WU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX8uXKyQ8fde9c
 v52+/SK01wdPt30eYTJ4tZH7H4/aVufQWRX6XWNqER69tw6OVT7BZaqadoiRUz1ZC9EAg1wqWlY
 Rp1k5Le8KmoR38X1uNLOcwE3ARVit+6jWsSmNvvHb8tABrBc1diNO3lQGy9io4LsyxgeVNm1Ywl
 EH7x06SkmUnCCThHeOzFVkMdp33kBQlM2Yslxch66nSv1jJDEms4Jw9o7Eg57re+rVKZ7174ckN
 qZ0YS2SCvCGc05qoD8xW8kZrA7XxPYcTXA8cVAKFq1gAL3F4kpuHKCis0/mkw4bxk1Qqy/G+Y3S
 xSWlkQy0Cztsvff1KGF+J2LJrpH4XDDlFgQsOTERmyL7/qRxI9lfo6vgPMxF1YvvqvIZOIzIAXh
 IifkHrTk
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c03769 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=qYIr1XgVyKI1DLWvbXsA:9
 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On Tue, Sep 09, 2025 at 10:38:31AM +0300, Svyatoslav Ryhel wrote:
> This panel requires dual-channel mode. The device accepts video-mode data
> on 8 lanes and will therefore need a dual-channel DSI controller. The two
> interfaces that make up this device need to be instantiated in the
> controllers that gang up to provide the dual-channel DSI host.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  15 ++
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-sharp-lq079l1sx01.c   | 232 ++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-sharp-lq079l1sx01.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

