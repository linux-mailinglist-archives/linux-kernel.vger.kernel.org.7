Return-Path: <linux-kernel+bounces-802902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1157CB45836
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A3297B62CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D596D350841;
	Fri,  5 Sep 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2o5/iH2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogx135m7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DD1F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076775; cv=none; b=BNGdZR4Q7dydqjlJlL2hnRYED1vF9vsCn6M9VHECRiM+OFcjTI8Q+tOwOnZyWxGU7kv4UZpkHjcTWBGYHfitjw6ho/APnhrUggQIJ3IjOadQOGT+4si4EhGREGxD1v4q9UyIxHKIf57jBI6KH2R/uwP1QAFFo5rSAKPllkEjqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076775; c=relaxed/simple;
	bh=HrvpACs1oMKeFysVw6yI8wCdTj2DLNW/qfnhINHCmok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBtg1uqd6+VdGn0a0POO7HiZyo1D2Qg6qQNZoFJ528Bo5vWPIXUT89sgNj4dZ1xpKwO1ccrq7IIVQuseywCaeif7hlypEQaNVPo7Qo2I462cfEATtjZoLdk0DrBXHdtresuvhQnFvZ7b6RsPFUKtW5zN3R9JvjgYLwO08BWVKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f2o5/iH2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogx135m7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 5 Sep 2025 14:52:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757076772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKV0VWkKbySLx0qTVzDRSCPQE+a1XtaRNvsZgELcJz0=;
	b=f2o5/iH2UHzKpVzlMiQm8ZhRYkZbKP7IYOVA+KJGFgMehPWL5eXhNoKUOsZAy2udZ4EPEm
	8XoZ78YQq0/IG3wgHwb/ZdvK66w6DW3wjAx9chLegFevruJH3M79BExyRwBG6IqvRZ91dP
	Z6ZzSzrgJrlNCfecterrLfCiX8/wKDW+1yhGolF7GPJv88QDy1Gp2JjbdmlKL/KRRvHHBs
	ykQJqIINpY5NL5p+4s0mFwLH32V54NyZVkzQprbHxNYZM7hudV6qvBUvCykxjrwdJ4h30w
	lNssfOo5JxbaDlfbCfvlIBpY94C7EV2JVp8BjomfIo06ukaIpz669Wf83RcjZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757076772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKV0VWkKbySLx0qTVzDRSCPQE+a1XtaRNvsZgELcJz0=;
	b=ogx135m7sbOJF3sTVMPC12/qkgSVnezYWUGm0lgH3GqXfnKloD5HQFyLfRyZVZiGam3dFA
	mHLxarRzyLx4sABg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/35] x86: Introduce a centralized CPUID data model
Message-ID: <aLrdImDdg5utz2ZF@lx-t490>
References: <20250905121515.192792-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905121515.192792-1-darwi@linutronix.de>

Hi,

On Fri, 05 Sep 2025, Ahmed S. Darwish wrote:
>
>     /*
>      * Compile-time failure: Requested subleaf > max dynamic subleaf
>      * CPUID(0xd).n, n > 62
>      */
>
>     cpuid_subleaf_n(&boot_cpu_data, 0xd, 63);
>

Sorry, this actually is:

    /*
     * Compile-time failure: Requested subleaf > max dynamic subleaf
     * CPUID(0xd).n, n > 63
     */

    cpuid_subleaf_n(&boot_cpu_data, 0xd, 64);

which is the correct thing, as per the Intel SDM manuals: n <= 63.

That false upper-bound snippet was a left over from a previous cover
letter draft.  That is, before the x86-cpuid-db commit:

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db/-/commit/f3d9bc48b4a

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH

