Return-Path: <linux-kernel+bounces-880964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCF5C270EA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C71E934B77B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 21:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFD30DEA0;
	Fri, 31 Oct 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fHBakwCY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837F241664
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946735; cv=none; b=Yvxafx3tro69IPcRZuiSKfBFS0frdSKMnwy16lBb0k9slA4lYCeDd3AcsSIKQHAjWDiuifjZxeaavD3dzzfsJMOoInNwU/Ce5/3JfxUBNjku6VHatYT235EhWjcDr7qE9m2ncBA2cdR/p2o/Z4GnNDMIdyqATbr9jZQrPyz84E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946735; c=relaxed/simple;
	bh=TPlNsDOB7+xC1rP2NRdQURfwtV/edU8Mt1F+x7pBCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGEb+02DR/0Evn9esA41+XQd17Wj2QjL6+rztdO+zQvcynH0VPSerMORQBx5DHUUGW3EhZyootJEwsztwkeIxOIClgWnV727kmGMiMRIX5ns+nEX22sqts5rhKcYiLcmy6FE0ol2by9a//9sqSiG2xP9/eI3IjrjacjR/Cz4bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fHBakwCY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DF28740E0200;
	Fri, 31 Oct 2025 21:38:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EQZhjGuVSxoA; Fri, 31 Oct 2025 21:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761946720; bh=1q5upS3f0bzQp9+k/9ubCPycN4qxugW9/lCNLd+NxXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHBakwCYD1UE56zh2UVtrsdpNTCA+P3A63QZ/WoZwLrISg3iUtX3X8tYM4pgtFLV9
	 IWG05ggFZ3oxtzHftTEyxPVHlPcdCy5hY27mV19bpubfmuzLb0RJGCFpgc7qT5eMlB
	 b65VH5vEsGYsmC7xjxOPdzbiKwUOWexGkmn0ceSqK40DoQ4ERDThZ8cu4zaYi17sXC
	 J9jVGRrmMeDpnjZVTP8HQNqnXN0KK5+BQgF081KEP2/KMb14HwOY+eHOzfOSA+YkTa
	 MlJC/QLZLwqtddHep9Qq2VSN2rRDCOhszXhWse/dnAVIGcS7UMjgQx/htL0hr+8sGu
	 2t5Oxj0xl8sWVzYZsJ/OEb9YpasDy+nFrezK1JRyFl/7Mkj3dI6r7t0VyPXOAo1TwW
	 iQcyilQbUbI7e+wUp6r887cCglqtfe6WZJaysNjBsYkZvcBEv4D3cGKO14TrQ3l7Oi
	 +v0okfeOLADFg+Lf8i6xNzGbX0HYMg7vZBdcQLZ5jBZMNcG3766z/o2u/HJYIOA8RT
	 xhk9k13jP4D/Qz3GTjORsMyqsI2EMehQCU3i76egs+2qjhaiRcv2/6qQVlk+EhmMXZ
	 bh8epxoFn6B5PBuAvrzBF2Gm7NEcWBAdPwm2vFrSLl44Lvhc4j1lrzCWg5UBkEPQ30
	 UnMNsxfs1VEPLkLVqLriBWcA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 201DE40E016E;
	Fri, 31 Oct 2025 21:38:31 +0000 (UTC)
Date: Fri, 31 Oct 2025 22:38:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
Message-ID: <20251031213822.GKaQUsTs_FhPgB6H9k@fat_crate.local>
References: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
 <20251030192819.GFaQO8U29xvWcPT_s2@fat_crate.local>
 <20251031142044.GB3022331@ax162>
 <20251031144624.GHaQTLwONX3j6aDkkP@fat_crate.local>
 <20251031202226.GA2486902@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031202226.GA2486902@ax162>

On Fri, Oct 31, 2025 at 04:22:26PM -0400, Nathan Chancellor wrote:
> Yeah, I should have explicitly tagged this change for stable but I have
> been a little lazy since AUTOSEL often picks up the slack :) If you want
> a resend with that adjusted, let me know.

Nah, that's fine.

I'm asking explicitly because we have this basic rule:

stable material => urgent branch and goes to Linus now

So it basically determines where I route it to.

Lemme take care of it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

