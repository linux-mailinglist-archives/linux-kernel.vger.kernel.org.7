Return-Path: <linux-kernel+bounces-876056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD4FC1AA7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A9756416D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28936275B05;
	Wed, 29 Oct 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivNmXOEX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475D2749C4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742150; cv=none; b=UNPCNp/bRmBAlu5bgCydAF9cpYW4HXmDKSMs9p5TwWlpA7gpC/ylQu3tlGQ7B1RHrqtnSA/gGEWI6BCtpLyZFMkaM/dlPOvF5LHnK779ZtyqEIMs9FQoa/eUAxoVjCbESSP9v9QQ1xsaBIOYdIQLzT/4n6dAZY3N+aCayhQWkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742150; c=relaxed/simple;
	bh=2+IpASvcKiq3HDIwMGzCLefruqRJAb0EaDfxrD0ZPFQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UReJfdPUVDLGn+i7rcCbcSP43vQCjtHpCMl3HHhVKrlYKVKqqt5dLsLue6wg5yk+Q1ZoPlWIpRLNdzZ+6vqZCyL/QQap3yBxqnt+hBesBdtkvjqsIJZIViUPgmbWDjLKTnq1S3UwVpEOszv1d5kEAd4WAAIqtsngPewwZLO3UCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ivNmXOEX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b64cdbb949cso1634866066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761742144; x=1762346944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epvoslRAzR95g5kEkCGn8E4piD8eZTMgDYxba/QgkMc=;
        b=ivNmXOEXneq1OxbFwSF4WLUEyMa9cEjIj6nqxb0dnB6hM8h2AFT41Lvsuxldy8eDku
         Z9GPSP0LhZE069bppK8i+VH0zu+rBGMxamDV7vGMfwPBP+ObjE2RZVCmjD1ALu+LX11Y
         O3NCw7dj+l51HXmN8W6QVlPlLAxO6pre39eux49kApjRLtpFzxmu7UcYH0F0WY/0zFjh
         X9FJC3TSyZ172i7TtNgTdhLwFUDvvg/4Qym/BRcN5YrceXk2US8+oWskefleW4em6Rcw
         pKmaQaMj7VBJCKamh75/n3GKfu8xhBYzHQd2V0pflSrtCdROyVRXJjxjcdGomepX+Wl9
         9m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761742144; x=1762346944;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=epvoslRAzR95g5kEkCGn8E4piD8eZTMgDYxba/QgkMc=;
        b=oRUJHZXoNMT1ZwvKr26GBKu0eIAKt6VZXCOuK31HY5Wvk/kilA73xJmjj1n4i5lhQ0
         xLs7K1MI8AaLDk4WGknRW8ZQpYGxXJqvsz7m9TbYEphiopBiYCokkihJ4MlZ21IUbRP2
         0W/wejHJocwZUaezXINjf1VVwuZc0D1YNQkQ159C3RZjotD5PLQygMCbhP0wfJZHnMws
         WY+qyj3MDDYZSGTjstKvsHY8ZAtH/npRUoQcnaXF8XlDj02eozDEmEXHF2hdqtkIM2w2
         ofZIdrWBCls0KizSLSsrswZnWRe6pE4LYu+GxpH08Zq8j1rG2R7bFIphGi6rML8sSQJz
         awfA==
X-Forwarded-Encrypted: i=1; AJvYcCV3MpxDir1wLoAG7hH0dXzRVUwBq2x3vJUfyPO370V5SSAfSxCIgJzYlitBT9rmbMPpzSsaOrSNcxGQiFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPyz7+NxPPkLyg6Sf1J7C9HGyZClH9LqbJ8Lc/d7F1Bxp7q/Q
	kp5ZZ2HjA+8cyGoQKDzw4CDp4jjY2Rfp3ZkqvCH7KItQpKzxoNQy6iq4oc2h+9CO0X8=
X-Gm-Gg: ASbGncvlyBGrPfRzbttPny807gwqTOPre1VbEe5+RE3uBYad0GZ0bKy/UBHTRuP/QRA
	YQ25Z619poS2SQMsKWTMHcFWmg5awNRMfKgwC6PGfXlGbhCZvmilFdpekJRcBKiYdXCvmLnQU/A
	w5AuTkWtuWonwzdmLDr1Sn0oIpbGk5yGuEhZNZZe4YaSenTvFFOUKL2aJJR3041DoNKIreNqOmx
	O18Q85OXZS8bWDG2rd+osKPmSZaa9/8G0Dn1Ks1owW00+uR6y3GNT1so19D6CzTlILv/BC+BZV4
	ajBchuSmg+9qVredG6EI7Wke2U8ZVfzb6Uuo3xxaTZxHJV8173W2uFPrShOEVk/DwPuGCu6jyFI
	aljdIYqiSODmr81ysHS7clOyuNuSJaPtdEpPKojYnLgOrypdsBLCEI0Vkbma4KHJTEuoGpUNIbU
	EfWe+nzeQlyuKOTuZQnrKn7QXquve5RNbQRCeuusMd+KRHNVvwxGHc9dgcRw1i
