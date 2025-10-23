Return-Path: <linux-kernel+bounces-867713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8FC0357A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C147358AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25F254855;
	Thu, 23 Oct 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eG3TFEJp"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFD142E83
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250600; cv=none; b=IsrL78jzBxHVa6+GJ4tT0vjcEyxGt8snp1cBRvGQr6ry0IUgfjneO6I3yGNjr3AM/H1xkmWtHQ17P1pxth79Cvk/XAbZR6exU/NjE8n6QK+5aD1fvkeuRZfBHTRZe1rEq1L47p35uPakWK4zmFkiC/1EO1IYgNMjyyRSvxbfqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250600; c=relaxed/simple;
	bh=fr+n8Ww5AbeMinkrbVJ0IIZGzI37BKWE2kT8u6n1VAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOI9eXA1syQUDpFBdV8ITuQMJlnEPtGkIs+1JIf7/SEWua0b45TIUNjVTfAZHyzM7hUbGduGKrxYsWewoiPPw7rbzZELxndl+pqFXgk5KRgh9bG9xfg0BNxtzRgTAPof8BSuqCWvTUJVjq56BYW3pAXKa4oVxKprtMOWNOXvAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eG3TFEJp; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42702037a01so199716f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761250597; x=1761855397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kR18xZLkIBD/v+YYlolu57R5lqheAjboSLyrb0PLlFA=;
        b=eG3TFEJpGaKSt5FipHNQt74HtKVr8BORKVwDO5mV7ekjObPJ+m8OqMob1xvb0arrTX
         6BQDFiIhVO2FJvtwmPV9oGy+3Bwb2hjJX8P+XgWatgadO2bnrAUW/b7/h+CLZRjIShHO
         ihyi5efcwEjmzClsDOaDGg+YWqFhKsYhB6cMtqYyAqnXgGYQwjKawFXoUFy1wb3gGNzh
         RhXOWIqXCTTo2WB9UkW0jJfYFt6Z8c1QD8e2P/QAoYbt0bqSginZkFWvF+UMagZAGkoW
         Hqef6ERm007HKNG0BLqi+k17yNv8USSeAVQwFe5s2kuZpRs0bFQa7tXcHCVgDzWfotdk
         EwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761250597; x=1761855397;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kR18xZLkIBD/v+YYlolu57R5lqheAjboSLyrb0PLlFA=;
        b=doI/hqUG/bMFKlsSC9+9PJyKr3WEiIA70doge/vDz+7VlpxYSGjW1u56LCcZcBEmdZ
         HmJGZOO40tej+BeT4ivk2Bz3Zsr6CB5jv0ion9Tt1uVcksQYdiiry7C747dJNzhk0/M8
         Bn1U9niSMwkDOq8q+vvEb3P4jUX7p04l4DTkvnfritrOr1zrvENKXWRhN6xkcRZT5DTv
         ZaP0ciOTT3j6JgZGSwH2vYNS1/F6DK6bvaYUYKRMW/2U/fcbEp+yRGB14eJfn4dN5Cih
         6xmAa2qNMnEYhZHjzZqCz89WSjtNolNgNiU9N+az2Ygh18Qhzt6k0hBYsJA0QMYnjRD7
         5hyw==
X-Gm-Message-State: AOJu0YzvAnFcuUYJhSDMWtgRq8LqQDjM9lkehA2D3YfXQO0Mwt4V2J91
	Bps6vLqd18CV1HRMHFFwTW4xxe/rT9isq99h6Taud5y+u+qEW3H/KAgQu02VCWYxdfY=
X-Gm-Gg: ASbGnctSOMxUY9+e5xEug7RhmH1nd5DoXaa2mOhb/Le6DHV9Wt02/gAh+dtikAKvc1A
	OTgwizLahc4lk/uXA9vno3bsG+lIycVY36N8CvdYXxzkrS4O3iTjObDgewftlbg6n1rs9KjFgun
	w3VfBrfVLK/98UH4Ks9ar7nW3l2Vdu75/autoLtetpmwKeeGWPSzNZfBdPshs/s5NvHJeW0YMc3
	L0yg++jNYRCVaLLD9hPEQLqvkU0H++t1hsUZF1pEYPA55gaJYBBzFF1bEigTxPFI8Gh9Q94Vova
	8CTGJUDOJhEjHFOv/+6uRFM3DRPHa+JNZiYpoq3lAuymnHiTmjwMLW9Gm4UfEjKnQWv26b0/7D6
	ipX1+fLod8+XP+ehTwsAoElbgKR3JDL2/fCrZWy6nTOzIXZw5AfTx+N9Op/M9P3hAe0tk1FCDT3
	7bgWKpA5kMxMNqkwKRfj/f
