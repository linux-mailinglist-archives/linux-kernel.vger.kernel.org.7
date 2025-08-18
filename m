Return-Path: <linux-kernel+bounces-773724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB68B2A828
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2211BA3509
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC6321F27;
	Mon, 18 Aug 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BVuujlT3"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AD522AE7A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524736; cv=none; b=SEKzT1mnZ14pTIy7/z+ZnhOzGV8xj8YHrUOV3xuRltZISoDJ3cPOSsQq8IOyFLZYsD1ReZAeQ9x6xbG4SK7d26Y9RQ6yKn3WPMW2On4AUsleZ7VsZN39r5yF9Tp6/V05Lt7A4qQOxbQcWKp7+3KNNkF1U6mja/766sQRqkO3KnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524736; c=relaxed/simple;
	bh=STUgQqWAjMIDSo5i9CNXFPPNs8IXyZkPpT1rTamUjss=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BlxNOhOahTD1iNqV+/S6Czkq7to4jf+jQWg7rokGj6DKZzgt/iHhggG1QK8SeL5Ty6anGGzZUKiCd+6N2nhp9mp3LpSVk3NX7BDRFo/+LqdsIxS3COy7tywdavG2VlUUvPp19abV5gdDWV3osR2vD4NSTOmgTcwmpthUOPiCcrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BVuujlT3; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30cce892b7dso1809022fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755524733; x=1756129533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10gZZQnBGMVk+f8qeUN3o4WqLNCEED7akiLQmYC5IOc=;
        b=BVuujlT3Q63n/8JHdVtF2SjZ2L+RzHDNF6eZkZFWpqET/PmOeG/IzZX8QsL6loycTJ
         71sXQ5lvHqx2sxYv2jg+Ge3lDRW13u1XEAEdEjSrln4t+ZKyXayShFeUW944Ke6l0KEZ
         VfnplEN62blktyihRxTgGOBl2Yj6B0CBIrSZOo2cW1APcqrVoZ2J2sCONp1OfOhlNjBc
         5IKLsvKe3KRIxW28GgpYGXo2DNQrKsvHnOmGW0NFgHcWQeYpSsBb2yCqXsSghU/kssyh
         5oqC+SBhBaYxBRwEHon5kznX665yTcx1HhAkCAtfsXcEHS745J02o+q9rHJMYd+IK6RU
         wsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755524733; x=1756129533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10gZZQnBGMVk+f8qeUN3o4WqLNCEED7akiLQmYC5IOc=;
        b=BOKnGNh6O0zoOak3GF1PXa7OalH7HFAxzHqYhLhb53rOvGu05aZVOl5cWTP9RQhIO5
         UVPCcxj4HmD7+MaMdOAeSPZZWJXVNa4/MIUAyfvQB7sJGaHCq7/2+TNI2mwje9Ej4B74
         NwhyusxsOXgLyOR0F52h92VCt/SVR4gHM5rMiwZdoIOZe9FbGkCdXXnNWjLt8dQubRez
         5ZnfGuOLs3tBXiLT0LfDaI02LDZfyupWvtwW6JMZzEE1W96NhZeITUgCxwhoSR4zmMxU
         nE2k5eFDbYk6Csm1lkNRcQysAnYUchAsvtnToKhyuZo2OkLCSQFaLWLG3+B26UwFJUt2
         5POA==
X-Forwarded-Encrypted: i=1; AJvYcCWLCSsvTomAbkTh16Sjo2VxEpZesLfOu9k6p8pLgMk13tyacKW94UACrvtHem87di4y97R/dxjhWwJsTgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVLXjkq3koi5015lfpypV09Nh56ljLl7FignL8HzbiKco0/op
	O7XebfW1bg47vX3JGIcifcr3jEItEyYXx8BtnskCzFGZ49/gb3UnkAuz/pOwE7IMylObne2sDzb
	3Nqpq
X-Gm-Gg: ASbGncvAQf51FvORMGrq8fErSmjjReKYp5ukL+WM1YrAds1Z3SkpjuXG2hX7Jw4Ei1m
	Nc2t1UKNUrs1u1nyGNue08ytHQGnmXfxvdPcPmIFmB5LR5ZPyRV8iqGYRhUruw6YqklKsQz3du8
	hQBYmS+6q6HxG8rlf/ZjOnz9o7QEb/tmdDdUwsQUM9ZreaQXBB14LtNCDtLYyXPY1Pxydw3h5Jh
	8BRIKMFI+XW7hz+cZN8V9mvjAiBCMYYmw1jFqpAXwnaXu/Ievm27+9QV2i7uA7MJwsX7nu/K5Ud
	kZuUH+WrFv7OZS420Pw/o5U5Uf6dn+Z7ecxEXBOaOFy80rR3bgz1U0mKlbCm8nQqprR6fwSx+Bl
	6AMkWiaYKNpiaTRjNfHbD+8D/DLNFQMzyp8//hy3UvGe/cO9iC/aQj6grZ+aAh1SFMaeJyFnxUw
	c=
X-Google-Smtp-Source: AGHT+IHkEIqXEKYW0YNfPwdn51TV3aOxjzPemzFAD5aoQACwyHFGGzbO2hendQDxiUtyNr97EYzhxA==
X-Received: by 2002:a05:6871:7283:b0:30b:af6d:f92 with SMTP id 586e51a60fabf-310aaf6f1ecmr7757906fac.34.1755524733102;
        Mon, 18 Aug 2025 06:45:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73? ([2600:8803:e7e4:1d00:ee1a:f057:94fa:9a73])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439204e5easm1851721a34.38.2025.08.18.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 06:45:32 -0700 (PDT)
Message-ID: <6c323896-10b9-455a-ae8a-bbe1e2a80e5d@baylibre.com>
Date: Mon, 18 Aug 2025 08:45:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: adc: add IIO backend support
To: Ioana Risteiu <Ioana.Risteiu@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
 <20250818131253.8854-3-Ioana.Risteiu@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250818131253.8854-3-Ioana.Risteiu@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 8:12 AM, Ioana Risteiu wrote:
> Add the generic io-backends property to the AD7779 binding to enable
> support for the IIO backend framework.
> 
> Also add the adi,num-lanes property to set the number of lanes used by
> AD7779.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7779.yaml          | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> index 044f92f39cfa..4a212c8bc9d3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -80,11 +80,27 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  io-backends:
> +    maxItems: 1
> +
> +  adi,num-lanes:
> +    description:
> +      Number of lanes on which the data is sent on the output when the data
> +      output interface is used.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4]
> +    default: 4

Isn't 0 lanes wired up an option? I.e. it is possible to use the
chip in SPI-only mode. So it seems like 0 should be the default.



