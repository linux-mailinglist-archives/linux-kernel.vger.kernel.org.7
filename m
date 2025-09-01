Return-Path: <linux-kernel+bounces-795085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1731B3ECA7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723803ADA88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073630648E;
	Mon,  1 Sep 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MFN+p/pf"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB92DF13C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745391; cv=none; b=ThHJuOgAfTJeS/jpqNZ71+7PA2ZSSQ7ickAdG9yMgAimdEgu+fXU9ZCyuHQMFayZZ3bk0xRTIuhJiEea5H/PNxcItsPuXTGuWBgeP3pJR2Ff4txMqzqZYRNd7KBBMT7pbbhdcVSyevVC+TvfqqWrGezsR2toqyjaH+qgVWcL3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745391; c=relaxed/simple;
	bh=iCDOwe2JDN7D20tz+UUXodURXbkHJQguPAdWUx1aBKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdl62U9M5c7LjhfL3g7T0C0vTy1f2RKqytJFXu8Ty/tncsNpgpsimGQrsSuigJY0CeBf5jGQQdFQ1QWbkW5y+hTzXGZpdgejDC/FCDCsszk/z5CRyZ1nhISNauKJhMhlVrt+vaHuf9GfgJMZP1tmaesrtgK5gDY+wgla0RbUMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MFN+p/pf; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-315bab2917bso3135455fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756745389; x=1757350189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDXivowS1hfDO+0A526hQxq99iIj0yuPAX5zet9fq1k=;
        b=MFN+p/pf7Rdr4sVwhW2c7JAp11ap6C5/B9nowJv6rdqWCoKGLIh5GAtveEtIN4UcFL
         xHOOG4ArbWO/qlg6CNUBzjrudmR1gmc+i6qGqWF3UIw4cTi3EbM2Iu3qj1xGiZKgThQ0
         Ls/6/Vcx0bJfc2dGvNvuIBK5Cz8QXGRByKq/YAFFbUwDP4CSTho4JqvwR1LrPp1zJ9Q0
         JDhHCKqAXhsKtJvGyu1wGa2UaB4pGoMKYaOCylGsqNeoHO/hWinohaVCopDkZkiRDAMs
         gGeCb8KDq9Pzqxd0KwU/kWbAY/+k/2X03KUOLTt1Pz6fm910y+LZywhD8+gSaKojGpd1
         93MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756745389; x=1757350189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDXivowS1hfDO+0A526hQxq99iIj0yuPAX5zet9fq1k=;
        b=t8nclVOF3wVjn9HHHQ2c5xDVjnhQFE7QpIDYaDT4u04IbdjsESbS5Pucz+M/nlhEiy
         WKvi9VJffdbJmExxnVELd79VfuHXKOs+1nWn3TPY1HwE74mgbwV1wVOdjIVF1ach1qm9
         8lNTxmj0I6KLfeJISB7KnUaTy3wMaWto8kEni8h7lmykNQ82PrbNqxsBpr690e4m5WVW
         YiNnhKXD9/4GX60uYr+3Gq2wkbK+sD88hdzvks5bOs/jwTrS/YR+v0NfzZ+o1TQ5b0tq
         1kud+NBuliitLnS+uEhmcALWsfkoq0RMKRwXuNy96yPnKPJ//tgEOTQivcJuWnYI9CNW
         3a7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpXq5jcP2annspRjFOs5Pm6ee6HbFP0LAfjrGOB7BYtQSvHBWZkJItntCMnuHpmV4oXWhj8yA7gMxNNiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xW4FzwtH1Mr2Xa9t1swrNb8DctiU313MUyOSGQl+40WJQEBj
	pbaAQ4O96tMXD6wPYYFQMR996em+vzKK44/Gi/4sYD2z5pKFjDbfd8vXWwUwC8bGsZM=
X-Gm-Gg: ASbGncvnCmou8nm7AXrHQES1AemwOb0dxU7jUGWKD8BZvgHoneoPh/50L83wupBQJg5
	5dh1EVEndB7EZRrymxQq7lQjOvdNyQ8GHPWXnqujvSZ3Cg0IcivTTe+ya7SMf5eXS16XMvJarq1
	/KFPZTdHweG92Lvx5qLFQVVxu75WG1tGz4Jd7amDGOx9dQX42oLCjMnCaLpMTLZYb/lxWdPqaom
	yvXL3j8EmGfvnnHiaBwvDZCyGML2o2YSIl0IN4SbPP276wYs8H0nzISxlKz1az20dB/AvhoXST+
	souykLob8MXBjqupuxJZ6vR3C57NwqIJASlpW7IImHkvX+uFQdUzS8xI4CJbj1GN4Ul1Wj37i33
	/e5j787pUcz/W4MhC/dFKSGyN9jVG+xEXbByaG+kuTWnjMljy3+ZtS/fsWsqb+qPs3cvVjdBTsg
	xQmNmzlmM9gjk4rxujsQ==
X-Google-Smtp-Source: AGHT+IE0HZ+iWpQczC5BrtTUNwIlahZdv82jHW37K5IFPYvYtCOZVlDUlO7zJReBZU+9WammgJgrxg==
X-Received: by 2002:a05:6870:1582:b0:315:60a6:c28f with SMTP id 586e51a60fabf-31963098d63mr4606617fac.3.1756745389022;
        Mon, 01 Sep 2025 09:49:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e? ([2600:8803:e7e4:1d00:3c0d:2a9:2478:d89e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d2a7f3csm1797037fac.8.2025.09.01.09.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 09:49:47 -0700 (PDT)
Message-ID: <e610c63d-7db0-427e-953f-b49b2b5ad2d0@baylibre.com>
Date: Mon, 1 Sep 2025 11:49:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: Fix a null pointer dereference in
 pac1934_acpi_parse_channel_config
To: Charles Han <hanchunchao@inspur.com>, marius.cristea@microchip.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250901064512.1554-1-hanchunchao@inspur.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250901064512.1554-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/25 1:45 AM, Charles Han wrote:
> Add check for the return value of devm_kmemdup()
> to prevent potential null pointer dereference.
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


