Return-Path: <linux-kernel+bounces-863628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA028BF87E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54274581A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FE62652AC;
	Tue, 21 Oct 2025 20:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpCnA3lU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F31A3029
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076933; cv=none; b=V2tduvTyo2FCMfUUrUS5NW9InStigJB/yBW4rELCX+QtDs2oiQIzBJY1ok7pcBm4WFX0rSU0K5x+tDCfUh5sknqe3aP00Fv7UXGfM0efbKcm9DN63V1VDkKRRng5BmwTdymW9ANI4un+BrMNfxkV/n1yDYQXI7HiHj68R/YxsHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076933; c=relaxed/simple;
	bh=68X/TKhrrRDjDEYu7sGPgAgyJh2anhZcRRb5J8PdFcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhTrR36dxaX7aDI2xEyJTjq3mEiZDBQv5UV7O4FR2nrPsc+yuN9pPmutX5zeBq+4Gsv3c0ANCzsgvjKIeWhbr6eD53M9rLk3HJ/KiKiquNBXynuFYU7c5pKlf1XbFprW1kI5ZQS+o0dGuMSnBPLJDanLJb/WTQAtJg0Zy4TVkO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LpCnA3lU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47116aaf345so7000755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761076928; x=1761681728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fPfIblKB1aVXjgqE72MsRVHT2MJH22sC2UAwSNaZH3M=;
        b=LpCnA3lUzvE55/yfZNw8Z1eutRXTlJ2iSP6tQBP5JdfkcNfwenstcY8kWWZjHh20u3
         VDbfhEKMNY3NlQVLZO2g70SqWdudbBfeQIM/cyGKS8ihisAe8nX3EvHt/nxcKZOvu1kM
         6Y5vJBYfoHYh28inm3KRxYg+378xj8SMq0OJM+Oh7Lv8vmXcKuo1BFuviI/ZuRKQS6Rf
         hiGDX4OZwJ8K7lU89fRKSjT0xzCWXgVfKJ4qGq/cKO+EnjfTL5pq7/RetlrzBKpJLT5Z
         Bb3Hc9PDOnIOZeoQ3qXR222PFtek8rubahJ2xwHBE/Yln73PwtxNnRixomx7apy6YzLv
         JLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761076928; x=1761681728;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPfIblKB1aVXjgqE72MsRVHT2MJH22sC2UAwSNaZH3M=;
        b=gcjeXfHqwUqQGccQtxjzXIYhrtAmQeTJC5J/sdaqYctod8ok4dm1MRgMJ+WTeoqlfo
         OcEtan3SHQWFHW/tHHtr8lJRaDmssJcZ2X8NFmlMqLcJKkq6D1CoS89isSxdt0VCIcP0
         jI547UrTob1mQ59g85mFKjqptmDCHb4OhXsayAmUGGrTE1l2PrOn3lJIGswlqYVsxrvf
         J12yHLY8VmsZ1nxh5c1OQFkmC80bky0syvcRC4qdaCKWNTarO84x/qk9bCpn6HQHUP6R
         BtFNpIZ5Cy0C1siJkdam6cNzm5tFcBe95aWyo65AStjQhjangvwbJFG/cvOGUMhmvJWK
         7mHw==
X-Forwarded-Encrypted: i=1; AJvYcCVxGHxaFtNionxbi2anpJN/4Nvp/MgkVK/5XG+cK16kdAnQu68Ke93dEA25Wz3xiAsWDTPv31dZUpUCn4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRq8kD3v3DV4iMyntVbAAjilPXOKP9yx5vDBN0sygf0lRvwNW
	zwWvvNaOevhEMzdvzQPnfSGFPfrCDlsc8AlJwuxH1WifPJe0FS3zJvzT8zEGMwNiAaw=
X-Gm-Gg: ASbGncuO3ORucQ5CeS4p5FA8coCwLG3xt4tQ3QaqjusPHGogy8YIz2cv1INmBjLO9BI
	dZ5XNdQzy3vA1sGypVhlSWNpJykrrOxFvFsFpKDQIQbQVq2VpcBO044jrcCSjE8LfDz1rK3301e
	JxaYd97QKuc3hUmAxd6uiYeuUV71MZk1E3lX49HXQ6N9y2ryqD1KaSZYSDs3gSYGCjQXbNvfgoL
	V+23ia6YIapzv/9CHO9GcXUt56WflX85fVH2sSrxlLznNEcYubbnH1MBNK67uJDll1jfjvYANhJ
	mF67UZidj0IJTfH+WP9Wugk0NRuB9/i1jS2NNO/ljiBrPmautBLyxBNl4shFIse57Z0RWQXoXVi
	FyaacofMfBMCY36/AZ0FmayYj/hzHPnAf/WSUy7N3lp9jE1bKFqJxYEzRC7/vzj/NpUYYnKXJ1a
	XdocufiL8TvNKyNSotgk7B
