Return-Path: <linux-kernel+bounces-757879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026F6B1C7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003007ACB1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E928DB4C;
	Wed,  6 Aug 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XChj0wWO"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9F215F4A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491244; cv=none; b=LG92MJpro8xEvSyVcplspDtb9GL+zcGIVI1El5miRsUhhCz8EN6VMgYLQMsb6FHOXrVnZK6ly2yqNc0hoiZF2tesYZqfZMSVnriumgfnVQEKLwBiWrpOJi9geQSeApkelFGbqsyk97tY1+zaEQdRXTxgWHCtPSBoZx0JG+NMW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491244; c=relaxed/simple;
	bh=Yq4+Yg+s7G/DTrQrYYUyQAh0fZYUk/b+sNrvPufl5IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLRxtNyVSG3WkDHrMBC5XaA3Shs4EBaaG/nh3tDqWlcdElZMYLyOaEQDVvhpIb9BDHS+iGfiixHE9AhvfGdTtvJ4MlIXENoxg41YuzRvfNvmeasMSB4ueIA16nLJZBfzxY5cM7jJ+b6NCbQYdAxb4ScWtJFj8c2Ne9Mum+9tZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XChj0wWO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b780bdda21so4747614f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754491241; x=1755096041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxj2Kb4c2cHaAqMwhewT0o+Azovwd0DMlxDKMvCajBE=;
        b=XChj0wWO5Tp4Yp421qM5Os0QsrX7SdEl9VRJA3a1n7Fa2Q/FwXbXREFqRSpwJPm7g6
         2rjZPWqHSjzJP0gFVlkBRDzDVG523hvv0XoK2glebcjz07evPic8e6izW4gHzMrvnDqe
         DmpIe/aRX+A2ZSS9cDNV4DrVOeMA+kP7TCcMM7ck83iIQb/xBikRncydIXEFRojyo/1W
         235y0n6kzKyS6ghZ6I18BmJ5fzunCUZ67JoMrjbQzV+iYR8nw4YKu8G2lMZ9rn5+AL7g
         Bg1/+I1IBRxypAB/A+ZEP2wUlHN8x++0jszdwcK231f7twOnKHlhdaf3kko6WqXFuUKE
         +IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491241; x=1755096041;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxj2Kb4c2cHaAqMwhewT0o+Azovwd0DMlxDKMvCajBE=;
        b=fyIPb8ADs9TSvQfS+UKTK/Zx95NT8AGqkz2qCELigFIvj3N1eE6RxkIIQs9/e2jppT
         CoQqZYdcO2kOe5Hl/RDU53ZXKa85Yuf6WxfpCWIGQWP572g8sBjV0/7NWWFSqH95C0fe
         ZZGebGRPpdN6TpMs+6+s9b/eI3ox053UiwqGQ9d70rZCo9DXlNufKSDYrjjWW700J4kJ
         IvkrH7cOxRkmgv+RxS/GIXqeI62w37SwHZFRP/s9XRWEXFZ6S8NQxOBolREsagLyt8LN
         IcTmofX1S5Hi0F+9ZDfpumhEjncmBj1z3r5L9CnWca5wgQfXNENWn8POG52NtxP883vq
         ZMWA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJQjTNd79yd0h7p1mSzEBh6q52rWZ4gjDfgR3s8si6LkvlmbOq/bFxvYsceYuRsn+CopBkXEN0EEHfYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOsn5k7U4h7col2AazDkStTgsnkKJ7oOSQOPv+KTnU9F5w50Wg
	4jhc9N0FTUxZJrnbrUyMb0x02QgEQ4eXT5tr7MRXzd7/6fzG96wQy9CIu/GUCzUxUTM=
X-Gm-Gg: ASbGncuPR/lNGBDBkQ8vJ936LNNTVkJt/pafNCqrJZdp/QxYN1kkp2I9kEl4J/+d4LV
	/fsus5ktVJfv+DHqOHKU90sNe7X5xHC0dKWnsbNvO/uKpPGLmW1lDrqk7rbTcozXQMgwpfIFfZA
	Uxj8e8zZAg4NiIUnzcRwM7mwviIzEr/cdEmnyc8wjHwTfawUezDFNKFFb2vjW5KYh0DWGYaiAJD
	CHrToFaASzx6lVgmESpD3uA2ejqCKD97nQkoTGOGAGxuZqhuz4DOZOOJrbMWVhSq1gTYPtW8J99
	kqiE6K5Eq2D/euJhIS5uYQzSuCfos1T+ExSc67+T2rs5DUR4wE5fQHrJB7tPBd2Arbl4mZwedxx
	lGO1pugYVG/0prtQTVW44OHeJsIX1+yWHoWNx/oicqHI2g6KdkvxtLcMvW4WaJ5YEUEfxwopiJu
	U=
X-Google-Smtp-Source: AGHT+IE7HUmcdn6gMWzXwLK4pq9FeM3DNXOHuvSf2VKplEZd8b0DggW2fzVBdDHM8SmnOeSMsbaHBw==
X-Received: by 2002:a05:6000:18a9:b0:3b7:7ded:ddb1 with SMTP id ffacd0b85a97d-3b8f492004amr2533955f8f.33.1754491240547;
        Wed, 06 Aug 2025 07:40:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:96df:e381:55b8:1990? ([2a01:e0a:3d9:2080:96df:e381:55b8:1990])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95e9sm22963623f8f.16.2025.08.06.07.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 07:40:39 -0700 (PDT)
Message-ID: <4f67b4f5-3dfe-4f5b-81a9-24fa7009b9af@linaro.org>
Date: Wed, 6 Aug 2025 16:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/2] phy: add new phy_notify_pmstate() api
To: Peter Griffin <peter.griffin@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, kernel-team@android.com,
 William Mcvicker <willmcvicker@google.com>
