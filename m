Return-Path: <linux-kernel+bounces-782868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11972B3262C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423A1680E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5431993B9;
	Sat, 23 Aug 2025 01:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMXf2+Dq"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E228F4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 01:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755911750; cv=none; b=qK0qUg58//C1Tbu2vken60TLu4vw2zwF2dJ5KTc94QbTrho0a55IP3iGKJ+Bf1bni0KfDVkSm9r5nwwcHkpYksX81mQcSUFwZoErfiu4GPXFp1H5ECWtUGkpWjLAhWtcvA3w6vCrz5JnUmZcUBzeklX6mq84wPoT/viURZsr02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755911750; c=relaxed/simple;
	bh=2TJf8u3FXhuCOAUX9JWR/xOPNDOZHYXw/yjbAHVWGFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRYLdp+NJvzasRLh1qZ+ku/eWlPoFIVRGF6AL7xc61juOCjXRAgmtYvHpCLdREQ1ttDFUQYyShtspli4ScjeeUdIj6ZCS+di09v6q8u4zeS01dSm5B1o/sPlvBE4ZB3Lu+Od2sWbJ7I622ERukz41q+B7j40UG+dqPuLQNpsDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMXf2+Dq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e8005bso2836657a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755911748; x=1756516548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SQPiCTgZZSRUhOTTutOFH4iVS/KapPommMHwl1cv0T4=;
        b=AMXf2+Dqn3QxmdMEEMkEdmcYhmlC6L8WXBukKAWXaHU3ulcEopnXcSg/6P78nrkC3F
         JUQETIb5X1ydyMVgLsFOwflTpLdk3NNXPDMawztT6AKZrNBO58vjQyv/Bwouk1nZQdH8
         UsgPaShG5rsx/b5KBSAboMtu+GDNI4/ubwpJW/FsYGvKYlYhD2KL/iioVuzPn9mhL2dF
         SaMo39+pgrQVB6RXLNFHlWgvGHpxB2SbCGlDXIeTEvimTR4AngkNzGay0/I9L+RzidCT
         E06iOR1ARpwbIT9FwNfYPvwSxxw6ZefAK4DonE/jklJLvFTjajLkwHEC4qtkKIMAEh9R
         o+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755911748; x=1756516548;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQPiCTgZZSRUhOTTutOFH4iVS/KapPommMHwl1cv0T4=;
        b=Ow3w2rNeDIFCSelskaCIqxAH0WSsUQELPIbYm1XbMyB82HXfV0olLRvZ1sXK3U2fjV
         3DmjPTasjghK98NoXqcbCDhDsMEX/2emVEdGajMbsBaAW6FUGXgwcXTz5G8HceB1dnax
         3Q2HwokdY6o5F8NP2RYRjK6QZJYVo8rhj0f4ZnKOunlMhrYLUdLIOgtWgA/XTVknlYTc
         slASjwkb3BSNGOrbKgNQBxTgGOarRhg41uFxlX5KcFJi8XnNMRLZgcDI7YhkgSoougdw
         HyVwtVhV7KYKEbXjyUX5jFfHZWidJDKFR2sGBZEKuwlpEF9SdTLVzXMfr/jnMR9ANami
         d6wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd6JKDIKnmWP49Z9PcTEi/dKo1L9CsWIAWuWB9e2pxqv2ketkDZmmRoasauPCQNIQsC69Uag3H1b70IvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWWEfRJKjtFlVO5BAG+N6tk3axdgZNZrnwl3/rLLvMGgRBWVR
	yI3kuQ/4FdxPUg0/IpZIA+uHeeTiEAbv4oP6dfA4zW82O10cmeCrJq/p
X-Gm-Gg: ASbGnctPNdS0jN6pfsSzIJH083hN1CB39g293QS4gweq5qM19FUorwsAVVdvcMjmxan
	GhJzxpJkWD3ZMl7ecqchSdQg2jSo+RbhAhmw/LAnjxaX4+wFoTkhWlLzIl4loFJ5C8ULIrfzFVz
	toNQiduYe3JBFROgIt0egCyXiRQ6P+9tegjVcGTgZYgYJqQIEHIh+tZoaiV8p7MPCOhwOdK976m
	rsY0Qgmyv9s1BVUKOFCiWTQWHXwwAYMxN5gHnlSZIHdeewfeHB3ASX61/tqxUXF5dAPfSceoBbj
	h7Noucn+pBaFJ2Gx6VXXRUUnkbM1Aq5LhlAgFK/G5cg1rSmbCfOBpXECyL2g22ub11wTyxGivO1
	ux0mJqEQXhZu2l4qzmKojbRJ0Cd4tnGLkOxgQvssQuLcoOK6BGrsysAsZrjIWgfsHAUtkSVA=
X-Google-Smtp-Source: AGHT+IF5kIFtsXH5MjU/UoyZrAGqieVQWhe+ovjJ3m1DuZW21DFUKhJjTneGtZPeOcVghqi4t11OFg==
X-Received: by 2002:a17:90b:3d4e:b0:325:2584:b403 with SMTP id 98e67ed59e1d1-3252584b664mr5195218a91.18.1755911748050;
        Fri, 22 Aug 2025 18:15:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ad9321bsm888141a91.0.2025.08.22.18.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 18:15:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e317b46-0179-457e-bd33-8843323b79fa@roeck-us.net>
Date: Fri, 22 Aug 2025 18:15:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] genirq/test: Platform/architecture fixes
To: Brian Norris <briannorris@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, kunit-dev@googlegroups.com
References: <20250822190140.2154646-1-briannorris@chromium.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250822190140.2154646-1-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/25 11:59, Brian Norris wrote:
> The new kunit tests at kernel/irq/irq_test.c were primarily tested on
> x86_64, with QEMU and with ARCH=um builds. Naturally, there are other
> architectures that throw complications in the mix, with various CPU
> hotplug and IRQ implementation choices.
> 
> Guenter has been dutifully noticing and reporting these errors, in
> places like:
> https://lore.kernel.org/all/b4cf04ea-d398-473f-bf11-d36643aa50dd@roeck-us.net/
> 
> I hope I've addressed all the failures, but it's hard to tell when I
> don't have cross-compilers and QEMU setups for all of these
> architectures.
> 
> I've tested what I could on arm, arm64, m68k, powerpc64, x86_64, and um
> ARCH. (Notably, patch 4 ("genirq/test: Depend on SPARSE_IRQ") drops
> support for ARCH=um and ARCH=m68k.)
> 
> This series is based on David's patch for these tests:
> 
> [PATCH] genirq/test: Fix depth tests on architectures with NOREQUEST by default.
> https://lore.kernel.org/all/20250816094528.3560222-2-davidgow@google.com/
> 
> Changes in v2:
>   * Make all tests depend on SPARSE_IRQ, not just a few (resolves
>     ARCH=m68k issues)
>   * Add David's Reviewed-by on unchanged patches
> 

My test system says:

Qemu test results
	total: 637 pass: 637 fail: 0
Unit tests:
	pass: 640359 fail: 0

I sent Tested-by: tags for all patches of the series.

Guenter


