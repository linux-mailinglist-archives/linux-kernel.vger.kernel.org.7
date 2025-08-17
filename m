Return-Path: <linux-kernel+bounces-772361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49048B291BF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C6D201EBF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A133E2063E7;
	Sun, 17 Aug 2025 06:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9U1k7TM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75917A314;
	Sun, 17 Aug 2025 06:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755410831; cv=none; b=pCsmoaiBfnD0w7d1S0zzWeUTZh1H7tkL1bLT5WI0ZlUK9qNvpEQhiqN1VS0snBuueioXBDkiipQA3NeTzP9bvE8csjbpv6xlLwzs/RLPRQQ4/HiyUiwpSEch2INBQwKeyr2Lhr3nKYMiiXvMx7OqZ/5KKhFynMyakWI5BSRUpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755410831; c=relaxed/simple;
	bh=HGGcLRz+ZraRVFfCLWo4kFMnqmPc26FQI/+/W5TGfkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHOIbfmECNi7aLDyzovQafxx3Zs1iwNT4qu/KHeklr6imrx9wWsyp+HesRSMyxZTODYLs8mipxxDQUnHW5+eIf48R2SgbrZQz+98jY6x8VFfbPSHNfmhCKcQ1Y29wG8XMw4UVH/cD+4NoAkFiTARa8G9e0aoFZDONBul9ubVCvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9U1k7TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00101C4CEEB;
	Sun, 17 Aug 2025 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755410831;
	bh=HGGcLRz+ZraRVFfCLWo4kFMnqmPc26FQI/+/W5TGfkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C9U1k7TMdBHes3n2U3HtU5TgFJ0ido19RMH6bSZZxEcZ7KeIGZcoJwgD+ZTwI9hPY
	 vsBFJQ88y+z5dVDi+XaD3Fj/8ASlVZDTMwS/79Qb274kFMZC4fhC57S4whrI2topvi
	 +afrdqypf8plTk6o7c0jfGK6DQKQmR2ZqyBeW7bxJPiS9oAyaWLeScEnJVYH0IyYLP
	 0AGLUgwFu+Pjvdli51G70bV8CU/wp1yW32WTXYtm+7gUiR+Gjt0eerEqgep6DTPNr/
	 Fqj6SF9n3QwJMyvGXm5hcPPtwGW9pHM3vrHOm0ifwUH9ePErR56zgNhm0Yv/ZATUJL
	 Nna1/W4to/9Cg==
Message-ID: <eb14a865-984c-4288-8139-5650408ebf51@kernel.org>
Date: Sun, 17 Aug 2025 08:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] clock: eswin: Add eic7700 clock driver
To: dongxuyang@eswincomputing.com, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093720.1088-1-dongxuyang@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20250815093720.1088-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 11:37, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> This driver depends on the CCF framework implementation.
>   Based on this driver, other modules in the SoC can use the APIs
>   provided by CCF to perform clock-related operations.

Useless description. Instead describe the hardware and architecture of
your driver. We all know what is the purpose of CCF and how it works.

>   The driver supports eic7700 series chips.

Messed indentation.

