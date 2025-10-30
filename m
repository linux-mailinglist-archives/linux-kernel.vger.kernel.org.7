Return-Path: <linux-kernel+bounces-877961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEC1C1F6F3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07188420BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDCA223324;
	Thu, 30 Oct 2025 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXNOwtZI"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851782E7167
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818580; cv=none; b=EmsY8JDFmlZ3AwwAoOIdVZumJxhda+tyCjOn4L/DCQiNKetO8Mo3vRVu+pnNMIsKQ6zRSUrmIIxyMLvBZUdg1rZ79CnL8e9BoYVCwF+wnPghWpPvK+ukXZLptK9Lu5mWnA6jgZHVjAytyKBab87WV0laZZnPqSVzAlJ384lZ8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818580; c=relaxed/simple;
	bh=nI43meaPVv7LKFa6m5bLdpfOMMPXVjutydImS6u+Y10=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fzMm30Z4lyG1w58ymyW55zwGSzFv0GXwsGEAH760DDJiv2zRw81GKBjGAtYF8N7OGF/W32vx7bRHTF7ppbfHwWAUyMM4G+U4SBx9gyxxjEKRLvblwkKv+Em2/I3BdQib4tnkFYIk87ymYbYKe8fGMIvcnHZeidCi9wi0eDJuSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXNOwtZI; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475c9881821so12815725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761818577; x=1762423377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cZyc2F+uCR0RhVCjuRr38GEFiWRVmB/pYGXqMvYdqk=;
        b=vXNOwtZIZCdW7/UzCfP1tgR9FuCJfPunxuWLHvdJiZK9KMK0EfLVq0crtIJOik6o8Z
         inCsZ2QTSY3Mg6vbKyXL4xV6TJ9yLsPswOs3qrPEdal3Ba/Ew8wxYZr26BFXLsnxDtMp
         AyOicRiPcXloYpJvr5/2j4SfWnmmBQMjapk/jxcps7Rqy8eRPnAn//Z6tuSad7hvX93F
         jYmWnljM4EelSP9YwMRslmF9MVgbjFEf/zy5ZGdzbWKJAe2R+PFWcCO+Igax/1zebaxR
         5ySS6N4bs9bFe1zJIg9mVbR1Q8C7hMjIUJFctTG7X94edh0dwKa/NTUZE9Slkn5IMMB4
         F/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818577; x=1762423377;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7cZyc2F+uCR0RhVCjuRr38GEFiWRVmB/pYGXqMvYdqk=;
        b=U1KCq0fjpMnJ4fMG71SZzJpy9B7d0acjlG2NiKgY0d8LRBcYes39HreM/c/Vkcdou4
         CjhrUVAAlewQZIOQfzTupmnADyCFTOEX2Ga4MR8TdRYl5ak3IS93c/hXK7yVorwB90DP
         jxix16hdFw+tiMSgSq1spgXCMLcaVVr8RXbOfkeTCwoY+d0V9i8wxEWS8rISaQNiWW+o
         g08T/ppuXrgxRkuDK002jbMAHuLSEgbeNshYhGCSyKs+9Up8MCgcL4g46Q8qIl72dXsO
         C0rx0uGQ3IG9DHW5dwXvKHGQuJLC+YaZQppoxTUGWfGORg4EExpr5u3A8aVn/RAZI5vo
         448w==
X-Forwarded-Encrypted: i=1; AJvYcCU9uLIotVXiUFSXLLeQh+vFtXUNV5AtT7j5rtG4mbWsbrhN1RChDw0lgBSK43pp7XyQmE2n2oyRJvZRvds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRRiajMqpfTJX2/yh6aUcfc9zuCRIJM1C2BASADVASFAsHqFC
	1NtgIL7YvT0P9X2DnSGDgcVgMwYXo3uMI4tZFuLXiZ8z3q6xohU006qoSKthBVQoHh0lASMrUiR
	HQu3C
X-Gm-Gg: ASbGncs/SwiMcLdTHgFvqWTjsFW2Br3ekysURfmHJ2RKVxbcutOmx45Xee0jalUHKAU
	X3xA4veqxwi07A7x3uhUf2mvInlb2+4IVLTCcwhC1sTYqEcCpKY7OgHg7m4SUKuLwYt3mcLpKwn
	1AhZ1XllH1Cna3fhL1mVdmSmDgV0M2yhkJY0seXSbju12K/KhbNcvwRuDaJj81F4T9iEYqxyZ94
	Fz29WtheJkebPhEmlYkBKHdmyxEy8HIWWCCAUtSyCX/15PHFJL5S9KhasgXKk7RQpiUbW1eg5+d
	5lKv7gwwEigcQIrUUAEqlqIG/eiWG1yrXPiUJXPQP/ZLbbQHqtl8sMx0+/+25OiWfVB8qmDOEVK
	ga6AQhoQ26jGbROHrN+JYtA0VQZgYe7YgJgiDvz+AuA3AYC7pcaVzFhUUIhb4RVri+AgIfJjOMN
	szTp+WvOPGJHNjvC3E33LBe5yiq2p/O8ZguO+FFgI8rX5dMbEWSWyj
