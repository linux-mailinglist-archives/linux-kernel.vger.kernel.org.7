Return-Path: <linux-kernel+bounces-831690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C367B9D543
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8CE27B24E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E781C1FE45D;
	Thu, 25 Sep 2025 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TQKIQF3D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166C2DFA54
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771809; cv=none; b=NPTwcrEfqzNESy188W/GpOOc9vYLkQwdMLs7cnqvPudG4fzrDOUSV3kFoFa6cDgP7kWMVYOUI8IAwzh8AsSBAzyyevJNI9Q09pjaohu/gYstjHixMiBoNUyHf2EP/unUzA04xz+9BiEN+e8Zeudpb4hj7mpmmepTDgWmGFBRjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771809; c=relaxed/simple;
	bh=5QQUSYkkIJbRYBnc9DmEnEHVwa6jPrIPzX+DC6PgVMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe7TuNdsrZUOnHiimlTMJZb6VJhxzIkcqCZYlt47p11q+OBPYhuJYnYAmjshwXP4rZEeLCYbGCB2boQHMCGipuKooJaxb3Z+HTJYRMAcHauCAL2nvu3ZzzLOk9F2Hey6H/HBa5mGFUn2FCoBRy/Ch6dxPBXULmAC8ixzgBcLtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TQKIQF3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1Gpqj018069
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PnFBXDYMwHMR4niA1eRDzAyq
	R4AF0gya3k2k3n4pd4A=; b=TQKIQF3D1H0cfkXF5qc5fP2RwPf6GUy1FvMymhg/
	DJLKpzD3UNAIEZuagU1wxAc5YlECDIkR4VQ4sTZg+ca6CFxRsXTdG6j4g3/2ZMKQ
	GUp57+cIydyvDxqHVwqk8Aymu4OxFBbwjZRsWKaNeLBk0dYl8bEYdNpZfmMasfPt
	OTbq8oqn9s5RkDM65Q74RkGCZno6YXuvrPEiVhOJ+MSDzIXKhA4LRwkjtPJKseCd
	++F2OWLhbz/UQQZATewPtqCrAWktE//axMMpAGLbJsOBZGjAlMezaiKEchMzLuhK
	3XRTtO15WADYGy5bg45nX9Cd1xTjbbmdA70fmnb09k895w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkakj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:43:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cf47c9bab2so18015741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758771806; x=1759376606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnFBXDYMwHMR4niA1eRDzAyqR4AF0gya3k2k3n4pd4A=;
        b=MR7uBI7YPTdGQMjHLjYPaQMiZoqXC0aOhW8YGdalHwVZhWL9oQ+EUfNQNgB63QrT4B
         2venmfTtVzEA65y1CCGo8OYM4PUeqnyLaz5Zi9VLm8JxVgvbqfEz18N2cZXQvRrqeWUr
         xmGiDToiwU5baKN93WlFeQQg1KWaJfeNdRx6lLTespv3PRAOmgKq5u34kGXunSZ1EZl6
         jepsufP7Boc1tgGmNR/eCciPobUsOWOwVOqwz80Ah7QoN/CRhFnpoeGUWKb5u7T0XS0R
         5uoemG8zNEEq8eUz6GKcStD0QF3NDV1xgt/gMh+hBJXGsZsHG9OeCbfRwnnYiA0xRcXt
         1kpA==
X-Forwarded-Encrypted: i=1; AJvYcCWJic2A+tJoR8s0CTEqj8IzCSOvQf6GVc/Mjlhj1ngSrkHPT2Re0CJ3lbG7VwGMOTNUFD0EZSOcLPyk6AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA2/uhg6CMBl8II4uBvOJdiGFKN1GteJ68fqx6cftfECGvIJ4
	hZBsk2QWiD/CyGQJ3wGfXmUZERmkIBAu6n0cknduY9RctOTUNDK2QKG73UKr54XGYjn8EVZpHSF
	NI6UP082bIHxgRspEMkwrRS3q8VsHVTbFdDbputAtuW/VFKd+xO8unCOPfbHipLdkmSI=
