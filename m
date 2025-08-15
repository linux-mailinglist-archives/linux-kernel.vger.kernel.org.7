Return-Path: <linux-kernel+bounces-771150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CEB28375
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CE35A7836
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F6B29B23F;
	Fri, 15 Aug 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6vVfJvf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96B1607A4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273718; cv=none; b=hH970rCiEAkGTYb741BcnuPhRRCV4hCY+FWJgxe9tMk5lhXIyXa6mL8AtjkvnGZyoFORl3WN20WjPPEOhv/6J7MyKjYRwNZiEL6rp4TtBm7d6LRWg8p+SnYN5UwNTq/VPeRf1t2vz0HNJGT63LLMTYixabwXsHAvOETmULU+dj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273718; c=relaxed/simple;
	bh=i76hjHtSCT3Rk3Ij+L/3aI1WhrGtueTd7YU/XskWjhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qREgt7Wf1kGA1yAtPOCfR9Hk4ufDwATRaS/2v6iVGUrI1W7QgOD7XWpWy/D5PimcSctiaBWSWAUUSCOGV8v6h/4qUfOHDq/Fy1Xh9MRfusELd2zEqSLMU8Habz6YBWfMaRDgFgONlSZd74gz6wXC9mSZK8A6hdEtfJ4WzLwxaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6vVfJvf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i76hjHtSCT3Rk3Ij+L/3aI1WhrGtueTd7YU/XskWjhI=;
	b=U6vVfJvf9wx6Y6O3ly/v+dgckWKSOsAUnYVWS6o9KRKZ196DPSSFEOu/XkyCCgYVm7f3lf
	X54yVRBynCSKzmLa2iIjXkHKZWDfddtFcAhzY80Yw9vB/MCZSFtDid8Wkmh39HEl3XtcRX
	Cg69JtdR8RKA3DBtB8rIMqv1siPewfY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-thauipouP2ihxQMNskW6MQ-1; Fri,
 15 Aug 2025 12:01:50 -0400
X-MC-Unique: thauipouP2ihxQMNskW6MQ-1
X-Mimecast-MFC-AGG-ID: thauipouP2ihxQMNskW6MQ_1755273708
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C96111800342;
	Fri, 15 Aug 2025 16:01:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BFA031955E89;
	Fri, 15 Aug 2025 16:01:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 18:00:31 +0200 (CEST)
Date: Fri, 15 Aug 2025 18:00:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250815160023.GH11549@redhat.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <e50065a9-d5e2-4e94-94b2-e34c5fac9720@sirena.org.uk>
 <20250815130125.GD11549@redhat.com>
 <20250815130851.GE11549@redhat.com>
 <f1a8da89-7522-429e-a4ba-4794222f1541@sirena.org.uk>
 <20250815154311.GG11549@redhat.com>
 <dfdf2af0-7154-415e-96f4-3e4fefbe96dc@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdf2af0-7154-415e-96f4-3e4fefbe96dc@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/15, Mark Brown wrote:
>
> On Fri, Aug 15, 2025 at 05:43:11PM +0200, Oleg Nesterov wrote:
> > On 08/15, Mark Brown wrote:
>
> > > Sure, but OTOH at least for arm64 there's no cost to leaving the feature
> > > enabled unless you actually execute userspace code so if we never return
> > > to userspace writing the code to disable isn't really buying us anything.
>
> > The fact that a kernel thread can have the pointless ARCH_SHSTK_SHSTK is
> > the only reason I know why x86_task_fpu(PF_USER_WORKER) has to work.
>
> > I'd like to make this logic consistent with PF_KTHREAD, and in the longer
> > term change the x86 FPU code so that the kernel threads can run without
> > without "struct fpu" attached to task_struct.
>
> OK, that's entirely x86 specific - there's no reason we'd want to do
> that for arm64.

Since I know nothing about arm64. Any reason we do want to have the unnecessary
ARCH_SHSTK_SHSTK/shstk on arm64?

And... do you agree that shstk_alloc_thread_stack() without update_fpu_shstk()
in copy_thread() path doesn't look right? Even if nothing really bad can happen.

Oleg.


