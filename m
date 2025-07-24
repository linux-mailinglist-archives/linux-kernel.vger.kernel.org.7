Return-Path: <linux-kernel+bounces-744147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFCDB1089C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672DAAA7C02
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444C26C3B7;
	Thu, 24 Jul 2025 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0sE8+P2u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ifIUJ/+K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685C26C3B0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355266; cv=none; b=SgF4Qh+RyQLNF0HGOgD+kcF3/LTb4uR4Utl9uir4+/FX8zJK+gJJKGS34rw2yLaLTn6Mbu/ZWTrKOjEhA8QuupSA6xijcyVmlWxG9/nH6UZeWHLAo2kitpmVzfM0bpPq/Xk7IzsJcZdyuVr05HEmO2RPJ3Nz/mvfPuTPSZ60kwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355266; c=relaxed/simple;
	bh=xnI3QorywOy9KZMfDrec4KbFn6tNBP5ylkYVGoqAqxk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TE8srmg112kbiqc+AAzDU1D0TLIJzYLEJ2ZNGDJHPn9gwTMcSEAlb2gTciHWH6OL0m/UNz6JTQM1sqc9ChGhJ0PkCqDfDylQ3dKdauIyLIbpz89fohq0wdygnlnNLTbW9fsv0q1c79FGfsVL/i/jsSoj4b81Qa6FM7dU+lGdJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0sE8+P2u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ifIUJ/+K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753355262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBmlz/tE0sk4BQMl3n36iswZBzHHerXTaBwPYrP9GGc=;
	b=0sE8+P2uUm0RuWh7qMeLjThuosVC6sq2Ct0pd12a++IZDdpqOg+bDo1d9yAwYinmqzJIsc
	2WW6qHDIOxMU+VLFF41ZgtkKZOClJkzF80VW9p31oMD/9j/Uia88Rw/ltGaxSzQU1ARhvi
	G6YvKfFSITgWk8ghUAgn5HYGJs8jQsIIHDjxRL08YnXMEBfv5RKlYoPWkQaf3RkmQ5twUB
	pbOQvqVbiBq3zrhb2xy5r1kDD2h1LNJSftQQjo2uk6c/3TRcS1n7HQc/G5d7D/y5lyxT+s
	JJqElAj6/YK2hB7WSf8iUxmajwN6H/IVcRipV3sJiebC3+UQkNZgKYOYIbaNwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753355262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBmlz/tE0sk4BQMl3n36iswZBzHHerXTaBwPYrP9GGc=;
	b=ifIUJ/+K1zVsSW0PemdZE9Dw9u0dTdc2z2aV7idcp1v26nxZFnlRMcO9tuwgwRzpp30Tq6
	PJ99N6g0NCCl8uCw==
To: Inochi Amaoto <inochiama@gmail.com>, Inochi Amaoto
 <inochiama@gmail.com>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>, Nam Cao
 <namcao@linutronix.de>
Subject: Re: Affinity setting problem for emulated MSI on PLIC
In-Reply-To: <re3qxwkm3lu7o77kyfswwennqvtpyonlj4zajt5eu7z5zwkosr@mwacqq6bpbk4>
References: <20250722224513.22125-1-inochiama@gmail.com>
 <87tt32r082.ffs@tglx>
 <re3qxwkm3lu7o77kyfswwennqvtpyonlj4zajt5eu7z5zwkosr@mwacqq6bpbk4>
Date: Thu, 24 Jul 2025 13:07:41 +0200
Message-ID: <87frelrgn6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 24 2025 at 09:34, Inochi Amaoto wrote:
> On Thu, Jul 24, 2025 at 12:50:05AM +0200, Thomas Gleixner wrote:
>> May I ask the obvious question:
>> 
>>     How did this obviously disfunctional driver gain Tested-by and other
>>     relevant tags?
>
> I think the SG2042 pci driver does not support affinity setting, so it
> is ignored. But the detail thing I will cc Chen Wang. I guess he can give
> some details.

It does not matter whether the PCI part supports it or not.

PLIC definitely supports it and if the routing entry is not set up, then
there is no way that an interrupt is delivered. As the routing entry
write is delayed on startup until irq_enable() is invoked, this never
happens because of PCI/MSI not having a irq_enable() callback.

> For SG2044, I have tested at old version and it worked when submitting.
> And I guess it is because the commit [1], which remove the irq_set_affinity.
>
> [1] https://lore.kernel.org/r/20240723132958.41320-6-marek.vasut+renesas@mailbox.org
>
> IIRC, the worked version I tested has no affinity set and all irqs
> are routed to 0, which is different from the behavior now. Another

That does not make any sense. What sets the routing entry for CPU0?

This really needs a coherent explanation. Works by chance is not an
explanation at all :)

Thanks,

        tglx

