Return-Path: <linux-kernel+bounces-801837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C279B44A8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D3316EE9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BC72D29A9;
	Thu,  4 Sep 2025 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qmme+sIo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3041DA60F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029712; cv=none; b=eBUzGcOP5AoNhGOSIb0liKRDHNIflb90Exoo/Co93jLVH5H+rkERZfhrQmOEXvGX+EcLqzuUhEwLkQlSXxLOwrbi0fZ10RqEmIRzAis9kkA+NpPZ9Akgka3281CJrwnUq3UoPy9w0PLU+ONayMASiqgwxV9QIo0YofEVR/IIJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029712; c=relaxed/simple;
	bh=+bQQK8leulzQJr3omlZJeug2zbyZcBQ4FJgu+E7YybA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lst195ozi4RvZx3H6nE/IqRYBxPgGDB0+UfFmFYubhT6kM++OhUZwk8CTuLWrsjS4JByJRW6usG1ezPirLeCvz2MEL7HIv5wkdBGbDaFx8bIO5KxqeuhGVxb+88ueirhf09hUNEymzzSUMbrm5MOI+JfKU0X0GKCrqwkq5Qb6GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qmme+sIo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GFvf7028221
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 23:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1hFrW2tCyaPS8qm9cBW3XS4K
	eJB96G/QpNSDirWrlko=; b=Qmme+sIohc8NdQu3MsiTwf41dHFazz/ksTqlhs07
	XAvg6aBe++8kBcViHxKjklyyuwVpi0vbnSsr1ZdGSPhegx/pgNOgRBRF45DQgjHv
	ytjELEWpLLoaKKSJMsWAzsPP38HO4Y+bJ9Tc8s1v9OD/SzJ+kFQV9YiA0b4z8Y3Q
	FHCqdIQ5UyrJy2ZaN3oWZ0Ygsxxss+31jZcymMiEortEsFvfEteRGtJ38syXW0Yu
	QPwqgpB13RMbrXnMN/UShR5yng6/xWgrpZrg2nXo5vjCHJs8FAcZHff1CN6/MxWr
	mqLd7A5MJ+n4CIBHA2+L3OWGQriinekWjMA0i9fW8Oh+ug==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0esbpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 23:48:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b32fe42b83so26392371cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757029709; x=1757634509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hFrW2tCyaPS8qm9cBW3XS4KeJB96G/QpNSDirWrlko=;
        b=D4S4ZnYbm3PJ14VNW4+tgvCBtTxwomn0ZPMNxmxyFfNE1EjX0IU6ju19fSmQiB1BZb
         4P1GNJCwdokIKjCfnzgxtFvgKv6LbgpHRR2rH0c2a8to+pgwS+QkRwTHNKjw43V8MRaQ
         pmnklyA5m4Qh3DI+wxqkU8Oe9pJzAUseNLAeBAmMnJZZ2WgzJOlknJGBkHGpGuKnOyQi
         s2rl91HVH+/YdM2ohj7AQxG1JfIPcPzzPeH3x17NoQj0haE4Gw5QdjWS/UTEDd3f89w7
         KeE1O5QNlEA30GqlJ5by00DSKBx/7Jx4PxQ1AOsPXjqd8VXaUZkN2g6FPjCpZUQDgY2w
         dNLw==
X-Forwarded-Encrypted: i=1; AJvYcCUiQT2D8nRMqq4LXGrDKz/AXqyMqbQP5rQtH41XeA3x8mKxFCF5ya69z6GzvhQ/wxiIYK0YttMEgsEmXcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycn20VidhuSfl/F3p02z7KmwaNrBNzgMqctoVnC+lTwkFLdgDj
	hzGv7uKt74KavU5S9pSvTuADkv+7YJ5/Ug83ag016II2uMonhvj8VoiI5vlnI+b8WfFRZtwKJUr
	QdSuq5R5g0LycbZc7C0Ufr6u3vindywIxSAjUMVXs8Dpu0JcDIlNLB8unyzG3SlOQKeo=
