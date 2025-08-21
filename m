Return-Path: <linux-kernel+bounces-779477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59FAB2F49A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59281CE16BB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1D62D9788;
	Thu, 21 Aug 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsechFQF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766B224B1B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769924; cv=none; b=prP8VCLyLFgtgBoX7rMVIfA6FkmjtlrGWFwNodbVg7z8vp6buyvmc1Hw/x/QCdHXEmBdUxMvdEL7pEEO13dLg1dppHCoUT7BZnTpBOaTe3Q0bYX91YwImPxZY7NDiZv3ET/EO+fz+fRea+f6gDb/yPAdxXy+CXoBoRktrPs8oVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769924; c=relaxed/simple;
	bh=hyl906W6gTJkr/mdeLDIIKMynuKNYSjbTvvir+DVDog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGXA8e/DIISuQIuHql4itNt693DPHeZfpwDFDajWQRGCIgPEtN08ibWiRm99RRAHIuKZlX1RqoFbSvn3kJ4uOPudh4Zm3qM9LjFkia0GT7VQSjY5WOyH8K7yrQ9ZHaCbKrXfkf30mqDKBPWnRcsfh2QL3KqxjNkssq2851Lk7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsechFQF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755769922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBPu2qZvmk+4D7+wKx7fg2twokVDOknDGsSEmODUJvI=;
	b=RsechFQFuUduKrRcZZnRdzL/QWitx7NP2GOTPXcVu3vJdWfV/uJu1xFsOMsfIGoiPk/7TI
	o7uN4FF+9oi4K7y+AI4grhcLaHPIW4iUqWwCZ26DrMMccJ6aODVFuO30vTyAuEyQY+6Spl
	NjPokYQhJyTGb32XElV1/zvlxWOYPso=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-f3bKeXooNSqgkNedtNeEIg-1; Thu,
 21 Aug 2025 05:51:58 -0400
X-MC-Unique: f3bKeXooNSqgkNedtNeEIg-1
X-Mimecast-MFC-AGG-ID: f3bKeXooNSqgkNedtNeEIg_1755769916
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4A8119541A0;
	Thu, 21 Aug 2025 09:51:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 965AE180028F;
	Thu, 21 Aug 2025 09:51:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 21 Aug 2025 11:50:36 +0200 (CEST)
Date: Thu, 21 Aug 2025 11:50:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Mark Brown <broonie@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/process: fix the misleading comment about
 PF_USER_WORKERs in copy_thread()
Message-ID: <20250821095030.GA1923@redhat.com>
References: <20250820164651.GA18799@redhat.com>
 <7996ef64-59af-4146-be76-95a8aeccfc7a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7996ef64-59af-4146-be76-95a8aeccfc7a@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/20, Dave Hansen wrote:
>
> On 8/20/25 09:46, Oleg Nesterov wrote:
> >  	if (unlikely(args->fn)) {
> >  		/*
> > -		 * A user space thread, but it doesn't return to
> > -		 * ret_after_fork().
> > +		 * A non-PF_KTHREAD thread, but it doesn't return from
> > +		 * ret_from_fork().
> > +		 *
> > +		 * Either a PF_USER_WORKER kernel thread, in this case
> > +		 * arg->fn() must not return.
> > +		 * Or a user space task created by user_mode_thread(), in
> > +		 * this case arg->fn() can only return after a successful
> > +		 * kernel_execve().
> >  		 *
> >  		 * In order to indicate that to tools like gdb,
> >  		 * we reset the stack and instruction pointers.
> >  		 *
> >  		 * It does the same kernel frame setup to return to a kernel
> > -		 * function that a kernel thread does.
> > +		 * function that a PF_KTHREAD thread does.
> >  		 */
>
> I'm not sure that comment clarifies things,

OK, lets forger this patch then. But note that the 1st paragraph is
obviously wrong.

> especially the new
> paragraph.

I was going to fix the typos in the 1st paragraph, then decided to add more
details to clarify "doesn't return" and to "sync" this comment with the
related comment in ret_from_fork().

And to make it clear that PF_USER_WORKER can never return to usermode, this
connects to the recent discussion about PF_USER_WORKER && shstk.

> This does _not_ seem like the place to me to be explaining
> what the conventions are around arg->fn(). It would be better to put it
> near the definition or 'kernel_clone_args' or the place the function
> gets called, but not here.

Not sure. To me this comment is more about kthread_frame_init() and
ret_from_fork(). But I won't argue.

Oleg.


