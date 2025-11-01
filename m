Return-Path: <linux-kernel+bounces-881240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD976C27CD2
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68D1A4E9F49
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B3427F16A;
	Sat,  1 Nov 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmWx0x2Q"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1552472BD
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 11:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997065; cv=none; b=aoSniPEGyPWxHkIE5trmBKBgm6dGHCralDbBoOAABKC2vR4WYTxHwGFzNqNIX4f7llwp6l3gLVI6OZBJLFOg3+qtxwkD9UVW3XfUo9BVfG4Klcy6rftOvfDUPwnlL/t3pRWZnDSl31knAXGIVgyaJM5yE7vxnrVdAR9d3T5VdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997065; c=relaxed/simple;
	bh=7IfCe1yJZ8OATH2vDaCumIpLU4/MgZjeWWPo4JOsHeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFT88CfOoi5t2xNm8XhEshFfWjZ7sMPK3Ag6B/SU4xoq+Mkql7Idw1UY9UuJpfwkOaeHoHhkpgQTJnzI8NuEpyU5iXx9gQelCinB9Nj6nsHLzUwwKaNU4dj0qUc6AC/36cifsZdU37LsGd62Dzv9UqH3x+XzwuY+lEhgnkh2mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmWx0x2Q; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso2339924a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761997064; x=1762601864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7p4U/aotayqb+o6BTayF37konWJWlNpUHWv7lMsZ+s=;
        b=kmWx0x2QJm2h7NYgilHXZjUnELxxao2Pn4NalMWDEtRS/GPrf6n0ogY01KiOuo6BXR
         kTpi4XFwIWtsqmkAJuGudfkY42Ro0eFGRyq39YfFvBfMiDonqXPm5dD/Tf+rzDGT1r9m
         L2RYAdlMcIDCAckLPN3jVjUq7EMhJ6np3YveBaoHkWfH8Cf7hdWNjpl8dlDGmB4aq4Pv
         nwmZZNnardmgtwv5gmWH6/1uCsqnZOTw4xpFa8N/Q23wOlKPsWYjz6/DKmb3oEif/rNn
         rQGyZ1WDY0N4EPQ6Vho6z4lV3/42e4ZY38vlUmmxjFCE1UXgXuJ322HE42vXasccKb33
         jgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997064; x=1762601864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7p4U/aotayqb+o6BTayF37konWJWlNpUHWv7lMsZ+s=;
        b=wZiPviEHkaDegmd9WxOM9xqOosoeCnH/LT4oarojKbj8mGfrqNPmfpa6qr6bBHbS3W
         6iKS3QkivoGt/dabldT9cyL9CfFd4QH7AnbkTjRoyif1vdlQtQ1HfT/kxHPeW9QaXj/b
         bkWcpBn3x/2zaj/WqPILk5EVoyYmEXYLWlFXahv395eaQX+kCfeo2r9mI9dNfGm4D29X
         TfCiRQQPdkbu50+o/yusALC6o31gELCR8cHpHf9s49xhl8evZ5jB/+JQgV8uZZJBPRG+
         DgzyWb4yukOiWRvChFnzpTejhZX9ChZO4DMw5V8r5xjCZtTxLhNcwPoFzcHmT8z24sXU
         6HWA==
X-Forwarded-Encrypted: i=1; AJvYcCWcx2vmF90UwVHn5OA0EhBLTfLQQ+L/TGOdEim/QKfIATFjgHYhzellBcE6hg7LpLzM0YDlLVbh5B6xXTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjlA97yEQgH1+0sEzsd8APZ0+fgY/rEgZXogTdtAEsYxEkrb5f
	K9HTeV3M2ewmIWDyvoe4OQ1ZacHYVrNwUs4FUXyObiOuTiVUwZpvRJk9
