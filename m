Return-Path: <linux-kernel+bounces-897538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8957CC53843
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911BB425792
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA85819C566;
	Wed, 12 Nov 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4y0cpRa"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426611339A4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960832; cv=none; b=tkVgAwnHpDfn8ETE2qCNwRM72hdca06j3+JBCI7DGGEvoTiNEcX/hYZyJogGqZPqNA2r9tVp8lEQtq4deTP0VXLzrCDytSw5w4QI2jtBxSAdwasWnxovQKNtSsSedsgTgm75OcJw4XnK3MS/DN+7Dx431zYsq82ZwLqvxwJSr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960832; c=relaxed/simple;
	bh=rEpygOMMw7NwEYesZSUo2zkOakUI/YYLib06u9nMkGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkTPHTf0nv8+1cM4dVGX0nQoju3D3iY5p9rHzIjMytd5nOWTHKBqlS85dqYOTqk8NknVVJR70I++sIRDy61N1HyvqPAMnqtN4Wy17+kKre56lmE5V4cyCk/w9jDsh5rX2iqpH0aRueV3H/ft4HuwHs7lb77YbnrB8zrmMHp1y9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H4y0cpRa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47758595eecso5157495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960828; x=1763565628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fP98tE+6C4+JA6WXZcx1VIO3VTsbvfDFJnIQEdGi7xY=;
        b=H4y0cpRaLOTzhfKePTQ9WT5Uzjh+Se4UHUzXACXmb+odLUQYVvNINmesjBRo/StF7C
         6smS3xuwmBglmHTV9IMdSeS2zzkHrsRUBCpdXk9oezdtU1zhjgz+fRhpLoh8M4TXm6KM
         9+uNNzRXOXSJ5nRp8qo6WSX7boxbL2yt/OWkIFPZZXv7uw4rCTDmHXV4cuCmQAzDVDTw
         xhO9RRATPKhtYBK7i4KYK/it/Lr6oN5ZyQUiK75zSkgqsfiVyYDGdoIk2LjZBNPXkBgq
         yw6d2FSYF7txUXsrNif1QBU88z+jqQ3XWg+fE6Cxr+UFRIjmae8tDV/1JN/UFwabAUyh
         Xo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960828; x=1763565628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fP98tE+6C4+JA6WXZcx1VIO3VTsbvfDFJnIQEdGi7xY=;
        b=IrnqNLQr6q0eqxX6wie9joAcdkkVrAWqxrpBIYzz/YbS1FE1/pYcNlB0/Mrffrc2qP
         19IAF6nBOsX9x7oHA1SyVnUIjfkce9VdxSTtBHvTZ6rwOF1mcZ0hLLwPT0PRbkTdtbTx
         1NxfheVPA6pJfGOmmWwF/IknAlgkPNcMzknT6hbZJ2I7lKD15QcMK+6JXT+Ve/RhMoVt
         IUIdg/8kWW16+XpHofKhGxX89OuJFGv4UQnJ2lWFIPcq8t9jml6KAz1NBombLaYhh9b2
         oPLHCOF0QwQGu+i7KTe08DyHGJqrGrYCKhYX0gh362jKuoPMcfDTfSxKmyZsuUt/t0lD
         C4iA==
X-Forwarded-Encrypted: i=1; AJvYcCUNsRGjrCpQh4ykEyuVTrQMlTYE7LeAte6lIggZ9ds2LKLbN44uD988rTm0IYY/eJ2Uw3vpaz98yGP80Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHWG5m94yMyBS3Qspfa2mmTOUfUseQ2Cpjr7IFxCPh6YD4h+Qq
	r1YwmctKg+Npgcpdcl52sK/lFNG5CGq/YEr3fzEO6QWlaxINXZTsSvu7mSyejao4IuFAlzSknaV
	5SuSJkcs=
