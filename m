Return-Path: <linux-kernel+bounces-757629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F86B1C47D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E2D560035
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008128A417;
	Wed,  6 Aug 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RM23ioCT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5F725C80D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476898; cv=none; b=RrH9QpT/IATyXY7qrIbSmVY92OtIFm9DhY/OpcfUjmKkpayXLLgpE1s0/YhuysfTC4prXyuOP8i+RdT9yxrnOIWpI2e8JA6U3IHIaAi8e+e+B5b3yy5lRUO8mYgGMnBThL3aYtxqswc/vJP/30NhRJ5Efo4qvExFcaYuFxHBLto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476898; c=relaxed/simple;
	bh=jDYzT7IM3p+MckKZ8/g1hs2VASH/YD3lYJmRuZ6le1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2YqoIgJIJhUluficapItLGvfvcE5n8fo9FRmI+ObNMEqD6XNIsfBOwFlAj8WhmqxNntec2eMXspszvTvXEMcw2ZPbmkbCzTS1Y9QX0/yp6pQzIMc6UdgFN4cFmpYK0vRT7hZWqZoCElWN3Av0fWbntaq/7eLW23Cief0bSoE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RM23ioCT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766P2tg021958
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 10:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HSbvjZwpGFDpPWe8VP+LR6gnGC3B/4MNmvmCPvzqWYo=; b=RM23ioCTEXqWxJiv
	oZ6rinWZFpVGcPLwuKPEVnjR01Oqy+82y0Jxr4dUNpeIZTHdCL3w1FoEfFk5DY9E
	joPXgOgzda++f5p5/fbLdvIYGrylP+jeXu8oDi+w2JkKB4Og7SU/HnWMN6Ksz/Sz
	uBhpHieaYLmELtRYtazH9Nj74gFrVp7DQztdXGn1au83OPEl91urQ+IuMN7KM8xx
	sZYgZ3i7CcVMMIy+9rbwsA6101LlgDyroOg5QrHwuZw7UDXWAt9CVom2+3YxLWd8
	aACM6o1h/uJz4vwu/t6/2XcD3PCTWsRk8Tyxesa3AkoAOb3XCHKve8laaj+JJ+Cc
	Y5zatQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8ab27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 10:41:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31bc3128fcso9900051a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 03:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754476895; x=1755081695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSbvjZwpGFDpPWe8VP+LR6gnGC3B/4MNmvmCPvzqWYo=;
        b=UUlcm64gFZYf4kwn+X53x7OZQ7SxHbhO17Y/6thhJvVMU6Ofeff8Bmg1KofDr/se21
         CnYKzQJ+M6tHHzdDpDZloL0VLTc2xRxYm0K0SF3Y7OkeyPgA1wcYfRkgYdQVrBNUdNVf
         Q77LtJ2Bm8eFpk9c1q1sirIBpi9I5xw4VqBjbx19sJq+vBCzXZJxJeAdWZPDw1iGeRCm
         yHJyyxd+9dZWRj3eI5Z1dFUEQhV3RxvmKx42PCyUUrDBRRJDSwEohyglJVzwaO8JYMA0
         qldH+s1cZNWq0g9BlhdDuvyVtcrDNQKMwgyKXWPdyKt3h/lXZr71YrPHOBdegmINXxb+
         9p5A==
X-Forwarded-Encrypted: i=1; AJvYcCV5ByTipNEg9Z2qLM+10q76BeaORo0+6cWAYh2CUFE4JK8ebfeSpkRgc21DuwmHePHTdtj6MXODMPS2iyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNCZOsDzj9B4q+XI1+SCwL+geaLODvwt5aj37xFPpB05oeoPv
	lBxIz6aA7T2myPwgmdvJFWdFSs1ueI7A8DWhQRpwqSwJ9Dl+Mko8ZTewybE4PeCLnJIXCFH4BEO
	c7sQkPLaQ1OUkWL9jxZyEvOqHxS4QdjR1NNFIEpBL0cbF8rbeLG1Qpcxfq8BY/mRPKkU=
