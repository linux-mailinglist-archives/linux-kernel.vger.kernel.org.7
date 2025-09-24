Return-Path: <linux-kernel+bounces-830890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970ADB9ACCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB953BBAA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B7E30F921;
	Wed, 24 Sep 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wilVXdMV"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5D313E06
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729637; cv=none; b=QyiSUKEAg2tk4IFSX/iRe+2w1vkNUkY6rtP/0uf9x2JZMRHMpolcWK8DwrN5jy52Uw3tgo87scGNw2JngfeQvfqFPy8d4AkYUiI0HMcPGeBh9l+z4XHaTacNZzYw+giyD+mZQdOAHP1hIOzQxZ4gS0wyfCqzePNtjR7n61AmeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729637; c=relaxed/simple;
	bh=EzqOYSDHnxhTVVqSNHLim9jV2AkvqdmMs19BuE0MqXM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1hkOX1+hX8ayb7BwpVBI/p8DphNBNl3xQPhmxZ91bQm8gLqGGJU0kCS0lufI66j92HlPNHlv9l6fAmM0qIIq3dca3HR6B6836TiUSqUea4e8yJq3gTbLsTG28PJzycXp+1vHSJVa5m4GNWmJHZTpGXfYkscVry7AAwtg0MLNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wilVXdMV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so43180495e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758729634; x=1759334434; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIYU8qrKCG63qfESQqAYHq2vCT+r9zxfWJIkv0fUrK4=;
        b=wilVXdMVdq4ZV4sNBQsBkykwQP0JMH/It58wcyGBaXwpx9XY8fQXchSrTwtWk8/+s+
         KTrHiiIJnYm1VjNt1axhI2fBtgSc5GpzdVujVK1xHFidAEdTTLT59USZxnNMrQsZ2x05
         4IjpM5DdOAFwua0Q5eW4QB7UYj1+Mq5E+/VZsDA9hU/v+LO6MfgDXHVY2FC7bL/yEhPf
         Bt3De+nxoE5lCa0n+gown1FqmW291v4XRAzmOfPhyh9hwji0noqx5LcFxJhfaDmOmdb7
         /tmu//IwLeXtl6HxomYv+wbYn5xsvpr86tnm8nIydRdqYwz1bJzzETeJfrr84hv7/wV1
         Thsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729634; x=1759334434;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIYU8qrKCG63qfESQqAYHq2vCT+r9zxfWJIkv0fUrK4=;
        b=WDF/Y5UYJkoRy02mang9lxzO8gQ4/QzFY+WwCf1SVbytk1neJaNkZwdV1t/v1bdHBJ
         s6jYZ4LSINs8lmrtRhjKObuJ9mr2KgQgRn5vQ5qtH5GaMsqzqOIY68lLf3iLt/eH20Cj
         dq008Z7gZKoejzCP3JFBNhKZxx/aIGfiTPd2Mvee1/wDISACh3yRYHviPwtgGOy9EncS
         lPRMR6UGdCBvU8mjV1IVbzg/0qQax24JoyKqJ+yxp+yPYC8QIKD1NZs0LSADpl0UBc1+
         qIV5frwUai6cmYu+Yr/VQvYIt9hhLUiapzl55K6CuH1UzsY+ASxopo3P9IVbcb+3a2l4
         Gjwg==
X-Gm-Message-State: AOJu0YwB/dMgMjciBlJwRY6YsPforE7hdCzuBOyuxBCyxGYKYUBT/Id1
	v8LMh/PA47pESrdqoutC1p77fOvVZhj2mYKqxAAAmhVktfU2ksFSdMS8472CHnMmOaY=
