Return-Path: <linux-kernel+bounces-725486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6963CAFFFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD71C4009E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146892E11A5;
	Thu, 10 Jul 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4y/oTuG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A461A841A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144865; cv=none; b=sDP3oSHUIPSVOfbNR+xcsM6pZpbQXEdbk5AoWJBk/VLQr7MFh6zK1tM6Q+wYu5JigvwtvKVjCIwe938OANuL5/skZpP+YzBvBCjJKSky/6NkWa5Htk9KPmM/bzNpzbrujiQGVPyenmfcZxUJmOUkfDMj2K/t2/mWpiy/hPWfrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144865; c=relaxed/simple;
	bh=Z0XyMNsz59gqAC4DYTnxq0yKNx9DYe5SsOvjPTT7WkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SPFtacosFvNTL1LE54B1ikZ5WP+wDHAr6w8xxzD7gIC5oqFI7CHf8ydij9xC0HvgSoRI2jiAYfp65AZw97vjkOLIJtcuYrPo16dy11Pb8SkY/5N/uKvRhPVHl8H2xWjS54amOIE/j11mcySGKCQFTUi8YfaCEGW42mbXKZNskMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4y/oTuG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d6ade159so6408185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752144862; x=1752749662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqRPOUWrfd/5ME1Dr6jOulUWrG857mjgDYu/6kY1HaI=;
        b=O4y/oTuGbBM/kfaO+Ts6EsX6pFkpJxtP9Sd+4kAE8lW+7AgY9m76uJa5N6DaeZeL5q
         W+5nsXnrj8X6D7FbtFtRJK3Pn/XKg14SnXg0qXmYLPdZpL4sfxTKKlfNK1uixyklu50M
         mXVmrw58UjUHN1goMYljQBx0v76JsOUgFh7JiLn7P5owmPwhODFY/75v6hnnRB1LFh+8
         bLaF0Qb5S7KwHtTjRTLgVFhClhS1CmAVAZ15wutCl1Ev9xy3JShPiDQQGkQkba468iIc
         MllcKOCKFl5G9Wv6zEHbgtvZppbp6BAboRX7ClkRinJ55adN9rWq9+O1Uj9Jgd5rXRR+
         HPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752144862; x=1752749662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqRPOUWrfd/5ME1Dr6jOulUWrG857mjgDYu/6kY1HaI=;
        b=M+OLckPMz/1QZsCM2iCMSdc6i+SIX9Ef5aF1zhLYGEgbbu4Z9G3cMegCWVKeqvShQR
         h4P8eTNSo7uvGptU8C6roS8l6nX1Awp+SR5ICciYgv9LrQEYl3XCTVF69FFYXDGN5l3x
         fk0t6SBzeqqwreyMdVvCorI6tm3yWyHWRMZ7PuJitXFa16KV94RyChHyQXts4u3enTsk
         4fG59pwvJDAy3HUnXpgmB22nJXYsQ+OaOneDChrlu8aqwz0elt4+GeVelK0SKp6W9TOO
         x36bbqv1WgTwueUOVYQ4D6Bd/zNLI4/9zVJoMJBpXYuKfjgw2xdCr+qLw+8nVZUbVT6c
         2qjg==
X-Forwarded-Encrypted: i=1; AJvYcCVcUyuPVV7k+eJqzEb9TFobu7NtNfVcyV/3izZOxe8y9BQUrY4CEpXZY13xhcXpQYdm/YtKg5Ffn9mIvZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp5+32HxwVI3Jgrqw/PbCUD1JTgW6WGtrz63gB+oNJfJLVVAqI
	+IuNG6+RWk7BDsWzt3kJyQXAR6hHBSD+TXunkRWLxSt0HXJKwsomwGIcrG+9zyrQjoI=
X-Gm-Gg: ASbGncv7W2D4VPcy50jhln07Zz9oQaVAV3EhjwJyQEf8bTzd0kFe86IJgAqYoqummvw
	nwc7rcXl8Hi7iD/pkvRubEQsAfmPJjOP7AUX0HrSZHAM8aRVqm9rJ64bk7E63a4Ebwr6xIOGu6p
	5ug4IDFIHDU4tbwk6b3kfnKTLxtsOv/yfIm1EEdYnrvEPZTZRkeAu5ZuCPBh+y9BjBO+5Rm93uE
	iXBdbLdNcQLG9W9vtj0U3hrNhzDxuDJ2mejRAknO/HIvSHCof5oP53qmvM67UF5xef7H0mI2RyE
	odbTFn65AkZhDTXtdwtkNNf9JwgMUJEwi/rR4iUtzsme7Lw6kbKrpKaRM9VxZNuR6PNGBaLzjJW
	r6pz5ZFY3HcYYL2Ar7zQaGqHjHw==
X-Google-Smtp-Source: AGHT+IHxiob336UNSrbe5i6u9msJD7vfivAAJRlwviQf0YDbO3tKbGcjJY0KOiN6sL99r8AJLF+BEQ==
X-Received: by 2002:a05:600c:8b02:b0:44a:775d:b5e8 with SMTP id 5b1f17b1804b1-454dd1c8c8dmr19164935e9.1.1752144861856;
        Thu, 10 Jul 2025 03:54:21 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc229asm1563263f8f.35.2025.07.10.03.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 03:54:21 -0700 (PDT)
Message-ID: <36970a28-44e7-4e54-b22b-fc7524bd2a08@linaro.org>
Date: Thu, 10 Jul 2025 12:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
To: Arnd Bergmann <arnd@arndb.de>
Cc: William McVicker <willmcvicker@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Rob Herring
 <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
 <aGMjfxIvbCkyR5rw@google.com>
 <27644998-b089-44ae-ae5f-95f4d7cbe756@app.fastmail.com>
 <aGzp5esx1SpR9aL5@mai.linaro.org>
 <746ab617-4db9-414b-a250-06adeb618b8b@app.fastmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <746ab617-4db9-414b-a250-06adeb618b8b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2025 18:10, Arnd Bergmann wrote:

[ ... ]

> The way I had expected this to work was that TIMER_OF_DECLARE_PDEV()
> always registers the platform_driver and just skips the
> section magic when it's in a loadable module.

Yes it would be a nice change, but it seems to be not possible for the 
early + builtin + module combination we have AFAICS.

What about to have two macros:

/*
  * Declares module_platform_driver
  * Assigns __driver.driver.of_match_table = __of_match
  * Assigns __driver.driver.name = __name
  */
TIMER_OF_DECLARE_PLATFORM_DRIVER(__name, __driver, __of_match)

/*
  * Does the same as the above but if MODULE is not set then then we
  * end up with timer-probe() instead of builtin_platform_driver
  */
TIMER_OF_DECLARE_EARLY_PLATFORM_DRIVER(__name, __driver, __of_match)

So when someone is converting a driver into a module, it can change the 
driver to use these macros instead.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

