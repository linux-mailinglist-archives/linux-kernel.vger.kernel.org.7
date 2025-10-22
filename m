Return-Path: <linux-kernel+bounces-865325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39268BFCCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A884C4EB85C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90F34844D;
	Wed, 22 Oct 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WILyl/bn"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02135BDBD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146044; cv=none; b=uqnEjXJ046LZwXkd0KcE5L6m/LhX0cH4Ub5vxFrBHSu0RyKwbi7774wEeh0BLEoeDb4GRSkHNhG4h9M5geVGdZlrlNTl1EMiRCkwII6gIs5wcRh5Ly0L4Glsi9nbV5Y/bhVs2G5ccp9EYnncJ5SGlfovMaJhd7sRXj9c+kxY0I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146044; c=relaxed/simple;
	bh=bJkRf2vDW66xzETEmduK5o/Wmh8MgCortzpmg5JEPoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJDI5Q7gMuO/h3SVBqCbnPaV6dgGs0TZnOeheECKMGZmdctGZdt851HkEvgHn5z8BjT8/4trxZQ8YyaWtTtd3NmoAEXRlz+a1Y+lX7gr/lVKT0y9cLUhCbVbvSnMJeS3tEzFm/LcwQFAM6Gha1uR1ptmZ0CUgB/NR7A6sQEwev8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WILyl/bn; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44181f9e5b4so4154113b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761146041; x=1761750841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M06GA4DzU6q4HcL9w50fg3W9nzfX6SVpmQDyjsPEDxA=;
        b=WILyl/bno9iHRovIoGuzt1qOrfFXuCFLtYkN9W1HXfo7iMfQKCh9aUdvScBILF1qN1
         qHEYWcyq5pcPdEtGuOSOaYcnBgcwXY9Q1HGMND12oMlaqdiHO97g+j0Paq58AwT8kg8c
         qXbMVqEt8VglL7upyQgN7NvkdAp6cgcHk4omYQqARv64nl3ppKZXCmJK2uCUUa3zAtGv
         LyS6QxCZswpi4NRMdRk5Y2ATzVfWtnucCnkuvTQP8xLKaf5Cm9xyCGc2lba/XKF6E0qA
         CcZJk6CxbPV4/2bB56L4AL1qmsoYLvUa6mZrropBBTMZUzL8dOi+mybq/UdOHiiW1ptL
         l0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146041; x=1761750841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M06GA4DzU6q4HcL9w50fg3W9nzfX6SVpmQDyjsPEDxA=;
        b=p8eRsv9g0C7hlq7qD7FsjKa2qqyE95eUXFmjTJz6OGlIrju6UjRTTkcQljcH5Lsp8s
         583qtNCC/zcFHTVOUORHIWg8zR7jPcr2c5r6q5Wj8YRHZ9uLKNxvucRGBeEIhOldSwZe
         R7crYjOt9VBfOK1lDoamXTBmRu69PCQBBwzHzN6ks2YM8gteocsOcqaF7q+jgJDral9e
         Lw5b4Nhurvj3QPEcTkw3hfKqVpGvKJVYuBVJ2/NrgoT8HOclCnuZjUxmYYCvuN16P1fR
         Vl3K0ZmcAYsNbGVJkIpBBnhLDPUmUyEoAskzUrpEQBdMBtLG7sy4Ojny23iRoAXws9z1
         oroQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhO+v9rh4tJu2SkHIlwnwBcmb5/zc4ksZO87GUcdh8fDzkOFErBeQGAayQfc0rPBu4sd02WPG2Bdwg8Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyifAuupwj3apRCf8BWLMYgO2DCus63eKcDrQUPYa3rNUn+QWbs
	zQhtSUbYK66H7z5fzzmttRnVvpZv8NeKVFRMPCeAHjOT5U9lHXpjJt8P7n3FiYP7aAw=
X-Gm-Gg: ASbGncuJSh+uc4rnWosNNVH3aM47oo5h8DentvCtICDw6xmUFucjAfToEJe4imSgZAO
	pvAMMBreeNUAVenxk/XDx5UkmJmCbi2Lv7/P58t1tPPDd9FK8LMOnrvid1cGlGu9yRGAbSDWVcW
	GWRqD4Z6q79w2h1dvEAbPhcETbRpCepMT/f+YV9E2ZBWppy+Zi6F3Ogu0+Mm2YtjCLmuPaO4tOn
	muFuOUuNWusUH+JgyVgyAVrxlKKTnrmPjulaRGecBZth8Ik54X68Kzajrc7wQnY0MYSmfZcmvqX
	rhM94rMC5BDoYLsqHSSyKScXqlbkYa+/W+oBrlWSxJLKIGwBy6wSredhXav3U7X/Q0zlKkHqxk3
	PrQPNcYXRBOO75wNrkJCh3KHaJAx3movO0HS7rasOFnVbFsBdmgEfItLumiBfDAq/hEgMpi5c93
	GwDpQ1ZH8rxBX6oT9O8+icLgRXfNU3GvcYqzfnBfEa68Upkz0xyA==
X-Google-Smtp-Source: AGHT+IH5X1dX+eTbtzPr1DK1hodPbkihzSGYwZP+aVpU3q50pmX97szy9HuXtGku72DLkLr+jPiOWQ==
X-Received: by 2002:a05:6808:2112:b0:43f:1b7d:b631 with SMTP id 5614622812f47-443a30af9femr9009191b6e.35.1761146040880;
        Wed, 22 Oct 2025 08:14:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:4176:6994:bd72:1296? ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df628a35sm3311240b6e.22.2025.10.22.08.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:14:00 -0700 (PDT)
Message-ID: <cf276696-2928-4ddd-9750-db84466e4599@baylibre.com>
Date: Wed, 22 Oct 2025 10:13:59 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] iio: imu: inv_icm45600: Add a missing return
 statement in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Remi Buisson <remi.buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aPi5vEp75jH0imQc@stanley.mountain>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aPi5vEp75jH0imQc@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 6:02 AM, Dan Carpenter wrote:
> The intention here was clearly to return -ENODEV but the return statement
> was missing.  It would result in an off by one read in i3c_chip_info[] on
> the next line.  Add the return statement.
> 
> Fixes: 1bef24e9007e ("iio: imu: inv_icm45600: add I3C driver for inv_icm45600 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