X-Google-Smtp-Source: AGHT+IGDdj2clyde62LaWC85mqGvgAg4Mcphg+WaGFRuMk1QFzv1PKO3ZTThd0ZWB4kpfNj4J8wWgw==
X-Received: by 2002:a05:6000:2681:b0:429:8c97:f9c2 with SMTP id ffacd0b85a97d-4298c97fb46mr917173f8f.10.1761250596713;
        Thu, 23 Oct 2025 13:16:36 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ec1dfsm5702040f8f.43.2025.10.23.13.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 13:16:36 -0700 (PDT)
Message-ID: <82770e98-a9f7-4a89-a076-01394cf6b880@linaro.org>
Date: Thu, 23 Oct 2025 22:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting
 and Ethernet
To: Marek Vasut <marek.vasut@mailbox.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
References: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
 <3381308.aeNJFYEL58@steina-w>
 <e6b282cf-e9de-43b7-a8d4-30e67cefe430@linaro.org>
 <5d042f21-274e-4b69-849a-3342d77942eb@mailbox.org>
 <00555ed7-1aee-459a-ae60-0242809d7b85@linaro.org>
 <07aba8d4-533d-40f7-bcd3-548704d7d228@mailbox.org>
 <f1bc82c0-8800-42e5-8a4d-aea209acd0f2@linaro.org>
 <656164be-5ce7-4f9e-b6cd-0eb1b9305132@mailbox.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <656164be-5ce7-4f9e-b6cd-0eb1b9305132@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2025 22:05, Marek Vasut wrote:
> On 10/23/25 6:01 PM, Krzysztof Kozlowski wrote:
>> On 23/10/2025 17:53, Marek Vasut wrote:
>>> On 10/23/25 5:32 PM, Krzysztof Kozlowski wrote:
>>>> On 23/10/2025 17:27, Marek Vasut wrote:
>>>>> On 10/23/25 5:22 PM, Krzysztof Kozlowski wrote:
>>>>>> On 23/10/2025 16:03, Alexander Stein wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> Am Donnerstag, 23. Oktober 2025, 14:19:15 CEST schrieb João Paulo Gonçalves:
>>>>>>>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>>>>>
>>>>>>>> Enable the necessary missing configs for the i.MX95 to boot and also
>>>>>>>> have Ethernet working:
>>>>>>>>
>>>>>>>> * CONFIG_NXP_ENETC4 for the network controller driver
>>>>>>>> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
>>>>>>>> * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver
>>>>>>>> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller
>>>>>>>>
>>>>>>>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>>>>> ---
>>>>>>>>     arch/arm64/configs/defconfig | 4 ++++
>>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>>>>>> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..787d3ae3f5afeac486a905e0943e7b0e1dcee3a9 100644
>>>>>>>> --- a/arch/arm64/configs/defconfig
>>>>>>>> +++ b/arch/arm64/configs/defconfig
>>>>>>>> @@ -354,8 +354,10 @@ CONFIG_FSL_FMAN=y
>>>>>>>>     CONFIG_FSL_DPAA_ETH=y
>>>>>>>>     CONFIG_FSL_DPAA2_ETH=y
>>>>>>>>     CONFIG_FSL_ENETC=y
>>>>>>>> +CONFIG_NXP_ENETC4=m
>>>>>>>>     CONFIG_FSL_ENETC_VF=y
>>>>>>>>     CONFIG_FSL_ENETC_QOS=y
>>>>>>>> +CONFIG_NXP_NETC_BLK_CTRL=m
>>>>>>>
>>>>>>> Are you sure this should be module? Shouldn't NFS boot be supported by
>>>>>>> default? I might be wring here though.
>>>>>>
>>>>>>
>>>>>> NFS root is supported already with this being module. Yes, it must be a
>>>>>> module, cannot be built in.
>>>>> It seems I am using it as built-in on MX95 Verdin (patch is posted on
>>>>> the ML), and yes, I do boot from NFS root without any initrd/initramfs.
>>>>> It has to be built-in for that use case to work.
>>>>
>>>>
>>>> Every arm64 platform is supposed to use initramfs and we already use all
>>>> over the place.
>>>
>>> Shouldn't the platform also be at least bootable with the defconfig ? If
>>> yes, then initramfs is a mandatory requirement for a NFS root boot (not
>>> a ... supposed to ... optional one), which does not seem to be the case
>>> until now.
>>
>> It always was a requirement, nothing new here.
> 
> Is this requirement documented anywhere then ?


Dunno, just dozen of emails.

> 
>>> I would argue the ethernet MAC support should be built-in to achieve
>>> maximum utility with the defconfig.
>>
>> No, you missed my earlier point - all decent platforms already use
>> initramfs since it is really not complicated.
> 
> Is my understanding correct, that the in-kernel defconfig is not meant 
> for practical use and is meant mainly for build-testing/build-coverage ?


It is 100% practical use - we all test our boards on defconfig. It is
not build testing, but actual runtime usage and testing. And as
mentioned many times - being able to only toggle KASAN for defconfig and
still fit in boot partition size is pretty useful.


Best regards,
Krzysztof

