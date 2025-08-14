Return-Path: <linux-kernel+bounces-769350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61423B26D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F1C165663
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B646C21256F;
	Thu, 14 Aug 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqkZOyPj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lT3/PRpv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95A1EB5FD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191460; cv=none; b=iGKAJZwrlf/88P3bsuRgCmcTBof5npsreyk/bCWZgSvgCIEqfzWC1BNonXSiQS/FnHBuTB0xSveYgocyc7hjxEgm3F6QeoWjnZk9ZTIOpUKCELeEsauKcMin+hRHfxWB455nU/RPCsttxTyjNbnOC+RA/tV9drSwHj7VfRwEkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191460; c=relaxed/simple;
	bh=550onVgFRw0/Q/X5fla3S9NRQ61rV59Lg0nfJVwpQdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vja5rxJpKnR98h7zt7FirILHXlc5VUg+1O9xLbGqzbacgUh0c4EQQpKlhvsjg4zfR7x+J2hHU9NixvmoHgJnBOV3oL/4zDvJ/f9rxamPllhtEB9pcLQBdQfpPAwLJYXpziACmQPNekrC2RqfGxGpgkkXDSJNgJSwZoJXTb+7k2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqkZOyPj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lT3/PRpv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Aug 2025 19:10:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755191456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSPuE0qqUtgD/ltrE16mUC6QPPWglETWqRrWz9tf6b0=;
	b=fqkZOyPjHu2D9TEUo+nuCJUECZ+JAx0d+oUMKC+27Y7wJnMowwWI71dQMVPWZ/3SHQ+vsf
	wzyVde0DP/tmzMARnb9YqrmAr12ZPySHWkXDGm8SxkzpcPhH5SVXlKAhH7oWMK7MT5iIwe
	rMp13FJhRH6y5LL8w+7AWL5FNfQViqScH8MQptU0+Gu3S9mSj3NE9CxEYly7Cjcj35bLMR
	snCJc7zG+8nFgdgDaNMtLvI39jYTXzB6qlp/CZy+8cire8KbMPZszC5tUrRd21Sz8Vm7pL
	UEdJGyL7b+bHiF87XsnJ0iBHLpr9DoyErQ7Qqen8Z1eW9o9RLZF0HA9Q1CwkFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755191456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSPuE0qqUtgD/ltrE16mUC6QPPWglETWqRrWz9tf6b0=;
	b=lT3/PRpva+2FgcuGPHE4p8HTHHiEje0bUslTJ2Z/t+oo6bni5kJPdrumvRSr+gEsGPFv8j
	0q4H/npYt582SBCg==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>, linux-kernel@vger.kernel.org,
	Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>,
	"<cperciva@tarsnap.com>" <cperciva@tarsnap.com>
Subject: Re: [PATCH v2] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <aJ4YnmxWspw1bb-1@lx-t490>
References: <140183ef0ad52cf0f5f892409d362f1ed09129f3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140183ef0ad52cf0f5f892409d362f1ed09129f3.camel@infradead.org>

On Thu, 14 Aug 2025, David Woodhouse wrote:
>
> +static uint32_t __init bhyve_detect(void)
> +{
> +	if (boot_cpu_data.cpuid_level < 0 ||
> ...

The CPUID API at <asm/cpuid/api.h> provides a cpuid_feature() macro for
this.  Let's please use that instead.

I understand that arch/x86/kernel/kvm.c and arch/x86/kernel/jailhouse.c
does a similar "cpuid_level < 0" check, but they should also be using
cpuid_feature() instead.

Thanks!
Ahmed

