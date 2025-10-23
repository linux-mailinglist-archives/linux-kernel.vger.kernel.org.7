Return-Path: <linux-kernel+bounces-866863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5023C00D44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 751E43505DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E030CD8D;
	Thu, 23 Oct 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NasfqWk2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DD30AD15
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219800; cv=none; b=k/+7+/C7tUJXUZtha0PX8XOCvyas60bP+U0CaTn/IIqkNneUj6wXZR5Q5C409I49O5HicY3gVGVG+7VRBcCBso/3GbrADMlZuySvBgjUY7hvVgHCwaiasMg/YIjWlM4DxsqUC9fjHZXKNzNP0aohRBu88A/yY9aFKj/+KKg8bF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219800; c=relaxed/simple;
	bh=iOv6HrFN/GyaoxkmibXJeE3HzCloZJr9e+zIqeHbdlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=It572mRrN1UcpbesOmiYnLwmeBQFTIxC0WA59HFFwZMUrGShiHGH4Nht1viA3tPAT1UW1sC7zDUTXwc4obn9m086OuB1y1m1yuew7P99r28mcDQO2nNi11mjSwkUX17vFIm0+AmVh4VB7Q+WFyWlWV6TmjCnoAr+O2uYsi9josg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NasfqWk2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N72Jdq011684
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=U/OA0PZSj4gKuY85d/FcU28n
	UQY1lg/5GJi4GwVamFc=; b=NasfqWk2ZECADNbBffa76Z/5DHnIlE36d1p3SbdH
	sS7Oe5NMUQSXdQezZOW52Gtugyq+X7iX9mdSy9bhV9WcWwdp/YNtWsHqdnKiq+UF
	AR0JuuoJTBpEXpVObW9gRARYcSYl1TkC+e9ZF8en9DGdJ0Ob/W0Ed9fLeF3nXiUe
	/+Uk60be9CbaEeArKq39/acKaVq1LjpWMTjxUUhJFYqK5V0jxjd5n5B8xK4SlVqB
	YZc48Zj+x4otifWHMUUfuIUYrhRaQs/zAosbj5eVaSd0T5dW8RwUcvjeJN9zs0Hm
	X+urzMIe2t6V7ZqXBf9CmLwYjv5XjnEe9Axt74r6bwsxzA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y524ae77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:43:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a9ec4746so38927101cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219796; x=1761824596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/OA0PZSj4gKuY85d/FcU28nUQY1lg/5GJi4GwVamFc=;
        b=W/uxQnecDJlwp75xX6KYXHW0L05+PWG1/O/x1GC1IcU+blE2ieNoeOr50MIz61Sl20
         mccv4XpL0zXQd/Lhqtls4mj7uWxiu5P8JA2H3weEA2AcW/+pur8kASg4t5Rxu/i+BwWm
         sXc3kvBVAfmb2kAf/0FfXcdVZ8ubdij7fZBWsPgB2KO3FV0d6DQxafaXdN+SEvhbAQVk
         JcMCG/zOS+polvmzQovz+vIWn3s1lg+8HnUKLxywht6EmuBAH86OtjtS7mDPfkd964FS
         liS3svtIgpghQLdwqL1SHgrLdUCmVlDEg3V90r3dcJfJt6OVY/RpXlqxlNApdraJ3d9/
         B4mA==
X-Forwarded-Encrypted: i=1; AJvYcCWihxtZhwEYgF2Adxm3BQ6wAIYNN6o+lzFnrah1SW7Y/NQb07OzpBpRIkDlGftpa7/StLUyNGB8w+vGCko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0NwJwd2z+B3L1Cv+YcQKWmY6oc9INP8jitM0vXyebCUVFvvlI
	RjTBzkKOJWnl209xPGS+fvJ15sL8r1OKBVM9pvOi+6KTx6gGqoNo8GtTcvzKAnrmdDyIiy1+8wI
	pa5fjn1ejE6Z9teWuJEISa7G5n3p1P6PE3fMgZhOu7I/GTHuBEJnw6JDls4H5oDN78SGmqAtx7G
	0=
