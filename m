Return-Path: <linux-kernel+bounces-798226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D31DB41ADB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99B9560957
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF572EA481;
	Wed,  3 Sep 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APpyBUCo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D79271450
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893376; cv=none; b=I949P6MqURPCYzFEtbvHTO0OBw6dXy/x2mHtj3KjbaYGSYpgKKdvJC0xnY7h6nm54oel6FRoKqkiYVk7OF8QKXypaOhyRNK77HWxipvG5n3XpOM8jzwJH0QViwgDxU3Djp+lfAi9BXp7YJ/fKtLMvmlavNt25OLUaernR162Zx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893376; c=relaxed/simple;
	bh=dMEwcQwAvtjSrzNLFmPH4BIo4vseIAhnZDS0aHlYncQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR1bclbq3n6MjO61fJvD3bodQmsmVZqUs9wIWpCH7ExnJFoFlAeJi4fQfl0LWN5+RxMPCdUAc/iD0x1F9c8O1pE0vQnDwFqZMsmYKYougXs+3mruazCgBo91WZxf98XFydkepcL5wfE+oznjHyctztuJBkRMyl0XPA/pwRRnyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APpyBUCo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756893373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XbUt7XpXZGaFKD52/4NGRxGRJlYjSpsjttnK6RB4jQ=;
	b=APpyBUCoJmZGg/IPsQtiyj7V/EuZJYBIjn7t/uo0xea4Y865+2l/4KRqUDUfyWIrDynPhh
	rO9JiZfoHmqmNk4Y8wOYjEFiP7sQEVLBhh/YsjPA/9rx5VcK4vpTbZ5mcRslN5ACtB2R+w
	j+kBssweH+xOmDIXgv7wv5BrwXEp3FI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-tVRqC0M3OS67ENNhqig_Og-1; Wed,
 03 Sep 2025 05:56:10 -0400
X-MC-Unique: tVRqC0M3OS67ENNhqig_Og-1
X-Mimecast-MFC-AGG-ID: tVRqC0M3OS67ENNhqig_Og_1756893368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E83A180057D;
	Wed,  3 Sep 2025 09:56:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2EB661800447;
	Wed,  3 Sep 2025 09:56:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 11:54:45 +0200 (CEST)
Date: Wed, 3 Sep 2025 11:54:37 +0200
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
Message-ID: <20250903095436.GA18799@redhat.com>
References: <20250822153603.GA27103@redhat.com>
 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
 <20250822192101.GA31721@redhat.com>
 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
 <20250825134706.GA27431@redhat.com>
 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
 <20250827145159.GA9844@redhat.com>
 <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
 <20250829150605.GA6035@redhat.com>
 <e653fb9cab51ed2d0ea71f9d322c55420a83a4f5.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e653fb9cab51ed2d0ea71f9d322c55420a83a4f5.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/02, Edgecombe, Rick P wrote:
>
> On Fri, 2025-08-29 at 17:06 +0200, Oleg Nesterov wrote:
> > > *If* we want to worry about an extra shadow stack allocation (which Dave
> > > seems to doubt), we don't need to clear ARCH_SHSTK_SHSTK to avoid
> > > allocations.
> > > Other thread types already avoid it (vfork, etc). So just add to the
> > > existing logic that skips shadow stack allocation. Make it do that for user
> > > workers too, and leave ARCH_SHSTK_SHSTK alone.
> >
> > From 0/5:
> >
> > 	However, there is an annoying complication:
> > shstk_alloc_thread_stack()
> > 	can alloc the pointless shadow stack for PF_USER_WORKER thread and
> > set
> > 	the ARCH_SHSTK_SHSTK flag. This means that ssp_get()->ssp_active()
> > can
> > 	return true, and in this case it wouldn't be right to use the
> > "unrelated"
> > 	init_fpstate.
>
> Yea the ptrace code currently assumes there will be a non-init SHSTK FPU state.
> But if the init state is currently associated with the FPU, whether it's via a
> cleared copy, or some pointer redirection as you proposed, what is the
> difference?

Well. Lets forget about other changes for the moment. Lets only discuss 4/5.

> Hmm, I actually do see a potential concrete issue...
>
> fpu_clone() will wipe out the FPU state for PF_USER_WORKER, which means if
> xsaves decides to use the init optimization for CET, "get_xsave_addr(xsave,
> XFEATURE_CET_USER)" could return NULL and trigger a warning.

Even if get_xsave_addr() returns a valid pointer, what is the point to try to
report cetregs->user_ssp which doesn't match the reality?
Again, update_fpu_shstk() was not called, ->user_ssp can't be correct.

Why not simply clear ARCH_SHSTK_SHSTK as 4/5 does? With this change ssp_get()
will return -ENODEV right after the ssp_active() check.

Unless I am totally confused, ARCH_SHSTK_SHSTK has no meaning for PF_USER_WORKER
kernel threads, so I don't understand your objections.

Oleg.


