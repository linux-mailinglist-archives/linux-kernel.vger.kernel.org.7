Return-Path: <linux-kernel+bounces-898706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD0C55D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407B23B025A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23524303CAF;
	Thu, 13 Nov 2025 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VY1Q6fD1"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D142C0287
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763012274; cv=none; b=RELNvYIVZ1u8KTVmF+CvIMQjKhWA3cOI4lrhZex6qtxVJpSrOYpw3rBoF/PL/l5g9ODurr0/QcikPJBkh+3bEhq1/GPi5BhAFr2jO99wyK3AKayjfUhogE2Q6qIdii7ZaMQmat8/WtqbnNuU7UbiUYxWFpda/kgBlz2k2py3/aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763012274; c=relaxed/simple;
	bh=NLXgfGolnt6T3xBpISVtUuJWVfaaTaXL2M9IDpzffz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEaeMSSGw+BfIVT6itvwcywXar9OP+0lnWz6/N1qs3kyiPHcmk+UpTR8gs3YES3+Pa2EjoiGGfwm9ctrXnM627ORALyr4bp5iWzEu1pA4myEC93CeovLc+UW1uh7DffU1vmtoQGXBg8bbb1ZKGwzCvsECWe5N3nW5tWsdlhwqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VY1Q6fD1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3437af844afso395430a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763012272; x=1763617072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z+EsClr012MBu5yKz0oei20vJI6zAT8gfC7sgIOz7g=;
        b=VY1Q6fD12NaHdKcI8bYxlA7SD7m0rlgHXhhKUtMOEYqRtyun484HTuU2HlZluHcZb0
         1cgE6MbDqZ2BrqOFfpT9OLpPkBN+iz4hQpHCEFXrnhjB158vKAveHWtojCIX4Kr5JPNr
         C1T7zsPMlrFO49ZfYaMJ3gH3iwNgdzemgZuNuKxqhx9SVLKaBSFC8V4uncQnz7BSTgCv
         FWxVg/wGdZbrygZG4zPURwkOclIH/ydcvWXI0EVY1gXwLzjGbbifHZR4cTB4auzbnw4G
         xTwDqCtdA51wkc+6ECwPt1ygj247SMah1ZYEhqCO2MvZOCm+DEIdERS1rBR8xIfg/PXO
         xsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763012272; x=1763617072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Z+EsClr012MBu5yKz0oei20vJI6zAT8gfC7sgIOz7g=;
        b=g8bweiBMkjrVWHReK3pOVmX/0ELi09Qq8BMsWAiT4ypZoZn/Jk5YNm6qeu3FSNOJ/W
         2CEmjm66lLW1FbxI/iaJrBVMvu7EBos/SeCBWCASIo6TAM6b2qnpgCXQ+82p/b2iOT3q
         yk1anKcj4CHl1Hx/yY2p0te54l29qn7blGJXG0svxZl+atLBNZwyvt3UyRD8EmWByIul
         VpEts0+/5NASKJBAjTrmln6sUw6tm8k1bZUX8lyo1H4oQp98tnab9lnpHL1pvnOk6Vj0
         VQchyTjnntl2+bZhmqkUdpHyF5vWd7WZjdEtpVxDNNAV9lUXtxnujEBoF+ar94nGXGTz
         Z7qw==
X-Forwarded-Encrypted: i=1; AJvYcCURU7Hr8vgz1Obog6NDezC7nLDnZNbzYfVfoaNa4/HABYKQOOqm2ORjHTs+eK4uE5+0sTWmkt5ludk1K+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlAcbhzX/lxSOCiOMC7TLYp8wYd/GXRg5jxquTzLIuSJhY99d
	/7/oZMcth/v0wns55JE6R7AqYNGs0jufPcBjHdE3zOhTDTFCnmIOI3UYiP7v6KZZS+BLwiHppqY
	1WzZXK1p4Dj+G5GUlmpK3T5U+xPPXkxc=
X-Gm-Gg: ASbGnctdkSF4bqQoyj5g5kl65046hAi4SiSUa1znBOcvbSDqHMiiUlZjgLx15S60smq
	QR3icpJOCaH8Wmi+iOa2HIMcsAq9eOVXG9XhMHd+rZVbaOh379m3GuWf6RMrNZ81G3xvO5sveaa
	W4UieqBdp93lIepJkwQIJDvgsUUXMMaTc3ewsv1/TTClSKedzsxyCR+Lnz43ftptxl63Sy6Dojg
	NrCY263l8myO/ISua0jyoJ04FncLu1dV5Fff+B/lh+gsnvCHg9fkcYSI2Ow
