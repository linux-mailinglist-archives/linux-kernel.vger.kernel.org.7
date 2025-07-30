Return-Path: <linux-kernel+bounces-750722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F50B1603B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6181818C70B3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358727E077;
	Wed, 30 Jul 2025 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIxdnV8k"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E174413CF9C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753878153; cv=none; b=ob/OXvyUK8XQhyNslcm33ILQb/fhTi++zkTsXcBNyb5nrL1HKDAUaXXv+nGHi4QQHDMuZlRdFePNk4pHQguGdApqnFVSPiOwIQdQwM0gOGypmRHXqbzlLvRU7t+eomYIXfWPxTqmmniXI749N3+AuHedCKD1BhXjX9JJQaqKrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753878153; c=relaxed/simple;
	bh=EM2SeeEDeL1kFD6kgQfv5p7+jZ0ToNtVz+ZdTeIR22g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKQKZFZQP8EDsJwokUapUT1/yecBLNP9tzayin3ygrnadM37dKZB0ni9qik1aennF2DwcaRVvLhHjZod20an6QoQXUv+xLcB9X1+9WJ4ZqCL4daHWI+8ElOYdvXUHdcpnL7JlmD3CUta8p1SCxTZHrp104GQs+TNNSCuaBAEsn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LIxdnV8k; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-454f428038eso57948455e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753878149; x=1754482949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUEKxJ5rgjXe1YyHgv4NRENeR2LO4lvKY16JCFZwTMM=;
        b=LIxdnV8kCrMKGgqQ5Bv/xbqFtCQzWjjwm/QU5/ONatS7oxPEubepeB+84Q8x7o+Pve
         LRRgyJLZogPyRFOnnjte3+ofVIWrzVGNWYFMNeHrsYf0rJl3CM/GwZ1LBuSHFAe+d/nO
         LohKWbka6nTwCGhpQhac0CzQthPfwJe4SdZmhxEBEuC5JBu405uvS8SzMFD5o4O0vuop
         8T+hMhD6VK3vodtT2CmTbfjTRA57kfJbRrLQOhBZc85ZAWlyiv2IrgMCHrUxUa0yCVyY
         RDfpzCpzDlFj2P+BjJL5ND4Cxh04piLFzjTrpMrc7IDoaWfUalUvgS4qjpJnqWs603a7
         QJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753878149; x=1754482949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUEKxJ5rgjXe1YyHgv4NRENeR2LO4lvKY16JCFZwTMM=;
        b=XmL9JIXF4GzGWCoSE0MtamxQF0tzW5Do6Q8kMuM8qdBFgYQdxQyQ9hpra+SHVFU/tM
         rs01UW2HLDYc/oSAG/uoy2IULFo7n5N9Mu9BW7A9yAOMLsewoVDpUzdvouEi4X8EA/t5
         Tq4SUIHbr0ijA1oBFGbDtNoIUlb7+G+UIQKng8uiikrRXIJ7o/96o8/viiTNC5T94P8/
         LMEwmg1SxkII0EpkmHOtB3bgHiebDYrMoi7XkI3Sc7ukSRT/yum+ac38+hamMvuDGVay
         QMGyIxnjwiSF0EnJnGxHzYxcHSrLsNUAbXV6VJGnSIIo/+S98+zkIP7ZIhSypAiGlgik
         c3xw==
X-Forwarded-Encrypted: i=1; AJvYcCUNdebk6gPVS3VC9XhoXfmTB1g40hWBPiE8COuUgSD2NmbOCmXLNg3xcWH7lJlg1UcTA2B4ILMK+0kR5aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF67oaSwUGDnAd2sSOYbARViTWg2tr0FMk3mDYY9U9UsAY4JRx
	AoYI0YNFnz6e1AaKfU1zDwjWxQiOAJgJFzGiZIoJxcO/t2JtnvF6h6KWgL8l31cH8cY=
X-Gm-Gg: ASbGnctlzFOBDrl3EyI/vac6ZJahRJPC2wcogCTbLFFHwh+tKAH+9Gy2Dxzia505po0
	upnT0PJa6ZBVzFHvyXOMPksHbSzDNOcmlDhcq7+H1h7+j5w87G84nTah7XKz51wCCAnK/p4YDmT
	32kHPpOKYosoUDv58GJms4TFXkyjnFlrnww+rLi98C5YjpcnyloWOu5DZOIbApz3EvE11XryWx7
	LHN0Oyo4M4WRQlcTkfGqP21g/XAn7UJPDMRBBKWnAzxwpDnGZUpb6ntqIy5ZQHN7il8t64qhZn+
	pGtzIFPem6/sF8/gJu77xiW5Xe+DsdowpCiZisp8SDZWIgVv/tGdhuRhzcdPykURznVpTelMpAU
	hv1suYpmV+TkKfelAdKHcGesPcjVWTpYBQjg9RGmhKnZpxb/bW9jg/afGE+qnkw==
X-Google-Smtp-Source: AGHT+IFHgIPDAvCDwsGBDdTU9OFJARdnfPOtF5aFPjgRrA/x3zrrr25gAt3sbRb8qonK3Xud+Sbecw==
X-Received: by 2002:a05:600c:1da6:b0:458:6733:fb43 with SMTP id 5b1f17b1804b1-45892bbf7f3mr28149845e9.19.1753878149097;
        Wed, 30 Jul 2025 05:22:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4588dd375e0sm45991465e9.2.2025.07.30.05.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 05:22:28 -0700 (PDT)
Message-ID: <e8e2bc93-1639-433d-9689-d1ce9f28b877@linaro.org>
Date: Wed, 30 Jul 2025 14:22:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the clockevents tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Donghoon Yu <hoony.yu@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250716160809.30045a56@canb.auug.org.au>
 <20250729114037.03a2d884@canb.auug.org.au>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250729114037.03a2d884@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2025 03:40, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 16 Jul 2025 16:08:09 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the clockevents tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>>
>> WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x324 (section: .text) -> register_current_timer_delay (section: .init.text)
>> WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x4c4 (section: .text) -> register_current_timer_delay (section: .init.text)
>>
>> Introduced by commit
>>
>>    5d86e479193b ("clocksource/drivers/exynos_mct: Add module support")
>>
>> and possibly
>>
>>    7e477e9c4eb4 ("clocksource/drivers/exynos_mct: Fix section mismatch from the module conversion")
>>
>> For this build,
>>
>> CONFIG_CLKSRC_EXYNOS_MCT=y
> 
> I am still seeing these warnings.  The above commit is now also commit
> 
>    338007c44c7f ("clocksource/drivers/exynos_mct: Add module support")
> 
> in the tip tree.

This should be fixed now.

Also the clockevent branch has been reset.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

