Return-Path: <linux-kernel+bounces-859219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAEBED09D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 136084E574A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EC1F03F3;
	Sat, 18 Oct 2025 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S9nEUs4N"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E17354AE6
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760794784; cv=none; b=tFWHw5ETPn14sm4itOwqJgosyzXTdepR5xl5zDgk33OmY4tdZyEWsrE1SsQhlQ0Eef/jApVTzJ/cypnY7GAA/xFSMtRApg4y7H2EATNeb+3W2OPDptT/8BwOn3w9phcgjjpJW5UZIE0gFAMVbvsO78F7TA0T4fo/Q4CuvaUnBA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760794784; c=relaxed/simple;
	bh=p0C77Nd7KvIBramBla8WgAMcw9im3Ctj5VQVoENhwcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQxB26bQ7kpFgyKI8U89FmpSHMNVyd/SQqZ13E6r8XNKo78neq/BuuWNQ3wg9TriLoqxG3OKtaFQIoVN7YVkRtg+S1bo9fPbIC75o4IXDSUPPPzcPI+jHT/U9Byk2orJPfdXRPZzOCiEzeghdup64b9ZeUNxxOpeUvrUcZesdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S9nEUs4N; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 551B940E00DE;
	Sat, 18 Oct 2025 13:39:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pwy_tiXwsbNA; Sat, 18 Oct 2025 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760794772; bh=blpkbXc5mYYks+Zk2jeu902rTTc7pq37MlmIFyhYZhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9nEUs4N8r4G7lkXp+0rhsQhlH9AZMyCgeaj7OH9mxPsWGSa8uWKJNe6Z2TzMl11N
	 NnYrl1m5N3mpZGPjhuVgl2VqIRG563q3qHMS7eQHbh1iAT4WD6Tt4jM5uAPcZ1yDuM
	 aYjign0R/ZYHVrCTpvsedMxze2Tvmo9GZrM9pctSfNg90/cfam06JIw7nNNmCutOV8
	 hSNvr6+zZ9gk8jNbNxInbyfm3mT2CtLma0bw0ROK++s32abXolESHDK0u+fJGw9zMV
	 A+9F8dhDFICZFs0br9VlUJFZ9ulY6tviL+0HVnTin3Ikttb2ZTH5mXgoBw84zLgF+m
	 JjYy11haeJPu9alDWscWts+RRZqIKi/5R3ms4gYfsH54HAdHAOU2U9phbXw0jxke7M
	 IlyXGHDHrDoSNZ83vYnQK2fLpvz6K1cpHo4cgQBwO/kP1mevpGf+zyxv1hCuMsIMXk
	 XW1hzEMQFiEHCQMKRtQQQ6DKWy+Yb6noWtTtnpItpfDSjFeXgAMUwuSbthdyQ05MZR
	 7ikVEhbR98Kdon6/i3J1Rn9uNn4uWMffI7BFpQBXwQ3WWf7PXghp7+MsxqnKkJyL99
	 NmudJQT5KOlZ0k//iyc4eC0SM9B7fFv0AMhvZji2W+XMi3oiA+RtLhP6EpG4uxCsa8
	 APNUX1A6wE5RA61tCeergjxc=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 05C3C40E015B;
	Sat, 18 Oct 2025 13:39:19 +0000 (UTC)
Date: Sat, 18 Oct 2025 15:39:13 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Message-ID: <20251018133913.GHaPOYgR0YNlz-KexS@fat_crate.local>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-2-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013143444.3999-2-david.kaplan@amd.com>

On Mon, Oct 13, 2025 at 09:33:49AM -0500, David Kaplan wrote:
> +Move Policy To Userspace
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Mitigation choices are related to the security policy and posture of the system.
> +Most mitigations are only necessary on shared, multi-user systems if untrusted
> +code may be run on the system, such as through untrusted userspace or untrusted
> +virtual machines.  The kernel may not know how the system will be used on boot,
									^^^^^^^^^^

"after it has been booted" I'd say.

> +and therefore must adopt a strong security posture for safety.
> +
> +With dynamic mitigations, userspace can re-select mitigations once the needs of
> +the system can be determined and more policy information is available.
> +
> +Mitigation Testing
> +^^^^^^^^^^^^^^^^^^
> +
> +Dynamic mitigation support makes it easy to toggle individual mitigations or
> +choose between different mitigation options without the expense of a reboot or
> +kexec.  This may be useful when evaluating the performance of various
> +mitigation options.  It can also be useful for performing bug fixes without a

"for fixing bugs in the mitigations themselves" - simpler

> +reboot, in case a particular mitigation is undesired or buggy.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

