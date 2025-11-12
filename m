Return-Path: <linux-kernel+bounces-896523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43106C50936
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E433B1C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615C221275;
	Wed, 12 Nov 2025 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdHaLX7b"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663632D5936
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762923712; cv=none; b=omjNOFGkIdOwT6S/GYKjx85neyIAfUHykjK4eDLy6fHF+IwL4Lj40ea7riysHHccVxLbfgEaIsV2959QWvk/EE7bZgWJ8xPQOoCIICOuy81YI747ehhDntkx3iAE/KAAwicZ9yM9KTlF/zSrjYTW4snJKRiUJ3LjtWP4Lr/UGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762923712; c=relaxed/simple;
	bh=Jl+9ESLVL5FaLytBHXW8P0yViF+1HEK7OXyFbdlKZy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/RZydPhplWNT8dsmR81wPI0c8KR4qFCbA4tqy9IY7/J5W0mgk7c+VQzPfMxJFrhxtIqbRclanPG5BMttDSd5xw+bWguAa5HgkBCt+SA3gRjXh0X0SKw9ZPMj72dli3A4w9G+WVY1eRM87L4lQlaewTalexOdt80ildQuPvjFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdHaLX7b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3437af8444cso396763a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762923710; x=1763528510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEqxUrDo4eAGicjXuVUlCuGarl146qcNvuN3jCTjpSM=;
        b=hdHaLX7bU9zQUBZqP0JDvrMqiWkPWdXqQ0a76XJaErZGshQrnVewIb5Gzj3rFUlfR2
         CY7ARoad8SM0zXAyeSf6UeVhYRfKmDp1Ls4mfdwicwEl2mHK/BHv1tfeWM8s3MUaAx5Q
         56BqfOv2+Fb9TwbN748QtgCY/WZuMXNJZXRslQRELK98oyNmw2UQ/yWE8qAHsRCYKf4W
         8pfOTOCyledYQ/wex6cfUJsnEkBkIPdxDTzGPw8rR5UvNME4NipZHzxqZl/q+7zHeqx9
         SxCM6wARUovBge0FTUVoiGxIwgRMjcXAh916HeVBeqJC+cbgzfYzI+7rQ2wSqAvDc8ZK
         VYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762923710; x=1763528510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEqxUrDo4eAGicjXuVUlCuGarl146qcNvuN3jCTjpSM=;
        b=NLQVrygIuguDe+AGEEQyizGwX3YKSPPouSNFiEPlc1B6NiIXsw+na3GGlY+hzosllo
         I6rVZKhbynshceAVYsFqjQ3DWoIj1/A0GZk66COypBJ95rqJyL/FvEb9khtGGnzbFq98
         d7YkbOz/C5TqS5JgnW40DIzdhwELKYGoFpQHxu1PW24l5oyF+UAis9d4CRNsNMiFhmSj
         ETeX6MJW8WszxQhzxNTl4cBwBBWlwAR64Alim/fEauAlNorgBMURBxQgWJQ5jbuSddmu
         qWGFG2nuGGXIFEz/G2vj8frpLc3f8hNDIavyaJ+N8VkLPiY4Jc1NpIXZjL+b9nm/8fGQ
         jNKw==
X-Forwarded-Encrypted: i=1; AJvYcCX+IV4PLDnBSawnELujwaDHvvkUVbaETUbiEFPednF7+xYWAMFvpqnMmZ6bYkc+Jfj/Agh5ml7jSfaw01s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEWgJGEidBQ6czw0xzIieL+3cX4/pAdEt2U0l2AgCB5L7wy1fk
	FTzyE6opOMbmdQSPq9y4Cmi40X+tPw+6pLXC31r7wUzgtPii//oYIDgIgS5JaGVqQdaWBIOJEtm
	3SojQMIPjHt38aThdHG7RzU43msotDHs=
