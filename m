Return-Path: <linux-kernel+bounces-777817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D7EB2DE36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636221883674
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9BC2E282E;
	Wed, 20 Aug 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwK5AnMW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC2214A6A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755697420; cv=none; b=cIhgLBOXXifishABPQSzervNdeWhlQqcc/qDO8MTjn5K7exs6++o6fiAJNPAYbXnlel/7poG4f47JY5syeSFJ/9FhBc9SmLyDq6vtLD8JWZ4JAAFVyFw2PAHbUcQefIAhXBS+b9Maz6O/LIjFerSKsBt8Xzc4girVcPgGRIdX4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755697420; c=relaxed/simple;
	bh=Jpu+23y8IuK2pSZfrjqKDpmze1PE8J+vVUOPRlurgkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJEWTHyYEL6EjaelNYj0QEzgNKZUlCeHubZCFxz5Lqhk+dpGdzsQQbf9Fx6UgbtYF+dCfXf0sLImjPX2r5lq9H2hTmW0Hic628yC7IzJv/ySsnciA9FEJqkCy4dxOc8y5M9odPNBFD+tDl0BpUi24ndp4Tr+McoZ10kiFi4sjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwK5AnMW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755697415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VcUvGNuA3d7yrOnkNCw6tvQdIAkf+02/D+Y78DFw/Ck=;
	b=cwK5AnMW5xmWgPyZBlnI1e9tcV/9VCxevSGUInSbLUrNx/oC5+/o/20O9YlP1dwxqsuP4q
	geQdMbem4zgtsntB5RHj+4MZVypjsjXOqKlehRp58Rj96j4MHdnzYK4z6U3elxEqHKpgdI
	qKzJ/KHSFAG/se76FFcnvegnfMqlQNk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-VHmAvDi2N2eBWQWFQX-ffg-1; Wed,
 20 Aug 2025 09:43:30 -0400
X-MC-Unique: VHmAvDi2N2eBWQWFQX-ffg-1
X-Mimecast-MFC-AGG-ID: VHmAvDi2N2eBWQWFQX-ffg_1755697408
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F32D19775B0;
	Wed, 20 Aug 2025 13:43:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72B6019560B4;
	Wed, 20 Aug 2025 13:43:25 +0000 (UTC)
Date: Wed, 20 Aug 2025 21:43:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	namcao@linutronix.de, sravankumarlpu@gmail.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Message-ID: <aKXQ96ZE6yyfUuYq@MiWiFi-R3L-srv>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <aKXPPQ93H/KkxgZh@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKXPPQ93H/KkxgZh@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/20/25 at 09:35pm, Baoquan He wrote:
> On 08/20/25 at 05:14pm, Jinchao Wang wrote:
> > crash_kexec() had its own code to exclude
> > parallel execution by setting panic_cpu.
> > This is already handled by panic_try_start().
> > 
> > Switch to panic_try_start() to remove the
> > duplication and keep the logic consistent.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  kernel/crash_core.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index a4ef79591eb2..bb38bbaf3a26 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -4,6 +4,7 @@
> >   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
> >   */
> >  
> > +#include "linux/panic.h"
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> >  #include <linux/buildid.h>
> > @@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
> >  
> >  __bpf_kfunc void crash_kexec(struct pt_regs *regs)
> >  {
> > -	int old_cpu, this_cpu;
> > -
> > -	/*
> > -	 * Only one CPU is allowed to execute the crash_kexec() code as with
> > -	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> > -	 * may stop each other.  To exclude them, we use panic_cpu here too.
> > -	 */
> > -	old_cpu = PANIC_CPU_INVALID;
> > -	this_cpu = raw_smp_processor_id();
> > -
> > -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> > +	if (panic_try_start()) {
> 
> Seriously, where can I find this panic_try_start() and the
> panic_reset()? 

Ok, just found it's in a patch series. Grabbed the patchset and will
have a look.

> 
> >  		/* This is the 1st CPU which comes here, so go ahead. */
> >  		__crash_kexec(regs);
> >  
> > @@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
> >  		 * Reset panic_cpu to allow another panic()/crash_kexec()
> >  		 * call.
> >  		 */
> > -		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> > +		panic_reset();
> >  	}
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> 


