Return-Path: <linux-kernel+bounces-861462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C19A3BF2CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87EF64FA747
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42633321CD;
	Mon, 20 Oct 2025 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y+d2pJ0Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFYwm7eY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49026B755
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982300; cv=none; b=DXDehWeVpMBHzFar/HLyDbRSzHDI2oIlGxMs3jrn5bXAlfLD5oM/BZ9X6leTv6SEsXQLtiT9tl6jAm2yu9ZqSbd0nxCUUWRAYTmxOU8ZDDRAIRo7YSepyXPzWwtIt7s/DsRaebGWTcW/PeYwYdq4noS08vmkjSqR1elWUiWY4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982300; c=relaxed/simple;
	bh=w5/OlzW9N66DcpypHR1C7SYDx1S2cEIE5LQRdH+OqXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Efe4dlJNst44WjjdWRl87kiGnnCzQClHb24WbbbN5HgvBZGxhMjHplJtNBk4Ly0t2GkE7ShDrN7JWTS/sZiXbxliWszj/jGhIyVQmZ2Cmsp0fDxZ/1g2uRsk/vSHvKL58ojdpu0h4Z0+C+779Fy2BkOnPtA5cLJ7WJCF11eF/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y+d2pJ0Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFYwm7eY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760982296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5nLyOLxW/yZHAWixRniPvYdKNsJsg26FMrw+1O2HHQ=;
	b=y+d2pJ0ZdEqudmxQCJZi43gDWG7GBPQuOF2BgYQSmyQI/iSouL601cj4GbfGHGp4wlYyAz
	tSbzx+0di4OZKfmRzvI40dyQmYJaklm9QhhPpnbiHO5hfxHvkCExHWe8EkO+S6ag3jPzYC
	B06MBMsud1Zem1+lNIpd99KlcH3ktOXsoBW+o0uArrTBw42YmJK2GOPKBd5Lhh26MkFUhj
	N7KSU7IOLpj59ZEKCvTWGyTYOOjVhVvXWfM8+4McYFvA8gIZOSenZv/HVrUtFUj/Gmg95Z
	e3uGlHtb3CGV1amdoX+7OUAM1usBpP+ZR7/DTm/bDoQd352nAYP8IB8YFZVdLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760982296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5nLyOLxW/yZHAWixRniPvYdKNsJsg26FMrw+1O2HHQ=;
	b=GFYwm7eY7qOlZEbF48OLPgnfFsyAlxEg/Nkxo/hWMQgnXWjR+Ra52dR2A/eSzQmJ38jIrj
	HUHuepe36hYeWvBA==
To: Troy Mitchell <troy.mitchell@linux.dev>, Paul Walmsley <pjw@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Troy
 Mitchell <troy.mitchell@linux.dev>
Subject: Re: [PATCH] irqchip/sifive-plic: use hartid as context_id in OF to
 fix AMP conflicts
In-Reply-To: <20251020-fix-plic-amp-v1-1-defe2a99ab80@linux.dev>
References: <20251020-fix-plic-amp-v1-1-defe2a99ab80@linux.dev>
Date: Mon, 20 Oct 2025 19:44:55 +0200
Message-ID: <87bjm1zcvc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 20 2025 at 11:49, Troy Mitchell wrote:
> In asymmetric multi-processing (AMP) scenarios, the original PLIC
> driver used the context loop index 'i' as context_id for OF (device

Which original driver and when did it stop to use the context loop index?

> tree) platforms. This caused multiple contexts from different harts
> (e.g., core0 and core4) to share the same enable_base, leading to
> conflicts when initializing the PLIC.

When did it stop to cause the issues? And if the issues have been
already resolved, what is this patch about?

> This patch resolves enable_base conflicts on AMP platforms while

# git grep 'This patch' Documentation/process/

> maintaining SMP/UP behavior.

There is zero explanation what this patch does to resolve the issue.

See also:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog

>  
>  		if (is_of_node(fwnode)) {
> -			context_id = i;
> +			context_id = hartid * 2 + i % 2;

This is incomprehensible and will cause head scratching 6 weeks down the
road. This needs a proper comment with an explanation what this is
about and why it is correct under all circumstances.

Thanks,

        tglx

