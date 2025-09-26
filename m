Return-Path: <linux-kernel+bounces-834295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6586BA45C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D043B2228
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED21F0E56;
	Fri, 26 Sep 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WIYhxgFV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC41EBA1E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899369; cv=none; b=F5m12sBSDQro6X1ljDG5sq++5+qTlf51NW+abtWX+riB8D1bxxf22cJrPvxR9KDgtWZGXUNyPE12tTnNj0sg0yCb9x6Hq45bXlND4g8nO2LaVVm8PU+ewHA6CQOW0IHZNhviB1vK3tXVYI338ia7TPI0GahIHD7vLDZxe3At710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899369; c=relaxed/simple;
	bh=2FVv1Hq8CsLTgxv3TXvMbj799Kn3CqKDdgv2Rf9D5Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTW1oGy3oEDw1Z2IAlSicwMf2dVyPWfhPCWcjldkpYCeuHyWUQOFn63ZUsrHt9ALYUUZp1uFJlvxXrF+NmT/aSmAY9Eo7rD51dzDkq9hMmco2eFRmeCzmYjSCLaNbYXO/aEp1ETD+gHTbKBlRfJuj/kAl5g0vP84gTfGarTgVW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WIYhxgFV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEX7L6010631
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xml9I4KJWJ+n/mLooOTRb4jr
	nF4kQuIKgjMLbzeFPFg=; b=WIYhxgFVDjPJC/GSKCkdWOuL54sXvXqRiPPI18rq
	X2kNGEj7aIp59ie7UxCbGCNu4uoFiSviFSSZhMP5D2vxEKkUPp/g2Rz8rq2dZ6YC
	Vez2sH4QsvLhmQoz1DD5c5hqqeEGWLZJUc44Q8eJg0WS6HaVUS1a6mU9kHu0GMg+
	Cm3i48ZM4+UcnAwEUMhqR3vr1l9J5WnirS7DndEIg2KTqYZCgI7OGadhvHmpg0yp
	vz5uUv0YUuEW3LditKCHg0dk8lKXuqW9dU69zTFgQFEj2a6s5cQBZEJwkuchnTbG
	/cq7HaKJ+uRxOxSGYX0KQQGOAwfqE2W9+e5KcRhlKjVsqw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49drfwgvw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:09:21 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d91b91b6f8so45033471cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899359; x=1759504159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xml9I4KJWJ+n/mLooOTRb4jrnF4kQuIKgjMLbzeFPFg=;
        b=L631X9oSek5KesYX43GgkhRGDI+O0o2ul/Chsf0rLIU7AQ9uS44WD3Td39/SPS06F7
         tsG8g9ndawC4f08AlwhC+Bin9tQsIGx3VZV+OzTGXRgzoD3UDUGn7y6bcIxZf50QOylD
         Eutngvk46t1Y3GTn5ROtbTA7syreBkbONLmVAUxLAhvvrn4ipVc2h5638HR/r0XiS7en
         RB7NJ40Gu1FWs9EVGANR8D0DmLcexMgzsb3oB8+XWWonwbActlwU5AyH3VZ0d+EXDcOz
         lnQb9OVvRsOkRwoAmahVOVGApz0Nmnn+gs8nxYn1HHB7aWvSNwBMIo+vwYiwY1ZhkW3i
         +SAw==
X-Forwarded-Encrypted: i=1; AJvYcCWhK4ZteHfkiC9cXNHx2kcZUmtnmUt42blAvk3v6MH1h3F7+SLPcr1JnUQNBT3gpXc8L3wzuBpvNu/gM4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL85U5Efn/YR67w4tte9hPqmXFcSzwHyLyCPBQ7eqVRK4Gv61t
	hZDMTOfInNbiGBOEiwQNrcR8P400KbhJ8PV0ETAOFy0npuJSgpjSlEHuxxrT1XKCzv2VKDmeS1F
	coYfJVL/3BkMB0MC5Jx+d8LjmN9QsimcogZRlPQpoGBBkGeak4nprOIERiIXjkXq/qQc=
X-Gm-Gg: ASbGncvoRonbwSawPq9OCrwrnA6BQhbSZdlUQGevXfcQVKEIiVBm9z9ivvdueLmcP1i
	jvIojYpYE/N5BuDFb385DdRNn8PYwIBn4matD6C7TEr5NMje/DXnQqXMqvAZSt58f236g5ap6Jk
	lq7wZti7zxahJSNOkgm4eMbi8UhbNy5i1wNSGOunwZY5ihwhsTgZlbtdITid4aX7rsyB0rqfVQU
	XhVc3ACaDncYFBIDzg4d7wod8E6qh6+WsKeWKYlfJttYo0op1ray0fmkQdp43M6Ym0FwyFnfZbP
	OzcaYGRLZEKRO7T/EHV8nhT86SiFajIsD7phhhpDdn9e7kIQs/QDgKbADemRuhJQe9n1MNgGcVl
	UqYJCf+cft6zWvA3vYlZzbh6XGLeGZhAE8Uc/nb+Twcn4LG4fpnI1
