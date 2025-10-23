Return-Path: <linux-kernel+bounces-866936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94699C011AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E8A3A4435
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68446305078;
	Thu, 23 Oct 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QjYN0jDE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAA14AD20
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222290; cv=none; b=I1kMAXM8ALyypQqazm4SrhrCE7kO38GSIjePJogHeo/5XHo6pEawB/aweuUKIQP8GPDXTjBhgIo8Q3apUhSoAKuEdTm1Cc1PoxxiQznxkIHTmJ2vQweqFwzDG7kGBWLTEiAc5Gs9lgRikSJE/I66tgshbeCQ/yno2p0X0Yem9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222290; c=relaxed/simple;
	bh=xUH8q+2SHnhWkhQOLL+vv5l6h2lHGatDGUNWMUJNVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jotULPJ5GF9X+vZbib9yTBVKe4TWN8M26JhdYqeyQpsomWich+Ta6AckgfH5GbHxhXrf+JhwdMJ7+eZuwbpj/qCKq/d4/tl0dcSlBQQNhHA032aTGwhWoLe/JPRI9amXMLTE5j5/TYxOt6ld0zhCg6AYmtcfnH1dOb/hNeAXb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QjYN0jDE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6shsO018549
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uXuANgXqsKXGKeLuCYHue4m8
	RvWUrBUEqqVkisMKjFI=; b=QjYN0jDEbXXPW528UXuem7IR6xFnUhjh8YPcgqRP
	Zu/ImmCyd/69SomauaI7UnWGQGcDb7TWP28Nkv8t56md3HrrEdvDdZKDyOa7Tl10
	H+AWCoCZ1qq5cK/CNU7zDWtnBU0DBZb9IJYe6TKh6hgCS9i8r7hbQuO8sCwPcfEu
	QIFDSbD6ssAz+tNvxJRRg+NeVrCMPkzQCJg8Zv75Rk5ukbZiGX5rxAfD6QjWxQoP
	QW6KzXbyHcEXRV+5JEQHVgHyY5lZLkmVUBTltYEFLZ9yIsnli8ydKAVEFon9r22x
	UKiWqJ3Mh2bQo/9czrwlk7Zo8svrW5MD/CbaDVPIRHpOTg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08prkc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:24:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e884663b25so23185541cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761222286; x=1761827086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXuANgXqsKXGKeLuCYHue4m8RvWUrBUEqqVkisMKjFI=;
        b=OQFCrAB4BhhKwRsq7GyhY5zDjZ7k2JScVYLA4X9Vbgww0LikTDe3E5mQgdJJ5ya81I
         Do9zI7sPnluDR5y1IaBKbQBKdarbbY1Mfqtn+lMiPHlJC1gZJUVDgOXI5KEjBGAzKtY5
         SlrPBqul0akT9CJOiTeulVWBf0NOgygdRpUlfZfEHlz6J3yiXLklNNeY2DorP8f/No/k
         QcOxy4BhREWdocZTl926kuTxZxcPf/PiaqrW3YPE+sTtkreYiKndiW0iVFi9XYwHYWaM
         DDKCV/AlBbhJX7b0vM0+H3bxERIM+2WMoud1ruBtBP50aW/E1Y8zKPIO4jIMF6Pk5w4N
         jYPA==
X-Forwarded-Encrypted: i=1; AJvYcCW1Nd53424cC7mGtAGabAD6Is16jsgBsxm2h52evJhSq2xuqXHP0DnhY3Oy+3l8BI2pDmiKHKrUYzmNWog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9ItYGay5zW2alyWbwuI05gY6NM9sdhmTRCrXitVNmewpmNpG
	tqlfZS1Gn8WK2jyCiQBPbs6GX810GJw2W71usl0v1i1IYVjUx6U/lr9oyegHnNsWj525FgxgBzx
	L36s5s2Wyule6SA1oo6bfdeOjvPhC40DEA6qN+wMtD8OCKgpzX507629aCTAi6lR61tg=
X-Gm-Gg: ASbGnctJ8mq8IgVUr/dZVEqt6fsExsuTKbGPZ+HUZ+LAIybl7gfAoJuaW8MvIdomqyD
	/2QLfU65blzKZyJkZIWrQcuw6iNQ5KkebsYwHZ8XY/6O5WEHwUh4A9VppPZkYIz+00frU6Au00B
	jzBrX/81GWsos90lAGQzOAijx3Q9GDX/wCz4gxbbdPjMZGgLhRfOY//T4nVpWW0YDofbMlh1r2d
	pgvgztAcdD/22mbSTBC8+tIhcom4gQFYsLeOyGDQeu33G7QoVJtGnjMhgKXBi7511qTM7R+p74N
	I/w/bmZo4ib80GKOTgqI/sZvLPdMdr0akcryzmKvr2iwRyCAL8iywPCDvBKuKapPdX5I838ibfA
	F3BxnIHX59JYFP61ai1VJ8p3PnYcEkQJGpNWUXI8OBXYidW3SnvtJFeNPzjUhZH6DJE5F7pFdhG
	m93iO1QWh8GeR1
