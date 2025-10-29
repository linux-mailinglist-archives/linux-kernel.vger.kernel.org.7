Return-Path: <linux-kernel+bounces-877274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD854C1DA14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF80188F986
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1E2E6122;
	Wed, 29 Oct 2025 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i9xG7JtT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82BB2DC78B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778669; cv=none; b=oWdO7xDqUFv5vtJmt4ghk/+DdNk2SSyoEMBhyIgepJacJSF0wRf/QS2DaXpeacBEnlOihWIL0LFCY1mzSzxt4R2fNGEgXXmJkuxPBLxJfU61MfYtW+DobNVc9BB7k8peNubxfM4HvuG0QAsUIYe6i3Oqk2zSRZZV8osBLVjLRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778669; c=relaxed/simple;
	bh=gNsvp11HCmdVamdNmDJq0mUxNvHbBQdm+wZRqQ05PYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdAJUjB2lI58pKiIYyRRds8D2roWs2GPgcL+sa70rQ9UYFUlP+gv7pqq54s2zCFoHzK7Ls8HLkX6SFFvsNNhO7pizERje1r8wrcw1nBaObtSO705jaFx5UhP0DbAmyeidNG+f4MZWSX8IIBlw1jBIJUG2OrH47owSzJDP0HNLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i9xG7JtT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD44C40E016E;
	Wed, 29 Oct 2025 22:57:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CgoJpOv9t2OZ; Wed, 29 Oct 2025 22:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761778660; bh=yGi8oB3x6eaPWyZqlAg1aSVhthOKt0dYgRp5suIsMiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i9xG7JtTzTIMH+0L+VH1+dUYv2KyyT3avj/0+p9Xjsy7u2sY8njasttXNJ4JF/QvE
	 hXhQPge9pgGOyrlUNmd7EU2+NdfR8shMpCKkUr5gqDw0ixj99E8rFZZtMWAMe+w5EJ
	 Cx2Iq6hNXAGXYVq/do/gTO9vC5TBVigZhn0MLrGFgpwEVZeWmKftRgN3MSd07+HjeW
	 wDSLnT8cVeOdB5LyBAMtBqL3WiPLfGauv1BGSuyUoQrTSJWOjN0q4zHVtnfD59p6Nx
	 xfMln3auw9bY/TkJ7QqwpHm9aJHR4Lu5mrAFiwPASRj1rEe+VyWa8qr5PG7CRQgkGG
	 hN7jhsMHgvr53xpri79mCQOexdffhwsY88WeLoK7MvqvAsnOsoMVnqMpCkZKtTsFTE
	 8L7NqKweHjdVofADyvG7n3d4w33d/DVO+1XmupwbmE7f61CG09+wQ6FchHRlWdQaeN
	 3FoBeAjRevTuGgzYLXRoVukGgyXk/iSMvgsTPJpB33no+Y2hdoBZpozWRoUbGUdj7J
	 qCos2vcuz1p+UEPmczOFu/UrBXZnFATwfxV0yBxEmaSUQ+A1OzBQYp7+T17Z2NLNcP
	 osoR+pO/e1kDfjpu4dH/uTt8RJZm9yE+n21CIzuSQk2Ndrpo+uQa+DT9VN1LiOaa/7
	 naS3Mf9kob0taM78946kAS4Q=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C120A40E0200;
	Wed, 29 Oct 2025 22:57:20 +0000 (UTC)
Date: Wed, 29 Oct 2025 23:57:14 +0100
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
Message-ID: <20251029225714.GIaQKbytWNKuQC5TNu@fat_crate.local>
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-6-ankur.a.arora@oracle.com>
 <20251028135640.GBaQDLmHzCQDegBHd6@fat_crate.local>
 <874iriq2pw.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874iriq2pw.fsf@oracle.com>

On Tue, Oct 28, 2025 at 11:51:39AM -0700, Ankur Arora wrote:
> The intent was to use a large enough value that enables uarchs which do
> 'REP; STOS' optimizations, but not too large so we end up with high
> preemption latency.

How is selecting that number tied to uarches which can do REP; STOSB? I assume
you mean REP; STOSB where microcode magic glue aggregates larger moves than
just u64 chunks but only under certain conditions and so on..., and not
REP_GOOD where the microcode doesn't have problems with REP prefixes...

> > Why isn't this thing determined dynamically during boot or so, instead of
> > hardcoding it this way and then having to change it again later when bandwidth
> > increases?
> 
> I thought of doing that but given that the precise value doesn't matter
> very much (and there's enough slack in it in either direction) it seemed
> unnecessary to do at this point.
> 
> Also, I'm not sure that a boot determined value would really help given
> that the 'REP; STOS' bandwidth could be high or low based on how
> saturated the bus is.
> 
> Clearly some of this detail should have been in my commit message.

So you want to have, say, 8MB of contiguous range - if possible - and let the
CPU do larger clears. And it depends on the scheduling model. And it depends
on what the CPU can do wrt length aggregation. Close?

Well, I would like, please, for this to be properly documented why it was
selected this way and what *all* the aspects were to select it this way so
that we can know why it is there and we can change it in the future if
needed.

It is very hard to do so if the reasoning behind it has disappeared in the
bowels of lkml...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

