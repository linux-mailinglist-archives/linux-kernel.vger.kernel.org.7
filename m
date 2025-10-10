Return-Path: <linux-kernel+bounces-848605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FEFBCE25B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4605919A2EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32D8223DDF;
	Fri, 10 Oct 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ssqrLHYn"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557B21883E
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118576; cv=none; b=Bxe2YfEA1Ff+5l6EASjLcL7Ni46+2JnGN3Y/RkLFce7+0NN/O5Vzrkvml54WHinhmGPQqTB7We5DZGVb2dEWYnMDBCqx61b7NqnBuWHFcRYwZm1BsIQ2ADMfYGb4dFuQ3g4jh9chh5jvmcC6CLGjyiVePQduGqvsAD/OxfYfD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118576; c=relaxed/simple;
	bh=SydbU5kjGr/3xovWC/nOqIpKErTuWjsdiYfkq7oCez4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKQWCJcNMnhsGdBDiVSfCT2TBu3ci8mr5FK9Zhr551nu2n5A2MICAQfUKblLIJplBpDyPl2UUvw723o/Z4IJ8Uadijw5jxTS3dBJmccB94S2gt9gHMn/B51/BR/HHlkfdd31xCSm9zoohiDBjIuYzZTNXDW41c6RXF2qZPhT+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ssqrLHYn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7a76561c291so1550613a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760118573; x=1760723373; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMaVmGxlRalQkaTOQI033Tgz8Btw2Xvfuv/0peF4wpw=;
        b=ssqrLHYnuuvLGSpgWS86+c6ov4l3etjXuVOpyUd8Siq5HHJH+dx3t6uN2GWIoB71VB
         esh+r7GNzRl76ObTVGR4ZO0jBzb+dYTt2Y42d0gSKVQ7owCRWlYucFLxgSR1JT7fSWKI
         fAv7/OPwL478PVke5I9k0vHyMRcR0ErZkPT8LSk8uXKqXGdUiZtyY/dHfjw2RHv6be9Q
         CHhiQJqj7PBsdJxXUNBTVli/trPM4ErA1vOHPNBlOlRRqQiHVYGOTPgluieByzDR814L
         lp+LudV9LqfESbP/eCK4OOYe/FPD2FqGptaSkp2jRlArJFbAnx+aC61D6HYJoygYE3Mh
         8WEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118573; x=1760723373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMaVmGxlRalQkaTOQI033Tgz8Btw2Xvfuv/0peF4wpw=;
        b=ZgN69o9pV2PXOHSJm5j+FBIa81WDKpENWPdWh3EO14Z5XRBZVqkjtvqTyN0Uo1J5U9
         amyi04C40gjy+IKgQ+uE3v65v+UxvLl/z9nYhKu1iEkVafkdqYKtT003FLIyQUAe0bI+
         329w16t8VNfAeM/xetyWS2H2M4xONkMZsVduuEIqdG6uCYb2XbLX3JraWdBQNN22f9Za
         aAzEsS+jFiDaF0ZHIdRr6oaQmA1zmT6qPiRCK3wQ9qvirxUwZjZ6R/DHir6Qd2ToZxhs
         b7vnxIGiDvBPeXa29imJSwUaIAONIhkJ150McM6Dd4gzCzNjTYuo+Ix6q1Ycow8+hDyi
         K0zA==
X-Forwarded-Encrypted: i=1; AJvYcCXKPGunPb2Cd44+d28t26AxTQNa18EtO4Ux+cfe9HbWM4g49KdoGlz5hK2173DmhkZz7MKWoUP1HBj2/MU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8J8JBoN79jWAjPbyHhl0GUaM7j841ynlM46O/mI46lNDcV7Pp
	8WV3tzeQ6lqX6wp3ka60CAaJBozYIspkdSVqJ/NAFFY4TvKeLlG154KBg4QpVomaovY=
X-Gm-Gg: ASbGncv3ZBhFVnh0eGdnXlQprJMZMm1KM0bjiGGAAKD0mSNJjbhZhMxMFmClGRE7COI
	RReKpvCx+oN9P/RySYLtAmm31d2Q4AEf33aXXWKVd04h/HHvWwpLbTy8ZdtbsI8jB9Wkt3AMxBn
	N/g6F9YiaWaim9tyWjmoJQYEFnV2wIHIkwZL8NHwJDvztee3XLm/9cSTAw1OUPX4HN3m8+bObYw
	jawgbpQsnATuIwcVOsQIIwUJlfI+/igc2edxULiLzh4zUWUBTPO4r8X2rI5zviDzLvMbNIJvixQ
	AaDKHpoGTgrF/cy1uvXJy0lQRUX+ooyaGgrxXPKyNg+eGG5+J8Wgp5i/sU/BaWAeURO1SC9eaTp
	LFgi5QhLneoYHr8LDS45I9XX+H7O982/UNBmOIbrS7NNf13F2AdmajPbw/0Qs4YW9VJ2DC7CNA8
	zbbdcOqyWJBl6e+QY=
X-Google-Smtp-Source: AGHT+IGFvMx8K8r1w2LJGI0aj1BdaxgMV07DhEGKjg2wLJeOFKBXNf333S18rFWDt7E0konUyv4QMg==
X-Received: by 2002:a05:6830:620d:b0:79e:f086:3aca with SMTP id 46e09a7af769-7c0df62378fmr7546589a34.10.1760118572753;
        Fri, 10 Oct 2025 10:49:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f9067887sm1027295a34.9.2025.10.10.10.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 10:49:32 -0700 (PDT)
Message-ID: <fce1c905-1c64-47b5-91b1-0017809ec12c@baylibre.com>
Date: Fri, 10 Oct 2025 12:49:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width
 property
To: Shrikant Raskar <raskar.shree97@gmail.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
 <20251008031737.7321-2-raskar.shree97@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251008031737.7321-2-raskar.shree97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/25 10:17 PM, Shrikant Raskar wrote:
> The appropriate LED pulse width for the MAX30100 depends on
> board-specific optical and mechanical design (lens, enclosure,
> LED-to-sensor distance) and the trade-off between measurement
> resolution and power consumption. Encoding it in Device Tree
> documents these platform choices and ensures consistent behavior.
> 
> Tested on: Raspberry Pi 3B + MAX30100 breakout board.
> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> Changes since v1:
> Add unit suffix.
> Drop redundant description.
> 
> Link to v1:
> https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.com/
> ---
>  .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> index 967778fb0ce8..5c651a0151cc 100644
> --- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> +++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
> @@ -27,6 +27,11 @@ properties:
>        LED current whilst the engine is running. First indexed value is
>        the configuration for the RED LED, and second value is for the IR LED.
>  
> +  maxim,pulse-width-us:
> +    maxItems: 1
> +    description: Pulse width in microseconds

Would be nice to add to the description which pulse width this is referring to.

> +    enum: [200, 400, 800, 1600]

Properties with standard unit suffixes are u32 arrays, so I think this
would fix the error and also make maxItems not necessary.

       items:
         - enum: [200, 400, 800, 1600]

And we want to know what the default is if this property is omitted.

        default: 1600

> +
>  additionalProperties: false
>  
>  required:
> @@ -44,6 +49,7 @@ examples:
>              compatible = "maxim,max30100";
>              reg = <0x57>;
>              maxim,led-current-microamp = <24000 50000>;
> +            maxim,pulse-width-us = <1600>;
>              interrupt-parent = <&gpio1>;
>              interrupts = <16 2>;
>          };


