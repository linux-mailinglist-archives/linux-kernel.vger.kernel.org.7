Return-Path: <linux-kernel+bounces-764836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC09B2279A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FFB7A59D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E93265CA0;
	Tue, 12 Aug 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RR/hbQfU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5F61EDA1A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003512; cv=none; b=IKnwxfERctyMFAR2y+2SunzVjnyh+C52+I8Yvh8b2+YOzmAqSaVIjuZeloFqbpiN95uKcGUECEeC4SneEFosPB+LDT6LmEN38SWAEdQVBoeiVyga49/RHnUQl+DtXo9u2BXJWTcwCw4WO9WAbetwSk/14+VtiIQgCp+9k1wFAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003512; c=relaxed/simple;
	bh=EEkuhCImXOv29EGKYKdaJrf1utelA1HOYG2A/NiU+y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfwI1nqD4sHt0kKmbNYpdIvvgYajNbm9mAKELeav6VNCn7IW6IAC+HufYLbGGf2XnRDA8JAhSNdbpWAfv75oTk6FivFzxRNl+QHFBaO2TryDRmRuUTxFQsgvHD6RowQGq+big6WHRvHdY04Dik9mlgy5Q4LgmneolHQsPpLqixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RR/hbQfU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755003509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEkuhCImXOv29EGKYKdaJrf1utelA1HOYG2A/NiU+y4=;
	b=RR/hbQfUhBOgH2ZDkJVoJtdEsUai6k25GvSUJ891lRRw9cvUlkk5NJpUKYz/58O4ALMTjV
	oEOGI6U3MaHpgLDB/hNNRm89WJBnQ2HOJn+GiLgCJjg/EOjWF5zZt6eN9KhPO6Ob6EiTqH
	lwp9CN52IQVH9hUT952RoktCEi+9kB0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-EyuRv2cqPNq0KfoH_LQgCQ-1; Tue,
 12 Aug 2025 08:58:26 -0400
X-MC-Unique: EyuRv2cqPNq0KfoH_LQgCQ-1
X-Mimecast-MFC-AGG-ID: EyuRv2cqPNq0KfoH_LQgCQ_1755003504
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6E9019560B0;
	Tue, 12 Aug 2025 12:58:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.234])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 480B5180028B;
	Tue, 12 Aug 2025 12:58:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 12 Aug 2025 14:57:10 +0200 (CEST)
Date: Tue, 12 Aug 2025 14:57:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Brian Gerst <brgerst@gmail.com>, Eric Biggers <ebiggers@google.com>,
	Kees Cook <kees@kernel.org>, Chao Gao <chao.gao@intel.com>,
	Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org,
	yi1.lai@intel.com
Subject: Re: [PATCH v3 2/2] x86/fpu: Update the debug flow for x86_task_fpu()
Message-ID: <20250812125700.GA11290@redhat.com>
References: <20250724013422.307954-1-sohil.mehta@intel.com>
 <20250724013422.307954-2-sohil.mehta@intel.com>
 <aJVuZZgYjEMxiUYq@ly-workstation>
 <20250808074948.GA29612@redhat.com>
 <e46bab92-ee1f-478f-8076-d46bd3fe9411@intel.com>
 <20250808151131.GD21685@redhat.com>
 <39edf291-d842-4ae1-b988-76dc3688673b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39edf291-d842-4ae1-b988-76dc3688673b@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/08, Sohil Mehta wrote:
>
> On 8/8/2025 8:11 AM, Oleg Nesterov wrote:
>
> >> However, independent of this warning, can xfpregs_get()->sync_fpstate()
> >> be called in the context of the PF_USER_WORKER thread?
> >
> > Probably not but I need to recheck.
>
> IIUC, if a PF_USER_WORKER thread encounters a fault, coredump could get
> triggered in its context. That could cause the above check in
> sync_fpstate() to pass. Maybe I am missing something?

A PF_USER_WORKER can't initiate the coredump, it blocks all signals except
SIGKILL and SIGSTOP. But this doesn't really matter.

First of all, I think that in the long term kthreads and PF_USER_WORKERs
should run without "struct fpu" attached to task_struct, so x86_task_fpu()
should return NULL regardless of CONFIG_X86_DEBUG_FPU in this case. That
is why I like your patch which adds the PF_USER_WORKER check. But this
needs more work.

So. The problem is that do_coredump() paths or ptrace can abuse
PF_USER_WORKER's FPU state for no reason.

To simplify, lets only discuss REGSET64_FP for now. As for xfpregs_get(),
everything looks simple, but needs some preparatory patches. membuf_write()
and copy_xstate_to_uabi_buf() should use &init_fpstate instead of
x86_task_fpu(target)->fpstate when target->flags & PF_USER_WORKER. This
matches the reality.

But what about xfpregs_set() ? Can it simply return, say, -EPERM ?

What do you think?

Oleg.


