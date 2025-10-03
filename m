Return-Path: <linux-kernel+bounces-841515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C2ABB790B
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED931B21270
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419AE2C21DB;
	Fri,  3 Oct 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAYwIsBv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC02C1593
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509323; cv=none; b=rj3JbwJTYxCW08ezu2dWb4AGf8AiuA5vuhEZtQeRZ0GtKIlQkIUx9pCKt2oUH3BbSezeEXb3u9LBtCpXwm6Lyi12RhvsLixYIOOj2aBEKjjLFMeT2fvogD00WHAerR57W/ZI2e2AhJYy18pgik455yLQoJvmj1fwK+EAmRaJZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509323; c=relaxed/simple;
	bh=W19mN3nWxvQRspPbP3F90kQcStjcNYfIZFu0akZMraU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tO9+EodDpHQTu8IDZFX24SVcvPYhYuOdtWB8fQE1YHBqNP5H/L3IeEuBDj0UfZ2VJT2+6UiZbNsWRVJNdxd8nBmYGvR0ggPamDtr01hggx5lt1sfMRDsNJTWkQ9DZx3CU7B4ooE2GN4xG9+Ai5Qq0TG1Dr3jHriV4VXs5eweaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DAYwIsBv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593A6Kg7006833
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 16:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BN+cZQE2ZHFMS/s2TQ1gBGDyzcU+J84X5eJjxhN4d/M=; b=DAYwIsBvKmf08Anr
	mMaZuN4CqYoRkXU8A/rRhgyQj/rgO8zVT5TEYrPKI4BrhVGyys9l/lAo8anED9xU
	JSX5P4CtMqR6/htjwRqPFxaUGs1HqRSjAbLhH+2QM9u8rx/tuWxO0CzXD6hqYckX
	VwKkwSuLBU9dHeN/EwwpOq/q2lo54zmwczfgwsNN2UnWr7TiOcajcRjcV+TSLh56
	kGaIOBRxXNtc6QguvQ10+TywfWqLSFNSZ4BBFuylO9JNj06LAen4MBjDmA4qk5ht
	6sypZnEtxE+scBWdjdfAoQG1fQVONxLxd4h+eY0fZ7BhgBNYlslV724pAXEYardb
	ErpOTA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851ucxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:35:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e0fcbf8eb0so59941021cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759509319; x=1760114119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BN+cZQE2ZHFMS/s2TQ1gBGDyzcU+J84X5eJjxhN4d/M=;
        b=oUvYg4fie5eR1nwH84yOtJNxQc2L1Ylq8oWorInixVo4eIjno1ppQYVQCr58TNbYSl
         jY+bOT83J5ps+u/HAqfVVUb1jWK6uuybChYPAZh2SwPZahZQlZNhlUkCULobS2wVsRfK
         jSXLrnOtE/cL03x/ieyWfMD4GzoZYl0t5Vgl6orWHAzd5AD+/Immd+WprCWiERiSMRhC
         AVSZis+6//rbUOK8j/ppUpMpWr2D+rPZa/IXGVyoj93OuP2OuIt3CjmtWsgI+0CNKEzO
         X1H3ywyGWmGe8+6a122evvW2Z3zcMwHWKHAUeq+p/d9Lusmjp0RcROYKBW8IJWHjdNnT
         FogA==
X-Forwarded-Encrypted: i=1; AJvYcCWNy55/IkPi4uWDB+YkrDUrEOq1bMNhWy//Pcdnn0LYLqsEmCqIrEzb3N37P5dWeVx7Swjo0zrrXt200+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pcj5bUxervUM8aRxJxgbeDXkdN+Cy07uTgAmKAnHmrg1LoHJ
	UN1WQX8NrthVlsl4eYHyPQFZjUq4pXMh1Yd/Mi3OSYA2QmQhSzBMsQh71n3hHUht48iwlDRsy4/
	CYOi/30ER3JCx1sEdP6usNIc4ILbFGLsi7eZlv3NZwlucm8VhaaXxvV4eEiprjEcCKrM=
X-Gm-Gg: ASbGncsw3vr0dgWNnpiEYMA8c6FggN9Ta2/FoBZMHSQ7rn/0CeuyVv01MQpnIcT+76y
	MXZvFZUrUgIaZfrPaQUYN+7QsTGaxlnphZhHf8LXQx3bPj3GwRSiqVGNHFOSdXft86s+dcTbjXD
	x4GpPmMSYhDvIjb1ERF9UPybP3jiHe4S8lRr6WLKdPpeRe0HVthvLc203tuB46u8AgMhuX2+PBS
	JoKhWCq5p62G6NdA4WngxFPOL0inZ5dfskZcQ3G/hlsine9P22ucXTAWvmdq5fseRzIUH37g2g5
	i2oFBqM7/CJTPeF2f3ty8/9g18+CGClq7cu9Nap0eZCL7w8EzNEUAmHsgC6D9ImeLlM0RhNq
X-Received: by 2002:ac8:57c3:0:b0:4d3:ee51:7819 with SMTP id d75a77b69052e-4e576b405aemr52572961cf.76.1759509318967;
        Fri, 03 Oct 2025 09:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5X64Ute70habcixAOvg2eexQGJ08nl+IYTPWnk0+F/5qtQEOhct1LHk+KKy0StXX4wfKJvQ==
X-Received: by 2002:ac8:57c3:0:b0:4d3:ee51:7819 with SMTP id d75a77b69052e-4e576b405aemr52572371cf.76.1759509318346;
        Fri, 03 Oct 2025 09:35:18 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e5b633afdsm81561215e9.2.2025.10.03.09.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 09:35:17 -0700 (PDT)
