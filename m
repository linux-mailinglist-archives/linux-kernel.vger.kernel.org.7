Return-Path: <linux-kernel+bounces-825727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7140AB8CACB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D30E97E4F30
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF52F546E;
	Sat, 20 Sep 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FBgPD5BL"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4C19D89E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380015; cv=none; b=HZ/+AmPyNbKxe1ognt3fToxk7dz0rWczwrQ7h4P9roIFan64AZKG8FVYELOsZYSp+lEe3DPrsgBKEKb+eUiXe3cS2hnydnfIkM64NXrTxhCKPXaLORHp2aAXNu0Yu2fUBONXDB3HTU/x0uPon8o9MCxOm3i+5pcJg+5aI5hv84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380015; c=relaxed/simple;
	bh=76xbBUxliUkmRauXzdFAYfn7G+UtF3ZVcwCnZS6jb94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUkwyiJ2n0MVI/1+rm8K3sEAtpZdcPbpyYmb6zg0Go/tsXa7YBh8XKXEYKDuLNN5sFxTpUfptqKUnKq7iU5R1DJ/4Re2jkdqwc6/77XubSEUouYLUuzxPKCfFiqjz6ybNmaVLTQYxx9u/2cpJRG0SOotLbSfWE+/e6aF4bEFr0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FBgPD5BL; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-331e80c3985so4176138fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 07:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758380012; x=1758984812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xbMd89b/nMwvZQdvsgC9Qh67PYEiiWYT76aG8fJcCXQ=;
        b=FBgPD5BLBAoCjYAAGJZdI2UmkoUmdwIAqs5SEWEio0BI+YkD4S1VZE1kP/rmuVGECH
         3jHs/6eU3kHRvuQykX/EhOrjwJRtzKzeSMgMkmrRWq1+Vl0MaXjfut3w8G1lsdtZtrh+
         MkZCBT8y1jVF91bCo5sYkzNjDtuWc5r7DHwioZ8cQuyRY+uLU0oxnp3LVB7BPmRxV581
         BQ9iGXG/9Z5t6xpTXHUIbS6JyOridUK332nBkQpklHm79IUxEi4zD1El1esfPcTerzHN
         vRLt01CybB3/kqy4D6gT5l2BR9N8Ub7kBm5ielxWKIES3GEsAV/kNWX6ECPSNHJweR4f
         OtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758380012; x=1758984812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbMd89b/nMwvZQdvsgC9Qh67PYEiiWYT76aG8fJcCXQ=;
        b=esvsqcMga3dej1UsW0yMP8lQGu/7OvO0NcIWZtsbVuf4PZbdjRZl3/eIQM9/orrjgn
         DyBks08ppweEJfCpPXXuuMq0MJfIve6WuoZ6jZJrfc5U/FWEloduWevagKUce9VkquA9
         ZcDsE2PX1eibe7+2V7BvtLp7hvmPfJ4YnZCcWhK+rFH0HWJ5Ria0dUmooznExY41rUNR
         GkaVvlmEdKwIfCssocMwbvCFhBMO3q5AVPNq1IwsMaXBoUWPov+jXtgrznwgevL+m9tw
         eEASxsdJcpUgsQ8smxCvlb28Ip8V1rtXJ8Il3Hata2jaCqLYfhcvIIj5SdLJFF5Vq+cW
         F07A==
X-Forwarded-Encrypted: i=1; AJvYcCUBZK9So5wZP2inaoGxF6YEyMzEah4AMNPlgUwjCisBIapQQRWRnGrfzVHQNQPRwLfEfyddjP6V+eZKPc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoXiwLL+PvjORveDndBJNAeGATsGzGib3Qm9kdLvma54+xDT3
	a9pUfieJMCmGPCZid7GygM+MbhbPZjN9nVMjWqqhSBsMPaME1Z/6RLV7WwKtG8EO8tQ=
