Return-Path: <linux-kernel+bounces-889903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AABC3ECCB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CE6234B877
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F72A30E83A;
	Fri,  7 Nov 2025 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OlIJKMME"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98130E0E2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762501510; cv=none; b=RRZBU8BcObBWZ9f77uGRpiCOkSDnGkbsTQbrcLrhDbNJK4M5Sh7+BBSKRuXklETnPnj3oEOm7OaDHBlb7TdyGHaGphF+K7UTKpXLAU5PUOkoBXA1JOJJscmWTgikM0vGg8jzDFlAHDWkEnnwZMqVqDzsjMvgsoNkpIItZ5PrtAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762501510; c=relaxed/simple;
	bh=Jy3BeTYOT36TAM8NXPaFdaGU0pmDhojDJJ5xupPvs9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So1BL2G2JjSTaQK9CaURcFyP1W4VHOJH38x6wVBdFI0S5m59npdwDTdwdOGiOn+Ms6wlBAUVy1Cq1AoFZAyjK2aJNef0rT3VXmlE8GgTLHf/o1cLWta1vq6BHtjNooalorhh5kqlM11OFfiOwYCIcXo+rTcI16k8M0oiuzEZAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OlIJKMME; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Nov 2025 15:44:45 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762501496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uaudMcICTPYCbrIDLJ6pWwstd0WXrj4u5ZUrEhHCE6M=;
	b=OlIJKMMESAjS+E2P6FtTJSqR19t+pmejvIKUVOqCUfUhtQdGzJfxklCl7waOGIWx8+bE0R
	1P8XUF/tf+ttLYHqD/tk253Zc3cdYkpEMtlxCsbr0vIhZnvQuADq01cak7xQc7B01TCV3g
	lWXpKR0jamS0ns+rGbNCTHjHWObxpp8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Troy Mitchell <troy.mitchell@linux.dev>
To: dongxuyang@eswincomputing.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Troy Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH v7 2/2] clock: eswin: Add eic7700 clock driver
Message-ID: <aQ2jbf2k3rwOZDuB@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <20251023071814.568-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071814.568-1-dongxuyang@eswincomputing.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 23, 2025 at 03:18:14PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> Add clock drivers for the EIC7700 SoC. The clock controller on the ESWIN
> EIC7700 provides various clocks to different IP blocks within the SoC.
> 
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
[...]
> diff --git a/drivers/clk/eswin/Kconfig b/drivers/clk/eswin/Kconfig
> new file mode 100644
> index 000000000000..9bc9008d3156
> --- /dev/null
> +++ b/drivers/clk/eswin/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config COMMON_CLK_ESWIN
> +	bool
> +
> +config COMMON_CLK_EIC7700
> +	bool "EIC7700 Clock Driver"
We can't build this driver as module?
If no, see here: https://lore.kernel.org/all/Z%2FlN7qrISpbK6MQY@goko-w.tailce6c49.ts.net/

> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	select COMMON_CLK_ESWIN
> +	default ARCH_ESWIN
> +	help
> +	  This driver provides support for clock controller on ESWIN EIC7700
> +	  SoC. The clock controller can generates and supplies clock to various
> +	  peripherals within the SoC.
> +	  Say yes here to support the clock controller on the EIC7700 SoC.
[...]
> diff --git a/drivers/clk/eswin/clk-eic7700.c b/drivers/clk/eswin/clk-eic7700.c
Can you give us a clock-tree img or pdf?

                        - Troy

