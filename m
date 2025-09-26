Return-Path: <linux-kernel+bounces-833747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4F4BA2F18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC8C57B6399
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED6928DF0B;
	Fri, 26 Sep 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENQwCCYN"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA810942
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875266; cv=none; b=BvCcnPBzxThyVTOdW+5LFU+TTkFYm9lXdlYTe4LiH4U/2bEQVC+/gxwQkPoG4Zwqj9vh7CoHLD8y1r2Q6mfpXKX41EbczoNrsnCfv5Qwhte/SoBPr4amI1R+ofjy2dCBqYRBaiI1FPTVmyU+TL9hmon8fyyhYTJMzaYk2LV3nFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875266; c=relaxed/simple;
	bh=FJ32/p4g+CxM5aiz56PxjKWyf3TIW+l8HDgnXk6ULco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anwmJY+niBlzWcsAtSgR6DGZRknRyI+IpYRSRDffaW7VOIGbjfAZlj2eYRuxh4hsbNspaa8ZvRfk7rSmzEl1OoVVdbciAr7coGJmQo8RUZx/jxBEZVlPI0WT0b+VX//RrSXVTi2i7zOmyiqSKuKOBYqVomKvdgrP+rBAakzq3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENQwCCYN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7811a02316bso199295b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758875263; x=1759480063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3c75WAzk0fFcFdEuaqWRC+mXQtAjTaZTP2dlJBnjvyw=;
        b=ENQwCCYNZuGCdsWln08O4tGsY7haTvhaSvBmmO7w4mIORjv3onfsPRJpKkjyYXN8Av
         O/3y1eLgGUXVFZZkdxx0TGD6PDZO8ekjWBkfD0raCFLfdON621d1jz+Br5Ur8K24bImF
         VSbDoSR036OfOa/Y2aOG7cUSej6ibV5kQinIvUut+x1piOT9dbm7Pl77RYhmIp9alV1g
         BVKUShTppIEVLQCTDhI6Snk6OCsglgRRXvgi5gSisqL9qz3Ei1qgcQ2nCYfhBbpvcyVv
         vnf0sLYpQYnYec3wZ20G970mqzmQ5YbezKd/ckRngekNkMaAVe5XCW/AVsonFC76vEKS
         d0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875263; x=1759480063;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c75WAzk0fFcFdEuaqWRC+mXQtAjTaZTP2dlJBnjvyw=;
        b=BlceANyqFGWxTMYHeM5yQPH3siE5vO0OiJjm+ARZfakwrvQMZMg5z8RdKPSKKm6Guw
         yz1iSiYVXuX+Q5OHfDPkOs0gY1+VE0qeHiwxrFsX3XqjWHOeayte2/lahx99Rxu0vjum
         i9IUSDPqALRdqEEkyhxu9VwKqxRycfO3NSAcpAWRX5AVBp750MLNnB3Mp9WbL8DfT1IO
         +EAr45HK0g0UKUtM0VxIntfA2K5EWAs44KpTJPZcGFS06jgIjphXmZ/Ju6uAR77kRrP5
         pGaevEuCPscKVchvqC/9mZxINFGjC1NkjKwSIoyVb7m9mWBD3F/g2Rz0io5EyFrI4IYG
         yrWw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Dip0AIeprQdCKBlrsQOyKQUnCHKaHaz6Ofs6akyr5NsN9vy67gwuUY9ccZD2Ze3jnqdQOhgyMzd4aMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0DSpa9WANGjp2krNVcPWTyEVF3+SUu63WZlhZtVujNg+RNPg
	AzVzaz44qDYUda//Uz103p4sHBdmRQaY12J6RAFVBf9hVYWj4Jc7Auc6
