Return-Path: <linux-kernel+bounces-788116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D2B37FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67641BA0541
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F9F32142E;
	Wed, 27 Aug 2025 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LtOYIozz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668623D7EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756290500; cv=none; b=CViRE0dD3nuyVOD+zu/tBCa8r0OyUghwRAmpWPSeAQQdWmjQXafTZONq9lvjfq+LBwBcinYHsRJxoYew6rfiHHGQ1v793FyxqBsyXFtpx0PRbQwH4gLHcAc/fB5SLKov7GVRxjfdERrPWHheyt9FJ4xfMaqNA1vrvYf2NDn+7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756290500; c=relaxed/simple;
	bh=QMfdyW0Tj/41W/n1KlVYnfo3C6Y2Fg3z/l5AR3MOWic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtqvFdmgqxDb3ea5eE73itE3KXPpcW9jOuJbJxs1JpdrYP0cS9w33E0ogNAB0mstx35Gj+n6RQxmvxnCV10sOPUYhR1HorlyUFMRk+zxy4GNomUT4jP7lb/lDNxYi2or9sbgcPItfggIxae5zTZxWaXVNuj41oVte1IfHpEBtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LtOYIozz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 946C940E027E;
	Wed, 27 Aug 2025 10:28:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uTWiGkXjtnvK; Wed, 27 Aug 2025 10:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756290490; bh=kZ9aQG6LBoyKemdQhaejIiPClOZCjpkZ40Q+ynxDu3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LtOYIozzW1oO+CDWaPHEfn2BVC5yAwkBOUCwnW2a+r+EhiKHK97tHSTFRL3q+VMWL
	 ZL3ckaL5W8jiE2MIneM25NyCE/mTIfYYm6MK15hkkd2blEKOXae6eDTD/d+Sn+WRrc
	 lpJMUxmQeQ8TwvfUmJOjfOjj7lDUczkuNGfNEuE09jMwoix+rlHKBxL5Z1+oUDDKVT
	 LLy8w/p6ZAAP5MUIg912dIBee26SKgM3yp9DIjpN4tmHid/zTKP8JU/PKYVRPGL4Xx
	 V1COe9INKElzOhPLdIQSUJmfHSnCc1l9346amlhFqrIUimmSSxNEKxhdG36jTXlie8
	 DvqMACViYL7ajyFqL9G6g+0FTtagAnl64xkb4ovQi6TacNBQ8P2CcGLEcMVrlRrFXD
	 4wqQoBdKLBsZi4QgG2qeDjcdbP3p0Jq6v8JYGeYXnJj65dg9VXXfBzosO0d1rC4BoM
	 TiB+UgaBLgGJAiAC7yaHdTr+sPgdZJrgtVBW9c7Gr9rGqXBgajdkY1i0T9z+mgkNI9
	 cvhIpVp4DX8pwatWpubYwqrgVO1vUjHRgsXV0j5UQ4O1ck+tS6YHWm5MADF1wuUkZt
	 de/0Pr7JBPPJXJxl8f+fonRh01XIFnZ3SbbdkNe5Ctv0MjoWuq391XaXqgILFIiZ+X
	 A5XR8/N0N0X9DeE2VNlLFwMM=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2AC6640E0185;
	Wed, 27 Aug 2025 10:28:00 +0000 (UTC)
Date: Wed, 27 Aug 2025 12:27:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Message-ID: <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>

On Wed, Aug 20, 2025 at 11:17:23PM -0700, Pawan Gupta wrote:
> On Tue, Aug 19, 2025 at 02:21:59PM -0500, David Kaplan wrote:
> > @@ -2646,11 +2650,18 @@ early_param("spec_store_bypass_disable", ssb_parse_cmdline);
> >  
> >  static void __init ssb_select_mitigation(void)
> >  {
> > -	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS) || cpu_mitigations_off()) {
> > +	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS)) {
> 
> Nothing major, but this change belongs to the next patch that cleans up
> cpu_mitigations_off().

Fixed and expediting this one so that 6.17 releases with the full attack
vectors functionality.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

