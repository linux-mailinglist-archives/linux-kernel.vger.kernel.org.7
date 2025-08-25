Return-Path: <linux-kernel+bounces-784620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C87B33E9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA017D623
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2EE269AFB;
	Mon, 25 Aug 2025 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRtzrO/j"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299126A0B3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123289; cv=none; b=UtLyil1e/dMVeTvfiyjq6d7B3Vcu27tih+9xVXpajXsN7AOE8zYo3PD8DwvayfKu14NmClgPzYkTgKIUo9VxZ3SsqzO/q5gCokAhHntFYd/h9lR3QwHy4AINXYrS5KQUfjp+3c/fjxMO6syrq7sE3p0itc1PIrddufSviSPQw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123289; c=relaxed/simple;
	bh=RFnXtMO9EySymNwVyAhdrrY0RQvFJ6yjd44teuvucr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eP9ptryntmhAtRjWpOU/mfIF/4VYmnxQ1Xy+vRmWKM9DvYKv/4wy391TDkpFrZzdEux9qIXscscPny7ogwBgyx+I4BnoiE/v/f6uMUlMDYT9YkMxsWuiTJr4Qpy5Ts0rTm+OwvRzJfMnPHhFt6d2LdHi/9ggSSHvU+5pvVyCbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRtzrO/j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a20c51c40so34203555e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756123286; x=1756728086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRcckAhyKKIfk/Fgtz+kopwNbFInJmosFYKCEYbjFWg=;
        b=YRtzrO/jDKlz3r0pEj/sMPXB4DkzBkCQUs4Hmwo6OqzT8RueL3ftkhhQZpFlICsVrB
         sFXHrKq42Bo7RD5vsmWC8AToIzNUd0rk3lN8NrlFcc2ng0RRC6PudrifMGzEGg1YR5Qj
         6awUXTqk5M2lTDF7MvowAAJeXkf2kMw1r8fMCdBY/NP5Rq4UiecJUmVJhjDdI4P+fv7I
         5Pg22tUzVkRdjncv2ypuCHcVcJLc2FUnt9xFUbKu38jK5FocEHxuItIM/NlNrLIIs6nt
         FDuLHa6mgyUqTSTMw1sQTTzXxRgINKXkBN2wXUeJnQUScZzxFOVvhcgk/IxGg4xphdgb
         AmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123286; x=1756728086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRcckAhyKKIfk/Fgtz+kopwNbFInJmosFYKCEYbjFWg=;
        b=dNLXn25TT6mQqGfeOBchkQFYxQ2LQLVzfKlbWmwToZvwHjAr6Ln7bmaZsoosSvgIWN
         TBmuRmMYBnySdSdGQr70dW5rT4+pPgaXLx27Fuz83nHMjhLMDxz9SW3rolnqo/U56h8f
         2U5g3KpUIhtnZbzmvMp7xNEoJYTXd4nUt9viRQhcs9o6ZZrNkR8wf8Vr8AXMnUiq2S+s
         l8U7xU3ia/g4j1P1DvRJkTZyrRCyEyxZkz4Z492fvZMBNButrWYsjo6I74QyrRQL2ARc
         KET0TAICyhELrVlei+KXup3nifzJtI+npJWnMXoSCUF6K3LIoqqY53L/iXt6WJqvFRrQ
         T6yw==
X-Forwarded-Encrypted: i=1; AJvYcCV3F5N2m66a7afPmLgTCmsPL8rFeLbPJgGRAFsqvV7AKTv9Zd6szhsz8WnUpFthnlpR8MRS/GqmQHWzq1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Chz6jZhZ/p5P/UhfC6xvNkDFuGI9GFLfQy2WUWYl8lfCHT5O
	ZhmeqG8ZU+PTQaTynZ+bCvHNheQ00+pkBNqh7jnsqmpVmspJw4ysxpzPQfJ9LLLvr1o=
X-Gm-Gg: ASbGncsYV6f3DgqDUPclXWVa21I25zPQ2HvvTNfSUF5b+2Sfuv/GF+51L1TRybxHTfZ
	0bC+5HWTyMVlrsMuLMDFIly4pNEtgOUTHucE+/hbcwMpUz7AS7ykFMmTA/xnJSH8TV5VjhdBVmo
	p6BSitHg9uzLFNAv7UFE+twl5kpgvFi37jze6qRUHs/Vmb6egb0CZrXir0GwY8kygvfFOCdW+iX
	wf5Tgbz55Yqk7ODnOFZOyknGM7ipxF0v2TC1qQV2pncd8ptgk98EDwk1joi3MoaXNvU/opGYLSE
	midsRhmWOXO5AN3u5MuQxENl13ROqTqbHZB5A//sizH/xxxy0GbKS+qpZnqsKb6lYfjSch0fL73
	CF8jUbJorAOYFFSTqDRtPGHw5kNVO0qg=
X-Google-Smtp-Source: AGHT+IH62AfWArXNyegFI8zsNyQcP9qoQacs5w+PUV6JSw51oEdiaFXWL4IPdH3vJ0s3i8QgSe1+bQ==
X-Received: by 2002:a05:600c:3590:b0:459:a1c7:99ad with SMTP id 5b1f17b1804b1-45b6133ff14mr19383645e9.22.1756123286249;
        Mon, 25 Aug 2025 05:01:26 -0700 (PDT)
Received: from [192.168.0.251] ([82.76.204.34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6300da81sm19978265e9.23.2025.08.25.05.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 05:01:25 -0700 (PDT)
Message-ID: <eb2416c2-ee1a-4770-803d-1d890e4ce238@linaro.org>
Date: Mon, 25 Aug 2025 13:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: firmware: google,gs101-acpm-ipc: add
 clocks node
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20250819-acpm-clk-v1-0-6bbd97474671@linaro.org>
 <20250819-acpm-clk-v1-1-6bbd97474671@linaro.org>
 <20250822135521.GA3487754-robh@kernel.org>
 <ebea336e-c43f-4519-b2c6-4f8812e29448@linaro.org>
 <b7bfe424-2cfd-4897-ab0d-69c8e92acf24@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <b7bfe424-2cfd-4897-ab0d-69c8e92acf24@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/24/25 6:00 PM, Krzysztof Kozlowski wrote:
> On 22/08/2025 17:03, Tudor Ambarus wrote:
>> Hi, Rob,
>>
>> On 8/22/25 2:55 PM, Rob Herring wrote:
>>> On Tue, Aug 19, 2025 at 11:45:36AM +0000, Tudor Ambarus wrote:
>>>> The firmware exposes clocks that can be controlled via the ACPM
>>>> interface. Describe the clocks exposed by the APM firmware.
>>>
>>> ACPM? APM is Advanced Power Management aka the predecessor to ACPI?
>>
>> ACPM (Alive Clock and Power Manager) is a firmware that operates on the     
> 
> Please unwrap the acronym in one place of bindings commit msgs.

Okay.

> 
>> APM (Active Power Management) module that handles overall power management                              
>> activities. APM is built around a GREBE processor.
>>
>> In linux we have an ACPM protocol driver that communicates with the firmware
>> via mailbox channels. It's similar to arm,scmi if you want.
> 
> Rest of Rob's comment seems valid, so this also invalidates the DTS.
> 

I assume Rob and you are suggesting to drop the child node and add 
#clock-cells to the parent. Then define the specific clock data in
the parent and create a platform device by hand for the clocks with
platform_device_register_data().

I think this works well as what's used in the kernel is just the
clock mailbox channel id, clock IDs and clock names. And these
can be defined with parent's compatible data.

Please correct me if I understood it wrong. Cheers,
ta