X-Google-Smtp-Source: AGHT+IHcG4LKDyrbB9tFryJhEA6/JjyPOxMR26v793Hdqd5h3OB8PE2OMNSaopJx02Zhxxs+Omnbzw==
X-Received: by 2002:a17:907:944a:b0:b65:abf2:417a with SMTP id a640c23a62f3a-b703d6034d6mr270327266b.64.1761742144231;
        Wed, 29 Oct 2025 05:49:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0? ([2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85359687sm1428207766b.23.2025.10.29.05.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:49:03 -0700 (PDT)
Message-ID: <ed323916-f0e4-4669-935c-6fc8ae6a9490@linaro.org>
Date: Wed, 29 Oct 2025 13:49:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
 <6381550a-4c1a-429d-b6c1-8c7ae77bf325@linaro.org>
 <da56lghirjcwesz4usdlfpttwcmvoql2h6bvjommoyfskjdkgk@hrlgx4ukt4aa>
 <09cbf40d-6536-4bda-94d6-5b45a5746962@linaro.org>
 <w4lwl34mtd7xv7it72nvomv6te2bcybisvirfdwzdazzqisd73@fvyusj6m5cb2>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <w4lwl34mtd7xv7it72nvomv6te2bcybisvirfdwzdazzqisd73@fvyusj6m5cb2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 13:30, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 10:40:25AM +0100, Neil Armstrong wrote:
>> On 10/28/25 20:52, Dmitry Baryshkov wrote:
>>> On Tue, Oct 28, 2025 at 09:42:57AM +0100, neil.armstrong@linaro.org wrote:
>>>> On 5/7/25 03:38, Jessica Zhang wrote:
>>>>> Filter out modes that have a clock rate greater than the max core clock
>>>>> rate when adjusted for the perf clock factor
>>>>>
>>>>> This is especially important for chipsets such as QCS615 that have lower
>>>>> limits for the MDP max core clock.
>>>>>
>>>>> Since the core CRTC clock is at least the mode clock (adjusted for the
>>>>> perf clock factor) [1], the modes supported by the driver should be less
>>>>> than the max core clock rate.
>>>>>
>>>>> [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c#L83
>>>>>
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - *crtc_clock -> *mode_clock (Dmitry)
>>>>> - Changed adjusted_mode_clk check to use multiplication (Dmitry)
>>>>> - Switch from quic_* email to OSS email
>>>>> - Link to v1: https://lore.kernel.org/lkml/20241212-filter-mode-clock-v1-1-f4441988d6aa@quicinc.com/
>>>>> ---
>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 35 ++++++++++++++++++---------
>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |  3 +++
>>>>>     drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 12 +++++++++
>>>>>     3 files changed, 39 insertions(+), 11 deletions(-)
>>>>>
>>>>
>>>> This test doesn't take in account if the mode is for a bonded DSI mode, which
>>>> is the same mode on 2 interfaces doubled, but it's valid since we could literally
>>>> set both modes separately. In bonded DSI this mode_clk must be again divided bv 2
>>>> in addition to the fix:
>>>> https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com/
>>>
>>>   From the docs:
>>>
>>>            * Since this function is both called from the check phase of an atomic
>>>            * commit, and the mode validation in the probe paths it is not allowed
>>>            * to look at anything else but the passed-in mode, and validate it
>>>            * against configuration-invariant hardware constraints. Any further
>>>            * limits which depend upon the configuration can only be checked in
>>>            * @mode_fixup or @atomic_check.
>>>
>>> Additionally, I don't think it is correct to divide mode_clk by two. In
>>> the end, the DPU processes the mode in a single pass, so the perf
>>> constrains applies as is, without additional dividers.
>>
>> Sorry but this is not correct, the current check means nothing. If you
>> enable 2 separate DSI outputs or enable then in bonded mode, the DPU
>> processes it the same so the bonded doubled mode should be valid.
>>
>> The difference between separate or bonded DSI DPU-wise is only the
>> synchronisation of vsyncs between interfaces.
> 
> I think there is some sort of confusion. It might be on my side. Please
> correct me if I'm wrong.
> 
> Each CRTC requires certain MDP clock rate to function: to process pixel
> data, for scanout, etc. This is captured in dpu_core_perf.c. The patch
> in question verifies that the mode can actually be set, that MDP can
> function at the required clock rate. Otherwise we end up in a situation
> when the driver lists a particular mode, but then the atomic_check
> rejects that mode.

A CRTC will be associated to 1 or multiple LMs, the LM is the actual block
you want to check for frequency. Speaking of CRTC means nothing for the DPU.

We should basically run a lightweight version of dpu_rm_reserve() in mode_valid,
and check against all the assigned blocks to see if we can handle the mode.

But is it worth it ? What did the original patch solve exactly ?

Do we have formal proof about which max clock frequency a complete HW setup is able to support ?

> 
> With that in mind, there is a difference between independent and bonded
> DSI panels: bonded panels use single CRTC, while independent panels use
> two different CRTCs. As such (again, please correct me if I'm wrong),
> we need 2x MDP clock for a single CRTC.

Any mode can use 1 or multiple LMs, in independent or bonded DSI. As I
said the bonded DSI with a 2x mode will lead to __exactly__ the same setup
as 2 independed DSI displays. And in bonded mode, you'll always have 2 LMs.

> 
>> So this check against the max frequency means nothing and should be
>> removed, but we should solely rely on the bandwidth calculation instead.
> 
> We need both. If you have a particular usecase which fails, lets discuss
> it:
> 
> - 2 DSI panels, resolution WxH, N Hz, the mode uses l LMs, m DSC units
>    and foo bar baz to output.
> 
> - The dpu_crtc_mode_valid() calculates the clock ABC, which is more than
>    the max value of DEF
> 
> - The actual modesetting results in a clock GHI, which is less than DEF

I don't understand what you need, in the current form the mode_valid will
accept the 2 DSI displays as independent, while using them as bonded will
use the exact same HW setup (resolution WxH, N Hz, the mode uses l LMs, m DSC units)
but the mode_valid with rejects it.

Neil

> 
>>
>> Neil
>>
>>>
>>>
>>>> I'm trying to find a correct way to handle that, I have tried that:
>>>> ===========================><========================================
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>>> index 48c3aef1cfc2..6aa5db1996e3 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
>>>
>>
> 


