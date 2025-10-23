Return-Path: <linux-kernel+bounces-867014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBACCC01566
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBC719A775F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2D531576D;
	Thu, 23 Oct 2025 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RxSTbIfX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFB314B82
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225711; cv=none; b=UVv+/RTpc+gTqgEoThEyW0gW0mkc2DkYcwQhDLufTd86K3kzVTqPEOFhxznSA/t6s2kr6RY6N6j5AvcbbhTzNlj96O+cLc9PFSVvpCZNl/hqs1r2e84Bk+cR+9Ph74C9pgTnNNw43enm4UzASk9HNoNYtQYU1S+rFMHG7UO1FJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225711; c=relaxed/simple;
	bh=bI1LhXXoCjT+GSMT3kkm1ZRzd54PARffICLaqyu0YAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR4uGNYkjxHxJ4Y3iQ2AKHEhEWN8nJu4mbUue2BpuqYGEcrbyw3pTHsMNQmuLrxTHi9gjW/eTqqEc0nBTO25KI5di4y/DfkrmcPruBfiH2Dcib1cUkgmb+65T10leTblyxpOd5/xZodxJZNNH1BO3U8DzdohDkiY0JNh0S2ZYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RxSTbIfX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6nmhr025826
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aYiJGBEDwxxPKH+N+F2798Tx
	YOZYqgIe5iOrPfIMAgs=; b=RxSTbIfX6WG+geB19i3oVps81Cx20gAbAdkOV/mC
	AbW4Dd7b8SuySz4ePyO3/taOAD9FOa5/YzH6ipJVMJaFJjFPnyNCbVRG4Th+p9HB
	L80vhVrEyvRwqJdJLhtBYBWeAOtlTDSdBQ/nZ9BbNaVT8mpGhGIyd2JlocTbaSBf
	IpP8gj2/lXNoFffQOtKpwcjiZ6SdNFyNQRwVCxGwLbhn30Uu6mnRuDWlLS7xeBsK
	PfAK3xDkIFF1Y7N4HkhYYTcpY1u7nwyv+acRhusQwg61aYhyb09TziQwzbP1Jl5Z
	2goJyPO5dinCRkze3U1fqaph6diKVh5f/z34z2PSkRct0w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kgb7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:21:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e8a387d01bso32445691cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225708; x=1761830508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYiJGBEDwxxPKH+N+F2798TxYOZYqgIe5iOrPfIMAgs=;
        b=i05hxd15UnWpcVJHgYu5WMMr2v96XQHQ6pVwjqNdsocLaC3Xt6CljvMJDXm6LByfY3
         4MxhEm0RBM+yrK6ZZSGSiEluiOExfCyoXH+nQLEFwMArQRqlZHgIN3+aj4rUco9rDY0o
         eQ7jojTpz8RoIXw2H/JWuOadCqob1KS+pQUuSkMA1UGFBlHgZH1VKuR9UhZ7K7SNvd1o
         hKuGZDXvKyun7/Ev1azwotMQJAKULgsOWgfZQ03BLujfpczTt/2QBwwjR+cD9NmSOkSr
         SNkAHAt8KceDmYj15srSRMRnMgXM/at9+C76t+df/h2RHOqpjhGM7ky7DAxVlFz4mwHh
         E9yg==
X-Forwarded-Encrypted: i=1; AJvYcCUXS2Z58gTXN9uR06/KWm2YOL9IXCLV80QIONi1ang/P31rpt/oPUL3+85JjT0rqxbPLTKy2FSYw/UUqCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgH449WkNyhwTZOFQz2mtox8+l7kw/W17Q5UZYYql/B/UkUbr
	Mt/dpe98X/HWXGhZ2Me8zT411YGnMAddjyOLEobNrXKRMBmDv7xKvTAVFcvwCW5VjsoXD4fe7ni
	gABvoJZqwtcb7vlvaE4RMBoUxlAF00cdivzE1OhPmm+8kBeggt67g/GsDEeKcrpbe9xc=