> 
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  drivers/clk/Kconfig             |   1 +
>  drivers/clk/Makefile            |   1 +
>  drivers/clk/eswin/Kconfig       |  10 +
>  drivers/clk/eswin/Makefile      |   8 +
>  drivers/clk/eswin/clk-eic7700.c |  44 ++
>  drivers/clk/eswin/clk.c         | 734 ++++++++++++++++++++++++++++++++
>  drivers/clk/eswin/clk.h         |  69 +++
>  7 files changed, 867 insertions(+)
>  create mode 100644 drivers/clk/eswin/Kconfig
>  create mode 100644 drivers/clk/eswin/Makefile
>  create mode 100644 drivers/clk/eswin/clk-eic7700.c
>  create mode 100644 drivers/clk/eswin/clk.c
>  create mode 100644 drivers/clk/eswin/clk.h
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 4d56475f94fc..184b76a406d7 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -505,6 +505,7 @@ source "drivers/clk/actions/Kconfig"
>  source "drivers/clk/analogbits/Kconfig"
>  source "drivers/clk/baikal-t1/Kconfig"
>  source "drivers/clk/bcm/Kconfig"
> +source "drivers/clk/eswin/Kconfig"
>  source "drivers/clk/hisilicon/Kconfig"
>  source "drivers/clk/imgtec/Kconfig"
>  source "drivers/clk/imx/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 18ed29cfdc11..42c61e216511 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -120,6 +120,7 @@ obj-$(CONFIG_CLK_BAIKAL_T1)		+= baikal-t1/
>  obj-y					+= bcm/
>  obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
>  obj-$(CONFIG_ARCH_DAVINCI)		+= davinci/
> +obj-$(CONFIG_ARCH_ESWIN)		+= eswin/
>  obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
>  obj-y					+= imgtec/
>  obj-y					+= imx/
> diff --git a/drivers/clk/eswin/Kconfig b/drivers/clk/eswin/Kconfig
> new file mode 100644
> index 000000000000..f2284c2d790d
> --- /dev/null
> +++ b/drivers/clk/eswin/Kconfig
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config COMMON_CLK_EIC7700
> +	bool "EIC7700 Clock Driver"
> +	depends on ARCH_ESWIN
> +	help
> +	  Build the Eswin EIC7700 SoC clock driver based on the
> +	  common clock framework. This driver provides support
> +	  for the clock control on the Eswin EIC7700 SoC,
> +	  which is essential for managing clock rates and power management.
> diff --git a/drivers/clk/eswin/Makefile b/drivers/clk/eswin/Makefile
> new file mode 100644
> index 000000000000..a3139e34ee22
> --- /dev/null
> +++ b/drivers/clk/eswin/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Eswin Clock specific Makefile
> +#
> +
> +obj-y	+= clk.o
> +
> +obj-$(CONFIG_COMMON_CLK_EIC7700)	+= clk-eic7700.o
> diff --git a/drivers/clk/eswin/clk-eic7700.c b/drivers/clk/eswin/clk-eic7700.c
> new file mode 100644
> index 000000000000..278b256b4c52
> --- /dev/null
> +++ b/drivers/clk/eswin/clk-eic7700.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
> + * All rights reserved.
> + *
> + * ESWIN EIC7700 CLK Provider Driver
> + *
> + * Authors:
> + *	Yifeng Huang <huangyifeng@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>

None of these three are used.

> +#include "clk.h"
> +
> +static void __init eic7700_clk_pll_init(struct device_node *np)
> +{
> +	eswin_clk_pll_register(np);
> +}
> +
> +static void __init eic7700_clk_mux_init(struct device_node *np)
> +{
> +	eswin_clk_mux_register(np);
> +}
> +
> +static void __init eic7700_clk_div_init(struct device_node *np)
> +{
> +	eswin_clk_div_register(np);
> +}
> +
> +static void __init eic7700_clk_gate_init(struct device_node *np)
> +{
> +	eswin_clk_gate_register(np);
> +}
> +
> +CLK_OF_DECLARE(eic7700_clk_pll, "eswin,pll-clock", eic7700_clk_pll_init);
> +CLK_OF_DECLARE(eic7700_clk_mux, "eswin,mux-clock", eic7700_clk_mux_init);
> +CLK_OF_DECLARE(eic7700_clk_div, "eswin,divider-clock", eic7700_clk_div_init);
> +CLK_OF_DECLARE(eic7700_clk_gate, "eswin,gate-clock", eic7700_clk_gate_init);

That's empty wrapper. You created just one more layer of indirection,
with no use at all, instead of calling these directly.

