Return-Path: <linux-kernel+bounces-851373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09DBD64E1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EE218A750E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0A2EBDC7;
	Mon, 13 Oct 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gNZRzhsN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87D1CAA92
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389158; cv=none; b=Xfl2dnTIKlLVgX/qpYqHGOZ4o6QP0n/0UyA0cAHZdiQC/ievPhSiWtBgDErPZ3zS9mZjqibJpX/ETDSa10hTSI5C9Fc1YCnDMIqDh4dsh4Qf4VeHSghJeGvVOJwpeYCgZJJreO6wGBl/toU929IIPAh/wSFoPEwpYEskKCijRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389158; c=relaxed/simple;
	bh=F6Rs8Om+koD8eX7FMENUXtv2uSuMCXLJo1Xg8ht+esM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=piBMIIa621MFkFPUNB+yrjaBHucdXcdt0+eOvgQS5up8cwbeHQc5ImYxmb2SZIuSQJFgCwjXBaP+VTenT07Pr98WvGVIi28jBLOvLW7IBZ3WsRqE+uHt+3bPsRmSgYbVLzA9+TRST9B3AcPBSX8IipV30/Q9w2YjpZE4g3xESPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gNZRzhsN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHD87U020493
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ySrLifkltjX1MyeBlHP2PYxG
	vJxVD9I05Z9UyzULgc0=; b=gNZRzhsNzNZJIeN27FEt2JANa184xNXwZi/jDXia
	NReWbxnQFjpMau9jGzG0g0/UaxGJpbiVHMrVEV+iSVfvK1DuBSeBFeGjYZL/u+Ls
	cuOqmcePe6AIB+j1fN46U9FZEq0XU6AD04DoAqweAAJnr0vTtYUr4UcUutEAr+m7
	5r8KgHAmHvCq7vmGeKwH9841UM8bKj3ajBStl+50SdcpfZFYaF1pSfBeJ1KrhQ/x
	pO4/EpY46lDd4f5SzYCQ2JB1M0/3yZni831wCb/4SbWcf6/cny36rA1kJUfC05E0
	9bjlutOVTVHICrMQmSD7CWc/CgnnB4gbAlYreyDytXs5kA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8x7tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:59:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8544316ef6aso608534785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760389153; x=1760993953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySrLifkltjX1MyeBlHP2PYxGvJxVD9I05Z9UyzULgc0=;
        b=XzEhrCVkp9fJ/UhXuyckV3SaAzsX4gITxr1SmTeYEmEUZysMPrCBxehgnozEcYZDPq
         3Z4/NkFB1MKt+rKeC4jBJnvz/Kaz9tg7G1EW76tJsAVdfcZREk2LKAlfTFO2b2SFlCiC
         4SYfoV0/Cpej9EEJO3dSr1zAYB1YLGFa8KlSsKdnA5P8DbcZLwu3Hi8s1SfAiPbmin/n
         kab2hHfl2noZNAm1uuzB8S3kxOTJL3JIakjMGOiTTOGxDT99xRCqai0b9chIKntWGBlE
         lf1oHO9N3kTH7ogY90UdfCIq+i40sFWjl1EIm10oQ57tVXTsHxl7nvAIXfBaJLQTbs4h
         iNUA==
X-Forwarded-Encrypted: i=1; AJvYcCXxce9ce/07HtAPkLZX3Pg64r3y69XrzrJUEXp4w4JqxanY13n+jiCZr41xHfRWsHBhM0WE1zhEsDtDDJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkizQvfcfHR8+DPuLTF9OiizDTRgxCNXp0+nfzRNp5N8+cv1+3
	YUAodyj6HmJbPfTXd15XZs0JqShndrazGQvVbZmTkZ+wCsINZn8a+wumHLfnTZg08AHJ0YBWNMp
	ZhHSrvNpW5g0tfD+AgfUmFM2RfjJc5Gqh9t8+gkgPdIvHi3WFAy6EuogUj51uEDcVop4=
X-Gm-Gg: ASbGnct8+tCnrMzsjgkv1uQg2lTLA+RkxfYZs+XexN3OZbtRcj20ziBroGTtZaZLSA0
	I+X0LZ+Vya7r5TlysX+m7gdYenjCs/K5AmT8yFz8ITr/hGC4+62eGe3mBQPxc1RJHMECAyd1a9c
	kpMn+syP0127qQf29iFO5KW46uoE8acsty7osb6rn/tIM4ZC81m6sG/jFYDV8Zy4AF0y5dgrmGW
	FxzOEhP6IqNbnJ3jbVWyqaL0y0pLb4BVL6qgAFHPwqUxXlQXqvdwbNmqHSlVVYoWrhazVPudIhB
	2qVzQRWTbeoSv/6JgpT8hvukm6RVa5eygja705JNPcOZQ2OK243WPxEeCZRiqCn7fOQ35oZzuXh
	AFOQtWm8QCf0P6sk4/u7Tk4WQtP9G3xtQ7K4IynIkoU7fOC1LLBLU
