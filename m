Return-Path: <linux-kernel+bounces-782622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744BB322C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E38D563DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D492D0623;
	Fri, 22 Aug 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmaZrpAI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB482C3761
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890557; cv=none; b=mpspzj2iFRmySvAoGIeMZu6no4NXonu3fdOVwyCz73tW9/5QPA6ZHfXbguW2Jh59h4zWofQ9sNWlY8ey+9mTVdrdNt8cZUCnrQyqsMaxN3IpIG7O8GjOt+9DUwtg4tQio/7U1oE/PpiBfIIdCHSnELHp6s0In6UTrmvIkArAs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890557; c=relaxed/simple;
	bh=e9rHCm+5wUu2Fo6VZBoRAomA+U4W3ETnOYk3CD8ENvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8Sg2VHMIoORwsdgzFfkAEQyOCEi7IAtR3g0PEc+M1DxhmJVJ+lmt87SMewHZcllRAXg/8X149Dr5IzlR/b0ZjL2LIVkSvoHesaO0gQI564s5pEBeom+Yhlc9oOg/NGQ8HuiHIO21XU+UaJ4OFVVM0aSD67JBM73Xh/45iuAdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmaZrpAI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755890554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e9rHCm+5wUu2Fo6VZBoRAomA+U4W3ETnOYk3CD8ENvI=;
	b=XmaZrpAIoFjfT514WAdOuS1itnLTXTqJRkoSk5RSTLQTDYukZ3v/uqA4x7WAkm1LjA6Duw
	8OX6hr4f56bY0ILdwm2KzxfvkzBVZaiHSDvC7OcQP6OHzHJJNNvRh5WNO9nQPc6wB8Y6Ft
	w1pDcR9PyzfTBOJP+NzraPJLx2BPJqU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-MpmbiL-pN4ecga6I9AZffA-1; Fri,
 22 Aug 2025 15:22:30 -0400
X-MC-Unique: MpmbiL-pN4ecga6I9AZffA-1
X-Mimecast-MFC-AGG-ID: MpmbiL-pN4ecga6I9AZffA_1755890549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E986A180034A;
	Fri, 22 Aug 2025 19:22:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.227])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6C36F18003FC;
	Fri, 22 Aug 2025 19:22:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 22 Aug 2025 21:21:08 +0200 (CEST)
Date: Fri, 22 Aug 2025 21:21:02 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"bp@alien8.de" <bp@alien8.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/5] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER)
 in .regset_get() paths
Message-ID: <20250822192101.GA31721@redhat.com>
References: <20250822153603.GA27103@redhat.com>
 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/22, Edgecombe, Rick P wrote:
>
> On Fri, 2025-08-22 at 17:36 +0200, Oleg Nesterov wrote:
> > PF_USER_WORKER threads don't really differ from PF_KTHREAD threads
> > at least in that they never return to usermode and never use their
> > FPU state.
> >
> > However, ptrace or coredump paths can access their FPU state and this
> > is the only reason why x86_task_fpu(PF_USER_WORKER) needs to work and
> > and discriminate PF_USER_WORKER from PF_KTHREAD. Unlike all other x86
> > FPU code paths which do not distinguish them.
> >
> > OTOH, arch/x86/kernel/fpu/regset.c doesn't really need "struct fpu *",
> > the .regset_get() functions actually need a "struct fpstate *". If the
> > target task is PF_USER_WORKER, they can safely use &init_fpstate. So
> > this series adds the new simple helper
>
> PKRU affects kernel accesses to userspace. io threads and vhost access
> userspace. So why don't we want PKRU state to be inherited for user workers?

Sorry I don't follow... Again, this is not my area, I am sure I've missed something.
But could you please explain how can this series affect the PKRU logic?

> I guess it is not today, but to me, conceptually we maybe don't want a special
> case for them? So rather than add more special handling, could we actually just
> remove special handling to make it consistent?

Could you spell please?

> But again, what exactly is the problem here? Is there a crash or something for
> user workers?

Well. I already tried to to explain this in the previous discussions. Apperently
I wasn't clear, my fault. So I guess this needs yet another email which I'll write
tomorrow, becauase I am already sleeping today.

Oleg.