X-Gm-Gg: ASbGncsbAnjCUNBm6AieT7msGC8+nQgrkuadxmieqSARVTnQuMI7zgBjUiStGtGDZon
	nYJe5A3BbTZQXjnpBb1ppHKqU//urZZUWu7YFZIWwU8aZ35csAzC6e0iW08hZZL1xtK3BJ6Xcn4
	Y8XaL4yHNIfAWbwMtlAMmuFHzKrEDkZ9Yr3IQt4Fv1IXPti0p17/0vLIid7qhNDp0BWeVmulyEV
	RbctUp7C/o8FrtzGNqQgH3PLVQpFtS+Cws63n5CARALLjx9mgVZHDPdq0u+
X-Google-Smtp-Source: AGHT+IETiObzHX/VV0cXhzRIj4fxF8f+A6mx5E8ehEokiBSNKi8vQpl+G4sLTeK/RZ4j1aYpnw7SHZ9/20pZW/k7FFM=
X-Received: by 2002:a17:90b:4b89:b0:343:87b1:272 with SMTP id
 98e67ed59e1d1-343dde81703mr2078084a91.22.1762923709575; Tue, 11 Nov 2025
 21:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110033232.12538-1-kernellwp@gmail.com> <a1e5a8db-8382-4f52-8ef2-3b62b0c031ab@linux.ibm.com>
In-Reply-To: <a1e5a8db-8382-4f52-8ef2-3b62b0c031ab@linux.ibm.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 12 Nov 2025 13:01:38 +0800
X-Gm-Features: AWmQ_blTs6lsj4lMAVntwEn7Aq9KSMnBiJfURBdxfrpnbZr94GZ6piTCM43MK8k
Message-ID: <CANRm+CzVtzgYYwgaqEMmsOAo7m=Esd9rd-zbB7zXzgL_p5SgxQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

On Mon, 10 Nov 2025 at 20:02, Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Am 10.11.25 um 04:32 schrieb Wanpeng Li:
> > From: Wanpeng Li <wanpengli@tencent.com>
> >
> > This series addresses long-standing yield_to() inefficiencies in
> > virtualized environments through two complementary mechanisms: a vCPU
> > debooster in the scheduler and IPI-aware directed yield in KVM.
> >
> > Problem Statement
> > -----------------
> >
> > In overcommitted virtualization scenarios, vCPUs frequently spin on locks
> > held by other vCPUs that are not currently running. The kernel's
> > paravirtual spinlock support detects these situations and calls yield_to()
> > to boost the lock holder, allowing it to run and release the lock.
> >
> > However, the current implementation has two critical limitations:
> >
> > 1. Scheduler-side limitation:
> >
> >     yield_to_task_fair() relies solely on set_next_buddy() to provide
> >     preference to the target vCPU. This buddy mechanism only offers
> >     immediate, transient preference. Once the buddy hint expires (typically
> >     after one scheduling decision), the yielding vCPU may preempt the target
> >     again, especially in nested cgroup hierarchies where vruntime domains
> >     differ.
> >
> >     This creates a ping-pong effect: the lock holder runs briefly, gets
> >     preempted before completing critical sections, and the yielding vCPU
> >     spins again, triggering another futile yield_to() cycle. The overhead
> >     accumulates rapidly in workloads with high lock contention.
>
> I can certainly confirm that on s390 we do see that yield_to does not always
> work as expected. Our spinlock code is lock holder aware so our KVM always yield
> correctly but often enought the hint is ignored our bounced back as you describe.
> So I am certainly interested in that part.
>
> I need to look more closely into the other part.

Thanks for the confirmation and interest! It's valuable to hear that
s390 observes similar yield_to() behavior where the hint gets ignored
or bounced back despite correct lock holder identification.

Since your spinlock code is already lock-holder-aware and KVM yields
to the correct target, the scheduler-side improvements (patches 1-5)
should directly address the ping-pong issue you're seeing. The
vruntime penalties are designed to sustain the preference beyond the
transient buddy hint, which should reduce the bouncing effect.

Best regards,
Wanpeng