X-Received: by 2002:a05:620a:17ac:b0:85c:bb2:ad9c with SMTP id af79cd13be357-88353b33b3emr2867039585a.53.1760389153340;
        Mon, 13 Oct 2025 13:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDcNjBXnK6hzJ9vsR2bUTJhKX6nknppdpL1zRylepA4C0kgR1fgp6jvWThoAE+XD38Yq28FA==
X-Received: by 2002:a05:620a:17ac:b0:85c:bb2:ad9c with SMTP id af79cd13be357-88353b33b3emr2867037285a.53.1760389152901;
        Mon, 13 Oct 2025 13:59:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881f8651sm4441041e87.30.2025.10.13.13.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:59:12 -0700 (PDT)
Date: Mon, 13 Oct 2025 23:59:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] drm: bridge: Add TI tmds181 and sn65dp159 driver
Message-ID: <lq2etybizdf3jqregv2gj64u3kwdtmz3ly23c7wy4chjue7agx@2n6ehezkahz3>
References: <20251013143658.25243-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b5126fec-b83c-46dd-9f18-6b82f3894607@emailsignatures365.codetwo.com>
 <20251013143658.25243-3-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013143658.25243-3-mike.looijmans@topic.nl>
X-Proofpoint-ORIG-GUID: eUvZoTsac-_1DG_ViIM0uh3lhNodz_-8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX237sMNna9MYZ
 ikhB8QK1oT0hvdE02LkoSO6Uoq3NUz+uk8lm0vcPq2vmtrgwmFiDwU9PSTkZfKlTJUf/HRdJnIP
 HHvVVYYsF3Kko8ac6FwIDSdpp2BLfawFldy+fn68mXJGCOkf9blL8qtlVSFY2GNLRlZuGUB07Kw
 rKKgOH2qk+jiKeo7h0P9uCnunxdH+mAyqeh0cNjRpt2d20MDGpvP4qlQKu0L9snj8MBv4wuwrQC
 z6jmZi4Zc8CwCfAYkTRLQ2m68pv3cHzbbBl2DrjiqACsFG6UYw3SY3FYRf4aEES72w1mdyQ/4lF
 vMQfybCQ2GPZ8z0e4nWdrIwSVAf6Hrsjvv3GTpYKSAuYMjMWGYYrfhQUX1fqx+vg7CfAsNSYydG
 vcDHsOAc+gE5rB+5fnlqngLCgaVALQ==
X-Proofpoint-GUID: eUvZoTsac-_1DG_ViIM0uh3lhNodz_-8
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ed6822 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=Z6EfDJrRAAAA:8 a=EUspDBNiAAAA:8 a=vJdPPGod3d2eY7P0RLwA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GLvejNd0Yr38jcbvy3o4:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Mon, Oct 13, 2025 at 04:36:50PM +0200, Mike Looijmans wrote:
> The tmds181 and sn65dp159 are "retimers" and hence can be considered
> HDMI-to-HDMI bridges. Typical usage is to convert the output of an
> FPGA into a valid HDMI signal, and it will typically be inserted
> between an encoder and hdmi-connector.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v7:
> Add DRM_DISPLAY_HELPER to Kconfig
> 
> Changes in v6:
> Add DRM_DISPLAY_HDMI_HELPER to Kconfig
> Change "ti,mode" to "ti,retimer-mode"
> 
> Changes in v5:
> Really added vcc/vdd regulator support
> "oe" gpio is now "reset" (reversed logic)
> devicetree enums ti,equalizer and ti,mode
> Always disable HDMI_SEL (formerly "dvi-mode")
> 
> Changes in v4:
> dev_err_probe, this_module, of_match_ptr
> Use fallback compatible
> Add vcc-supply and vdd-supply
> 
> Changes in v3:
> Lower-case hex values and use defines for EYESCAN registers
> Remove equalizer code (unlikely to be used)
> Remove attributes (no longer useful, undocumented)
> Fix build for 6.17 kernel
> Use devm_drm_bridge_alloc
> Sort includes and add linux/bitfield.h
> Check chip type and complain on mismatch
> 
> Changes in v2:
> Use atomic_enable/disable
> Use #defines for bit fields in registers
> Allow HDMI 2 compliance
> Filter modes on clock range
> Use cross-over pixel frequency instead of manual overides
> Devicetree bindings according to standards
> 
>  drivers/gpu/drm/bridge/Kconfig      |  13 +
>  drivers/gpu/drm/bridge/Makefile     |   1 +
>  drivers/gpu/drm/bridge/ti-tmds181.c | 427 ++++++++++++++++++++++++++++
>  3 files changed, 441 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ti-tmds181.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