X-Gm-Gg: ASbGncseOU8rVXjLrAzvfaZD4+8LLH2AWo7bwlL/cqsDLpJJD2tJ8EXmGiysmJ+jmVU
	5KfH5JjuqU6fJ2knZvUuaR5GiJKiT8pPptjdBCtjawtSwsbmkJ0LL2yuYAATBrQrFkN0WWQzuw7
	+zRqUlDrTIRMouw9wTSpAZZJBU5jhqeJ/+CwfjaX8LjVZhz4JPyvkz9CSkaz0FExp0UgaPqDQ4w
	melLkoguTnyZvYMzlmypxQm81j1RsyDJ70lQQNAJnBN1ZJHPVtaERh5IYz5+uHgsxFIc++tpbym
	lVlMctOsyuHhCt25vYD/K63DCHzQCWAw484/Pbb1ADmTrnklHFQUNDAB5aJKnu7Xa9sUwaqNMaz
	qPMeFxhnGuLLVOfFMLDiITe60ZP41H8syCjvT0k7EfqwFitY35q5BCjUbgwxrHFoxEKnapjWUu8
	jGABTvjt16BUS/
X-Received: by 2002:ac8:7fd3:0:b0:4b7:9abe:e1d6 with SMTP id d75a77b69052e-4e89d1dd370mr311674621cf.17.1761225707439;
        Thu, 23 Oct 2025 06:21:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuq5dFF2lUVdMzxUAI6oXyVuLskGEYUhb5l3Z3iRkPe+t8Xmf8Pbu8yBQXt8fpjtm/vTvAcw==
X-Received: by 2002:ac8:7fd3:0:b0:4b7:9abe:e1d6 with SMTP id d75a77b69052e-4e89d1dd370mr311674051cf.17.1761225706796;
        Thu, 23 Oct 2025 06:21:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d1f51dsm738183e87.80.2025.10.23.06.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:21:45 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:21:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Jianfeng Liu <liujianfeng1994@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-arm-msm@vger.kernel.org, Xilin Wu <sophon@radxa.com>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <7vtf5dlfvwkhms7c6licxf6hw3653uckv2trqjmy5sfl33lbuy@565k4iqcvwhg>
References: <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
 <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
 <e69b23de-e9b6-4dfc-af01-7d2726dc23e4@oss.qualcomm.com>
 <bnrpfijh4rljdzroduqncfygysvgblljlhdpvq7ubajlbbwvwd@ohdmpjvpzj33>
 <f9c922f5-52af-45bb-a4ca-7ca80c0c3534@kernel.org>
 <7fwfxr7zqsaudselhru3jtjc2f7pdjvlaj2b464vgdlqcrljek@asci6y3ghq63>
 <jymgfmn5pje4qaslyaivzfm4m7ho774pid3uenj6yfrlrdk3ss@2nqojclepgsu>
 <f1338318-0135-415e-ab65-482cef20f919@oss.qualcomm.com>
 <zlu5x6v2xkum67prrtk26r7govenczuntjvlrflvdb6lpd2ssy@jgrnl6elophe>
 <2ded2868-ae77-4c9d-9456-ac2af775a219@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ded2868-ae77-4c9d-9456-ac2af775a219@oss.qualcomm.com>
