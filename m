Return-Path: <linux-kernel+bounces-771808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B45B28BBE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981311CC81E9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952C5235041;
	Sat, 16 Aug 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZnvbNhs"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1767E220F36
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755331923; cv=none; b=sSttE+8EpgTxG6eNIu4qLNCPty1igZXeUK5VdFFO/8rb3gnWbH/6JGGpHi+gZaqgIx6P6QWd4+L8rzF6x7/xZI7EYWVlU8R/DrC/DxeEMuMmWLyu0EN7jFOVjVxYcyfehd6JcKHIokbbj4f97AEDq2LVw9MnoR+mFzcapmkmzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755331923; c=relaxed/simple;
	bh=8lP4zpMA/i2HAjSY6dZb9AmNIo93cnDnMVNT4KS7mAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjihAmh0HQaHLVflpCFm7BYHHLZqsq+keOeP/biEHqWU9yOr8fOtJlbfOl9/TTd5d/O+IyVatc3AYCQpk0CDk4pJmyEp1sljN1/qGTjvh5jCUuteGyVGD6n+wfDJ/F6HbOEl8KPIPDEp+LfCqVzXSq05XLDAM7hVD3DcCU/Q8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZnvbNhs; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Aug 2025 16:11:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755331917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QGRnTv4PX9m82Jne+p4R6rcnOyuHJv7aAuXXeHh7ZGA=;
	b=sZnvbNhsY2gVfOu/MXMUkomNwIRIbXOiyBweDFiPu0L8t7hueo0DqUVnrzVAm5yRAEqPYL
	tcmwnJuf6Wlxe0K7Nierlj2IxKhx2preaX/BOLqRCOmoTqkBrRCMeoiLiqdtJYiA5s8LcY
	ks10PrAE54xD+Gwx9mXv9kCwOpRC4x4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>,
	Yao Zi <ziyao@disroot.org>, Han Gao <rabenda.cn@gmail.com>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH 1/2] clk: thead: th1520-ap: describe gate clocks with
 clk_gate
Message-ID: <aKA9QxKo3fg-bdNa@troy-wujie14pro-arch>
References: <20250813171136.2213309-1-uwu@icenowy.me>
 <20250813171136.2213309-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813171136.2213309-2-uwu@icenowy.me>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 14, 2025 at 01:11:35AM +0800, Icenowy Zheng wrote:
> Similar to previous situation of mux clocks, the gate clocks of
> clk-th1520-ap drivers are also using a helper that creates a temporary
> struct clk_hw and abandons the struct clk_hw in struct ccu_common, which
> prevents clock gates to be clock parents.
> 
> Do the similar refactor of dropping struct ccu_common and directly use
> struct clk_gate here.
> 
> This patch mimics the refactor done on struct ccu_mux at [1].
> 
> [1] https://lore.kernel.org/all/20250722080535.60027-2-ziyao@disroot.org/
Should we remove this link to the cover-letter?
                - Troy

> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 382 +++++++++++++++---------------
>  1 file changed, 185 insertions(+), 197 deletions(-)
> 
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> index 0224f2dde0f63..d08e7fb387e50 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -49,8 +49,9 @@ struct ccu_mux {
>  };
>  
>  struct ccu_gate {
> -	u32			enable;
> -	struct ccu_common	common;
> +	int			clkid;
> +	u32			reg;
> +	struct clk_gate		gate;
>  };
>  
>  struct ccu_div {
> @@ -89,12 +90,12 @@ struct ccu_pll {
>  					0),				\
>  	}
>  
> -#define CCU_GATE(_clkid, _struct, _name, _parent, _reg, _gate, _flags)	\
> +#define CCU_GATE(_clkid, _struct, _name, _parent, _reg, _bit, _flags)	\
>  	struct ccu_gate _struct = {					\
> -		.enable	= _gate,					\
> -		.common	= {						\
> -			.clkid		= _clkid,			\
> -			.cfg0		= _reg,				\
> +		.clkid	= _clkid,					\
> +		.reg	= _reg,						\
> +		.gate	= {						\
> +			.bit_idx	= _bit,				\
>  			.hw.init	= CLK_HW_INIT_PARENTS_DATA(	\
>  						_name,			\
>  						_parent,		\
> @@ -122,13 +123,6 @@ static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
>  	return container_of(common, struct ccu_div, common);
>  }
>  
> -static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
> -{
> -	struct ccu_common *common = hw_to_ccu_common(hw);
> -
> -	return container_of(common, struct ccu_gate, common);
> -}
> -
>  static u8 ccu_get_parent_helper(struct ccu_common *common,
>  				struct ccu_internal *mux)
>  {
> @@ -876,128 +870,128 @@ static const struct clk_parent_data emmc_sdio_ref_clk_pd[] = {
>  	{ .hw = &emmc_sdio_ref_clk.hw },
>  };
>  
> -static CCU_GATE(CLK_BROM, brom_clk, "brom", ahb2_cpusys_hclk_pd, 0x100, BIT(4), 0);
> -static CCU_GATE(CLK_BMU, bmu_clk, "bmu", axi4_cpusys2_aclk_pd, 0x100, BIT(5), 0);
> +static CCU_GATE(CLK_BROM, brom_clk, "brom", ahb2_cpusys_hclk_pd, 0x100, 4, 0);
> +static CCU_GATE(CLK_BMU, bmu_clk, "bmu", axi4_cpusys2_aclk_pd, 0x100, 5, 0);
>  static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", axi4_cpusys2_aclk_pd,
> -		0x134, BIT(8), CLK_IS_CRITICAL);
> +		0x134, 8, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_X2X_CPUSYS, x2x_cpusys_clk, "x2x-cpusys", axi4_cpusys2_aclk_pd,
> -		0x134, BIT(7), CLK_IS_CRITICAL);
> +		0x134, 7, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_CPU2AON_X2H, cpu2aon_x2h_clk, "cpu2aon-x2h", axi_aclk_pd,
> -		0x138, BIT(8), CLK_IS_CRITICAL);
> +		0x138, 8, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_CPU2PERI_X2H, cpu2peri_x2h_clk, "cpu2peri-x2h", axi4_cpusys2_aclk_pd,
> -		0x140, BIT(9), CLK_IS_CRITICAL);
> +		0x140, 9, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_PERISYS_APB1_HCLK, perisys_apb1_hclk, "perisys-apb1-hclk", perisys_ahb_hclk_pd,
> -		0x150, BIT(9), CLK_IS_CRITICAL);
> +		0x150, 9, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_PERISYS_APB2_HCLK, perisys_apb2_hclk, "perisys-apb2-hclk", perisys_ahb_hclk_pd,
> -		0x150, BIT(10), CLK_IS_CRITICAL);
> +		0x150, 10, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3_hclk, "perisys-apb3-hclk", perisys_ahb_hclk_pd,
> -		0x150, BIT(11), CLK_IS_CRITICAL);
> +		0x150, 11, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-hclk", perisys_ahb_hclk_pd,
> -		0x150, BIT(12), 0);
> -static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, BIT(5), CLK_IS_CRITICAL);
> -static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, BIT(13), CLK_IS_CRITICAL);
> -static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, BIT(30), 0);
> -static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, BIT(26), 0);
> -static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, BIT(24), 0);
> -static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, BIT(23), 0);
> -static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, BIT(22), 0);
> -static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, BIT(21), 0);
> -static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, BIT(20), 0);
> -static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, BIT(19), 0);
> -static CCU_GATE(CLK_PWM, pwm_clk, "pwm", perisys_apb_pclk_pd, 0x204, BIT(18), 0);
> -static CCU_GATE(CLK_QSPI0, qspi0_clk, "qspi0", video_pll_clk_pd, 0x204, BIT(17), 0);
> -static CCU_GATE(CLK_QSPI1, qspi1_clk, "qspi1", video_pll_clk_pd, 0x204, BIT(16), 0);
> -static CCU_GATE(CLK_SPI, spi_clk, "spi", video_pll_clk_pd, 0x204, BIT(15), 0);
> -static CCU_GATE(CLK_UART0_PCLK, uart0_pclk, "uart0-pclk", perisys_apb_pclk_pd, 0x204, BIT(14), 0);
> -static CCU_GATE(CLK_UART1_PCLK, uart1_pclk, "uart1-pclk", perisys_apb_pclk_pd, 0x204, BIT(13), 0);
> -static CCU_GATE(CLK_UART2_PCLK, uart2_pclk, "uart2-pclk", perisys_apb_pclk_pd, 0x204, BIT(12), 0);
> -static CCU_GATE(CLK_UART3_PCLK, uart3_pclk, "uart3-pclk", perisys_apb_pclk_pd, 0x204, BIT(11), 0);
> -static CCU_GATE(CLK_UART4_PCLK, uart4_pclk, "uart4-pclk", perisys_apb_pclk_pd, 0x204, BIT(10), 0);
> -static CCU_GATE(CLK_UART5_PCLK, uart5_pclk, "uart5-pclk", perisys_apb_pclk_pd, 0x204, BIT(9), 0);
> -static CCU_GATE(CLK_GPIO0, gpio0_clk, "gpio0-clk", perisys_apb_pclk_pd, 0x204, BIT(8), 0);
> -static CCU_GATE(CLK_GPIO1, gpio1_clk, "gpio1-clk", perisys_apb_pclk_pd, 0x204, BIT(7), 0);
> -static CCU_GATE(CLK_GPIO2, gpio2_clk, "gpio2-clk", peri2sys_apb_pclk_pd, 0x204, BIT(6), 0);
> -static CCU_GATE(CLK_I2C0, i2c0_clk, "i2c0", perisys_apb_pclk_pd, 0x204, BIT(5), 0);
> -static CCU_GATE(CLK_I2C1, i2c1_clk, "i2c1", perisys_apb_pclk_pd, 0x204, BIT(4), 0);
> -static CCU_GATE(CLK_I2C2, i2c2_clk, "i2c2", perisys_apb_pclk_pd, 0x204, BIT(3), 0);
> -static CCU_GATE(CLK_I2C3, i2c3_clk, "i2c3", perisys_apb_pclk_pd, 0x204, BIT(2), 0);
> -static CCU_GATE(CLK_I2C4, i2c4_clk, "i2c4", perisys_apb_pclk_pd, 0x204, BIT(1), 0);
> -static CCU_GATE(CLK_I2C5, i2c5_clk, "i2c5", perisys_apb_pclk_pd, 0x204, BIT(0), 0);
> -static CCU_GATE(CLK_SPINLOCK, spinlock_clk, "spinlock", ahb2_cpusys_hclk_pd, 0x208, BIT(10), 0);
> -static CCU_GATE(CLK_DMA, dma_clk, "dma", axi4_cpusys2_aclk_pd, 0x208, BIT(8), 0);
> -static CCU_GATE(CLK_MBOX0, mbox0_clk, "mbox0", apb3_cpusys_pclk_pd, 0x208, BIT(7), 0);
> -static CCU_GATE(CLK_MBOX1, mbox1_clk, "mbox1", apb3_cpusys_pclk_pd, 0x208, BIT(6), 0);
> -static CCU_GATE(CLK_MBOX2, mbox2_clk, "mbox2", apb3_cpusys_pclk_pd, 0x208, BIT(5), 0);
> -static CCU_GATE(CLK_MBOX3, mbox3_clk, "mbox3", apb3_cpusys_pclk_pd, 0x208, BIT(4), 0);
> -static CCU_GATE(CLK_WDT0, wdt0_clk, "wdt0", apb3_cpusys_pclk_pd, 0x208, BIT(3), 0);
> -static CCU_GATE(CLK_WDT1, wdt1_clk, "wdt1", apb3_cpusys_pclk_pd, 0x208, BIT(2), 0);
> -static CCU_GATE(CLK_TIMER0, timer0_clk, "timer0", apb3_cpusys_pclk_pd, 0x208, BIT(1), 0);
> -static CCU_GATE(CLK_TIMER1, timer1_clk, "timer1", apb3_cpusys_pclk_pd, 0x208, BIT(0), 0);
> -static CCU_GATE(CLK_SRAM0, sram0_clk, "sram0", axi_aclk_pd, 0x20c, BIT(4), 0);
> -static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
> -static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, BIT(2), 0);
> -static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, BIT(1), 0);
> +		0x150, 12, 0);
> +static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8, 5, CLK_IS_CRITICAL);
> +static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, 13, CLK_IS_CRITICAL);
> +static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref_clk_pd, 0x204, 30, 0);
> +static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, 26, 0);
> +static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk_pd, 0x204, 24, 0);
> +static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0x204, 23, 0);
> +static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk_pd, 0x204, 22, 0);
> +static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_aclk_pd, 0x204, 21, 0);
> +static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd, 0x204, 20, 0);
> +static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, 19, 0);
> +static CCU_GATE(CLK_PWM, pwm_clk, "pwm", perisys_apb_pclk_pd, 0x204, 18, 0);
> +static CCU_GATE(CLK_QSPI0, qspi0_clk, "qspi0", video_pll_clk_pd, 0x204, 17, 0);
> +static CCU_GATE(CLK_QSPI1, qspi1_clk, "qspi1", video_pll_clk_pd, 0x204, 16, 0);
> +static CCU_GATE(CLK_SPI, spi_clk, "spi", video_pll_clk_pd, 0x204, 15, 0);
> +static CCU_GATE(CLK_UART0_PCLK, uart0_pclk, "uart0-pclk", perisys_apb_pclk_pd, 0x204, 14, 0);
> +static CCU_GATE(CLK_UART1_PCLK, uart1_pclk, "uart1-pclk", perisys_apb_pclk_pd, 0x204, 13, 0);
> +static CCU_GATE(CLK_UART2_PCLK, uart2_pclk, "uart2-pclk", perisys_apb_pclk_pd, 0x204, 12, 0);
> +static CCU_GATE(CLK_UART3_PCLK, uart3_pclk, "uart3-pclk", perisys_apb_pclk_pd, 0x204, 11, 0);
> +static CCU_GATE(CLK_UART4_PCLK, uart4_pclk, "uart4-pclk", perisys_apb_pclk_pd, 0x204, 10, 0);
> +static CCU_GATE(CLK_UART5_PCLK, uart5_pclk, "uart5-pclk", perisys_apb_pclk_pd, 0x204, 9, 0);
> +static CCU_GATE(CLK_GPIO0, gpio0_clk, "gpio0-clk", perisys_apb_pclk_pd, 0x204, 8, 0);
> +static CCU_GATE(CLK_GPIO1, gpio1_clk, "gpio1-clk", perisys_apb_pclk_pd, 0x204, 7, 0);
> +static CCU_GATE(CLK_GPIO2, gpio2_clk, "gpio2-clk", peri2sys_apb_pclk_pd, 0x204, 6, 0);
> +static CCU_GATE(CLK_I2C0, i2c0_clk, "i2c0", perisys_apb_pclk_pd, 0x204, 5, 0);
> +static CCU_GATE(CLK_I2C1, i2c1_clk, "i2c1", perisys_apb_pclk_pd, 0x204, 4, 0);
> +static CCU_GATE(CLK_I2C2, i2c2_clk, "i2c2", perisys_apb_pclk_pd, 0x204, 3, 0);
> +static CCU_GATE(CLK_I2C3, i2c3_clk, "i2c3", perisys_apb_pclk_pd, 0x204, 2, 0);
> +static CCU_GATE(CLK_I2C4, i2c4_clk, "i2c4", perisys_apb_pclk_pd, 0x204, 1, 0);
> +static CCU_GATE(CLK_I2C5, i2c5_clk, "i2c5", perisys_apb_pclk_pd, 0x204, 0, 0);
> +static CCU_GATE(CLK_SPINLOCK, spinlock_clk, "spinlock", ahb2_cpusys_hclk_pd, 0x208, 10, 0);
> +static CCU_GATE(CLK_DMA, dma_clk, "dma", axi4_cpusys2_aclk_pd, 0x208, 8, 0);
> +static CCU_GATE(CLK_MBOX0, mbox0_clk, "mbox0", apb3_cpusys_pclk_pd, 0x208, 7, 0);
> +static CCU_GATE(CLK_MBOX1, mbox1_clk, "mbox1", apb3_cpusys_pclk_pd, 0x208, 6, 0);
> +static CCU_GATE(CLK_MBOX2, mbox2_clk, "mbox2", apb3_cpusys_pclk_pd, 0x208, 5, 0);
> +static CCU_GATE(CLK_MBOX3, mbox3_clk, "mbox3", apb3_cpusys_pclk_pd, 0x208, 4, 0);
> +static CCU_GATE(CLK_WDT0, wdt0_clk, "wdt0", apb3_cpusys_pclk_pd, 0x208, 3, 0);
> +static CCU_GATE(CLK_WDT1, wdt1_clk, "wdt1", apb3_cpusys_pclk_pd, 0x208, 2, 0);
> +static CCU_GATE(CLK_TIMER0, timer0_clk, "timer0", apb3_cpusys_pclk_pd, 0x208, 1, 0);
> +static CCU_GATE(CLK_TIMER1, timer1_clk, "timer1", apb3_cpusys_pclk_pd, 0x208, 0, 0);
> +static CCU_GATE(CLK_SRAM0, sram0_clk, "sram0", axi_aclk_pd, 0x20c, 4, 0);
> +static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, 3, 0);
> +static CCU_GATE(CLK_SRAM2, sram2_clk, "sram2", axi_aclk_pd, 0x20c, 2, 0);
> +static CCU_GATE(CLK_SRAM3, sram3_clk, "sram3", axi_aclk_pd, 0x20c, 1, 0);
>  
>  static CCU_GATE(CLK_AXI4_VO_ACLK, axi4_vo_aclk, "axi4-vo-aclk",
> -		video_pll_clk_pd, 0x0, BIT(0), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 0, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk", video_pll_clk_pd,
> -		0x0, BIT(3), 0);
> +		0x0, 3, 0);
>  static CCU_GATE(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
> -		video_pll_clk_pd, 0x0, BIT(4), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 4, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_DPU_PIXELCLK0, dpu0_pixelclk, "dpu0-pixelclk",
> -		dpu0_clk_pd, 0x0, BIT(5), CLK_SET_RATE_PARENT);
> +		dpu0_clk_pd, 0x0, 5, CLK_SET_RATE_PARENT);
>  static CCU_GATE(CLK_DPU_PIXELCLK1, dpu1_pixelclk, "dpu1-pixelclk",
> -		dpu1_clk_pd, 0x0, BIT(6), CLK_SET_RATE_PARENT);
> +		dpu1_clk_pd, 0x0, 6, CLK_SET_RATE_PARENT);
>  static CCU_GATE(CLK_DPU_HCLK, dpu_hclk, "dpu-hclk", video_pll_clk_pd, 0x0,
> -		BIT(7), 0);
> +		7, 0);
>  static CCU_GATE(CLK_DPU_ACLK, dpu_aclk, "dpu-aclk", video_pll_clk_pd, 0x0,
> -		BIT(8), 0);
> +		8, 0);
>  static CCU_GATE(CLK_DPU_CCLK, dpu_cclk, "dpu-cclk", video_pll_clk_pd, 0x0,
> -		BIT(9), 0);
> +		9, 0);
>  static CCU_GATE(CLK_HDMI_SFR, hdmi_sfr_clk, "hdmi-sfr-clk", video_pll_clk_pd,
> -		0x0, BIT(10), 0);
> +		0x0, 10, 0);
>  static CCU_GATE(CLK_HDMI_PCLK, hdmi_pclk, "hdmi-pclk", video_pll_clk_pd, 0x0,
> -		BIT(11), 0);
> +		11, 0);
>  static CCU_GATE(CLK_HDMI_CEC, hdmi_cec_clk, "hdmi-cec-clk", video_pll_clk_pd,
> -		0x0, BIT(12), 0);
> +		0x0, 12, 0);
>  static CCU_GATE(CLK_MIPI_DSI0_PCLK, mipi_dsi0_pclk, "mipi-dsi0-pclk",
> -		video_pll_clk_pd, 0x0, BIT(13), 0);
> +		video_pll_clk_pd, 0x0, 13, 0);
>  static CCU_GATE(CLK_MIPI_DSI1_PCLK, mipi_dsi1_pclk, "mipi-dsi1-pclk",
> -		video_pll_clk_pd, 0x0, BIT(14), 0);
> +		video_pll_clk_pd, 0x0, 14, 0);
>  static CCU_GATE(CLK_MIPI_DSI0_CFG, mipi_dsi0_cfg_clk, "mipi-dsi0-cfg-clk",
> -		video_pll_clk_pd, 0x0, BIT(15), 0);
> +		video_pll_clk_pd, 0x0, 15, 0);
>  static CCU_GATE(CLK_MIPI_DSI1_CFG, mipi_dsi1_cfg_clk, "mipi-dsi1-cfg-clk",
> -		video_pll_clk_pd, 0x0, BIT(16), 0);
> +		video_pll_clk_pd, 0x0, 16, 0);
>  static CCU_GATE(CLK_MIPI_DSI0_REFCLK, mipi_dsi0_refclk, "mipi-dsi0-refclk",
> -		video_pll_clk_pd, 0x0, BIT(17), 0);
> +		video_pll_clk_pd, 0x0, 17, 0);
>  static CCU_GATE(CLK_MIPI_DSI1_REFCLK, mipi_dsi1_refclk, "mipi-dsi1-refclk",
> -		video_pll_clk_pd, 0x0, BIT(18), 0);
> +		video_pll_clk_pd, 0x0, 18, 0);
>  static CCU_GATE(CLK_HDMI_I2S, hdmi_i2s_clk, "hdmi-i2s-clk", video_pll_clk_pd,
> -		0x0, BIT(19), 0);
> +		0x0, 19, 0);
>  static CCU_GATE(CLK_X2H_DPU1_ACLK, x2h_dpu1_aclk, "x2h-dpu1-aclk",
> -		video_pll_clk_pd, 0x0, BIT(20), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 20, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_X2H_DPU_ACLK, x2h_dpu_aclk, "x2h-dpu-aclk",
> -		video_pll_clk_pd, 0x0, BIT(21), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 21, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_AXI4_VO_PCLK, axi4_vo_pclk, "axi4-vo-pclk",
> -		video_pll_clk_pd, 0x0, BIT(22), 0);
> +		video_pll_clk_pd, 0x0, 22, 0);
>  static CCU_GATE(CLK_IOPMP_VOSYS_DPU_PCLK, iopmp_vosys_dpu_pclk,
> -		"iopmp-vosys-dpu-pclk", video_pll_clk_pd, 0x0, BIT(23), 0);
> +		"iopmp-vosys-dpu-pclk", video_pll_clk_pd, 0x0, 23, 0);
>  static CCU_GATE(CLK_IOPMP_VOSYS_DPU1_PCLK, iopmp_vosys_dpu1_pclk,
> -		"iopmp-vosys-dpu1-pclk", video_pll_clk_pd, 0x0, BIT(24), 0);
> +		"iopmp-vosys-dpu1-pclk", video_pll_clk_pd, 0x0, 24, 0);
>  static CCU_GATE(CLK_IOPMP_VOSYS_GPU_PCLK, iopmp_vosys_gpu_pclk,
> -		"iopmp-vosys-gpu-pclk", video_pll_clk_pd, 0x0, BIT(25), 0);
> +		"iopmp-vosys-gpu-pclk", video_pll_clk_pd, 0x0, 25, 0);
>  static CCU_GATE(CLK_IOPMP_DPU1_ACLK, iopmp_dpu1_aclk, "iopmp-dpu1-aclk",
> -		video_pll_clk_pd, 0x0, BIT(27), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 27, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_IOPMP_DPU_ACLK, iopmp_dpu_aclk, "iopmp-dpu-aclk",
> -		video_pll_clk_pd, 0x0, BIT(28), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 28, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_IOPMP_GPU_ACLK, iopmp_gpu_aclk, "iopmp-gpu-aclk",
> -		video_pll_clk_pd, 0x0, BIT(29), CLK_IS_CRITICAL);
> +		video_pll_clk_pd, 0x0, 29, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_MIPIDSI0_PIXCLK, mipi_dsi0_pixclk, "mipi-dsi0-pixclk",
> -		video_pll_clk_pd, 0x0, BIT(30), 0);
> +		video_pll_clk_pd, 0x0, 30, 0);
>  static CCU_GATE(CLK_MIPIDSI1_PIXCLK, mipi_dsi1_pixclk, "mipi-dsi1-pixclk",
> -		video_pll_clk_pd, 0x0, BIT(31), 0);
> +		video_pll_clk_pd, 0x0, 31, 0);
>  static CCU_GATE(CLK_HDMI_PIXCLK, hdmi_pixclk, "hdmi-pixclk", video_pll_clk_pd,
> -		0x4, BIT(0), 0);
> +		0x4, 0, 0);
>  
>  static CLK_FIXED_FACTOR_HW(gmac_pll_clk_100m, "gmac-pll-clk-100m",
>  			   &gmac_pll_clk.common.hw, 10, 1, 0);
> @@ -1053,93 +1047,93 @@ static struct ccu_mux *th1520_mux_clks[] = {
>  	&uart_sclk,
>  };
>  
> -static struct ccu_common *th1520_gate_clks[] = {
> -	&emmc_sdio_clk.common,
> -	&aon2cpu_a2x_clk.common,
> -	&x2x_cpusys_clk.common,
> -	&brom_clk.common,
> -	&bmu_clk.common,
> -	&cpu2aon_x2h_clk.common,
> -	&cpu2peri_x2h_clk.common,
> -	&cpu2vp_clk.common,
> -	&perisys_apb1_hclk.common,
> -	&perisys_apb2_hclk.common,
> -	&perisys_apb3_hclk.common,
> -	&perisys_apb4_hclk.common,
> -	&npu_axi_clk.common,
> -	&gmac1_clk.common,
> -	&padctrl1_clk.common,
> -	&dsmart_clk.common,
> -	&padctrl0_clk.common,
> -	&gmac_axi_clk.common,
> -	&gpio3_clk.common,
> -	&gmac0_clk.common,
> -	&pwm_clk.common,
> -	&qspi0_clk.common,
> -	&qspi1_clk.common,
> -	&spi_clk.common,
> -	&uart0_pclk.common,
> -	&uart1_pclk.common,
> -	&uart2_pclk.common,
> -	&uart3_pclk.common,
> -	&uart4_pclk.common,
> -	&uart5_pclk.common,
> -	&gpio0_clk.common,
> -	&gpio1_clk.common,
> -	&gpio2_clk.common,
> -	&i2c0_clk.common,
> -	&i2c1_clk.common,
> -	&i2c2_clk.common,
> -	&i2c3_clk.common,
> -	&i2c4_clk.common,
> -	&i2c5_clk.common,
> -	&spinlock_clk.common,
> -	&dma_clk.common,
> -	&mbox0_clk.common,
> -	&mbox1_clk.common,
> -	&mbox2_clk.common,
> -	&mbox3_clk.common,
> -	&wdt0_clk.common,
> -	&wdt1_clk.common,
> -	&timer0_clk.common,
> -	&timer1_clk.common,
> -	&sram0_clk.common,
> -	&sram1_clk.common,
> -	&sram2_clk.common,
> -	&sram3_clk.common,
> -};
> -
> -static struct ccu_common *th1520_vo_gate_clks[] = {
> -	&axi4_vo_aclk.common,
> -	&gpu_core_clk.common,
> -	&gpu_cfg_aclk.common,
> -	&dpu0_pixelclk.common,
> -	&dpu1_pixelclk.common,
> -	&dpu_hclk.common,
> -	&dpu_aclk.common,
> -	&dpu_cclk.common,
> -	&hdmi_sfr_clk.common,
> -	&hdmi_pclk.common,
> -	&hdmi_cec_clk.common,
> -	&mipi_dsi0_pclk.common,
> -	&mipi_dsi1_pclk.common,
> -	&mipi_dsi0_cfg_clk.common,
> -	&mipi_dsi1_cfg_clk.common,
> -	&mipi_dsi0_refclk.common,
> -	&mipi_dsi1_refclk.common,
> -	&hdmi_i2s_clk.common,
> -	&x2h_dpu1_aclk.common,
> -	&x2h_dpu_aclk.common,
> -	&axi4_vo_pclk.common,
> -	&iopmp_vosys_dpu_pclk.common,
> -	&iopmp_vosys_dpu1_pclk.common,
> -	&iopmp_vosys_gpu_pclk.common,
> -	&iopmp_dpu1_aclk.common,
> -	&iopmp_dpu_aclk.common,
> -	&iopmp_gpu_aclk.common,
> -	&mipi_dsi0_pixclk.common,
> -	&mipi_dsi1_pixclk.common,
> -	&hdmi_pixclk.common
> +static struct ccu_gate *th1520_gate_clks[] = {
> +	&emmc_sdio_clk,
> +	&aon2cpu_a2x_clk,
> +	&x2x_cpusys_clk,
> +	&brom_clk,
> +	&bmu_clk,
> +	&cpu2aon_x2h_clk,
> +	&cpu2peri_x2h_clk,
> +	&cpu2vp_clk,
> +	&perisys_apb1_hclk,
> +	&perisys_apb2_hclk,
> +	&perisys_apb3_hclk,
> +	&perisys_apb4_hclk,
> +	&npu_axi_clk,
> +	&gmac1_clk,
> +	&padctrl1_clk,
> +	&dsmart_clk,
> +	&padctrl0_clk,
> +	&gmac_axi_clk,
> +	&gpio3_clk,
> +	&gmac0_clk,
> +	&pwm_clk,
> +	&qspi0_clk,
> +	&qspi1_clk,
> +	&spi_clk,
> +	&uart0_pclk,
> +	&uart1_pclk,
> +	&uart2_pclk,
> +	&uart3_pclk,
> +	&uart4_pclk,
> +	&uart5_pclk,
> +	&gpio0_clk,
> +	&gpio1_clk,
> +	&gpio2_clk,
> +	&i2c0_clk,
> +	&i2c1_clk,
> +	&i2c2_clk,
> +	&i2c3_clk,
> +	&i2c4_clk,
> +	&i2c5_clk,
> +	&spinlock_clk,
> +	&dma_clk,
> +	&mbox0_clk,
> +	&mbox1_clk,
> +	&mbox2_clk,
> +	&mbox3_clk,
> +	&wdt0_clk,
> +	&wdt1_clk,
> +	&timer0_clk,
> +	&timer1_clk,
> +	&sram0_clk,
> +	&sram1_clk,
> +	&sram2_clk,
> +	&sram3_clk,
> +};
> +
> +static struct ccu_gate *th1520_vo_gate_clks[] = {
> +	&axi4_vo_aclk,
> +	&gpu_core_clk,
> +	&gpu_cfg_aclk,
> +	&dpu0_pixelclk,
> +	&dpu1_pixelclk,
> +	&dpu_hclk,
> +	&dpu_aclk,
> +	&dpu_cclk,
> +	&hdmi_sfr_clk,
> +	&hdmi_pclk,
> +	&hdmi_cec_clk,
> +	&mipi_dsi0_pclk,
> +	&mipi_dsi1_pclk,
> +	&mipi_dsi0_cfg_clk,
> +	&mipi_dsi1_cfg_clk,
> +	&mipi_dsi0_refclk,
> +	&mipi_dsi1_refclk,
> +	&hdmi_i2s_clk,
> +	&x2h_dpu1_aclk,
> +	&x2h_dpu_aclk,
> +	&axi4_vo_pclk,
> +	&iopmp_vosys_dpu_pclk,
> +	&iopmp_vosys_dpu1_pclk,
> +	&iopmp_vosys_gpu_pclk,
> +	&iopmp_dpu1_aclk,
> +	&iopmp_dpu_aclk,
> +	&iopmp_gpu_aclk,
> +	&mipi_dsi0_pixclk,
> +	&mipi_dsi1_pixclk,
> +	&hdmi_pixclk
>  };
>  
>  static const struct regmap_config th1520_clk_regmap_config = {
> @@ -1153,7 +1147,7 @@ struct th1520_plat_data {
>  	struct ccu_common **th1520_pll_clks;
>  	struct ccu_common **th1520_div_clks;
>  	struct ccu_mux	  **th1520_mux_clks;
> -	struct ccu_common **th1520_gate_clks;
> +	struct ccu_gate   **th1520_gate_clks;
>  
>  	int nr_clks;
>  	int nr_pll_clks;
> @@ -1192,7 +1186,6 @@ static int th1520_clk_probe(struct platform_device *pdev)
>  
>  	struct regmap *map;
>  	void __iomem *base;
> -	struct clk_hw *hw;
>  	int ret, i;
>  
>  	plat_data = device_get_match_data(&pdev->dev);
> @@ -1251,20 +1244,15 @@ static int th1520_clk_probe(struct platform_device *pdev)
>  	}
>  
>  	for (i = 0; i < plat_data->nr_gate_clks; i++) {
> -		struct ccu_gate *cg = hw_to_ccu_gate(&plat_data->th1520_gate_clks[i]->hw);
> +		struct ccu_gate *cg = plat_data->th1520_gate_clks[i];
>  
> -		plat_data->th1520_gate_clks[i]->map = map;
> +		cg->gate.reg = base + cg->reg;
>  
> -		hw = devm_clk_hw_register_gate_parent_data(dev,
> -							   cg->common.hw.init->name,
> -							   cg->common.hw.init->parent_data,
> -							   cg->common.hw.init->flags,
> -							   base + cg->common.cfg0,
> -							   ffs(cg->enable) - 1, 0, NULL);
> -		if (IS_ERR(hw))
> -			return PTR_ERR(hw);
> +		ret = devm_clk_hw_register(dev, &cg->gate.hw);
> +		if (ret)
> +			return ret;
>  
> -		priv->hws[cg->common.clkid] = hw;
> +		priv->hws[cg->clkid] = &cg->gate.hw;
>  	}
>  
>  	if (plat_data == &th1520_ap_platdata) {
> -- 
> 2.50.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

