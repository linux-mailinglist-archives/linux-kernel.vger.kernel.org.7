Return-Path: <linux-kernel+bounces-897781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B42ECC53B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4469B540EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A3342CBC;
	Wed, 12 Nov 2025 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jO46oGgS"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58136342519
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966361; cv=none; b=XGErABuELQTL1/K1xUPCs2aPZV/Q5zAFzA+zg+uhVtr7Hq90zeMPFGAClMiuDS10m6fnCpIHPFz49g/qNdNYQZEdupEbexErCgUtAsNmv1rBYSVQqB8ZbzjdxrZvOWmkItqJ4uh/XlErFXa0GQJtCUJXBI1L8NlFpKJRqLMaoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966361; c=relaxed/simple;
	bh=vquyA6U0yVLVU87ffFxSvxSxY4DbgBQ5yYCH68Wc3l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmFq1QHBplCSd1qLuZS5WNbmE+gEGJl2e8dypp55LTAZecKeRA+eafXX+4G5n1kNZa+EqpYsOPMUFpZGZ0YuPytuktswkjPWoirxdKxWpFVWmTEE0LzCh2i6fW0Y2t3ocWkM+56lPqbF5siO5HAYCApi1JfiLlIIzM078lrcFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jO46oGgS; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c70e53db41so575182a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762966356; x=1763571156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otKN6HaBW7TeFZXmhol1N0rafttZcw0ehXIldHQZRQU=;
        b=jO46oGgS/vM3MXXYczpi4QHmtXP4ZJ6G9q+Sfnq2whfaApDS5crM9wQfMGl7pYGSSF
         kS5DX/Ko2AXyYeJ1cwm2qjGLv6RlMafrr5J1cXTVxvacrsR6SW2gT6knsOQdYZAO6zSY
         d9Cgmf99MFjOpBDPnWQ8BW8GwOun1+B8s7WWmDVNjto8kTwxkkntu4+H/CsBP0F/arPK
         2Ry3hfnAzVIGT8YeflrPx+6zEc3djCRx3Vonriz2hNiJKY9YXrPjki+5youDgXgRqU+L
         twTzmcbLFregOVEXAm2a6AA1Vr0EaauKeBWqhA9Z1OTTlndzLeM2pdXl5x8Hz8/KaHQC
         9JdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966356; x=1763571156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otKN6HaBW7TeFZXmhol1N0rafttZcw0ehXIldHQZRQU=;
        b=a4ObKMedzSBhjU8HgadgnL2Ir8BvjK0BfRwND10m1+O0vog93b+DeDAgNN0a+rotb4
         SuFuysYAF1Hg1TQfObBSbPCPyCPHG3+acxu5zrBCxMjdrlnryx6OOJyAU/m+FrHauxhu
         Hhc6XMbEnw5XhJIOs47S3ffzxJARhuuo5xkMDScrdR7Wt/ST8RzCpCoUIVtE93kKs/xx
         Y5stF4SwBWY/VDmnfkMHkh0vtUDyHZ+OXZoeBX9gDRRXbFCqa9GbXXPaW3nLyrJQXwDN
         tJmoUOSFtutvy44bTjf7S3SIDWHQjZE4HCCTmw7wP/1Re+UyK6eXaRiZjCH+vSZamey2
         cdDg==
X-Forwarded-Encrypted: i=1; AJvYcCUufo2KI30diE/nJpSX1XJ92+uWAzb5KBGjszZg4TeL0A4BzIfYpUcIkYu5Z0yThVMLC6Bd7ZCjmOlj//0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Hei5cgKC92FldptKtTB3ei34grJktOWYZHIjCt0zb0Mb3UNS
	AMknMa7uJyL9hicWs3lsoHSxivZUoSDeUaTDo8Dh9NpZvMRmr3XhvGcltkJjmBQ9RJo=
X-Gm-Gg: ASbGncuiCUY7c+ATCe7CIqRoACPxfTv6K71UEfNdb4fb62vIigY9tkWMAF1soTg0Rpa
	jtF7llaOcmZykZjs78G3pLgTZMLr7+mf5I7lTiY8YMJWfASLvbRizzKJqwDeWDNTzVboOecJBTi
	a0SLLKn8tC31l488eZg6IKGOhlpiHi1owzmt7AiaYwRsTZvERInIti2Qmg5aXsid65bKfh7yycy
	UX9eH41Qm39VBXrKfXuOKZj0u37QbZZp9lYyl9RLDRO6aSj0EqacZ5iH/yWZo1VNCWGFkMoYtlS
	ACoxDrTchRX3p45QKf71xW7ztGkmLDWX2qSqRJT65io+Iv5f5RQFNQ1qhS1JwLzDky7Qc46KQJX
	7uLFpSu434BIpcmp6k7emF2+73+t27zuVY84diNAoTPkSkY2Z2JTNZ0MlVHE7IMyGfyvdDOBbfS
	YadA07ov5NZblgvA4c6GEnO7O1dXZqIz3XyWpHESsg6nTNs/ZxLA==
X-Google-Smtp-Source: AGHT+IEzlLhnjrljziZsPJD+6TFphu87RW7odVOmHqBJgKS1HNWc+2CO5ak3CF5B+KTraiO0uH2Sxw==
X-Received: by 2002:a05:6808:1b07:b0:450:3c49:519 with SMTP id 5614622812f47-450743f38afmr1702472b6e.7.1762966355944;
        Wed, 12 Nov 2025 08:52:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:d404:301b:b985:c499? ([2600:8803:e7e4:500:d404:301b:b985:c499])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57ec231sm8495588eaf.17.2025.11.12.08.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:52:35 -0800 (PST)
Message-ID: <b18db31d-47e5-44bb-a671-c8d8a9f2cd82@baylibre.com>
Date: Wed, 12 Nov 2025 10:52:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: spi: Add spi-buses property
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-1-2098c12d6f5f@baylibre.com>
 <20251021142129.GA34073-robh@kernel.org>
 <14ae0769-341b-4325-b925-7bba6d57bbdf@baylibre.com>
 <20251030135126.GA3749313-robh@kernel.org>
 <f731ebd7-6494-45f5-861d-05a2926cc5fa@baylibre.com>
 <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aRIbBVNzo-7EYJbl@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 11:04 AM, Mark Brown wrote:
> On Thu, Oct 30, 2025 at 05:42:44PM -0500, David Lechner wrote:
>> On 10/30/25 8:51 AM, Rob Herring wrote:
> 
>>> But it can't really be 2 independent buses/controllers unless the ADC 
>>> has 2 completely independent interfaces, right?
> 
>> Correct.
> 
>> The proposed property really only concerns the data lines (tx/rx). It doesn't
>> care if there is 1 or 2 SCLK lines and it doesn't care if there is only 1 CS
>> line.
> 
>> So maybe spi-data-buses would be a better name for the property? Or
>> spi-data-ports (using the NXP FlexSPI controller docs terminology)?
>> Or spi-data-channels?
> 
> This bindings discussion seems to have stalled out?

Yes, it seems so. I sent a v2 with with the property changed to "spi-data-buses"
in hopes that that it would be good enough, or if not, get the conversation going
again. [1]

[1]: https://lore.kernel.org/linux-iio/20251107-spi-add-multi-bus-support-v2-1-8a92693314d9@baylibre.com/




