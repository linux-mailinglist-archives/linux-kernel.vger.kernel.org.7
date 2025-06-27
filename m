Return-Path: <linux-kernel+bounces-706000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F50AEB070
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 09:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352414E1FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 07:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802E221FA8;
	Fri, 27 Jun 2025 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ES0oAnmK"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF5221FB6
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010461; cv=none; b=SDJpCJQqdQtkU5w7xquObJ2Dwege8Wr3E23oF0NA9DMExIj9deQ+wz91E95xU832MXhQfaeIVtUa5eNxwqE/tj/8EH1w6j4tnunIH8z9fY1PwDcTYmvi0Ro4qfPznNRgCbIVJcqZGiUi0dj801sc6ws5/jJYf80OQUNmK3EwQbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010461; c=relaxed/simple;
	bh=Y7St4JhZZZq+mleq1bXqKtP6Z7Ps1WQG5WZmwKtliYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PZJx6NalsHssSW50fDvbP3hJnqW9yIj4tW9Dx4Y4fEfqQd+cTEcPaP6jTR4kuDFXGQTZ2Z5JOebyNcA0bTd5UGPEf2rPIn9B35FSb5Y3XLILLupIS49f9psOwaieofL+2iVl2EBNzkWcaorStSjS9N4cli7ZQZXxHbCru2u1aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ES0oAnmK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742c3d06de3so2225029b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 00:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751010459; x=1751615259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7St4JhZZZq+mleq1bXqKtP6Z7Ps1WQG5WZmwKtliYo=;
        b=ES0oAnmKXkVzacDiPmUHRWXrAEykJTjm/ofhO+1cIDiaybO0WA4I9Z/ZymmY84XyWY
         rAd3mcy2g2pWcjVeX1IE5nqjZPqB/e5lCzO0bxJuHJ2KXiDfuWLz2pfL0omWRIr2pb/x
         bihCfAIfZtlcxLGEfBeND4frevUKkxB1fshMsrXxXkj2nHp1XiQ9xqdxdb7OoLNKiExY
         6mdng2BDDTelS0+zxEkkAxjKL1L7l8Srb8a4sDj7mcNT9sAPWxP1ASberKTsWPDG/VtO
         R72dTSwnAhvad8PPsbBzQ/wvlSQVOKt7Ad8MTEkfIsVqicnPYMbBRalfMNJ9zpMqOojk
         c/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751010459; x=1751615259;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7St4JhZZZq+mleq1bXqKtP6Z7Ps1WQG5WZmwKtliYo=;
        b=Deu+KYpikM+TANy7lvjYlvfj8D1VQ7UOAyllS0hf/cIMETIOpfwG5LTTelboByj1Ht
         FDeMc7mMuSHkDmwNRYxYysQLCDlsIaar+SNVWOETgjJxYy7b2bY9bH/8y/AhPMeIT6K9
         qo9NRVO0g8uerQPisVE9xl9mlivgIDVkOy6yCiS0i1ZmkLkJNKn0RYTkZvY2pk1zQJYf
         KQwsgaCQRohcsDBl2HB1PsB6wx01ybHfS50CsKAmPtaUkacIjKpJDUMOkGWl8KUq9YHJ
         4Mb9q3pLEJIohUKHwBZGjSwhXZjCiFkP00jbi0hvnrcpobYeYBIkTPpskOIlsE/I1XU6
         TRPw==
X-Gm-Message-State: AOJu0YxD4mZJevqrP3QxCpy85kEZrcTbiRz1beQUgCuV/+5qhO1kykK3
	2DayIAd03kGR8IySIP1l4G0TPVkbYdz25Wcx/zQ6kAsfEwkHJ7xoNqNXQiN08GT6Yw==
X-Gm-Gg: ASbGncsq9M9vWwy4ifvSwEc2NzQ4HyMFcP+8BksFHh1Ka5kiZgi5ZigwdXlB0TXwr0i
	GI24O6udUUHxesgvVGvcvbCuydxIypC2uff3DSP9kxHx/91zoTKyBQBgiWX8nvBdRWcrv230VoF
	9M24GrLqjL9A/YQNGus988Jwqztxlb+LnJ1u41g584FOaU8N7wio42Iy2kKacTW6uA8MiT+Xwkl
	rOXcubd67SSTChx+LKMF4O3AJ1218ugmr8zquDBRQ0iSyETsx/78cPL3gJSTiEjcNYc/G+50Q3x
	E0YoPsPpM6tLfuOWp5acsEXUxhBl45QEOyb22OkLF5G/MopMc8Y7K386nG3H7Nw5Gd4t6vPszEp
	69k8nQ15ghfjHd0w24cx/5ZzHAQjWycgDEIM3kAaTkK2LKcoM
X-Google-Smtp-Source: AGHT+IHK/BoiWDoAeamudHKZKa3R7+0iiaHI3QMpkhmGL/UdBwZdH+9dnYc6xSPV6R2mIvwNGBWEvQ==
X-Received: by 2002:a05:6a00:3cd5:b0:74a:f611:484 with SMTP id d2e1a72fcca58-74af70a825cmr3440203b3a.24.1751010459048;
        Fri, 27 Jun 2025 00:47:39 -0700 (PDT)