X-Gm-Gg: ASbGncte6LdPW5F1X2gXNNBwg8DOLuWacxjkkbaynaa+mbEGraZix5KSfwx8P0hABD3
	f8WHRITjZG9saKHQ2vijeWBefuTLs6/5fYo7W+oS+MVU5I3ebJZhemy44fkgQz/iCk+pTiaTe5g
	0ozJw1Qk5EKTel7ikmzHbcTWtEi2X5+tOb9x0TtD/0XVAQcUlvHgm6DaWC7R29Ito82eg9pjtcK
	VvQ56H/O/dlwIs/v3arl35ZsZo9ZLGfdZ9QcnRmaRDxWvG6lqlEob2QPk9sgfqzNoGj+93glZnG
	6DsY9k3mH6k1lPkAhWdYiB5LkN5wC6A17p81NH8MjAB+r/hkF8mSRmlCjJDkMA==
X-Received: by 2002:a05:6a20:6a27:b0:23d:dfa5:e1b with SMTP id adf61e73a8af0-2403124d1b8mr3440797637.10.1754476894784;
        Wed, 06 Aug 2025 03:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoLG3sccJ6kVP+Nt8+1woUugLKi9IxsA45vBLw3UUAixCxgZTLZyjNGzgy7Nx1jyYEjvPNxQ==
X-Received: by 2002:a05:6a20:6a27:b0:23d:dfa5:e1b with SMTP id adf61e73a8af0-2403124d1b8mr3440764637.10.1754476894312;
        Wed, 06 Aug 2025 03:41:34 -0700 (PDT)
Received: from [10.92.206.236] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be718b2d6sm11308847b3a.56.2025.08.06.03.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:41:33 -0700 (PDT)
Message-ID: <ef29912e-fccc-437a-a2a3-18e9bd4f75c8@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 16:11:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/38] drm/msm/dp: remove dp_display's dp_mode and use
 dp_panel's instead
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-2-a54d8902a23d@quicinc.com>
 <kq6tb2wnte6v5z7uxgzc22kjwcevgvcdluzqbelvnbpbxlkotd@ltlv3u2guj4u>
 <1be2238d-7bb2-4ef9-9c7c-81dab0dcb559@quicinc.com>
 <4jrpa7iyygciuy2k4ydk7cpm5isdrddclljf6gbyvkiqc645tx@idyds4tkstkx>
 <9358a017-81ed-4db7-8e35-955922287c76@quicinc.com>
 <26f21464-022b-460a-92f2-0ea626cfd262@oss.qualcomm.com>
 <d55c1d20-fd55-4b43-b0cf-bcb2e7e3368e@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <d55c1d20-fd55-4b43-b0cf-bcb2e7e3368e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SanyZyBkFOUnGX0weUteDM10nYR127ra
X-Proofpoint-ORIG-GUID: SanyZyBkFOUnGX0weUteDM10nYR127ra
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX8M8YFADk1lK7
 oKArMxJ3ayDHNqp8tQZmXOLuI0RtqR1hyLIIf3VeekZpFcSybS0xVhTlorxSa8kjtDwOa5hMbk0
 U6XhqBE68ezTSBSUlHkFlg2ItC1U869piqtEPf0WW1MSUOVIhqOjHmJcZkWdXyIhjg7mhdbZjnT
 AYpc60+zu6vP67nUYLM+shns7TIgYkLCIe05G+cyGODfuZ5nBxjK+DH+UkWiTLJcnmy9LFOf823
 2470WQ4qQTqH3xe962riuZ7i+dVfSiMfvVQc3ujiHmzPtDuMoJEBvqMt78CSfVQZj4RQbBgeS89
 x+SkRS1LHt6CbExDN8wcsKE0gcude1aFPLgq9zUWdgZoU1iW88mBzX++reGbfybqTSb1NdatyTg
 9MQzsVG5
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6893315f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8
 a=0WhwKn8jsP_kjxG8mUgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 06/08/2025 14:52, Yongxing Mou wrote:
