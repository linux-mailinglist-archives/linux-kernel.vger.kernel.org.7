Return-Path: <linux-kernel+bounces-769588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01CCB270B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC6F3B518F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D426C3AA;
	Thu, 14 Aug 2025 21:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bQYXtUgw"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED37685C4A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206271; cv=none; b=tp5+b0ETg4AT7o3XRRf7vldxNGECqQ96cXkDKOUHvwtvVrjAdAYf+a0/sEqyz2wTuXt+5Ys06/ggxAyJByZD/mPvewIh/vF0PwlQUaAeBYPxT2esLg+1ihEnhPMXObzoKP7bM+THgxNZwrLPjDmQFlHRlYP9WM2Myv8IjrEtVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206271; c=relaxed/simple;
	bh=DCZK9o5mP8yYL2GAfmlgCA7k2kYEuHkoYqzOvAh/Pec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIdVb+FKz6GXmLkQztYm5ktwLrgjOa8c4S21HvKCz8b3gmXHrZsMM3PiWL2ZprKNyYa545wdtEA9mw5aJ8D9bI94rgb6saOHGGCcGK7zZLMyAtqm3CfovHA/OW/GRBT9kAAp0ZEo4w2+Si8m2W5j4qPHCAB3hhSyICLneilIAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bQYXtUgw; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-435de8160dbso453070b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755206267; x=1755811067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyCLhoYy7jyy9fXZUW6l5VbrMofMsKhJtElwy0Ukqwk=;
        b=bQYXtUgwGemBfSQyjy8PgeegDRVwqWHxMuMXRbL4li0udsnR2o+s/dC6mGPY8BezqK
         9QQWC9vz5fs1ZoXBjpqcnY/UiAiweBtairu34ADSDswO1GM6wIn8MspAoFvg2LjLfZvO
         7MMoaki+FRjUNFdl4O1EqUaRovga3B9Dt8UIZOKX+tHBbZOWVof4xNv2/oEsuAqM2g1z
         a0g6mqvS9O0yi0ZXngvg9ks2KOwFh14MOftthElsLCFngLrGS+jQ4VYteuF0PcAAFiEY
         n+c2Oqrw+bPc5oI2w4vMIGfklu/uUAzXZMnUp8jnOwE7YMrcCtGVROZdMDQdPMqFR5DX
         9/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755206267; x=1755811067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyCLhoYy7jyy9fXZUW6l5VbrMofMsKhJtElwy0Ukqwk=;
        b=waMBETvo+MGr/yr7LI61s+zBMP7FsJqq4R2pcw30GoGokmVf+M6Di8SkheVARPsqZz
         zkgVFQFh5rnootA2K8XizQ6o2HwpcXNwtGdszluzu2W8OR8bZqUS/+KCdP5d7z9EBJGd
         lgDmA64nXw3Vxm6ifVzRg51//aUhZ2B3Pg4Gvb6HHrJ4UQB7pmNAD79IpgxtF7A0B7z4
         3PjxFyEJuWR8mDxYfP9CP/5VU2Kn55hpMUZeFdeLjSjqoalnEbnj/Ws2ktn9m2IOT69G
         i0m9UqIcEZFzI4VNo5GcZbC2Qav8TC3L0Yzkv6eBIJosksetG9lMoTVm0yDFUK++rME6
         8Y7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOUrzgZ7cvgrJ5U6ISpD7YtdW+zYHdzi5unlab6T6nB6B9l8AgIceKLsePlWOJZeuGYoi9RGBw6e+ArlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5vxt9JEZNpcNTwQZ6L5Nf/8Z+zf5fkkBGMftmOFF6d6F4Wgzv
	X6u4UXmyEndnEqdMc9LolpOiiRhFjFKmm41z80LsOzLpcDMdw6BSTkapYAb5vQ89ICE=
X-Gm-Gg: ASbGncsKj9JSA+u3wfZ3Jgz8g34Mbj2c+mHxG9FeISCcq8DQhjr4/U7DY1cF31Z/t0t
	LhzkFzfKHz8r1kCXzyeu5hDy88xEIQ6MlE2CBONLjCYTfU+jaLutWdsUIk6xqkflxH3a/3b5wzb
	sQ/IAXlrrghOPL3H2Gj1i6j6fhWmbQEJ6gWfopggwjdW8u7QhvoF7p42NVao2NW40GQ4wR89scP
	/vm2cDN/7tk/Gs/06/Wn9Qj1LJuUeNdIo/qZcJ1XL0klc/IaRPaih+wMnUFAZucS6CVOzfMcWWL
	vezaH3ldkn17E7isXEkv0ox+3DPAKf/mizk0WbQkifQMi6rD2Ok0fOSGRSN/xLlAWjJThGrs9n/
	0zuqmPGIZxfRKBFyLh//sLa5h/ASNqyLUgZTOWXXmmeexwDB/B80TpJTgAWpvfR4z5oZrVHa9lW
	U=
X-Google-Smtp-Source: AGHT+IHLwc3eKl5bHyawwGLuUnTbJjGRZty13s2Nm04iMLIbVVsuSQ73l1ycimhqcR9RpsB41KxtMQ==
X-Received: by 2002:a05:6808:4f24:b0:41c:95a3:8180 with SMTP id 5614622812f47-435df7caeabmr3019825b6e.20.1755206266927;
        Thu, 14 Aug 2025 14:17:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce6fe528sm1217497b6e.7.2025.08.14.14.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 14:17:46 -0700 (PDT)
Message-ID: <5bbdddaf-4ff1-4cff-a933-143160896717@baylibre.com>
Date: Thu, 14 Aug 2025 16:17:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <1a87f436-317b-40e0-a655-cd82f969f22e@baylibre.com>
 <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5b02293b-9c86-441b-9344-2d0263eb1659@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 4:15 PM, Sean Anderson wrote:
> On 8/14/25 16:55, David Lechner wrote:
>> On 6/16/25 5:00 PM, Sean Anderson wrote:
>>> From: David Lechner <dlechner@baylibre.com>
>>>
>>> Add a spi-buses property to the spi-peripheral-props binding to allow
>>> specifying the SPI bus or buses that a peripheral is connected to in
>>> cases where the SPI controller has more than one physical SPI bus.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>> FYI, Mark's filters won't pick up `dt-bindings: spi:`, we need to change
>> the subject line to `spi: dt-bindings:` on the next revision.
>>
> 
> Sounds like he should fix his filter then.
> 
> --Sean

No, this is a documented expectation for contributors. [1] says that SPI and
a few other subsystems want the subsystem first in the subject.

[1]: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html