Received: from ynaffit-andsys.c.googlers.com (225.193.16.34.bc.googleusercontent.com. [34.16.193.225])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56d91edsm1728051b3a.140.2025.06.27.00.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:47:38 -0700 (PDT)
From: Tiffany Yang <ynaffit@google.com>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org,  cgroups@vger.kernel.org,
  kernel-team@android.com,  John Stultz <jstultz@google.com>,  Thomas
 Gleixner <tglx@linutronix.de>,  Stephen Boyd <sboyd@kernel.org>,
  Anna-Maria Behnsen <anna-maria@linutronix.de>,  Frederic Weisbecker
 <frederic@kernel.org>,  Tejun Heo <tj@kernel.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,  Pavel
 Machek <pavel@kernel.org>,  Roman Gushchin <roman.gushchin@linux.dev>,
  Chen Ridong <chenridong@huawei.com>,  Ingo Molnar <mingo@redhat.com>,
  Peter Zijlstra <peterz@infradead.org>,  Juri Lelli
 <juri.lelli@redhat.com>,  Vincent Guittot <vincent.guittot@linaro.org>,
  Dietmar Eggemann <dietmar.eggemann@arm.com>,  Steven Rostedt
 <rostedt@goodmis.org>,  Ben Segall <bsegall@google.com>,  Mel Gorman
 <mgorman@suse.de>,  Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
In-Reply-To: <gn6xiuqczaoiepdczg364cj46riiskvqwgvyaawbb3bpaybaw4@5iiohkyscrek>
	("Michal =?utf-8?Q?Koutn=C3=BD=22's?= message of "Tue, 17 Jun 2025 11:49:36
 +0200")
References: <20250603224304.3198729-3-ynaffit@google.com>
	<gn6xiuqczaoiepdczg364cj46riiskvqwgvyaawbb3bpaybaw4@5iiohkyscrek>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 27 Jun 2025 00:47:23 -0700
Message-ID: <dbx8h601k4ms.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

Hello! Thanks for taking the time to respond!

> Hello.
>
> On Tue, Jun 03, 2025 at 10:43:05PM +0000, Tiffany Yang <ynaffit@google.co=
m> wrote:
>> The cgroup v2 freezer controller allows user processes to be dynamically
>> added to and removed from an interruptible frozen state from
>> userspace.
>
> Beware of freezing by migration vs freezing by cgroup attribute change.
> The latter is primary design of cgroup v2, the former is "only" for
> consistency.
>
>> This feature is helpful for application management, as it
>> allows background tasks to be frozen to prevent them from being
>> scheduled or otherwise contending with foreground tasks for resources.
>
>> Still, applications are usually unaware of their having been placed in
>> the freezer cgroup, so any watchdog timers they may have set will fire
>> when they exit. To address this problem, I propose tracking the per-task
>> frozen time and exposing it to userland via procfs.
>
> But the watchdog fires rightfully when the application does not run,
> doesn't it?

Good question. I should've been clearer about our use case. In both
cases, the watchdog is being used to ensure that a job is completed
before some deadline. When the deadline is relative to the system time,
then yes, it would be firing correctly. In our case, the deadline is
meant to be relative to the time our task spends running; since we don't
have a clock for that, we set our timer against the system time
(CLOCK_MONOTONIC, in this case) as an approximation.

This timer may fire (correctly) while our application is still frozen,
but our watchdog task won't run until it's unfrozen. At that point, it
can check how much time has been spent in the cgroup v2 freezer and
decide whether to rearm the timer or to initiate a corrective action.

> It should be responsibility of the "freezing agent" to prepare or notify
> the application about expected latencies.
>

Fair point! The freezing agent could roughly track freeze-entrance and
freeze-exit times, but how it would communicate those values to every
application being frozen along with who would be responsible for
keeping track of per-thread accumulated frozen times make this a little
messy. The accuracy of those user timestamps compared to ones taken in
the kernel may be further degraded by possible preemptions, etc.

>> but the main focus in this initial submission is establishing the
>> right UAPI for this accounting information.
>
> /proc/<pid>/cgroup_v2_freezer_time_frozen looks quite extraordinary with

Agreed.

> other similar metrics, my first thought would be a field in
> /proc/<pid>/stat (or track it per cgroup as Tejun suggests).
>

Adding it to /proc/<pid>/stat is an option, but because this metric
isn't very widely used and exactly what it measures is pretty particular
("freezer time, but no, cgroup freezer time, but v2 and not v1"), we
were hesitant to add it there and make this interface even more
difficult for folks to parse.

> Could you please primarily explain why the application itself should
> care about the frozen time (and not other causes of delay)?
>

Thank you for asking this! This is a very helpful question. My answer is
that other causes of delay may be equally important, but this is another
place where things get messy because of the spectrum of types of
"delay". If we break delays into 2 categories, delays that were
requested (sleep) and delays that were not (SIGSTOP), I can say that we
are primarily interested in delays that were not requested. However,
there are many cases that fall somewhere in between, like the wakeup
latency after a sleep, or that are difficult to account for, like
blocking on a futex (requested), where the owner might be preempted (not
requested).

Which is all to say that this is a hard thing to really pin down
generalized semantics for.

We can usually ignore the smaller sources of delay on a time-shared
system, but larger causes of delay (e.g., cgroup v2 freezer, SIGSTOP,
or really bad cases of scheduler starvation) can cause problems.

In this case, we've focused on a narrowish solution to just the cgroup
v2 freezer delays because it's fairly tractable. Ideally, we could
abstract this out in a more general way to other delays (like SIGSTOP),
but the challenge here is that there isn't a clear line that separates a
problematic delay from an acceptable delay. Suggestions for a framework
to approach this more generally are very welcome.

In the meantime, focusing on task frozen/stopped time seems like the
most reasonable approach. Maybe that would be clear enough to make it
palatable for proc/<pid>/stat ?

--=20
Tiffany Y. Yang

