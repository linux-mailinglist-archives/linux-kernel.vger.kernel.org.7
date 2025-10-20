Return-Path: <linux-kernel+bounces-860989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5A4BF186A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F19024F54C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54313164A4;
	Mon, 20 Oct 2025 13:24:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D7241665;
	Mon, 20 Oct 2025 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966688; cv=none; b=lxhWwDqCc8hO7wCUwt9rn4XPO9AaRj0cRR0TPAAc5YSPe5XvNyulfv0mqo/j8dCG7vQZiU8BJVBJbQ3wqGR6fH9058XBN1rYN7i57moURdJltYK/5nGByw0Od6CiaulhgjsM/I8EcocE+gkdrqpNMFn7rPI8n45Ip2r1VvUaOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966688; c=relaxed/simple;
	bh=57e2mVImHOH5lb+qBMy58ZLJTwYxPeo4lARKG2XJmLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gspsy9B/pxflQcJR7IXg93Eeh6DoBICeeVDAkZt7f+o/UopZL8WsPmq6ZEi05xC0wvI13R7z+aGLlgfk7iS8K4+86T5pJRV1w1y7jN4t5f9eGoKLp19dLkM2wyVubWO3iMR38wg5/st2CCojjsuX8ttAayQWFfKihBzEMxnEw0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 609F71063;
	Mon, 20 Oct 2025 06:24:38 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 083B23F66E;
	Mon, 20 Oct 2025 06:24:44 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:24:34 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: wens@csie.org, samuel@sholland.org, mturquette@baylibre.com,
 sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as critical
Message-ID: <20251020142434.066f53b8@donnerap.manchester.arm.com>
In-Reply-To: <20251019172647.80379-1-jernej.skrabec@gmail.com>
References: <20251019172647.80379-1-jernej.skrabec@gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Oct 2025 19:26:47 +0200
Jernej Skrabec <jernej.skrabec@gmail.com> wrote:

> bus-r-cpucfg clock is important for peripheral which takes care for
> powering CPU cores on and off. Since this operation is done by firmware
> (TF-A), mark is as critical. That way Linux won't interfere with that
> clock.

Many thanks, makes sense. I hammered /sys/devices/system/cpu/cpu<x>/online
like a 1000 times in a random loop now, and it survived - after I excluded
CPU0 from this. Offlining CPU0 works, but it doesn't come back online
again. But that's probably something in TF-A, so nothing that affects this
patch:

> Fixes: 8cea339cfb81 ("clk: sunxi-ng: add support for the A523/T527 PRCM CCU")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
> index 70ce0ca0cb7d..c5b0d4a2e397 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
> @@ -125,7 +125,7 @@ static SUNXI_CCU_GATE_HW(bus_r_dma_clk, "bus-r-dma",
>  static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc",
>  			 &r_apb0_clk.common.hw, 0x20c, BIT(0), 0);
>  static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg",
> -			 &r_apb0_clk.common.hw, 0x22c, BIT(0), 0);
> +			 &r_apb0_clk.common.hw, 0x22c, BIT(0), CLK_IS_CRITICAL);
>  
>  static struct ccu_common *sun55i_a523_r_ccu_clks[] = {
>  	&r_ahb_clk.common,


