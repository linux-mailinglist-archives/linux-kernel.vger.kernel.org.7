Return-Path: <linux-kernel+bounces-881208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC47C27B87
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36703BD4CC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD82620E5;
	Sat,  1 Nov 2025 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MvQzhz6P"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACE223311
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761991430; cv=none; b=FXDi9PMkiV/BDjdRivy7Oy+6Tu4VMRDBi9Yy5YshYhEGHuaenSN7k9SH/e/8KjcH84vf2fIO2pwKLGS6hi+Yn/JZ48045IXuGRWWYhHSbs1Rkwyj3WdNwCItEnPJyn+rqihXqib2oS3LUk71TA7kP8bB6/lr2wfWGI/FEJ0HxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761991430; c=relaxed/simple;
	bh=si3WMn9DMZ/D4bKuF6ESJCK4U5DTaVShGHWcKdwEHVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU0wvqpzzdv09t5Q3z5L+nLgeJ8C4dIk1I9+J0dX7xixIl2BIq0+v1sVIc9VOHwzU5aoIMijzAeIfQjGQFoHZg0Vy6uIl8hESFNJ3LV08Rfvpm5LXTyuL2Z9q8Cm59n29etxbPi2qv+/tLM0YvsssgOr/865LmJCRTPhk2VI28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MvQzhz6P; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 26BC840E01AB;
	Sat,  1 Nov 2025 10:03:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kBpOaBub9f3l; Sat,  1 Nov 2025 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761991419; bh=VilwulQHPh3be2Owdqwiz8BjA56ckJZCkWxEmqVk8us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvQzhz6PZLta6HGyH/KEHp4reqFY2pNYznt6+rPHT1OdRD5qd+sruTb+aBuA5NKO+
	 jnh8YoIOZglAhAlCAVabYfORO5igbwqbJ2wYoWf6v+aqsqrXinWvM3SP4qhEfBh7aP
	 74n5xfjH9gnwRLJbxpLo3fLYn22Rc3+piC6D5VOeXumw95GDN8z/EcjQAlhbAzamK3
	 GJBHnW4s0cF5m/mu3uYbnAG9dZCInh6m5L8ZpFP+H53ljZvbqaZIbd1HPCK1v535Y2
	 FW/QBeUSL3oGQdDPPh0J6Zsrb3xWrAStMKe4dsL/U/jbyvLZ3TzXUiP67tDKSaAvPA
	 DToD+8aaG8J1txU1S9kcd/a9WyTceO1U5PffRnIvdNfa04tJ03jpynwSTfR2E+qInu
	 2nr10wAeEZTlb7dDDKYyJ6JT2JYChjfY7CAtvuqTJTJOnjh1KqcXbSvBTS7nhO4But
	 Gj+NFIkrcNWbz3cTddbXPDkrqRnri1BK14xJCrWQjWjGWv8XYXP6ylHF/Vi5xDjjC9
	 MATKSASnZuMnV64F+wiqs8KbZXmAIw+top34n5B0qrBtML+GdYKe0yJXjhDFEDXK1s
	 JKcmpdN7zByu2gkJLvnnn8DMYMeGF9PnCvtWXcKfosdgtKGPw6KlTG5jQ7gjO9O3G7
	 b2t31yq6OYwftOI5j7kFkou0=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 728B940E01A5;
	Sat,  1 Nov 2025 10:03:32 +0000 (UTC)
Date: Sat, 1 Nov 2025 11:03:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: Marc Herbert <marc.herbert@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/msr: add CPU_OUT_OF_SPEC taint name to
 "unrecognized" pr_warn(msg)
Message-ID: <20251101100325.GAaQXa7UF-Ru2yqdI1@fat_crate.local>
References: <20251101-tainted-msr-v1-1-e00658ba04d4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251101-tainted-msr-v1-1-e00658ba04d4@linux.intel.com>

On Sat, Nov 01, 2025 at 03:10:24AM +0000, Marc Herbert wrote:
> While restricting access, commit a7e1f67ed29f ("x86/msr: Filter MSR
> writes") also added warning and tainting. But the warning message never
> mentioned tainting. Moreover, this uses the "CPU_OUT_OF_SPEC" flag which
> is not clearly related to MSRs: that flag is overloaded by several,
> fairly different situations, including some much scarier ones. So,

Taint flags are expensive and we don't have flag for everything. And when
userspace is poking at MSRs, that's similar to putting the CPU in
a out-of-specification mode of sorts. So I took what's closest.

> without an expert around (thank you Dave Hansen), it would have been
> practically impossible to root cause the tainting from just the log file
> at hand.  Fix this by simply appending the CPU_OUT_OF_SPEC flag to the
> warning message.
>
> This readability issue happened when staring at logs involving the
> Intel Memory Latency Checker (among many other things going on in that
> log). The MLC disables hardware prefetch.

Thanks for the background.

What is not clear to me is why do you need to dump the fact that it tainted
here and dump the taint flag too?

Also, why aren't you using print_tainted() if that is really necessary?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

