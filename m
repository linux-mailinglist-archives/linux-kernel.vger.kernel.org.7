Return-Path: <linux-kernel+bounces-608548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F665A91523
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 09:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4917AC16A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 07:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666921B1AC;
	Thu, 17 Apr 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWcsisTX"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA00219A7C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874930; cv=none; b=BDCwTSvSkJ001KgLaq9r5E1/d3sNeG6zd62+91NDDRo7v1qReKlupOaFnjq13YKjAVWmGxgCvTJIqMtk+tzBsmqBol6rns+MwyvVG+uusLNYtpbvudJbAWtWhRYM4ErmHx070PfmN1EWMgM70Y90QODf5GkWvJb7/zphQ2Yzi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874930; c=relaxed/simple;
	bh=Vfs3mItdj9KPrNQdqQNYQknOyD2oMo8MEhXAQ5nfREs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjjwiF3g1h178CnFX3yiRnVOZMGHmFvb1NwWP05VOSDdD360KAWfx5E4Xz9YBur5vQqpHtcjDL6wPvuOmBAO4c046N5ErIpD9LmIDOSf7DywC+K9aDCHqptGbp76fNqKy8S0YE6wBVLSwiiWeIL2WfRWlJpflj0Ty/ngsvRf7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWcsisTX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ab85402c9so18050f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744874927; x=1745479727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xVUuqaTr/85bEp2vmjyLVKnqValaRXl23CqZa0ZHR/g=;
        b=DWcsisTXwju7uFGnVICIrpKCw0w0sVF9FSo7DHFfei1qvS4WyVY6LIPEVh+IOTrHbN
         fC/vG0bh2w8GolpbylcBhmX5CbhYUs6Ebh1PQwYq4zEdEDsMTtAS7sbDc//JOgYG9KLP
         h5zjSl/zqxepciDVRySF/mo1lZXsd/VCLnBW1Edi+wCk/UJRMxUWFDexl54EKtCOBD3Y
         l2VSZZ8eTrpcA2693+uZTwSOTonMHJeuFTwdKUt0SC1VRRmJOogV/kfuGjqC38Kz15g4
         cieI2Tog9aeXPGW1oHJCSF115UT+Py/4Zx9tbZ28mkKVShriguVRmlxR9UoBSx3UXRAu
         eVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874927; x=1745479727;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVUuqaTr/85bEp2vmjyLVKnqValaRXl23CqZa0ZHR/g=;
        b=dzvye6rdLfOwohZoEDMtruYWpWfoUqRvQJCq5bfpH+OCAIL7NMC08UfnIlJchKWUjy
         QtLSdasslwxrIekNxdd0wGF+L4r0t/MaBeu9e6fgLSV3TgIwH3O4rVsFnWptN1M/5r7g
         GTJ4RuBTPFA8PAu9PVWqaqsXnrs/kAO2Nm6rJI7vVCYYSO0YbjrrYXTb4WtSsOicXK9Z
         gjhByVLEmyapTz09p1iwBTND0GgcmjF9zvgou8lZL5NdJfWTrYfDv3SBTunHAiIZrKVa
         l4tloL3niSQgZ5e+LOB4FJxfxEYp0Tw7pZYqr+OkMNtHrDAT8R2yCLsdsefW3zuLBLcL
         4vrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0DX3dhBc+A7RV9wi44bMYCER9h9DA3gfJZZZgyduTZV8jBkEjxUsSobIxCid3lFlePTnXMiqB+ElHROw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7aMW1Ypqn9gBrDQrudp1kIuDjlsP154BfoxVefOBcwr1dimS
	i33s1eA0+SXdCB9en/BV2sTbFqemk/Q3DqSIL+D2h65bsHB/jvScpgBk5oNAsQw=
X-Gm-Gg: ASbGncte8YoYGohFlmlhiR5w9O0PKRXd5+3meqbs/f0Bee7Gnv1k4SGFDhElX4Y1K0y
	gI31vbiVFXm6dSFxqI/6i6soz1lL0sJvBhOlWfWv2uuafXDne2vKF5x0MKn08Erga2jV5xSz5wy
	D1wSGDLPvFGMKfuolV+9SL960y8DWK/CiWjrR/Ox5c5NEotobUmMScg3SR1CdCZ1Y5afDDa7AFZ
	iE79yOFQxS8XnquFNgxOJp/9lsTNtvOHCHTp2vdS1Gq84lAmj2fDKerzrsO33Famj0XojdrLzkw
	hJjA76j+CeSPxd3gT/C2l2efa3oz2uFhPqlV4P+3wGH0obTHgTruyUxY4MG49RqOAXrigrmPODW
	ggQiYG8OuC4jJr0cy
