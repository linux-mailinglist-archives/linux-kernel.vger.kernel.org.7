Return-Path: <linux-kernel+bounces-873894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02EC1504D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA963502EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34922376FD;
	Tue, 28 Oct 2025 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="efrqwEo9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD472417F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659836; cv=none; b=DejCMq2Fopbzuo4xoFSeJk2yfc7DVXGYLNb8pPtRIp7K03krkZtBNvdZNMM++nmPpGstd11To/G0D0AuEL3ePdmDY9jzDkvq9eG9hBvUS2SY9ikRBkvvvngB0nu8miHcwHhOZw5BCYAS3+bdd/LsHfI1SjO8ahQPEI1rC4Wd7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659836; c=relaxed/simple;
	bh=P3H+ea+1mCfp2dT18ZD518E9RL3RnI57LxiNgEybxzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl+HlIUqFpaeBT0zkIgOi/BfyROkHOwbq0jJ+r9Ni6RwXsaoXi9ViLfcSr92kQhy9/rRVjUgGoh88uwbA8nO72IroaXR2J5v6Ms6RO1dAzP8ujwV8pT3k2tzAMt7JxrJBjQXDdqaKNJAkzb2rS74LA+T2qYnbGyo0sG3rSha8tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=efrqwEo9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EF1B840E0225;
	Tue, 28 Oct 2025 13:57:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1_nsMwL3qR96; Tue, 28 Oct 2025 13:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761659827; bh=Bu9Jr2dam06sl63fQm0tPkTHNuZQtbs/dlOpqYwRSNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efrqwEo9LcJeGn3Hp3jgS8IGZBBajA6sljLj7pC3IXfRxaIRC1IPE/zSM61vuj0lF
	 GHgpbzAdYeu8OJMqOok/GadSfjYgZf/aEMjpTwliPBEj7ctTmXpfWeF7cPLTF4Lc/c
	 plznYjbyLE9p0TNCRj8Srqri+MkwbTkp7iCPXsUx0xhZTFf89eJIMgucTTZaU8JRLs
	 kLHkhPL/fBE7940uAoc2g6JJfDVAgYOzttpih3lWkVsEIjMqDBYjTc8EsDiQiJ+DGk
	 lUoBcQ8MionCKQQeETUXNhK2znD3yZALyP0NJHWJNzXnDJwznbuOHRbwOSjD1TOhEu
	 Uay+B7NjUvlXgPM6QPPyXWojsGSuulnTEpno0Tw5nb/+joejPo3QnaWODsBim0wew7
	 g3Oo87lnimQYvf7IvbkW00qy0tApDI6UDgVtSuyNKghV0VH1cfFA/fjppDMai0z6rQ
	 gyLN9nygh8LPRE4ZiVEGnhqWvSpFVHyCo1oo60zHrqSbuFsdSJUvkKRaiRouHUOtCV
	 So119eeWpoaGbEBdaDqMTfvzFvSqo/xsPpfCpP2PXKaegEe9ItDsQCjxb0pL19YN2j
	 fPrDxHv9oBv4w4UeZ2iyfyo39t39g0hl+RRya6z2Pqhz/0UzGpWNqpr0t93djBWMfN
	 a2E0Plm2ZYfSbsJi21O9atLk=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3570940E00DA;
	Tue, 28 Oct 2025 13:56:48 +0000 (UTC)
Date: Tue, 28 Oct 2025 14:56:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
	willy@infradead.org, raghavendra.kt@amd.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 5/7] x86/clear_page: Introduce clear_pages()
Message-ID: <20251028135640.GBaQDLmHzCQDegBHd6@fat_crate.local>
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-6-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027202109.678022-6-ankur.a.arora@oracle.com>

On Mon, Oct 27, 2025 at 01:21:07PM -0700, Ankur Arora wrote:
> Also define ARCH_PAGE_CONTIG_NR to specify the maximum contiguous page
> range that can be zeroed when running under cooperative preemption
> models. This limits the worst case preemption latency.

Please do not explain what the patch does in the commit message - that should
be clear from the diff itself. Rather, concentrate on why this patch exists.

> +/*
> + * When running under cooperatively scheduled preemption models limit the
> + * maximum contiguous extent that can be cleared to pages worth 8MB.

Why?

> + *
> + * With a clearing BW of ~10GBps, this should result in worst case scheduling

This sounds like you have this bandwidth (please write it out - we have more
than enough silly abbreviations) on *everything* x86 the kernel runs on. Which
simply ain't true.

> + * latency of ~1ms.
> + */
> +#define ARCH_PAGE_CONTIG_NR (8 << (20 - PAGE_SHIFT))

And so this looks like some magic number which makes sense only on some
uarches but most likely it doesn't on others.

Why isn't this thing determined dynamically during boot or so, instead of
hardcoding it this way and then having to change it again later when bandwidth
increases?

Hmm, weird.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

