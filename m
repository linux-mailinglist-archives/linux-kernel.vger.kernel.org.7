Return-Path: <linux-kernel+bounces-823519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025BCB86B71
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24CA3AA9C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C1C2D8DDD;
	Thu, 18 Sep 2025 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UpPMRvqf"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1362D239F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224346; cv=none; b=C2YwsHGS5cBmlf5lbXqbKlsS9CkD/hDsP3c16vfRyt/5C45+EIQAskJI95UJL0RCs0OvGVZ3Cr35P2BjvEFa35MhcknrHfyU4pSdrck1klAajPrqG0ZPcrYDHSpc1vCw0Mg+MRBQ0oktR7kAhelGGDD5jkO/e1t4b1bClnPAVq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224346; c=relaxed/simple;
	bh=VQ3t8/qxZa8M7ApZdBgI92YVOKX5tQcpsXI5KcrvT5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6FEYThTYh/c4GZYPOFGqI9QY42v8gk3y1gYJ5sgRPPzUl+Icuh7zll/vIceqWe5Ro2HXmMSG0HukZYACQBLdJIj38ry/+dZs+5LDVGRFzCOJzBmhzER82pf/ronhONRrmrPJk6o4emX3VQQK7Y37Bz7ncVObmHskwl1gly2zsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UpPMRvqf; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-62347d880feso844016eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758224343; x=1758829143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC1D1RXpqGWlfeokss9Ec91Msfh5uPWlxYgo1Th1KKE=;
        b=UpPMRvqfOgPqzydGEl7JaO4hSSi6dZcUjUkHSSoIz0DfqyvkvF9j/JsdUOSOYTuWhl
         o4jfmM7W5OJJ6zHMOS966ArVDhX66r3qIhCNyNAj/V5S/+eRnEUl4k/slQRRKch3DgS9
         1YXJQznDKqO0M3OQmVewpS7qGTYoAp4N50yo7l1yNvEz5eFrGGs5OHZCc9Lo+O1wNXLq
         SiE03ZfxmRahrzrVmBUYgrc1bMe2B6N/vEv1O/lZqi11l3GtvwdeXe8HMks8gQtDDZ5X
         YBAXo4JzP/OQgVSRtlPYASsrot/bGx966NlHvOMADKz4IdAl0D46ACEB4aAzub+njKCm
         2dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224343; x=1758829143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC1D1RXpqGWlfeokss9Ec91Msfh5uPWlxYgo1Th1KKE=;
        b=Qap8YZWEhzHNG5ia0GGsfZUgDO/nSkWXizwWTLWuorlLxpi66QywrsX9+V8u0JAAHr
         LeQzreAjuS/YGlPfDS0etKhog6hJTl5LlMTo+FC14rPI/E2OfCahpEtMZ0A0EzJVafy7
         GMkhTLd8V3FtIsnYPh9no5czbc3L8y7pMajb7AhRBhniDvA6HF4beg/dHVwz1xHC0ChJ
         VoIdF1VOrcOssufYqO31g41ybYHjWINl1GaOV67vqiHyDhF/dNO1OYr8xf4c8dHRUCgi
         FqDx5dO6wJcNV1J3XO6WlJndi1Vq/wDBcPWiH6Dfh8yuZE4u/seVI1MgV0WzqZx43zUo
         weJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPlek2pmsOZns0AFub46L2djGN5rypGt/m5HJFWAORekSmcs8bFREQhjpXPZ6MonzCtY0Izz6eHlrdFEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnr9WaVk4V0ih1sc6bcZ/Sa0luvpgYSEEkxXCbINMImX2ctYWw
	cUuYtqHSA8NaXZwxSflFxmgdCrgSCmzJlsmObx0M9zaHGfUDsYCcjeh0rYOnVJD6XAY=
X-Gm-Gg: ASbGncv5GENhX0P71ty+vduAG0Hr/lpJNANW1ubQnz0GftQgNZDlliKhjcB1X9Kwi2L
	4vf0CtguYacesbqZip1Ww4IY2U2fHuNAD9RIuDjpwVWgHuXHWF+smUZZulAAeKVLjPb0vXg/MkD
	tk7Haa65CWuHMrvL5vLNH9FB5c4va78Zg4koyn86PIBtiwz6oDeO4u4xofxvhVcnj0C1Le0hih4
	emB0WsBIRCbuQ0PBxWVKPjVVe8nuaUPHd2blb3N9siwXEOFklLu7xsS39sePgQ3s8ggi9JRERQN
	dThgDsCMd3OK9jTbCzPaHJ2xz8k9Hd8oNIMAq91y5EqE87QLAeq1/TghaqHBwDFfirzAdNE76ss
	bH8Htpd0ci+BfkmfTuQEHJDQUUJbRHznnIniBeo+jp9+s+aqtGqJSsrSmhBPZFPlu6hMwQg2TRh
	Ay8iOp9OhfKtfdjz7oqg==
X-Google-Smtp-Source: AGHT+IGwPYMqQBvoGrbWLKmtCrh7hU1R/7J5LL0cXcvqHKYJ/id7TQ+ISZN+tixS6oxGOqJOrN22sQ==
X-Received: by 2002:a05:6808:198f:b0:438:bdb0:89b7 with SMTP id 5614622812f47-43d6c2c68eemr244526b6e.49.1758224343041;
        Thu, 18 Sep 2025 12:39:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c881af7sm1142955b6e.29.2025.09.18.12.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:39:02 -0700 (PDT)
Message-ID: <f7d7f400-cc43-41d9-bc97-39d308363f14@baylibre.com>
Date: Thu, 18 Sep 2025 14:39:01 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference
 spi-peripheral-props
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> AD4030 and similar devices all connect to the system as SPI peripherals.
> Reference spi-peripheral-props so common SPI peripheral can be used from
> ad4030 dt-binding.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 54e7349317b7..a8fee4062d0e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -20,6 +20,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
>  
> +$ref: /schemas/spi/spi-peripheral-props.yaml#

I think this is already referenced for all child nodes of a SPI
controller because of pattern matching of:

patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    $ref: spi-peripheral-props.yaml

in Documentation/devicetree/bindings/spi/spi-controller.yaml

So perhaps not strictly necessary?

Would be curious to know if there is some difference.

> +
>  properties:
>    compatible:
>      enum:


