Return-Path: <linux-kernel+bounces-777952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B57FAB2DF80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03F318958BF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADF275AFF;
	Wed, 20 Aug 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OV9bJd0M"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39ED26E702
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700522; cv=none; b=UIVq5I6ID78EFqZ5FvCNCE15g+xC2dOhlzRy82zi39dWLzOEN3nL4gHcs+OatIuFdGVfmhS2m47/+V8pb6U0YkhSpGl2obdOaBlxPrfGWWAjKaCCzStJebUBhbgTVwLL2OOauz4O1QtAQigi2m6qnYhFpN07B90vJSqzIYxqJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700522; c=relaxed/simple;
	bh=1Qag84jSIYKKGB3GL4h9gMK0DcgCqCfg2JEuSG840xo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JHwE+Ly3aQzSF97bZzQcZBJcqU/M/vtRKklxONmSSz8rOQGuLjlkqxPLoDIFnNuT5/gCoa+Q4awh+8eGAjNXN7hMQ8ouSU2ASj+U0ZSAJWTt1nMw0bC8UDuC2Ut+OGOet1h2W5dGU7EkrdQPbmIaofzDvOknOm3M7MhwRiDVUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OV9bJd0M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b0becf5so36278955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755700518; x=1756305318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lyug+3qlgRJRhXiV8Js+LFY/rJHmnY0zI7jbnl8sttM=;
        b=OV9bJd0M6gswSiSqNYNoygHPHZr5pimR7L8+mHbQxUb/CaaCXtJsR1yLxNnTLnE++5
         mGZMe3yjbuDRTI+vHEO4/VZWdaB3NzCDLUz0yBOIamZyfsCbhAKO5qxiNbaWwdiD8Ea1
         2APsSX+wB5mlQIedN77Zw/zVEpnxYRzNyJlLlA5OLuVYFbGefV4hi4EXnLPyBhFF8FgL
         szB7d2HpCKyIYEc+2dV2XoyjClH9NlTq1jwJ7eFSg9xFXilH95TmhQ28V1Dr2vDL1m11
         ETW3TkhiCJUsMUb4VI7LiG6kHzdn0aGhi19PDJw6kRiuKYESHUUY2HiBWM85/rgc/JSa
         Yn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755700518; x=1756305318;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lyug+3qlgRJRhXiV8Js+LFY/rJHmnY0zI7jbnl8sttM=;
        b=QLouG7otfj9gwVEkgabw+tB3n2jJxrltIG8r7fvUzrTOk08FLpQEduStLAXzfB0NiB
         8V5IsEo0tEvU1Q+3oHrXOprmHkW232ObSGNA4Ox/iVrViBk4NhMIznh6Cv0bEEmSpejF
         D+WcTR5lxKJEbpogc+fV4AstX/lbm/AFtz0Hr8utMWTJdzz0ax1AcL24rDHUYs5wNNmp
         HEBPHgMCY8xmGUbPXI5+fPcIJDPBBmDxWY4wrd0aEIqa6TppT6JfZadlsDydsRExPwc+
         sQ251y+N2Ku0Sbes1ziObefPTJQlgNB4GRad8FcoAS1yyTWXxca5L3RNQP8fO8k/Z3ql
         SqJA==
X-Forwarded-Encrypted: i=1; AJvYcCXGnuNxv5sEnQdLqq31tGFpstDgY7EXwrRUBk3GOWECh8BLtnCqNzwWy8gsXVu1LKWS6vFSM98ikW1e9Xg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Gag6Yk/Zwyl2ZxPcZLJslpv5Fn1FFI9Xg35s+FDWNOj7ux1V
	HsYPKuGnFueYIRrpl7Y1NVky/fuIOJoHEfQX2wUwY9toeZMgJepiPcMQNBX8ikeRkV8=
X-Gm-Gg: ASbGnctgWh+mejlMgiZIZ7EdTeKQIoTN1v9AyqnKd7TarVmhsEwvsL/K+IROqnBMfLU
	6D5n2AsU7UuaSGfFF6PLxSpCOIyxBOxxBCQPAwyDrT2IIgFY+ST7SugEj9nE168yE4EdeOvbrBL
	2PsKGia3l8mhnDsHamCGbSrEuSOfA6if3z7fgTdOlnUsXAMUbs5P+HUmP27YUDEsRCMAQLLduKo
	T3MNQwoaYjST57XVaR7ocPO7IyfvxUspYETExVCBOctudZLgwsDg1B+f/FGeGrk/p6DlRVqyvY3
	i4AbexzW6XAG8w8w2I8xjNbU10FXWw7F7iy6F3y+fRIA7HyIZzz/L/jWecKQVAGWr454yKa+tgj
	3pcT5Wz/Klr38p6BVruhWr6w15kc+KmQf0scLfCwj9hPTBXEGknySSHFjsFdFKtxaqqeyvhXZ7h
	2oyTSxVpRDTw==
