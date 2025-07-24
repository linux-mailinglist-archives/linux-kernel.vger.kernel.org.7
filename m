Return-Path: <linux-kernel+bounces-744047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2F9B1075F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9361D188D58E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC9D25E44B;
	Thu, 24 Jul 2025 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srenrMbu"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E63595D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351473; cv=none; b=sm5ee/GWxATJB5ggiDwfRlYB68QipkZc6iDpNa/VwcSt9v/Z1DSjf6NIo4hkrJ/PEZ/0FggSOZyit1VOuKkSmN2ORtlsiTexcfWLvguE5RF4m+/fyRsdmCtOq7FQ7l7KR7R0AP+g79/3k62G2guAzeb1G/UrBBYMLOUBvul4Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351473; c=relaxed/simple;
	bh=bhBYQx+MeGt4Lw37gQ/tIsLuchXQxW10o5cYnX8zaNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0gaQ14xmLAuiIkMUqxPvOIh87ijb2mCWfKpWDEK8Tk749BjwnDUslcQ1TDQlHTZ3XJjCTvsGozCCIFQlZF7qub+PMSf3bvgc6RxyHpQ4pmg8ExgxBitQSPx7pq8CS3oDHHmM7VSEuTkKLOoPe1oAIe8lM3rzWSrkrXhs/pHYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srenrMbu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455b00339c8so4907795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 03:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753351469; x=1753956269; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lhw7338n0t1GGRiQcUMuvSi/SuBMhOwu4TUTadunMk=;
        b=srenrMbuNlbGEQCtiW/EnB/FqGzNxTrEqTc3gE1ElI0jW5k873it/lryUPU1KHpwST
         2ImehyVTIosWdaqBboEAHukRj2AWtFR7QFf3LLE4Tfb9YpkhGqdXJgoywiiJye8QT5BC
         2YldpgNnO80CCcnlXfTIANdTDnBz9FhMS+xqtU+IJweNjd8UV8C3pjD4yFC9/G6Ue/tS
         EJgb5n4kr+MH26VapI38LKRmEecaljPElLI9N8arnaxGAJawAfyH1EsqCc0pd4FIYQ2f
         7Ye2zE2of7TYm7suwJ3AdbxI+Ng/W7WtFn5OWVYpBfPlsmFv/Z3H5dw+Gk1IDdfqqYXB
         jWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753351469; x=1753956269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lhw7338n0t1GGRiQcUMuvSi/SuBMhOwu4TUTadunMk=;
        b=fxgQXYMTJFgV7HACN0Q65XbCP7nqwDAPoLU3ar0LhTiFqRrXJBiEusRosoUyyiYIjv
         7nWRNt2YeZMveJ372R+Td26/U0GLATaQ/UhgovPXBYvwJEFyOPXZ1Dip8HYq+qd13xqU
         LVA7K2VU8ggzZVlbnHJuX1Y3OFWVA8wFHzRH0rWag2Z5Casf3FBNugEfAgfL2gr6ZHPl
         iL3Yaqp9jE2OAyJOZn5E/XImdTGHailb4hIJG4RTmQdRMHwcs7b7c+kY+n3BY+PyAnr2
         NUyGaAYZIfEN6GPGVwiJmVYA6StmBHTgglvziqEV3i+cRtEzSuoleuT4IZAAszzO6jlf
         wGng==
X-Forwarded-Encrypted: i=1; AJvYcCVjqpdFL8+V55z39BYbCL17X3gwePEdf+sx/LtQiEIN3ApdispxpmcteeNzVsiS8AP5OvArX6vhOOiMZYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbRbJNUoe8IWYrCkIEjjNQZ7eII+7uPhzW59hYMs9HKTrSh+d
	gU4w6euF5MWdCMjWrg7mXpjI3DJChbTC9V13Ts9xRMKRdfcEd8tTc6stDFPDESwck7Q=
X-Gm-Gg: ASbGncuIZIGcoIJoJEAmFiy/mpjuYI1+0JaXJC2aLHleTF4SnIl8nvHg6YiBkkFIhkR
	C+vULdlYSRXuAtYHYUrCIfGqQlQ3EcxRvDmzKFLMDeD0+h9RGt+OnQ72xXBnjDZQfV+49Wc/EVS
	KuM33ZK407sNAEabONiN2aMMRqQO0QQKIipT3/Ks8wEhcCNDEgh31ZetG1uXbtwSTuAdndXauZi
	alr9rIKO1u/wkRMmLzE1gp6Newq0M1x5mL1dBj7Dm9vxw9vfx4GqQm1bYjNH8bDDV1AQpv5++SS
	bN41WdpCfNBU1Ozn5yMsPiPD6rKRGiWdNchwj5r/kMXkZhqokMS7ivJG2miyg0lkAcGm0gaN1+5
	CibQ3DVmNZoM37G6Ehw/vIlyHZxuN82TMCxy9ovJeK3PHnh6Li9tgHntQZfo/cQ==