X-Proofpoint-GUID: Wz_2sjFWXKVgA-_wX1kXiTTk2LzdE9DL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX5gkz+Yc2TKFB
 yP6nwz3gy8xgR01zCNsoQdf1BHGji/rI5ZYHACxn4Y9gMMJmwaXk3AUhqdYHtG+GXN1BH1L+1Qd
 IPWIY07M9meFZbSqpcKTTQvk0NvayWm3ehCgsJQGyylrxaqGbiRq3If5OUpi+8TbRh3dXE2xmOj
 AaEOQuFauZCcwReD/CCielsbkxRx9Bmsvo47SZ97uAE6OAI8PxTmAx2uPfqRZjXxMLX6Y5TGoAC
 ZT8/ylUZRWeUK5d3rGMNuwUPHtSX9oHyKlCuU6m1AuB77aX7NPktOTiB9Q8pZGTOUnDfUHbLpB9
 0Zclok5MG8diwA3Q87JYz4MSZCc/ZkPvdtdENLQ7S6TjEwayuoitoMJlhhxEru+gUMHBgq72FYp
 2G7RgIbVG3FmXs9W0F6t1JZJC99cTg==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68fa2bec cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=9F4OQHvmJvbc7bxQTiYA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Wz_2sjFWXKVgA-_wX1kXiTTk2LzdE9DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On Thu, Oct 23, 2025 at 01:47:33PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 10/23/25 1:24 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 23, 2025 at 12:48:59PM +0100, Srinivas Kandagatla wrote:
