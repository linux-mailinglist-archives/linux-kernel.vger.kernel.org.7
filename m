Return-Path: <linux-kernel+bounces-763631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44724B217EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B7C623B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947792E4248;
	Mon, 11 Aug 2025 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBRwsTLA"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B432E3AFC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949894; cv=none; b=JyVJbgPF9wLSGfhkZimbXx2vt0S6LVl4tJPWno0WgxEK1N3W9F6+Lump0ZAwJnZIa96+N1+0WC7ySa4TXQjHZYVxUardrVwk2WSbHMr3R5ZfyyqlnvXKOozVAGlOq52wsTbaQNajnjt7EtoIWP1k2DG6uKn1vfpprsXJ+yek4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949894; c=relaxed/simple;
	bh=HFRMJILUx04e7fKt9LkmjdYNj+zwMID9MEScB+KBfxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a+42APS8hFHPpjodD9nN03XCmghzi7+n/fVGubhrDt/e/ODkNOkjVwPOlVK/PplsZ6QtgB/ovHH79V4igiC3+rOup3g42jcLkjtb87rw6j2QlZiuCVZvpdVRnBQ5bf3puZuKEgKCZMm8svbWZu7xsUP4ZsEIx3i+9ucPluNJ+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBRwsTLA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so3629374a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949892; x=1755554692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7vJ1PiJBGG7zEvp25Z73MIEIXUg5MN85U43tAoCiyk=;
        b=LBRwsTLAnljdvCNZj7JRC3l+jDNczF/qfQgiZEY+Mh3A8hDJOOW2O6zi+HrOv+V4q6
         Z8YiU/56nZ9OO6tqtp9ju0V9UzUFIloruXMCz105mta/nbdJ73GE1Hd9AL9fFJnKak24
         6z761PIcqtS3G4S5VwY89LGd7bc1iPDZjA6MJB9ogEe8iJhT9aAu91UxrycxhDPnyd21
         IorI8wb8mdNLwPXNfrckfna88yZyMIhUmmqkJNa5OUlkXoUqjn57JlKdq53fPpuZgk/7
         ceTKKUm03fkBYzRyJo67+Fhea7IZHLv7ZOwJlfUw8sMaJ1OciVDB/vHfDx0LBOEW6bIE
         4Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949892; x=1755554692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7vJ1PiJBGG7zEvp25Z73MIEIXUg5MN85U43tAoCiyk=;
        b=gdNW35ZbDU0lBjBduGcBqEEfd+BSCnapXpKfVHATzDWWcnojZ70xxKTTBrO56onlK4
         4MNGTFtulUxkZqsF9COvxXAQAq2vJSe1mpuRjlz5SjnBIdMShgxSKDbZZQkuJq4iqByP
         bsE4vrRTwDJYAlvaEDTWvr/H3otjz2joDffpXBzmqp/cIpRFdO5d/H5mNZH4qBdmuz31
         E3lsljz+ZoiUBdEgeJMODtFokAsvf9AwZ4CPYw51q95hosJA5BnO91VFLytn5Dr7jlod
         psKW/UQC4celLjY3fq0nF6tK4m4igHV1cNqnwj4DTJ6LuPv9DrbUi5uQrsFoahtdeoCc
         EMuw==
X-Forwarded-Encrypted: i=1; AJvYcCXvCPhe7J5DTrDq4j5lYJ2ZKAWOAYRFfpwscCCOE7kbqh2pvaeDbW4miixnsKuxHNKKBiMQl3hxhmjjq6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xsQqaZRe2YnMwbROYlJJkrbsgc0Y1yWje1UppI64QjWCEqFD
	JhDDsGKT+HyMfJztqiwJwjWOx9SiOXjDNKiT675b1YZvQA+1kuzWoBiSoF+MJH+VmneqLZCyTWV
	BXSlyJQ==
