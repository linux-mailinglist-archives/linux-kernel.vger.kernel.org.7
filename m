Return-Path: <linux-kernel+bounces-846809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A858CBC9189
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7543E6A0E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2A2E2850;
	Thu,  9 Oct 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j63ETbu0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R92TXDhK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E612825A642
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013800; cv=none; b=ftwiv5PLxuo3QtBy+mJLjN32v91FaRq/T/7m857hH6po7Atny1wC+mnwHEirDgKC37PXiwOiSM7837IKnoHUAvcn0y3jXPO8juO28W8I2EbRIavag3ryhsr/38uRIyZDrtUxyo5Ph3AHDNBadvgv1dE49prFywpADl/iVa6DCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013800; c=relaxed/simple;
	bh=k8m4x49KGQBWUUhmOBK/arns4g60coZ7SY//6xWwlgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUrzRjCK2+fnIswN1JfCESh6k7v4TMAWyBA09IBH9F6bWlbPlSNZ748QZaQ40yRBK17UqLJknGE/XXrsJ5ZC5MULh04N9pGZDZnUNpxPGIgtZfVCTGibhaXS1msGJ04RD9AKyNRmV43GCAvGsY1xLO03qtgg/pQ6FFW/2/PeOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j63ETbu0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R92TXDhK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Oct 2025 14:43:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760013797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8vHmRPj6QLQqxML4R8NhTxzBlF/pqxtWljQhFdmz/A=;
	b=j63ETbu0pNF0W5ltYuFH/WEDWR8134d8qMIywkXbWCDrjyBeQm0ytbVvJUlA4Sc7htKKnS
	WEzNHZD10/SF98op/EUxAx+QuWigTqi8pswSxPgfBgex7whSxXiZMG4qy/Tp3Qk6k3j+v/
	u/+q0IZQbo/fNJvUzeLKNYj/3KJStl/cc6EcDPO8uvHE8hVOe0NkM/R/eAAVa7pzJHWJtC
	qsPFCKZqCG2P2ZMDPZvV2k5qaBJyFA2sRWiQqyhq+wGnvWvXoi/SWl5iS3VWVcKQhyZBsM
	b8st2UOuUWkvRv/DuxayPtwEOf8YDKnQMijcThnkiMQRvb4I2dr0rHgRcbgi8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760013797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8vHmRPj6QLQqxML4R8NhTxzBlF/pqxtWljQhFdmz/A=;
	b=R92TXDhKCNcuNbuNGevkcUTDI1+/ciYRVw6B1rtbjo57kRbkOS2kxiqIJj3g8Spt4WxVxz
	He3ePR+n6lK/gRDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Message-ID: <20251009124315.KS20u0OG@linutronix.de>
References: <20251009103900.2Fk8stnM@linutronix.de>
 <86b3a4f4-18fd-40c6-9f96-825af52a0509@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86b3a4f4-18fd-40c6-9f96-825af52a0509@kernel.org>

On 2025-10-09 21:39:07 [+0900], Vincent Mailhol wrote:
> Hi Sebastian,
Hi Vincent,

> On 09/10/2025 at 19:39, Sebastian Andrzej Siewior wrote:
> 
> (...)
> 
> > @@ -223,12 +223,12 @@ typedef spinlock_t local_trylock_t;
> >  #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
> >  #define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
> >  
> > -#define __local_lock_init(l)					\
> > +#define __local_lock_init(__l)					\
> >  	do {							\
> > -		local_spin_lock_init((l));			\
> > +		local_spin_lock_init((__l));			\
> >  	} while (0)
> >  
> > -#define __local_trylock_init(l)			__local_lock_init(l)
> > +#define __local_trylock_init(__l)			__local_lock_init(__l)
> >  
> >  #define __local_lock(__lock)					\
> >  	do {							\
> 
> The parameters of a function like macro can not shadow existing
> symbols because, when invoked, these parameters would be substituted
> during the macro expansion by the actual arguments. Only the local
> variables declared in the macro would survive after the preprocessor
> and thus only those may cause shadowing.
> 
> So this last part of the patch is not needed.

Right, but then we have the same __l variable in the whole file. Isn't
this worth something?

> Yours sincerely,
> Vincent Mailhol

Sebastian