X-Gm-Gg: ASbGncsS/oSiWjHIsEnrLKK0FOdxmMSb/t+b7ghDVv2sCE9YhA1ZyhOY7pDVNmCh+LK
	psRQKYfDIvMRc0Y68xI6rKf8COW3NT6nVMEgI83KWkYfMarMGRMUN7Uvtzs//tVOzDxBeS4Eu6I
	p8HjagGRIOaOaCN3r/Ck7v3I9+5C5lwZMPsRWxHuP3dVFFx+KtuZXCYx0F4OfaT6tT30nMDZW+b
	DyIDfq5jx277gLn1L6ouOuoh4ayv7jCMb0p3MTF7pEfhv2SpvgMpYD3ZEqa8xEUaVZPa/wT+mtv
	NUrjevPdwuwlh1Q6OmubjY6c09B6Tb+fT220DkiJwiHagEUj2YpNECaoITTbb2LeDV8pEh39e6r
	U2xSLxN0Ij3bo54jtIbPgr+yO75piOjvDJ3alXpF5aITNlthsVQmJNpXdOh6ZWquAQTfEtrtYWJ
	5vj5Yaj6fNnQ==
X-Google-Smtp-Source: AGHT+IFtxS6pm8P+qBM7VQ/5xkujMyKbTLba8CfRjV6NkOCTUCAv+clFuIj/SxQDcTROVCvuV1IquA==
X-Received: by 2002:a05:6871:651:b0:333:7d78:7045 with SMTP id 586e51a60fabf-33bb5a705b7mr3448072fac.32.1758380011967;
        Sat, 20 Sep 2025 07:53:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4? ([2600:8803:e7e4:1d00:14ea:b68a:f92c:93c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e3af740csm4980635fac.5.2025.09.20.07.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 07:53:30 -0700 (PDT)
Message-ID: <3bcca945-b74e-42a0-bf42-24d01068d246@baylibre.com>
Date: Sat, 20 Sep 2025 09:53:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
 <20250920122404.76277a27@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250920122404.76277a27@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/25 6:24 AM, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 17:05:01 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Change the allocation strategy of the 8 SETUP registers from a least-
>> recently-used (LRU) to a first-come-first-served basis.
>>
>> The AD7124 chips can have up to 16 channels enabled at a time in the
>> sequencer for buffered reads, but only have 8 SETUP configurations
>> (namely the OFFSET, GAIN, CONFIG and FILTER registers) that must be
>> shared among the 16 channels.  This means some of the channels must use
>> the exact same configuration parameters so that they can share a single
>> SETUP group of registers.  The previous LRU strategy did not keep track
>> of how many different configurations were requested at the same time,
>> so if there were more than 8 different configurations requested, some
>> channels would end up using the incorrect configuration because the slot
>> assigned to them would also be assigned to a different configuration
>> that wrote over it later.
>>
>> Adding such tracking to solve this would make an already complex
>> algorithm even more complex.  Instead we can replace it with a simpler
>> first-come-first-serve strategy.  This makes it easy to track how many
>> different configurations are being requested at the same time.  This
>> comes at the expense of slightly longer setup times for buffered reads
>> since all setup registers must be written each time when a buffered read
>> is enabled.  But this is generally not considered a hot path where
>> performance is critical, so should be acceptable.
> 
> If I read this correctly, ever time we call postenable()
> this parses the channels enabled and first checks if an existing cfg
> is usable, if not assigns the first unused slot.
> 
> If so, the algorithm is a little more complex than it needs to be because
> it is allowing for holes in the used cfg registers that I don't think
> can occur.

Yes, Nuno noticed this too and had a suggestion on how to simplify it.

> 
> So if we add simple cfg_slots_used variable we can for example jump directly
> to the next unused slot if we don't find a match and we can use this
> as the loop limit to save on checking a bunch of zeros after that aren't
> in use.

There are only 8 available config slots, so I didn't consider such
optimization. But we could perhaps do this even without adding an
extra variable.

> 
> Maybe I'm missing something?
> 
> In general the approach you have here feels sensible.
> 
> Jonathan
> 