X-Google-Smtp-Source: AGHT+IFFG9+M51KyAvdzx79GMeJICdcq4m2AzrAOIzyEIbL6zl03qhM7rREZKB5iSrHCHzeg6X+dfKVjwjINPNYNDvE=
X-Received: by 2002:a17:90b:510d:b0:33f:f22c:8602 with SMTP id
 98e67ed59e1d1-343ddec0ee2mr6762562a91.26.1763012272146; Wed, 12 Nov 2025
 21:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110033232.12538-1-kernellwp@gmail.com> <7bc4b0b7-42ea-42fc-ae96-3084f44bdc81@amd.com>
 <CANRm+CxZfFVk=dX3Koi_RUH6ppr_zc6fs3HHPaYkRGwV7h9L7w@mail.gmail.com> <27c6a3f4-ca70-45ce-a684-fe8e9b33efd1@amd.com>
In-Reply-To: <27c6a3f4-ca70-45ce-a684-fe8e9b33efd1@amd.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 13 Nov 2025 13:37:39 +0800
X-Gm-Features: AWmQ_bkdkc-qjApKKjuCRIy_g-D2oms-P06nE8qc2NLXc5PAJvKssZsKf7_rQuY
Message-ID: <CANRm+Cza0iiB8XqD+Jn9-eqAyjDFm9u1vqmyj9eGdVd-mpV7vg@mail.gmail.com>
Subject: Re: [PATCH 00/10] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek,

On Wed, 12 Nov 2025 at 14:07, K Prateek Nayak <kprateek.nayak@amd.com> wrot=
e:
>
> Hello Wanpeng,
>
> On 11/12/2025 10:24 AM, Wanpeng Li wrote:
> >>> Problem Statement
> >>> -----------------
> >>>
> >>> In overcommitted virtualization scenarios, vCPUs frequently spin on l=
ocks
> >>> held by other vCPUs that are not currently running. The kernel's
> >>> paravirtual spinlock support detects these situations and calls yield=
_to()
> >>> to boost the lock holder, allowing it to run and release the lock.
> >>>
> >>> However, the current implementation has two critical limitations:
> >>>
> >>> 1. Scheduler-side limitation:
> >>>
> >>>    yield_to_task_fair() relies solely on set_next_buddy() to provide
> >>>    preference to the target vCPU. This buddy mechanism only offers
> >>>    immediate, transient preference. Once the buddy hint expires (typi=
cally
> >>>    after one scheduling decision), the yielding vCPU may preempt the =
target
> >>>    again, especially in nested cgroup hierarchies where vruntime doma=
ins
> >>>    differ.
> >>
> >> So what you are saying is there are configurations out there where vCP=
Us
> >> of same guest are put in different cgroups? Why? Does the use case
> >> warrant enabling the cpu controller for the subtree? Are you running
> >
> > You're right to question this. The problematic scenario occurs with
> > nested cgroup hierarchies, which is common when VMs are deployed with
> > cgroup-based resource management. Even when all vCPUs of a single
> > guest are in the same leaf cgroup, that leaf sits under parent cgroups
> > with their own vruntime domains.
> >
> > The issue manifests when:
> >    - set_next_buddy() provides preference at the leaf level
> >    - But vruntime competition happens at parent levels
>
> If that is the case, then NEXT_BUDDY is in-eligible as a result of its
> vruntime being higher that the weighted averages of other entity.
> Won't this break fairness?

Yes, it does break strict vruntime fairness temporarily. That's
intentional. The problem: buddy expires after one pick, then vruntime
wins =E2=86=92 ping-pong. The spinning vCPU wastes CPU while the lock holde=
r
stays preempted. The fix applies a bounded vruntime penalty to the
yielder at the cgroup LCA level:

Bounds:
  * Rate limited: 6ms minimum interval between deboosting
  * Queue-adaptive caps: 6.0=C3=97 gran for 2-task ping-pong, decays to
1.0=C3=97 gran for large queues (12+)
  * Debounce: 600=C2=B5s window detects A=E2=86=92B=E2=86=92A reverse patte=
rns and reduces penalty
  * Hierarchy-aware: Applied at LCA, so same-cgroup yields have localized i=
mpact

Why acceptable: Current behavior is already unfair=E2=80=94wasting CPU on
spinning instead of productive work. Bounded vruntime penalty lets the
lock holder complete faster, reducing overall waste. The scheduler
still converges to fairness=E2=80=94the penalty just gives the boosted task
sustained advantage until it finishes the critical section. Runtime
toggle available via
/sys/kernel/debug/sched/sched_vcpu_debooster_enabled if degradation
observed. Dbench results show net throughput wins (+6-14%) outweigh
the temporary fairness deviation.

Regards,
Wanpeng