Message-ID: <e69b23de-e9b6-4dfc-af01-7d2726dc23e4@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 17:35:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
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
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <46q2pje4hginnm2wld6ejyo36hfkmkzydaa4qggx47gd2p4q4z@q6vmomtgqihv>
 <cc1afa21-8a66-4e0c-8fae-d0b07142b11d@kernel.org>
 <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <rydatk4grelhg6w57wwkqafq5ghccnsuiwvfqvvdv7qum5dg5a@scoc76ni7hue>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dffb48 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=98231OFmOk8s024PzkQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX91q4fkXYTMMX
 vRDKOjx1UAFtoqEdMupkHE2IxtwRnOlWjNMD7SvO2ot9+fVECIaovxIMec8IqJ6mXMUyewldXOY
 lpV5EyreA1s6CZNtzN/oDKhW6tu1rynqRZERpd5PfEpMMT/lF+3y276RGZlXNMGJVUNDtMLwwnN
 LZVejGSL7OlrXcPAhTZ/ubQ9HfnSW8yUMQkUTd/yxO9WmJci8HZs/jA6wfcKS9JqXyoMfIGi6sP
 /RMcdcFA6KaiO3unymEFET1LTg4Dbda1ELzgJKyqq0X9No54mmbkLq+iLF2UbRO76LBi8px5LGx
 sxjViLMny4Hi7z0hmiU/fpwWzCeBRho5H6jqMiC2y6MhEHBVcbnckU9ZtmkjVeWdGYtvLo0YtAG
 VGRMQ8UR1EslFgp/NRUOdnUAbiGRPA==
X-Proofpoint-ORIG-GUID: KqBKI6CvgfED8F98TxDqy6ldMF__5_II
X-Proofpoint-GUID: KqBKI6CvgfED8F98TxDqy6ldMF__5_II
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032



On 9/26/25 4:09 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 26, 2025 at 11:30:26AM +0100, Srinivas Kandagatla wrote:
>>
>>
>> On 9/25/25 5:28 AM, Dmitry Baryshkov wrote:
>>> On Thu, Sep 25, 2025 at 12:05:09PM +0800, Jianfeng Liu wrote:
>>>> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
>>>> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
>>>> use msm_dp_audio_prepare instead. While userspace is still calling
>>>> hw_params to do audio initialization, and we get the following errors:
>>>>
>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>>>> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
>>>> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
>>>> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
>>>> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
>>>> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
>>>
>>> And a call to hdmi_codec_prepare() comes only at this place.
>>>
>>> Srini, Mark, when selecting to only implement .prepare for codec ops I
>>> was following the commit 2fef64eec23a ("ASoC: hdmi-codec: Add a prepare
>>> hook"), which documents that IEC958 status bit is set after
>>> .hw_params(), so it's only visible during .prepare(). Is it okay to
>>> implement both callbacks? Or should the audioreach DAI driver be fixed
>>> somehow instead (I suppose it assumes that the port is available after
>>> .hw_params(), not sure if that assumption is correct)?
>>>
>>>>
>>>> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
>>>> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
>>>> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
>>>> hdmi-codec driver can work with userspace alsa.
>>>>
>>>> Tested with Radxa Dragon Q6A.
>>>>
>>>> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
>>>> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>>>
>>> The patch LGTM, but I would wait for response from audio maintainers.
>>>
>>
>> The ordering matters in this case as we need clocks and audio
>> configuration on DP codec side to be setup before we start configuring
>> the dsp pipeline. Looks like that DSP is trying to setup DP endpoint
>> even before it is ready.
>>
>> q6apm prepare loads the dsp pipeline and starts configuring the
>> endpoints, if the DP endpoint is not ready dsp would throw an error.
>>
>> We might be able to pull in some dsp logs to confirm this, but I dont
>> have a setup that I can reproduce this issue.
> 
> What would be your recommendation to proceed? Is it okay for the DAI
> driver to depend on the .hw_params enabling the clock? Also I see that
> the error regarding the clocks comes from .prepare callback too. What is
> the order of .prepare callbacks()? Can we influence it?

prepare follows hw-params, and prepare can be called multiple times

When you mean order of prepare callbacks, you mean w.r.t codec and dsp
backend dia link drivers ?

TBH, Am not sure, I did not find anything that was obvious from the code.



--srini



> 
>>
>>
>> --srini
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Link to v1: https://lore.kernel.org/linux-arm-msm/20250924085804.34183-1-liujianfeng1994@gmail.com/
>>>> - Use more detailed trace log in commit message.
>>>> - Drop the empty line between Fixex and SoB.
>>>>
>>>>  drivers/gpu/drm/display/drm_hdmi_audio_helper.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
>>>> index 7d78b02c1446..6ca1c7ad0632 100644
>>>> --- a/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
>>>> +++ b/drivers/gpu/drm/display/drm_hdmi_audio_helper.c
>>>> @@ -130,6 +130,7 @@ EXPORT_SYMBOL(drm_connector_hdmi_audio_plugged_notify);
>>>>  
>>>>  static const struct hdmi_codec_ops drm_connector_hdmi_audio_ops = {
>>>>  	.audio_startup = drm_connector_hdmi_audio_startup,
>>>> +	.hw_params = drm_connector_hdmi_audio_prepare,
>>>>  	.prepare = drm_connector_hdmi_audio_prepare,
>>>>  	.audio_shutdown = drm_connector_hdmi_audio_shutdown,
>>>>  	.mute_stream = drm_connector_hdmi_audio_mute_stream,
>>>> -- 
>>>> 2.43.0
>>>>
>>>
>>
> 


