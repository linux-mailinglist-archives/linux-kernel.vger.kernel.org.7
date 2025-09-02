Return-Path: <linux-kernel+bounces-796724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C6B40653
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5221188EAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52CF2F5319;
	Tue,  2 Sep 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X8CPfwPl"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F9FC8FE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822333; cv=none; b=kYYAdCEUzD4uQWh2jNMbsL6nkAGaGvp1nas+HNylkMdaQYWRp7g5CO2lBVZSj2Nuf8N5rmR5I3UJ6ekMD208sd2e6cyUJ5raU1ZrSIs6OmXC49eLwQEHKOJ3njY9hpc71lF/ILqww+fYGlDJhUoQ7EddDDIVbdNkcT3PAcgAAnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822333; c=relaxed/simple;
	bh=xgRzeXI2CD5w/fM4iCTLNx0usBOQ59YNNKel8DP+qug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j12G5jOcB7a09okSv+L0pX1x3+tfbYIRL2X526Z/uxOHw6GEJ8CXf/TeNOcmCoGaj2zsccHCyYg431sI4ljQai6+xQuOJkZONYt5cOq/phfDe53hB6mLbcbS+gSuPaeydjZt3MFKA+V4qUgd6cJPPmc60Q6x7iG1J5LtUuaczMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X8CPfwPl; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61da7b78978so3279008eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756822330; x=1757427130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNZKVTJfYG5mU9g/1mQ/DuNW173Ja54Z3lvAivJbbvI=;
        b=X8CPfwPl/w1H4cfcEG/iP0c2UeQrUabl68gBwbwapsQYkPgB8BCiblYAV7u9a/oS/U
         iNbEtgULIEvR5794aW0IctA+xpb8s6Mcy4gDxdzkl1fOZkyXeJOhSlluYymrm3KBkmCY
         NQCmVie1kGYTAc2P6DHl73Sk3WFtlb3MveIgiTUKVX1AmTHgF2dNjAHcJ7ekK1+xmSFS
         9ddQ3+FwgEUZZ7vk9U+C8UMzQ2fSB649rkhVBCtuV9+lZQjFjPJdfPV/1xammkqQ/vx5
         gnHg7yr8/6V5bvxAkECXo2cuodxS1a2Tkq4IdPH3oYqWZRA89H41wUvRjg3MQPxw2co5
         w3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756822330; x=1757427130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNZKVTJfYG5mU9g/1mQ/DuNW173Ja54Z3lvAivJbbvI=;
        b=rCESN2K8XF4kgiATHI5mafp5eg4nOyAUpN1oOear31D4PaaOYXrDPkklPAdw92Ccah
         s7VzpFNWvixhIr6Yy+D8RkDoE8zIXNBWfGve4mm37eKceo4T4MvBz3zosgc+vqfYiUIX
         F4MeMGQBAff7HcFig1Nt3XcaizuCxfyIn2dzrsLxJVVO84Hm79R2eTj8RrOAB3BxPpsF
         Ai5G1A6k7Bw376ddTy7fQOh4OaIbIoAf5hIpn0alFOTnEdMxLqlg/57B8pnvjNBjACJ9
         VyONgKQvWB2Gv/EFb2H6BYydUQT116T3Zu1+NravN4/Vrz1t6z+BxTYQzYvqW0tzsXZY
         JpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKrghZ/1aI3FUJ6ioV72g0PW4zyKKXhYee/vZDj/3iDiiQw2sZVsyureAmcE5bg8FkiLLnNztBHf6/l6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxnY9u7UjDAmpDAz9XimlpWqmZsHgDdso72biNTzEOEoatCB74
	O1FPcZmmelEnCz/MPsKVkOIwbeuHKl3q08OccejpCL+5ZX9/PVfxVPsa+6unHC01QEA=
X-Gm-Gg: ASbGncuG3AfD0X6KnryR2CuuEqpn5xz2h5CIP/UmB5Yx6yT2NoGZ5HrnVDTrknX1mKo
	vB+dfoae1M89i6H1krQCZMyH3IF1sDE0N862tnfhZegMnlg8UYcdlFYumehGMb6LC/2TrqCDfQQ
	kCs8DaXVNRFK43XfkinCx/Tqum4TZ4ZT6Y8rcsjcjQiNbxRhZ3qDW4n1niibrb1f3XP5cXsBuF5
	o52V/H3Kue0jWA4go5c8xYO1feBTmza+vBpX1v/yhE2DXsWMRzpTxiLP1XvSm6paE8vlIMcjUgT
	ha+UBBpy8wIgR6glAB3t4r/zb1MQ+WZL6NLhUx7n8IyI5V9YYIX2K6EpoMvaYfGMidHsoPTiXiG
	+Ur5TwR8Vcw4cJeOMghFPvHIMjWYXIsDAx6Yy0W+4VeKF2S0DRetu5bP+9+o3XqA6mOqizMqium
	AH1Mo7CRUIylXns5XbGg==
X-Google-Smtp-Source: AGHT+IENGpjIQSKPQ3/J4nef7N7bdmmja3tu+Ub53CLM4ZX5k8/MduKyP43yqbZL+BkgmS4ttc1JIg==
X-Received: by 2002:a05:6820:1c9f:b0:61e:1fa9:ad86 with SMTP id 006d021491bc7-61e336f522emr6089858eaf.3.1756822330090;
        Tue, 02 Sep 2025 07:12:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b? ([2600:8803:e7e4:1d00:8d95:114e:b6f:bf5b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e31f1d616sm912783eaf.8.2025.09.02.07.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 07:12:09 -0700 (PDT)
Message-ID: <0cc072ab-dbf6-40fb-b753-13453b904974@baylibre.com>
Date: Tue, 2 Sep 2025 09:12:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] iio: adc: max14001: New driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
 Ceclan Dumitru <dumitru.ceclan@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
 <aLb0_TKn96nGbk6l@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aLb0_TKn96nGbk6l@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 8:45 AM, Andy Shevchenko wrote:

...

>> +	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
>> +	if (ret < 0) {
>> +		st->vref_mv = 1250000 / 1000;
> 
> (MICRO / MILLI)
> 
>> +	} else {
>> +		st->vref_mv = ret / 1000;
> 
> Ditto.
> 
>> +		ext_vrefin = 1;
>> +	}
> 
> And with deduplication refactored code:
> 
> 	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");

	if (ret < 0 && ret != -ENODEV)
		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");

Most errors should be propagated, so we should also add this.
Only -ENODEV means that the supply was omitted from the devicetree
and we should use the internal reference voltage.

> 	if (ret < 0)
> 		ret = 1250000;
> 	else
> 		ext_vrefin = 1;
> 	st->vref_mv = ret / (MICRO / MILLI);
> 
>> +	ret = devm_mutex_init(dev, &st->lock);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +			"Failed to init the mutex\n");
> 

