Return-Path: <linux-kernel+bounces-840838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9BABB5891
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 713E34E024F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5E255F28;
	Thu,  2 Oct 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRssk/Hh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8011CAF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443259; cv=none; b=dRMReJNbayNK/SOfD77S2IHYyQ+BbcF4VEROm+RaAZqkSXYR91KYDh83tZhFrSOCO4LEagktfvLzU4XSLmf7p1PvVLPHpFyO/2Ho758xMwsg3BVJtcGTqZ92o9O3CwLFUfi7OTJmhcHFoVmFQXNdxcdGjX2A/cNv6P7ITSxBaW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443259; c=relaxed/simple;
	bh=bJqxID90rzeZQW6x4VioAiM9HO5SSBRl9HBk2YS5H4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jep9jkO7NK/MjxtUYwailQlgYgQReNbNrd7hJoAGn+3Wjd+Fls/GPsvCQ8H2Bh5XAebswpJXBwDVeNO6KGlsx3yvRQDqK48V70Igtp5CQiznqq80vZ2VxwmtvqJc7UeNAnaavV1j0gCr0onllhT2rITYiH0mk3qXQowKv7TZ4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRssk/Hh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698e4795ebso14759355ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759443257; x=1760048057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H3afLalH6Ixhx5uorw5x+fuC8TSKfvIs8t48zMbaAbA=;
        b=KRssk/HhYlk35ehaI0gpGlh9LYbeb2RurGBEnSf4DyrH6KZqkDs7PdwhtTiQ2du+eQ
         C4UwFbmMBk7UjEOaxS786ftH0b5GYx9FU1km0nXmfjuXcjs7Gw67WFKsdwDqxXuD3fsF
         FuRY18ILEzo/cYlmwFw34KKKo6buuuhbMm2LsQbW1jXEw/YTza3XsWk3vbssAs/VH1yX
         5/nSXipMMKAoRB0vBs6JcbJHacaYdgx5tb+3KW8LM7uVmdo5qEy0p83Z3l/232YqqkvD
         0WzP4A3GjHNNxBQpcbA8R5orfhwkF3q92akMxSQBSlj6CQQBekFsiCnv85P1oR/BbKKr
         dA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443257; x=1760048057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3afLalH6Ixhx5uorw5x+fuC8TSKfvIs8t48zMbaAbA=;
        b=K88rwSjs7vDCFwpyllEZ19yHvDFpdzFx8CaVvt4P2P50DsMByHUdiu981afXWAnj0F
         gjkojt95JaCGabvy1E2sUs9GiBIZqOUfS2/iidZT9GJ2mRDmZ0RcUSf1XYnOcHw02lVd
         OC34c/MiexwEyDn3RJVZqoso8ivTpTX+aREw58gmj8Ql1Z/DMykiHN8FhZA/4uq0TiqG
         1mlYDmeJ1D4DTdMSRs7PKzheIf2PTVRLVzUrFDcJlEYhqmLrEgj+AGV10llbe27MDBCm
         7oatWlYfijbKprfzer/2v75qbkDkfh7NKDUGzUBQuCvSBHIssvBZ4gGm5H8OPxkISqiG
         B1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DNTUq2A/WMJfvDoODZ/70wc+P6gcoSLfv2r2a6Ma8WAf8tYIZjhNZST1Jy+GerFmDis+h9gJ94RqHsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUa77TgWJqCHQlHXs/EAluqsYSXYigUepBN/z3euyTbmeXshkg
	fUnzaMTaFp/Z8Gd97eKVPjlytkt2JeOPWLUrr8v1CpcmNso/IKNWLP7s
X-Gm-Gg: ASbGncsBUBdPUCBzyd4YGOD74ggvA1aYiYKkCRyyDj2YyWYdck/1asgBPjpoQH76cVZ
	WiSQ/v6Sj9JvbnC4qz0Nk9EOX2fVj0mLv/KCLI52uDeFJCpyNBzHnuENYEqCDIFfj/UZQBdQuaP
	dV91T1qvxNN/1caJFrvXGjVzGJuqSlI18CygBaEAzQYYVcsQ7WQIAS+AOfHFJP0fV8eVsPSamiP
	UKJaDpiwP8SeXa4BLXIqIQkgNaJGN8QgvIZDEXPNbaHKmBGFsFI+ecgdi7vx8drO19WDnoy+rgX
	7qm0V1L9mjFNgKaBTqCxeD8AnGSH1Ggc8cu609QABofBMOMuOCBiLhrAy8GZYl1on71fWdarVpQ
	8UEl51gFlNpA3xKUj7ZKpuw60oBIvNQrLcKHBDu/VhUQY3FCqq6hMMec=
X-Google-Smtp-Source: AGHT+IENBul3bFqweSZ0dwqDKMkxMEi9ojWTa2JsfjOjJH/8VekQN37yrh4kPtbRCy3N115vb7fIgw==
X-Received: by 2002:a17:903:1b4f:b0:28d:18d3:46bd with SMTP id d9443c01a7336-28e9a6be1bbmr9153845ad.43.1759443257422;
        Thu, 02 Oct 2025 15:14:17 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1127a3sm30497785ad.20.2025.10.02.15.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:14:16 -0700 (PDT)
Date: Thu, 2 Oct 2025 19:15:09 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pmbus: add max17616
Message-ID: <aN75bfJINa3nV57Y@debian-BULLSEYE-live-builder-AMD64>
References: <20250930-upstream-max17616-v1-0-1525a85f126c@analog.com>
 <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-upstream-max17616-v1-1-1525a85f126c@analog.com>

Hi Kim,

For completeness, the dt doc could also have the SMBALERT interrupt.
Though, I see the patch has been accepted and I don't want to make upstreaming
take longer than needed. Maybe the comment below can be taken as follow up 
patch suggestion. Though, if you end up doing a v2 for any reason, you can add
my review tag.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

On 09/30, Kim Seer Paller wrote:
> Add device tree documentation for MAX17616/MAX17616A current-limiter
> with overvoltage/surge, undervoltage, reverse polarity, loss of ground
> protection with PMBus interface.
>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../bindings/hwmon/pmbus/adi,max17616.yaml         | 48 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++++
...
> +properties:
> +  compatible:
> +    const: adi,max17616
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply: true

  interrupts:
    description: Fault condition signal provided on SMBALERT pin.
    maxItems: 1

> +
> +required:
> +  - compatible
> +  - reg
> +  - vcc-supply
> +

Best regards,
Marcelo

