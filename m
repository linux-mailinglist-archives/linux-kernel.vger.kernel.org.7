Return-Path: <linux-kernel+bounces-744802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5959EB11125
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68785831E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B726CE2A;
	Thu, 24 Jul 2025 18:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Csu6nQln"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCE21422B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383005; cv=none; b=Y+qSeOmWlE1XrG1AsDl8lq235l1PyWxZ67Yn3x36/4CRABUtf4F4OGVFqaRhvznXLjwtu5vQU+Zhj3qUcoWhl+dXBjkbY1t7mw5xzDvdpfewC9uHpETsTeESTeSADTA10TqPjSpy3NGGn49PwyYT3uE6ZB35KIZbuPZZN0Mhu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383005; c=relaxed/simple;
	bh=G5C4mzPGDXF5x9ODvBwjqri/9D9M0K4qppMDG0Q1Ugs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaJjTz49KQ3f1wkjJeLitg4NOeMbUjD3bvvAiA+YqQllenB538J1S/ysC9Gcrsxw7fQXfdb7yDSPympK1C7brwbOaSjeRJXGqn4W7w7n4/45jhBap6k7CKF4mgGvMRz3WHjB+rqP6gafohW1YUpwJW1ZBt1mbjokU1Nrk9EoEDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Csu6nQln; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-73e82d2ec21so684324a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753383003; x=1753987803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDGAiR/MF/7h8+9i+INY+MYAQGP+1TEqMmWynuyvVC0=;
        b=Csu6nQln9l1nGR7ViAakCsVgxB8DHSLIKww2OQ3jr0hG5MBVqA0bAOm9ao28uC2X6h
         ptj2fg57PsueR5BrvWC6nb3xPEE8RfkRJ5zZi3k+ZalgXLEsKGRzF2+7LDDTkGqz8+UO
         HumFPjVIYlkgZ8ZcS5nuO1aWuGpV3WPyxUT1O9uzc/V90fuvGy552auneJ1GoqyhxNpo
         EAw4I2QZNW/6PAJCpV3Dc/VayfzdutX6uy9t8uJMFQWTFrV0rShAjdCk2495shFAxz4B
         E2F65p1E+It6GdwgztAz1SlJw3ER4b/+31WAc3RiBoasoyS4CdwZWXKjxFcubN4y6u/8
         k0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753383003; x=1753987803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDGAiR/MF/7h8+9i+INY+MYAQGP+1TEqMmWynuyvVC0=;
        b=MAxw8Js5K5YKEs0zf13mIgc816dq7Pl8DXuw4TOgWMMU/mUT8v7D0NQYKBnp6ViVJF
         i28OuLr1H6a6NIFLOg2EzJW6h7LGrSGwLzl6yoAgG27RrC3sApCbzJ+fEXYcjdLgVrRO
         UgTMwVlVsz0nQFBhBgjVHF96Hkbk0HE+Ro1+744OdFG6fnKzCzbb2VCy8++a7Zoadejw
         TdlCONerQ33J12FJ0XxCCeXceYHTng9Vp0W9YJjxM+vTYh1xe4GGat7RgK6AI7AHjZPQ
         BbIH1RLaB3Kz0w5CsT48Ds1VQiI+n7GU1BdycJXPBb2vUWvq611+HsJV7ileDCoA30dN
         0lrA==
X-Forwarded-Encrypted: i=1; AJvYcCXft7wYRJE4LvrJEsmSLkuTOLPLgJt2ikCqah6OBOYIKFKIman/fccXJs9fLNEIODH1TSUAY/HIvtMhlPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMmRlZv3mpO63al17t4luLF1UKiWPscCJ2PKL/e2lqeS4hiLM
	g45wBm5zrhYvrr9tjo8kTctz0cuPp+H2ZEsaKduSYSvfZ4oUMqBImZy2rBSj5HVdiRI=
