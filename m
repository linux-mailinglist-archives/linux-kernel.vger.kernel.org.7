Return-Path: <linux-kernel+bounces-896875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC83C51761
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABDA7501570
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66B30100E;
	Wed, 12 Nov 2025 09:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9oOxxT7"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258213002C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940264; cv=none; b=iMi9brPcgQS6axWxZ8KRSsmSVj+NF5O9M+AE+yDuFNncRL1qoro999xn0jqPHtE7vkREYoQZTsh2kbWi4hZwyM/U0BgbwOG40wlg9ULe5DpWDTnOWq6eaHnntxJnafTjFjlqG085jpHPhND0m8jdh2cYV2Yk3QOB2z2vDCHFgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940264; c=relaxed/simple;
	bh=kqDDnduyUUh9PtMAAC8Iw27n6POgWt5b/f0jd8ADwGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPRcfFYrujUYlZIXMIVsc1h6yy8vpm6fuTz5MflwxF9D/zAdX1it3pwyQS60bK1AAqXtJRhbQS/cC/cHAfNAvD0CNWhNLjz4hd29NkhzqwBnLEkLx/j1yGOqUvBDxU0cAcXFDRQEAC1k7AuOXCS2Nfmi6Mu6i1pxyPVMxfvpA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9oOxxT7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c7e438a8so477984f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762940260; x=1763545060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kkR3PECBtgg2Ta+T3zNVyfwyQ39/v40ObIhIUJF1Ho=;
        b=J9oOxxT7Ju//2ES9jzGeCSntrAyadTvcBePrvjzmAaNYwI1jadsazyU9EwAvziBTdS
         lb3PeIrTXqmvym96RAlhkJCSZ+ZLcuTkD9p84Zu4pObAAZ7DfeWHfrlv2IoopdmTG9Dp
         z2PHpjDx4AU6E+AAEVb2W8WabuA2gKcECUq+kXCtLFleghfDlUZIA+OfCoHQDBt9k5yx
         lRmLeHAoS4PCM6MCOFYiKADhF+YC4n33Q980W0EsCMupAxm48cY9bsb11EvgiCGhM9vV
         /Z9Ha6x8EJm5+aKwlK9hHFg9Jy7oxmHBYkrXjnq4kvJ5rS4U3c18pDEbfzgDDNrnaUdj
         3ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762940260; x=1763545060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kkR3PECBtgg2Ta+T3zNVyfwyQ39/v40ObIhIUJF1Ho=;
        b=Wa4AhOkT+ThIgeEvv+FsYQ8S/7kp8RHYhBRbQtTx+QneGutwk8xVbHb97ZyoFWKl4+
         e7RLC/RwWUauUlz/4grbogqraCA7knuHsRPakbo+sTEmPYaapkJNL10c6TIURfg4ALIr
         HWho/G5VpGwqsrJAKtI0AOUqILU7+hWgIee7wHIdqa4ePwSaQX4PE2PNj7EfLQuQVFlb
         MlA0mO0POEKCTgARajc1kJ3nQrjW/j7XoAxnZG27xuXkgnP5TGQZDxuIyaHjovXTrTf6
         lb9Q+AzCx79jOebRAqqreuxhbW4aCvoxiQL+ZMuZ2/LbMWSXnlNXVCscLRlviMZaLPT3
         HlwA==
X-Forwarded-Encrypted: i=1; AJvYcCVyuAFHzKQvMdIQZvRz/guxd4+uf6GLh7WElEWLxYDC7scGOAJ8tyGdYrw6CC1KPGd/zxNHI7iCbK2PSYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlqv1r695MaYhUE5nIiIbvYeYg42Z6YR4Lsanqf6/+m5cbInxD
	CjI0RzZ7HISidxG1/h47M7toIsb2o50GqbNB+yG91W97aeo/rr+ybg69eNnGvuPt9WCU8iOeHbc
	AvHuFqtQ=
X-Gm-Gg: ASbGncsD4Yj9MnAhSF5ErnsFzJLG+u0/bS05cR9pDGvhs1PBnI/zSYW8rHUdVTzfktT
	7sGOcof9ckpfBW+jQdF1fnROEE8M/DmiCI/yc2DMrKlp7d0gJpwSW/ZE16iV55J2jmAAL0Qq8dB
	exHUwefsB4vkJ/K3kmYzjVv0ibFAIk6Wqg2fIq8RrrEsqJQbSAlXRYgYuZXJC/g5NvO/Mj595/g
	gQFCaixOMMstFOc8VsufmPD+OFSTx2ycQ9eLx4X5D3IeojxjBoP3hdlt80qrEfu9ox+VOKd1Sue
	3XYmIZ4N+/PuJNSRG+XicyUoS5TGY6DQothKZUho1sF/zT8+MYkvGwT4+GbUtwmC/10pGfl3q+Z
	S0boeueDb++jYUJvrYnE5UJjhK/5Y4j1pJulNZOdC7vUxr85/i1uI6Eq4i2zvQvwF+sBY5Vr4XZ
	MYC3wIjA==
X-Google-Smtp-Source: AGHT+IGZSi7yScfYmi/h+1qIucc+YYMtcUxa9jmazfcfm23PzWB2Va5yBYWI09vRuMxpAqpjCguVyw==
X-Received: by 2002:a05:6000:1847:b0:42b:3dfb:645f with SMTP id ffacd0b85a97d-42b4bdb7d81mr1738754f8f.47.1762940260515;
        Wed, 12 Nov 2025 01:37:40 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63ba87sm33821589f8f.14.2025.11.12.01.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:37:40 -0800 (PST)
Message-ID: <8a370764-e093-4987-9a5f-3a8c1d6d900c@linaro.org>
Date: Wed, 12 Nov 2025 11:37:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Hello,
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Sean Anderson <sean.anderson@linux.dev>
References: <20251105-winbond-v6-18-rc1-spi-nor-v1-0-42cc9fb46e1b@bootlin.com>
 <c67466c0-c133-4fac-82d5-b412693f9d30@linaro.org>
 <87seej7fv6.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87seej7fv6.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/12/25 11:35 AM, Miquel Raynal wrote:
> On 10/11/2025 at 08:54:24 +02, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> Hi, Miquel,
>>
>> On 11/5/25 7:26 PM, Miquel Raynal wrote:
>>> Here is a series adding support for 6 Winbond SPI NOR chips. Describing
>>> these chips is needed otherwise the block protection feature is not
>>> available. Everything else looks fine otherwise.
>>
>> I'm glad to see this, you're an locking expert now :). Do you care to
>> extend the SPI NOR testing requirements [1] with steps on how to test the
>> locking? There's some testing proposed at [2], would you please check and
>> review it?
> 
> Good idea. Let me have a loot at what Sean proposed.

I proposed to him as well to update the testing requirements if he cares,
he said he'll take a look. Sync with him please.

Cheers,
ta

> 
>> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html#minimum-testing-requirements
>> [2] https://lore.kernel.org/linux-mtd/92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev/
> 
> Thanks,
> Miquèl


