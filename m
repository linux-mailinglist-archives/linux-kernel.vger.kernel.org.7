Return-Path: <linux-kernel+bounces-841556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C414BB7A48
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28F864EDC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A22D73A7;
	Fri,  3 Oct 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PXiVTmgh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4381482F2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510966; cv=none; b=GelRdCulGlKCLgG7A14OYLOnUARHC33t/tFqG11tO3pWnBJLVt5fwM3QmA4qlNfXdLhKkgoN6wlmk7bdWItYNGQVclUH05ccvXg+idjiqvnvX1eYhV/k8pYgM8jWMiLmRfoO2hu8onMNcW74d7d6yVs8RjNgWLacORbocEp4kh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510966; c=relaxed/simple;
	bh=1zx1udROAwruUJTmdJWQyMyDDuBstgfxLo5u4KwL30I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIFJmIoq+A9EwCTgOOjy2dQ5Pgaewp5DFCYHkYzfvL6w2zCTAE8S1Sj3Ur8VP7prnoaibgVgWxoS/1unR1hnkJJEUTZEyhSG93sNtE2LZaEC2Y+Rfs5z5FGcP3J/UshWPAeLwJODCgrNLyAA+VYjr29jH9Ofw9X0B9yEMYkGFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PXiVTmgh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593BBm0I021211
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 17:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KgoxikXo2ZLB4qRYHWwK6Hmk
	lhI2iR3jWmKfpn6+5BU=; b=PXiVTmghXPDtT3Nr2+qSWeiRnA5fgCLitmfqYLGB
	TKSHqsHFcXgEU2MHmUubMUBcFj+LzL8T34iFf3XOUI/5qGr62B1c9rgmdXwD4XH7
	NCj7e36Z7ygyU0XsiH+ECSjkwREAeGzen/NvrEhvPLPbL63JMC0+xD2a6lJKpScp
	WK7JYkgr0pi4V6ts6AZ4yZjaqVFMQyyGgLWsweyaDwg1em/1/KDqC0MFbtoEwyWI
	EHNqctiqXGekQM4enaPq8jEVfWqK8Sv8ueskiKfdWzG5Szh1JJPX0vAyJC70Ym//
	RSKbLOtE8BtuZEAmb8MJkIIARnGql740GNJxvzP2a7gphQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49gyu1frpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 17:02:44 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-43f437f4f22so609624b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510963; x=1760115763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgoxikXo2ZLB4qRYHWwK6HmklhI2iR3jWmKfpn6+5BU=;
        b=luBQ4B5XJZXGCF3wA14jSkyqSPK0jMD0anZhUTCjWpPlBoLAzTiVDRLcIZaMmEVhUe
         rZVLxZIN6fyDWYHbVrBLc3ON3Dybn6L+VW4846o3w2mdfZMH1fCiz62MJkOA5WpHiI0I
         IiFMePeBcpuYUFAPgizLdxypGClAv1QV5/6ySgRJushxk2zasMb6st2SDkPTlnxnjghQ
         8fLJXluXNBL5Ay3rW54tXR1NV5Tbo9498M7FxmfGLxaZNTMf9T+ctZncuSiBWOVk9S2u
         BZpq1lhXZBGCsO3Ju08xHhSnr6aTmM+q7kYiepCSRQEg3rQkVmR3aJP6bDgP2J1df/2O
         aNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdmyrtU8db9MpUONyXz1xYAJJT/K1QEUQk6H58rKLixMqF+JHv6mjQ0CT8hH5IAMdxh7/r7ueslwVSclw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZCwLZSk5GoXIpAuLbZ6Hb4PUV583JYcWRk4Rv+ZP6H24XQT4
	B08fO7aoDenJhy7Stq2uLxacW+7Zly4vKaOBKA1Md+s4GrMKiDAnXVd6XKeiwm3CjOeL8W3n7+n
	cPmJAKygZ06Nw/hSeYVSzDn8avceqWnAID8KxsaC/auJRMbWubiDobbJj3AqezHn/DnI=
