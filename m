Return-Path: <linux-kernel+bounces-880960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F3C270D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A071890566
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D722E426B;
	Fri, 31 Oct 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7wYv5oJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pzJjMn2O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2307C2D8362
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946377; cv=none; b=l9UA0KzZtdEyxqdBz4vC8BGKB1Hr3/l8kBiXVz4Z7BSS5SKo/77HLRu2yyIhs8rmSpKxEuASLO+cCbkI4/LaNRy/C77vtLtxPoh2wqHXA+tZqpMgIS/KXB+0XVSekRQLdiVLvCoflnV8e2CSLQIH5gNKprwDl8bw83ckI674Cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946377; c=relaxed/simple;
	bh=3jcCB8/EkZPfz7coyBYWsShFlwvNE2phWmXKkqmYyoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amZX/ACmY3tsPvQYv40VqOqB1f7kC2jHXLRQfzIpqX4Zr75IiEZrw9abJnfxODSoFX1TvKx2OSY93ulB+TFKamx6VgkbtpEVgWrD++nG+zGBAeWq0kZ6E3tRFKj121qZqjBAiYshTgizo4gouExbn5AMlX36gB+Mbm1qOjaBjbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7wYv5oJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pzJjMn2O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761946373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73A5YyJdt58GaQCs7MXkkXB1WngwQ/eBfsUfjTWrvnk=;
	b=O7wYv5oJq1h7dE26GIu2j81t/YNiR0MJAjptP1kv8ZonMUfBy8eOQAclPrnVjWsx76k73L
	/0qix1LVjtxzoSAsdI+k3xuRklgUXv6wGEcT6I3TWYSlVy0w5sLEq1HhYcqloXJ4uj0mA2
	bXnLfVAAKCjdkqmcjpIUrTds4Ul/bOTzda7xKZbZTRYElVucwTZDOntn2MH6Dd0aKHhj7M
	VuH7urFOZSvQrvqFjY2e2ddmwFBPNIYHiM+pB3dZlLeeCJFTapypGKH8C8UDxHNG7Addtb
	BZwHpuPhbGuxK/YcyXU854paEJ4z4GBWZO4UATiBIgPNV2j0UI5xJRu9m5Es7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761946373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73A5YyJdt58GaQCs7MXkkXB1WngwQ/eBfsUfjTWrvnk=;
	b=pzJjMn2OwJPgc4jUGKphIkDCS2aXhq5St61jCoWQQg0AWQuSu5zcdPJ3ALedcbBok2UzsQ
	q1nbdR6C9ao06SCQ==
To: Charles Mirabile <cmirabil@redhat.com>, lkp@intel.com
Cc: cmirabil@redhat.com, linux-kernel@vger.kernel.org, lzampier@redhat.com,
 oe-kbuild-all@lists.linux.dev, x86@kernel.org
Subject: Re: [tip:irq/drivers 22/22]
 drivers/irqchip/irq-sifive-plic.c:590:55: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
In-Reply-To: <20251027174725.1014197-1-cmirabil@redhat.com>
References: <202510271316.AQM7gCCy-lkp@intel.com>
 <20251027174725.1014197-1-cmirabil@redhat.com>
Date: Fri, 31 Oct 2025 22:32:52 +0100
Message-ID: <87346ysqnv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 27 2025 at 13:47, Charles Mirabile wrote:
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 9c4af7d58846..fbf7378899d3 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -590,12 +590,12 @@ static int plic_probe(struct fwnode_handle *fwnode)
>  		if (parent_hwirq != RV_IRQ_EXT) {
>  			/* Disable S-mode enable bits if running in M-mode. */
>  			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
> -				void __iomem *enable_base = priv->regs +
> +				u32 __iomem *enable_base = priv->regs +
>  					CONTEXT_ENABLE_BASE +
>  					i * CONTEXT_ENABLE_SIZE;
>  
> -				for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> -					__plic_toggle(enable_base, hwirq, 0);
> +				for (int j = 0; j <= nr_irqs / 32; j++)
> +					writel(0, enable_base + j);
>  			}
>  			continue;
>  		}

Care to send a proper patch for that?