X-Received: by 2002:ac8:7f06:0:b0:4e8:a967:953e with SMTP id d75a77b69052e-4e8a9679e65mr251440981cf.24.1761222285495;
        Thu, 23 Oct 2025 05:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVfVx4NRvt1CYWR2h8fbEsyadOtBDfpsDEnBpaGw2vZHVqcYjFk6imZkMy/IOObieOX2c1UQ==
X-Received: by 2002:ac8:7f06:0:b0:4e8:a967:953e with SMTP id d75a77b69052e-4e8a9679e65mr251440601cf.24.1761222284973;
        Thu, 23 Oct 2025 05:24:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378d66bb005sm4458881fa.10.2025.10.23.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:24:43 -0700 (PDT)
Date: Thu, 23 Oct 2025 15:24:41 +0300
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
Message-ID: <zlu5x6v2xkum67prrtk26r7govenczuntjvlrflvdb6lpd2ssy@jgrnl6elophe>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <46q2pje4hginnm2wld6ejyo36hfkmkzydaa4qggx47gd2p4q4z@q6vmomtgqihv>
 <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
 <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
 <e69b23de-e9b6-4dfc-af01-7d2726dc23e4@oss.qualcomm.com>
 <bnrpfijh4rljdzroduqncfygysvgblljlhdpvq7ubajlbbwvwd@ohdmpjvpzj33>
 <f9c922f5-52af-45bb-a4ca-7ca80c0c3534@kernel.org>
 <7fwfxr7zqsaudselhru3jtjc2f7pdjvlaj2b464vgdlqcrljek@asci6y3ghq63>
 <jymgfmn5pje4qaslyaivzfm4m7ho774pid3uenj6yfrlrdk3ss@2nqojclepgsu>
 <f1338318-0135-415e-ab65-482cef20f919@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1338318-0135-415e-ab65-482cef20f919@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX2FoiItEkbXn1
 9BDjklnBikp6EKUhmo912HsqwNYuD9tF1PABn9yDgd+5YmfI0olMoZalYgHFue/XtcPD9ROXv+P
 S6auAwh1mSIeZ9fRyFpF024ezObxNzzTz+SZm7N2K49ecLw8TnPyvCMb7CUiVTR7dJ82AvzZR6Y
 TVYG6zSUxhmb0PhgH300tkRQD9xsCvYnFwjX93Rrea5a/hKH8mYFiVV78HGc+j9+xWgFUrGd8Sq
 4pAvKKtnZdSFoDtxwF7eK4s5Segbi9f2P/pQXK6IHEALZnjUZuBwJUYFkeG0Zf2SoL3FZN4uvIi
 VFLWlOIxYOPlIykB6/wCTJVtvLL4apyEL3GbAED7maXoxymwrGoE/mcympsVb74o0Sj2qk6ley+
 TFptc+G8egX44c+h0sBJLDBSmvdfJg==
X-Proofpoint-GUID: A1h6lNcV7DSddm3QKJIviSmWyIQnCXdo
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fa1e8e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=grqte4VfTkGWRzHCIIUA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: A1h6lNcV7DSddm3QKJIviSmWyIQnCXdo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

