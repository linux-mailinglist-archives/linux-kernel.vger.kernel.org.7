Return-Path: <linux-kernel+bounces-865492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D87BFD482
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11401888731
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B95E2BF005;
	Wed, 22 Oct 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swVQIr8w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sb+bqavY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AF26FD97
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149993; cv=none; b=ncsYN6S04Qnggusapt6Krs5OZB+JFK1DnApSSVnqFehzff2om0q8hoLWpfTYIgTqF2dUdjChKssGhXdwrjePbFNqdrnUJBxhj/1MP9Jc2KHUln4TCtKFvwKk+JetDjKek3NZQP1jB9RZFWHB0mZ+ESuuaRc2DkaLHja6WmrRDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149993; c=relaxed/simple;
	bh=YamIwuRSsnp9InnGFIY7SZo7d7ggLTb5ADqaF8om17Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=futk37vu+sLG17i/VmiG8XeynAsgvcj4JMUqWR9LFcFuzrI+Ai0jeqlEJ25SdwFumFxntxyLW4NIx8YXlyhSII1PWme8KU3xVpfTPkOqlRGdZ6i2xo6SSgbePKYUHXOXHmvsOzii9KMhjceI1Rr6ZwJgyJZsG01LWraf13YjGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swVQIr8w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sb+bqavY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761149989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=intqF4X61TIVht9J2tEpEqsbVq3t7w7lHnZlS86PgTc=;
	b=swVQIr8wu2b/rrny7YMQdW+pRcDTldfu+/p5fWMusBFOBkuWnH3k3cKdFWkN9zEZQ9qTFa
	DZxBMQQsIP4jR31stuE+D2eD9b0dQ4stnNjaFXSMuTxSJFDyFZSGmnol/8kYmqyRLRwBf3
	cZKEShhumQ5YCCzHjRe8O1tV9THN0ob0u3OWn80jknQttl+q+5KTPf4X6L84tsBDlSPYeT
	5nbyLBngGckqsUHZjYs2lhL2M4ji2VEK23VQCmZfp5UFIgNmhYHKM7cFbZ1i+HC9ujz7rc
	9eQePIPZ/A0En0zrOxrGZ/WZLgMYJaFEHWzjBReHuuVHgTM8AMxX4VWxg5KLsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761149989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=intqF4X61TIVht9J2tEpEqsbVq3t7w7lHnZlS86PgTc=;
	b=Sb+bqavYPv6BKbF6HY770U1I6vDOwEq6kHTHXDwBromi/z7/vVmhgMSly9F2iQbx8W3wuV
	vUmR9ZDr0qBaCoAw==
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: [PATCH] irqchip/renesas-rzg2l: remove braces around single
 statement if block
In-Reply-To: <20251022073558.1992384-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251022073558.1992384-1-cosmin-gabriel.tanislav.xa@renesas.com>
Date: Wed, 22 Oct 2025 18:19:48 +0200
Message-ID: <87jz0mykm3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 22 2025 at 10:35, Cosmin Tanislav wrote:
> Braces around single statement if blocks are unnecessary, remove them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  drivers/irqchip/irq-renesas-rzg2l.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> index 1bf19deb02c4..6e215649bf29 100644
> --- a/drivers/irqchip/irq-renesas-rzg2l.c
> +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> @@ -555,10 +555,9 @@ static int rzg2l_irqc_common_probe(struct platform_device *pdev, struct device_n
>  		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
>  
>  	resetn = devm_reset_control_get_exclusive_deasserted(dev, NULL);
> -	if (IS_ERR(resetn)) {
> +	if (IS_ERR(resetn))
>  		return dev_err_probe(dev, PTR_ERR(resetn),
>  				     "failed to acquire deasserted reset: %d\n", ret);
> -	}

No. That's visual garbage and breaks the reading flow as the lack of
brackets indicates that there is a single line following after the if():

         if (cond)
         	foo();

is perfectly readable but

        if (cond)
                foo(................................,
                        ............................);

is not.

You are right, C does not require the brackets for the single
statement. But humans read in patterns and the expected pattern for a
if() or for() is that if it has no brackets then there follows a single
line statement. If that pattern is not there the reading flow is
disturbed.

Thanks,

        tglx

