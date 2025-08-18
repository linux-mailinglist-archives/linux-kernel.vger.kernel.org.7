Return-Path: <linux-kernel+bounces-773313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78A0B29E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310F97A8CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020CE30DECA;
	Mon, 18 Aug 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoDz7qfV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="47EHUOFG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EF1217716
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755509855; cv=none; b=WDRySmwFSuvvwRMJYdel1MNhYkH1BaNI1dBSFlbHmEoeBEhKkEd/Xawb3pdvGPDtwskbgfRIfBRHZhnWLseGZiSFiagj21qlyE35WpXqON/rNa3tvP1x1dX3hKVTwIRKRGeLZMwLZn8k7nT1aKxxvKI20eb0SHBk5cFgNm1QsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755509855; c=relaxed/simple;
	bh=U8pyLjNXdfZ8PcB+p+pyaTOX/TwfKNup+TaLG5+Vnd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XumMAWhHM/NIWhNzSl/b43T/MRGcI12vkJvIgKHxz8KkrHwxG+0vxMI7ZBqSzdhMF5J1a4Arc+vZ/Do+xl/3BRGF/2O5mZ5SOpbMxGtH1BbNDyRSm4XEmHr1Nbl4mrh2d2hKpdLptxIcPXZ0irXFRLAaZQWl2fITS+aOiKii7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zoDz7qfV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=47EHUOFG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 11:37:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755509852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f72dzrk30Kvy10blES1ypXW/eSdngD8YGITCYhBYHvk=;
	b=zoDz7qfVqUEUCGkrjO1N//HYEbClwbOroyHQa6Rq2W8Lap5OdZBclxG2AQmUwJ5IEv1cqq
	XIftcWJBU7yjbXOaAO998R8gIA9SBjFimypbEhDTBRwnAspoIHAG2K+hzxnhJX9ZQZ7pqR
	Zio7EUjy2lorog6v8HT8/cyjoq4dZZbpbAlX6o1H1by5lva3MCg38MkkF7y/qnfJFJePqk
	DCG3GGUuTIlu7O2czD48lS/aBaoZvYriEKZm3YhlnO82cHBLP3Ruqpm3ofcoSDItof3R47
	F0wlO4uHTz/d1O2dBjdgBJ/cQ5Sh9b8ZntX5eOku2GeY02e5xEmKz0hWqfrpRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755509852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f72dzrk30Kvy10blES1ypXW/eSdngD8YGITCYhBYHvk=;
	b=47EHUOFG2niyb3wGJAls7L3RXTWpCMoZ1uZLW+EVQTGuybBVP4/rzqHwDZ7hU+s2iEowTw
	3D1AR/fJP0zvvXAA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>,
	"<cperciva@tarsnap.com>" <cperciva@tarsnap.com>
Subject: Re: [PATCH v2] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <aKL0WlA4wIU8l9RT@lx-t490>
References: <140183ef0ad52cf0f5f892409d362f1ed09129f3.camel@infradead.org>
 <aJ4YnmxWspw1bb-1@lx-t490>
 <203725e3355d04b0ae6df383481e67636d116b65.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <203725e3355d04b0ae6df383481e67636d116b65.camel@infradead.org>

On Fri, 15 Aug 2025, David Woodhouse wrote:
>
> Or just not, in the case of jailhouse and bhyve? Since cpuid_feature()
> is hard-coded to true for x86_64 anyway, and they both depend on that
> (like acrn, which already only checks for X86_FEATURE_HYPERVISOR).
>
> And anyway, how is X86_FEATURE_HYPERVISOR even going to get set if
> there's no CPUID? Can that happen?
>

Correct, these early-boot feature detection code paths are all already
messed up.  I will clean them as part of the CPUID parser work.

For example, in the CPUID parser patch queue next iteration (v5),
X86_FEATURE flags are integrated.  There's also a Directed Acylic Graph
of X86_FEATURE and CPUID bits dependencies.

So, in the above case, the dependencies table will just have:

    X86_FEATURE_HYPERVISOR ► X86_FEATURE_CPUID (and whatever else)

and all the circles of x86 vendor checking, CPUID max level checking,
other CPUID-bits checking, X86_FEATURE dependency checking, etc. will all
be removed from call sites.

I will show more of that at LPC Japan x86 track, and hopefully much
before that the CPUID parser v5 shall also be already posted to LKML.

Thanks!
Ahmed

