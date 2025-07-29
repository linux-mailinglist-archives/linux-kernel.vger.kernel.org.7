Return-Path: <linux-kernel+bounces-749068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537AB149A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9590E3BFEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B626B0B6;
	Tue, 29 Jul 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEvEmy/p"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B82192FC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775892; cv=none; b=DHQ0St2BV4uaBWskitFjMerQx2HUPG2cHbUKuf2JbQZgY3DzZEVqgJy1AbMpv+weJCOvUNT97K1WtaT857f+jGP3HNcqmEogbLljqKJehOFwU/eChDz0vV2xmLN3jKTiwxPbU6G0oTKqKMfS+wvGDOSnJ2qXKO/u4oTHy29mDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775892; c=relaxed/simple;
	bh=AbTOM347spOloDSOG4nl3ZHZIS1SePcI8qYC399qLTI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AH9NlXyMazxdWhEnYwGcXMJ/RgNeXIBw/fatP6xqpp7GxV1HKkgepIjgnClbALtJLmahbn19So5dCNfjmyjz8YpKA/ilLZLuiJNlDXnzjANMeaFuC6Q43AhVM/2IW7IZzsCATH8Wsb0Ml10f9ZW8JjRgZM+0eHcWPiaoXvNof18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEvEmy/p; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b77b8750acso458057f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753775889; x=1754380689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9nSRUdmOtFwIfWjaocj7a2xYBLBsc7tk6nknvXHnmLE=;
        b=VEvEmy/pto9TLgswrHw+6VJkbLFNG4DC6gr4wyHNlv267zdIM/vEXO6gwYlFNei0Qu
         PSV8SfKtWWn12zobO0JB5uYhDOLHOOJvPUnyVAjIg5EDHkK4LwFjrVpIcalC87aIp1Dz
         yuocFYgKs11Fjz/gS8LY4jFp6h36u7rcj4p7z4QPTs5PPJT1pbyed2Kaei+7p6xVAZ+T
         29OrebzNMW+XIxQiutChcMtIOChdmG8zRE2rxeaYRyzrhKfW5VE+keU88PoDfCZcZqUo
         4F3vh7tewsc6HQpQDqx503ZvTpoduDyh69uu6Q4FvsUL6sIFSs+rHY9soPoW/QLHMgf9
         9arA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753775889; x=1754380689;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nSRUdmOtFwIfWjaocj7a2xYBLBsc7tk6nknvXHnmLE=;
        b=XwYKzsjv6XMSQZCXAnb1PnzFVFfAvLE0ju8SsL08wqPJc3mNBC65fsbjGbciUGkvud
         g902w/eHIXJAP8n6VarSjiop1F5fNKhwdwExs4ytjI38cMM1e0YnpMH1v+lNjlxNqQq0
         Gg4OyU8V8EgUJ49J7Ci/xyXLAbuqFpGAaOtZXF1/fD30TFOUOuNQcv64m1ECv/4KPzhv
         oiNLAo5/8Shexvreeukj7soe/aLl/OgEO5PYQ5QmLK0mtF342sqfxt+QP8uUsXbMmZ/P
         GG/B5/Gk4PDCb7QQje4y3B2vKfYyJ5thb6Du1CzoQNfIcfDwFGb40vcR5tVw6Pd39tnd
         COBg==
X-Gm-Message-State: AOJu0Yw78kz8G4j6mdpZfenqBYzRfXoT24b/G1sA8ziGypJGYc8OuwGg
	aJDFCKmzR07s21LDRUHc6XLy+5gfdfcJnv2k49KSkC3+/yAVbVRdo3jmsId0+OUIs2g=
X-Gm-Gg: ASbGncv9ssSzyhuxR8Y/lVp7EnOW8IkzOiRW3+1DQbnGa1p3+IPztsBP0JqjXz9cLit
	yWYBO0c+TtrfPIAgctdkMsVppJshvR0vYONOpO4k6m5gjzp4g1WTD/H8ctp9876aaMP4fv8ylBh
	4K+B/M0XpKMm1cpac0MBQpxjry1q/ZvqccIaZgOXXsdD0aPhRnLcUbnXDP37yVsQHi28aDo/Nec
	wkow1q4KOT25mWoePSxWuCgJbJPU8fmNhFnjaLhYzpMRHXOgGQ2YZ5iOEvqoz1QqamBgsS/Bl9n
	ZVu60SgwEorTrNQBVYQcY7BbzRbXlmPZcgY/7ls0VBWNWMfFo7ffpqCdwIzRBtpaS3uie/5Si6y
	DyCII5sLnTejlHDGYIqLCs6/Bm/HHuS+5Mr8Uashqm0w07qmxaJIYXod2mDHyKw==
X-Google-Smtp-Source: AGHT+IGhmQCAt8Nrwl6CzOv7wPCcFH8G36gaFS3yKtLiEMiKywzAOyCeXI3zYJATdeJPcC3SqG6aYA==
X-Received: by 2002:a05:6000:3104:b0:3b7:828a:47df with SMTP id ffacd0b85a97d-3b78e3dd9a6mr1545125f8f.4.1753775888693;
        Tue, 29 Jul 2025 00:58:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b789a31c4asm4888771f8f.17.2025.07.29.00.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 00:58:08 -0700 (PDT)
Message-ID: <162ef225-51d5-48f5-bc00-36e00e905023@linaro.org>
Date: Tue, 29 Jul 2025 09:58:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linux-tip-commits@vger.kernel.org, Donghoon Yu <hoony.yu@samsung.com>,
 Youngmin Nam <youngmin.nam@samsung.com>, John Stultz <jstultz@google.com>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
 <aINdu_hrz6zJnBGb@gmail.com>
 <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
Content-Language: en-US
In-Reply-To: <8a0662b7-2801-47a2-9c91-4eb0e7ef307b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Ingo,

just a gentle ping for the question below about dropping the two patches.


On 25/07/2025 15:15, Daniel Lezcano wrote:

[ ... ]

>> So I got no answer for this question, but I suppose my assumption is
>> correct - so I've rebased the tip:timers/clocksource commits to fix the
>> misattribution and a number of other problems, and also fixed various
>> typos, spelling mistakes and inconsistencies in the changelogs while at
>> it. Let me know if I got something wrong.
> 
> If the rebase is possible, I suggest to take the opportunity to remove 
> the following patches:
> 
> commit 5d86e479193b - clocksource/drivers/exynos_mct: Add module support
> commit 7e477e9c4eb4 - clocksource/drivers/exynos_mct: Fix section 
> mismatch from the module conversion
> 
> Because of:
> 
> [1] https://lore.kernel.org/all/20250725090349.87730-2- 
> krzysztof.kozlowski@linaro.org/
> 
> [2] https://lore.kernel.org/all/bccb77b9-7cdc-4965- 
> aa05-05836466f81f@app.fastmail.com/

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