> 
> 
> On 2025/6/27 20:44, Dmitry Baryshkov wrote:
>> On 27/06/2025 11:40, Yongxing Mou wrote:
>>>
>>>
>>> On 2025/6/25 22:03, Dmitry Baryshkov wrote:
>>>> On Wed, Jun 25, 2025 at 08:34:18PM +0800, Yongxing Mou wrote:
>>>>>
>>>>>
>>>>> On 2025/6/9 20:48, Dmitry Baryshkov wrote:
>>>>>> On Mon, Jun 09, 2025 at 08:21:21PM +0800, Yongxing Mou wrote:
>>>>>>> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>>
>>>>>>> dp_display caches the current display mode and then passes it onto
>>>>>>> the panel to be used for programming the panel params. Remove this
>>>>>>> two level passing and directly populated the panel's dp_display_mode
>>>>>>> instead.
>>>>>>
>>>>>> - Why do we need to cache / copy it anyway? Can't we just pass the
>>>>>>     corresponding drm_atomic_state / drm_crtc_state / 
>>>>>> drm_display_mode ?
>>>>>>
>>>>> This part works as follows: .mode_set() copies the adjusted_mode into
>>>>> msm_dp_display_private->msm_dp_display_mode, and also parses and 
>>>>> stores
>>>>> variables such as v_active_low/h_active_low/out_fmt_is_yuv_420 
>>>>> and ... When
>>>>> @drm_bridge_funcs.atomic_enable() is called, it copies
>>>>> msm_dp_display->msm_dp_mode into dp_panel->msm_dp_mode and initializes
>>>>> panel_info in msm_dp_display_set_mode(). Then when go to
>>>>> msm_dp_ctrl_on_stream(), the parameters are updated into the 
>>>>> corresponding
>>>>> hardware registers.
>>>>
>>>> So, if we do everything during .atomic_enable(), there would be no need
>>>> to store and/or copy anything. All the data is available and can be 
>>>> used
>>>> as is.
>>>>
>>> Got it. Let me confirm—can we keep msm_dp_mode or drm_display_mode in 
>>> msm_dp_panel? Mabey debug node will use this ..
>>
>> Please don't. I really dislike storing drm_atomic_state-related 
>> variables in a non-state structure. I think it makes it easier to 
>> mistakenly update or to use a stale value.
>>
>> Debug code already prints modes in debugfs/dri/N/state. If we need any 
>> other state-related prints, they should go to the same file.
>>
> Hi, I got this point.. i go through the driver. since lots of funcs used 
> msm_dp_mode cached. so maybe it is not a very small change.. I’d like to 
> prioritize MST first, and then submit this patch once I got time..

Ack

