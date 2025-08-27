Return-Path: <linux-kernel+bounces-788507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A7B3857D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7261518846E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E121884A;
	Wed, 27 Aug 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iwj9kzNV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891918A6AD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306414; cv=none; b=EB2fjhJGo7yMz/DuVVSCE9dyvbu/o9ceeHh+cof8OkNV5wtK0J7ETwyOmbO2Z8xZiceLPKuP2ECt7hWUZK/Y2HrqqQgYHnOFSTFccjrdKqoD7wtEvR662fnSeEEsLVuz14+wSg8ATcfdMvR9jqe0+eW5okKDaZ8jdng0xEkjrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306414; c=relaxed/simple;
	bh=5wWMon+YJHxehhx1gUsMtqdFdwkx9U+Zs0qGaUzdB0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKxWZq6xvNx2Gjc1u+n9EkehqM4rrO84SW1KhYTgX3Y7TMrW5OgCvyyMpvasutKfmWYnjaY7oi71FNFkB4yOaLjflW3pGAwtbcTZeFtNk48hJ1lwc3WLI0lSXVvpQl/9YphutXnXn/id6qTbCNuKtOK6VSo/XnZFZ357bqHgIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iwj9kzNV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756306411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kacv6oiGFz+GTTgK1BtohD0+Ldc6xRCNyYD9wji9qUw=;
	b=Iwj9kzNV1gjzHpuhyCXWwrROAi5EGKtiTEcSy6XXPX09NnxsUZSBdRBQ9CusT3jvB4IxOE
	DjCkBTyn8A4oqlyrjPs429dgP9Iwi79wvM5wmJ4xiIBCHCl5fmmM5bN8FVBbgKI3TK/QOo
	FdB32YniI/a8TW3sHAM+W0Vt/sydGpo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-9_A6r84mP3izRvNMrq1Siw-1; Wed,
 27 Aug 2025 10:53:29 -0400
X-MC-Unique: 9_A6r84mP3izRvNMrq1Siw-1
X-Mimecast-MFC-AGG-ID: 9_A6r84mP3izRvNMrq1Siw_1756306407
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7CCA180034B;
	Wed, 27 Aug 2025 14:53:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5AA031800446;
	Wed, 27 Aug 2025 14:53:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 27 Aug 2025 16:52:06 +0200 (CEST)
Date: Wed, 27 Aug 2025 16:51:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Message-ID: <20250827145159.GA9844@redhat.com>
References: <20250822153603.GA27103@redhat.com>
 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
 <20250822192101.GA31721@redhat.com>
 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
 <20250825134706.GA27431@redhat.com>
 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/27, Edgecombe, Rick P wrote:
>
> On Mon, 2025-08-25 at 15:47 +0200, Oleg Nesterov wrote:
> >
> > So. Sorry if it wasn't clear, this series is not a bug fix or something like this.
> > This starts the cleanups I was thinking about year ago, see
> >
> > 	https://lore.kernel.org/all/20240606120038.GB22450@redhat.com/
> >
> > Then later we can probably make more changes so that the kernel threads
> > (PF_KTHREADs and PF_USER_WORKERs) will run without "struct fpu" attached
> > to task_struct, so that x86_task_fpu() should return NULL regardless of
> > CONFIG_X86_DEBUG_FPU.
>
> To save space?

Yes. And to make the fact that kernel threads never use (do not really have)
FPU state more clear.

> > But even the WARN_ON_ONCE(task->flags & (PF_KTHREAD|PF_USER_WORKER)) in
> > x86_task_fpu() makes sense to me.
> >
> > Say, switch_fpu() has no reason to check "PF_KTHREAD | PF_USER_WORKER",
> > this check should die. 
> >
>
> Digging through git, the reason for the PF_USER_WORKER check in switch_fpu() was
> originally: "more of a cosmetic thing that was found while debugging and issue
> and pondering why the FPU flag is set on these threads."

Whatever reasons we had, they're gone. We can rely on TIF_NEED_FPU_LOAD.
I'll send a coupld of patches tomorrow.

> So a goal could be to make the code make more sense? If that is a reason, then I
> have some concerns with it. The simpler code would need to somehow work with
> that (I think...) user workers should still have a PKRU value. So then does
> ptrace need branching logic for xstateregs_get/set() with a struct fpu and
> without? If so, is that ultimately simpler?

Sorry, I don't understand... In particular, I don't understand again how
this connects to PKRU. __switch_to()->x86_pkru_load() doesn't depend on
switch_fpu() ?

> > But if something goes wrong, it would be nice to
> > have a warning for io threads as well.
>
> I guess I question whether it really makes sense to add a special case for
> PF_USER_WORKER, including the existing logic. But I'm still trying to piece
> together a clearly stated benefit.

Again, I don't understand... To me, currently arch/x86/kernel/fpu/regset.c
adds a special case for PF_USER_WORKER, this series tries to remove it (but
we need a bit more of simple changes).

> > That said... Could you explain why do you dislike 4/5 ?
>
> As I said, shstk_alloc_thread_stack() shouldn't clear ARCH_SHSTK_SHSTK because
> the function is about shadow stack allocation.

OK, then how/where we can clear this flag if we avoid the pointless shadow stack
allocation for PF_USER_WORKER?

> It also doesn't make sense to
> clear ARCH_SHSTK_SHSTK for user workers.

Why?

> I think Dave also questioned whether a rare extra shadow stack is really a
> problem.

Sure, it is not really a problem. In that it is not a bug. But why we can't
avoid the pointless shadow stack / ARCH_SHSTK_SHSTK for user workers ? 4/5
doesn't complicate this code.

Plus, again, the current code is not consistent. fpu_clone() won't do
update_fpu_shstk() in this case. Not a bug too, but imo deserves a cleanup.

Oleg.


