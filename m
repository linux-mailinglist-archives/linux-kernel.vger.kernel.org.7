Return-Path: <linux-kernel+bounces-720291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F98AFB9C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216F642086C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570892957C1;
	Mon,  7 Jul 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C0biudtz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+jCCVgf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D2622127A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909010; cv=none; b=sgk9IMhXBMnHlZNEELEtSJH0DNQzvKLAkttOYTzKKlwfmAAQclog52QzXHyZ0gyXSSgJTuN973GRWanjeNRwi74FHrAxLzEBCKsulFZMPl6hV53ioy4VVimsEZjSfBHmOaT9jchgM27J7nIO16z9uk8LrlCdYBknkbaGOuERPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909010; c=relaxed/simple;
	bh=shcKHc7pDwYRvBuVdbR42bhz6I4pw+wvKvc4dA1CSKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzPpDnXtpPP83d3Y2Qt+XILgIxsJRt+tdomALHlZeCRJXbOG2ju/iK82+n6dzfI7m6t7AxzezWkOTDYQyJKKGCbmxmERHYIAVmFHNeqygZb9TyxbbEzXtD3MF7vEuRpifWRuMHJPmX8NQE5Dc0Ekr1dqTPxDP4Q2V/2K1bmoc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C0biudtz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+jCCVgf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Jul 2025 19:23:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751909007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shcKHc7pDwYRvBuVdbR42bhz6I4pw+wvKvc4dA1CSKY=;
	b=C0biudtzAKlLKQpodPRiFC1EusItzcJ/9keBzf3otsh70Az+2Sk1T+Z5WQEsO+a0VCIZOz
	AXTYu6uiplE9rAsR69IwHadk5C5R+dh/kjSCqLCYVaHcpIwLaULZJ0EbFjicDoDiiAnnhr
	gI+V2NE6+hB2eSSTtRNLZlkoaS9yYqK+AoLoC7Uz3NfGcZmKb8KlFlaG8BKAl4NkY4NKIr
	ywAEN0z375ABXZGLMqebEQf4Q9sJk/7T5sKtYOlxaNcQOsflInm9T17ni1PEe2wS2+PVO0
	oCWM2AdLyc8gu3SRODUARL1bYbKGx9jiwfgiIP5gpuIPVw8o+y8ssf76Gq8Ncg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751909007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=shcKHc7pDwYRvBuVdbR42bhz6I4pw+wvKvc4dA1CSKY=;
	b=M+jCCVgfOE/06uOracm7Bl2XFp/xkod0O5M0Gd4ntpCP9io/k9zqmZVVSA0UsBKcM2nxer
	FHyIo69oKe2NyVAw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 16/44] thermal: intel: Reorder headers alphabetically
Message-ID: <aGwCjRU6d9A-kva1@lx-t490>
References: <20250612234010.572636-1-darwi@linutronix.de>
 <20250612234010.572636-17-darwi@linutronix.de>
 <20250704113421.GNaGe8PbALdikAapIf@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704113421.GNaGe8PbALdikAapIf@fat_crate.local>

On Fri, 04 Jul 2025, Borislav Petkov wrote:
>
> Can we merge all those silly includes sorting patches into a single,
> per-topic or per-tree patch respectively please?
>
> A single includes sorting patch is fine too since the whole pile will
> go through tip eventually.
>

Sure, will do.

