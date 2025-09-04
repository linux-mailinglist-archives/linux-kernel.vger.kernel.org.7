Return-Path: <linux-kernel+bounces-800357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 659DCB436B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C402E7B3533
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535BC2E0B64;
	Thu,  4 Sep 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUkAcN3t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0626E70C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977115; cv=none; b=ihiFrTxK4IuucTggvwkcMff+tYQEIFWev8GK1HfAPOoWLN9j6RY2zv9WMKhZgpnTn6dmOYt4zeeM6A1farLs64ewIlZwUDBj42pdZASTgHd8lMV9SYS2xSVCgEVlMhnODdJNwnag2f+9053SMH5MQiJJGnEJIC3AGVF07X/Ka10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977115; c=relaxed/simple;
	bh=DmdoGdYnbYjhO6QpJrH+knWoIO4cuyRmzzzOdZTcPI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWGl/jRhLAMrMqEl0Ihtj+pjBwbmxj1IztOrM/OI8DGXkq1m1kz5MY3PoqxtuFoelUOsvMY5nB5AX7zTlEzGDi1fNmoJjSrxeNKO/Nf11ui8q0+TSry+tGzpNoYtGvqXHbsRx/KppqgJCEkr4tDijXX+7c81wNb84HvWUJdQWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUkAcN3t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756977113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap8nEHbAjkSuUadouik2OGxJ+woZMqI3nNwdhC/IOJA=;
	b=GUkAcN3tA4zCCAbW6RJ+R6lQ2oOBXl1mc3SBsbKryFqydWkOANdigb18CuvZaRxn45ieT+
	lzd7WiGyfXxxUHb6rFarqRyVJQyGS8fmSASfYwfLak1xadDIE1IuBQjDDXt2pFaERNVgBu
	zrnv69+pdsoX04qGx2bpU3WAhtO7uK8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-oSbfkzNcM2mo_hrHo7Fesw-1; Thu,
 04 Sep 2025 05:11:48 -0400
X-MC-Unique: oSbfkzNcM2mo_hrHo7Fesw-1
X-Mimecast-MFC-AGG-ID: oSbfkzNcM2mo_hrHo7Fesw_1756977106
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E00871956089;
	Thu,  4 Sep 2025 09:11:44 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59ED619560AB;
	Thu,  4 Sep 2025 09:11:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Sep 2025 11:10:22 +0200 (CEST)
Date: Thu, 4 Sep 2025 11:10:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 1/1] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250904091015.GC27255@redhat.com>
References: <20250903134126.GA27641@redhat.com>
 <20250903134203.GA27651@redhat.com>
 <b91c72b6-cbe0-4767-8d65-05f804733a55@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b91c72b6-cbe0-4767-8d65-05f804733a55@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/03, Dave Hansen wrote:
>
> On 9/3/25 06:42, Oleg Nesterov wrote:
> >  arch/x86/include/asm/shstk.h | 4 ++--
> >  arch/x86/kernel/process.c    | 2 +-
> >  arch/x86/kernel/shstk.c      | 9 +++++++--
> >  3 files changed, 10 insertions(+), 5 deletions(-)
>
> That's not a great diffstat for a "cleanup". It's also not fixing any
> end-user-visible issues as far as I can tell.

Well, from the changelog:

	Another problem is that the current logic looks simply wrong. In this case
	fpu_clone() won't call update_fpu_shstk(), so xstate->user_ssp won't be
	initialized.

	But since the copy_thread() paths do not clear the ARCH_SHSTK_SHSTK flag
	copied by arch_dup_task_struct(), ssp_active(PF_USER_WORKER) will return
	true in ssp_get(), so ssp_get() will try to report cetregs->user_ssp which
	can't be correct.

this doesn't look right to me.

> > -	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
> > +	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->fn, args->stack_size);
>
> Passing 'args->fn' as a 'bool' argument is a bit cruel, don't you think?

Yes, and

> >  unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> > -				       unsigned long stack_size)
> > +				       bool minimal, unsigned long stack_size)
> 'minimal' is an awfully meaningless name for this.

yes.

But please note that fpu_clone() has the same "bool minimal" argument passed
as "args->fn". I even mentioned this in the changelog, this patch tries to
mimic the existing code. But of course I can change it. Can you suggest a
better name?

Oleg.


