Return-Path: <linux-kernel+bounces-784836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E237B34245
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5757D1883D49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737162F1FDC;
	Mon, 25 Aug 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2qQPUPD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7C62F0C64
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129724; cv=none; b=B6fRLCu1dlA6XDAUoXDXLlIriItxdLJ3gNKW6qdN2T+6kqv73ZS506Cn7DqfCAa6DQohDeA+7BKnWFokqCinz1P3x3fP1JzYEQ5pxXYu7CxEYrQYvJRg79iE+7TUtQ2myL9iz6B6zQD5kyGDBAPyT0iY+x86NElj2GqGXiogEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129724; c=relaxed/simple;
	bh=O4OCGVjBuHOd2QR6HQHYIJxABGuTjU5vdsKPJv3kD2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ48VrM2bZvQd8YW+azs5p9fQmNR9+d8eD/mpkB0F/zAYLFLAW+AJdUhocrmNEbFafbIrMaPWRo8lfCm3/Y/9NHqagryjCUVfU5kf7ApXW3DuScZeQER5V6PRukNRy8u+9vTj1kB8xCJor4skS+ImR246dssz18OrretRivKb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2qQPUPD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756129721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I4NNJslRyc7WtADRsSwZC2QzJ7akESKiBtQvJt+0x5E=;
	b=O2qQPUPD1D1eJqY+fvn8Uzv+mS8TNMQvPD0LHfaAKzPuKd3Tg7r/uN6/tu+BCCLOwJ9gny
	LGMOrNBdhdUmCO2Wa/YjDhkjREGdZ5QzDm3m4JufUCY3oUSMvyWzMp5LYazCUgNlb7Uo8c
	WeGG14xQQIjDgwq5AzwrsX/UaduVe2w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-YxWqEMRjOUCbHchwR9DdBg-1; Mon,
 25 Aug 2025 09:48:36 -0400
X-MC-Unique: YxWqEMRjOUCbHchwR9DdBg-1
X-Mimecast-MFC-AGG-ID: YxWqEMRjOUCbHchwR9DdBg_1756129714
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9499F1800451;
	Mon, 25 Aug 2025 13:48:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 59E381800295;
	Mon, 25 Aug 2025 13:48:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 25 Aug 2025 15:47:13 +0200 (CEST)
Date: Mon, 25 Aug 2025 15:47:07 +0200
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
Message-ID: <20250825134706.GA27431@redhat.com>
References: <20250822153603.GA27103@redhat.com>
 <064735211c874bf79bfdf6d22a33b5ae5b76386c.camel@intel.com>
 <20250822192101.GA31721@redhat.com>
 <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b483759593fb83ec977c318d02ea1865f4052eb7.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/22, Edgecombe, Rick P wrote:
>
> On Fri, 2025-08-22 at 21:21 +0200, Oleg Nesterov wrote:
> > > PKRU affects kernel accesses to userspace. io threads and vhost access
> > > userspace. So why don't we want PKRU state to be inherited for user workers?
> >
> > Sorry I don't follow... Again, this is not my area, I am sure I've missed
> > something.
> > But could you please explain how can this series affect the PKRU logic?
> >
> > > I guess it is not today
>
> I'm sorry, this is incorrect. PKRU is not kept in the FPU structs anymore. So it
> should be inherited over clone I guess.

Yes,

> But despite not being in the actual FPU
> buffer, for compatibility it's left in the uabi xstate copy stuff that the
> regsets use.

Yes, and copy_xstate_to_uabi_buf() still reports target->thread.pkru for
io threads.

So this series doesn't make any difference in this respect...

> > > But again, what exactly is the problem here? Is there a crash or something
> > > for
> > > user workers?
> >
> > Well. I already tried to to explain this in the previous discussions.
> > Apperently I wasn't clear, my fault. So I guess this needs yet another email
> > which I'll write tomorrow, becauase I am already sleeping today.
>
> I believe you said something like "sorry my fault and I'll explain in another
> mail"[0]. Did I miss it?
>
> [0]
> https://lore.kernel.org/lkml/20250815191306.GK11549@redhat.com/

I tried to add more details in this "[PATCH v2 0/5]" cover letter, in particular
to explain why does this series include "[PATCH v2 4/5] x86/shstk: don't create the
shadow stack for PF_USER_WORKERs". I thought that your were asking to explain this
part...

So. Sorry if it wasn't clear, this series is not a bug fix or something like this.
This starts the cleanups I was thinking about year ago, see

	https://lore.kernel.org/all/20240606120038.GB22450@redhat.com/

Then later we can probably make more changes so that the kernel threads
(PF_KTHREADs and PF_USER_WORKERs) will run without "struct fpu" attached
to task_struct, so that x86_task_fpu() should return NULL regardless of
CONFIG_X86_DEBUG_FPU.

But even the WARN_ON_ONCE(task->flags & (PF_KTHREAD|PF_USER_WORKER)) in
x86_task_fpu() makes sense to me.

Say, switch_fpu() has no reason to check "PF_KTHREAD | PF_USER_WORKER",
this check should die. But if something goes wrong, it would be nice to
have a warning for io threads as well.

But as I said, I understand that cleanups are always subjective. It seems
that nobody is interested, and the only reviewer (you ;) doesn't like these
changes. I am going to give up.

That said... Could you explain why do you dislike 4/5 ?

Oleg.