X-Gm-Gg: ASbGncvGt3pI1WvEi4Hw4by28Jj3Gc2/gjbrpk5IqKYMVd+oHdFz0LqyzqUnNNT7ysq
	Z/PETH0n67bx3wJpYIM15mnMah1d7Rrug0aXUZmeciIE0ij2y5z/nZLHcyEGzNSjfwDCJyHEliF
	8KAlgUg7q91q1ZMZayV5tBgA79CmxsdEMxKA8EscckG8zwr5H7m8rM1fhx0fCv+RCZw6FgHRlNr
	LrtxNdhaGYSqMhrpk1qs3ylS4PyEo2/aAcndvsl5LOgWjJhUX4Q3vVy44F6lfinlQTTLQfGswg6
	mFAChpCBy0+e9KHdgxjY/4HMCbMHEnHI57WrgkKh6s3CFdOdcb2xKRSliOsKyDmluc7gNIbAGSQ
	4lJE+cOfjPIQSUcGzlFDhsnh2llmBWRtpnJKG2De6KEDUQGKaMOtE
X-Received: by 2002:a05:6214:d89:b0:71d:9d4c:192a with SMTP id 6a1803df08f44-71d9d4c3057mr102310986d6.36.1757029708968;
        Thu, 04 Sep 2025 16:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGyjZe+NSX9mpYQeP9HfjJmgNoHuKa4eYSD2icUNBITBoWtqUVLeB7F2OOeEL/Zt7cpc6XQw==
X-Received: by 2002:a05:6214:d89:b0:71d:9d4c:192a with SMTP id 6a1803df08f44-71d9d4c3057mr102310786d6.36.1757029708573;
        Thu, 04 Sep 2025 16:48:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ab5c151sm1515072e87.2.2025.09.04.16.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 16:48:26 -0700 (PDT)
Date: Fri, 5 Sep 2025 02:48:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kernel@collabora.com,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Algea Cao <algea.cao@rock-chips.com>,
        Derek Foreman <derek.foreman@collabora.com>,
        Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v4 0/6] Add HDMI CEC support to Rockchip RK3588/RK3576
 SoCs
Message-ID: <ncmsmxdcvhj4jec6wmqf5abrb7nijx7ac2i33tvvcc2prljez3@uks2cb6aunnx>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
X-Proofpoint-GUID: sriO3MyjGp9MpxbS4Q4jzChKWPpbkNGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXwCl2O5iNAVo2
 ZRpfvb+lY1QK/H+FLyln1P8iEOrA24ss1t4R/LINaiUk3mUUojomQY2XGHXtXRObT8ISUWx4Ft2
 vakFNN/UTscE3wO2o/G7hYVL7OjX7wnkdjzyr4hj5fXGD161l3W7q2pXlX2VGkXZvaSt1CaVcgP
 xCRZyvSB704Rn5Ep6TjMaZdvKuMqxw3HjpVwN25xMw2B1jspLbKI2jvdqcH2cIp7zKFwpCu59T6
 Dh94JSaIIYq203/xJWqDSGKHdXiJ6hOKaBJ7fz2M2EklGoumlCKQyw/h5AChSDjK9uOMwLkEBTI
 vmf8VoAMYd/r4xRwPYmnh8W9rNkr4qc7CBEXJdswisG1Pe6WcZMjO3QriOBdcQ6U9lyW4yEqiEm
 uaOb7XQw
X-Proofpoint-ORIG-GUID: sriO3MyjGp9MpxbS4Q4jzChKWPpbkNGh
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68ba254e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=QX4gbG5DAAAA:8 a=Q_aPI2XdcSPthaebfpMA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On Wed, Sep 03, 2025 at 09:50:58PM +0300, Cristian Ciocaltea wrote:
> The first patch in the series implements the CEC capability of the
> Synopsys DesignWare HDMI QP TX controller found in RK3588 & RK3576 Socs.
> This is based on the downstream code, but rewritten on top of the CEC
> helpers added recently to the DRM HDMI connector framework.
> 
> The second patch is needed for RK3576 in order to fixup the timer base
> setup according to the actual reference clock rate, which differs
> slightly from RK3588.
> 
> The following three patches setup platform data with the new information
> expected by the HDMI QP transmitter library, while improving the error
> handling in the probe path.
> 
> Please note the CEC helpers were affected by a resource deallocation
> issue which could crash the kernel and freeze the system under certain
> test conditions.  This has been already fixed in v6.17-rc1 via commit
> 19920ab98e17 ("drm/display: hdmi-cec-helper: Fix adapter
> unregistration").
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Cristian, I'm sorry for almost off-topic, but as you are working on this
driver: would it be possible to support HDMI (vendor-specific) and SPD
InfoFrames in the dw-hdmi-qp driver?

-- 
With best wishes
Dmitry

