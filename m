Return-Path: <linux-kernel+bounces-806372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A09B495AB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0AD3AE3DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A627430EF8E;
	Mon,  8 Sep 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVcDj2B2"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9B3112B2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349211; cv=none; b=PmKimQIfEXYsA086Lut/Hjb/C/EO9B6fGTt60Tw/qq9Uf677u8wCQ8t4ZZpu+kX2OEBHRlcaFmmCcenbMoxK0xg16EGsKWqSqiHywWkm2qoPc92HdvtKfywuSU8CVVGjMvqpht5lhLW/+Joxp/FCAHrcAWt8wJxJDUkhXToTZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349211; c=relaxed/simple;
	bh=DQ5xqqgu7m8HNjsRr8+111a6SfDAiRkaBt5C1QHesLE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TrEzlbFYHTdXhTkydadq/gPoUooR2ReLF7FxeRaY25p2WRnUsbBPUHJ/8UkyZ2xsvQ2cEJWwANRoEHvwGJk41A6rYgJvCqV+bXCAXQfQhiLPUTUmVU9gGS0bu1rlrGyuPhd5vnnes19NscJjLWuE8RCFcLYQWddtR8pDLXdJHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVcDj2B2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso26355485e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757349208; x=1757954008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hL4k/Psh7QV3Oz0BWAiE3A5PYnYKCxQRfGopalfqlC0=;
        b=XVcDj2B2sPcocDn+jEnl6XX1xTqzv8ROmHltr7pVhN8IBbxTqtK685pyYkYiYf40Gm
         pUsr5U0jMgboZcDJZP4unULB+FRIehhJrIiLtIpatiN/U8MXdy2sU9oDYunwVKrpEEv8
         SEZ2CMd+Jc0l/mj634+JLDnEOTMEZvvz6w2F+2cLJnMvTZKyxEMcMXrmq9OvlQOYqLAK
         PnJwUg2JmvHcBUZiehNBVMamtP4ySdcBUfRZxr6ZYWwQ7cTNZu/bqozXWM4H2DFmL7my
         tO+w2thyXYQ/B9q5aSW7k9csooXsJUqd1f4xpshwyA9Ken4d/2XPMCw1ES5K26CC4yTD
         90tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349208; x=1757954008;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hL4k/Psh7QV3Oz0BWAiE3A5PYnYKCxQRfGopalfqlC0=;
        b=KDIzRj+6gKge07AN6kOwNcVMgpOVy17Pkw813buWzsu+1qC4ZRDJxgEaT3aWQx5txi
         tyQKxML0qQ9QaTUW9UpFiTGY4zKLDF91v8F/1uT3otQCCqMqkiah6QdpBbteOI6t9bpz
         ldOt+NIa1EufhmZ+1J64uxXhVuZZhopo41xMdl5gQqhATNe9sVX+OndWuGccAHzBupUj
         pgBoe62fAQ/8c5PkP8d1v1zceyO85CVnRmL4NGguhxNv5uXmaBgIyGjzs4wcwXun7Vid
         yh/WrNSQUxdk0u4BWJzIDm4uuKF1SjxW/Aptoyp9sK7ueoRkrkk8a7kcfgYmiNFke6hk
         d2lw==
X-Forwarded-Encrypted: i=1; AJvYcCVi61bYjtAtaH7tpdOFS6SimTDEF/3upi/e7EuxWNoEdnSQIjManDhKuHI3FDJXcnn7Gl3zJhO/8CLZ4ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXcL0DEDyaNhSEvKFXP9rcEy1CzdTyMzPuLC+AmxBroxcmH+fr
	HrPRanaYOPklUi2odwA22FuPkXWuRES4s64OKpvA1vjoJbBvEkc5HA1gRGX5xmybvO0=
X-Gm-Gg: ASbGnct7a0psXTXm/qehY5IIw5XjtCZrmqD0N2j8lHOyxX1Fx6M27DVONafLbp+gFk6
	4iUZWnneR2BboZu99hoZafukS8yumlE5LuPTKzc8/YI1ce2LLLaWwcK6+hGPvzK1rXtF1IGdWFZ
	klK881zIisfxMwUZ4eliBM7DOl3KfQsm44SWx3CMDRdlUP9rcjHvo4o1btclcp2ij74Ig9hykIO
	n3KCY8muvcIMjotPUsro+79JpYWhYLMLY0ySUGOeEq270oUDQuHigRdb855uS/2FeiLzW86sF5f
	QxUP+gOBUc8BFcdDN+un1A/7LtgNhtUlMs0QnrrxZEGrOAv4IKlqJAn+Xpl+bcBR4n6qDBZxu8z
	rHtVvPz4ws0+nqv+0DKS5tqBSMsYqBbV7SXR7yfTzSdDzYrePE+EP5SqxwW0lKJiw9iP4kyq+I9
	0=
