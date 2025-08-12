Return-Path: <linux-kernel+bounces-764482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91BB2239E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91ED21B615A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643692DCF5F;
	Tue, 12 Aug 2025 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2iWcETs"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE74280308;
	Tue, 12 Aug 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991974; cv=none; b=jD/CC+WpHB8qKOfbnBB9GJnu+S8Wg0IOq4KTAh3UWzdZWpNemEqElK+VqJ6wblUBp3NWRnpJVTdTS/Axqe30x1aqJFhsagk80yOBOEwta1w9Q6uk6r8yvlKwLkgylYQTHQupAvvjHGa5qbe4uq9TMt9MhqobPcHVAXWsnvqDddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991974; c=relaxed/simple;
	bh=a5W3LIIPs2omyjBIaORiELNf8Ee9yWsPoM3uxHAjEMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4t0ujWykTmDKi6NMeX5+QCq+E2Q4bM2sWAOCYoNUV99WwGcIYCFRSi9aP80qgoCX0eJTlcrCL7YxgoWsUKo2F415u19KIDxLzwfgz1pp/7bS6/2UN6MfMcMaN3SJKqHh36QvKGmFEOf3OGfcnimfV2ajg7Zju2yBZGnpS+os4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2iWcETs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6182b3218aeso3501358a12.2;
        Tue, 12 Aug 2025 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754991971; x=1755596771; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fjVIKjeUwxPFaZApTw5n61+HZBIH65P3mIOsayr0+Vc=;
        b=h2iWcETsIJr1EVoap5Uof1EL7pmQ6GG5G/ek/yGsg27WYPzGxWlBNwqofVJuxGVWoG
         9J0q7NTJJ6frSB2R+XFbqav3VK+TKJhRcVySRoT2koRMhRH9U2af8f58hj3t3Km74pXD
         X8QP4DJpWo2SrfSzIAxvQLHr6K6tP8UN6c5TdowoGsegl7+de9HYiiznnFmdtwNmv8RC
         NFSUhd146jmFoylImt2PZ9cn8FTYtsfSxNysIcJw2GPa/3SxNZwCznIpDj1Dymkj8oGU
         0ThQC3Sh8zjbj7QgiU1ONuLBuYQDryHN1QHXzPFRE27iS/G++pP8gLS8I8K3LJr3XWW/
         boWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754991971; x=1755596771;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjVIKjeUwxPFaZApTw5n61+HZBIH65P3mIOsayr0+Vc=;
        b=V8Bnhc9PjVlkwo5uAfQIJRw8RVjyKO4PFbLjL4KNMeyLqqE5m/LRXWh9JGfK7qHcag
         DckOdV4TPoDiIvwQkbLmzz9vO81s0P40cqO0y37ESq01onPO1+kTP4mGCK90vrf9QyRO
         cWB+OmNLBmFjipBz0xU/owOeHcRSGbHksIpHt+8pMPjBswXlbNXeQ+E7BlWe67wHjduF
         LUx7HEx/EKqn+pyGF8gaJp3+6ZV49OFCSWtMEf9/99xFSX+G3L5ZPR1DripAwXmWpjj4
         JN1Gh/Ld0wDLA2W+uFg1U4u+UP5GAkWwJ5edzjFbU3Ws73dncp8vQjOet4sfDNWyjueJ
         XV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf3Z5JonGoDS3RYrKt2K+Fve3KMYLQUatiimTXArbo+j7dZgzQRPW5Q8Kha/njfdZeIDMLIu4lXfTD96bh@vger.kernel.org, AJvYcCWZJBgn1DJMON8IFz6iRnnkKkk8OXp4UNZvV3h78RiJppcMubtqmBkAPIBfSJFwdu9taV4lpGG66FCW@vger.kernel.org, AJvYcCXfB9xMtkxQdPYJyPezrmEoYGh4ThcM57ZvowM/t0+hd4vsUMxnka/4ZSF3eX0j0HmPP6Em0uLfwd/f@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGlgIBDfTngqUjEt2gkWzdGzEPpk8pBl+/LIEFIAkhUutYZCJ
	6/YMfTj+uhvhTgm4Akztvlpxinkk9qkU6xaQPwc9+Nq/7AvLX9tDDVnQ
X-Gm-Gg: ASbGncvbEwpGv/I9zpNqRnxHtQUQo9LtQU35ZEF/NL1IDD5Ix+44ahJrgZAKHNIeMIr
	XhJ91msD3rruw43BofX7jqCn6H5cJjtueK60F4HMYWJU+LLejMchtaOkVIhIPd/uOMG9gDFLrCH
	fcuw8j7NL+8xu7La4dyE2j0eW3ByJPzvDdEp0y4AnNmTAl1qRb35oBa0f6PZeJop2x6PPmi0RZQ
	GFnPFwQQ8pOj6Grijc+TKwBs9i9QJvg1rJEYQgWcKkyQBHkI7PHXjEnN4y/6YKs9rKvw3FYbt2H
	wkXtlkcdYxMZRnX0U7nxJhtlaCRA+bTTE80sH3rPCzZhI/0qXHDr3i5T8RkuZneP3XnHySjcvTy
	mQdiY/+7XJiyKNhU=
X-Google-Smtp-Source: AGHT+IESCpxt101/vHoMm8x2v74Z4a4fzMUqHfeuz0IzBLGBuBbFHZ9DNlZ5ZtTnOo38czseJxE1kg==
X-Received: by 2002:a05:6402:5246:b0:615:7fdf:9c4f with SMTP id 4fb4d7f45d1cf-6184ec90659mr1956866a12.24.1754991971059;
        Tue, 12 Aug 2025 02:46:11 -0700 (PDT)
Received: from nsa ([193.187.128.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6181ad55ebasm4716471a12.55.2025.08.12.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:46:10 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:46:28 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: add
 clock-output-names property
Message-ID: <oploom26lwx7hhrdauxoe7hgjf4ccfrnqrnh5pd3juqxh44d5q@rpiiooqkztxw>
References: <20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-v1-1-f02727736aa7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-v1-1-f02727736aa7@baylibre.com>

On Mon, Aug 11, 2025 at 05:17:01PM -0500, David Lechner wrote:
> Add an optional `clock-output-names` property to the ADI AXI Clock
> Generator binding. This is already being used in the Linux driver and
> real-world dtbs, so we should document it to allow for correct binding
> validation.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> index 2b2041818a0a44456ee986fe29d32346f68835f3..6eea1a41150a7c90153cffcfb5b4862c243b4e0f 100644
> --- a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> +++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> @@ -42,6 +42,9 @@ properties:
>            - const: clkin2
>            - const: s_axi_aclk
>  
> +  clock-output-names:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 0
>  
> @@ -65,4 +68,5 @@ examples:
>        reg = <0xff000000 0x1000>;
>        clocks = <&osc 1>, <&clkc 15>;
>        clock-names = "clkin1", "s_axi_aclk";
> +      clock-output-names = "spi_sclk";
>      };
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250811-dt-bindings-clk-axi-clkgen-add-clock-output-names-property-f413c3ef8bf4
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

