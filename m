Return-Path: <linux-kernel+bounces-749369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B492B14D76
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0443B0B07
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752628FABA;
	Tue, 29 Jul 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtH1wAm4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CODkKN93"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301C228FAAB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791059; cv=none; b=twnCib5Kvcz+0xzuIf3PYsXfHK7FEesGQB3PgcRxWEwkEX+ev1i9psLkgQUAWsDz6BrS4VFG0nkbfNHiG2iS7n/rjuZ/c0CWnQQO0Qk3x742nkeLbtnM74AONcDjbpiiRz6DUe0wSXVlAW/0t05wY6Dw+0BAuuHmgWzDkS7/3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791059; c=relaxed/simple;
	bh=W8L0uPruHr4XIGrI0YQHff76y24TTJjFzgAHx77mudQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1I6d1Ui3uqQOIcLMbhPBbss1gZZ3Nnc9HZ5kiztXTjcgL7SzX29TqN3NCgwoCb1FFDc45dQ0oFSj2y1wJMuNrelrsI+X7Xky1tFreY9PHWfU7zyTx92bu89sAWMB3XoldVYoW3WBoAlGVQJLijlFej3OJCEjMy5a4xv95wRzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtH1wAm4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CODkKN93; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753791055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJTOrfSboZ5kBnfTci5EHjzBUJIqW0Jji9p+5UbooMI=;
	b=vtH1wAm4o8ZwzxxHLKO8cxIM67H/br7RGJ8TODVhx6Bp7jAJV2cT73RtIebTma5fuwuRuc
	2Odr3BPEGTYZO4CVCJYPIYFKSfzwsFaKUOkxmioZPMAd9LCaLo2mYRlTeuWhhGQwHiAHN2
	+rV28pGPY42N+SI1Hz6UAMxV2Eg3lW9qnNHRZlxPGEZZjKDJfd4e29ioN/2eDVy1ONZn21
	sUMouBnZYgTWFwFb0zXmBSnjjUld/Mdl7mOSjiRTkbCN+72blr7sSGusl/hN/vonNBY9QR
	M74EGGApj2FnieVBV5cqpvgitt4NaQjSK2v5dbZflUibqZZaRA7Rd+KYUrnhLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753791055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJTOrfSboZ5kBnfTci5EHjzBUJIqW0Jji9p+5UbooMI=;
	b=CODkKN93nKbR4BkRAHJ60sfY22CZ5gfznf78OK/QMCyHUOTixYw9DOEdo0kdo7yWfIHLVQ
	r58CG5qkBWbO+KAw==
To: enachman@marvell.com, andrew@lunn.ch, gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: enachman@marvell.com
Subject: Re: [PATCH] irqchip/mvebu-gicp: clear pending irqs on init
In-Reply-To: <20250729084826.3222785-1-enachman@marvell.com>
References: <20250729084826.3222785-1-enachman@marvell.com>
Date: Tue, 29 Jul 2025 14:10:54 +0200
Message-ID: <87ldo7jiy9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 29 2025 at 11:48, enachman@marvell.com wrote:
> From: Elad Nachman <enachman@marvell.com>
>
> For kexec case, left interrupt might generate spurious
> interrupts in various A7/A8/CN913x interrupt system
> from the I/O SB to the NB.

That's a lot of incomprehensible acronyms. Is any of that relevant for
understanding the problem?

What's a 'left' interrupt?

Just say something like this:

  When a kexec'ed kernel boots up, there might be stale unhandled
  interrupts pending in the interrupt controller. These are delivered as
  spurious interrupts once the boot CPU enables interrupts.

That's clear and sufficient, no?

> Clear all pending interrupts
> when the driver is initialized to prevent these spurious
> interrupts.

> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/irqchip/irq-mvebu-gicp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
> index d3232d6d8dce..0fa21a45d4e1 100644
> --- a/drivers/irqchip/irq-mvebu-gicp.c
> +++ b/drivers/irqchip/irq-mvebu-gicp.c
> @@ -31,6 +31,7 @@ struct mvebu_gicp_spi_range {
>  
>  struct mvebu_gicp {
>  	struct mvebu_gicp_spi_range *spi_ranges;
> +	void __iomem *base;

Why?

>  	unsigned int spi_ranges_cnt;
>  	unsigned int spi_cnt;
>  	unsigned long *spi_bitmap;
> @@ -236,6 +237,14 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	gicp->base = devm_platform_ioremap_resource(pdev, 0);

There is no reason to create a permanent mapping, which is not used
anywhere else. Just map, write, unmap.

> +	if (IS_ERR(gicp->base))
> +		dev_err(&pdev->dev, "gicp - Cannot ioremap !\n");

So this emits a unspecific error message and then happily
continues. That does not make sense.

As the ioremap failure is not fatal, tell the user what this is about,
i.e. "ioremap() failed. Unable to clear pending interrupts."
or something to that effect.

> +	else {

Lacks parenthesis on the if clause for symmetry.

> +		for (i = 0; i < 64; i++)
> +			writel(i, gicp->base + GICP_CLRSPI_NSR_OFFSET);
> +	}
> +
>  	return msi_create_parent_irq_domain(&info, &gicp_msi_parent_ops) ? 0 : -ENOMEM;
>  }

Thanks,

        tglx

