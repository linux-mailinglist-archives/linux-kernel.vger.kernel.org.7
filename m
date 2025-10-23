Return-Path: <linux-kernel+bounces-867125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C7BC01994
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08A3835B151
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9C200BA1;
	Thu, 23 Oct 2025 13:58:50 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9142EC0A7
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227930; cv=none; b=ukbbd/+ZLt41XnKwwec3GacKDOxVkVxxq18l+gKGSPcWd+gWjbctLjcgc1gg6LRFzrKEKNdUHnKBu48GzeC5k1EAfBBO81K7upAho9nMU+3Sw9dKxj8ZK+TaQfdHAUjgMT1g1EbHregCLWaIHEcNrh8LSRNcJdGhSiN+PMFtjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227930; c=relaxed/simple;
	bh=70l9t4VdfE1npK3VaiMwUNG+xoIszb0NPTKI/djYJrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vcg+8MtKh4JGcbrbYFmFaFbqBgjZfxfkMfIl7IYdPNi+Wi283xw0y5eoiiRfniAopb57Rb2ogtRzu/NH+v7SBU+ywDOU5Ub93D0BNn4fCxpDJw4BckEkROHtlJN2u9Xd5nPs4kS2ljgil4Pd5+dBLL82gLvIcg4z448bx9MC7VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5db1aa8c93eso425972137.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227927; x=1761832727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LHznA4IxR0ryi2cJoCEHN+kBwQ2XKkkZXeR8LA/d1QU=;
        b=KT00ND2XwOo7aZifxc8gXtwT/tbOFyzH9mqyMheHaHm6wE4CtZglHHGlIB5qRQy7HV
         dwr/nlwU3t0iyCZmWVVtcCkqdUE1kYrsgYmsr8j8tHVhCkUDysjtJtwggh5vsS5Xi1Yp
         NnxhxhDA4h8kochBmWYkCz8I/hXpI/ecMprTUJfgl7nFoFGOiILM4QvR9qKaN+48y2Cv
         mXtuVbmLlnGDmhOq/1UaEVUpJrsKZCvfWMBntbETUJAQ3LiRn7iVUYQpawDkeBpdrnX4
         QS53C6YP8YrLrnJ5aeNavJsVaJZXO6eFtLZI9dkvrYFvhk/l3n77NxSNqWznqDNY5O4N
         KGKg==
X-Forwarded-Encrypted: i=1; AJvYcCXRT+ckOVCNUYcIbfNObczXhxlqpom1Tmyx2rUsOAMoHoDVSw/oKISaH/kHeGQ4/e4mJCHa0IVVFH3xEXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWExqG/u0VOTVVt5bNgI3hU00lEl96CB9jjNDKdOdDX2ivK8Q
	7ZbLdwWT1xSbHr4z4dqfvXo7sFl9mtol3lkXO6UtdzVo1GZrwD0AGwSruDD3AVGg
X-Gm-Gg: ASbGnctH5UscRoC7m67UYcpyeCntOAJOEpoPbXWU6toX1StxqiXAdekrXBokgML7HAq
	IYTNB/3DHCFqOx61fh7v3Hp6G4pRPIj2OBcCIwjgLtYb+TgeArKxygibLHxcJCzJIQWFAHcxRUK
	i2wWH2FCGVWG8ZfUA13LWNyES/DXOcK72u4ePGs5uCC3gSplbjJ/TcwLto0xRftzvYO/GXa6I6R
	yGEXjICjoh+mDFRkFcwr6qrxulxYY5VIg+43OX5PVaxnvomfuD06f4njiHflRJ2UhrTlB+cIkMx
	CA203GT9qfK4a3yolAM0j6bwrRPOgxo9J8iEB1J5livdP6XrFxKtavpM4lDn7QbuFPBDWMTcCf3
	QyTA+Sr/hz4s+AQX+wv7FLZDhHI4YSFq2rcdNNh/jGoEYc8DNr/vIomqhmKOhErIHVG5By7EXs/
	cGl+ol9T1d0pjpAjbY23agk48uWGdqmeNflzeuXQ==
