Return-Path: <linux-kernel+bounces-726122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A098B00869
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1931898609
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901222EFD85;
	Thu, 10 Jul 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asEOVvLd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A902EF9DE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164361; cv=none; b=h6YhTHN6NhaOFaqI4+P5llGsI3Ei0rLyKKnPlP9nQN4jnSnyOCncGYRwPeGkiTAYpevYTW9wJF/4EwHvU8wlTTArOBWTKQtJpSsSn645azmCHPzWV/TnSUfH7Yq/r1DFGXCrIS4wI1FaYB6JiU4jLmkovI/tf1HvK9VzENHZ65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164361; c=relaxed/simple;
	bh=YmAxF8TR1lUnIWjvJfSysEiQVexi9iMpay8Rx18dvyA=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wr52Q4eJTbtcabmWmz11LES1S7EJbxXdwifRZWxPIha9aQyQ6R65bPnBmXFqe08VLFivMtCsvc2wI7eARmb4W3YPA+4eO2W5YG7p4LYpUF9edkDOZvA+2HQGDrLMiE1OQiXa586CMui8J0nJ3xXCHRJDii8hVhrt9WHQZpHk+1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=asEOVvLd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jb8MxRFJ7YDicHzCqkcmOzetiDqrKlL6YyrmCbXyEbA=;
	b=asEOVvLd6l4owXYrD+hzpSV3g6KVC9HVUH1UMxPZPIULpT6vRMa4QdPanOAQXQxiAdE5d2
	aPoMPKSzjFfY2cGL0jFAl/CiHgDZU+CJkKm2As6YErW09spX8EKj0+IC4h7olqnsr+WxsQ
	myryzf9/m9pSpC2ZbNDQ2P5wrKalOJQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-qoDx9hBuNAKLp320YKCGsA-1; Thu, 10 Jul 2025 12:19:18 -0400
X-MC-Unique: qoDx9hBuNAKLp320YKCGsA-1
X-Mimecast-MFC-AGG-ID: qoDx9hBuNAKLp320YKCGsA_1752164357
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6df0c67a6so795890f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164357; x=1752769157;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb8MxRFJ7YDicHzCqkcmOzetiDqrKlL6YyrmCbXyEbA=;
        b=FQRKqMWsumMVKROc9Zc7UBlMdi61dNkKQyZSZwakTBhnfEzSctU7PpzKODo21h7HIN
         LexwRU8AH3LE7cL3bCurEi1k/6i4mBvINyaV+r7rsjDbj8Pmd563yrrEoDJZkTo1oOWr
         5pOOmpm22u3vxLMT9lJFaNSRh6IMwooxaluOEWerd2vXcfP32Y9SP/2HuYQfE/rc4xIK
         LtNdHMqDdlVDUQF5Q6tFdcHuNllVxQF1+Wn1w2NZwiZN0UOQtNIu/T48MV+fbzlNGz/M
         LsSEe/5OnmUfBlu6uwAOpWd0AX9YFjPboG/SsQSVh0gKbF0Kw41Ip23/EdVNguIuEzHY
         0wOw==
X-Forwarded-Encrypted: i=1; AJvYcCXx2iQElIn/OVuYleG6S44O5NnR9u3ry9xIES03V5qxT8RoKQJgDE5knxPALYn7f0NeDFR/x63O5FJej2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB26SCOhZJ+RrXGdn1K1Tuar1nysk4CvIqJ5GvAH1Kv+PFd9R+
	SW9P2umgDsaNmwfsvBxNdfYks0RrqaRLkuS+10gGmF6WxKwcgUX/8HhFxacAaU83Kk5uixMJE+M
	ppSuehPnzWHvSKTC3QWVlz7edGM+M1DBTcmHpF1bL833UbG5F86L4cQ/4yhZc8sresA==
X-Gm-Gg: ASbGnctgUfo9S5t3QH+p2dqMOgqnZOor0nDuIPFsmZyr0XCKmUFdfpICcw/YMxw9P7J
	7Wa/YKqhj9JPb8zmaPY+neP1QC1Owqr54BIn512x8Wwkbotgn7bNRnHvQwXcEti7csDv20+lNEg
	tSBj+5k2BJPSWMPnOt2Lu/PEDNeGn8M97a1selQGPfWXhB+R15osQ3R+I9gFNYOEu8kr8j1iNoa
	m0SqCESApII2kre7LttLkoyILPqTH8mEphNkPMKjYzRP+41yQHFK7eEQqtv4ByopQbie3IL4wUz
	yiww5QVAZZZWO3irJi02aSh05Ijqz/9hVlPzmlM33KW0IqhOoD6J1Hvn3uCRz0prEiLj6NWs8Tg
	W1/z3WE8=
X-Received: by 2002:adf:b643:0:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3b5f18a7a4dmr128570f8f.54.1752164356613;
        Thu, 10 Jul 2025 09:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVAL5FTUNSY5NUppJgN69V9ZILsCc0pG1G2fmP70vWMvaMiOrIkOTJseQOmniZXHYXrNxzCA==
X-Received: by 2002:adf:b643:0:b0:3a4:ee3f:e9a6 with SMTP id ffacd0b85a97d-3b5f18a7a4dmr128529f8f.54.1752164356213;
        Thu, 10 Jul 2025 09:19:16 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ee1sm2221730f8f.23.2025.07.10.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:19:15 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, David Vernet
 <dvernet@meta.com>, Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Juri Lelli
 <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, Mel Gorman
 <mgorman@suse.de>, Vincent Guittot <vincent.guittot@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>, Wander Lairson Costa <wander@redhat.com>,
 lclaudio00@gmail.com
Subject: Re: [PATCH v6] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
In-Reply-To: <aGvTz5VaPFyj0pBV@uudg.org>
References: <aGvTz5VaPFyj0pBV@uudg.org>
Date: Thu, 10 Jul 2025 18:19:14 +0200
Message-ID: <xhsmhtt3k10jh.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/07/25 11:03, Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
>
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);
>
> This is not a SCHED_EXT bug. The first cleanup function called by
> __put_task_struct() is sched_ext_free() and it happens to take a
> (RT) spin_lock, which in the scenario described above, would trigger
> the lockdep assertion of "!current->pi_blocked_on".
>
> Crystal Wood was able to identify the problem as __put_task_struct()
> being called during rt_mutex_adjust_prio_chain(), in the context of
> a process with a mutex enqueued.
>
> Instead of adding more complex conditions to decide when to directly
> call __put_task_struct() and when to defer the call, unconditionally
> resort to the deferred call on PREEMPT_RT to simplify the code.
>
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Reviewed-by: Wander Lairson Costa <wander@redhat.com>
> Fixes: 893cdaaa3977 ("sched: avoid false lockdep splat in put_task_struct()")
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

FWIW:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


