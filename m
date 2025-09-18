Return-Path: <linux-kernel+bounces-774859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EDFB2B86D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13B2527E26
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9430F54B;
	Tue, 19 Aug 2025 04:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="BYAzsV/s"
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C66B3597A;
	Tue, 19 Aug 2025 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755578925; cv=none; b=eZTyfuJAiiilkDs+za0doOXGsHkCy+XOZhRh+TYSE9wU4nn+DYEQlXHN5MFuRTFsy+8WN8SOjas0hFPg9Olraqb6BuZxm02e68FSQVoKfGc8z/HEtyIFEEEgJt+k2tRmdEna6fQgFoqEsNgN/kiJbYyA1k0i6TVVcHWcCoh+QIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755578925; c=relaxed/simple;
	bh=xCmAXL2+pMYSrseAdCWaGKIlpDJ0NWVjvePc9jL5mu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QastUxaIn0mqw+uqKe1PxM2CXGNIbYHNrk/WMmn85pQRwzFvCDmZTOoRkTpym0X+9kETmUDrrKsQSEK+ftiBczDlvTqVRl2qZbKYOMco774lLp5lActpuG/BL3s0cpJcx1yQ14yG4LhvwFL/CZpyJKvj+UWWFKe31LgFoyF6pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=BYAzsV/s; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755578783;
	bh=bak+yprjBO8cdRBgyq8nNZBhbv9cF1GX7OaLxBhBfEc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=BYAzsV/sg9M/p6OpctHQu3TP01Ngj8a2mrN+ZD8PFqak/DbVlp1ucvJ9GENtL0XM6
	 pC4cMcs1mwTz0f3sIFWhLY+pkoQmzQmSHGkfcCiJKJWm8ln5nJj/0yDs4SSeMokx4Y
	 2/VJw3t/Pa+IyxyXdJwXkxujnRNwKPITqaeCP+ek=
X-QQ-mid: zesmtpsz5t1755578777teac74b3b
X-QQ-Originating-IP: kcGfAUX1LRO/9y89+f4P059KQWMSfYRmV0uMo+WzLN4=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 12:46:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17483429776780194175
EX-QQ-RecipientCnt: 19
Date: Tue, 19 Aug 2025 12:46:15 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: dongxuyang@eswincomputing.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v4 2/3] clock: eswin: Add eic7700 clock driver
Message-ID: <4062F0ACD5F73215+aKQBl3LMPkTacr9O@LT-Guozexi>
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093720.1088-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815093720.1088-1-dongxuyang@eswincomputing.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N4ZILu3POr3OawCtvtxQPOiahSiDS8IwV//aueIuSaPZeMa+HSVeJPcL
	BBFb6VPNu/6uRRUAL6PRr7SeJVI9h9iIglgmdoIM11LH7Ak3vDQSGuKSeyccvdYhulO69Z0
	7F2XkTqAg1NMrb8k4mmnaOjXsnWa1isC+mJnYcj+4+MRnPbHmCeO0e2Ty0oehXYcueuNR7w
	H950ltiEpik1A0+93MGvDonM/D3OuN0fhSQLkeZIsChDvrPkkEmEBSpHF9wkSJWH0mEUEfQ
	j3AeeHWyxsn+CDRS6GpZ147acbIDDRcy6nVKciMEsnCsesGkoU0omTfo8arM23IXt0Kjo3Z
	xsplAEJx8qz5zuEc81WYQgiGCzk3Sl7P9ZpcH08QtABGFYk1gQtr/Gs68jPgfyIxqlM/Z3z
	U6nowX9MuDok+CLV5G9aMlroquCBEj0n0/jW6Xl8ZZB+dU65Q2fDuCowyGWN6Ei1Trf8FZs
	80aKXj5U6zZIv8GyGaDbIgMQHykQpgCANTRHfgkbYw4LvoNoUxbZ6EPEJ/wOybUdhPGiWHX
	/ywNrwgH8c6mckzNHnfRei8Wx5OgoGc0IWrPdZDR6rlD9qHhCLhGDTjPWw08zcQ4uke0JnP
	/8c0D3WxqLL9xG9I0jcakjFB7LatgKA8ZTXI9x5kBbemoeRYwEzV60k2D1WV/xTVkChzD3S
	u4aRR8HyDimXXpOb0BqhCJOeZF86jDiNDeeKzTDgCCYewwxWHHdQW89OzZnUF+t4uQwlhBI
	HiJzKeoMXYNKXmLpYAfyX90pS0kxcGTxlfQuQnwNmWakAHi9VgiVHIAA9sNTAsfM9vRkaVC
	zxkdSzy+nCOHjAfCX/GF4oJoTFRbjuyMk9Dmk3pAsQt5wXnv6/GwxaneNYDFJL95kzXuk/f
	3WXn7gFM7FvgYcwCje5bcQtJNXeblkNGvSsmcw4ZkadS6jtGdG89NZUNia0pwXUFBLW2YjU
	YnHjgZhlkO+rHJM/YCoUYcxCxeOWSrd1JLd41zsWFv1P+eWLZeDRedLijXmghLQj1x6Frp6
	8wP1AepSuhewZcx6RRuA2Lv5wHVnc3ZtFKORtVuscMazCqeX4/KX013DveUIJoAFmTxqnNr
	w==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 05:37:20PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> This driver depends on the CCF framework implementation.
