Return-Path: <linux-kernel+bounces-871160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BCFC0C8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C4319A2346
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DFB2FB98A;
	Mon, 27 Oct 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQR4/MBP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUACJbDY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3632F5A33
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555433; cv=none; b=sUxfzo+hzQz7SO5hhi9mFN3tPZcpuhIBg78qncnBAKAa0+2DvQUFrj0k23R404fd4KlI+ui43OyEHQmEcG2xnOa69zvZzAD5P8la6MWsR41538kFZ6cBRPMiToF3oRlDznt7dx0c3OSfRO/WWKTVz/xMeBS+iz9U+vOJ7+jQdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555433; c=relaxed/simple;
	bh=XzUzgNsWzAH8d86T0v4DRLsaxZqRLfMHXw8J2RV8+Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GU+GBT5VMdowivkaRQ8+cOHBR5dpc9I+9hMY4Y/K9S3SI1/agaFHbantQjA28ynb5JZaFe4nXUGuqgmWIgotvZ1CjI4Wj96tYvEanEakSYBkUbJW0qlhEUZEuxOlQtV/fgaK4Hxt5MFz39vlIV1QW79SUnIXrCHF0EVH8wAJoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQR4/MBP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUACJbDY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761555430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+yDgn6Ck5Kv94QtFEuwA9qgOSpLSx1YBLJbSeKWqig=;
	b=hQR4/MBPvj4U5IB9emN+mI1hry0d8HFyYJQLoFvPj73LfxC14LCXAb6mNLOtA5RexGOMfU
	7ij5GXXMVkDn+H6XdN0cvyxeJT16Hiku3B4QK6KCc+xmdNBCLUlUrzYvdp8ZSL3ykGceSa
	jdNnSrsP/ya82XGsGl5E18y6WObi8Rg3UvnSuqKB5bS0+lmNwlZV+A/AWyw0BAqJ5fFWx2
	uhNbez4wjkbZEEJR1dfYbVPRZOYkNq0jWpVbiQAJUOiHNETLsVPxWTAQvkoZTk0PXIsGs+
	DyPrv99ktsbV1VXI3bDvOreYHmgbHhrnMjRIsAEsXfPT4Fc/cc1JF6thYAraug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761555430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+yDgn6Ck5Kv94QtFEuwA9qgOSpLSx1YBLJbSeKWqig=;
	b=DUACJbDY8xR3k5+skrdlDIwF5V3s/FYPzOkMstHNuZOVNW9N5lgm0pWORdnXTK7SY03B7g
	TqwixIi7h4yeboAg==
To: Shrikanth Hegde <sshegde@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [patch V2 10/20] sched/mmcid: Convert mm CID mask to a bitmap
In-Reply-To: <6f7b0688-6c92-4901-ab18-d348e667703e@linux.ibm.com>
References: <20251022104005.907410538@linutronix.de>
 <20251022110556.029862568@linutronix.de>
 <6f7b0688-6c92-4901-ab18-d348e667703e@linux.ibm.com>
Date: Mon, 27 Oct 2025 09:57:09 +0100
Message-ID: <87ikg0wwm2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 27 2025 at 11:15, Shrikanth Hegde wrote:
> On 10/22/25 6:25 PM, Thomas Gleixner wrote:
>>   static inline void mm_init_cid(struct mm_struct *mm, struct task_struct *p)
>> @@ -1363,7 +1363,7 @@ static inline void mm_init_cid(struct mm
>>   	mm->mm_cid.nr_cpus_allowed = p->nr_cpus_allowed;
>>   	raw_spin_lock_init(&mm->mm_cid.lock);
>>   	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
>> -	cpumask_clear(mm_cidmask(mm));
>> +	bitmap_zero(mm_cidmask(mm), cpumask_size());
>
> Could use num_possible_cpus() here? CID are bound to be less than it no?

Probably.