X-Gm-Gg: ASbGncun3ouZsvJB7AbrKRm/b4UQI3LKtP5c4VP6z7uuYHyCLyK/BexTWBFm4+Lck4A
	tC+FzmYEg19aQGYBt96h+lpmw+5iJ6k3IxZy3j2IXHsIdmzzS0kyJBKvvDO411bG2zvw/VuCQ2D
	0SAUjS3n7cAcEJNn1hBXos0gGBmec/OTK3kl3dmDrlcIFKYE5X0CqdzHgpMb/3bs9hZvUx5JMaA
	sN68N7zpks/13df5aAXBAWqpshvYSphuN9Ick5RO4shJhbrV02uCJR7Ggh96O1qoKiO3FQPv6KE
	0q9uDCBmBlR9e3sTEuL5LjHyuPN8IqduKLyRNivsBxaB3e89xqM0jHZ+6D4CIIUETuOP1W6KVN3
	6Sg889zEst8KLADeUvWpbMc4HXOYhHW0/HGDZxZZaA3c/wjTeFEXiAGnQ2I5XpY0EV0sBPMocjp
	9tS/avm1vjrm+2
X-Received: by 2002:a05:622a:5d0:b0:4e8:97b3:abfb with SMTP id d75a77b69052e-4e89d35d2f9mr291370411cf.55.1761219795536;
        Thu, 23 Oct 2025 04:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXyOFCl7kcBIEN/wDP5UVI6A64TolHRUI28nTCF4yEdOZomT5Qgfo9kDVTDA2p9pMBrG3vEQ==
X-Received: by 2002:a05:622a:5d0:b0:4e8:97b3:abfb with SMTP id d75a77b69052e-4e89d35d2f9mr291370091cf.55.1761219795026;
        Thu, 23 Oct 2025 04:43:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d67dc640sm4062841fa.40.2025.10.23.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:43:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:43:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
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
Message-ID: <jymgfmn5pje4qaslyaivzfm4m7ho774pid3uenj6yfrlrdk3ss@2nqojclepgsu>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <46q2pje4hginnm2wld6ejyo36hfkmkzydaa4qggx47gd2p4q4z@q6vmomtgqihv>
 <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
 <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
 <e69b23de-e9b6-4dfc-af01-7d2726dc23e4@oss.qualcomm.com>
 <bnrpfijh4rljdzroduqncfygysvgblljlhdpvq7ubajlbbwvwd@ohdmpjvpzj33>
 <f9c922f5-52af-45bb-a4ca-7ca80c0c3534@kernel.org>
 <7fwfxr7zqsaudselhru3jtjc2f7pdjvlaj2b464vgdlqcrljek@asci6y3ghq63>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fwfxr7zqsaudselhru3jtjc2f7pdjvlaj2b464vgdlqcrljek@asci6y3ghq63>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfX4UCKvyjFduFm
 HSdrkcboYlArliGGKr8jIXS7uTcGwuHerEJy5cXzQDdgUl6fCsE7LfKp26eEz5G7dK/I4MynS9q
 gJojLnBBDnuF6rMjjgLM/laxLNxnIndBy0ZxIpDBbmK+F0J245DU4+in+O7T8CXuYX9lMN9H6fO
 kxoO7CleNUeXeoafoxr9s30NwIasxyjgMh8CzsWOt7YHHHvonCFz8MZGIVf7cR+xoRqPiUD1xbV
 JK0Bvq6Vjx3Q0yWoe9EeOIjn3s2+5b8VyWktyR0xDxTOiXxr66eFU+jW7pVSrPHXP0QiZ/8MMS3
 cMUUV9c/zhaiPqCf2mef5veD90f+gBQ1z9VbVY1y4mYm5XNONy88h8FNRQuRT59ONKSh8bJD2+b
 6rFpcKKC+rVBZOQSSTqRVNEnqiu9YQ==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68fa14d5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=HstBAKh7-VjeVNBl2p8A:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: xYAYRI4e3RGFempBXtKIXZt-so__laZy
X-Proofpoint-ORIG-GUID: xYAYRI4e3RGFempBXtKIXZt-so__laZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