X-Gm-Gg: ASbGncuYQk7k51aR+w5gzSdF68FlbPaeiliDcsmIRkgEDpLz6g0QcWLs0UWX3MqHzcx
	kx4x5kTH360jdE8UBTHh+eD0QwZWu2n4y57IPOVPUsdjpdT7zvT6d8g6HbjttUVlngYNJWoD++I
	B3OV4xl6Lb2qAoHM65pW8s0BDpw6zHyTGq8o82eKDS3Z2pO3LiLfzZUnyNjb0czOoO4+FAdI1y3
	ig6Wd82TtqKnmOfztoWvbADYhH0MrE0auP7DmWGNBLMU64/DSWWKUIPMvuG84VFagNJmn3SVsKR
	ssS4B5XeVTljUU1kEKdBVPZ80F4xQuCXxrQMHwrVhlXIUDjp3jFMWfUL44D5trgh5TqiyzzyD3J
	msPdZRpLS51MEay7lkOz6ySea17buxooU5ioy2olsWNBEmwOjki08+5L9KwXvYJS3mIdnvrWTQO
	FLwnFvVI2Ld5io+f57kZ4M1Jke8FpOThdIXmf+2wDBGiDs1v9XQCtNMDUUthJAwBH0xXu0dS2Jc
	q0fakSuenAdPgEU7Pw+sD9YHYZYrI11et7Qyn1rKjbymLrelhLlhCuEIYbBGRZuyCT+zM5sDBQp
	sE9z9Qtr
X-Google-Smtp-Source: AGHT+IElqgpdi0hmBlhoWaDzwCMRVG9l19J7bo2p6s9Q8XOq2cgtoU26ySYjwTwYUrWC/KeNqbFRWQ==
X-Received: by 2002:a17:903:18b:b0:295:5dbe:f629 with SMTP id d9443c01a7336-2955dbef73cmr10992835ad.8.1761997063284;
        Sat, 01 Nov 2025 04:37:43 -0700 (PDT)
Received: from ?IPV6:2402:e280:21d3:2:61a9:cfa6:c139:b812? ([2402:e280:21d3:2:61a9:cfa6:c139:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955967f329sm16919845ad.108.2025.11.01.04.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 04:37:43 -0700 (PDT)
Message-ID: <406fbb02-5a2b-4097-a645-b97d3d74287c@gmail.com>
Date: Sat, 1 Nov 2025 17:07:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] iio: adc: Add support for TI ADS1120 ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
 <aQR1N__AwvPm21tm@smile.fi.intel.com>
Content-Language: en-US
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
In-Reply-To: <aQR1N__AwvPm21tm@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/25 2:07 PM, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 10:04:08PM +0530, Ajith Anandhan wrote:
>> This RFC patch series adds support for the Texas Instruments ADS1120,
>> a precision 16-bit delta-sigma ADC with SPI interface.
>>
>> The driver provides:
>> - 4 single-ended voltage input channels
>> - Programmable gain amplifier (1 to 128)
>> - Configurable data rates (20 to 1000 SPS)
>> - Single-shot conversion mode
>>
>> I'm looking for feedback on:
>> 1. The implementation approach for single-shot conversions
>> 2. Any other suggestions for improvement
>>
>> Datasheet: https://www.ti.com/lit/gpn/ads1120
> The cover letter missed to answer the Q: Why a new driver? Have you checked the
> existing drivers? Do we have a similar enough one that may be extended to
> support this chip?
>
Hi Andy,

Thank you for the feedback.

I evaluated the following existing driver before creating a new one:

ads124s08.c - TI ADS124S08

- This is the closest match (both are delta-sigma, SPI-based)

- However, significant differences exist:

     * Different register layout (ADS124S08 has more registers)

     * Different command set ADS124S08 has built-in MUX for differential 
inputs

     * Different register addressing and bit fields and conversion 
timing and data retrieval.

would require extensive conditional code paths that might reduce 
maintainability for both devices. A separate, focused driver seemed cleaner.

BR,
Ajith Anandhan.