> >>
> >>
> >> On 10/23/25 12:43 PM, Dmitry Baryshkov wrote:
> >>> On Sun, Oct 05, 2025 at 06:29:20PM +0300, Dmitry Baryshkov wrote:
> >>>> On Sat, Oct 04, 2025 at 02:16:08PM +0100, Srinivas Kandagatla wrote:
> >>>>>
> >>>>>
> >>>>> On 10/3/25 6:02 PM, Dmitry Baryshkov wrote:
> >>>>>> On Fri, Oct 03, 2025 at 05:35:16PM +0100, Srinivas Kandagatla wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 9/26/25 4:09 PM, Dmitry Baryshkov wrote:
> >>>>>>>> On Fri, Sep 26, 2025 at 11:30:26AM +0100, Srinivas Kandagatla wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 9/25/25 5:28 AM, Dmitry Baryshkov wrote:
> >>>>>>>>>> On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
> >>>>>>>>>>> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> >>>>>>>>>>> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> >>>>>>>>>>> use msm_dp_audio_prepare instead. While userspace is still calling
> >>>>>>>>>>> hw_params to do audio initialization, and we get the following errors:
> >>>>>>>>>>>
> >>>>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>>>> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >>>>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>>>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> >>>>>>>>>>> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> >>>>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> >>>>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >>>>>>>>>>> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> >>>>>>>>>>
> >>>>>>>>>> And a call to hdmi_codec_prepare() comes only at this place.
> >>>>>>>>>>
> >>>>>>>>>> Srini, Mark, when selecting to only implement .prepare for codec ops I
> >>>>>>>>>> was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
> >>>>>>>>>> hook"), which documents that IEC958 status bit is set after
> >>>>>>>>>> .hw_params(), so it's only visible during .prepare(). Is it okay to
> >>>>>>>>>> implement both callbacks? Or should the audioreach DAI driver be fixed
> >>>>>>>>>> somehow instead (I suppose it assumes that the port is available after
> >>>>>>>>>> .hw_params(), not sure if that assumption is correct)?
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >>>>>>>>>>> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> >>>>>>>>>>> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> >>>>>>>>>>> hdmi-codec driver can work with userspace alsa.
> >>>>>>>>>>>
> >>>>>>>>>>> Tested with Radxa Dragon Q6A.
> >>>>>>>>>>>
> >>>>>>>>>>> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> >>>>>>>>>>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> >>>>>>>>>>
> >>>>>>>>>> The patch LGTM, but I would wait for response from audio maintainers.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> The ordering matters in this case as we need clocks and audio
> >>>>>>>>> configuration on DP codec side to be setup before we start configuring
> >>>>>>>>> the dsp pipeline. Looks like that DSP is trying to setup DP endpoint
> >>>>>>>>> even before it is ready.
> >>>>>>>>>
> >>>>>>>>> q6apm prepare loads the dsp pipeline and starts configuring the
> >>>>>>>>> endpoints, if the DP endpoint is not ready dsp would throw an error.
> >>>>>>>>>
> >>>>>>>>> We might be able to pull in some dsp logs to confirm this, but I dont
> >>>>>>>>> have a setup that I can reproduce this issue.
> >>>>>>>>
> >>>>>>>> What would be your recommendation to proceed? Is it okay for the DAI
> >>>>>>>> driver to depend on the .hw_params enabling the clock? Also I see that
> >>>>>>>> the error regarding the clocks comes from .prepare callback too. What is
> >>>>>>>> the order of .prepare callbacks()? Can we influence it?
> >>>>>>>
> >>>>>>> prepare follows hw-params, and prepare can be called multiple times
> >>>>>>>
> >>>>>>> When you mean order of prepare callbacks, you mean w.r.t codec and dsp
> >>>>>>> backend dia link drivers ?
> >>>>>>
> >>>>>> Yes. Here we got a dependency from the cpu dai to be prepare()'d after
> >>>>>> the DP driver performs some actions, which were a part of hw_params()
> >>>>>> callback but were moved to be executed during prepare() callback.
> >>>>>>
> >>>>>> This leads me to two sets of questions:
> >>>>>> - In which order are those callbacks executed? Can we make the ASoC
> >>>>>>   enforce some order of DAI's prepare() callbacks?
> >>>>>>
> >>>>>> - More improtantly, isn't it a sympthom of DP driver (incorrectly)
> >>>>>>   performing too much in the .hw_params() / .prepare() callback? Should
> >>>>>>   we move some of the setup to the .audio_startup() instead? What is the
> >>>>>>   expected split between those callbacks?
> >>>>>
> >>>>> I have not looked at full dp sequences but, if prepare is the only place
> >>>>> when it enables the required clocks for audio block, then it is a
> >>>>> problem, we should do it early so that DSP can enable the required
> >>>>> configuration in prepare.
> >>>>
> >>>> As I wrote, previously it was done as a part of hw_params, which is
> >>>> also not optimal as hdmi-codec clearly defines both callbacks as
> >>>> optional, requiring only one of them. Do you know, what is actually
> >>>> required on the DP side for the DSP to be able to preapre()?
> >>>
> >>> Srinivas, did you have a chance to look at this? Or the .hw_prepare
> >>> ordering? I really don't want to land this fix only to face the same
> >>> issue because on some of the platforms .hw_prepare() callbacks will be
> >>> called in a different order.
> >>>
> >> Dmitry, few days back Krzysztof was enabling DP audio on T14s, and we
> >> have seen that the DSP is not happy and returning error 1 when we try to
> >> prepare the dp port. The exact reason is codec is not ready at that point.
> >>
> >>
> >> By adding this patch, Krzystof managed to get DP working.
> >> XElite platforms were working before 2fef64eec23a ("ASoC: hdmi-codec:
> >> Add a prepare) patch was merged, basically 2fef64eec23a broke what was
> >> working before.
> >>
> >> Am happy with this patch, better move to hw_params instead of prepare.
> > 
> > And I'm not happy with it :-)
> > 
> > hdmi-codec defines that one of the callbacks can be optional. We know
> > that at .hw_params time we don't have IEC 958 status bits, so we will be
> > programming incorrect audioframe.
> Your statement is contradicting with callbacks that are supported by
> hdmi-codec.
> 
> hdmi-codec uses IEC 958 status bits both in hw_params and prepare, if
> hw_params is not the right place, then that should be clarified and not
> correct for any of the codec drivers to use this callback.>

See https://lore.kernel.org/all/20210525132354.297468-6-maxime@cerno.tech/

> > Should some bits of code be moved to .audio_enable isntead? If so, which
> > bits?
> 
> I have not read the data sheet of msm dp block yet, but what it looks to
> me is the audio engine in the DP is powered off while dsp is trying to
> set it up.

Okay. What exactly is expected by the DSP? Which part, signal or clock
should be on?

-- 
With best wishes
Dmitry