X-Google-Smtp-Source: AGHT+IE/bHkCvtJGwkyeQKWM4rKPlNT8I8me++cHytkHfdfTfpSocT4TZtdl+nCNSujmBTMfCyIjig==
X-Received: by 2002:a05:600c:6488:b0:456:26c6:77f3 with SMTP id 5b1f17b1804b1-45868c9408fmr51113315e9.12.1753351469453;
        Thu, 24 Jul 2025 03:04:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705c4cacsm13878835e9.24.2025.07.24.03.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:04:28 -0700 (PDT)
Message-ID: <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
Date: Thu, 24 Jul 2025 12:04:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aIHBnFESZwjpXzjr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/07/2025 07:16, Ingo Molnar wrote:
> 
> * tip-bot2 for Will McVicker <tip-bot2@linutronix.de> wrote:
> 
>> The following commit has been merged into the timers/clocksource branch of tip:
>>
>> Commit-ID:     394b981382e6198363cf513f6eb6be4c55b22e44
>> Gitweb:        https://git.kernel.org/tip/394b981382e6198363cf513f6eb6be4c55b22e44
>> Author:        Will McVicker <willmcvicker@google.com>
>> AuthorDate:    Fri, 20 Jun 2025 11:17:05 -07:00
>> Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
>> CommitterDate: Tue, 15 Jul 2025 13:00:50 +02:00
>>
>> clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64
>>
>> The MCT register is unfortunately very slow to access, but importantly
>> does not halt in the c2 idle state. So for ARM64, we can improve
>> performance by not registering the MCT for sched_clock, allowing the
>> system to use the faster ARM architected timer for sched_clock instead.
>>
>> The MCT is still registered as a clocksource, and a clockevent in order
>> to be a wakeup source for the arch_timer to exit the "c2" idle state.
>>
>> Since ARM32 SoCs don't have an architected timer, the MCT must continue
>> to be used for sched_clock. Detailed discussion on this topic can be
>> found at [1].
>>
>> [1] https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email-chirantan@chromium.org/
>>
>> [Original commit from https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6eb8dd00727
>>
>> Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Acked-by: John Stultz <jstultz@google.com>
>> Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Signed-off-by: Will McVicker <willmcvicker@google.com>
>> Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> The whole SOB chain of this commit is messy and has several serious
> problems:
> 
> 1)
> 
> This commit has misattributed authorship: the first SOB is:
> 
>     Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> 
> but the Author field is not Donghoon Yu:
> 
>     Author:        Will McVicker <willmcvicker@google.com>

Yes, you are right. I should have pay more attention to author / sob, 
thanks for spotting it.

> 2)
> 
> The Reviewed-by tag is misapplied:
> 
>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
> 
> When someone passes along a patch, it's implicit that they have
> reviewed it.

Well my understanding of the SOB chain for these is the Signed-off-by 
from Youngmin is in the delivery path because it went first to the AOSP, 
then carried on to Linux by Will. Then Reviewed-by Youngmin letting us 
know the port from AOSP to Linux is ok.

> 3)
> 
> There's also a stray Tested-by tag by one of the SOB entries:
> 
>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
> 
> When someone passes along a patch, it's implicit that they not only
> have reviewed the patch, but have also tested it to a certain extent

In this specific case where the original commit is from AOSP, this chain 
seems to make sense. Souns like:

"I was in the original commit delivery path"
"I reviewed this patch carried to Linux"
"I tested it on Linux"

> ...
> 
> 4)
> 
> Why is the 'Link' tag just in the middle of the SOB chain, instead at the end of it?

I don't know. Link must be at the end  It is stated somewhere in the 
documentation?

I use git b4 -s <msg-id> and the tool adds the Link then my sign off.


> Presumably this is the proper SOB chain:
> 
>> Author:        Donghoon Yu <hoony.yu@samsung.com>
> 
>> Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
>> Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
>> Signed-off-by: Will McVicker <willmcvicker@google.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: John Stultz <jstultz@google.com>
>> Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
> 
> Correct?








-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

