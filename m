Return-Path: <linux-kernel+bounces-627493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEAFAA5174
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38BA1C06C62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A596261370;
	Wed, 30 Apr 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9UJTq2x"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1685157493
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746029972; cv=none; b=XqtJVTKZPXKl6WHR6Zw59z/bDLw7ESLkGF+cNE4uSi5IFjBeIQTFfRwVGBr9QHu+3NF7U8TcwFQJwmXtQvhd8ecccDpI8ICACvRRzSnp8urtI/B3ovO5b/6Iec83s9/1Qwwgu7FiC0IXkQ8YiSBxJWeWjxnibQ3p2TTh4bh5xl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746029972; c=relaxed/simple;
	bh=gxoBkfkS52yO8riHnDTwSWFiE8lVSuhhDftXhP+C4jc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HCzwF+3qwPu2GxbX30DWBstox/uyjI8nspwMnz5qhKrmViEI6P3MSWY+MDkS1HXp+ukt5ZqhdoVKD6QK1GxY5Q+bPF4tQdgTwcQS81ISP2yGHzfKtzHXRSTvo+mBwfKoJ2jiAJ4rJGuxmepFkmKKycdd6Rpt3BW3L+01D+Qb5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9UJTq2x; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso5140041f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746029968; x=1746634768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7Se6Bcet/jD1trRSgYmZmnWG6hjkxwW1xZsDPD2EnI=;
        b=o9UJTq2xrePaeSWMBeOJL2/uVN3yys9rWraQ3xN1nVVpQpuhmD+0gqRjc0UONFMc6u
         VuY4GPfm+viDo2yn5j4T1LdUlBxJJavlFdSkMAAAXs1enVBG2U32vTO6u/X36NNF+sfd
         iJPqA5l2dtH1tMmIFcuCBgDPlykrVdj7sNxmdb6q5N6vC6FNYcHScGMf4xJmxwYioo9w
         9NJAQGtSSt0NW2IZZbN/7/4FxPbC1oe1uolcwLRPT6XYVr8FgPHiOnT0A20fBdrFLUAO
         kjltg9QOBD3ARu8nk6IflSxxlGkiazMZvBadbZMI++iZAIDd3D/cAq2V6aTc/EuX8V1F
         xDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746029968; x=1746634768;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g7Se6Bcet/jD1trRSgYmZmnWG6hjkxwW1xZsDPD2EnI=;
        b=bDIg0tF+g0usr3mPcbnCJncHvtUSC3PaU15scWIEkBwmRIbODl/0BJDvY/DWFxAIyo
         7eZSxFZHXoSRS7K5dFrsEjDruoRMFLzM5SL26VWDaj3mnl9q1MVmGCV0FpQUy43Cqjf+
         cCAFBSyFagTpMefmBzpIB6rjHzul26SJy5m7CNNcsRbjKXAJKENKDkltpo1SzM3Grel1
         GMqVjo5Mr40/rObF+SuQSjn6Wrucz6gWZPPe0ChGDIMci8PMPL6uvCU9VzWbbrsNqXjX
         DMoko7Casc1WkKCG20SnElCJ3aXCo21YiJli1gpEgs6+UyKhXkNSh0rOybuVUXHcNoIf
         EkNA==
X-Forwarded-Encrypted: i=1; AJvYcCUYoeop9t7uCAUaoOVpg4xCBb7sTp+ahnmSD3HgSWHYLTGWyl6H/woSs3jZos9mKBnoT/b14qKLOIWJYQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB5e3uN374RCNKli+hKBwnQvsldmvl5vEtL3Y1Mn3X3rnTkBG4
	9xpKhGanilHr6R6KcqfpXDJln8ckXu14sZ6BiGDS2mG0328rVgVMFUxixA7MDsE=