On Thu, Oct 23, 2025 at 12:48:59PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 10/23/25 12:43 PM, Dmitry Baryshkov wrote:
> > On Sun, Oct 05, 2025 at 06:29:20PM +0300, Dmitry Baryshkov wrote:
> >> On Sat, Oct 04, 2025 at 02:16:08PM +0100, Srinivas Kandagatla wrote:
> >>>
> >>>
> >>> On 10/3/25 6:02 PM, Dmitry Baryshkov wrote:
> >>>> On Fri, Oct 03, 2025 at 05:35:16PM +0100, Srinivas Kandagatla wrote:
> >>>>>
> >>>>>
> >>>>> On 9/26/25 4:09 PM, Dmitry Baryshkov wrote:
> >>>>>> On Fri, Sep 26, 2025 at 11:30:26AM +0100, Srinivas Kandagatla wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 9/25/25 5:28 AM, Dmitry Baryshkov wrote:
> >>>>>>>> On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
> >>>>>>>>> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> >>>>>>>>> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> >>>>>>>>> use msm_dp_audio_prepare instead. While userspace is still calling
> >>>>>>>>> hw_params to do audio initialization, and we get the following errors:
> >>>>>>>>>
> >>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >>>>>>>>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> >>>>>>>>> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> >>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> >>>>>>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >>>>>>>>> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> >>>>>>>>
> >>>>>>>> And a call to hdmi_codec_prepare() comes only at this place.
> >>>>>>>>
> >>>>>>>> Srini, Mark, when selecting to only implement .prepare for codec ops I
> >>>>>>>> was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
> >>>>>>>> hook"), which documents that IEC958 status bit is set after
> >>>>>>>> .hw_params(), so it's only visible during .prepare(). Is it okay to
> >>>>>>>> implement both callbacks? Or should the audioreach DAI driver be fixed
> >>>>>>>> somehow instead (I suppose it assumes that the port is available after
> >>>>>>>> .hw_params(), not sure if that assumption is correct)?
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >>>>>>>>> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> >>>>>>>>> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> >>>>>>>>> hdmi-codec driver can work with userspace alsa.
> >>>>>>>>>
> >>>>>>>>> Tested with Radxa Dragon Q6A.
> >>>>>>>>>
> >>>>>>>>> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> >>>>>>>>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> >>>>>>>>
> >>>>>>>> The patch LGTM, but I would wait for response from audio maintainers.
> >>>>>>>>
> >>>>>>>
> >>>>>>> The ordering matters in this case as we need clocks and audio
> >>>>>>> configuration on DP codec side to be setup before we start configuring
> >>>>>>> the dsp pipeline. Looks like that DSP is trying to setup DP endpoint
> >>>>>>> even before it is ready.
> >>>>>>>
> >>>>>>> q6apm prepare loads the dsp pipeline and starts configuring the
> >>>>>>> endpoints, if the DP endpoint is not ready dsp would throw an error.
> >>>>>>>
> >>>>>>> We might be able to pull in some dsp logs to confirm this, but I dont
> >>>>>>> have a setup that I can reproduce this issue.
> >>>>>>
> >>>>>> What would be your recommendation to proceed? Is it okay for the DAI
> >>>>>> driver to depend on the .hw_params enabling the clock? Also I see that
> >>>>>> the error regarding the clocks comes from .prepare callback too. What is
> >>>>>> the order of .prepare callbacks()? Can we influence it?
> >>>>>
> >>>>> prepare follows hw-params, and prepare can be called multiple times
> >>>>>
> >>>>> When you mean order of prepare callbacks, you mean w.r.t codec and dsp
> >>>>> backend dia link drivers ?
> >>>>
> >>>> Yes. Here we got a dependency from the cpu dai to be prepare()'d after
> >>>> the DP driver performs some actions, which were a part of hw_params()
> >>>> callback but were moved to be executed during prepare() callback.
> >>>>
> >>>> This leads me to two sets of questions:
> >>>> - In which order are those callbacks executed? Can we make the ASoC
> >>>>   enforce some order of DAI's prepare() callbacks?
> >>>>
> >>>> - More improtantly, isn't it a sympthom of DP driver (incorrectly)
> >>>>   performing too much in the .hw_params() / .prepare() callback? Should
> >>>>   we move some of the setup to the .audio_startup() instead? What is the
> >>>>   expected split between those callbacks?
> >>>
> >>> I have not looked at full dp sequences but, if prepare is the only place
> >>> when it enables the required clocks for audio block, then it is a
> >>> problem, we should do it early so that DSP can enable the required
> >>> configuration in prepare.
> >>
> >> As I wrote, previously it was done as a part of hw_params, which is
> >> also not optimal as hdmi-codec clearly defines both callbacks as
> >> optional, requiring only one of them. Do you know, what is actually
> >> required on the DP side for the DSP to be able to preapre()?
> > 
> > Srinivas, did you have a chance to look at this? Or the .hw_prepare
> > ordering? I really don't want to land this fix only to face the same
> > issue because on some of the platforms .hw_prepare() callbacks will be
> > called in a different order.
> > 
> Dmitry, few days back Krzysztof was enabling DP audio on T14s, and we
> have seen that the DSP is not happy and returning error 1 when we try to
> prepare the dp port. The exact reason is codec is not ready at that point.
> 
> 
> By adding this patch, Krzystof managed to get DP working.
> XElite platforms were working before 2fef64eec23a ("ASoC: hdmi-codec:
> Add a prepare) patch was merged, basically 2fef64eec23a broke what was
> working before.
> 
> Am happy with this patch, better move to hw_params instead of prepare.

And I'm not happy with it :-)

hdmi-codec defines that one of the callbacks can be optional. We know
that at .hw_params time we don't have IEC 958 status bits, so we will be
programming incorrect audioframe.

Should some bits of code be moved to .audio_enable isntead? If so, which
bits?

I agree that there is a regression and that this patch fixes it. I argue
that the fix is incorrect.

-- 
With best wishes
Dmitry

