Return-Path: <linux-kernel+bounces-746678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDDAB129FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B914E562121
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0D224AF0;
	Sat, 26 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzC/8A9L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E7215062
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753523829; cv=none; b=lsje9yckxqJiNw16EZtdvRkj/qfx6ODqkd6bwC8vz2UihksbTWgyTwguBixwhmEMmDp4k08QU4znHunX9zvQ+7iRw8T7SN2EEVcPOY/6en59RLSylNlIpuyJTJwQ55A+MFOvG0ZM8rAPIdDXj1niyhaAQfdNk7rqGzhoxLLCOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753523829; c=relaxed/simple;
	bh=S+JCuOb7BzLxSQy+vZABQ5558LqPUeHfNomoyUrZs3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABmIw6VV6B1AWUKhDXHvy1mvGIrb0Ma8kDFHsdFcXP6FyZaQZPs03jWDUbKK+AsdCUBIuWonYHsHzoptUyL0azttMPHnqnyt8PMFAfQKzo8RGfJpsaUl2pkTS8gKHNdDT11jC+LAlPPEqeU5TnuGO2cdCvXc1aO+itp3EtSb1Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzC/8A9L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753523824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5U7mxgyIjpYwr+GEoex21w9SsUqOvjGUZ1hsAnlZXHI=;
	b=KzC/8A9Lz62F1nMcWYUrZM4L5SnNhBET0zkv/SLnyFRDWp7pG/irgvNifzVyPGOsC2z7dY
	KCczDZvXocuAXScvztDQvr1Ca2f3ZXcZFLeVqlJ5Tq/s2vFwXXWmc3jknMuhXX5lRcUPPQ
	xbxrY1XGoSnQXL7ynL1KjP5/YwZCk+4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-GdAc0f3rNPayKqnrhomFlw-1; Sat,
 26 Jul 2025 05:57:00 -0400
X-MC-Unique: GdAc0f3rNPayKqnrhomFlw-1
X-Mimecast-MFC-AGG-ID: GdAc0f3rNPayKqnrhomFlw_1753523819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56E251800446;
	Sat, 26 Jul 2025 09:56:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.53])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7230919560AA;
	Sat, 26 Jul 2025 09:56:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 26 Jul 2025 11:55:49 +0200 (CEST)
Date: Sat, 26 Jul 2025 11:55:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250726095543.GA21780@redhat.com>
References: <20250722132147.GB2845@redhat.com>
 <20250722230341.5a1cc5e5@pumpkin>
 <20250723093825.GA12884@redhat.com>
 <20250723224831.4492ec75@pumpkin>
 <20250724081125.GA10980@redhat.com>
 <20250724082547.GB10980@redhat.com>
 <20250724111426.GA15444@redhat.com>
 <1225B7DD-BF29-4091-A956-FC312679E9BE@zytor.com>
 <20250725101201.GA8700@redhat.com>
 <20250725224622.2d718f12@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725224622.2d718f12@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 07/25, David Laight wrote:
>
> On Fri, 25 Jul 2025 12:12:02 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > As for the latter. I took another look at asm/extable_fixup_types.h
> > and it turns out we don't need a new EX_FLAG_, this version
> >
> > 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> > 	{
> > 		u64 q;
> >
> > 		asm ("mulq %2; 1: divq %3; 2:\n"
> > 			_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_IMM_REG | EX_DATA_IMM(-1))
>
> That should be _ASM_EXTABLE_TYPE_REG() with an extra %%rax parameter.

Not at all. EX_TYPE_IMM_REG needs a simple EX_DATA_REG().

> It works because ax is register zero.

Yes, just like other users of EX_TYPE_IMM_REG which use the "default" regs->ax.
But I won't mind to add the unnecessary EX_DATA_REG(0) if you want it.


> > 			: "a" (a), "rm" (mul), "rm" (div)
>
> The "rm" should both be ASM_INPUT_RM

You have already mentioned this before, but I disagree.

I mean, this needs another patch. IIUC, this change is not needed for correctness,
and the same arch/x86/include/asm/div64.h file has a lot more "rm"'s. So that
patch should probably change them all and check the generated code with clang.

> > But to me the main question is: Peter, David, do we want to add
> > BUG and/or WARN into mul_u64_u64_div_u64??? If yes, then this version
> > won't work.
>
> Looking through the code in extable.[ch] there is actually scope for adding
> an extra EX_TYPE that is the same as IMM_REG but contains a WARN_ONCE().

I thought about this too. I think a new EX_FLAG_ makes more sense.

> It would be a 'global' ONCE for all such traps,

Yes, unfortunately. But lets discuss this later.

Oleg.