X-Gm-Gg: ASbGncs4lbfsrkN/s+nogQSscXrZmMMlrkcpOebFNpaPrYQ3wX/eGwk3wVXagbWwZ2s
	GGPJhx6oFTn8gK1F5kuEX17e5Y2VBFYct0HnoqN5osJ+0jG7WGApMYrxUzo4Z+vwtVqrugUFG9i
	IP5Z9zWyrNdHwQlFAipxNyovgNzGRwU9jEeCKU3G3SJFnBs5D9z99fTCT50lg4VlUUdLBnJ/Nca
	2nVrtsF3m4nXIn9ocH+Xteqf1zBL/Ugpg8LbN6Av6V+T4Qw9KuGym9LYGf+U0NHsYPxsArL107/
	d14Hjtq2jYOm2Sw2VE/+YjB+6+Y1HWYZRRE0KcXonDvTEFrAfm/dHftkGF3LPQkRI61ZeK1wdoI
	X8IKbIkElWppKDQGdCqzRYWsdhB3/0QTAyq7T8HucRUqYnXYVA+9mehVF3w==
X-Received: by 2002:a05:6808:159f:b0:43d:2004:bf3d with SMTP id 5614622812f47-43fc1830c2cmr1748762b6e.32.1759510963163;
        Fri, 03 Oct 2025 10:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSLjjxQA4p0EfAhPSPlC8pxdM4ZJElDgCUfgufaoYhlOS1ukf+CvDzO3irSmuShAdwAqpqXw==
X-Received: by 2002:a05:6808:159f:b0:43d:2004:bf3d with SMTP id 5614622812f47-43fc1830c2cmr1748700b6e.32.1759510962583;
        Fri, 03 Oct 2025 10:02:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124297sm2012104e87.23.2025.10.03.10.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 10:02:41 -0700 (PDT)
Date: Fri, 3 Oct 2025 20:02:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Jianfeng Liu <liujianfeng1994@gmail.com>,
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
Message-ID: <bnrpfijh4rljdzroduqncfygysvgblljlhdpvq7ubajlbbwvwd@ohdmpjvpzj33>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <46q2pje4hginnm2wld6ejyo36hfkmkzydaa4qggx47gd2p4q4z@q6vmomtgqihv>
 <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
 <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
 <e69b23de-e9b6-4dfc-af01-7d2726dc23e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69b23de-e9b6-4dfc-af01-7d2726dc23e4@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RfGdyltv c=1 sm=1 tr=0 ts=68e001b4 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=vpI0o0ENzK3Q5gXZhecA:9
 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: 6-7_fgLTkWp7Svawjy4gH7lwMnK9CUCD
X-Proofpoint-GUID: 6-7_fgLTkWp7Svawjy4gH7lwMnK9CUCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAxMDA1OCBTYWx0ZWRfX4Gbb1EFIqRge
 aTb3Wh3iHNPpuc4GJKe+75Sb4OoSK2MODvv9N/1ApbcNa8AIPT2w8RUW4o2NhZ2FDdepwWCXcj1
 MfbBThwBUbPjITfPYTmODuxY3HTaKPUv+H2yLMTbFMJZPvdN7t0F5OfSNAt41JtKMIKeP3x0bNS
 OU8VBpmF0+ss18xBxlgD8rdYkxR1+2F6HlX6/KWYnsYdoz9mTfmrJMcqo+mGEOVD2hIoo1hqXeo
 RtV6f/3HVTiKgz/1izqGGwq+CxsfZLtQIKY5pxHrKZzw7IW3UpMzqieiStoSl77j3RHMl4b4oCK
 cfBDSRZkDMrwMF7HlzX8h1kZ9qyzavhsqXjsiRDafnMrTdSWmD/s5AVXH4Pjx2NLfNZciEV/3Gc
 qtuR66Zf3jVWzUzUe7WoAili5jySgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510010058

