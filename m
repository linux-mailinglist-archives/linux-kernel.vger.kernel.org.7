Return-Path: <linux-kernel+bounces-827924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A9B93713
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65022174AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF62820D1;
	Mon, 22 Sep 2025 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="by9vcJQe"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9C9189F20
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579334; cv=none; b=fjJtbASIvL+rnHfaA1uDmAhSqNbMAIRxdss/Cvj4hTMFSPgq9q+1bCKCyEEcaa3OTsnOPHuKRwYNmBp+Lwgvmn4fcaMb2e0cer9YaBz6AXNm8SbvRzEffxGzRgSSbNJjH89Yf4ao6te9fJ9PobKZ3qwZCGxMw2Jx99Feib+9wXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579334; c=relaxed/simple;
	bh=RzkyAiWGPIV6p+AvKmAXHMrRF6qrXdOWtTLyoFs77fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHF7Tf9lFXiFVU9nOufhipK9Y8k8gYW8VGR+z5ZFhpLteg802gLkCWTOvM4FNBR7+oFL+n+0h9dYCI1BdKwaVVr3EyK88bCI6y4i7ju/CC7uhxDuZwy/din5DjjzAI5Ynj7+o6VLU8R0bod2eThDZdjdblyduyN8ZS3PD2cYg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=by9vcJQe; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-341f608661aso1349555fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758579331; x=1759184131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3df8lNuWhvDC2rJQvD/ziJ2M1JBls7/FB1ABGRRG/BM=;
        b=by9vcJQeD6EPColGhUSB5oVuNQ6LxvyKFIFOtCrXS3hghVNVGMZBje/BSgC0SoCcdv
         2vEziLwRBaH99SuIKVGaSoSJC1LfTmGFleUKMidl2UjmhoXPspUkdhY97XBhskUpuv6X
         Wta1/0yOHyC9RIjbcYqTsXayHdelEWOObqGeVEfuIvD5/INnUe9KdHL88n3RHyfXolmJ
         /hRzd7C1MZTTuyWdkXhZBcZt1rmp0bo/g7PhIu2CC1EA+6PL3O/D1T3Ch4gYFUqlbql4
         5/GVHDUBgUMToILGL6tulvnJ08Tlah6No47KoR0SNlGFOKNV891wkX3XuX8tpyXjRXfY
         7zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579331; x=1759184131;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3df8lNuWhvDC2rJQvD/ziJ2M1JBls7/FB1ABGRRG/BM=;
        b=X56xj0flwifYWWE0fSlpU6q4FAyGPVvgXbL/8153amTv4bVPaQt5t9SZz+dYQP7SBh
         sK58FMstOKTq3JAXKYyzx83kk12vt/X2ZgVcPccNkxuR/yYJWsm8l+qFJ6XvSNCymGO3
         /A6+4c3009Qo0r5xEr02DNyXmxGMTKa1qDBuYYcC9/4i+YhC0JFvXGJm5xfWN3a77Yd+
         NgIRAE3N628PyNOJ1tEe/LkrOJFhKwSF+nZfPm4FAns/JWRwoTNOcQry/38pPbvGwNcF
         ds0qKBO5a/bsV6nLXTj/tCsiVAIMjp7mxz1uYTEnYpUPfN1hh6tvYwFHevIThdzTcrAV
         4Agg==
X-Forwarded-Encrypted: i=1; AJvYcCXX851NF1ZJXNa+oJEMVsG1esWbC6cAMNRPQ6HAFlJAV6ZHVImDfES4FEHpoXue6OLgXdstZNPdCP8Wigg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJh6e40H1wPddSwVU4RjI8xveV3XkuYLGtab4pb9uqTjXvXLX
	xu0JiiJjMmRpRMDi0ipA/ScmlT9GokjkJuwglUbOa6ylDekML/VrbjkEtQzcRfWudVI=
X-Gm-Gg: ASbGncvmowSul/e6rc0yhWZCnzjUUwv5S4IOWWXbaLMqq4788xdOBArf/L6YTiLgSjV
	XJtpzJeJPx7daLyPnR6vIYCLqmgya9rLKOLsQpBjVwH6LhNNKolh8mEfPzARnnfIwQSJ4BRArhd
	n1z4lNoFNK645i1NDVmO2zP1O2oyOw6i9+lrfftpvA0/566d5d+m1/JxZKkJmQlwd8Qqu8Q+Mho
	0r92oyJbjq20OcfvrQnlPulnQL9OhQ1nlqDxj7ITrJkMwCdUR9mN3H+C1cZPfHqsnM11g18CcZD
	qnBXArrBgI9mONvZnQlM/5joKfBIEF1ix0t5Kv03U0/uGv3shIEVaM5hXYic/EWyhrXnXcS7J8O
	QFEJrpH4PE/NxH/NKP9STgWldf4Xq2pXZGM+V4OJsJ2z1vDiBvg9bL0U9ZihkFtVP+h+9pnvNd/
	g=
X-Google-Smtp-Source: AGHT+IFTQfgxCGrhqdxhdussfgDYYkEXHNBEZrXgWgIug9QWcQ3pADFUjI5JaX+cZ8bP6//iw+MOdg==
X-Received: by 2002:a05:6871:4b13:b0:319:625d:319f with SMTP id 586e51a60fabf-34c83b0869bmr247841fac.39.1758579331095;
        Mon, 22 Sep 2025 15:15:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e0fbe706sm8402073fac.0.2025.09.22.15.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:15:30 -0700 (PDT)
Message-ID: <3457c119-2f49-43a3-b96b-736b8f5de99b@baylibre.com>
Date: Mon, 22 Sep 2025 17:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
 <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
 <859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 3:10 PM, Nuno Sá wrote:
> Hi Ariana,
> 
> Thanks for your patches. Some initial comments from me...
> 
> On Mon, 2025-09-22 at 14:30 +0300, Ariana Lazar wrote:

...

>> +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom, 0);
>> +static struct attribute *mcp47feb02_attributes[] = {
>> +	&iio_dev_attr_store_eeprom.dev_attr.attr,
>> +	NULL,
>> +};
>> +
> 
> Not going to argue about the ABI for now but I don't think this is a standard one? So
> if acceptable you need an ABI doc.
> 
Here's a random idea. (I would wait for Jonathan to weigh in first before
assuming it is an acceptable idea though :-p)

The config registers are pretty much going to be a one-time deal. So those
could be written to only if they need it during probe.

For the voltage output registers, we could add extra out_voltageY channels
that are the power-on output state channels. So writing to out_voltageY_raw
wouldn't change any real output but would just be written to EEPROM. This
way these voltages could be controlled independently from the real outputs
and it uses existing ABI.

In any case, it would be interesting to hear more about how this chips are
actually used to better understand this EEPROM feature.