X-Google-Smtp-Source: AGHT+IE3Zzfxa2xFyAPrwj1JpkKzEGocwO0Z4hobPysDcfIP1i7yTyBis7baQC7iPuUdTJ/9/E9XkQ==
X-Received: by 2002:a5d:47ac:0:b0:39c:30f1:beaa with SMTP id ffacd0b85a97d-39ee8fada0cmr628338f8f.7.1744874926948;
        Thu, 17 Apr 2025 00:28:46 -0700 (PDT)
Received: from [192.168.0.101] (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f3bb0sm43455915e9.22.2025.04.17.00.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:28:45 -0700 (PDT)
Message-ID: <f957e366-51e1-4447-982c-93374d0fde2e@linaro.org>
Date: Thu, 17 Apr 2025 09:28:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: fix compile-test defaults
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250417065535.21358-1-johan+linaro@kernel.org>
 <a0739b6b-b043-47f1-8044-f6ed68d39f2c@linaro.org>
 <aACsQUADxYHTQDi1@hovoldconsulting.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <aACsQUADxYHTQDi1@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2025 09:22, Johan Hovold wrote:
> On Thu, Apr 17, 2025 at 09:10:09AM +0200, Krzysztof Kozlowski wrote:
>> On 17/04/2025 08:55, Johan Hovold wrote:
>>> Commit 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
>>> enabled compile testing of most Arm CPUFreq drivers but left the
>>> existing default values unchanged so that many drivers are enabled by
>>> default whenever COMPILE_TEST is selected.
>>>
>>> This specifically results in the S3C64XX CPUFreq driver being enabled
>>> and initialised during boot of non-S3C64XX platforms with the following
>>> error logged:
>>>
>>> 	cpufreq: Unable to obtain ARMCLK: -2
>>
>> But isn't this fixed by my commit (d4f610a9bafd)? How is it possible to
>> reproduce above error when you are NOT test compiling?
> 
> Correct, but this was how I found the issue and motivation for
> backporting the fixes including yours which was not marked for stable.

OK, just does not feel up to date anymore.

>  
>>> Commit d4f610a9bafd ("cpufreq: Do not enable by default during compile
>>> testing") recently fixed most of the default values, but two entries
>>> were missed
>>
>> That's not really a bug to be fixed. No things got worse by missing two
>> entries, so how this part could be called something needing fixing?
> 
> I'm not saying it's buggy, I'm explaining that the identified issue was
> recently fixed partially.
>  
>>>  and two could use a more specific default condition.
>>
>> Two entries for more specific default - before they were ALWAYS default,
>> so again I narrowed it from wide default. Nothing to fix here. You can
>> narrow it further but claiming that my commit made something worse looks
>> like a stretch - and that's a meaning of fixing someone's commit.
> 
> Relax. I'm not blaming you for doing anything wrong here.
> 
> I sent a fix for the same issues you addressed and Viresh let me know
> that he had already merged a fix for most of the issues:
> 
> 	https://lore.kernel.org/lkml/20250416134331.7604-1-johan+linaro@kernel.org/
>  
>>> Fix the default values for drivers that can be compile tested and that
>>> should be enabled by default when not compile testing.
>>>
>>> Fixes: 3f66425a4fc8 ("cpufreq: Enable COMPILE_TEST on Arm drivers")
>>
>>
>>> Fixes: d4f610a9bafd ("cpufreq: Do not enable by default during compile testing")
>>
>> That's not correct tag - it introduced no new issues, did not make
>> things worse, so nothing to fix there, if I understand correctly.
> 
> Fair enough, I could have used dependency notation for this one.
> 
> Let me do that in v3.

OK. I have doubts that this should be marked as a fix in the first place
- even skipping my commit. Some (several?) people were always
considering COMPILE_TEST as enable everything, thus for them this was
the intention, even if it causes such S3C64xx cpufreq warnings:

https://lore.kernel.org/all/8b6ede05-281a-4fb1-bcdc-457e6f2610ff@roeck-us.net/

I had also talks about this in the past that one should never boot
compile test kernel.

Best regards,
Krzysztof

