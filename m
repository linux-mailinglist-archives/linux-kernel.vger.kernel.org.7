Return-Path: <linux-kernel+bounces-874833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E89C17304
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F4C3A38CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E63557FC;
	Tue, 28 Oct 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="So+JhCCZ"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652162DE6EF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761690414; cv=none; b=OMtKcJjxwiqzgLDIVuZHgp3qyPEd0VbkUPwGuleyltcoSzmj0KCjJCWSn3rRkIGeH0/loje1UnhSPDZ2rPDYrPx2WE1ieYytpW0rubqlL2D54Dq2jj7HnHXFzuhigCJFriNynSb/wN36Raj24N0KGCD0dFEP15uUO3mky9MhHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761690414; c=relaxed/simple;
	bh=a6pAU7QlGKPQhiPVwBdKOoKYdXk/wLGXo3K7rfw5OnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJfJ3AXa1JHVKk6kGh/v+/6k27OINfyAYLRZ6IW42Q4dUm9MZa0uRq9W9Hf+hYQxZ5wAu1krjNyteOljcbJfasA0aDtJea2jwm+KQWrCe0y+Oqmso1lW4c186GwDIcZE0tWp+0emBVozg8Sy/ICA6Ea/i9hG5l3uBewJU58VYlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=So+JhCCZ; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-934bbe85220so1896720241.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761690411; x=1762295211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6pAU7QlGKPQhiPVwBdKOoKYdXk/wLGXo3K7rfw5OnE=;
        b=So+JhCCZLdIJuk4b3ZOkPB7VqUML5XgowzjhZGP5es5v3QpHlTsJu/qluUGLS+Bwbd
         bzn4Y6FXHxN9nyp1Ll89vKXL0suv2ZYnI+5nrGaAzuMoPFPcrcI9Nz3W8xhxcPTYvh4S
         uE2ia/IfNu86D938donhdSMn73EdvSoNugCg0yrg1sQQl1wHzyHZftkHyUaCpzpaRoDQ
         bsvpQqSBMP8zk7j5h0b+mhAmyrXTBjfDkB2kORbSkPt0Ovz/8D6AktICYSup/GxnVMiE
         Op7KIS2FhegIKXxv13VQGYu1JlGl4Gsb5YjlEZEOautnmW6EJXz3MYo1xJ03q56EpeQz
         LCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761690411; x=1762295211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6pAU7QlGKPQhiPVwBdKOoKYdXk/wLGXo3K7rfw5OnE=;
        b=rkjffS503GpO4rRU3vab6W32Wj7xrv9NIwL93+OyLKKsLW6TSZrrK4ZN4FlLUZSrNN
         cvBpdLrHnhwpY2uddxIwUO86ziAlIp2diFPLAuuX1vS5mLKqGnvqWre0iZvxYqKG80eW
         3oValrZKf13c+mx9m3S1eWaZTaIYgT24VdTeQNhBgCHKnJc503BfpXXt1orLy/Eq3DbA
         30ZFu1FeYMp8UEyQv1N07hsZH7mGepMM8g/XjUfb38YVC7QhZN84sl6tf6XUS0QiU06W
         qPEvirQjAh09z2XUoU60VeKY1c46aKM5uUgjd/bu2vXN/RWYsmYcHXA0FgUv0InoGSGA
         cHSw==
X-Forwarded-Encrypted: i=1; AJvYcCUZcQbWur61IpsAbNg/vl6xk0rWwKSNQNU9pr4OJfeDPmOgey2T3R6zrAlVB5iXBzN/UdcJbkBJQcmmu9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnJT7CrubOPK+uh2ZN5/ahjJXg/HRWTUalmx84POfc98DiO5C
	E6UMqJ+ogXf4T9mpTV49NnslzpNUBJgXd2O9pvQBwuufmDw5GXzu30x84wXOqGlx21PX7/rmBGQ
	XvNnVsbSTQpGVuTbz2rfoNjfcZuJSkmopooXbHiwO