X-Received: by 2002:ac8:57c6:0:b0:4d8:f0e4:f92d with SMTP id d75a77b69052e-4da48a96e98mr117642601cf.34.1758899358951;
        Fri, 26 Sep 2025 08:09:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVNL1+kS1q2UptTniV/FQ9TTOA5N9MQS67FNYuK7ugL+YJ4ZWes7rk96zqrRI0rqdGs4Uteg==
X-Received: by 2002:ac8:57c6:0:b0:4d8:f0e4:f92d with SMTP id d75a77b69052e-4da48a96e98mr117641741cf.34.1758899358147;
        Fri, 26 Sep 2025 08:09:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316d14010sm1877513e87.124.2025.09.26.08.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:09:17 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:09:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm@vger.kernel.org, Xilin Wu <sophon@radxa.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <46q2pje4hginnm2wld6ejyo36hfkmkzydaa4qggx47gd2p4q4z@q6vmomtgqihv>
 <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
X-Proofpoint-ORIG-GUID: JaKLufx5NEvvU__8tYNs7Eo_Oba8huwt
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=68d6aca1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=Hfy8LQLwNBXcVyXodC8A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: JaKLufx5NEvvU__8tYNs7Eo_Oba8huwt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA4OSBTYWx0ZWRfX5ris39ZZ1OAm
 Q1M66Uttz+i09I5EYaTWsMUMUWFPxFnr/eSSmNAlghAHK9HqgrxiKplTiOop1g6Lru15O5iL4I+
 V5icIAqRB/8XFoElXDJZvBrl4zA+VgbHprSYYbjQWb6yrO72n31oW5wcRwzUcjDXQOufWpO02Hm
 W+137Nsve1WA448C1WLXh3TKXygfRiJszo60vK3MO03giCY3WjSx+A+xfGMfkToxBjqJWjNHid4
 uhzmqIiarUOQyE3c6vckyOc1ivcExr57MKcZHsMQtUi5PLkebSBQVOAHrksQSIGiMonrSX1H6eX
 COGCajoWylU7kRUMea9kHwJf+SK+fRsYFfXbH1yrbsA5KuQPcRNzjlNe91W8AReQWy1C/rwrfE+
 7BTLsAYbwehiiymZDcABXRy1QPdKcA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_05,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509260089

On Fri, Sep 26, 2025 at 11:30:26AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 9/25/25 5:28 AM, Dmitry Baryshkov wrote:
> > On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
> >> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> >> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> >> use msm_dp_audio_prepare instead. While userspace is still calling
> >> hw_params to do audio initialization, and we get the following errors:
> >>
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> >> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> > 
> > And a call to hdmi_codec_prepare() comes only at this place.
> > 
> > Srini, Mark, when selecting to only implement .prepare for codec ops I
> > was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
> > hook"), which documents that IEC958 status bit is set after
> > .hw_params(), so it's only visible during .prepare(). Is it okay to
> > implement both callbacks? Or should the audioreach DAI driver be fixed
> > somehow instead (I suppose it assumes that the port is available after
> > .hw_params(), not sure if that assumption is correct)?
> > 
> >>
> >> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> >> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> >> hdmi-codec driver can work with userspace alsa.
> >>
> >> Tested with Radxa Dragon Q6A.
> >>
> >> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> >> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> > 
> > The patch LGTM, but I would wait for response from audio maintainers.
> > 
> 
> The ordering matters in this case as we need clocks and audio
> configuration on DP codec side to be setup before we start configuring
> the dsp pipeline. Looks like that DSP is trying to setup DP endpoint
> even before it is ready.
> 
> q6apm prepare loads the dsp pipeline and starts configuring the
> endpoints, if the DP endpoint is not ready dsp would throw an error.
> 
> We might be able to pull in some dsp logs to confirm this, but I dont
> have a setup that I can reproduce this issue.

What would be your recommendation to proceed? Is it okay for the DAI
driver to depend on the .hw_params enabling the clock? Also I see that
the error regarding the clocks comes from .prepare callback too. What is
the order of .prepare callbacks()? Can we influence it?

> 
> 
> --srini
> >> ---
> >>
> >> Changes in v2:
> >> - Link to v1: https://lore.kernel.org/linux-arm-msm/20250924085804.34183-1-liujianfeng1994@gmail.com/
> >> - Use more detailed trace log in commit message.
> >> - Drop the empty line between Fixex and SoB.
> >>
> >>  drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> >> index 7d78b02c1446..6ca1c7ad0632 100644
> >> --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> >> +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> >> @@ -130,6 +130,7 @@ EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify);
> >>  
> >>  static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops = {
> >>  	.audio_startup = drm_connector_hdmi_audio_startup,
> >> +	.hw_params = drm_connector_hdmi_audio_prepare,
> >>  	.prepare = drm_connector_hdmi_audio_prepare,
> >>  	.audio_shutdown = drm_connector_hdmi_audio_shutdown,
> >>  	.mute_stream = drm_connector_hdmi_audio_mute_stream,
> >> -- 
> >> 2.43.0
> >>
> > 
> 

-- 
With best wishes
Dmitry

