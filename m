Return-Path: <linux-kernel+bounces-800908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E18B43D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287131C853B1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD660307AF7;
	Thu,  4 Sep 2025 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ3qQ178"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F4307486
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993580; cv=none; b=ohFgBYP0KCIPu5MGQAbcG8qHJrqrYyCXqsv627Gh9ONmE1zuNb0EBEVuAQuDgNad5iJHLMjwYp1WQUfLW4mOliTR010EiNrsBDPdlY2zW704/WdO1UyMmbgDUlXQkbgfutgDgzuAFrrtroowZZkwTEB234O23xSyKuzXxBsQzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993580; c=relaxed/simple;
	bh=Jpx4yFoiRQ4AV7GXYy1EkLPU4nZnRgkoSoHCGfbgou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=phtHeYJa1Z9NcU5v3O89d+FKHcDcbQcykcPM7BGuZ84pK8bRa0eK7n5zkNSpvbiSnFGlG6qNlo021P8e4HJV07HU89QNboqfxD6BEQCQREJ1w6xLMGM+2EOchoEFyE8+2KVbK+qzr8qqDEiWShUDEE0ngSc11L+aB2YJyVPjoe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJ3qQ178; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756993577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jpx4yFoiRQ4AV7GXYy1EkLPU4nZnRgkoSoHCGfbgou4=;
	b=IJ3qQ178T4Dla5AkAKqls/mrvg5Ys/jNJ2WmJ9ZZtN/kuzyeTazrwk1ie8dr1vN84CU5RY
	iTgV/JfoPNFkuMJ3aPuHmixL+P8Xefm2cvmZ1oqTC56XN6/DjYIye3BkNnNU7W2xDDc6Bv
	yFuWeDeY8N5fLZh6GmIpHuUHglycXQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-hYIjsfd1Nn2sGwIrL3aTZw-1; Thu,
 04 Sep 2025 09:46:10 -0400
X-MC-Unique: hYIjsfd1Nn2sGwIrL3aTZw-1
X-Mimecast-MFC-AGG-ID: hYIjsfd1Nn2sGwIrL3aTZw_1756993568
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB3221800452;
	Thu,  4 Sep 2025 13:46:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BA74E1800451;
	Thu,  4 Sep 2025 13:46:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Sep 2025 15:44:45 +0200 (CEST)
Date: Thu, 4 Sep 2025 15:44:39 +0200
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
Message-ID: <20250904134438.GA23718@redhat.com>
References: <20250822192101.GA31721@redhat.com>
 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
 <20250825134706.GA27431@redhat.com>
 <2491b7c6ce97bc9f16549a5dfd15e41edf17d218.camel@intel.com>
 <20250827145159.GA9844@redhat.com>
 <4249e18ffed68e8038624021aa3a6f06b64eeb85.camel@intel.com>
 <20250829150605.GA6035@redhat.com>
 <e653fb9cab51ed2d0ea71f9d322c55420a83a4f5.camel@intel.com>
 <20250903095436.GA18799@redhat.com>
 <78d2f583a0d3008c7d0e2b0e6b70a1b3258cc659.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78d2f583a0d3008c7d0e2b0e6b70a1b3258cc659.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/03, Edgecombe, Rick P wrote:
>
> On Wed, 2025-09-03 at 11:54 +0200, Oleg Nesterov wrote:
> > > Hmm, I actually do see a potential concrete issue...
> > >
> > > fpu_clone() will wipe out the FPU state for PF_USER_WORKER, which means if
> > > xsaves decides to use the init optimization for CET, "get_xsave_addr(xsave,
> > > XFEATURE_CET_USER)" could return NULL and trigger a warning.
> >
> > Even if get_xsave_addr() returns a valid pointer, what is the point to try to
> > report cetregs->user_ssp which doesn't match the reality?
> > Again, update_fpu_shstk() was not called, ->user_ssp can't be correct.
>
> I think it would be better to have less special cases in the FPU.

Agreed,

> I'm not sure
> what you mean by "correct". As above, it gets zeroed in fpu_clone(). I guess you
> want it to be something else.

Well. I think that if copy_thread() path allocate the shadow stack, then
ssp_get() should report the value returned by shstk_alloc_thread_stack().
If the thread runs without shstk/ARCH_SHSTK_SHSTK ssp_get() should return
-ENODEV. Regardless of PF_USER_WORKER.

Now lets recall that my actual motivation is "don't abuse x86_task_fpu(PF_USER_WORKER)",
and we also have ssp_set(). Without this patch which clears ARCH_SHSTK_SHSTK
ssp_set() -> x86_task_fpu(PF_USER_WORKER) has to return a "real" FPU state.

Oleg.


