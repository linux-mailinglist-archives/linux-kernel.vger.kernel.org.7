Return-Path: <linux-kernel+bounces-831546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9308B9CFAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF22E7C45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAC2DCF78;
	Thu, 25 Sep 2025 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DZDayied"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13E21C9F4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762594; cv=none; b=jY1N55hdz/ZxCRh/6Q3PWbdvvYzC5x+mHDEAfseFEM2xX+xnenvriao0ZWyD4NzoYU13QZBuN0F8BOmrHS4yfJsA+YseOKdBrGvJQNk2EZbzvNnt+qNQ29MoOVutJA74AI4t65GUc8eTKXJHLdI9ws2qNmR6wWnhRV3GIvCEPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762594; c=relaxed/simple;
	bh=dKn+5PTXvbu9BDHE5QDcgy+Iz1Koprl+SNOyetn7xjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msxRgfPJmxwO09kdpAhS1TiVv8Iqw28EGhenxevg4eoA4eNmj1QJVmdoLCExfVwHHAZWcwcvlxpzMhslPlW5fz7mNJY/PGhCB3lTGxtlTVNnkFSmTWIqa0ealWok/w1lqbk4/+RLSeHywBfpzIOrHbA2g+h8TTh44KSkiKH6Sm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DZDayied; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0M9b8017424
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DbUhjN5CIGWSt9WkjZTIH5uw
	xuwIn+CRrMV8Oz+n67A=; b=DZDayiedObjYn5sPShaRMCrXuWpgoG8g83mwdC4o
	zsMM3TiN5iB2yOV0oFbCpRNLPXroSzKuTXbgcMmWMJqqLPYoccmqPXh5S3sdhveO
	90i6UqZUOoLUIzAQIprL4LvlqoKvnY/qyvMPXk15pTbRxpFxu1l703rrZCGLPQW8
	n0SDz0Ysu7umuMbQpcUQIAe6X2HV/rsTvLqCNHocMMTmM907uRrrSY57evXZYmdl
	F7kftmcyzY1f1+wiVKlAHPxZnooiow4/hDHVgvxRNOJzOhausCigu1YJmwAo+F7A
	9rgXQuZXjCdk7eM4Uqm1vmfru1RExeCpeZPjiFmaKBff/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjykau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:09:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ca4eeb9b06so9973401cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762591; x=1759367391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbUhjN5CIGWSt9WkjZTIH5uwxuwIn+CRrMV8Oz+n67A=;
        b=SsJmORhvmXZDfPfGaYSAaa8GEOBs8t6F/RuKImgiSR5Bp8CDWIIQPlpQgHTfrRvjKi
         gX9LoKTeDyYc89S6KfL03ULm61hMQ4tGGL8qxVSidWP0Z8mMw5TAp4Q+6iL9WlkqMc4y
         qoprZYZdRQTwUv3tGPRPf8x8/bFXCpXgZbKhDbG5aophws1xW5ckaL8dDCaHZLNQ8VxI
         rXoMQAV7Hc5oyL+bhSd1Iot/pgJT0uEuwG7U2R/A+fI/TRpNVDKIC8xbp1jq+TlFQGR0
         V0WovnKysQuI1zloISdNZsEhCqc6oqvYNywIq9rDivNtYyMa2/vsjJFhIPDXwBAFwVu2
         q6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVTrNINgnxrsbA67aT//x4W1ziEDzc8/n2qUOWGN8PWcLmyoUEXZHMKHcTfYSmybym5DTy+mnUHX/kl44g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7jYiZ/IpytA6If6yN3kjPxt39qaLocdTdevTIvUzYJZIRVj1
	khc9JtY4B+Ad63GzbVGpVHDb1k7uZvVOfdaqTU5Mrt+Dpf4J4T0ur53gtMXp/Fmte3Vhb8LvKyX
	bGTzt3OG18y+yIWMqbN5qduCpm+k9/UMIlwaZ7ZJnwZZN2w/xc3y43Bafc75K6KaUWKg=