X-Google-Smtp-Source: AGHT+IHqw1wRprVYzsFDJipmjIMPPymCVaMrYiB43Q+lBlZxNeByMRbFHYy3Pn2djh4r08jeIEsC2Q==
X-Received: by 2002:a05:6102:290e:b0:5a1:ea0:f56d with SMTP id ada2fe7eead31-5d7dd6d937dmr7869785137.32.1761227927027;
        Thu, 23 Oct 2025 06:58:47 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bdbe57c5sm766851e0c.19.2025.10.23.06.58.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:58:46 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5db374c282dso135534137.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:58:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXF5DVw4AzDDpBDkyjaCg+jhGQKjm/gmAzJjmIO8NlgO7DLYPlGZwgBanuTVcKOZS7NTaqARZf2UuVocVc=@vger.kernel.org
X-Received: by 2002:a05:6102:c09:b0:5db:3935:1636 with SMTP id
 ada2fe7eead31-5db393518f0mr253967137.26.1761227926239; Thu, 23 Oct 2025
 06:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com> <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
In-Reply-To: <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 15:58:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-UkzLnrPpBVyMH0DtgubxE_spUYbxtpO+5dmkFFqdcQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl-Wzz5qd5CCY2fSVugSIzDYGwiZQethxZEtHbYBjXjOaCfH3VbWwjwxpU
Message-ID: <CAMuHMdU-UkzLnrPpBVyMH0DtgubxE_spUYbxtpO+5dmkFFqdcQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
To: Peng Fan <peng.fan@nxp.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Sebin Francis <sebin.francis@ti.com>, Brian Masney <bmasney@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Peng,

On Thu, 9 Oct 2025 at 05:49, Peng Fan <peng.fan@nxp.com> wrote:
>  - Introduce 'clk-scmi-oem.c' to support vendor-specific OEM extensions
>    for the SCMI clock driver, allows clean integration of vendor-specific
>    features without impacting the core SCMI clock driver logic.
>  - Extend 'clk-scmi.h' with 'scmi_clk_oem' structure and related declarations.
>  - Initialize OEM extensions via 'scmi_clk_oem_init()'.
>  - Support querying OEM-specific features and setting spread spectrum.
>  - Pass 'scmi_device' to 'scmi_clk_ops_select()' for OEM data access.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/clk/clk-scmi-oem.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The Vendor OEM extension for System Control and Power Interface (SCMI)
> + * Protocol based clock driver
> + *
> + * Copyright 2025 NXP
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/scmi_imx_protocol.h>
> +#include <linux/scmi_protocol.h>
> +
> +#include "clk-scmi.h"
> +
> +#define SCMI_CLOCK_CFG_IMX_SSC                 0x80
> +#define SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK      GENMASK(7, 0)
> +#define SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK                GENMASK(23, 8)
> +#define SCMI_CLOCK_IMX_SS_ENABLE_MASK          BIT(24)
> +
> +struct scmi_clk_oem_info {
> +       char *vendor_id;
> +       char *sub_vendor_id;
> +       char *compatible;
> +       const void *data;
> +};
> +
> +static int
> +scmi_clk_imx_set_spread_spectrum(struct clk_hw *hw,
> +                                const struct clk_spread_spectrum *ss_conf)
> +{
> +       struct scmi_clk *clk = to_scmi_clk(hw);
> +       int ret;
> +       u32 val;
> +
> +       /*
> +        * extConfigValue[7:0]   - spread percentage (%)
> +        * extConfigValue[23:8]  - Modulation Frequency

What is the unit of this?
According to the code below, it is in Hz, so it is limited to 65535 Hz.

> +        * extConfigValue[24]    - Enable/Disable
> +        * extConfigValue[31:25] - Reserved

Center, up, down, could be stored here, I assume?

> +        */
> +       val = FIELD_PREP(SCMI_CLOCK_IMX_SS_PERCENTAGE_MASK, ss_conf->spread_bp / 10000);
> +       val |= FIELD_PREP(SCMI_CLOCK_IMX_SS_MOD_FREQ_MASK, ss_conf->modfreq_hz);
> +       if (ss_conf->method != CLK_SPREAD_NO)
> +               val |= SCMI_CLOCK_IMX_SS_ENABLE_MASK;
> +       ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
> +                                                SCMI_CLOCK_CFG_IMX_SSC,
> +                                                val, false);
> +       if (ret)
> +               dev_warn(clk->dev,
> +                        "Failed to set spread spectrum(%u,%u,%u) for clock ID %d\n",
> +                        ss_conf->modfreq_hz, ss_conf->spread_bp, ss_conf->method,
> +                        clk->id);
> +
> +       return ret;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

