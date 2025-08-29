Return-Path: <linux-kernel+bounces-791969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB57B3BEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA8A3B7D81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367132255F;
	Fri, 29 Aug 2025 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akefIn4F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E669322742
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480067; cv=none; b=pxwa4YZKQTvkgafksdemY2+YV+NTynvpp3p7spTuh7knsa4VEnHUwsBo5A7/Yexvyu2i9Byok/oAZVIsCSaiPl8ZvTDfU0/izdSij2Ba18bCXGVrI0rvmIb+f1NMcglQssDB86kmDgYJL+bNQNCEeP2Lyy2jQd0RP8bgGn3pSfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480067; c=relaxed/simple;
	bh=CsW+QWy4vp9f7NzL5kZd/W7g4wtc/fW6Yuky2aNtlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMqcciaLU56v1GIcAMsMZlsKS0tB4hr17GwTldBtHYo0D7vn93DyP760m0Y/9+anSpRtCGn9lkSYoJ9AJJZt8WNCJaQhwC/hlWWp3CzsAi8BVIBQ3PGCy6QRITAWnRSqrEJ1/tvsgJE93ZBpcESM6IRJo5fzg0NvguB1EDGmtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akefIn4F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756480064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAE6TdbwMuzsuth1ZB3OiEFeJzD1aZ2jYkSqMxBdWRU=;
	b=akefIn4FTTz9ImaGVRbH7Xk/CjCqPG83kGuU/1o0g+qlSM5Qye6TXOtWNn3/c64yuW4OmU
	OrRVsl/ySB4vGs1pSxD8s6n1I6JGIiT+8OiIpn0sygvoXMjwRLS2StH/SLnswNV3OOMKEv
	8DpDa0PSfAMjm4aJYSp4ekF8B1llaZ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-NXHasCw2M5eReuvOq3s1Yw-1; Fri,
 29 Aug 2025 11:07:37 -0400
X-MC-Unique: NXHasCw2M5eReuvOq3s1Yw-1
X-Mimecast-MFC-AGG-ID: NXHasCw2M5eReuvOq3s1Yw_1756480056
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E117519560A2;
	Fri, 29 Aug 2025 15:07:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.111])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A4F81180047F;
	Fri, 29 Aug 2025 15:07:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 29 Aug 2025 17:06:13 +0200 (CEST)
Date: Fri, 29 Aug 2025 17:06:06 +0200
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
Message-ID: <20250829150605.GA6035@redhat.com>
References: <20250822153603.GA27103@redhat.com>
 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
 <20250822192101.GA31721@redhat.com>
 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
 <20250825134706.GA27431@redhat.com>
 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
 <20250827145159.GA9844@redhat.com>
 <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/28, Edgecombe, Rick P wrote:
>
> On Wed, 2025-08-27 at 16:51 +0200, Oleg Nesterov wrote:
> > >
> > > I guess I question whether it really makes sense to add a special case for
> > > PF_USER_WORKER, including the existing logic. But I'm still trying to piece
> > > together a clearly stated benefit.
> >
> > Again, I don't understand... To me, currently arch/x86/kernel/fpu/regset.c
> > adds a special case for PF_USER_WORKER, this series tries to remove it (but
> > we need a bit more of simple changes).
>
> That commit I dug up? It didn't have a super strong justification either. Can
> you say what your intended benefit is?

I meant that arch/x86/kernel/fpu/regset.c adds a special case for PF_USER_WORKER
in that this is the only case when x86_task_fpu(PF_USER_WORKER) is used.

> > OK, then how/where we can clear this flag if we avoid the pointless shadow
> > stack allocation for PF_USER_WORKER?
>
> *If* we want to worry about an extra shadow stack allocation (which Dave seems
> to doubt), we don't need to clear ARCH_SHSTK_SHSTK to avoid allocations. Other
> thread types already avoid it (vfork, etc). So just add to the existing logic
> that skips shadow stack allocation. Make it do that for user workers too, and
> leave ARCH_SHSTK_SHSTK alone.

From 0/5:

	However, there is an annoying complication: shstk_alloc_thread_stack()
	can alloc the pointless shadow stack for PF_USER_WORKER thread and set
	the ARCH_SHSTK_SHSTK flag. This means that ssp_get()->ssp_active() can
	return true, and in this case it wouldn't be right to use the "unrelated"
	init_fpstate.

> > Why?
>
> Because ARCH_SHSTK_SHSTK is supposed to be inherited by children. It adds a
> special case for no reason.

See above. And it has no meaning for io-threads, right?

> > Plus, again, the current code is not consistent. fpu_clone() won't do
> > update_fpu_shstk() in this case. Not a bug too, but imo deserves a cleanup.
>
> I thought we discussed that the user worker logic already wipes the whole FPU
> state though, so we don't need to call update_fpu_shstk(). Did I get that wrong?

Sure, but see the note from 0/5.

We don't need to call update_fpu_shstk() and initialize ->user_ssp.
Yet ssp_get() will report the bogus cetregs->user_ssp.

This all doesn't look right to me even if nothing really bad can happen.

Oleg.