On Fri, Oct 03, 2025 at 05:35:16PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 9/26/25 4:09 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 26, 2025 at 11:30:26AM +0100, Srinivas Kandagatla wrote:
> >>
> >>
> >> On 9/25/25 5:28 AM, Dmitry Baryshkov wrote:
> >>> On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
> >>>> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> >>>> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> >>>> use msm_dp_audio_prepare instead. While userspace is still calling
> >>>> hw_params to do audio initialization, and we get the following errors:
> >>>>
> >>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> >>>> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> >>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> >>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >>>> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> >>>
> >>> And a call to hdmi_codec_prepare() comes only at this place.
> >>>
> >>> Srini, Mark, when selecting to only implement .prepare for codec ops I
> >>> was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
> >>> hook"), which documents that IEC958 status bit is set after
> >>> .hw_params(), so it's only visible during .prepare(). Is it okay to
> >>> implement both callbacks? Or should the audioreach DAI driver be fixed
> >>> somehow instead (I suppose it assumes that the port is available after
> >>> .hw_params(), not sure if that assumption is correct)?
> >>>
> >>>>
> >>>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >>>> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> >>>> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> >>>> hdmi-codec driver can work with userspace alsa.
> >>>>
> >>>> Tested with Radxa Dragon Q6A.
> >>>>
> >>>> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> >>>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> >>>
> >>> The patch LGTM, but I would wait for response from audio maintainers.
> >>>
> >>
> >> The ordering matters in this case as we need clocks and audio
> >> configuration on DP codec side to be setup before we start configuring
> >> the dsp pipeline. Looks like that DSP is trying to setup DP endpoint
> >> even before it is ready.
> >>
> >> q6apm prepare loads the dsp pipeline and starts configuring the
> >> endpoints, if the DP endpoint is not ready dsp would throw an error.
> >>
> >> We might be able to pull in some dsp logs to confirm this, but I dont
> >> have a setup that I can reproduce this issue.
> > 
> > What would be your recommendation to proceed? Is it okay for the DAI
> > driver to depend on the .hw_params enabling the clock? Also I see that
> > the error regarding the clocks comes from .prepare callback too. What is
> > the order of .prepare callbacks()? Can we influence it?
> 
> prepare follows hw-params, and prepare can be called multiple times
> 
> When you mean order of prepare callbacks, you mean w.r.t codec and dsp
> backend dia link drivers ?

Yes. Here we got a dependency from the cpu dai to be prepare()'d after
the DP driver performs some actions, which were a part of hw_params()
callback but were moved to be executed during prepare() callback.

This leads me to two sets of questions:
- In which order are those callbacks executed? Can we make the ASoC
  enforce some order of DAI's prepare() callbacks?

- More improtantly, isn't it a sympthom of DP driver (incorrectly)
  performing too much in the .hw_params() / .prepare() callback? Should
  we move some of the setup to the .audio_startup() instead? What is the
  expected split between those callbacks?

> 
> TBH, Am not sure, I did not find anything that was obvious from the code.
> 
> 
> 
> --srini
> 
> 
> 
> > 
> >>
> >>
> >> --srini
> >>>> ---
> >>>>
> >>>> Changes in v2:
> >>>> - Link to v1: https://lore.kernel.org/linux-arm-msm/20250924085804.34183-1-liujianfeng1994@gmail.com/
> >>>> - Use more detailed trace log in commit message.
> >>>> - Drop the empty line between Fixex and SoB.
> >>>>
> >>>>  drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> >>>> index 7d78b02c1446..6ca1c7ad0632 100644
> >>>> --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> >>>> +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
> >>>> @@ -130,6 +130,7 @@ EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify);
> >>>>  
> >>>>  static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops = {
> >>>>  	.audio_startup = drm_connector_hdmi_audio_startup,
> >>>> +	.hw_params = drm_connector_hdmi_audio_prepare,
> >>>>  	.prepare = drm_connector_hdmi_audio_prepare,
> >>>>  	.audio_shutdown = drm_connector_hdmi_audio_shutdown,
> >>>>  	.mute_stream = drm_connector_hdmi_audio_mute_stream,
> >>>> -- 
> >>>> 2.43.0
> >>>>
> >>>
> >>
> > 
> 

-- 
With best wishes
Dmitry