X-Gm-Gg: ASbGnct0W3+6WrnGYcLLB6qvIITRc8Y8GuQUhMEUw97/a7Qwgis3R97R+ZL1PbwZjTo
	qXLUMc05F1OOeSu6zCKe8M6Q4UvfjJw8rUVEJme5x+xvto9ieI+TxABHFpqNqY3HCqCfEQKft5Z
	3A3RDrv7t4ovGzHJIzgcAXCTqznhVwXGE5Z6NmrZQcrmihSV8OOriAY/sQHNwK7nMwHSK2ZT8zI
	+g0da030fh14I1LhS7RAMVwSDliz9mBfDpcmIpB1NvTiSe4zaW/FRAhROZYJNfqqckUlUcwFu+2
	3ukCV2uNBqBQoNBFsppslXikc4bvTLs1USfvspNVoX7oW4GccwS28QFRWx3cohmBU9a8aXEncfl
	IayY3lFMuTKR0X3LYuel+NXokUCMFBDNs1OtKbaA6QJaMPCgtww+HkyCV7eFBshOBi2QKLsY=
X-Google-Smtp-Source: AGHT+IFVG/zIzdk+YYb+6Peneg1BzhpGa8nIP/03clP9hKSS2cs92RS7kDIAloGplbjParz2Z0AAUw==
X-Received: by 2002:a05:6a20:258f:b0:263:b547:d0c3 with SMTP id adf61e73a8af0-2e7ceeee380mr8397622637.36.1758875263508;
        Fri, 26 Sep 2025 01:27:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53d9160sm4089812a12.22.2025.09.26.01.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:27:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f35193de-a106-42ec-b318-1501793fcfb9@roeck-us.net>
Date: Fri, 26 Sep 2025 01:27:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in
 isl68137
To: Jeff Lin <jefflin994697@gmail.com>, jdelvare@suse.com
Cc: cedricjustine.encarnacion@analog.com, ninad@linux.ibm.com,
 andriy.shevchenko@linux.intel.com, johnerasmusmari.geronimo@analog.com,
 Mariel.Tinaco@analog.com, jbrunet@baylibre.com, kimseer.paller@analog.com,
 leo.yang.sy0@gmail.com, nuno.sa@analog.com, chiang.brian@inventec.com,
 gregkh@linuxfoundation.org, grantpeltier93@gmail.com, peterz@infradead.org,
 william@wkennington.com, krzysztof.kozlowski@linaro.org, tzungbi@kernel.org,
 thorsten.blum@linux.dev, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926014552.1625950-1-jefflin994697@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250926014552.1625950-1-jefflin994697@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/25 18:45, Jeff Lin wrote:
> In chip RAA229141 there exist ISYS pin which can report the current data
> for the device connected to this chip through this pin by routed by Direct
> Memory Access(DMA) command. To read the data in ISYS pin, we have to set
> the DMA address to 0xC5 and then read the DMA data from 0xC7. And then use
> the Direct read format with 10mA per LSB to transfer the data in 0xC7.
> And for ISYS input pin, the DMA address is 0xE0D3 and for ISYS output pin,
> the DMA address is 0xEE42.
> 
> Signed-off-by: Jeff Lin <jefflin994697@gmail.com>

As submitted this is a no-go, for several reasons.

The description should describe what is done and why (i.e., here, describe
the added chip), not implementation details. Those are useful as comments
in the code, not as patch description.

Introducing a new sensor class is unacceptable. This is a current (I think),
treat it as such.

Changes in the core together with other changes are unacceptable.

A new virtual command (or commands) would have to be discussed and be generic.

A new Kconfig symbol when adding support for a new chip to an existing driver
is unacceptable. Besides, the new Kconfig symbol would have no effect if
the driver supporting the chip is not enabled, so this is not only unacceptable
but wrong.

Regarding the code itself: Stick with existing coding style. Do not use C++ comments,
declare variables at the beginning of code blocks.

I would suggest to add support for RAA229141 in one patch, then we can discuss
what ISYS_{IN,OUT} actually measures, how it differs from IIN/IOUT, if it indeed
requires new virtual commands and how those command might look like, or if it
can be handled by mapping a existing commands.

The datasheet for RAA229141 is not public, so be prepared to provide a detailed
description.

Guenter