X-Google-Smtp-Source: AGHT+IHZ635b9SjY7d8RUHZcAjaLQmZND7zjYFIJgLQ6XF1MQuhYWcWzho0k/wPxq5HS3XBXtiNcyc5SDhA=
X-Received: from pjsa15.prod.google.com ([2002:a17:90a:be0f:b0:31f:26b:cc66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3842:b0:311:9c1f:8522
 with SMTP id 98e67ed59e1d1-321c09fc527mr1632717a91.10.1754949891756; Mon, 11
 Aug 2025 15:04:51 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:04:50 -0700
In-Reply-To: <aJpgZeC8SEHfQ0EY@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811203041.61622-1-yury.norov@gmail.com> <20250811203041.61622-3-yury.norov@gmail.com>
 <aJpWet3USvXLWYEZ@google.com> <aJpgZeC8SEHfQ0EY@yury>
Message-ID: <aJppAp5tK7kPv8uj@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: drop useless cpumask_test_cpu() in pre_sev_run()
From: Sean Christopherson <seanjc@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Yury Norov wrote:
> On Mon, Aug 11, 2025 at 01:45:46PM -0700, Sean Christopherson wrote:
> > On Mon, Aug 11, 2025, Yury Norov wrote:
> > > Testing cpumask for a CPU to be cleared just before setting the exact
> > > same CPU is useless because the end result is always the same: CPU is
> > > set.
> > 
> > No, it is not useless.  Blindly writing to the variable will unnecessarily bounce
> > the cacheline, and this is a hot path.
> 
> How hot is that path?

Very, it gets hit on every VM-Exit => VM-Entry.  For context, putting a single
printk anywhere in KVM's exit=>entry path can completely prevent forward progress
in the guest (for some workloads/patterns).

> How bad the cache contention is?

I would expect it to be "fatally" bad for some workloads and setups.  Not literally
fatal, but bad enough that it would require an urgent fix.

> Is there any evidence that conditional cpumask_set_cpu() worth the effort?

I don't have evidence for this specific code flow, but there is plenty of evidence
that shows that generating atomic accesses, especially across sockets, can have a
significant negative impact on performance.

I didn't ask for performance numbers for optimizing setting the mask because (a)
I know the VM-Entry path can be extremely hot, (b) I know that dueling atomics
can be hugely problematic, and (c) I don't see the separate test + set logic as
being at all notable in terms of effort.

> The original patch doesn't discuss that at all, and without any comment the
> code looks just buggy.

FWIW, there was discussion in a previous version of the series, but no hard
numbers on the perf impact.

https://lore.kernel.org/all/Z75se_OZQvaeQE-4@google.com

> 
> > > While there, switch CPU setter to a non-atomic version. Atomicity is
> > > useless here 
> > 
> > No, atomicity isn't useless here either.  Dropping atomicity could result in
> > CPU's bit being lost.  I.e. the atomic accesses aren't for the benefit of
> > smp_call_function_many_cond(), the writes are atomic so that multiple vCPUs can
> > concurrently update the mask without needing additional protection.
> 
> OK, I see. Something heavy hit my head before I decided to drop
> atomicity there.
> 
> > > because sev_writeback_caches() ends up with a plain
> > > for_each_cpu() loop in smp_call_function_many_cond(), which is not
> > > atomic by nature.
> > 
> > That's fine.  As noted in sev_writeback_caches(), if vCPU could be running, then
> > the caller is responsible for ensuring that all vCPUs flush caches before the
> > memory being reclaimed is fully freed.  Those guarantees are provided by KVM's
> > MMU.
> > 
> > sev_writeback_caches() => smp_call_function_many_cond() could hit false positives,
> > i.e. trigger WBINVD on CPUs that couldn't possibly have accessed the memory being
> > reclaimed, but such false positives are functionally benign, and are "intended"
> > in the sense that we chose to prioritize simplicity over precision.
> 
> So, I don't object to drop the patch, but it would be really nice to
> have this 
>                         if (!cpumask_test_cpu())
>                                 cpumask_set_cpu()
> 
> pattern explained, and even better supported with performance numbers.

I can definitely add a comment, and I might try to gather numbers out of curiosity,
but as above, I just don't see this as something that needs to be investigated with
any urgency.

