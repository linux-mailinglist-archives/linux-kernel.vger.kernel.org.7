Return-Path: <linux-kernel+bounces-896926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C20C51899
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A79189F730
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5DC30148E;
	Wed, 12 Nov 2025 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3Gk2B/G"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B12F5302
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941610; cv=none; b=Bt4XfIGrjaXxuxTOwg5jb2HZxOZDQgLaJzbTBr5vdVmtEq7v+bhtY/LGABcLJeqNkmz6vp3pxXUoZzUHtsrdKEiDXHnDOMtikqrFvZswRCIfTTK0TwO1Bc8oBirdYqr6YBy82c/xT1c6WtmK2R0jb+ATzib19HXRdWrVecCXoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941610; c=relaxed/simple;
	bh=mCHVGSY5nG2xTagjSNTDjVhzMzoCaNY36P98eDp+ROI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/OQKQ/8QLcDQ0dTjHvl5U2d62ei13vm/X+u8y6+SG6kK0XNrZNYeYQiPMEMYxzKjucgT7/OHBr6c7Dpsg0JSKgThOsszvBvYMCZ+NfshkKMjY/RVwYwuK44XVZ2YHb9BTB/8aJ402EdlTl6yDKj5MqFLGIxWp6YK/hHIvrJwR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3Gk2B/G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477632cc932so2661455e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762941607; x=1763546407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8f8+DXKONCmTI8/qphYme8tsG5/HEsqS5J6Z0v2BCY=;
        b=C3Gk2B/G1iEdWvrm3NSoVst92G4SArZEZ2De8KynNOwJ4QNMW9akDifu2JjbQTPuSB
         I3Oif/nHpBulNmpVASkVtsDThVnDiSo066DS26ZTJoyOGvgIkE5ssPwe1MSO4Dnw8iXk
         O56ZRAXCO/CK8tC+4wt4bsRIkGp0cLmcebthvF4JVYLhQLMyJXJiBetYZVpyyImKoweh
         4TLAWIt+OHx2ffOzJFuZ4ylTrLdBiq1/utlT+ktjenV4Rk0QBbhN7FHdizri6nPw0/h+
         sM2WaauzaaGTTaQQhazX+HLquQX7FFMbmT1Q8Qp5VOfDgu1nfj0xNldcNIMg6F1F8QEM
         HMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941607; x=1763546407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8f8+DXKONCmTI8/qphYme8tsG5/HEsqS5J6Z0v2BCY=;
        b=WioXhfA4QRF6EHtI4LKl+/FUXuIFmTyZyG4tjWOTYsiQ0Qta68p1OjUx9Xv32id/OW
         6Ob/O4NyDmRgwpTcf0F4kwluQjGfi56C5wSqOK6Z+inTOD+wszRKCQOIEbXTKXgEN8xn
         Nki/NfFUshUmN9HnDsEJsJ9T6lxQLjq2FIvbXC32shX5AlxauvOqzRY9YkIC6vKSrZDK
         /IcNxwA1iqRsnU7tF+auzh8/vlROUjhCOEu5N+REzP3Ns+MiLL71H9m3GttDh68Vh1WC
         zS1ap/Fo4iTyXujL7vJ+YAZ/HTu9+rzhVwf0EIKJs5z+FonKfoJoep1BICO3knIuX+TE
         y+wg==
X-Gm-Message-State: AOJu0YwyYRKBSV9gKgx/m5IB/l7iW7N23BjmeQxY/hLXaS1eKHaD+Yzu
	SgOiI5X8BeGl5PBAQOq2fiU73YXTPne3aI8u5UZMItdfxQ3Y6JTZvxNQTBzVTPWGjVT4tug9sf8
	HuxN8HGY=
X-Gm-Gg: ASbGncsIJdncFYTUN+tRgkcWDu29P5TBFmRbq/pA54I30qEd+P0olxSu95IGfpJ63Cg
	QQ/oIRXETFp0UE+4gUc0cG+iYtPUr/8WHP4mr3nD15YuovmbS1DWl8/FGLxEHgDXNGR8aCpNhEP
	ugAtfjd7iprwO6puGz1h2Z2koyStYW6bbPoB97vo5ggk6hq4SEdN19kaotfAmJCemDnn+uM8gFP
	/JY2zUZPJqv5t0KYkonSLXttRbFPh4pJ4DIRHv7Jiy8Wpy0T8p4f7N5QQDX1EQHEgSgtNaibJVI
	bZ+F+l446CdHvUU+IHjKpRzlY2mOKgG3dhhbl+cN8jedo3ZXLsIu2ufJ9/SlD9SSNmv1AfUXVD2
	u+x2IIl51kYm7zoWVO/0ikTi26Cu/lcGqUFfNBwc9NDtbQonv/dSTe6NE9vbz1vYxe9FqXm3MbN
	xwAdXw3QkSzSYNawp7olO5FqqNPXXlZ48MTi+4XaJZgiuDwZj8rHqQ
X-Google-Smtp-Source: AGHT+IHfrI00g3adREBO4Qxu+SQTGFO6r7DZm9ogYWhFWl3K82QfsvudPlF4mksK/RmSAUszY3/OLg==
X-Received: by 2002:a05:600c:3114:b0:477:1bb6:17e5 with SMTP id 5b1f17b1804b1-477871c4b45mr20891125e9.30.1762941607010;
        Wed, 12 Nov 2025 02:00:07 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d? ([2a05:6e02:1041:c10:23e5:17c0:bfdb:f0d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47788a1f823sm9867465e9.2.2025.11.12.02.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 02:00:06 -0800 (PST)
Message-ID: <6336a324-3597-4726-b2ff-fe0f561c59bc@linaro.org>
Date: Wed, 12 Nov 2025 11:00:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clocksource/drivers/nxp-pit: Prevent driver unbind
To: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
References: <20251111153226.579-1-johan@kernel.org>
 <20251111153226.579-3-johan@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251111153226.579-3-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 16:32, Johan Hovold wrote:
> The driver does not support unbinding (e.g. as clockevents cannot be
> deregistered) so suppress the bind attributes to prevent the driver from
> being unbound and rebound after registration (and disabling the timer
> when reprobing fails).
> 
> Even if the driver can currently only be built-in, also switch to
> builtin_platform_driver() to prevent it from being unloaded should
> modular builds ever be enabled.
> 
> Fixes: bee33f22d7c3 ("clocksource/drivers/nxp-pit: Add NXP Automotive s32g2 / s32g3 support")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/clocksource/timer-nxp-pit.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-nxp-pit.c b/drivers/clocksource/timer-nxp-pit.c
> index 2d0a3554b6bf..d1740f18f718 100644
> --- a/drivers/clocksource/timer-nxp-pit.c
> +++ b/drivers/clocksource/timer-nxp-pit.c
> @@ -374,9 +374,10 @@ static struct platform_driver nxp_pit_driver = {
>   	.driver = {
>   		.name = "nxp-pit",
>   		.of_match_table = pit_timer_of_match,
> +		.suppress_bind_attrs = true,
>   	},
>   	.probe = pit_timer_probe,
>   };
> -module_platform_driver(nxp_pit_driver);
> +builtin_platform_driver(nxp_pit_driver);

Do not use builtin_platform here. You can add the tristate Kconfig 
option for this driver, I tested it.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

