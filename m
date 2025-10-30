Return-Path: <linux-kernel+bounces-877830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC7AC1F21E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09CD74E8377
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FFB33CEB2;
	Thu, 30 Oct 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXULy106"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD633A03F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814464; cv=none; b=qSwQH4N7qyJ2OmWfbjbt5QsiLpjic6ReyT4FPH1O4EeacKyVHvgsl+wj4nq+isjiiZ7U+siA/rHj3lQHjjKfdx5gBZ2mTTBXnoTFgLZDu/QFWyNlNo5kBF8IJkOG/ZRVXgfINEwAnGYlqaJ85N0PYwuNRgXd8MMoDQc/WxtQ+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814464; c=relaxed/simple;
	bh=4FbxbnCJDc/1oh2iUw/DiNtq0IJ+KihYhiAuxVGgt3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojKqpDpvfo+6j+HuYBk4IJzs0POIuuLv6wC9EY+2dpGl4XKSEqb201Ak8C00nlpoFqQQz0HqKz+J3pDQa2qo0phFhm9xjp1/KhhoVXO/aq5Dym3LCET1CUQgJjwrKyhcG9xe4P44R8HuvcQhlCZwLp+vm6AE6E0lAofNtvssteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXULy106; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3401314d845so1122375a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761814461; x=1762419261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z1nbpNKxGZmwf2lpk230ytxyk1UWzh/Nxzqzjf3QY9s=;
        b=jXULy106eZuAjPjamE5lEQTRgXIck0xUm4Mc+g/UMbzE5iPATnRryx+BR3xiKhvcz4
         UJ7UWBB0ecLREAuyIaRmdlruI61fq4pu071W9KK0S7v+RYM5Dv6Kv1FMZoVbuwky8zHl
         T88sSpHxCGfWaGVP3td9QWlnnz2qz4+eDVxLerFueMeFeOeweZOWEgLNwkP65pThABnX
         jCXzStZN40lwfq/gE4Y5z8WZBG24Tu+rF15vXoLeMDotA9L8bijyFisbLXIqLq9KUQ/5
         lmty/0VDBApvHReBQFShREXxOw65dnSqE3UnKnsNLnXcv/OPFUiyxBJ8S9OcAleZ8SHR
         b0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814461; x=1762419261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1nbpNKxGZmwf2lpk230ytxyk1UWzh/Nxzqzjf3QY9s=;
        b=t3tPoV0UaAX+CIiidtds8XnhnXa1HVM4eK9yXt3vSpxmg4as9f33IEqwfIxRykqFXV
         COfFTs62TWM2E283ctRQ1cdmsvVu0zBzgD139G1PGmjoB+jfbelD4ZM+Ez0TmQDfZ80a
         FAx2BaYtHi83d9Iop18ucy3y6qzbtwDt8bnNvwG13hjE1mWX8HGUrNSmBvE8mlkziLYg
         u2uXW2OtATea3cabL7YD3THIuvqfP8if0jqnwzvBTy7hXvSijzHwf2s34MGHHpI0jmpl
         NWCOvrS4Nuz0z1U8jSTzQ3Z3OdMh5CcU4OjamYfXPu7hMzPNrGmB9qq4ze2QOj6x2DGK
         73CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtQqI3iX/VJCFr6t6p0cSySDUrUBGj4aM9w+YTYNqUcSXjWXn2YuAiEy0FjphnW2uGzpt7pOglxIONN3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMdHdkL9REbK0BtMcFdh9heK/3lrByjQyJeiyXYvq5QKt5Md0
	5Drklyr2qnn9m7AWyA1qEbgbg7dtugoJwLWqBfXYQOeQsoFB3TqeksjC
X-Gm-Gg: ASbGncvsQOZDllKctcI+Jo4rVG7BiPmK3xPr6nA7GaKRzpN1Y2waepBYWI97YPAYBum
	3GEeWnlXyqauywxMONaqyW/g8mKbP9+Vx9HqwnMhn/qxPLJgHOfynB45++yydEOUWSUO3CTYrJv
	kMGgyKACPA0mU61hk1dPE9FjPl98psdaMXQWEpMN2UEM6NzS+/ZtL94LJgbXeTEUqqWDnU9jWhh
	JYRg96ie4cP+1jF8H3aKrf/p6LyfAcGNsh/tNWihHYeyuY95am/O6pgaADtH38X0QK+aVibf8Wj
	oSrGxt2HDj+QqAz950RVgkSKR9DaraWcp9nIAJXT2v6MnI4vqZf9qCasGM4xmRmUXie44O2FId8
	uOcGMBJFpzH4Ad1FSU/HLHWL4yLNdrxTiz6TZPvYIzl9hBs2+RkCXh0nDl7amkfVT/4DsZXskCO
	RYC7QcZPxWbMfp
