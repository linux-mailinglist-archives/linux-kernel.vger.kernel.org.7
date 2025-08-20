Return-Path: <linux-kernel+bounces-778403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A505B2E516
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F721C88663
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992F6277CB4;
	Wed, 20 Aug 2025 18:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XPGSRaG2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A6628E0F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715096; cv=none; b=VhKqSuDdp38DPWMI1qKhIAcvoTB9kkcuSzxxg2M2yBXcrj3bSN6w+zftt/xuVwBPXJoY0Rwl4JrZ6y9AUcGhRNhOi+094iuTUAPnT6wZ9ulA0lHzTzbMVox9iMmD/HOrPWyYvoS86XPzKtZn1LocNjp17gCH7pZcnLiQZbKnizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715096; c=relaxed/simple;
	bh=7iE55B7CRjFfi42IU5fsBfxacGvYHZAYz2CGGVdqXUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiZ6rQA4hgASwHivXaS80FsojY6oyow66J3ekcRv/qpWm3h1hSu4Ke1TlzjfWMa6tl+1hcc9W8obkwU/KBFLn6f+3D3hSmraspZvCJfInUA4kY3xLZPzGYktZB3GS513qDq0YvPM3rjeB5F+LuOLdfgT6EG5URtF9UN3MFKLQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XPGSRaG2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 79FF940E0217;
	Wed, 20 Aug 2025 18:38:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id e96STOIG6Mca; Wed, 20 Aug 2025 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755715084; bh=L/iAUJcxu9ycnIrQupAeMt1m7+dAOdtQUy1+SBSyCzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPGSRaG2mlh6h5LSKXYsyT5ad+hoRReHO/LId2FKdNFfmqmTXdOnTZVrM/haF9dDB
	 H9fidn5wudTn9nQED5KFrqF7bzKdu9GqutrrllqCmwJKE3YBemJNnSL7G/zMPQE63E
	 5vt7852CwY/rTnFelxftYQICL/hlAveaJhy0Vr3W5pj865fT5L5EWnlnXJO79ltTfw
	 R5H6rQxwQRb6+Rlg2wkH7S8TP/p0N/V0pi+lF6tFQFa2LLR+uoY8j//QciW1n2Insp
	 oi1R2NbAbZD+ZrFkmCaDMBamxjZHVNExaBaq58gjtact6ecdCi8ur/YLjasjpbaThf
	 ONqX1PZDDOXRNvx7HHc8uWotJG5l+KEDEGSfRIFxhRyDqMkNlpRqaVFcNwEqdEHsOy
	 Xfb5RrqUrb4HwLhcq58jRZsfguNb+YDq+jR0xo55Rr7SbWxF54X0R9qxaJPbTKX26M
	 sq6GmHN8NQVq/b+OI7PKCOBaSOUvWy0uw7uRNMXmvDHnYQOMHspptoFteZfZrbz0YG
	 owKRIKdnZpGP2n/3ut01wh2Ciiuf/75NNMUkFVH/qRrv+bKvOJRZNCZQxE6FdXVGPh
	 Ft0FOkr8VKPehz2BlNzyeWI1+7yDvrFscKBMZ024yvck+MvMzses3mtj7bv2cKBEHC
	 1ZF77XyFHFEPd5zzqF3ivHIg=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 191DD40E0163;
	Wed, 20 Aug 2025 18:37:54 +0000 (UTC)
Date: Wed, 20 Aug 2025 20:37:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] x86/bugs: Use early_param for spectre_v2_user
Message-ID: <20250820183747.GPaKYV-6egd_25ikM4@fat_crate.local>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192200.2003074-2-david.kaplan@amd.com>

On Tue, Aug 19, 2025 at 02:21:56PM -0500, David Kaplan wrote:
> Most of the mitigations in bugs.c use early_param to parse their command
> line options.  Modify spectre_v2_user to use early_param for consistency.
> 
> Remove spec_v2_user_print_cond() because informing a user about their
> cmdline choice isn't very interesting and the chosen mitigation is already
> printed in spectre_v2_user_update_mitigation().
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>  arch/x86/kernel/cpu/bugs.c | 65 +++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 39 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

