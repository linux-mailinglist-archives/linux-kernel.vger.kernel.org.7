Return-Path: <linux-kernel+bounces-749167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3831BB14AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1681217E867
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A36286D6F;
	Tue, 29 Jul 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qe9JxUOq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2621E0B2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780422; cv=none; b=MN6zwo7jKGQ0vH44dZXy6ZJPOE1RxbqVgi9rbJGOM5ReYxbXkrcIWZiB3LnHlWa53+eae+GRoFpO1wSWO6hfw10nqDFUBj/wXOs75jUNy2IYVYD/gX1WGtPrM7gAe8VwpseIuEOcs61G4yk0ZxAIJny0s1wgDgMkEALAS0QBBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780422; c=relaxed/simple;
	bh=Pgger2eGoP8Jfc70Jpn+Y297tCCbE/cXHE1x9qHbCRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls4ZzTTE2IlRNIC4Glo7UDwRo5ytyVd0Kkou6X7QKPKSmXy9p4YWiIujurdqJqSeLO+tm+GO8eBwafQESg/qcuytxLkqjT+k21nXNDhyXpFdd2orFKRURJAtBrRsechax76zzF5f1fIDNDe10yRPLARhpaaGb//5WMx8mg6iBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qe9JxUOq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso55815815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753780419; x=1754385219; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/T7xfa6EKXzBmswjGiH5vZYytRxtAdkrVjl1Ndu+Bo=;
        b=qe9JxUOqiAHxCofI6cFX+XH7qomlcV7ELO5JOCjHsIdRgvdNccCzOSXqT+WAx63+A/
         Z27INjWGCpWSQLZ+0Ukq9PWauxwMVVkJ0oAVmMcH5QNrRURiTPkFUushH3hZGDtMeiQi
         GqQ0luOf2TBDBzNmXk1bcbsLLg5YUEPBGT10j1VX8KuSTCiMz2P48wo7KDZYEuWhFFIC
         K4g9zngYDpA8Dc1m5iXOFxSMjTRcoC7MYS6aZihF3b19iss4WsZtwlxnWpHP2U9GuJ6p
         xXw8l0t6Yf214QnNpyUKjxeK1Jjs6lbjVPO5+gWjLZ9OYfsrI1VGRqoUnwpHfUo7wcO1
         dS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780419; x=1754385219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/T7xfa6EKXzBmswjGiH5vZYytRxtAdkrVjl1Ndu+Bo=;
        b=lSfNafBgiRKzMwOd3ieLrkmGbb3YlcO9O75J+JTHFGbA9jrI7xPhXYHgb+0QqJdb1s
         9QkFJZACWPoVU+eHPXczQKWu7tnA1d6J3dm5z6GvEi1T6uKLUz2BxtizmiIqY6HD36nM
         A8sejhKVzYxoBQZY+f2gg5/QtNhaELgBJT6rS8GTlWVlXChBKYQqN6cCjiiZOAZt5Cp0
         Xsu8iyGPm+Mg09yztb58D/CCGR42Mdh7TpMzoPq+QyfYNnUrk5g5tvPk0fz6A354ghSZ
         S7rr3psowapZwP/787ZO3AwNuZ41eShw0rYPV7jLsimhQhvnlLDEUKRWNBHZP1+MYVc7
         YQww==
X-Gm-Message-State: AOJu0Ywnoe+dr+pxGbo9cesJ5a1jioj2Kt6waFN+AWxA0pBv8/3Y+6A0
	4gHoT9TbaGkECQu3hOxJwIwUY81teqxQGip3LD84e9IVb4W7VhtnN7T5ia3YyXh5mQc=
X-Gm-Gg: ASbGnctNfAD+fVUlZQDXVeo0jtQbbPd7fSUpHEuqpDh0LUt9SFYrrut3wKLDb8HqqdT
	OTpJyfllNQVozjabaM5GaVLomXdyyZTZLVndcuDX7rhZNDCwxwAixz8EsUMiTHvBSCGpy6L1BQH
	5+S0h2/hLGzTRL6WrjUfpEjNCMu7grMqjHIprbkpEvYaHg0PQFcRBEA0xglIZi4v6SUpKFhHYYP
	eFWHOyJq2YrGNERxHI3nesfszx8Qc0A+H9NBu1SiPVbLayll6CVKeORKaDiwFxgrFWB3efCCH1Z
	SJIJd7Ry6schtv0hoMp+nvyZTSI87jWnUV6a6AAgZQPK1TMR9XNXnLLuoJxcULmLlqFjUXw4xX1
	txC50XOIcpcbvkgvvZleMkiLrZ+Z4ZjP0dvP4o0QyXCaR/ENaf8qxS/oHKitL9g==
X-Google-Smtp-Source: AGHT+IFIUouVLdYyN5JupIDqGUB18/YRE2cxY7ZTWjlDFQeNFzA1mKxBf2H6uB1h2zr9LAFNkSsR0A==
X-Received: by 2002:a05:600c:c1d7:10b0:456:1c44:441f with SMTP id 5b1f17b1804b1-458769e88a1mr67665805e9.31.1753780418663;
        Tue, 29 Jul 2025 02:13:38 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b7887285e1sm6179310f8f.65.2025.07.29.02.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:13:38 -0700 (PDT)
Message-ID: <920c5a0c-6ac2-49a1-8dbe-17761379765e@linaro.org>
Date: Tue, 29 Jul 2025 11:13:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Donghoon Yu <hoony.yu@samsung.com>, Youngmin Nam <youngmin.nam@samsung.com>,
 John Stultz <jstultz@google.com>, Will McVicker <willmcvicker@google.com>,
 x86@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
 <aINdu_hrz6zJnBGb@gmail.com>
 <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
 <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org> <87qzxznzjp.ffs@tglx>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87qzxznzjp.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2025 10:58, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 09:58, Daniel Lezcano wrote:
>> just a gentle ping for the question below about dropping the two patches.
>>
>> On 25/07/2025 15:15, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>>> So I got no answer for this question, but I suppose my assumption is
>>>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>>>> misattribution and a number of other problems, and also fixed various
>>>> typos, spelling mistakes and inconsistencies in the changelogs while at
>>>> it. Let me know if I got something wrong.
>>>
>>> If the rebase is possible, I suggest to take the opportunity to remove
>>> the following patches:
>>>
>>> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
>>> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section
>>> mismatch from the module conversion
>>>
>>> Because of:
>>>
>>> [1] https://lore.kernel.org/all/20250725090349.87730-2-
>>> krzysztof.kozlowski@linaro.org/
>>>
>>> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965-
>>> aa05-05836466f81f@app.fastmail.com/
> 
> Grrr.
> 
> I've already sent the pull request for the pile. Let me ask Linus not to
> pull and I revert them on top.
> 
> Also please reset your clockevents branch so next does not have the
> conflicting SHAs

There is revert otherwise above [1]

Branch reset to v6.16-rc5

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

