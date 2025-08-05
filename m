Return-Path: <linux-kernel+bounces-756682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CAEB1B7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F6516C9B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2E277C98;
	Tue,  5 Aug 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvLIBxj8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A64A28;
	Tue,  5 Aug 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408351; cv=none; b=m5cn4QqnHH5k9SvRbqI1u68eI/errNi/RCMWXfGax84g8WVt1Yf8N0xqVo0WfzjBoQlKP5BLK6tSWj2vsy6c9WUbQgjeAHkPYixp9yYzt2XCMSWQB6pXIV66BlFKJPI/zLiwE5wRJgJIrGgrurhaOhjdLHmv/Ibq0KxX8teOPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408351; c=relaxed/simple;
	bh=Sfc3xMxHGqVoflK676SStVZbw5uDGyunMmKEB2eOesM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnMJG0ZhL/KE8Tg0y26816hDZJlAtdvrjY25Ul2eU5xJCehkmcvy5qwVXKC+GG38l8dVgS5W36FeFXO4qomuHPHr15vN5LvYcRY11a+X6LhYdr3UqEFKE4M8NG/m7CddaHVTL2UHjvpP2lIu7lHSngljIIoIiQqg7mDf5oHnNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvLIBxj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E53C4CEF0;
	Tue,  5 Aug 2025 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754408351;
	bh=Sfc3xMxHGqVoflK676SStVZbw5uDGyunMmKEB2eOesM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvLIBxj8IsgIX41sw53OtzX3fdSThyLyVyGhoI1inGTzM5sMCj5lU9fDrUeBDXkUd
	 aKZd4ZF2s2RWT+H3CnkZFF+w7jF7GgHW8UBtprj+4UVk4Zk5LBFJVwPdVcgFwgu5zA
	 DpVn4bKnqDeuI7G9lSY1QVAjN4L7LkdnISkvQFOJjJbXhC1ONbkAwrSnfCWkiZScoI
	 b7dJkTlw1a8merA/t75DOoawK+KnPSH6o12t33UxdV/RJyve4f8cHuGdKPqdxIuoTB
	 0q99GD1EaJ7h6gVRa3dku3gsRFpk3Ba0r0dmdriLLPz/mcuSQ9C5s+4BJ+JjuyfwFK
	 mPLUnqRSi/iSg==
Date: Tue, 5 Aug 2025 10:39:08 -0500
From: Rob Herring <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Message-ID: <20250805153908.GA1807801-robh@kernel.org>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250804053445.1482749-3-ryan_chen@aspeedtech.com>

On Mon, Aug 04, 2025 at 01:34:45PM +0800, Ryan Chen wrote:
> The AST2700 SoC follows the multi-instance interrupt controller architecture
> introduced in the AST2600, where each SCU interrupt group (IC0–IC3) is treated
> as an independent interrupt domain.
> 
> Unlike the AST2600, which uses a combined register for interrupt enable and
> status bits, the AST2700 separates these into distinct registers: one for
> interrupt enable (IER) and another for interrupt status (ISR). This architectural
> change requires explicit handling of split registers for interrupt control.
> 
> - Register definitions and configuration for AST2700 SCU IC instances
>   (compatible: aspeed,ast2700-scu-ic0/1/2/3)
> - Initialization logic for handling split IER/ISR registers
> - Chained IRQ handling and mask/unmask logic
> - Table-driven registration using IRQCHIP_DECLARE per compatible
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/irqchip/irq-aspeed-scu-ic.c | 240 ++++++++++++++++++++++------
>  1 file changed, 195 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
> index 1c7045467c48..b6f3ba269c5b 100644
> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
> + * Aspeed AST24XX, AST25XX, AST26XX, AST27XX SCU Interrupt Controller
>   * Copyright 2019 IBM Corporation
>   *
>   * Eddie James <eajames@linux.ibm.com>
> @@ -34,11 +34,42 @@
>  	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
>  #define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
>  
> +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
> +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
> +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)
> +#define ASPEED_AST2700_SCU_IC0_NUM_IRQS	4
> +
> +#define ASPEED_AST2700_SCU_IC1_EN_REG	0x1e0
> +#define ASPEED_AST2700_SCU_IC1_STS_REG	0x1e4
> +#define ASPEED_AST2700_SCU_IC1_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC1_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC1_SHIFT)
> +#define ASPEED_AST2700_SCU_IC1_NUM_IRQS	4
> +
> +#define ASPEED_AST2700_SCU_IC2_EN_REG	0x104
> +#define ASPEED_AST2700_SCU_IC2_STS_REG	0x100
> +#define ASPEED_AST2700_SCU_IC2_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC2_ENABLE	\
> +	GENMASK(3, ASPEED_AST2700_SCU_IC2_SHIFT)
> +#define ASPEED_AST2700_SCU_IC2_NUM_IRQS	4
> +
> +#define ASPEED_AST2700_SCU_IC3_EN_REG	0x10c
> +#define ASPEED_AST2700_SCU_IC3_STS_REG	0x108
> +#define ASPEED_AST2700_SCU_IC3_SHIFT	0
> +#define ASPEED_AST2700_SCU_IC3_ENABLE	\
> +	GENMASK(1, ASPEED_AST2700_SCU_IC3_SHIFT)
> +#define ASPEED_AST2700_SCU_IC3_NUM_IRQS	2
> +

The reason for ic0/ic1 compatibles before was the enable field was 
different. Now it's at least at the same shift. Do you really need a 
different value for IC3? 

The register addresses should come from "reg". I don't understand why 
they are hardcoded in the driver.

Rob

