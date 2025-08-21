Return-Path: <linux-kernel+bounces-779425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2BEB2F3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14D81CE027C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8855F2EE61D;
	Thu, 21 Aug 2025 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="D/IEZLPL"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB22EE5F8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768567; cv=none; b=B36H0zgIaL0wZyDNR/ZDzMzcgvuifYjspbsCo+Rk+/oP5a16SDCm72hHrczWh14AQZWHUeE1d+pj2pAODFjZSAaF03l9RQPu6BYq+tvtCucjsq9d73Th2oYoKSCrDDH7cH1DC84go8qTxm/endSnZiangyZy3BUpaz+26rYQngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768567; c=relaxed/simple;
	bh=81uW8OmQiGdXsRCFP2NdXoyszHPVCMlcwDFk879A34c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuNxUpTtr7YC4k1yRT2zWkZ6S+HB9KCjcL75Ys+eZU89tDXfLWmYL9rAv89c7JuQ9eGtevAlhlOvISzpD50aai3fTp8xvovcATdDnOpCojF75zz9r3+krdUacJDVtGAkqjZsWHVH5F98mZX10yESZfdj3ptPS1hM+M7EjJZ06+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=D/IEZLPL; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BD5AA40E022E;
	Thu, 21 Aug 2025 09:29:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uS3bjzb9i7Gq; Thu, 21 Aug 2025 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755768558; bh=U0DyypuOMFxB0E3PEiM7/rOlK8tfqNc1Qj4+2mq0NL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/IEZLPLDDQnQz2oUwUZFWfcBrw8G1BThNAXoISgZH0EGLhlsgSPuC+z0Hsb4PmfI
	 ZKDlD2s1VrVV1+Wsf5IsRCbKLdIsG4mFd6kZ+5vyzloHx0GgWZ/RR0zPTMqNUe6S2I
	 U35d0FzH6mrhD6U+1CJX6tXe+HZPTAMWXOJSoVEGpKjBuPqXsfkJjQfDLlJFi1U0sY
	 /vWcBaiLvl9IdIL4JeQvZqlRH1lwzf8dYzGMNvOJHbMBIzj6Kcs8ey9QZ70AYqtVS0
	 izWYH/OrS3jylvRjLN04T3fzQRVeJuTwGCaKQcxgp0r0mvRBR5gikezuSsI5ltm0SS
	 EJg0Fvt8y8u4kUipeY/xQ0sOG1OjivwtMVDr18LVHXwiWEtZtIsMtqlXW/aFDNGJXH
	 6nXOw5tAUBbSb1bf0arNpdJOe+tb7cv3aSIqQUGyA9aPP8LifXAEjCkxr54UDrXW+j
	 +zpy+CMz+HAc3R/XWG8ksEBJ+oelTB9t9Hl9bX1dtqyvZgFrq8zCwvyVNw0NT6s8bv
	 y3D1dQwCdHXiNAc+vk26hCwISFu5/+z9HBOHD3paWeSUtD9hHNF1+Jtx/jbmjD7GhF
	 pJtDYu1MhT/Jq4dStX3e6oWNQGaaSFZy9p1vwYitB+IDZ1bnuQbT441v5lVtGC8pkO
	 Ek5OQ2u9EDbR2Q4iAPh74mV0=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 171F140E01AB;
	Thu, 21 Aug 2025 09:29:10 +0000 (UTC)
Date: Thu, 21 Aug 2025 11:29:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH 0/2] x86/cpu/cacheinfo: Simplify llc_id calculation on
 AMD platforms
Message-ID: <20250821092903.GAaKbm31k_2efcVej5@fat_crate.local>
References: <20250821051910.7351-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821051910.7351-1-kprateek.nayak@amd.com>

On Thu, Aug 21, 2025 at 05:19:08AM +0000, K Prateek Nayak wrote:
> Reuse the available cacheinfo helpers instead of open-coding masks and
> shifts in cacheinfo_amd_init_llc_id().
> 
> This series has been tested on top of tip:x86/cpu at commit 6a42c31ef324

Yeah, for the future - no need to do it now - pls test patches for tip only
ontop of tip/master.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

