Return-Path: <linux-kernel+bounces-771237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E0B28485
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637BE1BC4E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675962E5D3E;
	Fri, 15 Aug 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LluvcIaL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447982E5D3F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276978; cv=none; b=d2x/DQDJCGb8+gIpFj6kuDmDFz1uYvRE9VK8VbZSwNSxHgGDkt288Q1id8DpcJ+pnLGIgbJksm/Kwq8LyOvrlL2ANrKaWEL0+ullZDfD4mi4LNj0kvsjTf+qAcPGOj1fowScGSpw7i/gQHeyUt6lITqBtnMs/8h+ZUvtMdm2EAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276978; c=relaxed/simple;
	bh=jzYVPiD9tyKEeT28JRDm9zemzaPQoskDq33wyJmZODM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DipqmtoLcqL/bUFAC6E2rnXxMvlGNkLf7YJIqHqvgIFvaLCpfzatRnYR+Mn3vRa8bkwOG6kjVDc++Z36OzXWkCFE35i/6/K8ScMcNBjRsNc7P/oK/+fH4WIa8nRcgzfLZp9pfdDoGroPFIHBqJgEyKpBlzwIhF3cluazop7Bxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LluvcIaL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755276975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vcvVrWH9+EFilGrnShsj98sFFJjYdII60EYb8XR8AzU=;
	b=LluvcIaLf30q1TOoBwpK7J/A0eWNGD7jY0kETxXLxGoouXOCBjLiCMxxJqdkTLVado0y0D
	Z90QsFDCuOa4mmN8Kyi7ipCOtlCzq+/FJzi4UYVjMIRUPfBP0D6cZbLoBQRwJ8/AR87p9M
	IewCoYRFiNc9xzymRyMnf0b1+oFttxY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-jNBMAr_vOu63X-vvMe4BKA-1; Fri,
 15 Aug 2025 12:56:12 -0400
X-MC-Unique: jNBMAr_vOu63X-vvMe4BKA-1
X-Mimecast-MFC-AGG-ID: jNBMAr_vOu63X-vvMe4BKA_1755276970
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F32719373DD;
	Fri, 15 Aug 2025 16:56:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4400F18003FC;
	Fri, 15 Aug 2025 16:56:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 18:54:52 +0200 (CEST)
Date: Fri, 15 Aug 2025 18:54:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250815165445.GJ11549@redhat.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <20250815121702.GB11549@redhat.com>
 <cf6441dca8fe5d7c568d01e43adf715e9a35a9ba.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6441dca8fe5d7c568d01e43adf715e9a35a9ba.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/15, Edgecombe, Rick P wrote:
>
> The bit in thread.features is like a sticky bit that is inherrited whenver a
> thread is cloned.

...

> You don't want to allow a protected app to spawn a new thread that
> escapes the enforcement.

Ah, this is clear. But again, PF_USER_WORKER is the kernel thread cloned
by the kernel. Yes, it shares the same thread-group, but this is only to
make SIGKILL/exit_group/etc work. It is not that userspace app can create
it via something like pthread_create().

> So what are we trying to do for PF_USER_WORKER? Prevent them from wasting a VMA
> with an unused shadow stack? Or set PF_USER_WORKER's aside from the logic that
> is about more than protecting the individual thread in the process?

Let me quote my answer to Mark:

	The fact that a kernel thread can have the pointless ARCH_SHSTK_SHSTK is
	the only reason I know why x86_task_fpu(PF_USER_WORKER) has to work.

	I'd like to make this logic consistent with PF_KTHREAD, and in the longer
	term change the x86 FPU code so that the kernel threads can run without
	without "struct fpu" attached to task_struct.

And again, please see

	Warning from x86_task_fpu()
	https://lore.kernel.org/all/aJVuZZgYjEMxiUYq@ly-workstation/

	PF_USER_WORKERs and shadow stack
	https://lore.kernel.org/all/20250813162824.GA15234@redhat.com/

and 6/6 in this series.

> No, to make it have the same logic as the vfork case (which doesn't allocate a
> new shadow stack).
>
> Like:
>  	if ((clone_flags & CLONE_VFORK) || minimal) {
>  		shstk->base = 0;
>  		shstk->size = 0;
>  		return 0;
>  	}

Aha, got it. Agreed, but I think we also need to clear ARCH_SHSTK_SHSTK
copied by arch_dup_task_struct() ?

Oleg.


