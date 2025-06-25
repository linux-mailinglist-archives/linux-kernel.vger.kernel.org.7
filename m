Return-Path: <linux-kernel+bounces-702453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15376AE82A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44661BC31E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CAC25CC47;
	Wed, 25 Jun 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCxHVwCk"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55125BF19
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854341; cv=none; b=CSQeCozWw4skcDdHAwTMdFDdJ9mL/nd/dBC2cqq9clrAvoPpU7q+6tFR/FJsZt2xKla0EWLc7yYWEbWQBU0nuISCUlZZwN/ZHIiqlpk2o3e6UzUojNa/njwJmuK/pa9gHtESmEQUfxVbshx5eJoCw4dUhVoAm0UfvcEf2vlBCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854341; c=relaxed/simple;
	bh=//cJ1R+qXYIOQavXZE+0EfDVpn3NcjvwbOGFUZ2/Vwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgHJLTQDMmvzF+tOPbq7yGvGPzKIwiA0jKtvT9G9htyxtJhxIhO4apEcL0kAq/5dbJzirLxBWkOdvc//dwUUrle1ZkmSo3ODCK2kGszD+YeelH5thR7wTW7cJC9aYPXdGzXFiTycuT0oMGB7KobS9TJFkMkCq7n6vsoOpSajJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCxHVwCk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a588da60dfso3915895f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 05:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750854338; x=1751459138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jvdYN44TiNs68JwW8S/yVlosf8CSUIVEdttnuRdhms=;
        b=zCxHVwCkfaQ4LHLv/3m74JXelo22PY+sC7dDVAXFHMHi1jCqWTrOazh3mDuUo0WLdi
         VDA+OMfjFf0yFpkS7qy8R0XmLME78CjlPIqS0b+mD8BjOukDLADEj9xg3WhWJlrIwNFq
         zfWMDKtpwn48ui6gBlIHDVTZmdkaVR3HD8ESjAxZsuNWpOeeWhiJTjqLGi0d7ouHsncu
         ubVT6+xrJxEp+ztXLPD6HxxxNGcj3sJh6ZSmuCX8QMCIXtEoZXXbNwnef6g4Mh57rF2i
         iMgerkqPi6NPV6ZDXB8vjzALmL+495xt6ZBF7UdkfNuftyrIAPwkQJGcdZRZ0cJWwjF9
         1qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750854338; x=1751459138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jvdYN44TiNs68JwW8S/yVlosf8CSUIVEdttnuRdhms=;
        b=bpe0gtM4b8AXt3Iwv5plTh1ZARPMvdYo9xsVT5r0szq0HomWJ19WVYwcvm/IWduS2D
         4G/MEiUeLKOCxvIF2lVFklPdaG9m96iO5mu4X8TEHjTKS/yaBF6zsFYc4yziytFEzSxV
         5RkwLIu5Jv0cVfJ+VcmJvjoVGeCxDfotPR0Lxdfwu1EpiiJ+LeaOOkkUHcmR2F6FsnP+
         p7qemAJdQ55y8yRobhJXz8T9QyPwS+nLWnYGlNOfbUO2Q0vp3OndeNdJj3sSaOXSpu34
         B2ikbAUJgp2NUpgGLDnZFmolHwsTIbR+QmwS/VCbYevF3OLSiGrnQOOgzjMlFA1AJmB2
         gMZw==
X-Gm-Message-State: AOJu0Yy4tjSWn1PTKxt+2IbaSrrYj/sxj/u717jR0n5QHjEr2SmGu8T7
	7rs2LUH1UWsEaDV8WroK16q4+i0kkL0uydbtX31Ungt9Am3eopwMQdfCVH1QMZp/52E=
X-Gm-Gg: ASbGncuvvwlZfnQx8s4AyDHSSeJXpKKfYj65dPlucRyT78uKOO9yY3GesdF1j4Z3+ko
	DWXQjkeHpf1bmYvCkmbZ78sKZsf2dA23HQ4ewJ2cyM1wKYqgIhzXyslzOZt5kumz1Isn3GYiyTF
	TL7RNII9TWKyRMtVhx02GM/Aobmno6vtO68J4UY8IvbhwNf5/kWYUmh41a+GCf/+7ZBCE3mi4U9
	I967Nzoe51rUOeW6BaNyVMGi6cV6GiUMsfZPffhfmtnsp6KAnaUjshazryErh2aAa30EouxQDl6
	Ohza1afsPdGKOkLiRPKXgpdGesDcRMY7oXjgcj+R2SVnq94BjgZ69IqDBIykCJrwIUagzZaNP2o
	1599iV7EHSOPlABr//eFEuUYx6A==
X-Google-Smtp-Source: AGHT+IFext7dCx/qknWBCJpjQqXsjhcdgrzm4hickPzaUez5YIOyJ1vzQGCH42r2f1t3xxF9+iiC0w==
X-Received: by 2002:a05:6000:4615:b0:3a4:ef30:a4c8 with SMTP id ffacd0b85a97d-3a6ed5e9bf6mr2043160f8f.10.1750854338131;
        Wed, 25 Jun 2025 05:25:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45382373c6esm19046175e9.34.2025.06.25.05.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 05:25:37 -0700 (PDT)
Message-ID: <44062b00-8903-49e5-922e-aed68c377c70@linaro.org>
Date: Wed, 25 Jun 2025 14:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@linaro.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <e557503b-ccd5-46e2-b0b6-e8db30ad0ac4@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e557503b-ccd5-46e2-b0b6-e8db30ad0ac4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Bryan,

thanks for your review

On 25/06/2025 12:20, Bryan O'Donoghue wrote:

[ ... ]

>> +
>> +    for_each_matching_node_and_match(np, __timer_pdev_of_table, 
>> &match) {
>> +        if (!of_device_is_available(np))
>> +            continue;
>> +
>> +        init_func = match->data;
>> +
>> +        pdev = platform_device_alloc(of_node_full_name(np), -1);
>> +        if (!pdev)
>> +            continue;
> 
> Shouldn't this be return -ENOMEM;
> 
>> +
>> +        ret = device_add_of_node(&pdev->dev, np);
>> +        if (ret) {
>> +            platform_device_put(pdev);
>> +            continue;
> 
> Why is this a continue ? you can get -EINVAL and -EBUSY from 
> device_add_of_node() - can/should you really continue this loop after an 
> -EINVAL ?
> 
> Understood for architected you want to keep going and get the system up 
> at the very least I'd add a noisy message about it.

Yes, that's correct. If we bail out on failure, the system will hang. 
The platform can have more timers which will work allowing the system to 
boot.

It is expected to have the driver probe function to print a message on 
error, so adding one message seems to be redundant.

If timer_probe() fails to initialize a timer (the number of initialized 
driver is zero) then an error will be emitted.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