X-Gm-Gg: ASbGncudbQIPTqqLRm5FdvY6iBJDn2pq8ne0wMurb9N/tBsiso7y26ZoitGS3FvlJ4b
	2xPs1wPTxuGloml4cQ1CCI/KlY6RQ0bDvRAsvawFepmCf++PtB+Q+lgKi/FUNJ2J15MaBZSzaU8
	Q+5C8NbMMR3yopJ/NDgfxEnBrlvM25ZEyjrOwqVMcLR6vs+y0voSAj9cwAHG6CraFJersth4hir
	2MSo/TyqrNfFWNeTwX3V79nVqcBQArwWfK+ppKwFdgUo80MtivyNm+uw8924M4/7hYbthWYNrQX
	wXjj9SYNTs9e+uA=
X-Google-Smtp-Source: AGHT+IEjN3kheu/BsYwRD1Y/T2LnlKP5NgGHnsSh37lbW6uUdo2JaXwBAfWg/cLk3xu6DsVoxTMt7V6+RGa+0uf1OWA=
X-Received: by 2002:a05:6102:38cd:b0:5d5:f6ae:74b9 with SMTP id
 ada2fe7eead31-5db906ab2e7mr204584137.45.1761690410981; Tue, 28 Oct 2025
 15:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028080348.2177469-1-blakejones@google.com>
 <20251028112901.GL3245006@noisy.programming.kicks-ass.net> <CAP_z_Cj_hVicedOGUCnXNVDXp_dWbG4az5J_w_g0xTMCTuuUrA@mail.gmail.com>
In-Reply-To: <CAP_z_Cj_hVicedOGUCnXNVDXp_dWbG4az5J_w_g0xTMCTuuUrA@mail.gmail.com>
From: Blake Jones <blakejones@google.com>
Date: Tue, 28 Oct 2025 15:26:39 -0700
X-Gm-Features: AWmQ_blQoQPwHzG23PJKtiySxwjrDH6r6KaDOQ49b62D18r0KLYcZmnGbQPNV8E
Message-ID: <CAP_z_CgtWoJ8CAm=hAxJMcWrGMoi=OPj+Axsu+sMyZ_BuuHVxg@mail.gmail.com>
Subject: Re: [PATCH v3] sched: reorder some fields in struct rq
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Josh Don <joshdon@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[I thought I'd turned off HTML on my reply just now, but apparently not.
Sorry about that. Re-sending so the list has context...]

Hi Peter,

Thanks for your questions. Here are my thoughts:

On Tue, Oct 28, 2025 at 4:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> queue_mask is modified right along with nr_running -- every
> enqueue/dequeue. It seems weird to move it away from nr_running.

My main goal with this change is to optimize the first line for read-mostly
usage - specifically, for the loop in update_sg_lb_stats(), which loads
data from many rq's without locking them. Data from some Google fleet
profilers showed about 38x as many loads as stores to these fields.

From what I could tell from your patch, queue_mask is write-mostly -
enqueue_task() and dequeue_task() update it, and sched_balance_newidle()
stores to it and loads it later. That's why I didn't put it in the first
line.

That said, the place where I relocated it to is somewhat arbitrary. I
mostly put it there because it had some open space on that line, though
its new neighbors prev_mm and next_balance are also updated somewhat
frequently. If you have another suggestion I'm quite open to it.

> Does it not make more sense to put the lock in the same cacheline as the
> clock fields?

Great question. When I was first playing around with this reordering, I did
some more substantial movement within struct rq. But for the versions I've
sent out, I decided to keep it focused on just a few areas where I could
tell there was clustered usage. I didn't want to over-fit the placement of
a whole lot of fields in struct rq, since the code inevitably changes.

So I'd be open to moving the lock to the same line as the clock fields if
you think it would be a perf win, but I don't personally have any perf
numbers that could demonstrate the merits of doing that. WDYT?

> nr_iowait has cross CPU updates and would be subject to false sharing.

Mmm, good point. I moved it back before the clock-related cache line to
balance out moving "clock" and "clock_update_flags" to that line, since
otherwise it was going to add an extra line to the structure. But also,
it had been on the same line as the various clock fields, so that false
sharing was already not doing us any favors.

The line that I've moved it to has your queue_mask, so that's probably not
the best place. How about if I move it to the end of the structure, next to
cfsb_csd and cfsb_csd_list, since those don't seem to get used very often?

> Does the thing want a __no_randomize_layout ?

Well, this is by far one of the hottest kernel data structures we see at
Google, and it's not an obvious thing for a security vuln to target. So I'd
be quite happy to add __no_randomize_layout; if you agree, I'll add it.

Blake

