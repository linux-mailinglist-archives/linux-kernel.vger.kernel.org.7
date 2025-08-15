Return-Path: <linux-kernel+bounces-771135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713AEB28344
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C50B03D03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7F308F20;
	Fri, 15 Aug 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="royxHDIp"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF7A306D5F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272986; cv=none; b=XSDHWIrC01liMhQmYFhXjJJWWtta0VLU5issdN66kQvr6DEcUdZV72AfnqOejrbbLzQg+nMta9anhdTeBUDW5cdhftULhAffT793fxSEcwLfQ9eT10CnlMig4w4h6mwiLs9lpHbZtkyBsZyiRGCO6xh7rMb2WU8Zx1E+RDyrPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272986; c=relaxed/simple;
	bh=LDT1LlSRvClcQTESyvNZOcCDbQzHYlxIpeUOcGdwEq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hl2GRjsq8JtxQFrxnIE2mxrD0+Sexj4UTxLlWMUwsN87FK9OQHiaQOe2e/Ie77X+sQrUZlIrDzujWx7ss2cFmNyuZlj2/kIdk+Oe0wTTRGCmF45/NeOc61LJWFjHL3M6wuq5DdR3uvBuskNssGpO5Pv9AbN1V+lxZr0+Y7Ze9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=royxHDIp; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381f0664fso594521a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755272982; x=1755877782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYeMUsITLzLzX8aJHEpZBjK6mYQbUKQb8W2QJwQZHWg=;
        b=royxHDIp6fTpPf7/wF2Uis2NIQDsarsmTXle6OaQMmECNcLb0YOEcVASBVQ+i0V0zc
         fx8azFrjCN4BPJ1lWqFrnfqh2NcO4NEsTqF9w7d3pJbuTwXM/msNiSmwGLEy77D1moLs
         bDTEYhfNAgSHvJ9a6LZXFjYcEz2xdaWDJD7l8pyetL5vqh5m+rN8pzWOagnPJ60WnMuU
         fqvqk4FJF/1p/QFfMvW7BArhAaM/M4ff5vMppz4C9dNueUHbDwrGYLpnquJSbqDOaCOX
         zJS8U0mkK14N0OorqAZ1NKwV+dtrLPlTTUNdiNoIvVBxs1pWkw6ahiQhhjbmLv9eD0iM
         btyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272982; x=1755877782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYeMUsITLzLzX8aJHEpZBjK6mYQbUKQb8W2QJwQZHWg=;
        b=hQcDXwRJkp6gfIRv+tumoVyD16x6RR6R3ZE/mS7BQBEUIpjOk14xqJyJdI1A6btcam
         xbTRDYmbgbXt3mBXkYGu5aRL8GCS9fjV1lruVKQ9a8oqu9yUTq0wUKA1xxNW1xfBM+4h
         7auSuNioOjBJNDIzzMcOYnNw2FSnJdol2Sr7w0f3B/eUYSCLYADEF3IF54GYeAWUc9wz
         ktzlf6M8RiU7gD6Qijeq5kbNOHNg4bGyq6VW+xdiFVgFpryWeqRPaIvsr3ylEMSWZt5e
         kUBAoY1n5mvDgYMU1p+1eVoVHg48zOq+bx3D+k+MaXrV8ED7nf1G6k+oxXR1GUxRdEbk
         Fspw==
X-Forwarded-Encrypted: i=1; AJvYcCWwFeqqDi6PwfywUrrRfCaLhkyYd0vTAo848Dn991USCOdEkVgMaz1E4Ed9ytlpLMdRPF1HoqM2JJllw3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+uER4VfV7C+EFUOVdIeSr98xgj/8Nb1+tTqXQVRc8zR2MaYk
	g5Iomi5GbDUf4hnACBW7rUXNGJoUgN/O3RvKXchmxeMry66OrkJDgmTWezuguIcZqBc=
X-Gm-Gg: ASbGncsO6R9OonqZHTJyUa0sHLz4ym2SKYr4qVjWJ9wFL0bpgzD1n8SBz+AsgueY1qP
	L0jjb4D/uG5+7Ax6Gh7f7sziT6stME5NlssyTdyrADXY6aTzA46tttqdYLH/SWjgXU+j1nI9+05
	WMCBHC30cbraVt2MXutaF+P9PzFtO+Qn1pv5rfooZolnNwyH31CIARZeFTXFAYM1p1isWYdzam8
	hssdjkC3lbinZrXSG8fjckq5Kwo3JSNDodWrccpvFu2kUZ4K4912dIjetQG+jevjTbDKiM1x5ge
	l9AhzsNZW2SUwvRDjMSnewWCFoC2z6tc+yMWqDfYOZt4yuBdkYExpHI+1XADsq0MvHJ9vgsJjZN
	vPWdFAYwp7UBeFIQFuDM6UXENHlnmjK0Ca1ci0y6B6N50hKiPonKivt8qBxYt+ORVtu69hXSUzf
	mYRnAfbXk=
X-Google-Smtp-Source: AGHT+IEoVnaL83a5r2gLAMPUw8k6gnxh57UaRSMs78wsysGd8hJtR5B/O1txsAfKqL986GFe82rtXQ==
X-Received: by 2002:a05:6830:4108:b0:742:f996:ef34 with SMTP id 46e09a7af769-743924f533bmr1526978a34.27.1755272981907;
        Fri, 15 Aug 2025 08:49:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203b5ffsm348082a34.25.2025.08.15.08.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:49:41 -0700 (PDT)
Message-ID: <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
Date: Fri, 15 Aug 2025 10:49:40 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 5:00 PM, Sean Anderson wrote:
> From: David Lechner <dlechner@baylibre.com>
> 
> Add a spi-buses property to the spi-peripheral-props binding to allow
> specifying the SPI bus or buses that a peripheral is connected to in
> cases where the SPI controller has more than one physical SPI bus.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - New
> 
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 8fc17e16efb2..cfdb55071a08 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -89,6 +89,16 @@ properties:
>      description:
>        Delay, in microseconds, after a write transfer.
>  
> +  spi-buses:
> +    description:
> +      Array of bus numbers that describes which SPI buses of the controller are
> +      connected to the peripheral. This only applies to peripherals connected
> +      to specialized SPI controllers that have multiple SPI buses on a single
> +      controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1

Finally have some hardware to test this series with using 2 or 4 buses.
I found that we also need an absolute max here to make the bindings checker
happy. 8 seems sensible since I haven't seen more than that on a peripheral.
We can always increase it if we find hardware that requires more buses.

	maxItems: 8



> +    default: [0]
> +
>    stacked-memories:
>      description: Several SPI memories can be wired in stacked mode.
>        This basically means that either a device features several chip