X-Google-Smtp-Source: AGHT+IGFeqYgROmr+sPNZXEEZkn6mYlrCgf3ZvBH+yTloU98WBNL4oCUsdI3RF82oEmk9ZTtm2e7CQ==
X-Received: by 2002:a17:90b:580d:b0:340:29be:8afe with SMTP id 98e67ed59e1d1-3404c56f639mr2713860a91.33.1761814461463;
        Thu, 30 Oct 2025 01:54:21 -0700 (PDT)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f880ef2sm15926777a12.38.2025.10.30.01.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 01:54:21 -0700 (PDT)
Message-ID: <ae9021dc-e0ca-4631-b45b-3cf9f526bd14@gmail.com>
Date: Thu, 30 Oct 2025 14:24:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
 <d05fe82a-640f-4a09-9d83-39bb5aff179d@oss.qualcomm.com>
 <9208d2ef-79da-4e80-ac1f-e01fa5feae0a@gmail.com>
 <sfxvtfzzstdbt7in6z6ztsjfy6e555fr3sjbi5kqkv5sk77b26@kl57zs7iuuvk>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <sfxvtfzzstdbt7in6z6ztsjfy6e555fr3sjbi5kqkv5sk77b26@kl57zs7iuuvk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29/10/25 18:04, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 05:50:01PM +0530, Tessolve Upstream wrote:
>>
>>
>> On 28/10/25 14:55, Konrad Dybcio wrote:
>>> On 10/28/25 7:16 AM, Sudarshan Shetty wrote:
>>>> This patch introduces a new device tree for the QCS615 Talos
>>>> EVK platform with dual-channel LVDS display support.
>>>>
>>>> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
>>>> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
>>>> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
>>>>
>>>> where channel-A carries odd pixel and channel-B carries even pixel
>>>> on the QCS615 talos evk platform.
>>>>
>>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +	backlight: backlight {
>>>> +		compatible = "gpio-backlight";
>>>> +		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
>>>> +		default-on;
>>>> +	};
>>>> +
>>>> +	lcd0_pwm_en {
>>>
>>> Use hyphens instead of underscores in node names
>>
>> Okay, will update in next patch.
>>>
>>>> +		compatible = "pwm-gpio";
>>>> +		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
>>>> +		pinctrl-0 = <&lcd0_bklt_pwm>;
>>>
>>> I think your intention was to use pwm-backlight and wire this node
>>> up to that
>>
>> Soc does not support the PWM interface hence we are using gpio 
>> as "pwm-gpio" by setting the duty cycle to 100%(i.e. "no pwm")
> 
> Why do you mention PWM here at all? It's perfectly fine to use
> gpio-backlight. That looks extremely suspicious since you are not
> referecing the pwm-gpio device at all.

Thanks for the feedback.
GPIO59 (LED_PWM) connected to the panel’s dimming input.

Since we can only drive the LED_PWM pin high (100% duty), 
it does not provide true PWM control.

I’ll remove the non-standard "pwm-gpio" node and model both lines
using the standard gpio-backlight binding, like this:

backlight: backlight {
    compatible = "gpio-backlight";
    gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>, <&tlmm 59 GPIO_ACTIVE_HIGH>;
    default-on;
    pinctrl-0 = <&lcd0_bklt_en>, <&lcd0_bklt_pwm>;
    pinctrl-names = "default";
};

&tlmm {
       lcd0_bklt_en: lcd0-bklt-en-state {
               pins = "gpio115";
               function = "gpio";
               bias-disable;
       };

       lcd0_bklt_pwm: lcd0-bklt-pwm-state {
               pins = "gpio59";
               function = "gpio";
               bias-disable;
       };
};

Let me know your opinion here,
Thanks in advance.
> 