X-Google-Smtp-Source: AGHT+IHPshw4MFF3MtFW66lL56KGDr/ELsFHDavtEJzMD7lAGjt0usUJGeNNjmlUvzx4UEW9zDYZRQ==
X-Received: by 2002:a05:600c:3547:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-45dddecd814mr75926175e9.22.1757349207638;
        Mon, 08 Sep 2025 09:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:61c1:5d31:4427:381b? ([2a01:e0a:3d9:2080:61c1:5d31:4427:381b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd3aadbcesm176753155e9.17.2025.09.08.09.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:33:27 -0700 (PDT)
Message-ID: <f00dffa0-11d2-4e88-9770-c34682f770ff@linaro.org>
Date: Mon, 8 Sep 2025 18:33:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
 <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
 <33442cc4-a205-46a8-a2b8-5c85c236c8d4@oss.qualcomm.com>
 <b4f283ce-5be1-4d2f-82e2-e9c3be22a37f@oss.qualcomm.com>
 <269506b6-f51b-45cc-b7cc-7ad0e5ceea47@linaro.org>
 <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
 <df007b41-5c3d-4c69-81b9-27155485ccf9@oss.qualcomm.com>
 <pxigrjxtizcrhn4l25ph4yh4runebintfp4swqfiewfq5hqceo@g5cy3mdgjir5>
 <77db4861-4868-4110-8c31-eb2045ddbf4b@oss.qualcomm.com>
 <4fa44ec5-2792-45e3-af87-b3e4d2ed5d86@oss.qualcomm.com>
 <dad0a37f-38b7-48b4-983d-fba265bc66f1@oss.qualcomm.com>
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
In-Reply-To: <dad0a37f-38b7-48b4-983d-fba265bc66f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/09/2025 18:29, Akhil P Oommen wrote:
> On 9/8/2025 9:52 PM, Konrad Dybcio wrote:
>> On 8/18/25 9:17 AM, Akhil P Oommen wrote:
>>> On 8/16/2025 3:45 AM, Dmitry Baryshkov wrote:
>>>> On Thu, Aug 14, 2025 at 07:52:13PM +0200, Konrad Dybcio wrote:
>>>>> On 8/14/25 6:38 PM, Akhil P Oommen wrote:
>>>>>> On 8/14/2025 7:56 PM, Neil Armstrong wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 14/08/2025 13:22, Konrad Dybcio wrote:
>>>>>>>> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
>>>>>>>>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
>>>>>>>>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>>>>>>>>>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth
>>>>>>>>>>> along
>>>>>>>>>>> the Frequency and Power Domain level, but by default we leave the
>>>>>>>>>>> OPP core scale the interconnect ddr path.
>>>>>>>>>>>
>>>>>>>>>>> Declare the Bus Control Modules (BCMs) and the corresponding
>>>>>>>>>>> parameters
>>>>>>>>>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>>>>> ---
>>>>>>>>>>> Changes in v2:
>>>>>>>>>>> - Used proper ACV perfmode bit/freq
>>>>>>>>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-
>>>>>>>>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
>>>>>>>>>>> ---
>>>>>>>>>>>    drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>>>>>>>>>    1 file changed, 11 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/
>>>>>>>>>>> gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>>>> index
>>>>>>>>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>>>>>>>>                .pwrup_reglist = &a7xx_pwrup_reglist,
>>>>>>>>>>>                .gmu_chipid = 0x7050001,
>>>>>>>>>>>                .gmu_cgc_mode = 0x00020202,
>>>>>>>>>>> +            .bcms = (const struct a6xx_bcm[]) {
>>>>>>>>>>> +                { .name = "SH0", .buswidth = 16 },
>>>>>>>>>>> +                { .name = "MC0", .buswidth = 4 },
>>>>>>>>>>> +                {
>>>>>>>>>>> +                    .name = "ACV",
>>>>>>>>>>> +                    .fixed = true,
>>>>>>>>>>> +                    .perfmode = BIT(3),
>>>>>>>>>>> +                    .perfmode_bw = 16500000,
>>>>>>>>>>
>>>>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>>>
>>>>>>>>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)
>>>>>>
>>>>>> You are right that BIT(2) is GPU specific, but that support was
>>>>>> commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2), so lets
>>>>>> use that in Linux too.
>>>>>>
>>>>>> I know some docs show BIT(2) support, but lets not bring in untested
>>>>>> configurations.
>>>>>
>>>>> Eh, then let's get the docs fixed if you don't trust them because we can't
>>>>> work like that..
>>>>>
>>>>> FWIW this is information from per-platform RPMh cmd-db data
>>>>
>>>> If it comes from cmd-db, then we should be requesting it from the cmd-db
>>>> driver rather than hardcoding it here.
>>
>> No, what I meant is that there is a piece of configuration that reflects
>> what goes into cmd-db as its compiled and that's where I found that
>> information
>>
>>>
>>> Not really. This should be under the control of GPU driver.
>>> BIT(3) is correct for X1E.
>>
>> BIT(3) is for APPS, see the interconnect driver which also uses it.
>> This will create conflicts and may cause unvotes when some other
>> driver requests perf_mode through the ICC API, but the GPU is sitting
>> idle.

Yeah gpu will vote via it's own bcm drv interface and they will be agregated in the rpmh.

It's basically the whole point of this gpu bandwidth voting via gmu.

> 
> No. GPU vote goes via a different DRV. So it is independent. Anyway, I
> checked this further earlier. X1E platform doesn't implement any
> perfmode vote. So both BIT(3) and BIT(2) are no-op and are ignored by
> AOSS. ICC driver's vote too should be no-op on X1E.

So I can drop the ACV bcm or it's a compat for other SoCs ?

Neil

> 
> -Akhil.
> 
>>
>> Konrad
> 


