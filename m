Return-Path: <linux-kernel+bounces-769324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE12B26CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD11A5C63FB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ABE1E9B3F;
	Thu, 14 Aug 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuxKjmvY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GP94c3/o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E532145F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190294; cv=none; b=lWaHkcXcbqwSZy8gIYhQ0TzonXRqEonrOIeFYoW7UYwAinYiIh1hibyY6QmQD8K/qvWKpZA7KqvzU8BhRJbuU/2UX7+T5usZMFj7GjyuWaHPQQpRuUw+dsP8Tp2/I6YgVndH//rb+3k8Cu7Pieq8CvnPfj3TPxE9swTtrXsGjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190294; c=relaxed/simple;
	bh=0EMXvJzbVCGk9QgY+RKdDXUf1vYpGiJfjW30bH6I/7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quNNvyAb0rcmdhpRHNNGftTIVHMgMhCzdM/jS5WWePBBo40OmMfiez3xtU67six8uxASOJffj0dvK9KaQkiOqKa60Vr1m/305psZZ0VB64XgvjzXUIqvrGA7bVdFhMLfxOEeCfH2OGkzVTQeOQNJ6kcaJ/wLj7wrufELE2cmAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuxKjmvY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GP94c3/o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Aug 2025 18:51:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755190291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EMXvJzbVCGk9QgY+RKdDXUf1vYpGiJfjW30bH6I/7A=;
	b=XuxKjmvYIv7UtmU3BEb6+bSkqGY3iIkNBowRwnLMr/q8iIXpo5RhL8vIXjYtPUi7W4n3JU
	8tP9SMJddSczEogydLSNAZMT3SrfQ6WSxt8FOyX9MMoPBUtezoRhKuSoKxVKlQ41pYrTwW
	5grCX5aHseHLG8ZA5ZtP31yxJCDbky3++DgV+sks6SnvwRwMHYwfbryXsSMfetWp3PUEeO
	iKrlks9vpwq6kGc2OCwOkVF3OabNKyjy5bXz0Ih4tegvXF10YSjLsktWMXbKxMnn2rX0NE
	ZdepIFia3DGTdL7UiKiQxSUYucJkrOigA3YQ8m0S6t7776yo+r+0hL/IpHu93g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755190291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EMXvJzbVCGk9QgY+RKdDXUf1vYpGiJfjW30bH6I/7A=;
	b=GP94c3/oohPKRigNtIZXXTTvmrfAs4DSRI122oy0T9M1qY+LjOI9lPJlncWLw++Vv2tq4A
	crJhUO53eKDOgQAA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Konstantin Belousov <kib@kib.kiev.ua>,
	John Baldwin <jhb@freebsd.org>
Subject: Re: [RFC PATCH] x86/bhyve: Detect FreeBSD Bhyve hypervisor
Message-ID: <aJ4UEO3gRUiuD-4F@lx-t490>
References: <98dd43553b2d63edd3d994816f378985d1a19d72.camel@infradead.org>
 <20250814101552.GAaJ23WBZ-O3Yuu64t@fat_crate.local>
 <8ff6b4cad51167c6226304483544a6828d3f7e0c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff6b4cad51167c6226304483544a6828d3f7e0c.camel@infradead.org>

On Thu, 14 Aug 2025, David Woodhouse wrote:
> On Thu, 2025-08-14 at 12:15 +0200, Borislav Petkov wrote:
>
> >
> > Which makes it, what, 0x4000_0001?
> >
> > I presume there's an agreement among all the hypervisors...?
>
> There is no such agreement about CPUID; by *coincidence* most of them
> seem to use 0x4000_0?01 as their feature leaf, but the feature bits in
> each such leaf are completely different and the guest doesn't look at a
> given leaf unless it knows that specific hypervisor. Which is why the
> 15-bit enlightenment is advertised differently by each hypervisor
> despite being precisely the same enlightenment across them all.
>

For what it takes, such hypervisor leaves, in the 0x40000000 range, will
be converted by the ongoing x86-cpuid-db CPUID parser work at some point.

(Another iteration of the CPUID parser is to be posted today.)

Thanks,
Ahmed

