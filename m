Return-Path: <linux-kernel+bounces-831612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E6B9D1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC84A383A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED161E260C;
	Thu, 25 Sep 2025 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I6hbMzC1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF5C1DE4E0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758766695; cv=none; b=B6JK+9WFjGAKV1LYjSiUS3yRsYMr6Ay8/QFg4jkcB6S5cBIzd2A4xh3DOtMUqcu5Wh6mAsSPdA/5dX048eRL/QDEn7mDu46N9c/HVJIXZCQLhTssvwzN57XDQ3M8WNZq3iwHW3tA0H8LHVcLXDqEveSnUPQVV9VaPrOswlVwHG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758766695; c=relaxed/simple;
	bh=CehTCmJ3harVhsJLXtf6xLYElsZU85bSjSvk7ys12WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz6mkURtvcHOf9PWzduaaygXQquDarQQ0uiDiq86u0H3nLXIjl7VazE2T13easRBLgEdnJzA/5Vdz+wRicfpCiKjp7jZxqdtxnaNfoXdgiZKLms+ocYCIVnTCWEcpVMGPOlv/xsOR7uRfnxCCBl36PljVx3E9zIBuBhGUI8vCy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I6hbMzC1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONv5m7028199
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1tdqO6cd5fS/+0X1NnexIlG3
	ahbTElvONhvf7VCi+6w=; b=I6hbMzC1fh2Scl+TOYopFwKYOj3BNWylHO/zZqGk
	6gfoCqw7pFzO1jOYtskX3JNJB6AGkeoaw2/cipQvzyOQvilwapzlzq3xqNaTOciR
	McMhPo6Oayuq8nkVhnDNaLHUDB0OAwP8XxR76TDUFT3lXBFRdr4BY/hYu2M2qmKh
	s4LWdCErmLCWF9ml0O3EBI4KFK455jNaGvDfjz3vm0SE5q4QtVrNgjwrx1L1r8gE
	y6oW614EMhcKxW42n7a+KjaJayj2CPZSDJjJfWdPlq7qQnOYMMXeKHkfcOVfDETL
	eK4ZAm1JDR/bF/N8hiUyCRrvCBJZAxe295l9ED/uSXyydg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnxrxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:18:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cdcff1c0b1so16339451cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758766692; x=1759371492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tdqO6cd5fS/+0X1NnexIlG3ahbTElvONhvf7VCi+6w=;
        b=JNwhQBVVBLV/zs/qp3gfs5TuDLyfGz49jScXa/h/rGDAej7ZboiI3qsBGBzT7PD4Ln
         KJTCGyx9R9k/NY/W9xq9UW9yIhJtP3R8wP8ZXMUgifFt61zqvB/lbLur/dTlyo5Qbf5l
         ZVcRWuJR73WuyyfDkyAqdlB7Enta/T+YWXqPVvJmweZ/widQ16vX2zRV7ChQuKiu/7pj
         H1PD9SGo+sO/wNMNCbSvul29Xra91+0hEY5zn3R8mNWVS1eb0bDyaUtRB6Yobxe6888A
         59kSx17HTWYnfN+8Th/qARZu8mHqgK4YrpsDsrvYAgKw3+/kJmHpcJKeE6P0cwj0hFcf
         VowQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzLZd+ryZELzrnq3TAL7FxnM0bMlNod1XBv3Y13TmZa+n4iW/A7nZ7nDtwRv5MjeWlCOjIhU2dA87eyQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3dMkVKalrYLxM/eBOFVaRYBVuSr8Qw5mtyQM+VgHXfYkloxm
	sFnq4vhY8smd2DgIT3q0NH1dSlHVB4Twyw7ZMDCJMNOdTInz0WmkDOTmY3BpEcF4Nk9skQv6lsH
	OZlRI7QcoF3f1cKTdhkZEsky1tlg357rti4oRXd/viMmpH7cq+SV7o4LoTABx47/KITU=