X-Gm-Gg: ASbGncue1TlZs4u+9pSALgmf8I5DAxmR5Tq1SRtaVwF7tuLRyh+kfvTRZyYoHd8661C
	aCyTvFg88cfauUfRj0wZdmVsPWQiax/Zio2sWJUJCTXlnJhwUxJGUd6VTPSL2af69Q9FbineXwz
	moGw3OIlB/HfkWtLwLI3vFMLMBUh0yQc09uu18YJvZ/XjM0DAtf0w15jIE9rZkxPR5rKgWyU8gq
	kxPoh9umlblrx0gHy1jV6hXc6NgysQUSC+oiaBK1LJfNttsOxjili30aiJndswbhQ8JDMopentk
	xtaxGvYfKCgSHWDs775pT/RINhgtwOH/8RtlCua5GuN2XB/urNcxlktrC0vaG258nWhG0IAVUbe
	XaYikARSbEGJmxhw2RQ==
X-Google-Smtp-Source: AGHT+IFPiRzjJ1dXuW8JSjggrKqr4T+OSJprmTDKCcWUMBgJRLMdsXrx1svViVBvRkDmlT4kDww2eg==
X-Received: by 2002:a05:6000:1785:b0:3a0:80dd:16d5 with SMTP id ffacd0b85a97d-3a08ff555bemr3020991f8f.55.1746029967967;
        Wed, 30 Apr 2025 09:19:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b3d6:213c:5c50:7785? ([2a01:e0a:3d9:2080:b3d6:213c:5c50:7785])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a07dbd6ea1sm13319523f8f.7.2025.04.30.09.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:19:27 -0700 (PDT)
