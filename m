Return-Path: <linux-kernel+bounces-814722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE643B557C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81AFA5A2267
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6207C2BE7B1;
	Fri, 12 Sep 2025 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i957haVk"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12325A2A7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757709748; cv=none; b=TotJvEhSP4NW6uYN9K6Ey8Yyul0XWsFabspYCn+/d9h13J7M7bA4GHG/g1cJCPt1Ocmv+23EyqGFoHlWHg0nzGBd8EGgnlwpVW9FmlD+Mzp+Ti0d91ugbdOgPiExUkgDnrw/y+6MyUzjdjI+biZvtKwbCsykcxMX4yEOA4n58L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757709748; c=relaxed/simple;
	bh=vbClG8BGix9jhRN585GLZM7R9GHoqMND76HBEi44+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB83r7DH9P70taVUqLd8rzpxJEp6vhKO5moKOb1TX7H4O8cu/hYMYc2e1UU3vyOavJTXxIV9S+aHtqWGYvGywda1QsqGYp/8/ghq4YXAipkiqg/ez+eC3maO8nHzcV1/QyEcPH6TlfidCtRpDFkWau0tPa6GUuXxBE62UD8AVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i957haVk; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1FA8640E0140;
	Fri, 12 Sep 2025 20:42:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TZ3O9SvsRBYN; Fri, 12 Sep 2025 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1757709739; bh=B2wrVvUcI26eeIFUV0687eXHug31Yg2nxTpS7CY3YVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i957haVkqfzxKRKG9pMFV7SwQ5WV6aSv6vj/nNHLX30LVXAcH8DprqCg8fAEk1j3j
	 Lw4iHJ6J1+FAsB9wiZk/VNRUFSlxJy/vso3tU4x1XU5paI/yMHYQSdfoNFmoAd56lr
	 O2gRx7GLeYb8CR3CtM1NH36qzKaxPPg46D3vOooImNvTJaqEi3Y3+HOmnx5Fnr8LZO
	 WHLf8/rN+zGVO7FnO1i9B0xf7ZXwOfL4ccVASUJ5hInKtkdqujg9hlBeupUtoD8855
	 OGFtLGYJpUQXmrExq9FfwT938lZTGw/ffPt/Mx73+pT+OzK/oFF1uPLm+jj/M7dkzX
	 LVEz35FyTms6GM28wbScYW7uX97Res3IVfSMbHq/iTnxSqDQ45E1rGClnhjZy2VOyA
	 K+1nFToG1Wo8KwY3IisZkyknx8mEyGkmw7c0GrAxYNooBPp973Z8wU2jivcmogvdNW
	 EnB4NNHNmFoBmkZlNLvl+Z4zDe/GB34qO7AyeB03MrvBD3GKtZpB3o1ysOYQZQtSyv
	 WD4zR//ErrxhhVD/KPFPHDr7SS7NGQA2uLVgC4AcwHfUs5+tC3GyX3LeKnA6S56syz
	 j/S2N6xqc5vwVdBwrEzi9jqAaOku9bwPAizg8GbW5xX8NDcXjnALtNPygmj4dCJ/Uu
	 XBQ4jE8Y5yONq0z/jSuYHz2Q=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A248140E00DD;
	Fri, 12 Sep 2025 20:42:10 +0000 (UTC)
Date: Fri, 12 Sep 2025 22:42:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Sean Christopherson <seanjc@google.com>, stable@kernel.org
Subject: Re: [PATCH] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
Message-ID: <20250912204203.GEaMSFm2-N6lPteue5@fat_crate.local>
References: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70e38f2c4a549063de54052c9f64929705313526.1757708959.git.thomas.lendacky@amd.com>

On Fri, Sep 12, 2025 at 03:29:19PM -0500, Tom Lendacky wrote:
> The sev_evict_cache() is guest-related code and should be guarded by
> CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV. Move the function
> declarations under the appropriate #ifdef.
> 
> Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation")
> Cc: <stable@kernel.org>

Do we really want this in stable?

I haven't seen any breakages from it...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