On Sun, Oct 05, 2025 at 06:29:20PM +0300, Dmitry Baryshkov wrote:
> On Sat, Oct 04, 2025 at 02:16:08PM +0100, Srinivas Kandagatla wrote:
> > 
> > 
> > On 10/3/25 6:02 PM, Dmitry Baryshkov wrote:
> > > On Fri, Oct 03, 2025 at 05:35:16PM +0100, Srinivas Kandagatla wrote:
> > >>
> > >>
> > >> On 9/26/25 4:09 PM, Dmitry Baryshkov wrote:
> > >>> On Fri, Sep 26, 2025 at 11:30:26AM +0100, Srinivas Kandagatla wrote:
> > >>>>
> > >>>>
> > >>>> On 9/25/25 5:28 AM, Dmitry Baryshkov wrote:
> > >>>>> On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
> > >>>>>> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> > >>>>>> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> > >>>>>> use msm_dp_audio_prepare instead. While userspace is still calling
> > >>>>>> hw_params to do audio initialization, and we get the following errors:
> > >>>>>>
> > >>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >>>>>> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> > >>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >>>>>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> > >>>>>> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> > >>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> > >>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> > >>>>>> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> > >>>>>
> > >>>>> And a call to hdmi_codec_prepare() comes only at this place.
> > >>>>>
> > >>>>> Srini, Mark, when selecting to only implement .prepare for codec ops I
> > >>>>> was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
> > >>>>> hook"), which documents that IEC958 status bit is set after
> > >>>>> .hw_params(), so it's only visible during .prepare(). Is it okay to
> > >>>>> implement both callbacks? Or should the audioreach DAI driver be fixed
> > >>>>> somehow instead (I suppose it assumes that the port is available after
> > >>>>> .hw_params(), not sure if that assumption is correct)?
> > >>>>>
> > >>>>>>
> > >>>>>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> > >>>>>> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> > >>>>>> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> > >>>>>> hdmi-codec driver can work with userspace alsa.
> > >>>>>>
> > >>>>>> Tested with Radxa Dragon Q6A.
> > >>>>>>
> > >>>>>> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> > >>>>>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> > >>>>>
> > >>>>> The patch LGTM, but I would wait for response from audio maintainers.
> > >>>>>
> > >>>>
> > >>>> The ordering matters in this case as we need clocks and audio
> > >>>> configuration on DP codec side to be setup before we start configuring
> > >>>> the dsp pipeline. Looks like that DSP is trying to setup DP endpoint
> > >>>> even before it is ready.
> > >>>>
> > >>>> q6apm prepare loads the dsp pipeline and starts configuring the
> > >>>> endpoints, if the DP endpoint is not ready dsp would throw an error.
> > >>>>
> > >>>> We might be able to pull in some dsp logs to confirm this, but I dont
> > >>>> have a setup that I can reproduce this issue.
> > >>>
> > >>> What would be your recommendation to proceed? Is it okay for the DAI
> > >>> driver to depend on the .hw_params enabling the clock? Also I see that
> > >>> the error regarding the clocks comes from .prepare callback too. What is
> > >>> the order of .prepare callbacks()? Can we influence it?
> > >>
> > >> prepare follows hw-params, and prepare can be called multiple times
> > >>
> > >> When you mean order of prepare callbacks, you mean w.r.t codec and dsp
> > >> backend dia link drivers ?
> > > 
> > > Yes. Here we got a dependency from the cpu dai to be prepare()'d after
> > > the DP driver performs some actions, which were a part of hw_params()
> > > callback but were moved to be executed during prepare() callback.
> > > 
> > > This leads me to two sets of questions:
> > > - In which order are those callbacks executed? Can we make the ASoC
> > >   enforce some order of DAI's prepare() callbacks?
> > > 
> > > - More improtantly, isn't it a sympthom of DP driver (incorrectly)
> > >   performing too much in the .hw_params() / .prepare() callback? Should
> > >   we move some of the setup to the .audio_startup() instead? What is the
> > >   expected split between those callbacks?
> > 
> > I have not looked at full dp sequences but, if prepare is the only place
> > when it enables the required clocks for audio block, then it is a
> > problem, we should do it early so that DSP can enable the required
> > configuration in prepare.
> 
> As I wrote, previously it was done as a part of hw_params, which is
> also not optimal as hdmi-codec clearly defines both callbacks as
> optional, requiring only one of them. Do you know, what is actually
> required on the DP side for the DSP to be able to preapre()?

Srinivas, did you have a chance to look at this? Or the .hw_prepare
ordering? I really don't want to land this fix only to face the same
issue because on some of the platforms .hw_prepare() callbacks will be
called in a different order.

> 
> > 
> > Its also doable to move out the clock related settings from  prepare to
> > startup which should work aswell.
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

