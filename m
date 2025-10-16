Return-Path: <linux-kernel+bounces-856370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C671ABE4005
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E181A6570B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4065343D97;
	Thu, 16 Oct 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vx90OX7n"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8A334374
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626070; cv=none; b=M1aHz0UTzeYC91mgb8ExU4IrU/zpgDcF5PCuFGMg4/U1+v7QuAlgmQvIUuUA6DSHHxzDSiIF3NZieqva5CTKn0eSlO1zIbGqtbGCepc15O/8TXscDVgWeOfCzo6unPYtI4EPQ5G4qqVHQFc5HJMVupaxzDAcZYVak8mWG8izjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626070; c=relaxed/simple;
	bh=OrbyBdIicLCGAeM8lYPcouoRTX8gJIiVb6vSQ7/G8+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGprS12jlWk08BH685kDkbzhCwgfvzo5Sf0+rc0me7rOas0SdgnlHPIiuQz7vnXMCkcwzIyzolQywWvpvWu6Ay8Abh0Ody8/A1ZzvvOqDGHVJuWzViRNSaKfVtZryE7rU79Q4Z5hZ5KkDlTBodJSrRDY5EKhhSSJ1XegI7oOg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vx90OX7n; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aYPTBRsVIqrflJNVKsvy27i1kQjy4+54W9Iq8c5x6zE=; b=Vx90OX7nTp6q+G/biYA1pW3v5d
	o9htIUhFXuV2dSAMsCrrrhfZ4/HWynYRRF2ATJtTiIfLHdnQd/3SukSfKYdXeimvmuOoHW8sqvnIE
	5uGZbcYIDmhy6a9PRGkVMxrLfBnb3ijat8HgUEbIRzxrCrugbtSo8gwoNmJ3J0l6DH439PfJRskt7
	lq21BjZ0q1f/YFXHGWfyvD9tq5PZVKiAe1UM6DWu8j3tU78yJ8o1MOjmfnWiYR+fpGpqtB6/HSWW2
	qiDy4ZTw7NM9TaIxJ3o94M2oDqn5yaPtQbneyN1uLHprL7Z1AaSCZEIC8uAMvEg3/XBrWRNdYUVGI
	h21IbQQg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9PGN-00000006o84-2t1I;
	Thu, 16 Oct 2025 14:47:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 678AE300325; Thu, 16 Oct 2025 16:47:30 +0200 (CEST)
Date: Thu, 16 Oct 2025 16:47:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 40/56] x86/alternative: Use sync_core_nmi_safe()
Message-ID: <20251016144730.GC3245006@noisy.programming.kicks-ass.net>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-41-david.kaplan@amd.com>
 <20251016103549.GD3289052@noisy.programming.kicks-ass.net>
 <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR12MB9273D987B842D9E80081261A94E9A@DS0PR12MB9273.namprd12.prod.outlook.com>

On Thu, Oct 16, 2025 at 02:40:51PM +0000, Kaplan, David wrote:

> > Can we please keep this in sync_core()? Something like:
> >
> > static __always_inline void sync_core(void)
> > {
> >         if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
> >                 serialize();
> >                 return;
> >         }
> >
> > +       if (repatch_in_progress) {
> > +               sync_core_nmi_safe();
> > +               return;
> > +       }
> > +
> >         iret_to_self();
> > }
> >
> > That way all the modern stuff that has SERIALIZE will still use that.
> 
> Hmm, I can't quite do that because sync_core() is used in a number of
> other places too (unless we make repatch_in_progress a true global).

We could just out-of-line the thing; nothing using this should care
about cycles -- all of this is quite expensive.

> I wonder though if it'd be ok to have sync_core() check
> IS_ENABLED(CONFIG_DYNAMIC_MITIGATIONS) and then always use the mov-cr2
> version?  It might also have to check X86_FEATURE_XENPV and use IRET
> in that case but otherwise I'd think it's safe for machines that could
> support dynamic mitigations.

Yeah, dunno.. I'm not well versed in the virt thing.

BTW, will AMD do that SERIALIZE instruction?