X-Google-Smtp-Source: AGHT+IH2PCh10EGWGC8baP3sMoz7knk4da/N+N42fjmQaDFcdmVjFaFtFR4Mlufp0WtiU9Fco43Mbg==
X-Received: by 2002:a05:600c:3513:b0:46e:43f0:6181 with SMTP id 5b1f17b1804b1-47117921447mr65677625e9.7.1761076927958;
        Tue, 21 Oct 2025 13:02:07 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f77bsm8568715e9.3.2025.10.21.13.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 13:02:07 -0700 (PDT)
Message-ID: <ea7e6e43-c9fa-4ae0-93d9-8837ce6a6b63@linaro.org>
Date: Tue, 21 Oct 2025 22:02:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
To: Peter Zijlstra <peterz@infradead.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Breno Leitao <leitao@debian.org>, Kriish Sharma
 <kriish.sharma2006@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, Menglong Dong <menglong8.dong@gmail.com>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Aditya Gollamudi <adigollamudi@gmail.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>, Dan Carpenter <error27@gmail.com>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
 <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
 <67e75a68-7a03-46bb-ae40-b1a8f24c0b16@suse.cz>
 <20251014103439.GU3245006@noisy.programming.kicks-ass.net>
 <yc3bcn76b6jcdcbnoegwi6bigccor32fuevg66o2lqdewem7dc@nvujb2gazknq>
 <20251021133018.GV3419281@noisy.programming.kicks-ass.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251021133018.GV3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/10/2025 15:30, Peter Zijlstra wrote:
>>> People using W=1 and WERROR can keep the pieces. Anyway, this is a much
>>> more coherent explanation that the original patch.
>>
>> Can we please get this fixed even though you don't bother about W=1
>> builds? There seem to be others who do. And note that even
>>
>> 	make W=1 drivers/pwm/
>>
>> is broken due to that, so it affects also maintainers who only want W=1
>> for their own subtree.
> 
> Only if you have WERROR=y, which really you shouldn't have if you use
> W>0.


That's not correct. I want my code to have zero W=1 errors and way I
achieved that is that I fixed all the warnings and now I build code I
maintain with allyesconfig (so werror) and W=1. That's way I am sure no
new warnings will slip into subsystem I maintain.

I recommend other maintainers also not to introduce W=1 errors and don't
accept patches who introduce them, even if that patch (like in this
case) just re-shuffled things and made some non important issue visible.

Why? Because we anyway do not want W=1 errors in RC release...

> 
>> Regarding the Fixes line: Vlastimil Babka bisected it to 378b7708194f
>> ("sched: Make migrate_{en,dis}able() inline"), but I think this is just
>> the commit that made the compiler notice that. IMHO Andy identified the
>> more plausible commit with:
>>
>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> 
> Right, as said, Thomas is rewriting all that. His first patch is a
> revert of that commit:
> 
>   https://lkml.kernel.org/r/20251015164952.694882104@linutronix.de
> 
>> Note there is a lkp report about André's patch (i.e. the first in my
>> list above) at
>> https://lore.kernel.org/all/202510041546.DvhFLp2x-lkp@intel.com/#t. I
>> don't understand the issue found there, but maybe someone should before
>> the patch is applied.
> 
> That's unrelated to the patch in question -- it is the robot
> re-reporting a smatch thing because the code changed and the new report
> no longer exactly matches the old report or something.
> 
> smatch wasn't able to discover the relation between next->mm and
> next->mm_cid_active and warns us that next->mm can be NULL (per a
> previous test for that) and that feeding said NULL into mm_cid_get() is
> a problem -- it would be, except next->mm_cid_active cannot be set if
> !next->mm.
> 
> *sigh*, it just means Thomas will have to rebase his series -- not the
> end of the world I suppose but I really don't get this obsession with
> W=1.
> 
> The problem is really that I'm now mandated to keep the scheduler W=1
> clean, and I really, as in *really* don't care for W=1. A number of

Great, so since your code is quite important and I cannot build my code
without that part, we are all stuck because you want W=0 compliance...

> warnings there are just not sane, like that ludicrous unused static
> inline warning.

That ludicrous warning could have been fixed when it hit next, because
it was not hiding from you. Building with W=1 is pretty standard thing
for new code. The truth is that that commit was applied shortly - few
days before merge window:
1. my earliest report comes from 26th of September
https://krzk.eu/#/builders/135/builds/180

2. Merge window opens Sep 28.

Two days in next, great!

> 
> But sure -- send a patch for this, with a coherent changelog. I'll be a
> bigger pain in the arse the moment the 'fix' really doesn't make sense.
> I'll probably propose removing the warnings from W=1, like here:
> 
>   https://lkml.kernel.org/r/20250813152142.GP4067720@noisy.programming.kicks-ass.net

That is fine as well. Your subsystem, your call, but unfortunately we
cannot build our stuff when yours fails.


Best regards,
Krzysztof