X-Google-Smtp-Source: AGHT+IF9B7tqIKdb0iENG78IKFvAW+b3aPLefvK3bcUp3eG0jsgNx9wqXhniQbUfVg6Xi43bgw/eBA==
X-Received: by 2002:a05:600c:3144:b0:458:f70d:ebd7 with SMTP id 5b1f17b1804b1-45b479f7aa4mr22885645e9.20.1755700517998;
        Wed, 20 Aug 2025 07:35:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:dc4b:4af3:f382:7aa7? ([2a01:e0a:3d9:2080:dc4b:4af3:f382:7aa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c29c9dsm37952745e9.4.2025.08.20.07.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 07:35:17 -0700 (PDT)
Message-ID: <d1c0a646-8089-4d5c-ac5a-068c4910bb66@linaro.org>
Date: Wed, 20 Aug 2025 16:35:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCHv1 4/5] arm64: dts: amlogic: Add cache information to the
 Amlogic S922X SoC
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240205171930.968-1-linux.amoon@gmail.com>
 <20240205171930.968-5-linux.amoon@gmail.com>
 <cf47b82c-6307-475b-af3a-eab7f09715f0@linaro.org>
 <CANAwSgTOpDmZGR33veBWrzr75=xEZ-28iu=GeCzqa0ZPXxDchw@mail.gmail.com>
 <f87069a4-042c-467a-94fb-0b65bfa4758d@linaro.org>
 <CANAwSgR1+Fb5Si6yBU6JXCfRiq-XU0xjr-ecVbnALMj7qmv0Sg@mail.gmail.com>
 <CANAwSgQvYyE3rZqBHR2_Q0FzggznOh=fhtBQVJZ1DRn73P24pQ@mail.gmail.com>
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
In-Reply-To: <CANAwSgQvYyE3rZqBHR2_Q0FzggznOh=fhtBQVJZ1DRn73P24pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 16:00, Anand Moon wrote:
> Hi Neil,
> 
> On Tue, 27 Feb 2024 at 18:34, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Niel,
>>
>> On Tue, 6 Feb 2024 at 20:31, <neil.armstrong@linaro.org> wrote:
>>>
>>> On 06/02/2024 11:15, Anand Moon wrote:
>>>> Hi Neil,
>>>>
>>>> On Tue, 6 Feb 2024 at 14:30, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>
>>>>> On 05/02/2024 18:19, Anand Moon wrote:
>>>>>> As per S922X datasheet add missing cache information to the Amlogic
>>>>>> S922X SoC.
>>>>>>
>>>>>> - Each Cortex-A53 core has 32 KB of instruction cache and
>>>>>>         32 KB of L1 data cache available.
>>>>>> - Each Cortex-A73 core has 64 KB of L1 instruction cache and
>>>>>>         64 KB of L1 data cache available.
>>>>>> - The little (A53) cluster has 512 KB of unified L2 cache available.
>>>>>> - The big (A73) cluster has 1 MB of unified L2 cache available.
>>>>>
>>>>> Datasheet says:
>>>>> The quad core Cortex™-A73 processor is paired with A53 processor in a big.Little configuration, with each
>>>>> core has L1 instruction and data chaches, together with a single shared L2 unified cache with A53
>>>>>
>>>> Ok,
>>>>
>>>> Since all the Cortex™-A73 and Cortex™-A53 share some improvements in
>>>> the architecture with some improvements in cache features
>>>> hence I update the changes accordingly.
>>>> Also, I checked this in the ARM documentation earlier on this.
>>>
>>> I don't understand, Amlogic states it's a shared L2 cache, but you trust
>>> the ARM documentation instead ???
>>
>> Yes please find the Cortex™-A73 TRM
>> L1 Cache
>> https://developer.arm.com/documentation/100048/0002/level-1-memory-system/about-the-l1-memory-system?lang=en
>> L2 Cache
>> https://developer.arm.com/documentation/100048/0002/level-2-memory-system/about-the-l2-memory-system?lang=en
>>>
>>>>
>>>>> And there's no indication of the L1 or L2 cache sizes.
>>>>
>>>> What I feel is in general all the Cortex™-A73 and Cortex™-A53 supports
>>>> L1 and L2 cache size since it is part of the core features.
>>>> but I opted for these size values from a Wikipedia article.
>>>>
>>>> On my Odroid N2+, I observe the following.
>>>>
>>>> I have also done some testing on the stress-ng to verify this.
>>>
>>>
>>> Ok I don't feel confident adding numbers that comes out of thin air,
>>> and even more since they are only shared to userspace.
>>>
>>> I think we should only add the numbers which are 100% sure
>>
>> Best way to let the Amlogic SoC members comment on the CPU  L1/ / L2 cache size.
>> But with the lack of pref PMU events we cannot test this feature.
>>
>>>
>>>
>>> This looks pretty, but let's keep exporting verified data.
>>>
> I just wanted to revisit this patch series with some updates on
> 
> Here is where the Android TV provides the cache details.
> [1] https://androidpctv.com/comparative-amlogic-s922x/
> 
> Amlogic S922X Hexa Core SoC has four ARM Cortex-A73 cores capable of
> reaching 1.8Ghz
> with 1MB L2 cache + 2 Cortex-A53 RAM processors with 256k L2 cache,
> 
> https://boardor.com/blog/understanding-the-architecture-of-arm-cortex-a53-cache
> 
> Also  Amlogic A311D processor utilizes a "big.LITTLE" architecture, combining:
> 
> Quad-core ARM Cortex-A73:
> Each Cortex-A73 core has:
>       64 KB L1 instruction cache 64 KB L1 data cache
> The Cortex-A73 cluster shares a 1 MB unified L2 cache.
> 
> Dual-core ARM Cortex-A53:
> Each Cortex-A53 core has:
>    32 KB L1 instruction cache, 32 KB L1 data cache
> 
> The Cortex-A53 cluster shares a 512 KB unified L2 cache.
> 
>  From what I understand, CPU caches are a core feature of the CPU.
> Do you think I should update these patches and resend ?

Yes sure,

Neil

> 
> Thanks
> -Anand