X-Gm-Gg: ASbGncs8aaaviPe+EvgnDhYp2SUVuMCOA7Srpq5q2sHfGSr1UzNNHWKWBCv1Ic4L6St
	ycwVFiFXFx37oJhHHQraCE9Tc5E9sKtAQW5R4KYAXZ2wRMoA6POFOVoGklqmqmS95h1dkB97moz
	Lzbdom34HhpNWCHW271TQSC0X2nlstfD98fRfUW/ggjQSoViEx4wo2aTuhgm1JAJqK8aHUBlPSv
	E/yBBowKovnX92+ddSdUiI0Qw7n3sv2lAM/1dC+cnqtSw6hJUu5ILQ2AWizDGZ4v2eO3BhoYXvl
	uJuCVGIQ2i602xGlwwsKPM/vEQ/ekSIeTAb3cXnCna2D9Lzyf6H843fI5sk4emPcIGJh2/TGxTz
	8x1snan4bhb/YpVRyJj55uT4iPv9c9iNP6xqL+ApeTqikuPiK6cN1
X-Received: by 2002:a05:622a:1793:b0:4d0:63f2:7f49 with SMTP id d75a77b69052e-4da4962f5a5mr25304191cf.33.1758766692053;
        Wed, 24 Sep 2025 19:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxpvMVwwqQ5NSW2xYygd6P9uBSKUklEXxj6opSTMlhrMfSS6SRxYcwepDRrUJAQRSgxE63IQ==
X-Received: by 2002:a05:622a:1793:b0:4d0:63f2:7f49 with SMTP id d75a77b69052e-4da4962f5a5mr25304041cf.33.1758766691461;
        Wed, 24 Sep 2025 19:18:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd5f4bsm242768e87.52.2025.09.24.19.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:18:10 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:18:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: airlied@gmail.com, broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lumag@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, quic_abhinavk@quicinc.com, simona@ffwll.ch,
        sophon@radxa.com, tzimmermann@suse.de
Subject: Re: [PATCH] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <6mq5morx4kuwmxa3dhpxf42uqedtveectlbeodl5oj74rqk4gy@oweda3unauqj>
References: <zopgbudg67lygconkv3bl43xogzl6rncif7wdpclbyc4wblan2@n7v75dbnaqqd>
 <20250925015112.19499-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925015112.19499-1-liujianfeng1994@gmail.com>
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d4a664 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GGPZM4PYextjLufLVlkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: q0zqbutyyyMm_4GuYFwvnqNyUZRPhKb1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX5PMnuOSu/joy
 7RlXa1t86yOzmHTkKyQaZ/SIIE6iK4VIQAdmFLaGAm9T4qRrGjJnfuqgklzu1zpMUiLgqhZps8g
 x0fKpW2PAm2OGfXslvijBCLdrYcjgRgJGxPoliyiDM06UgelGafBS4j84QO335pSdz8XI4U2xWV
 aTME2Ce+YN77i2mgJ28lVCDXI/s8bax0R9jK/uEaFwdL/XZ8h/nJtprkNHJ/xVAz6huK3wgm6/p
 2/QdU99IKnqQWT8W6MYcC6AKTtXrAfZmJaEis1F2W3drUrQbHthMm5fd0bfIh2nu4Rfi01TIOXy
 NHZhJOz5xrL65kzcwlkEc/Xi9FLf3o7yNFPo+GOuQrdem/qfhB76+u5YZP6fptTqF1WrkCmbU5J
 MUhoCgdt
X-Proofpoint-GUID: q0zqbutyyyMm_4GuYFwvnqNyUZRPhKb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

On Thu, Sep 25, 2025 at 09:51:12AM +0800, Jianfeng Liu wrote:
> Hi,
> 
> On 2025-09-24 20:17 UTC, Dmitry Baryshkov wrote:
> >> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >> and runs hw_params. This commit will add hw_params callback function
> >> same as drm_connector_hdmi_audio_prepare, so that hdmi-codec driver can
> >> work with userspace alsa.
> >
> >I think something is wrong here. The prepare callback also should be
> >called. Is it that the prepare callback is called too late?
> 
> I have added debug log to hdmi_codec_hw_params() and hdmi_codec_prepare(),
> but only logs from hdmi_codec_hw_params() are printed without this patch.
> After applying this patch, hdmi_codec_prepare() is called after
> hdmi_codec_hw_params():

When does q6apm_lpass_dai_prepare() happen?

> 
> [   14.218445] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> [   14.223004] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started
> [   14.534614] msm_dpu ae01000.display-controller: [drm:adreno_request_fw] loaded qcom/a660_gmu.bin from new location
> [   14.535750] [drm] Loaded GMU firmware v3.1.10
> [   15.727443] rfkill: input handler disabled
> [   42.647157] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> [   42.656774] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started
> 
> Best regards,
> Jianfeng

-- 
With best wishes
Dmitry