X-Gm-Gg: ASbGnctDN7vrPw/WfPus9TZbAC7TdaD+3b6SUjAFwOxmo2zvEQg7x3s71II6c5XhDr6
	OD27xYQ/OdYm0WpdSaE/K+0j/SkVWypDfO2VTwIU8wsVbseEfAJMyZYjt8e4XqLn3CXpcjb6PjR
	WTsb6RnFc+gfQWexfjwOMZ7CrJBCCW3oAyaVXgWgW6TbSshPVNYR0Xd44GS//7ncvenxsR8NqnS
	uKb7ZiU69Bz9iaDNtoSSAMLRyI0tLiR7O63A7auadQj+y1ZbiSbY53M2fqzNAHW/EIi0WOuHGM1
	+PxpGIkNm+tr4dd0/jCfZeuIhWqsDLjk2ry98ijAnJ2WrooCopLCoYy2lxlXCNWpCjtXI0DNl7c
	+CXg2x980AjBzh6/vUiJoMll8dA==
X-Google-Smtp-Source: AGHT+IEr/xCPYlRIQOGy0m52/J9vkL4EaMZaXgIFMjJ6l8pxzmajhf9oWnQ5HbRALQAcj/6nHTpS4w==
X-Received: by 2002:a05:6000:1a85:b0:406:5e66:ae65 with SMTP id ffacd0b85a97d-40e4d9c9f20mr466144f8f.60.1758729633869;
        Wed, 24 Sep 2025 09:00:33 -0700 (PDT)
Received: from [10.1.1.59] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32bf95f6sm549345e9.2.2025.09.24.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:00:33 -0700 (PDT)
Message-ID: <798600a43825818bcf828da7060f38105f7f3225.camel@linaro.org>
Subject: Re: [PATCH v5 4/5] clk: samsung: add Exynos ACPM clock driver
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin	 <peter.griffin@linaro.org>, Michael
 Turquette <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Catalin Marinas	
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
Date: Wed, 24 Sep 2025 17:00:31 +0100
In-Reply-To: <20250924-acpm-clk-v5-4-4cca1fadd00d@linaro.org>
References: <20250924-acpm-clk-v5-0-4cca1fadd00d@linaro.org>
	 <20250924-acpm-clk-v5-4-4cca1fadd00d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Wed, 2025-09-24 at 15:11 +0000, Tudor Ambarus wrote:
> Add the Exynos ACPM clock driver. It provides support for clocks that
> are controlled by firmware that implements the ACPM interface.

[...]

> diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acp=
m.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9e8354168a63b1427c2f3faf1=
5e4e7955e924dc8
> --- /dev/null
> +++ b/drivers/clk/samsung/clk-acpm.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Samsung Exynos ACPM protocol based clock driver.
> + *
> + * Copyright 2025 Linaro Ltd.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/clk-provider.h>
> +#include <linux/container_of.h>
> +#include <linux/device/devres.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/firmware/samsung/exynos-acpm-protocol.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +struct acpm_clk {
> +	u32 id;
> +	struct clk_hw hw;
> +	unsigned int mbox_chan_id;
> +	const struct acpm_handle *handle;
> +};
> +
> +struct acpm_clk_variant {
> +	const char *name;
> +};
> +
> +struct acpm_clk_driver_data {
> +	const struct acpm_clk_variant *clks;
> +	unsigned int nr_clks;
> +	unsigned int mbox_chan_id;
> +};
> +
> +#define to_acpm_clk(clk) container_of(clk, struct acpm_clk, hw)
> +
> +#define ACPM_CLK(cname)					\
> +	{						\
> +		.name		=3D cname,		\
> +	}
> +
> +static const struct acpm_clk_variant gs101_acpm_clks[] =3D {
> +	ACPM_CLK("mif"),
> +	ACPM_CLK("int"),
> +	ACPM_CLK("cpucl0"),
> +	ACPM_CLK("cpucl1"),
> +	ACPM_CLK("cpucl2"),
> +	ACPM_CLK("g3d"),
> +	ACPM_CLK("g3dl2"),
> +	ACPM_CLK("tpu"),
> +	ACPM_CLK("intcam"),
> +	ACPM_CLK("tnr"),
> +	ACPM_CLK("cam"),
> +	ACPM_CLK("mfc"),
> +	ACPM_CLK("disp"),
> +	ACPM_CLK("b0"),

The last one should be 'bo' (bigocean), not b0.

Cheers,
Andre'