X-Gm-Gg: ASbGncsOgYM0li+FAk48TynExoi+z8kG1GVNGl/sY9TGTaCvkEkCYXr0KgUHQaYX+hQ
	fpPk2o4ArOjrrgpiI5QjuVbv7Fr2Zo0cfDkVAI4gMihqeg8NYB2+Zw/iLU1FyMgN6Z8v/bc5F58
	TJSyod15UBiobedKkGstk6PtHs6SjGuhHSxaT4elTUkGGnBPgW2osl9rme8zrHOLZiIhs7AL2B+
	G4FyU0Q3ZgKsYUK/drtGtTTqikl4ADD8e1bry4FEOZJcy7ztZdo/++/wZ1bde5RfKjs+MshfOS9
	bCCH3iUkXlhIT3bU3k9/G3JSajbboI+jmLc8XCitTrMqQJo6N7OahQOhfd7/6T2xG2mnYw7hvab
	wRYr7/vNnjSclRIUo9hCCenNP5tDrLS0paailFZthpRdD4AxAxGii
X-Received: by 2002:a05:622a:1308:b0:4b4:8f2c:ba3f with SMTP id d75a77b69052e-4da4d8e0d40mr31575551cf.76.1758771805691;
        Wed, 24 Sep 2025 20:43:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCJpBXnXK9vRB+B3gtPfRrk2NcHwsvlg/n3k4nv71c4lmfp/1kkcUFeNgMsag0YU1JgEi30A==
X-Received: by 2002:a05:622a:1308:b0:4b4:8f2c:ba3f with SMTP id d75a77b69052e-4da4d8e0d40mr31575361cf.76.1758771805231;
        Wed, 24 Sep 2025 20:43:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313dd4b98sm306966e87.50.2025.09.24.20.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:43:24 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:43:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: airlied@gmail.com, broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lumag@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, quic_abhinavk@quicinc.com, simona@ffwll.ch,
        sophon@radxa.com, tzimmermann@suse.de
Subject: Re: [PATCH] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <t2v7h2wx4onumjkinxvvyxfm6gqxf7p6tewwaaomx76f4wno3o@ngewgnnclg4u>
References: <5au5p32oyouifgmqlnl7unm6n7tbxq45wpwpqx57xoepiucmxw@tjqlbh2a57yk>
 <20250925032338.20243-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925032338.20243-1-liujianfeng1994@gmail.com>
X-Proofpoint-GUID: NSciVwvQITwn-u09VBatz1esm1mkxBT_
X-Proofpoint-ORIG-GUID: NSciVwvQITwn-u09VBatz1esm1mkxBT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfXyyx4oKqK48xZ
 kGCiZ5Y5Yiy/SE1yNq0upOvfZaEjTkATLLdpzWun0BMdMfA9/vgMNAF8oCH7lowJN5wulPnSKge
 i+c5/Dri8idoLx0kmfHFBlTV2mCCDxBaOu99h+Sh2v3e+vUFWj/W+qwkaPAMeS4xw6PP8/o+J9t
 BNOsDsV5Tw/pUQiNEcf1Y+7UeylqubjHDUqWOD4V46hnBNzUxmKW4yXrAChmIlGGoilq3b7Boh3
 I0tFV+KqO1RQZDmfmVYtwJvOQ9dd3/gySZxf0vRNCeVeYyjDsjg9WPsp6qOjswOSa24lAq2c0Oc
 SOwELbuKWtAQVeiKMgwFHLejKckS9jcZG87N2WoPGTxeUBdtcTKHutgtqq5QkEEOOXsKOQ7SWcM
 A8ZvAX8A
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4ba5e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=LKkRTRVqgOcP5VMVAcwA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On Thu, Sep 25, 2025 at 11:23:38AM +0800, Jianfeng Liu wrote:
> Hi,
> 
> On Thu, 25 Sep 2025 06:08:58 +0300, Dmitry Baryshkov wrote:
> >> [   14.055198] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> [   14.067225] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> [   14.089925] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> [   14.105988] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >> [   14.106027] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> [   14.122707] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_prepare() started
> >
> >From this log I don't see, why the function would fail in the way you've
> >described. Could you please post (for comparison) a trace log without
> >your patch?
> 
> Here is the trace log without mu patch:
> 
> [   14.093437] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.105285] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.127546] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.144819] hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> [   14.144855] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> [   14.652233] qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> [   14.659556] qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> [   14.666326] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> [   14.677484] q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> [   14.690897]  MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback

Please include these call traces (up to this point, the rest is not
necessary) into the commit message. You can drop the timestamps to save
space.

Also please drop the empty line between Fixex and SoB.


-- 
With best wishes
Dmitry

