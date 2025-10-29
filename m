Return-Path: <linux-kernel+bounces-875967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045FC1A4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7766B580716
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628B369965;
	Wed, 29 Oct 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKusNya+"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7245735BDD9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740592; cv=none; b=hXllxrJ7OvEWEDulxmC5mvV8Gqkg461VvMCnolSQHfgT11G2Z3fYUlEjvPRbnxgbXEfc/BO/dmBYm19BuZwHy3sq/IgqK+DeQvA/a8cuutJ8igJcJgJDP1kPPrLaSvNgm/+QE8X1BlTsW75J8rEq1pdQoxEYmIfSA4oTGt8lpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740592; c=relaxed/simple;
	bh=4q7J4aubuQWsGwr0ektsFotDhPgrwX82ZQ+g0OMBrag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkFiJvSHo6PnlrEQNI7rUsXE4hN8PjRJCm3F4oiiAspmUagO1TuRdPAClcl69dUEldRvzPaNHgFK1azpTNb+1EpzgO4ZRYS/BqCzAGoBfqavMX1EK2FH0ySYqav8iXGDzi64k6WVpuJv0f4uPe+47PJWFU0Qfj9Of4w9xQzy7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKusNya+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36d77de259bso47050611fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761740588; x=1762345388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwOTcdAl6vDZ/MWyMdXE0a7QobEAic8ni59wBqX8fPs=;
        b=aKusNya+J1epch69ax/IhqtTcFFpOXJlXycJ3taG2vAOmbfp5vZwMNwAwBFguwg3/Z
         iA5ZMqVWcGfEE/fkTY2j6W8/t6u/Amc3PuCCNe8K3HEP9bi88kUMQEnLT50SmA0xR8oz
         kjgeFGRrAQY7/0L/g/TilJzqMIeIakGJOXRFkr3nWwMw69QcKH4JjpCPNH/8JsOMzS/K
         G//42m3pFRCNn1P2pYqDJZZ7i0fwtn36IiINOJPRcWNJ7n5RPen4uWKfsa00ir6XNTiv
         s4+BR3zF4LXbN2b/x5+DHA325CzYi4Y9bsxThtoQgnfy0Y14RIJAMO5CBUtgcTLfo4Dc
         lfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740588; x=1762345388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwOTcdAl6vDZ/MWyMdXE0a7QobEAic8ni59wBqX8fPs=;
        b=Fkc3mn1z55q5xLb8hKO8yIJMPzv/XEpdCnwW9VBGqT8yivRsNLIgAGmHld7Ez6k4Dq
         zRX6Y6KD8yK47Fd3nnE1yrCRUrtXoN+8AxDHJpG5umzRjjxZTep7uDXjr5H1tQQiH37X
         FbhPGZYJ4/lKOtlul6xon+U2nHBa7swmzEHtCrtbbS5PWRdSiHvdLSeM2GBjzaV0hUn2
         tBs3iZWLGgl3Ju3ub0uvERJxa2EmuEq7BAeWp+q2bHe7ac3R2EGcGxKuER2HEOETWa+M
         C/3NnPXc4RHtKowlKo8kSkZ9K3JXLORyQ72Whl9MVvlNNfS9X6X5q83YL9pz11Ung3im
         pAzw==
X-Forwarded-Encrypted: i=1; AJvYcCUNR+yBa2BAXIFSEvGAq6RHIMGILhNVE+XaIftO4jl4d3BCNkP4Z7QiDNv9T9P9f/rAxz7+b3KPupHCn/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYABBBhzqhbuD61TMQEOYhNxxFuy8VkPrHnhvfW3bdxTyFLYrz
	H+RHRcNRjycy8Ayt65f0czmiESV6BsZptiN7Dk+UYS+7/RbXYpYcqECc
X-Gm-Gg: ASbGncu9pDboTaCxhw7cjcKxXcJjqaU1N04U1Ua5lRNnaPGLD4SJihMAqfQMpUcl0QP
	EqAU/0uPxdrKl/B7+peMLa3kvoQ10+7DCsEaXISUIchCDPraPocl4taCuT+jWdyZcKdTYurv1y9
	O8yJnbzfGpz8F6n21vHdgX1jSMBMUGXHEwEx3mTzrUjykSJLrf13yDvP/GQGxJeJeIn1a20UOHf
	VScYXApbRjzJh2ApwY2UPLO4VtpbCclAbpj3Wx7IOkJPcVfdgtmdKc4/tt7Lf8XA6OAM1HBUFoL
	59BjbaR8upJ0LP3Qo5Gi9PcdyKolNasmlHGMGyM6aaCSen0XkH7kr6NtUo9I6ULwn2skzS3w03Z
	O51y2QGqPQjdXZ5SeNrIgbQHAEzd3rjBToQ5yUnWGZMU8bHKCwqpJ4N8g2iYMuTvLbo5rhIyvEB
	K51Cg2jPDaKg==
X-Google-Smtp-Source: AGHT+IFFUkHYksyaF7YXcZrhW6iSWoG+pahPESVLSjEUcjb9W1AN2WMoPe9CQ3dBxP/T6OWyot0tAg==
X-Received: by 2002:a05:651c:1ca:b0:378:ec26:bac with SMTP id 38308e7fff4ca-37a023c5e6fmr9540811fa.15.1761740588247;
        Wed, 29 Oct 2025 05:23:08 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f5f98esm3814707e87.57.2025.10.29.05.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:23:07 -0700 (PDT)
Message-ID: <49612d39-e2ba-4cf1-8bd2-3da1e9869069@gmail.com>
Date: Wed, 29 Oct 2025 14:23:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] dt-bindings: mfd: ROHM BD72720
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org
References: <cover.1761564043.git.mazziesaccount@gmail.com>
 <a5957c4f83724d4f32527fb892fc340af4eeddde.1761564043.git.mazziesaccount@gmail.com>
 <20251027222030.560def67@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20251027222030.560def67@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2025 23:20, Andreas Kemnade wrote:
> On Mon, 27 Oct 2025 13:45:46 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> The ROHM BD72720 is a power management IC integrating regulators, GPIOs,
>> charger, LEDs, RTC and a clock gate.
>>
>> Add dt-binding doc for ROHM BD72720.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
> [...]
>> +
>> +  rohm,charger-sense-resistor-milli-ohms:
>> +    minimum: 10
>> +    maximum: 50
>> +    description: |
>> +      BD72720 has a SAR ADC for measuring charging currents. External sense
>> +      resistor (RSENSE in data sheet) should be used. If some other but
>> +      30 mOhm resistor is used the resistance value should be given here in
>> +      milli Ohms.
>> +
> rohm,bd71828.yaml has rohm,charger-sense-resistor-micro-ohms, lets
> keep that unified.

Absolutely! Good catch, thanks!

Yours,
	-- Matti