X-Google-Smtp-Source: AGHT+IFJBoa9YdfMbxiAk1SCPTzm/0RQQYulj8uAJ0Kt0YVpcYoKE4JtI4r67rxKu51doX5nxSQpwA==
X-Received: by 2002:a7b:cc0b:0:b0:477:f2c:291c with SMTP id 5b1f17b1804b1-477262baa1bmr18108475e9.14.1761818576676;
        Thu, 30 Oct 2025 03:02:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477? ([2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728ab375asm31884385e9.17.2025.10.30.03.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 03:02:56 -0700 (PDT)
Message-ID: <36f62e69-ef7c-4f22-93ab-32bceade3fd1@linaro.org>
Date: Thu, 30 Oct 2025 11:02:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC RFT] drm/msm: adreno: attach the GMU device to a
 driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251022-topic-adreno-attach-gmu-to-driver-v1-1-999037f7c83e@linaro.org>
 <5d6e7303-cc57-4a50-a9ad-b45d3c89d045@oss.qualcomm.com>
 <25e829f8-60b2-4b69-8d57-ded846b5206a@linaro.org>
 <c79c55fb-3aaa-4256-a71b-fa86cd0166f7@oss.qualcomm.com>
 <bed92353-da4e-4447-97d2-10e8a333e4e0@linaro.org>
 <a15e8316-96cb-452d-b2b8-731eeb6d25d3@oss.qualcomm.com>
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
In-Reply-To: <a15e8316-96cb-452d-b2b8-731eeb6d25d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 10:52, Konrad Dybcio wrote:
> On 10/24/25 11:11 AM, Neil Armstrong wrote:
>> On 10/24/25 10:55, Konrad Dybcio wrote:
>>> On 10/23/25 10:27 AM, Neil Armstrong wrote:
>>>> On 10/22/25 19:09, Konrad Dybcio wrote:
>>>>> On 10/22/25 2:44 PM, Neil Armstrong wrote:
>>>>>> Due to the sync_state is enabled by default in pmdomain & CCF since v6.17,
>>>>>> the GCC and GPUCC sync_state would stay pending, leaving the resources in
>>>>>> full performance:
>>>>>> gcc-x1e80100 100000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>>>> gpucc-x1e80100 3d90000.clock-controller: sync_state() pending due to 3d6a000.gmu
>>>>>
>>>>> Does this *actually* cause any harm, by the way?
>>>>
>>>> ?
>>>>
>>>>>
>>>>> For example on x1e, GMU refers to 2 GPU_CC GDSCs, GPU_CC refers
>>>>> to a pair of GCC clocks and GCC refers to VDD_CX
>>>>>
>>>>> and I see these prints, yet:
>>>>>
>>>>> /sys/kernel/debug/pm_genpd/gpu_cx_gdsc/current_state:off-0
>>>>> /sys/kernel/debug/pm_genpd/gpu_gx_gdsc/current_state:off-0
>>>>>
>>>>> /sys/kernel/debug/pm_genpd/cx/current_state:on
>>>>> /sys/kernel/debug/pm_genpd/cx/perf_state:256 # because of USB3 votes
>>>>>
>>>>> I'm not super sure where that sync_state comes from either (maybe
>>>>> dev_set_drv_sync_state in pmdomain/core?)
>>>>
>>>> The way we handle the GMU so far is wrong, it abuses the driver model.
>>>>
>>>> And this is a symptom, whatever the impact it has, it needs to be fixed
>>>> in a proper way.
>>>>
>>>> The sync_state is retained because the gmu device is never probed but
>>>> has some clocks and power domains attached to it, which is clearly wrong.
>>>
>>> Yes I agree, however I'm only debating the commit message claims of
>>> 'leaving the resources in full performance', which doesn't seem to be
>>> true
>>
>> OK so the wording may be a little bit extreme, perhaps something like:
>> the GCC and GPUCC sync_state would stay pending, leaving the unused
>> power domains enabled for the lifetime of the system.
> 
> The debugfs reads above suggest this is actually not happening

Oh yeah so let's do nothing, thanks for your very useful nitpick review.

Is there anyone going to review the actual change instead of the commit message wording ?

Neil

> 
> Konrad