> 
>>>>>
>>>>> This design has been in place since the first version of the DP 
>>>>> driver and
>>>>> has remained largely unchanged.
>>>>
>>>> Yes... The point is that you are touching this piece of code anyway,
>>>> let's make it nicer.
>>>>
>>> Agree with this point.
>>>>> Originally, the drm_mode would be passed in
>>>>> two stages: from msm_dp_display->msm_dp_mode to dp_panel- 
>>>>> >msm_dp_mode. Since
>>>>> in MST mode each stream requires its own drm_mode and stored in 
>>>>> dp_panel, we
>>>>> simplified the two-stage transfer into a single step (.mode_set() 
>>>>> do all
>>>>> things and store in msm_dp_panel). Meanwhile we modified the
>>>>> msm_dp_display_set_mode function to accept a msm_dp_panel parameter,
>>>>> allowing the MST bridge funcs' mode_set() to reuse this part code.
>>>>>
>>>>> The following patches:
>>>>> https://patchwork.freedesktop.org/patch/657573/?series=142207&rev=2 
>>>>> and
>>>>> https://patchwork.freedesktop.org/patch/657593/?series=142207&rev=2,
>>>>> introduce msm_dp_display_*_helper functions to help reuse common 
>>>>> code across
>>>>> MST/SST/eDP drm_bridge_funcs.
>>>>>
>>>>> If we drop msm_dp_mode from dp_panel and use drm_display_mode, it 
>>>>> might
>>>>> introduce a large number of changes that are not directly related 
>>>>> to MST.
>>>>> Actually i think the presence of msm_dp_display_mode seems to 
>>>>> simplify the
>>>>> work in msm_dp_panel_timing_cfg(), this patch series we want to 
>>>>> focus on MST
>>>>> parts, so would we consider optimizing them later?
>>>>
>>>> Sure... But then you have to change two places. If you optimize it
>>>> first, you have to touch only place. And it can be even submitted
>>>> separately.
>>>>
>>> Understood, that’s indeed the case. I just want to prioritize the MST 
>>> patch and have it merged first, since it involves changes to lots of 
>>> files. Thanks~~
>>>>>
>>>>> Thanks~
>>>>>>>
>>>>>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>>>>>> Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/msm/dp/dp_display.c | 76 +++++++++++++ 
>>>>>>> +-----------------------
>>>>>>>    1 file changed, 29 insertions(+), 47 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/ 
>>>>>>> drm/ msm/dp/dp_display.c
>>>>>>> index 
>>>>>>> 4a9b65647cdef1ed6c3bb851f93df0db8be977af..9d2db9cbd2552470a36a63f70f517c35436f7280 100644
>>>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>>>> @@ -92,7 +92,6 @@ struct msm_dp_display_private {
>>>>>>>        struct msm_dp_panel   *panel;
>>>>>>>        struct msm_dp_ctrl    *ctrl;
>>>>>>> -    struct msm_dp_display_mode msm_dp_mode;
>>>>>>>        struct msm_dp msm_dp_display;
>>>>>>>        /* wait for audio signaling */
>>>>>>> @@ -806,16 +805,29 @@ static int msm_dp_init_sub_modules(struct 
>>>>>>> msm_dp_display_private *dp)
>>>>>>>    }
>>>>>>>    static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
>>>>>>> -                   struct msm_dp_display_mode *mode)
>>>>>>> +                   const struct drm_display_mode *adjusted_mode,
>>>>>>> +                   struct msm_dp_panel *msm_dp_panel)
>>>>>>>    {
>>>>>>> -    struct msm_dp_display_private *dp;
>>>>>>> +    u32 bpp;
>>>>>>> -    dp = container_of(msm_dp_display, struct 
>>>>>>> msm_dp_display_private, msm_dp_display);
>>>>>>> +    drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, 
>>>>>>> adjusted_mode);
>>>>>>> +
>>>>>>> +    if (msm_dp_display_check_video_test(msm_dp_display))
>>>>>>> +        bpp = msm_dp_display_get_test_bpp(msm_dp_display);
>>>>>>> +    else
>>>>>>> +        bpp = msm_dp_panel->connector->display_info.bpc * 3;
>>>>>>> +
>>>>>>> +    msm_dp_panel->msm_dp_mode.bpp = bpp;
>>>>>>> +
>>>>>>> +    msm_dp_panel->msm_dp_mode.v_active_low =
>>>>>>> +        !!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
>>>>>>> +    msm_dp_panel->msm_dp_mode.h_active_low =
>>>>>>> +        !!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
>>>>>>> +    msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
>>>>>>> +        drm_mode_is_420_only(&msm_dp_panel->connector- 
>>>>>>> >display_info, adjusted_mode) &&
>>>>>>> +        msm_dp_panel->vsc_sdp_supported;
>>>>>>> -    drm_mode_copy(&dp->panel->msm_dp_mode.drm_mode, &mode- 
>>>>>>> >drm_mode);
>>>>>>> -    dp->panel->msm_dp_mode.bpp = mode->bpp;
>>>>>>> -    dp->panel->msm_dp_mode.out_fmt_is_yuv_420 = mode- 
>>>>>>> >out_fmt_is_yuv_420;
>>>>>>> -    msm_dp_panel_init_panel_info(dp->panel);
>>>>>>> +    msm_dp_panel_init_panel_info(msm_dp_panel);
>>>>>>>        return 0;
>>>>>>>    }
>>>>>>> @@ -1431,10 +1443,13 @@ bool msm_dp_needs_periph_flush(const 
>>>>>>> struct msm_dp *msm_dp_display,
>>>>>>>    bool msm_dp_wide_bus_available(const struct msm_dp 
>>>>>>> *msm_dp_display)
>>>>>>>    {
>>>>>>>        struct msm_dp_display_private *dp;
>>>>>>> +    struct msm_dp_panel *dp_panel;
>>>>>>>        dp = container_of(msm_dp_display, struct 
>>>>>>> msm_dp_display_private, msm_dp_display);
>>>>>>> -    if (dp->msm_dp_mode.out_fmt_is_yuv_420)
>>>>>>> +    dp_panel = dp->panel;
>>>>>>> +
>>>>>>> +    if (dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
>>>>>>>            return false;
>>>>>>>        return dp->wide_bus_supported;
>>>>>>> @@ -1496,10 +1511,6 @@ void msm_dp_bridge_atomic_enable(struct 
>>>>>>> drm_bridge *drm_bridge,
>>>>>>>        bool force_link_train = false;
>>>>>>>        msm_dp_display = container_of(dp, struct 
>>>>>>> msm_dp_display_private, msm_dp_display);
>>>>>>> -    if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
>>>>>>> -        DRM_ERROR("invalid params\n");
>>>>>>> -        return;
>>>>>>> -    }
>>>>>>>        if (dp->is_edp)
>>>>>>>            msm_dp_hpd_plug_handle(msm_dp_display, 0);
>>>>>>> @@ -1517,15 +1528,6 @@ void msm_dp_bridge_atomic_enable(struct 
>>>>>>> drm_bridge *drm_bridge,
>>>>>>>            return;
>>>>>>>        }
>>>>>>> -    rc = msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
>>>>>>> -    if (rc) {
>>>>>>> -        DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
>>>>>>> -        mutex_unlock(&msm_dp_display->event_mutex);
>>>>>>> -        return;
>>>>>>> -    }
>>>>>>
>>>>>> It should be done other way around: keep this call and drop
>>>>>> msm_dp_bridge_mode_set().
>>>>>>
>>>>> Emm as reply in last comments..
>>>>
>>>> Yep. Drop .mode_set, the callback is even described as deprecated.
>>>>
>>> Thanks, the documentation does state that.
>>>>>>> -
>>>>>>> -    hpd_state =  msm_dp_display->hpd_state;
>>>>>>> -
>>>>>>>        if (hpd_state == ST_CONNECTED && !dp->power_on) {
>>>>>>>            msm_dp_display_host_phy_init(msm_dp_display);
>>>>>>>            force_link_train = true;
>>>>>>> @@ -1604,33 +1606,13 @@ void msm_dp_bridge_mode_set(struct 
>>>>>>> drm_bridge *drm_bridge,
>>>>>>>        msm_dp_display = container_of(dp, struct 
>>>>>>> msm_dp_display_private, msm_dp_display);
>>>>>>>        msm_dp_panel = msm_dp_display->panel;
>>>>>>> -    memset(&msm_dp_display->msm_dp_mode, 0x0, sizeof(struct 
>>>>>>> msm_dp_display_mode));
>>>>>>> -
>>>>>>> -    if (msm_dp_display_check_video_test(dp))
>>>>>>> -        msm_dp_display->msm_dp_mode.bpp = 
>>>>>>> msm_dp_display_get_test_bpp(dp);
>>>>>>> -    else /* Default num_components per pixel = 3 */
>>>>>>> -        msm_dp_display->msm_dp_mode.bpp = dp->connector- 
>>>>>>> >display_info.bpc * 3;
>>>>>>> -
>>>>>>> -    if (!msm_dp_display->msm_dp_mode.bpp)
>>>>>>> -        msm_dp_display->msm_dp_mode.bpp = 24; /* Default bpp */
>>>>>>> -
>>>>>>> -    drm_mode_copy(&msm_dp_display->msm_dp_mode.drm_mode, 
>>>>>>> adjusted_mode);
>>>>>>> -
>>>>>>> -    msm_dp_display->msm_dp_mode.v_active_low =
>>>>>>> -        !!(msm_dp_display->msm_dp_mode.drm_mode.flags & 
>>>>>>> DRM_MODE_FLAG_NVSYNC);
>>>>>>> -
>>>>>>> -    msm_dp_display->msm_dp_mode.h_active_low =
>>>>>>> -        !!(msm_dp_display->msm_dp_mode.drm_mode.flags & 
>>>>>>> DRM_MODE_FLAG_NHSYNC);
>>>>>>> -
>>>>>>> -    msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 =
>>>>>>> -        drm_mode_is_420_only(&dp->connector->display_info, 
>>>>>>> adjusted_mode) &&
>>>>>>> -        msm_dp_panel->vsc_sdp_supported;
>>>>>>> +    msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
>>>>>>>        /* populate wide_bus_support to different layers */
>>>>>>> -    msm_dp_display->ctrl->wide_bus_en =
>>>>>>> -        msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : 
>>>>>>> msm_dp_display->wide_bus_supported;
>>>>>>> -    msm_dp_display->catalog->wide_bus_en =
>>>>>>> -        msm_dp_display->msm_dp_mode.out_fmt_is_yuv_420 ? false : 
>>>>>>> msm_dp_display->wide_bus_supported;
>>>>>>> +    msm_dp_display->ctrl->wide_bus_en = msm_dp_panel- 
>>>>>>> >msm_dp_mode.out_fmt_is_yuv_420 ?
>>>>>>> +        false : msm_dp_display->wide_bus_supported;
>>>>>>> +    msm_dp_display->catalog->wide_bus_en = msm_dp_panel- 
>>>>>>> >msm_dp_mode.out_fmt_is_yuv_420 ?
>>>>>>> +        false : msm_dp_display->wide_bus_supported;
>>>>>>>    }
>>>>>>>    void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>>
> 


-- 
With best wishes
Dmitry

