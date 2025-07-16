Return-Path: <linux-kernel+bounces-733197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2112B0716B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7FC3B8BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D02BE7DD;
	Wed, 16 Jul 2025 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j1EHC8d+"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50537230997
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657469; cv=none; b=H3fX0DRlPdipAWD7JWimLQcd1WSJSUDKFpzfcObo5SaGbC0Ay7k1f8UaECkmc07XMBiPEYL78yd8Zi1NL1jZCWF80i0UU7ymORFf/XFd2BH2MuCig8cEHUCtvc88ejzDuFjGDFmv7aoRHtA21JJBvdTOL6Au0neikU57PlkdjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657469; c=relaxed/simple;
	bh=p3psaIpWekDleS8qDEO04vSUVnVKKBHCUq3cEc5+TWw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWOkMF7HOqGft3VIDg6pNXFfKDF2ySSnl0kNTZ9RlKfwEDOdR84mjNGo4ALnisX8CWZLl8AUsyreul0lzsh0IbObRnUi7R0plZoo+ahCfkLz0ACbzJDlyBbsNK0Ja158IbpMWCPYV1Zq2aD0eODPaoYWghO+QeYdNBLW9CFbp7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j1EHC8d+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0BFE83F46D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752657457;
	bh=lKJkCknNqquqLUrS/r00x/I5WEOOcl1UCaCBMQgpdJU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=j1EHC8d+rmobtLe1vN5cpjrTShQXI85i0/G7nz4p7KGFxtDDWrddB6jCf2DoWzIjR
	 bPjAYEwswTs6mGY5IoxzOTfQntHk3VANOYljzXLMlXArmL0qoDrJyjFOXfvZjjR0uy
	 SWvF4y37WjG+KdBbL1PF5le7T/A1LCPtOQptsRCHLW2j6qbiNWzZs5xUquX3HrJsYm
	 rSiRR4YNReyAg5JsHt7MGiGcDfXmIl4U5vNMW5t7Ay9/fIqOx8qoh8pJm1tcPIhWw5
	 0qTgUdbsZ8ezBcwAaqfUS0TQYhhJxJFeOKs1xPsIoNhZlChPcRebAUKhsqczcyDOgy
	 Z+y+yRAyeB8dg==
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-886df024fd5so860727241.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752657455; x=1753262255;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKJkCknNqquqLUrS/r00x/I5WEOOcl1UCaCBMQgpdJU=;
        b=u2boz2tVeEvKV5EHRoHI9ZRuGW6afR921kK51NdDGivvWRgaqBdMNx9ICmqTonxZCg
         +oINTByPnVZQXcFztJpQYiwlZXhgRuHUaOzYZ/dNEoSyvOelqEtt/gqzEvm1dFyU1vGp
         LkT+4ab+kb44OVsh8UPl3JYvLjzeORo32CtrKl0Va5BAlON8ke92AThWQPArWSaz5N1L
         XkeGwXcByqzxc7lH6eX4l9Su9g9VOPf8T/q9EwXw0OFCgC1aZ+y6WochEWpX3xgNNsQ5
         6VccGh9UyzSr4Jy5Li1kE1p3r00xlS83Pe4F/UGVx8CRiRJMGhFAwjKes6hvTO6BZiQL
         c5/g==
X-Forwarded-Encrypted: i=1; AJvYcCXVzM171kg09ND3StQMrOoebQhugFKXZbpe5OPB/5HTWPLOHVpsyn6EjwHqlwzGH4mEXWS08rAvLuK6CNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYrpsDnXUPIwbF+JSnChs+QQtNHnmCQF1ecW/IFtaxhMQPZBN
	0DU+lo1ZBiVg/cQQzIF+/BNPieapv7rpCrR4CVefWLG9hK8orv0dptHSSLQwiqce2MSTBb5QcLF
	rNmcyGUAQEur+tI8CAaPEf63f2NWemFLor/KglU3ZnIPWEFj6zEshL4JvoSkZpI9RkPPj1EEwAk
	aO3A6w69eiVe6wUX2idlD994gXSTOtYrGsfkDOmEIzRfBc63b+wiuwF2od
X-Gm-Gg: ASbGncv9DOH9YOfXgYcs5Op1svqi5gDhl4lxwdjneTmrWSEgup3+1RDP/5oDcygp8qC
	+lPYJnWPbWZs88pifV/66sn6/wTcXpRnOa4MYmk/oWiSCWTJmcVEDyfB1Wz52KHH2BHZN5+Ywsl
	R9EuuE5nsvyiG9PqsMuz9WIDYhh+cQQR1abnGFVtwK/vTpum93XTVvtQ==
X-Received: by 2002:a05:6102:3909:b0:4ee:5244:6607 with SMTP id ada2fe7eead31-4f7ecce6f6amr3650959137.11.1752657455257;
        Wed, 16 Jul 2025 02:17:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiavZVdxpFEKHgbgCF35PoW7jjegI2SWdWpd8C3ymcjoql3WT3rxALLt4r4tuR4OhbDAZbKkza9zz3i73RUPE=
X-Received: by 2002:a05:6102:3909:b0:4ee:5244:6607 with SMTP id
 ada2fe7eead31-4f7ecce6f6amr3650944137.11.1752657454900; Wed, 16 Jul 2025
 02:17:34 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 02:17:34 -0700
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 16 Jul 2025 02:17:34 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20250716061940.180231-1-e@freeshell.de>
References: <20250716061940.180231-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 16 Jul 2025 02:17:34 -0700
X-Gm-Features: Ac12FXxB4Yd_B-giOtO9phydLKQkpjDC5FpqIWq0GIfPuitk-kXsg_LMxgUuYUs
Message-ID: <CAJM55Z_77aygReSPJyZMtfZWk_UPYTzYLH5E5uEw6K=GSu0LNQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-milkv-mars sort properties
To: E Shattow <e@freeshell.de>, Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> Improve style with node property order sort of common properties before
> vendor prefixes
>
> Signed-off-by: E Shattow <e@freeshell.de>

Thanks!

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> index 3bd62ab78523..fdaf6b4557da 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -12,9 +12,9 @@ / {
>  };
>
>  &gmac0 {
> -	starfive,tx-use-rgmii-clk;
>  	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>  	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +	starfive,tx-use-rgmii-clk;
>  	status = "okay";
>  };
>
> @@ -31,14 +31,14 @@ &pcie1 {
>  };
>
>  &phy0 {
> -	motorcomm,tx-clk-adj-enabled;
> +	rx-internal-delay-ps = <1500>;
> +	tx-internal-delay-ps = <1500>;
> +	motorcomm,rx-clk-drv-microamp = <3970>;
> +	motorcomm,rx-data-drv-microamp = <2910>;
>  	motorcomm,tx-clk-10-inverted;
>  	motorcomm,tx-clk-100-inverted;
>  	motorcomm,tx-clk-1000-inverted;
> -	motorcomm,rx-clk-drv-microamp = <3970>;
> -	motorcomm,rx-data-drv-microamp = <2910>;
> -	rx-internal-delay-ps = <1500>;
> -	tx-internal-delay-ps = <1500>;
> +	motorcomm,tx-clk-adj-enabled;
>  };
>
>  &pwm {
>
> base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
> --
> 2.50.0
>