> diff --git a/drivers/clk/eswin/clk.c b/drivers/clk/eswin/clk.c
> new file mode 100644
> index 000000000000..e227cc4664ca
> --- /dev/null
> +++ b/drivers/clk/eswin/clk.c
> @@ -0,0 +1,734 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
> + * All rights reserved.
> + *
> + * Authors:
> + *	Yifeng Huang <huangyifeng@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/math.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/util_macros.h>
> +#include "clk.h"
> +
> +enum pll_clk {
> +	CLK_APLL_FOUT1 = 1,
> +	CLK_PLL_CPU
> +};
> +
> +static enum pll_clk str_to_pll_clk(const char *str)
> +{
> +	if (!strcmp(str, "clk_apll_fout1"))
> +		return CLK_APLL_FOUT1;
> +	else if (!strcmp(str, "clk_pll_cpu"))
> +		return CLK_PLL_CPU;
> +	else
> +		return 0;
> +}
> +
> +static void __iomem *parent_base;

Don't write singletons.

> +
> +static void __init get_parent_base(struct device_node *parent_np)

This is just poor code. Drop.


> +{
> +	if (!parent_base) {
> +		parent_base = of_iomap(parent_np, 0);
> +		if (IS_ERR(parent_base)) {
> +			pr_err("%s: Failed to map registers\n", __func__);
> +			parent_base = NULL;
> +		}
> +	}
> +}
> +


...

> +
> +void __init eswin_clk_gate_register(struct device_node *np)
> +{
> +	struct clk_hw *clk_hw;
> +	struct device_node *parent_np;
> +	const char *clk_name;
> +	const char *parent_name;
> +	u32 idx_bit;
> +	u32 reg;
> +	int ret;
> +
> +	parent_np = of_get_parent(np);
> +	if (!parent_np) {
> +		pr_err("%s: Failed to get parent node\n", __func__);
> +		return;
> +	}
> +
> +	if (of_device_is_compatible(parent_np, "eswin,eic7700-clock"))
> +		get_parent_base(parent_np);
> +	else
> +		return;

What? Don't write drivers like that. All this is completely unnecessary
and confusing code. You don't get a singleton, you don't reference it
from some other init code. It's not needed even! Design this properly so
 other clocks will be instantiated from parent clock driver. Just like
every other clock controller is doing.

> +
> +	if (IS_ERR(parent_base)) {
> +		pr_err("%s: Failed to map registers\n", __func__);

Even more spaghetti code. If you need to check for the value, you check
right after obtaining it.

> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_string(np, "clock-output-names", &clk_name);
> +	if (ret) {
> +		pr_err("%s: Missing clock-output-names\n", __func__);
> +		goto put_node;
> +	}

...

> +
> +#define CLK_FREQ_1800M 1800000000
> +#define CLK_FREQ_1700M 1700000000
> +#define CLK_FREQ_1600M 1600000000
> +#define CLK_FREQ_1500M 1500000000
> +#define CLK_FREQ_1400M 1400000000
> +#define CLK_FREQ_1300M 1300000000
> +#define CLK_FREQ_1200M 1200000000
> +#define CLK_FREQ_1000M 1000000000
> +#define CLK_FREQ_900M 900000000
> +#define CLK_FREQ_800M 800000000
> +#define CLK_FREQ_700M 700000000
> +#define CLK_FREQ_600M 600000000
> +#define CLK_FREQ_500M 500000000
> +#define CLK_FREQ_400M 400000000
> +#define CLK_FREQ_200M 200000000
> +#define CLK_FREQ_100M 100000000
> +#define CLK_FREQ_24M 24000000

Useless defines, just like: #define true 1

> +
> +#define APLL_HIGH_FREQ 983040000
> +#define APLL_LOW_FREQ 225792000
> +
> +struct eswin_clk_pll {
> +	struct clk_hw hw;
> +	void __iomem *ctrl_reg0;
> +	u8 pllen_shift;
> +	u8 pllen_width;
> +	u8 refdiv_shift;
> +	u8 refdiv_width;
> +	u8 fbdiv_shift;
Best regards,
Krzysztof