X-Gm-Gg: ASbGnctSB3yCnAngOkzinPOcaK+vICBO1eGP+KAezh5v0gxrYSvlc9Iea/NK9H4C+Wu
	fFe+2vZIeBBPHGEnMgzC4tH+zgjJnkqv+bxTNnJFqvI0BjQbhZNmdw+wi925F7fMigGVOaKMe6P
	VoioAxah86qtDFdR6BcN+HtLn4eIaa1w+2zj1Tz52LyHaf4opMKbsyHjytkvLwJ1KfO5eTCZPOC
	kVoSbePdjhgsoeKMh2P1VMv/E3WWrFrfaKJGEpiwk+zSsdy/9eY4/4qNSbNvu1i9rmvM2hCMD4C
	TjlBK/1NhS+RWIi2X9PmmW3yI6Q2kRT0DU36MG138jNZEGHl+TosyF2rpX/1vsd4D3vCDDVOMAi
	T1buViKQCNEEDdWZwWjySEo9IesRs1dNVNC1gldviP0D6Tx9TpLDnZrWHHdb/9IkRlvjYXKX0ZP
	Eii/Blcz7B80vL2+8ypyCAYUoMwrcwkg9Kw+ycEeUG66D/ESMQcK4w
X-Google-Smtp-Source: AGHT+IEprFPstSQ+3E3u6YiNYfO4Gol0Ya3k5yap0VxtuJKCAKc39SIMvK5oEgD93PdAZoZSQeoVgQ==
X-Received: by 2002:a05:600c:3511:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-477870b9825mr35270655e9.22.1762960828563;
        Wed, 12 Nov 2025 07:20:28 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d? ([2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477889bfda6sm16495655e9.1.2025.11.12.07.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 07:20:27 -0800 (PST)
Message-ID: <a964500b-3363-456a-bfcc-38ec289cc57f@linaro.org>
Date: Wed, 12 Nov 2025 16:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clocksource/drivers/nxp-pit: Prevent driver unbind
To: Johan Hovold <johan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20251111153226.579-1-johan@kernel.org>
 <20251111153226.579-3-johan@kernel.org>
 <6336a324-3597-4726-b2ff-fe0f561c59bc@linaro.org>
 <aRRpFWfgz0OYpdWy@hovoldconsulting.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <aRRpFWfgz0OYpdWy@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/25 12:01, Johan Hovold wrote:
> On Wed, Nov 12, 2025 at 11:00:05AM +0100, Daniel Lezcano wrote:
>> On 11/11/25 16:32, Johan Hovold wrote:
>>> The driver does not support unbinding (e.g. as clockevents cannot be
>>> deregistered) so suppress the bind attributes to prevent the driver from
>>> being unbound and rebound after registration (and disabling the timer
>>> when reprobing fails).
>>>
>>> Even if the driver can currently only be built-in, also switch to
>>> builtin_platform_driver() to prevent it from being unloaded should
>>> modular builds ever be enabled.
>>>
>>> Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
>>> Signed-off-by: Johan Hovold <johan@kernel.org>
>>> ---
>>>    drivers/clocksource/timer-nxp-pit.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
>>> index 2d0a3554b6bf..d1740f18f718 100644
>>> --- a/drivers/clocksource/timer-nxp-pit.c
>>> +++ b/drivers/clocksource/timer-nxp-pit.c
>>> @@ -374,9 +374,10 @@ static struct platform_driver nxp_pit_driver = {
>>>    	.driver = {
>>>    		.name = "nxp-pit",
>>>    		.of_match_table = pit_timer_of_match,
>>> +		.suppress_bind_attrs = true,
>>>    	},
>>>    	.probe = pit_timer_probe,
>>>    };
>>> -module_platform_driver(nxp_pit_driver);
>>> +builtin_platform_driver(nxp_pit_driver);
>>
>> Do not use builtin_platform here. You can add the tristate Kconfig
>> option for this driver, I tested it.
> 
> As I just commented on the cover letter, that's not relevant here;
> builtin_platform_driver() only prevents unloading a driver built as a
> module (which is something we want to prevent for these drivers).

I see your point, I agree. That is something we want to prevent for 
drivers having a clockevent.

Even if the core framework will prevent the module to be unloaded, we 
can consider these changes an additional guard.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

