Return-Path: <linux-kernel+bounces-754200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF6B18FAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 20:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630CF3BC4DA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4097A24A057;
	Sat,  2 Aug 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U9vMzmrx"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DB1A5B86
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754160242; cv=none; b=r2C0mcxyQpkPfgdcMUBIMcm1Phzhp2fS0Mz3XZ+CLeLQ4I/mEX0V8JW3z7pV/Sdc35g+RwR9YvK0z7rdtGhj3czbWqFmjmpEXipCspQJWxTvuSG1t8X9c7nUl+SbsEnO2gio6vaZkOavEM+OIxa7/fK6hg5CoZ5DoY/70hZLhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754160242; c=relaxed/simple;
	bh=MEDjJ6IZHbO/pLdz03Pt41wZbLNceAm9tgy1am66PoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evdypnr///ykYEs4hXekd4aph61ckM0HmS168mPimnM/8kXwdxtLmy41v6jArPCtG+GlzAibBT/klwlhZ7P8n/Thm4kO0H1Zort2dfFsNP+1e9ywq0nNtgu5Fp1RENOXW9gKIMbt9pavLxMP5Su2Nzj4YoZf16ZT7wubT9QzJtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U9vMzmrx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso5501863a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754160238; x=1754765038; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C0eFAYHftl+u3oj1hj6FjhN5WfviUosYL+n2VwWadx4=;
        b=U9vMzmrxadgNdsnr2Du1uDZ69eD+uIFQoKO6Q1XuGQd1jd+LoruZ3Swzj1tSLbR14Y
         auCHvaX/3ghGwC71u66r1qL/XH+XXlk5NAb2wIUz5Xpvhq3XWc5Vw/szttrwLVY/XJgN
         t3bPQWfJdF3NjnxtHmTQU9FRLOpZp2doYeZRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754160238; x=1754765038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0eFAYHftl+u3oj1hj6FjhN5WfviUosYL+n2VwWadx4=;
        b=B1npD+Nv7czkxpnvXwytu8wpMJao6evZ85RqpLylpIRww695qHin8D4EGieH6TI62G
         KlwmZ1vL0tHapf9TD9NsOxnwcLbn9HkTSX8si9SnqEBSiYuBTCR/XeAKoTqI/CMh4Z1d
         e5B/PnC1IXNM6q+rssuCRWrNXJx3+qOMlijQNMl1bAXVYs83mJcLDFpxdpfuWE+zjCZk
         dqCX3eiA2AbLiOOTxqEz9+SNMxJoSDiJ24teIb/EWK5G1ZJd5BYRq2qFZx1+otPuCmvy
         +ui3arlE3/al+MEH/M8YrYKxukwX0K+4nyRxvqUFEMtt00iWGKDYHIxL5C8qNlDdLTU/
         2YrQ==
X-Gm-Message-State: AOJu0Yz8Fq0deS+I6/OEOxUcq0e6VXTsPR/9p6BEmREa3P0bNJY2wTuH
	Geh03KR031l3y+CP0vUCx7mfTjUo0hYwv2scC1V7vqZ0M5RkiWopvJaAha42Kl6j0MHcpCCu3gQ
	2+vVkIbDr0A==
X-Gm-Gg: ASbGncuBv0cZkdCuCvw5LdEmeLxHQtxtbPmSz2QL3aSKyKxhO5Z1t5Lw1duj4xrGtvb
	86qj7jlebthIG8t4kcQLHtefAhMhCfK7A9hh0E0wVSRQiX0EdbauUqBVRi+B18RX8Ok5p+9cQJ3
	TiglYPGIzGI1yF462vg8ojw45e5T+wf49Sng0jo/A10MdlqLiLMU0akMJnueB8PQDUUtvETKJhs
	2wC0+4JqqdWWKgKyTvlnmGSo8hWbom2xB+EClFRbE3A0We8Ch4ffjUE9yGLQRlYvVDeErjZwdKM
	GNeNAdW21wU6jEQB7ceKskUhJZA5iTJa+1CVW2fgwZTHDSOBQh85s5gazJyd5tp6/bB5OPqba7D
	L7ZBGWB+fHqYiSfZn7JuNXRztBzE15dPph+uex6PRGqyAKxa1Nj//b5t18ht0yOzyZ4h5mXSB
X-Google-Smtp-Source: AGHT+IE0l7X3g3WWQ08CIYrOHedFWbFCQ01t9Ck40I1uMDqmeotqNnWTEtPPwUyMarcPArdEQXQqMg==
X-Received: by 2002:a05:6402:520a:b0:617:41ce:6fa0 with SMTP id 4fb4d7f45d1cf-61741ce6ff1mr441217a12.23.1754160238110;
        Sat, 02 Aug 2025 11:43:58 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a911a5afsm4387436a12.65.2025.08.02.11.43.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 11:43:57 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso5501847a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 11:43:56 -0700 (PDT)
X-Received: by 2002:a05:6402:1d32:b0:615:7e5b:7a23 with SMTP id
 4fb4d7f45d1cf-615e6edd617mr2858724a12.8.1754160236621; Sat, 02 Aug 2025
 11:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIcdTI3e04W_RdM_@gmail.com> <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
In-Reply-To: <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Aug 2025 11:43:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
X-Gm-Features: Ac12FXyvjziRl1ca9AAwZkZOSpY9EC0m8uPhlZ_x9NozSwq8eqozJnbLh9TyzoA
Message-ID: <CAHk-=wg7Ad6zjs8QdgDkS-8oJD2EbLK2Ne-WRo36ZXVHa=hmWw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 20:31, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 27 Jul 2025 at 23:48, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > PSI:
> >
> >  - Improve scalability by optimizing psi_group_change() cpu_clock() usage
> >    (Peter Zijlstra)
>
> I suspect this is buggy.
>
> Maybe this is coincidence, but that sounds very unlikely:
>
>   watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:3:7996]
>   CPU#0 Utilization every 4s during lockup:

Happened again this morning, and as far as I can tell the machine was
just sitting there idle at the desktop.

I've only seen this on my laptop, so maybe it's some hw dependency,
but it *really* smells like commit 570c8efd5eb7 ("sched/psi: Optimize
psi_group_change() cpu_clock() usage") from the symptoms. It's
literally hanging on that psi_read_begin(), which is that
read_seqcount_begin() on that new per-cpu psi_seq counter.

Now, I'm not seeing how it could possibly trigger - I looked through
all the psi_write_begin() users, and they all *seem* to be (a) under
rq_lock_irq and (b) paired with a psi_write_end() with the same cpu.

But the symptoms have been very consistent both times it happened: the
RIP always a watchdog in collect_percpu_times(), always at that
'pause' in the "wait for seqcount to be even".

It's typically been in that psi_avgs_work kworker, but once it was
systemd-oomd that apparently had done a "read()" on it, so it went
through "psi_show()" instead.

Now, the *writers* all take the proper locks, but the readers don't.
And my laptop has CONFIG_PREMPT_VOLUNTARY in its config (random old
setting).

I'm not seeing why that would matter, since the seq count should
become even at some point, but it does mean that the seqcount read
loop looks like it's an endless kernel loop when it triggers. I don't
see how that would make a difference, since the seqcount should become
even on the writer side and the writers shouldn't be preempted and get
some kind of priority inversion with a reader that doesn't go away,
but *if* there is some bug in this area, maybe that config is why I'm
seeing it and others aren't?

Any ideas, people?

              Linus