X-Gm-Gg: ASbGncv+OayfIl3KDsctQcmCA1ePN3N1LQSTLZ2Ww/lPSnXkErqkZimBXYyLbLZyHYX
	G1VS2b6rsS+BM4UeUQjCpb5cFOW0pK0NymfVJCRYJPutoOuojGyG3juKrEeLojdkOAHCBzrY2A0
	cs3Ku7t+gOy9177EXh0MR9yxGWKc2fH4IRs1djTtWvzS7Wq4GO7Eu1wdMYXVrQqKjeisp06YlMp
	ewQc29ub05DFReqDxTstbb3lmxvNyuS37zlCCGuJ7WL5X0xui6xWvhV0PFzETVmnjwDHpeo1ud4
	tLGNBAUehP45706mOeiEdPIvi3/JeGR7rQLNVoZc6MAb49YpTUHxE4SjrgbiQCGdO+yeVUiGDSg
	KC1DqGEvElqmji4yCan6m6P0sBraZrTmJA3Q/b7WyvOzTzVsI/edy
X-Received: by 2002:ac8:7d8e:0:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4da4c39b63dmr22908781cf.61.1758762590690;
        Wed, 24 Sep 2025 18:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHy06/44VJG9y/4ON5huaolTpEddWVJd1dr3xZtLHQ8wyGirA7dIu3ZPD6BlpqavkK+a5x3g==
X-Received: by 2002:ac8:7d8e:0:b0:4ce:dcd9:20e5 with SMTP id d75a77b69052e-4da4c39b63dmr22908561cf.61.1758762590203;
        Wed, 24 Sep 2025 18:09:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a3252csm183105e87.119.2025.09.24.18.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:09:49 -0700 (PDT)
Date: Thu, 25 Sep 2025 04:09:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        simona@ffwll.ch, matthias.bgg@gmail.com, dmitry.osipenko@collabora.com,
        granquet@baylibre.com, rex-bc.chen@mediatek.com, ck.hu@mediatek.com,
        amergnat@baylibre.com, djkurtz@chromium.org, littlecvr@chromium.org,
        bibby.hsieh@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/3] drm/mediatek: mtk_dp: Fix hdmi codec and phy driver
 unregistration
Message-ID: <72pgsr4birfy5wtf5umsfkahr7tplnih5wxoj4x33igapaspmg@7iafkarq4hzg>
References: <20250924103708.19071-1-angelogioacchino.delregno@collabora.com>
 <20250924103708.19071-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924103708.19071-2-angelogioacchino.delregno@collabora.com>
X-Proofpoint-ORIG-GUID: TKWRbYYysHttm0nsHjbdGt6TThMB3Wz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXy1MXSto+VpJG
 vTLh2xL9AT626KKotroMG5TYmJM+0MnCsuUHAPz1h1Hq+Ln69zajY9RoSJWKIsgmRKoxgAgaxQx
 NhPwCGNTy5hw/xm8QQrYHr33K1/KI2xI47/rrq1Usbz4FUtZ1wZxqdiKJLOQakZW+WSvG4kJUw0
 VhAiJTjY5JfxSFmfauXD1UKzD4VU+Y3eV/w0HzfQ1NRXTJljSrGSf01xTDkfDxn66rzmBCEVBM6
 q4h0zhTdr3N3SejSDhiyyxeMcqrgPFhxLrty4uyYm4vHqCjADXvnOIB7ICR1GSp1BKVIzJSIs36
 1zEXESWmVe2zo0asMoXWcKzOmwb/q7VENuAewTQ5YeX4CwWFq1OFxsIJYXoXRGNFIbyVnguDRai
 62s9rfKu
X-Proofpoint-GUID: TKWRbYYysHttm0nsHjbdGt6TThMB3Wz9
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d49660 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=QX4gbG5DAAAA:8 a=O6Y6ztsS-7Sf4rctI10A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Wed, Sep 24, 2025 at 12:37:06PM +0200, AngeloGioacchino Del Regno wrote:
> During probe, this driver is registering two platform devices: one
> for the HDMI Codec driver and one for the DisplayPort PHY driver.
> 
> In the probe function, none of the error cases are unregistering
> any of the two platform devices and this may cause registration
> of multiple instances of those in case this driver returns one or
> more probe deferral(s) in the "wrong" spots.
> 
> In order to fix this, add devm actions to unregister those and
> remove the manual calls to platform_device_unregister in the
> mtk_dp_remove() function, as those would otherwise be redundant.
> 
> Fixes: e71a8ebbe086 ("drm/mediatek: dp: Audio support for MT8195")
> Fixes: caf2ae486742 ("drm/mediatek: dp: Add support for embedded DisplayPort aux-bus")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dp.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 

You can save yourself from all these troubles if you store the
registered device at  connector->hdmi_audio.codec_pdev (see
drm_connector_cleanup()).

And of course, you might use DRM_BRIDGE_OP_DP_AUDIO in order to reduce
code duplication.

-- 
With best wishes
Dmitry

