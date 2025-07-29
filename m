Return-Path: <linux-kernel+bounces-749669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A628DB1514D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75963B5DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06594293C58;
	Tue, 29 Jul 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xz3JdEo1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9438D286897
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806475; cv=none; b=aBfwpfd42Pe1kGSukATQAMyPFrpNkpnbA4hgVLcSSDiCG7GykeizRMqHW1f7BdW96gddYngxNACToIrzvWzYwQ4VdXzZuNBhNSYkhenbX3JDClCc9oHVVPHFdPkx1PurYDUCShJZkZHhwvp4e9tT6hV8eFCWwSIxpgGnVoq06Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806475; c=relaxed/simple;
	bh=PtfTh9/5EjYP7cCIAc8vupIcGt9u0ol0XId1dZQt8dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKtuxesa1VvxW3tKyQr/2jfVxQM6yx3/b+lvkBYX8B1geC5j5hPHYIyA53B9iWx2Mp7KpjdYS3IlRQFTJ4YZ2v1FVIoCEn2k/cTtOODLhv+7L3aUrdbaJY1gix2mlUS2K2nFleUA4qgBU/G1V4MC9qIkcf7aWdeaBxLxVcu/oPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xz3JdEo1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so63363595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753806472; x=1754411272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A7RLDUsOcYWlXRCgS940bPzn/qiZ8ZUn6ZRMAh3pp0=;
        b=Xz3JdEo1vTiVV1LUV3aFRg5RmxDY0xrWmb7ZCOnKPz6FpBTcmlAOMDbRSamldghP5Y
         XgrZBBGUg9PDCWJd/e1B4mevc/vtv1CgX69PXY/pTAgt8vDH210LYlpwjUEv5kw5Ow97
         rPVKcS2FivD7Y4aqGpjNEpiQiTQzz8qIFTuQnoXBKscVZaKgiDMbHf4X//aT5D3L3/lA
         h3jHXfES+R9+fylB52mDCfm0V8YiKZcT7tPsuwz3N5O6qbX/J6agT5yPs1P9zNpqG6DE
         4oyTS5LwxsVHUJohxeLwXJeqRotF52CNGeDf+a4S1W49Kb9vHDP316EN+E0D1uORIa3g
         RBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806472; x=1754411272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A7RLDUsOcYWlXRCgS940bPzn/qiZ8ZUn6ZRMAh3pp0=;
        b=AKQY33BSqUuj0/TUphq1a61yCXUO7++ZVdrxYF6xX44cg7U509IjOplZ4ZkaTJLw/v
         B0xMC9tYLTp2SoTm8MxhbCn2Uf5Pc+Kf1BhAS9Jos7LRiiDdx9Me/EZOiuxM/+Nssk08
         AIWsd18Qq6fglI6e8An9PzlenyZ3849zvPl6wM+fCFQSiF+KxEdJSvkPYrLyW52ybxUa
         cM5w8tY+alpHfcIekPwUa2mn/wssztCe1cmGDKDGBTxDpLImDC4g/end+Ib00Luuh5/u
         y7GPZn+06i78+tlPfxYUMallt0Z/jKYMu+chvHL2qYAByWUc71JzJc29JyGncLovO5De
         pz9g==
X-Gm-Message-State: AOJu0Ywtf9669Yq+QS6IyMrfxWg/8CtMUaJv2Qc2dlXB1NcESfTmSKpZ
	QSE4EsA64Z9L3/6AQ1B2Fe4966kqzlNzpXoX3pEmyZjmr73nOwlX/fPRb0Uu6PgyCPw=
X-Gm-Gg: ASbGncs75NGyqkeWAU/S6P5gZTPHe2sb2w7mNxwWRE1RY36oNgn7x40KJYgWXBbOeVo
	FI1413EJQ/YjyZeJhmGYIxGfPtUvuE3rtEnFrv7XWm3d88y+aX6WzwIO0thoXqaVLvoPYB3Gn+y
	Q7r1FcJdMUp07+El54STL7FN/QAOCV/7CJtU2Lwf5cL63rTI9ygEm6a/FAfjENjWNiWLSWsRCq0
	R0eZMPPPZoklTM/4dBQxXLhfiUgGg4Z9F6OAkrWHyqp6HNTZYCceSw/gX5CbbXeHBaUSgMpZidE
	oIjCpGxDxzIEIFx2C7fBTohDjbbGodjZj5/z9Fr4AIfpn90YO0XLjkhNLB9JYMhKAwtUHdiM+mH
	dYmoABG+oZEvR1fZVMt+lvWK4uP851SKuIZ6w4eJ8roZeBY3GRhvWKcPURXBMTQ==
X-Google-Smtp-Source: AGHT+IHp9Zc3/dVoGDvaHUfbhAcLiJnGhZKm5gZA3joiIGW+r5lfXTxBNZ3YixZSGe6e8hK+NWThpQ==
X-Received: by 2002:a05:600c:5195:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45892b9da2dmr5059105e9.10.1753806471744;
        Tue, 29 Jul 2025 09:27:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705ce685sm202071465e9.30.2025.07.29.09.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 09:27:51 -0700 (PDT)
Message-ID: <f66b5f8e-da7b-4a24-b87c-7b563d9f14dc@linaro.org>
Date: Tue, 29 Jul 2025 18:27:50 +0200
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
 <920c5a0c-6ac2-49a1-8dbe-17761379765e@linaro.org> <87frefj7pd.ffs@tglx>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <87frefj7pd.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2025 18:13, Thomas Gleixner wrote:
> On Tue, Jul 29 2025 at 11:13, Daniel Lezcano wrote:
>> On 29/07/2025 10:58, Thomas Gleixner wrote:
>>> On Tue, Jul 29 2025 at 09:58, Daniel Lezcano wrote:
>>>> just a gentle ping for the question below about dropping the two patches.
>>>>
>>>> On 25/07/2025 15:15, Daniel Lezcano wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>> So I got no answer for this question, but I suppose my assumption is
>>>>>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>>>>>> misattribution and a number of other problems, and also fixed various
>>>>>> typos, spelling mistakes and inconsistencies in the changelogs while at
>>>>>> it. Let me know if I got something wrong.
>>>>>
>>>>> If the rebase is possible, I suggest to take the opportunity to remove
>>>>> the following patches:
>>>>>
>>>>> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
>>>>> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section
>>>>> mismatch from the module conversion
>>>>>
>>>>> Because of:
>>>>>
>>>>> [1] https://lore.kernel.org/all/20250725090349.87730-2-
>>>>> krzysztof.kozlowski@linaro.org/
>>>>>
>>>>> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965-
>>>>> aa05-05836466f81f@app.fastmail.com/
>>>
>>> Grrr.
>>>
>>> I've already sent the pull request for the pile. Let me ask Linus not to
>>> pull and I revert them on top.
>>>
>>> Also please reset your clockevents branch so next does not have the
>>> conflicting SHAs
>>
>> There is revert otherwise above [1]
> 
> It's incomplete :)
> 
> I just reverted all three exynos mct related changes on top of the
> timers/clocksource branch and pushed the result out.


Thanks, sorry for the mess


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

