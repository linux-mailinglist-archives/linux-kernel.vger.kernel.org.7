Return-Path: <linux-kernel+bounces-871855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8AC0E8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04362421341
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3B62641CA;
	Mon, 27 Oct 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPdV8rgD"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290D274FE8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575906; cv=none; b=N8xOGvtW3RgZj+GEuJSUW+V0NSdKPnYD6BSe8WJWxYvH7jyYBbVANhTMSxfDNurh3iFR1Vi/v3QWIe9Y4gTGDnqAgFNI8JWLSXpx/3FPsSTkoqsjjJeUHhk6x38WEiCfvQ1EgYNff3xjcNzAqhJkn7Zk1+ecB5vj2JbBLp5ekbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575906; c=relaxed/simple;
	bh=Y1MvkoDsD6mAVgFGqzLAJUR28Uz46clMp+rAZBaByK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWYICdes3MlTge4D7VMN2EC5qhTD5uYw3n4Wzt9qBeFRSWkpVRVmpyC9Qc0uGZJgi5qxASTOQM9VKi0LWFIV1k9SNNcVKpVREpAWyNsirXOPCQm1LmnhIHrJM2S4UdalrrtC2dNrW3HGKuqCL16vaUSlIVUOr421Xj14x/ypVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPdV8rgD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47106fc51faso60512455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761575903; x=1762180703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcrvC0QhhQcUv37B42RkeyPXTBCgLFTjF588kV/8S8E=;
        b=xPdV8rgDsvLM1XB5w2rmqx7GUDdmR2kaC7wFvt0NFMMqavBOCapOrkWKKjWzO4odkK
         2Pd4Tv6ItMoyCgl4zqHkjPfuPfeCROOeJpXdHIF1nCwSjHoUmhJXW0g9I8AgW/aCMXD7
         SoQE9IFFmLGrCDd+l+ijex3mqktSYEvIV7YOxpwlPtp+XGntzfgn7NKDV4K6EFFrRXXS
         4hQhhmX9ABPeUOLNvlXVmfcpgQhJFdRrCaXfnefQttP4A4Lr7ttGXuasGNf3sOedhInG
         U21E3Ru+Wvb/ex+q/T8s6aaQN4JHZBMU+HHSs2Uqi7Iyw9ATtjbdW3fWJydZ+fJzZiCK
         YEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575903; x=1762180703;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PcrvC0QhhQcUv37B42RkeyPXTBCgLFTjF588kV/8S8E=;
        b=Z+yBjNAp1NR3GlY2U/wxvEvNEKJtA1kXMM9r/pmQ5IR2ZWahaWq2F/fQ3DEyp7xctl
         Gne4yewP2AfGOKYMptKbCJ0WDoMRGxCFWqrgvJw/QgomWNPuDru2cu/D7UrSc7ONpnG6
         wOTl0HLxZIS1jOluOpawHAioLBORxJhax/SHjelTWvLKQ9pZpEijemJrFXKvEz3CZ40E
         BvyGp6ggYEjTGiJhBO5EmJ0+S0yUj6msJDTXA45SeDv1TH+zd32cC55f88WpV+0QbQPr
         kJxYgv2W77W7fq2GFubjiATfshotpDrGx42cE6udT0K5rn/oxKuJRa+Ry4v8nAEshtyK
         QJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRrlZPC1u1L1aXrAS4OCBW5UwI00TxXCeg40/6suswElRbQDPpDGspraGh7ohTYF+qE/34eJDye1MLfMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7CX+XEX0aV8FR2sGs5cHip9NPoSnkfGWBTVC0yH9B2Zpk7jR
	FQejgkvZs0Zp1+ySNgh+1jaF7ELa/aqx+X/9+pBMQlJejcqYtn4mHBJABQhhavTKs64=