X-Gm-Gg: ASbGncsgMsmXqAbtt64U12JRfZURgtrfcAzotR8CMMNQuK/cTfYaD5YuG49qp63kLPc
	AYwa5+JmTFzaXJSNYaxaywxH4Mmf7QDbx/xPdN7cSeiDxu0cRrZL0axtLnztiYb12+cQNx0JOwY
	fRQCzP+ssbqihXKRxJdS74j81ULZpgZ82akQiY+knOW2mfh159uMEVThkw/Si/lXWaz5cmDSl/d
	DxfTja8QfQKFdG7a4HvjvS1nSo0I9K5JF6u+Qt7jDPjaQDdSG1cx4utwJMuONcmh90ulH4fL+kQ
	2KvkwkQE6m3nppGwY83g4w6s8VVO8n/rmzbfpXEB5g5rNblpbLqq/swM25ilCDmM4sUL23yIMWo
	h1WLowmDOUzvF4WqfhDGSc0B7M1huad9TNxAtpI4rv597KtdQbOKIzhvmdu8jgbZxJRDESOAs9b
	c=
X-Google-Smtp-Source: AGHT+IF2VA3qRZNatjMoZ+7jjHwZ+ikWklknaE6t8u9/hB8gztHVQ2WFyh7bE/ctVaAXwSWngvbs3w==
X-Received: by 2002:a05:6830:4d95:b0:741:21b8:b247 with SMTP id 46e09a7af769-74121b8b848mr3838706a34.12.1753383002846;
        Thu, 24 Jul 2025 11:50:02 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9829:e9f9:e475:a206? ([2600:8803:e7e4:1d00:9829:e9f9:e475:a206])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7412d31acf6sm348944a34.52.2025.07.24.11.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:50:02 -0700 (PDT)
Message-ID: <fe3f5832-469b-4d8b-9d02-ea716c07c5d9@baylibre.com>
Date: Thu, 24 Jul 2025 13:50:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] iio: adc: ad7137: add filter support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
 <29786806-6495-4423-9172-e924c60b93d6@baylibre.com>
 <20250724142001.72181c21@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250724142001.72181c21@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 8:20 AM, Jonathan Cameron wrote:
> On Thu, 10 Jul 2025 17:47:14 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 7/10/25 5:39 PM, David Lechner wrote:
>>> Adding yet another feature to the ad7173 driver, this time,
>>> filter support.
>>>
>>> There are a couple of leading patches to rename some stuff to minimize
>>> the diff in the main patch where filter support is actually added. And
>>> there is a bonus patch to clean up the ABI docs for filter_type first
>>> before adding the new filter types introduced in this series.
>>>
>>> This was tested on the EVAL-AD7173-8ARDZ evaluation board.
>>>
>>> This series depends on a bunch of fixes, so we'll have to wait for
>>> those to make it back into iio/testing before we can merge this
>>> series. There is also an outstanding patch to add SPI offload support
>>> to this driver, but that doesn't actually have any merge conflicts
>>> with this series, so they can be applied in any order.
>>>
>>> ---
>>> David Lechner (5):
>>>       iio: adc: ad7173: rename ad7173_chan_spec_ext_info
>>>       iio: adc: ad7173: rename odr field
>>>       iio: adc: ad7173: support changing filter type
>>>       iio: ABI: alphabetize filter types
>>>       iio: ABI: add filter types for ad7173
>>>   
>> I don't know why, but I really struggle to write this part number
>> correctly. The subject of this cover letter is wrong, but at least
>> I got it right in all of the patch subject lines.
>>
> 
> Series look good to me. Give me a poke if it looks like I've forgotten
> to pick this up after the precursor fix is in my tree.
> 
> Jonathan

Sure, no problem. Can we pick up PATCH 4/5 ("iio: ABI: alphabetize
filter types") sooner though? I know there is at least one other
series under review that is adding more filter types and I am
getting ready to start on another one that will likely introduce
some more variants.