>   Based on this driver, other modules in the SoC can use the APIs
>   provided by CCF to perform clock-related operations.
>   The driver supports eic7700 series chips.
Please align and modify according to Krzysztof's suggestion.

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
also COMPILE_TEST here.

> +	help
> +	  Build the Eswin EIC7700 SoC clock driver based on the
> +	  common clock framework. This driver provides support
> +	  for the clock control on the Eswin EIC7700 SoC,
no need to mention CCF.

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
Should we always compile this?

                - Troy

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
> +
> +static void __init get_parent_base(struct device_node *parent_np)
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
> +/**
> + * eswin_calc_pll - calculate PLL values
> + * @frac_val: fractional divider
> + * @fbdiv_val: feedback divider
> + * @rate: reference rate
> + *
> + *   Calculate PLL values for frac and fbdiv
> + */
> +static void eswin_calc_pll(u32 *frac_val, u32 *fbdiv_val, u64 rate)
> +{
> +	u32 rem, tmp1, tmp2;
> +
> +	rate = rate * 4;
> +	rem = do_div(rate, 1000);
> +	if (rem)
> +		tmp1 = rem;
> +
> +	rem = do_div(rate, 1000);
> +	if (rem)
> +		tmp2 = rem;
> +
> +	rem = do_div(rate, 24);
> +	/* fbdiv = rate * 4 / 24000000 */
> +	*fbdiv_val = rate;
> +	/* frac = rate * 4 % 24000000 * (2 ^ 24) */
> +	*frac_val = ((1000 * (1000 * rem + tmp2) + tmp1) << 21) / 3 / 1000000;
> +}
> +
> +static inline struct eswin_clk_pll *to_pll_clk(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct eswin_clk_pll, hw);
> +}
> +
> +static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct eswin_clk_pll *clk = to_pll_clk(hw);
> +	const char *clk_name = clk_hw_get_name(&clk->hw);
> +
> +	if (!clk_name)
> +		return -ENOMEM;
> +
> +	u32 frac_val = 0, fbdiv_val, refdiv_val = 1, postdiv1_val = 0;
> +	u32 val;
> +	int ret;
> +	struct clk *clk_cpu_mux = NULL;
> +	struct clk *clk_cpu_lp_pll = NULL;
> +	struct clk *clk_cpu_pll = NULL;
> +	int try_count = 0;
> +	bool lock_flag = false;
> +
> +	eswin_calc_pll(&frac_val, &fbdiv_val, (u64)rate);
> +
> +	/* Must switch the CPU to other CLK before we change the CPU PLL. */
> +	if (str_to_pll_clk(clk_name) == CLK_PLL_CPU) {
> +		clk_cpu_mux = __clk_lookup("mux_cpu_root_3mux1");
> +		if (!clk_cpu_mux) {
> +			pr_err("%s %d, failed to get %s\n", __func__, __LINE__,
> +			       "mux_cpu_root_3mux1");
> +			return -EINVAL;
> +		}
> +		clk_cpu_lp_pll = __clk_lookup("fixed_factor_u84_core_lp_div2");
> +		if (!clk_cpu_lp_pll) {
> +			pr_err("%s %d, failed to get %s\n", __func__, __LINE__,
> +			       "fixed_factor_u84_core_lp_div2");
> +			return -EINVAL;
> +		}
> +		ret = clk_prepare_enable(clk_cpu_lp_pll);
> +		if (ret) {
> +			pr_err("%s %d, failed to enable %s, ret %d\n",
> +			       __func__, __LINE__,
> +			       "fixed_factor_u84_core_lp_div2", ret);
> +			return ret;
> +		}
> +		clk_cpu_pll = __clk_lookup("clk_pll_cpu");
> +		if (!clk_cpu_pll) {
> +			pr_err("%s %d, failed to get %s\n", __func__, __LINE__,
> +			       "clk_pll_cpu");
> +			clk_disable_unprepare(clk_cpu_lp_pll);
> +			return -EINVAL;
> +		}
> +
> +		ret = clk_set_parent(clk_cpu_mux, clk_cpu_lp_pll);
> +		if (ret) {
> +			pr_err("%s %d, failed to switch %s to %s, ret %d\n",
> +			       __func__, __LINE__, "mux_cpu_root_3mux1",
> +			       "fixed_factor_u84_core_lp_div2", ret);
> +			clk_disable_unprepare(clk_cpu_lp_pll);
> +			return -EPERM;
> +		}
> +	}
> +
> +	/* first disable PLL */
> +	val = readl_relaxed(clk->ctrl_reg0);
> +	val &= ~(((1 << clk->pllen_width) - 1) << clk->pllen_shift);
> +	val |= 0 << clk->pllen_shift;
> +	writel_relaxed(val, clk->ctrl_reg0);
> +
> +	val = readl_relaxed(clk->ctrl_reg0);
> +	val &= ~(((1 << clk->fbdiv_width) - 1) << clk->fbdiv_shift);
> +	val &= ~(((1 << clk->refdiv_width) - 1) << clk->refdiv_shift);
> +	val |= refdiv_val << clk->refdiv_shift;
> +	val |= fbdiv_val << clk->fbdiv_shift;
> +	writel_relaxed(val, clk->ctrl_reg0);
> +
> +	val = readl_relaxed(clk->ctrl_reg1);
> +	val &= ~(((1 << clk->frac_width) - 1) << clk->frac_shift);
> +	val |= frac_val << clk->frac_shift;
> +	writel_relaxed(val, clk->ctrl_reg1);
> +
> +	val = readl_relaxed(clk->ctrl_reg2);
> +	val &= ~(((1 << clk->postdiv1_width) - 1) << clk->postdiv1_shift);
> +	val |= postdiv1_val << clk->postdiv1_shift;
> +	writel_relaxed(val, clk->ctrl_reg2);
> +
> +	/* at last, enable PLL */
> +	val = readl_relaxed(clk->ctrl_reg0);
> +	val &= ~(((1 << clk->pllen_width) - 1) << clk->pllen_shift);
> +	val |= 1 << clk->pllen_shift;
> +	writel_relaxed(val, clk->ctrl_reg0);
> +
> +	/* usually the PLL would lock in 50us */
> +	do {
> +		usleep_range(refdiv_val * 80, refdiv_val * 80 * 2);
> +		val = readl_relaxed(clk->status_reg);
> +		if (val & 1 << clk->lock_shift) {
> +			lock_flag = true;
> +			break;
> +		}
> +	} while (try_count++ < 10);
> +
> +	if (!lock_flag) {
> +		pr_err("%s %d, failed to lock the cpu pll", __func__, __LINE__);
> +		return -EBUSY;
> +	}
> +
> +	if (str_to_pll_clk(clk_name) == CLK_PLL_CPU) {
> +		ret = clk_set_parent(clk_cpu_mux, clk_cpu_pll);
> +		if (ret) {
> +			pr_err("%s %d, failed to switch %s to %s, ret %d\n",
> +			       __func__, __LINE__, "mux_cpu_root_3mux1",
> +			       "clk_pll_cpu", ret);
> +			return -EPERM;
> +		}
> +		clk_disable_unprepare(clk_cpu_lp_pll);
> +	}
> +	return ret;
> +}
> +
> +static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct eswin_clk_pll *clk = to_pll_clk(hw);
> +	const char *clk_name = clk_hw_get_name(&clk->hw);
> +
> +	if (!clk_name)
> +		return -ENOMEM;
> +
> +	u64 frac_val, fbdiv_val, refdiv_val, tmp, rem;
> +	u32 postdiv1_val;
> +	u32 val;
> +	u64 rate = 0;
> +
> +	val = readl_relaxed(clk->ctrl_reg0);
> +	val = val >> clk->fbdiv_shift;
> +	val &= ((1 << clk->fbdiv_width) - 1);
> +	fbdiv_val = val;
> +
> +	val = readl_relaxed(clk->ctrl_reg0);
> +	val = val >> clk->refdiv_shift;
> +	val &= ((1 << clk->refdiv_width) - 1);
> +	refdiv_val = val;
> +
> +	val = readl_relaxed(clk->ctrl_reg1);
> +	val = val >> clk->frac_shift;
> +	val &= ((1 << clk->frac_width) - 1);
> +	frac_val = val;
> +
> +	val = readl_relaxed(clk->ctrl_reg2);
> +	val = val >> clk->postdiv1_shift;
> +	val &= ((1 << clk->postdiv1_width) - 1);
> +	postdiv1_val = val;
> +
> +	/* rate = 24000000 * (fbdiv + frac / (2 ^ 24)) / 4 */
> +	if (str_to_pll_clk(clk_name)) {
> +		tmp = 1000 * frac_val;
> +		rem = do_div(tmp, BIT(24));
> +		if (rem)
> +			rate = (u64)(6000 * (1000 * fbdiv_val + tmp) +
> +				    ((6000 * rem) >> 24) + 1);
> +		else
> +			rate = (u64)(6000 * 1000 * fbdiv_val);
> +	}
> +
> +	return rate;
> +}
> +
> +static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *parent_rate)
> +{
> +	struct eswin_clk_pll *clk = to_pll_clk(hw);
> +	const char *clk_name = clk_hw_get_name(&clk->hw);
> +
> +	if (!clk_name)
> +		return -ENOMEM;
> +
> +	int index;
> +	u64 round_rate = 0;
> +
> +	/* Must be sorted in ascending order */
> +	u64 apll_clk[] = { APLL_LOW_FREQ, APLL_HIGH_FREQ };
> +	u64 cpu_pll_clk[] = { CLK_FREQ_100M,  CLK_FREQ_200M,  CLK_FREQ_400M,
> +			      CLK_FREQ_500M,  CLK_FREQ_600M,  CLK_FREQ_700M,
> +			      CLK_FREQ_800M,  CLK_FREQ_900M,  CLK_FREQ_1000M,
> +			      CLK_FREQ_1200M, CLK_FREQ_1300M, CLK_FREQ_1400M,
> +			      CLK_FREQ_1500M, CLK_FREQ_1600M, CLK_FREQ_1700M,
> +			      CLK_FREQ_1800M };
> +
> +	switch (str_to_pll_clk(clk_name)) {
> +	case CLK_APLL_FOUT1:
> +		index = find_closest(rate, apll_clk, ARRAY_SIZE(apll_clk));
> +		round_rate = apll_clk[index];
> +		break;
> +	case CLK_PLL_CPU:
> +		index = find_closest(rate, cpu_pll_clk,
> +				     ARRAY_SIZE(cpu_pll_clk));
> +		round_rate = cpu_pll_clk[index];
> +		break;
> +	default:
> +		pr_err("%s %d, unknown clk %s\n", __func__, __LINE__,
> +		       clk_name);
> +		break;
> +	}
> +	return round_rate;
> +}
> +
> +static const struct clk_ops eswin_clk_pll_ops = {
> +	.set_rate = clk_pll_set_rate,
> +	.recalc_rate = clk_pll_recalc_rate,
> +	.round_rate = clk_pll_round_rate,
> +};
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
> +
> +	if (IS_ERR(parent_base)) {
> +		pr_err("%s: Failed to map registers\n", __func__);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_string(np, "clock-output-names", &clk_name);
> +	if (ret) {
> +		pr_err("%s: Missing clock-output-names\n", __func__);
> +		goto put_node;
> +	}
> +
> +	parent_name = of_clk_get_parent_name(np, 0);
> +	if (!parent_name)
> +		goto put_node;
> +
> +	ret = of_property_read_u32(np, "bit-index", &idx_bit);
> +	if (ret) {
> +		pr_err("%s: Missing bit-index for gate %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "reg", &reg);
> +	if (ret) {
> +		pr_err("%s: Missing reg for gate %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	clk_hw = clk_hw_register_gate(NULL, clk_name, parent_name,
> +				      CLK_SET_RATE_PARENT,
> +				      parent_base + reg, idx_bit, 0, NULL);
> +
> +	if (IS_ERR(clk_hw)) {
> +		pr_err("%s: Failed to register gate clock %s: %ld\n",
> +		       __func__, clk_name, PTR_ERR(clk_hw));
> +		goto put_node;
> +	}
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, clk_hw);
> +	if (ret) {
> +		pr_err("%s: Failed to add clock provider: %d\n", __func__, ret);
> +		clk_hw_unregister_gate(clk_hw);
> +	}
> +
> +put_node:
> +	of_node_put(parent_np);
> +}
> +
> +void __init eswin_clk_mux_register(struct device_node *np)
> +{
> +	struct clk *clk;
> +	const char *clk_name = NULL;
> +	const char **parent_names = NULL;
> +	struct device_node *parent_np;
> +	u32 shift, width;
> +	u32 reg;
> +	u8 num_parents;
> +	u32 mask = 0;
> +	int ret, i;
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
> +
> +	if (IS_ERR(parent_base)) {
> +		pr_err("%s: Failed to map registers\n", __func__);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_string(np, "clock-output-names", &clk_name);
> +	if (ret) {
> +		pr_err("%s: Missing clock-output-names\n", __func__);
> +		goto put_node;
> +	}
> +
> +	num_parents = of_clk_get_parent_count(np);
> +	if (!num_parents) {
> +		pr_err("%s: No parents for mux %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	parent_names = kcalloc(num_parents, sizeof(*parent_names),
> +			       GFP_KERNEL);
> +	if (!parent_names)
> +		goto put_node;
> +
> +	for (i = 0; i < num_parents; i++) {
> +		parent_names[i] = of_clk_get_parent_name(np, i);
> +		if (!parent_names[i]) {
> +			pr_err("%s: Failed to get parent name %d for %s\n",
> +			       __func__, i, clk_name);
> +			goto free_parents;
> +		}
> +	}
> +
> +	ret = of_property_read_u32(np, "shift", &shift);
> +	if (ret) {
> +		pr_err("%s: Missing shift for mux %s\n", __func__, clk_name);
> +		goto free_parents;
> +	}
> +
> +	ret = of_property_read_u32(np, "width", &width);
> +	if (ret) {
> +		pr_err("%s: Missing width for mux %s\n", __func__, clk_name);
> +		goto free_parents;
> +	}
> +
> +	ret = of_property_read_u32(np, "reg", &reg);
> +	if (ret) {
> +		pr_err("%s: Missing reg for mux %s\n", __func__, clk_name);
> +		goto free_parents;
> +	}
> +
> +	mask = BIT(width) - 1;
> +	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
> +				     CLK_SET_RATE_PARENT, parent_base + reg,
> +				     shift, mask, 0, NULL, NULL);
> +
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: Failed to register mux clock %s: %ld\n", __func__,
> +		       clk_name, PTR_ERR(clk));
> +		goto free_parents;
> +	}
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, clk);
> +	if (ret) {
> +		pr_err("%s: Failed to add clock provider: %d\n", __func__, ret);
> +		clk_unregister_mux(clk);
> +	}
> +
> +free_parents:
> +	kfree(parent_names);
> +put_node:
> +	of_node_put(parent_np);
> +}
> +
> +void __init eswin_clk_div_register(struct device_node *np)
> +{
> +	struct clk_hw *clk_hw;
> +	struct device_node *parent_np;
> +	const char *clk_name;
> +	const char *parent_name;
> +	u32 shift, width, div_flags;
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
> +
> +	if (IS_ERR(parent_base)) {
> +		pr_err("%s: Failed to map registers\n", __func__);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_string(np, "clock-output-names", &clk_name);
> +	if (ret) {
> +		pr_err("%s: Missing clock-output-names\n", __func__);
> +		goto put_node;
> +	}
> +
> +	parent_name = of_clk_get_parent_name(np, 0);
> +	if (!parent_name) {
> +		pr_err("%s: No parent for div %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "shift", &shift);
> +	if (ret) {
> +		pr_err("%s: Missing shift for div %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "width", &width);
> +	if (ret) {
> +		pr_err("%s: Missing width for div %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "div-flags", &div_flags);
> +	if (ret) {
> +		pr_err("%s: Missing div-flags for div %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "reg", &reg);
> +	if (ret) {
> +		pr_err("%s: Missing reg for div %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	clk_hw = clk_hw_register_divider(NULL, clk_name, parent_name, 0,
> +					 parent_base + reg, shift, width,
> +					 div_flags, NULL);
> +
> +	if (IS_ERR(clk_hw)) {
> +		pr_err("%s: Failed to register divider clock %s: %ld\n",
> +		       __func__, clk_name, PTR_ERR(clk_hw));
> +		goto put_node;
> +	}
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, clk_hw);
> +	if (ret) {
> +		pr_err("%s: Failed to add clock provider: %d\n", __func__, ret);
> +		clk_hw_unregister_divider(clk_hw);
> +	}
> +
> +put_node:
> +	of_node_put(parent_np);
> +}
> +
> +void __init eswin_clk_pll_register(struct device_node *np)
> +{
> +	struct eswin_clk_pll *p_clk = NULL;
> +	struct clk *clk = NULL;
> +	struct clk_init_data init = {};
> +	struct device_node *parent_np;
> +	const char *clk_name;
> +	const char *parent_name;
> +	int ret;
> +	u32 reg[4];
> +	u32 en_shift, en_width;
> +	u32 refdiv_shift, refdiv_width;
> +	u32 fbdiv_shift, fbdiv_width;
> +	u32 frac_shift, frac_width;
> +	u32 postdiv1_shift, postdiv1_width;
> +	u32 postdiv2_shift, postdiv2_width;
> +	u32 lock_shift, lock_width;
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
> +
> +	if (IS_ERR(parent_base)) {
> +		pr_err("%s: Failed to map registers\n", __func__);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_string(np, "clock-output-names", &clk_name);
> +	if (ret) {
> +		pr_err("%s: Missing clock-output-names\n", __func__);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "enable-shift", &en_shift);
> +	if (ret) {
> +		pr_err("%s: Missing enable-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "enable-width", &en_width);
> +	if (ret) {
> +		pr_err("%s: Missing enable-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "refdiv-shift", &refdiv_shift);
> +	if (ret) {
> +		pr_err("%s: Missing refdiv-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "refdiv-width", &refdiv_width);
> +	if (ret) {
> +		pr_err("%s: Missing refdiv-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "fbdiv-shift", &fbdiv_shift);
> +	if (ret) {
> +		pr_err("%s: Missing fbdiv-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "fbdiv-width", &fbdiv_width);
> +	if (ret) {
> +		pr_err("%s: Missing fbdiv-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "frac-shift", &frac_shift);
> +	if (ret) {
> +		pr_err("%s: Missing frac-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "frac-width", &frac_width);
> +	if (ret) {
> +		pr_err("%s: Missing frac-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "postdiv1-shift", &postdiv1_shift);
> +	if (ret) {
> +		pr_err("%s: Missing postdiv1-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "postdiv1-width", &postdiv1_width);
> +	if (ret) {
> +		pr_err("%s: Missing postdiv1-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "postdiv2-shift", &postdiv2_shift);
> +	if (ret) {
> +		pr_err("%s: Missing postdiv2-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "postdiv2-width", &postdiv2_width);
> +	if (ret) {
> +		pr_err("%s: Missing postdiv2-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "lock-shift", &lock_shift);
> +	if (ret) {
> +		pr_err("%s: Missing lock-shift for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32(np, "lock-width", &lock_width);
> +	if (ret) {
> +		pr_err("%s: Missing lock-width for pll %s\n", __func__,
> +		       clk_name);
> +		goto put_node;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "reg", reg, 4);
> +	if (ret) {
> +		pr_err("%s: Missing reg for pll %s\n", __func__, clk_name);
> +		goto put_node;
> +	}
> +
> +	p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
> +	if (!p_clk)
> +		goto put_node;
> +
> +	p_clk->ctrl_reg0 = parent_base + reg[0];
> +	p_clk->pllen_shift = en_shift;
> +	p_clk->pllen_width = en_width;
> +	p_clk->refdiv_shift = refdiv_shift;
> +	p_clk->refdiv_width = refdiv_width;
> +	p_clk->fbdiv_shift = fbdiv_shift;
> +	p_clk->fbdiv_width = fbdiv_width;
> +
> +	p_clk->ctrl_reg1 = parent_base + reg[1];
> +	p_clk->frac_shift = frac_shift;
> +	p_clk->frac_width = frac_width;
> +
> +	p_clk->ctrl_reg2 = parent_base + reg[2];
> +	p_clk->postdiv1_shift = postdiv1_shift;
> +	p_clk->postdiv1_width = postdiv1_width;
> +	p_clk->postdiv2_shift = postdiv2_shift;
> +	p_clk->postdiv2_width = postdiv2_width;
> +
> +	p_clk->status_reg = parent_base + reg[3];
> +	p_clk->lock_shift = lock_shift;
> +	p_clk->lock_width = lock_width;
> +
> +	init.name = clk_name;
> +	init.flags = 0;
> +	init.parent_names = parent_name ? &parent_name : NULL;
> +	init.num_parents = parent_name ? 1 : 0;
> +	init.ops = &eswin_clk_pll_ops;
> +	p_clk->hw.init = &init;
> +
> +	clk = clk_register(NULL, &p_clk->hw);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: Failed to register pll clock %s: %ld\n", __func__,
> +		       clk_name, PTR_ERR(clk));
> +		kfree(p_clk);
> +		goto put_node;
> +	}
> +
> +	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, clk);
> +	if (ret) {
> +		pr_err("%s: Failed to add clock provider: %d\n", __func__, ret);
> +		clk_unregister(clk);
> +	}
> +
> +put_node:
> +	of_node_put(parent_np);
> +}
> diff --git a/drivers/clk/eswin/clk.h b/drivers/clk/eswin/clk.h
> new file mode 100644
> index 000000000000..1302540f9e24
> --- /dev/null
> +++ b/drivers/clk/eswin/clk.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd..
> + * All rights reserved.
> + *
> + * Authors:
> + *	Yifeng Huang <huangyifeng@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +
> +#ifndef __ESWIN_CLK_H__
> +#define __ESWIN_CLK_H__
> +
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
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
> +	u8 fbdiv_width;
> +
> +	void __iomem *ctrl_reg1;
> +	u8 frac_shift;
> +	u8 frac_width;
> +
> +	void __iomem *ctrl_reg2;
> +	u8 postdiv1_shift;
> +	u8 postdiv1_width;
> +	u8 postdiv2_shift;
> +	u8 postdiv2_width;
> +
> +	void __iomem *status_reg;
> +	u8 lock_shift;
> +	u8 lock_width;
> +};
> +
> +void __init eswin_clk_gate_register(struct device_node *np);
> +void __init eswin_clk_mux_register(struct device_node *np);
> +void __init eswin_clk_div_register(struct device_node *np);
> +void __init eswin_clk_pll_register(struct device_node *np);
> +
> +#endif /* __ESWIN_CLK_H__ */
> --
> 2.17.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