X-Gm-Gg: ASbGncsv1emaE67QtYutxF+TjFwJEzrKsxBYGqr+EWDZ/Xu30/tkUfALrR7+kvkC95a
	HLV2V++lCkN6WJkRI5VaYupLQH0J5nyzLKcYidLm6iAejIVK96DkRlTKftP+8+HfRCgVxk/YZ7r
	8g6lLlMJNH7V17E4EFQgnON8siHTNBfFXfOx5jHcXhOLwmrow8nWnOCgZ6u0SltjIw2JJNEFxUi
	BpNZqJymXQmTMfqEAxzyRT7d8/CMs+jYDwfUh9r7RmCOU3nrxgzt8v+5cA00nhd5S9VVF5nVc7A
	DeVvjiKvAXaW5lvjgMJOAlmKjTPxOW0zrm22sElpxV2xH3YYJDqbOSK9adus1c440Ek1cVBc/ri
	bavJb1yvLii/i3MWnQd3NTGIqVQ6QTbG5xchTwi7ZrJMvMcYZqGU8lHHqoE76g3ERiAkbOm8bLs
	Yk/NIumtYbj0fuHg+2d7LttWGVW/HMnjzpvLs5NOmgQZYtdJcruO2MwTY/1RdwJEomQZe5b1E=
X-Google-Smtp-Source: AGHT+IEEl52P6D6EwSvleUH3ycIr3Mmb2VBMLuS8a2FK7+Mnf2RdBjU5ngbhIw+7PDepKyIiKMDTLg==
X-Received: by 2002:a05:600d:8310:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-4770fadaf6cmr30682965e9.34.1761575902589;
        Mon, 27 Oct 2025 07:38:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:9a4:ec5a:4022:b507? ([2a01:e0a:cad:2140:9a4:ec5a:4022:b507])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dcff9101sm71964205e9.1.2025.10.27.07.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:38:22 -0700 (PDT)
Message-ID: <7656e8f6-e281-4f7b-9ff4-1b2722234091@linaro.org>
Date: Mon, 27 Oct 2025 15:38:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
 <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
 <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
 <cb361d77-6845-45c9-b418-67649880495e@oss.qualcomm.com>
 <ef247fe6-6d9c-4a74-b3f8-a56857332758@oss.qualcomm.com>
 <9a227c15-dc60-4086-8d81-f80e3398a083@oss.qualcomm.com>
 <18e8d5db-e32a-4893-9d1f-5003670cedeb@oss.qualcomm.com>
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
In-Reply-To: <18e8d5db-e32a-4893-9d1f-5003670cedeb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 14:29, Konrad Dybcio wrote:
> On 10/23/25 11:46 AM, Maulik Shah (mkshah) wrote:
>>
>>
>> On 10/23/2025 2:39 PM, Konrad Dybcio wrote:
>>> On 10/23/25 10:57 AM, Maulik Shah (mkshah) wrote:
>>>>
>>>>
>>>> On 10/23/2025 1:47 PM, Konrad Dybcio wrote:
>>>>> On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
>>>>>>
>>>>>>
>>>>>> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>>>>>>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>>>>>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>>>>>>
>>>>>>>> All rpmh_*() APIs so far have supported placing votes for various
>>>>>>>> resource settings but the H/W also have option to read resource
>>>>>>>> settings.
>>>>>>>>
>>>>>>>> This change adds a new rpmh_read() API to allow clients
>>>>>>>> to read back resource setting from H/W. This will be useful for
>>>>>>>> clients like regulators, which currently don't have a way to know
>>>>>>>> the settings applied during bootloader stage.
>>>>>>>>
>>>>>>>
>>>>>>> Allow me to express my disappointment over the fact that you sat on this
>>>>>>> for 7 years!
>>>>>>
>>>>>> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
>>>>>> Read support was eventually removed from downstream driver too for the same reason.
>>>>>> There were early discussions to remove read support from RSC H/W, due to lack of users.
>>>>>> Its not realized yet and all SoCs still supports read.
>>>>>
>>>>> Can we read BCM states from HLOS this way too?
>>>>
>>>> Yes, Any of ARC/BCM/VRM can be read to get HLOS/DRV2 votes.
>>>
>>> Wow this is amazing..
>>>
>>> Do you have code for this already, or should I hack on it?
>>
>> No, it won't be of much help, as i said above it gets HLOS/DRV2 votes only for a given resource.
>> More specifically, the read does not give the aggregated vote result across all the DRVs.
> 
> Hm, perhaps it could still be of *some* use
> 
> But maybe reading back rpmhpd and rpmhcc states would be of more
> use!

The interconnect core definitely supports reading back the state at boot.

Neil

> 
> Konrad


