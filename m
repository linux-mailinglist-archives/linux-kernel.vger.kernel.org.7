Return-Path: <linux-kernel+bounces-730480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534ADB0453A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A43161D58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFCA25EFBE;
	Mon, 14 Jul 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VCgXrIdc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BE2E36F0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509830; cv=none; b=ftHz8qUao6AYWitrgqTTNC8HGGqrdgrJVvGno6cjAj/VE2rSNyUzhnBhwZj5dRmX0iy+Z9t+0MwtlsCIoymdv4NwKT4stazuQ1RsxpFO+CqY6l5yJS7jZ3ZIjbZNA3RQPnKVmiAiywACbEM9wFT6e31vP8B76OGonTfkU7epEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509830; c=relaxed/simple;
	bh=XOpDJ51jEF04CntbAL6QpSAXSQ6+Q86kmfIhMKMbXYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBzoR07x23gjnxi6p+JH87m7nZUUS5iTClxB+u43QwT91mU6Q5+Sx4gxiTjCcCJ6NZdmFOZ6TLQeU8ao5riaxpiZlj+LxzLsDANpatRc3ed3jiWErR5ETHPXWXRg06MelX8+/PXMkGMEfwWec/H20rdSngY/eIaS1WkmATl0ZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VCgXrIdc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5CC6840E0213;
	Mon, 14 Jul 2025 16:16:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZVMRs7O_RlYO; Mon, 14 Jul 2025 16:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1752509814; bh=lqKyNrawjxd58c04G7Shk4ptqrC1D520uML5zM9/4jM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCgXrIdcto85bbw8nLQUoH2p5Vtr6Fy19sGxa6O4nl7IvIZuY1APe8mq6If7GqExw
	 pjdhBAo+k9q74RlWZthWDb7qJxnRKHP0wB0xS39Y6h+a0DGcwHQ/14WKanSteKmqhC
	 K5YFtVRrP4Eg5TsUiVdyF8H4H1AAxw0js3MCtnDHmZO+qJc0W3dgyarhIvXjpRM0Hn
	 i7slMhrlqGwEg2GMn+G5F4YolmWkHp9XYoH+M39BbIhbNT7OKQ012D2UmKNgaE+s0i
	 USQqjmBsy9wiqWMsa6qzg7/z2Y6pbPWqujwfpOpSgcF7xC+wDbIhhgIPlVLplI0L8A
	 ClYZmLpKhelGKFMqWBvh/yHUtOfduKkHXWGj2ppxLGWqKINxQOJR3qvqCJBpsxsDSd
	 6CVWbHEegeCpX2wzUX1DsNd0sFMHhJT6hZmxun94KsSLMazOtMXqnr+0jhx9gwOsAZ
	 XfysGar5xE3r6JezhF9BqicaHix1AjhvWLx28fFX1BhGDXFPTbZihoyx2gLxmCDEwX
	 ALdznbIUHgOMGkNARYMpJ141Y4McEtrb4UF6Ue+t1wQsJHISC17KOtPnL0nd5ti71r
	 5g9RXk2TNn5ohGCaYKn/yIdS8mBtJxdJS3WToW1Io//2g51lP4tx0Emj3YrWGkreAG
	 d5YuB50jf6OfUbVLbUJ5PvLY=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8F7C40E01FD;
	Mon, 14 Jul 2025 16:16:45 +0000 (UTC)
Date: Mon, 14 Jul 2025 18:16:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, santosh.shukla@amd.com
Subject: Re: [PATCH] x86/sev: Improve handling of writes to intercepted
 GUEST_TSC_FREQ
Message-ID: <20250714161639.GLaHUtZwleS3COfxxX@fat_crate.local>
References: <20250711041200.87892-1-nikunj@amd.com>
 <20250714104424.GGaHTfiFxI_pf-vhRn@fat_crate.local>
 <aHUTMiEJ-nd76lxM@google.com>
 <76e0988d-279f-be58-51d9-621806dbb453@amd.com>
 <aHUfecs9UJPx0v_C@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHUfecs9UJPx0v_C@google.com>

On Mon, Jul 14, 2025 at 08:17:13AM -0700, Sean Christopherson wrote:
> The guest cannot dictate VMM behavior.  If the guest side wants to panic, then
> so be it, panic.  But don't blame the VMM for taking a conservative approach.
> 
> If you want to dictate VMM behavior, then the required behavior needs to be
> explicitly documented in an "official" spec, e.g. the GHCB.

Ok, so you want to squash the #GP from an attempted write to a MSR into
a warning because this is how the hypervisor has been handling it already for
others. Ok, I guess this is established protocol or whatnot.

Now, why should it panic when a *read* is then attempted?

The APM says:

"Guests that run with Secure TSC enabled may read the GUEST_TSC_FREQ MSR
(C001_0134h) which returns the effective frequency in MHz of the guest view of
TSC. This MSR is read-only and attempting to write the MSR or read it when
outside of a guest with Secure TSC enabled causes a #GP(0) exception."

So what is the established protocol for reading non-existent MSRs?

Also, if secure TSC is enabled, that MSR read should succeed.

The original text in the patch:

"Only terminate the guest when reading from intercepted GUEST_TSC_FREQ MSR
with Secure TSC enabled, as this indicates an unexpected hypervisor
configuration."

doesn't make too much sense to me.

Maybe you need to explain things in detail as virt and I don't understand each
other too much yet.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

