Return-Path: <linux-kernel+bounces-757960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40720B1C8D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABB717DCEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83B292B35;
	Wed,  6 Aug 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mlrgkfhp"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118D1E2823
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494601; cv=none; b=hZETeB1sQcizodkehBCQZEpoBG1CgKZPrU+lMZbjB2L6uVNhLijOre6L2uf8URIqqpgo0Dop7GP+mecgfyC/+d9ZCyG3uDgSRqlqtiI7ra7skVQredPMYBbbAt8TE45r6fKYg6xKbWfu9GWbr0u508qcrwFe8cZZYCD/v0KmWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494601; c=relaxed/simple;
	bh=uvmxOPt36TrYQmAZH5PJimtskptI3m4APwNFvRAT5p0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGBhEEgQnhWc9QOGLc5R0G2jXLgwwjVmcnUXLRG1R4j6HrlWhkRs76udQUxwzWeD+kGbx6W9qpG9wtgsgTERCvePLXwxAVdEECdD9ZnsPtw7KCnFfIH0zBMzkKfe7gxnwSZTu30COS8w2uWVy/QgWivU9846Y3LGRtqeM8pc44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mlrgkfhp; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61997c8e2a1so18020eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754494598; x=1755099398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thKq8nqRZOrjc9MmhrunTNzuRRm/Pq05XYSm+m11iWc=;
        b=MlrgkfhpSclxFqg9LOKqOdeMYXIsk2PCUGRpWGY/tEXhuPHPMcj5gZ9/zrE1+zsIkK
         Y/q5narRBlPtijtt+TCUOW9l8jIy/6jJx0+IhHzWKzEpV/I4PAb7ILSIfRdzKLZWhKgu
         uNxU0aWrLh9EbZzyAZ/0f+W/EhB+yR6eteueaulYUhTkBW/GH0YxKjiQXsQc+8tvgZsE
         yoehWtAwf6YlLjxfAFVuqo1aNTTfLsn/1vpDk8J7llrGzqEJ4SHsMpssA3gmpg+YiWsB
         mQC4csXZR6DCFAYI8izDowXzxdClgJbvyjY1112gPT9un1jQ0/SEjMvBP93x8Ib73xUg
         avwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494598; x=1755099398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thKq8nqRZOrjc9MmhrunTNzuRRm/Pq05XYSm+m11iWc=;
        b=ZZOsvrO2sxO2xLx19QYmGqwh6QMcOflrfRqwkySUa76xcZz46T2qxjCdOU6D5bWf3X
         bqFbq6Ks347qh2+eDFFKaJ/GPlptuijWZ2WFQiG5W8qX/bFJR/ZVAJ4UrvLQ5QHcxBP0
         rLb9D2nilpoOC8I9a/HWLepXPIf3Chuytwti8r6lV/ckb5SZ1/HYv/bU+bBZQseJjMMl
         z4+VONxnjtufpSsDQjl5Nq2CGClMvBrOXUrw9hk4hi74K9kR7vRVxjs+KCF46m3OT/B0
         Ydl0RI7+Uifd8QLBUijrljQMt430ZzhmbdgRMqDZcUBrhoHmMJAoJXauHmblwZtqVRqx
         WDyw==
X-Forwarded-Encrypted: i=1; AJvYcCX2v+INNd9fPHAAEF9M0tLPt3IXloBIGM1DkCPTYtOZ6lYwjlvWckT264K4YHS6TOB2mqpR4EeDAtscQMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2oUK3girVzw3d2O0A05wc6+MwkQYy9SfNDdyHC5rZmWR1gOo
	BXuiL4mX3WEFTs0VGBVIqk4qJaSWkvyNQPydjiCgGw50ngptaUjjhkWMJGiLDUJoMfM=
X-Gm-Gg: ASbGncuGN7pkmYVUjlXvshNdGSHRlq3LlHLPshJlvVysii7NSjgE20QztiKcVGljovN
	3i5cqQ+4d/HafeT3jB8XvipSibdF2w1bGZH71plef9U4RHBzCB2WrhTcHfHgaaTHdLeG4jO3ZO1
	yYToqjMWOtyFIaqiTvGuK+ral6t5Q09G4PArem+r+geh/+4VdEeec1D9Dvjww3hfOvajKVxDRna
	Ixr98x9LBn7MAUpMLE52yGGPe/ZvAwltwryK2HF9rA9FnWd6HXjClJx43wc3XduIyxmdraSOhDO
	62CbFzfZtq4nIUa5tLkkvmYk89CWD1SLvzSaXYUEL9z2Tswh0Ur0cMf+/nQXubcGT+3VnAfgID7
	MmPPqjn0yH2uJXU/RgfL/QPQbC+NrdkUhp6R9kbXbAU9Jb6JK45CrxmmyzAaCRgEAERf1VsvFuw
	4=
X-Google-Smtp-Source: AGHT+IEgpLxbOH1IdG1r864d3lWsygwTIH9kiW5cLmLAD0mJvYuFu4isOEti/2PmnFdeRsjTDRUgUw==
X-Received: by 2002:a05:6820:999:b0:619:a34b:3e29 with SMTP id 006d021491bc7-61b5f62b957mr1973618eaf.1.1754494598540;
        Wed, 06 Aug 2025 08:36:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d? ([2600:8803:e7e4:1d00:a4aa:5c40:1610:d43d])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-619705183bbsm2402087eaf.10.2025.08.06.08.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:36:37 -0700 (PDT)
Message-ID: <6397c502-26b2-4fdc-825c-2f666c43ea95@baylibre.com>
Date: Wed, 6 Aug 2025 10:36:35 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad799x: add reference voltage capability to
 chip_info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Stefano Manni <stefano.manni@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250806090158.117628-1-stefano.manni@gmail.com>
 <20250806090158.117628-2-stefano.manni@gmail.com>
 <20250806155853.00003f0b@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250806155853.00003f0b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/25 9:58 AM, Jonathan Cameron wrote:
> On Wed,  6 Aug 2025 11:01:57 +0200
> Stefano Manni <stefano.manni@gmail.com> wrote:
> 

...

>> +	else {
> 
> 	} else {
> 
>> +		st->vref = NULL;
>> +		dev_dbg(&client->dev, "Supplied reference not supported\n");
>> +	}
>>  
>>  	st->client = client;
>>  
> 

I would just completely drop the else. st->vref is already
NULL since st is zeroed at allocation and the message is no
longer useful. Previously, it warned that the devicetree
contained a vref-supply when the chip didn't support it.
But now no message is printed in that case and this message
would be printed on all chips that don't have vref-supply
in the devicetree when that case didn't print anything before.