Message-ID: <63105bce-6b8e-4b99-bca1-3741f27ea25a@linaro.org>
Date: Wed, 30 Apr 2025 18:19:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT v6 2/5] drm/msm/adreno: Add speedbin data for SM8550 /
 A740
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20250430-topic-smem_speedbin_respin-v6-0-954ff66061cf@oss.qualcomm.com>
 <20250430-topic-smem_speedbin_respin-v6-2-954ff66061cf@oss.qualcomm.com>
 <13cd20c6-f758-45ff-82d1-4fd663d1698c@linaro.org>
 <886d979d-c513-4ab8-829e-4a885953079a@oss.qualcomm.com>
 <b838f9bd-0537-4f8d-b24b-d96700d566c8@linaro.org>
 <98a4ad20-c141-4280-801e-015dafd1fb39@oss.qualcomm.com>
 <a26213ec-808f-4edf-bb0d-ab469ee0a884@linaro.org>
 <281ab1b6-498e-4b29-9e15-19b5aae25342@oss.qualcomm.com>
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
In-Reply-To: <281ab1b6-498e-4b29-9e15-19b5aae25342@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/04/2025 17:36, Konrad Dybcio wrote:
> On 4/30/25 4:49 PM, neil.armstrong@linaro.org wrote:
>> On 30/04/2025 15:09, Konrad Dybcio wrote:
>>> On 4/30/25 2:49 PM, neil.armstrong@linaro.org wrote:
>>>> On 30/04/2025 14:35, Konrad Dybcio wrote:
>>>>> On 4/30/25 2:26 PM, neil.armstrong@linaro.org wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 30/04/2025 13:34, Konrad Dybcio wrote:
>>>>>>> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>>
>>>>>>> Add speebin data for A740, as found on SM8550 and derivative SoCs.
>>>>>>>
>>>>>>> For non-development SoCs it seems that "everything except FC_AC, FC_AF
>>>>>>> should be speedbin 1", but what the values are for said "everything" are
>>>>>>> not known, so that's an exercise left to the user..
>>>>>>>
>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 8 ++++++++
>>>>>>>      1 file changed, 8 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>> index 53e2ff4406d8f0afe474aaafbf0e459ef8f4577d..61daa331567925e529deae5e25d6fb63a8ba8375 100644
>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>> @@ -11,6 +11,9 @@
>>>>>>>      #include "a6xx.xml.h"
>>>>>>>      #include "a6xx_gmu.xml.h"
>>>>>>>      +#include <linux/soc/qcom/smem.h>
>>>>>>> +#include <linux/soc/qcom/socinfo.h>
>>>>>>> +
>>>>>>>      static const struct adreno_reglist a612_hwcg[] = {
>>>>>>>          {REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
>>>>>>>          {REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
>>>>>>> @@ -1431,6 +1434,11 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>>>>              },
>>>>>>>              .address_space_size = SZ_16G,
>>>>>>>              .preempt_record_size = 4192 * SZ_1K,
>>>>>>> +        .speedbins = ADRENO_SPEEDBINS(
>>>>>>> +            { ADRENO_SKU_ID(SOCINFO_FC_AC), 0 },
>>>>>>> +            { ADRENO_SKU_ID(SOCINFO_FC_AF), 0 },
>>>>>>> +            /* Other feature codes (on prod SoCs) should match to speedbin 1 */
>>>>>>
>>>>>> I'm trying to understand this sentence. because reading patch 4, when there's no match
>>>>>> devm_pm_opp_set_supported_hw() is simply never called so how can it match speedbin 1 ?
>>>>>
>>>>> What I'm saying is that all other entries that happen to be possibly
>>>>> added down the line are expected to be speedbin 1 (i.e. BIT(1))
>>>>>
>>>>>> Before this change the fallback was speedbin = BIT(0), but this disappeared.
>>>>>
>>>>> No, the default was to allow speedbin mask ~(0U)
>>>>
>>>> Hmm no:
>>>>
>>>>       supp_hw = fuse_to_supp_hw(info, speedbin);
>>>>
>>>>       if (supp_hw == UINT_MAX) {
>>>>           DRM_DEV_ERROR(dev,
>>>>               "missing support for speed-bin: %u. Some OPPs may not be supported by hardware\n",
>>>>               speedbin);
>>>>           supp_hw = BIT(0); /* Default */
>>>>       }
>>>>
>>>>       ret = devm_pm_opp_set_supported_hw(dev, &supp_hw, 1);
>>>>       if (ret)
>>>>           return ret;
>>>
>>> Right, that's my own code even..
>>>
>>> in any case, the kernel can't know about the speed bins that aren't
>>> defined and here we only define bin0, which doesn't break things
>>>
>>> the kernel isn't aware about hw with bin1 with or without this change
>>> so it effectively doesn't matter
>>
>> But it's regression for the other platforms, where before an unknown SKU
>> mapped to supp_hw=BIT(0)
>>
>> Not calling devm_pm_opp_set_supported_hw() is a major regression,
>> if the opp-supported-hw is present, the OPP will be rejected:
> 
> A comment in patch 4 explains that. We can either be forwards or backwards
> compatible (i.e. accept a limited amount of
> speedbin_in_driver x speedbin_in_dt combinations)

I have a hard time understanding the change, please be much more verbose
in the cover letter and commit messages.

The fact that you do such a large change in the speedbin policy in patch 4
makes it hard to understand why it's needed in the first place.

Finally I'm very concerned that "old" SM8550 DT won't work on new kernels,
this is frankly unacceptable, and this should be addressed in the first
place.

The nvmem situation was much simple, where we considered we added the nvmem
property at the same time as opp-supported-hw in OPPs, but it's no more the
case.

So I think the OPP API should probably be extended to address this situation
first, since if we do not have the opp-supported-hw in OPPs, all OPPs are safe.

So this code:
	count = of_property_count_u32_elems(np, "opp-supported-hw");
	if (count <= 0 || count % levels) {
		dev_err(dev, "%s: Invalid opp-supported-hw property (%d)\n",
			__func__, count);
		return false;
	}
should return true in this specific case, like a supported_hw_failsafe mode.

Neil

> 
> Konrad