References: <20250703-phy-notify-pmstate-v2-0-fc1690439117@linaro.org>
 <20250703-phy-notify-pmstate-v2-1-fc1690439117@linaro.org>
 <e2lhm237c3xtbdjux2wuesq5fwu7nky3w7oq2fnsgn2pqcg5kh@xhxktriooyes>
 <aICKM-ebp9SMAkZ_@vaman>
 <yaz4ozb55t3pkwd2gj4l4d2hdspdcsqjm2dfsux7lfdxy6lxjl@uae2qz2vjo64>
 <CADrjBPpE0ab3MD6tAS-JQns1HaPfmngRhixkUpqqAfj_2D5nmw@mail.gmail.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <CADrjBPpE0ab3MD6tAS-JQns1HaPfmngRhixkUpqqAfj_2D5nmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/07/2025 12:21, Peter Griffin wrote:
> Hi Vinod, Mani & Neil,
> 
> Thanks a lot for the valuable review feedback.
> 
> On Wed, 23 Jul 2025 at 09:04, Manivannan Sadhasivam <mani@kernel.org> wrote:
>>
>> On Wed, Jul 23, 2025 at 12:37:31PM GMT, Vinod Koul wrote:
>>> On 22-07-25, 22:04, Manivannan Sadhasivam wrote:
>>>> On Thu, Jul 03, 2025 at 02:03:22PM GMT, Peter Griffin wrote:
>>>>> Add a new phy_notify_pmstate() api that notifies and configures a phy for a
>>>>> given PM link state transition.
>>>>>
>>>>> This is intended to be by phy drivers which need to do some runtime
>>>>> configuration of parameters during the transition that can't be handled by
>>>>> phy_calibrate() or phy_power_{on|off}().
>>>>>
>>>>> The first usage of this API is in the Samsung UFS phy that needs to issue
>>>>> some register writes when entering and exiting the hibernate link state.
>>>>>
>>>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>>>> ---
>>>>>   drivers/phy/phy-core.c  | 25 +++++++++++++++++++++++++
>>>>>   include/linux/phy/phy.h | 25 +++++++++++++++++++++++++
>>>>>   2 files changed, 50 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>>>> index 04a5a34e7a950ae94fae915673c25d476fc071c1..0b29bc2c709890d7fc27d1480a35cda6a826fd30 100644
>>>>> --- a/drivers/phy/phy-core.c
>>>>> +++ b/drivers/phy/phy-core.c
>>>>> @@ -520,6 +520,31 @@ int phy_notify_disconnect(struct phy *phy, int port)
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(phy_notify_disconnect);
>>>>>
>>>>> +/**
>>>>> + * phy_notify_pmstate() - phy link state notification
>>>>
>>>> 'pmstate' doesn't correspond to 'link state'. So how about,
>>>> phy_notify_link_state()?
>>>>
>>>> s/phy/PHY (here and below)
> 
> will fix
> 
>>>>
>>>>> + * @phy: the phy returned by phy_get()
>>>>> + * @state: the link state
>>>>> + *
>>>>> + * Notify the phy of some PM link state transition. Used to notify and
>>>>
>>>> Link state change is common for the PHY. So remove 'PM'.
>>>
>>> Is it really link or phy state?
> 
> I think it is likely both link and phy state.
> 
> Looking at the wording in section '9.5 Hibernate' in mipi unipro 1.8
> spec we have phrases such as
> 
> 9.5 Hibernate "Hibernate is a UniPro state in which the PHY is in the
> HIBERNATE_STATE, and the UniPro stack keeps only a minimal set of
> features active."
> 
> 9.5 Figure 99 describes Link hibernation where one Device, typically a
> Host Device, initiates Link hibernation with a peer Device.

So this is part handled by the PHY

> 
> 9.5.1.2 The local PA Layer receives this request and places the M-PHY
> Link into hibernate using the PACP protocol (detailed description of
> PACP protocol can be found in Section 5.7.7). Once the PA Layer has
> successfully hibernated the M-PHY Link, subsequent layers of the local
> and peer
> UniPro stack (L4 to L2) shall be hibernated by the DME by sending a
> <layer-identifer>_LM_HIBERNATE_ENTER.req SAP primitive to the
> respective layers.
> 

And this by the controller, so yeah we set the PHY state, and the PHY will
set the link state accordingly.

>>>
>>
>> This is a bit of ambiguity. But as per the spec, Hibern8 is the low power state
>> of the M-PHY and Unipro controller.
>>
>> Maybe, phy_notify_state()?
>>
> 
> phy_notify_state() seems like a good name. It might be better suited
> for other peripherals as well rather than narrowing it with link_state
> or pmstate.

Ack

> 
> Vinod, any thoughts on your preferred name?
> 
>>>>
> 
>>>>> + * configure the phy accordingly.
>>>>> + *
>>>>> + * Returns: %0 if successful, a negative error code otherwise
>>>>> + */
>>>>> +int phy_notify_pmstate(struct phy *phy, enum phy_linkstate state)
>>>>
>>>> I think you need to use 'int state' and let drivers pass their own link state
>>>> values. You cannot have generic link states across all peripherals.
>>>
>>> I would avoid that, people start overloading this if we let it keep
>>> open! I would like to avoid the api -(ab)use
>>>
>>
>> Then we will end up with peripheral specific enums in include/linux/phy/phy.h.
>> If you are OK with that, fine with me.
> 
> Ok I'll add peripheral specific enums to include/linux/phy/phy.h in
> the next version.
> 
> Thanks,
> 
> Peter
> 

Thanks,
Neil

