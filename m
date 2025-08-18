Return-Path: <linux-kernel+bounces-773944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4DB2ACB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451BA1896181
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C7256C6D;
	Mon, 18 Aug 2025 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ArY4HTC0"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA90E253B71
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530567; cv=none; b=TiJhcTtjjdyJNRmk8GzfRidKtl4iouQ4imwEcXIvtwd8Ww7arMGBQaE+AIcjhEfOXl2ok+ySjkXXeZNJTz7R1MRYMQdpWcbHQgDzHV437GqRnM1rOxz6zPQrNcKXKYUkAmagtxclaVBot2O0YcN61qDw5LaDzM/kQecmtQjeE8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530567; c=relaxed/simple;
	bh=cL/BkRePawzT6v72IhLPr6FG3t3IqCKEZ0g1meuYxH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txL0cfsMeu3AdSPdHQ5ycEWJQvsUMBXi3I0GsYalcsJp8FfcqeVG5YhUO3pcrrNf5FzrxvIX0NYRNollewPVMUgLUJn62fcW5ShpWeqNzFarTMWZHtehhSDQB8zx1gYjxyDQfXRfF1HxdkINlIKLoyG3M0Cs+q2cwpvGOaCDQYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ArY4HTC0; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381ff668cso2248714a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755530564; x=1756135364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTxGCx4zj4KRJ8B1DI2WEkLZlXQbTwcBBSMe4+Qh/hw=;
        b=ArY4HTC0Vs+Qzk4A7RbeiR0uhQcLYIQQJmOsiUPAvKYaIAtEquqJC9OPdJ6YEQVArt
         DTgXLZa5UfY74Fd+lXPMf2MDLctEQ0ft3DmRhetxd/gaXFxQdljYa9ksyCyQOmAsSJEQ
         GMMD6gyLbzbr1WtC9i3kwffESu05EiQO+MmFJN/3uXV4i4mERcP99LcQsdErx2OTLG56
         vmjBNiTBVOVE4srAE66n5FUyM2HlRZTQcsIT90vLzoeXM4cFPP6BOafp6icDWnxZ6UBo
         WtwRb90kWxsSMTO+nOpIj/z7CvhmBQAZfhz5e7X88yMIBjnXXFZXf0lKIXIR4pEkDJM5
         o89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530564; x=1756135364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTxGCx4zj4KRJ8B1DI2WEkLZlXQbTwcBBSMe4+Qh/hw=;
        b=deymcDnjoPomNxVd4pg9Bll+JNW3zQYq3675QoUQkw3GWy81e8o+Yz/dHDzM7mfbx2
         moVedQ2DbQKpRvMJZoVWfvgHidLAfyZ3OkhtbcIhy05n2glctoMIapu+D3WH6vLZJ3PC
         BVJPyx1UNQS74rQ8ApHqzwimsyPaBejq+nrrhNeGZ3SIW6lVVri+xYtOHqdY4dA1HrTM
         fvbo6xr06Hnug9kg9HFM1ZOqLARjkT67xsOhHB8WdaqzBSd+Cf0AAv/8gWUT4FGVFPvv
         555g89t4N7ppj14Fii5N6Brfl/yKuiUcq/jNDu/s1KJENOlXhSubg5SmrcCHOAZfUlng
         Y0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUus5XdxfxAxpz9mLlX8rDupxOUZ22ldKX+P9PfIAkXIk1Oh97DLTm8VU01+WiDSLdmf5BkAcvQ0SuCmfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JPgVIYC6z3cY3rDb+8LHJHZN0AdGoYXI0OJHHFemtf1jqWsc
	kSzVW6nVspATNGidbVhOFuxL3jMji7YowwBlQbSlaUATBSC8sTt3iKbSnSRhDBrSPMQ588y5vYt
	vewiQ
X-Gm-Gg: ASbGncv028crXnlSjvxP926JTO9c8kb4AmQFE4l1FP6spSroUe47koQmP5z2twieBiu
	PZ846/utOukANNFGIZM49FCvztFQY6FqzMUyj0neLRTPT383Zo7Xdp8rGpzzmhME128vWJ3ddwT
	STRfod2TcT/7QfG+hYz8TSDEamrTlJZdZ4RVdjbVkfj1U8W1k8i0DiLkJvz5v12hYk1FSuMcglL
	EnPfS3o7qw6reMO/22B4Bx/f+f7B8KwW5gbP9Tu+MzWG7Z6jYLPWqd+5IpallgXYYzgNAFgSzZr
	EUcXpt3GToOTGVm1cumLOeu5KJP2S8aKcZnNXvD9X+5COeUjwZPMxsohUpx+9AC5DMXTWgRdvFO
	vK51cMutN1dyTt04/lPjr+DAg2ntwuwoLU865ExaeGwcGjOAOwHZ4lMb17gFrcn+VaqIk0yNsZy
	A=
X-Google-Smtp-Source: AGHT+IGPBTHW30IdobikaWZYenZffvlRVfNOQG0PIn6NtUluKl6ZS29TrtJlRc5HqzQnb05egqYH2g==
X-Received: by 2002:a05:6808:50a0:b0:433:fdfa:913c with SMTP id 5614622812f47-435ec4c9ad7mr6463423b6e.30.1755530563885;
        Mon, 18 Aug 2025 08:22:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1bfb0bsm1759838b6e.22.2025.08.18.08.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 08:22:43 -0700 (PDT)
Message-ID: <0b9a3b8b-11d5-4722-a7ea-e80d893bc209@baylibre.com>
Date: Mon, 18 Aug 2025 10:22:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
 <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
 <87frdp119x.fsf@bootlin.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <87frdp119x.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/25 3:28 AM, Miquel Raynal wrote:
> Hello,
> 
>>> +  spi-buses:
>>> +    description:
>>> +      Array of bus numbers that describes which SPI buses of the controller are
>>> +      connected to the peripheral. This only applies to peripherals connected
>>> +      to specialized SPI controllers that have multiple SPI buses on a single
>>> +      controller.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +    minItems: 1
> 
>>
>> Finally have some hardware to test this series with using 2 or 4 buses.
> 
> Out of curiosity, what is the practical use case and intended benefit?
> Maybe an example of such device and an explanation of how useful this is
> would be welcome, as it does not seem to fit the initial spi idea
> (which has been greatly "improved", not saying it is bad, just unusual).
> 
> Thanks,
> Miquèl

From my side, I am working on supporting complex analog-digital converters.
There are many of these that contain multiple converters in a single chip
and have multiple serial data lines so that the data from each converter
can be read on a separate serial line to speed up throughput. And in some
cases multiple chips are also used in parallel to the same effect. I.e.
all chips share the same conversion trigger and we want to read back the
data from all chips at the same time to get max throughput.


