Return-Path: <linux-kernel+bounces-631818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B6AA8DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B323C1893469
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977A91E1A2D;
	Mon,  5 May 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3g3sJAJ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794B938DD8
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746432514; cv=none; b=A0ohrPz+84X1Jqz6+k1pTDLEg8m4TOmIpMTkBLJvUJnxBDU8SIte76OTIQb6Lbo5ZRRSFwKZwYxV/0aBTuD+p7N+o3WdE+V24Bs1jeBsK4XRCwVV3ydYL0wnYHsQqCl8dGZR4QOQ0r17DfbEafR7CXckVs6A2CKOkVd78Yfto/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746432514; c=relaxed/simple;
	bh=+GdgUEMxmeeDP8lvtP9u3GQ+NjoMaSaT0I4LcsdVFgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwjUyU5qVzRwRpoF/UVQomRmw6VpR9hQm4zQv5ya7czar4UYZ/BQrVyBbQ5+bfoElzmwDvCf2aoA9mosm3HvB1TZ/6wdpZFpkW9URI8qfJDhhF48vQsTkqwvzjLiouVjvd2gGXSQUByYWaaFL/bza/2Kk0aHme+th6H/73UfQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3g3sJAJ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c2d427194so36227421fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746432510; x=1747037310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCXUgF3diTMwlvCqE1V/IN/tFAzJF2eih16ycTXQbeQ=;
        b=p3g3sJAJnx/lwl4d+PBWPmzFF/rvp8wHoaZAAddMBFVL2H+722kU7hHFyC5bzkNkOS
         PyYusM92EHabcTW+coLEbz9Bd9rAZtmX736bTlSgawJTI6LE0/i4mVutROGdMCFO8Sxo
         GVP6tz3GKPUy3sbCjwJpiivKZ6KAo3NXxB7AHtLALslSI9ObqTfEkjNRGMfmz8VLjffL
         CYwvxDIphflMYpx5tz5y09vCUplyXyNrLzm6rhdJudRErC6YWN3DHH8qfV9O1RNO3TV4
         /gubSayNZH2Yeps6aDEqfoajfWTGfX+IkCrzmhGe216G2T+vWDeG8jyqrQpWfH9ljhZx
         ItYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746432510; x=1747037310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCXUgF3diTMwlvCqE1V/IN/tFAzJF2eih16ycTXQbeQ=;
        b=ZdxBfaEz9+IsO0JWt3ATMEMjd73++DGPhr+ZtonIDT+49uBsdSD6I/5RYr4kINND3D
         P4xXPOKpuTxZycJUy5fN9+mVMLLMqIqR/snCcOm0cXr/htPPNt7wwjkJKvaLTpyfwul+
         gBpSoKKh3KNPhGid1n7YrgQgRpkxNx7tFz1VlZYEcTu66ePP0WyJKAoRTB2OhX/y27iN
         pJ00KCYTLEOPDgI1YtHr8SlK89HB1gLDmib1i4gFqYAMqFmKmiaSyr/o5rfuye0ET49X
         Wk2Go+dhhXtSQOmNebvsjtGpnzd9qC5j0XYAEYQbQ0d4V84Jys/eutagnUv5R9/fCg5B
         LxoA==
X-Forwarded-Encrypted: i=1; AJvYcCXlrOv07Grhl3BwbUZDFDn3kWlPoF4gm620MLvDGPHYVHQxlXZJwkvTFvXHye1aIhbPERhGsjUNOLUENQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTfj4+6hEHGfxgFa8ozniSMUk/ZLvNR+0eFa8BPjkfSm64y48D
	mIeURmX5a7JJ48h7ludoLWF+81m+YqwmoEv8OZFKiUgpbgauiX01zWFrvo/X2WFR8RhdzWsvwPM
	ayzDdLHnV1QIWEVjAL8vBqFwxtsN5+SF9Y+ko
X-Gm-Gg: ASbGnct06r4JxTQ7jGXqjloRHnMSc/z6kjCYTafKCoTpz3HSvT/0+Fav2yCb3AUv03L
	NxrBHBcao1bijZLNC7JL1PO08zvaBHYDFf+HeabXTB2UUAcBB9vL4KgEoPCoJ9kvptWGKbHhPj6
	Ikh17qozSNfoyyK7CP0Hrk3KIEMi2F/h8UXcwEFMjn9iyVVt2pDQskZId8YA/AdTQL
X-Google-Smtp-Source: AGHT+IGtSvPoXmi4pMqnGbTT/jKbyjaZIgtnVVAge1dhpVimzKfl7CZioKLTzAFmFqBr1PGTxyYlbNCGskxZkI5ELDw=
X-Received: by 2002:a2e:b887:0:b0:30b:f274:d1e2 with SMTP id
 38308e7fff4ca-320c3af0581mr34401481fa.1.1746432510182; Mon, 05 May 2025
 01:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org>
In-Reply-To: <20250503003620.45072-1-namhyung@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 5 May 2025 10:08:17 +0200
X-Gm-Features: ATxdqUFutFekXtwYbXmiA644Z1bF2753cScz7VbHu8YLfvCkist93GjXquWD9LE
Message-ID: <CACT4Y+Yr7vffLYG+YmyB=9Vn_oxdQqR_6U4d-_WeQoOtPXZ6iw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 May 2025 at 02:36, Namhyung Kim <namhyung@kernel.org> wrote:
>
> When it profile a target process (and its children), it's
> straight-forward to track parallelism using sched-switch info.  The
> parallelism is kept in machine-level in this case.
>
> But when it profile multiple processes like in the system-wide mode,
> it might not be clear how to apply the (machine-level) parallelism to
> different tasks.  That's why it disabled the latency profiling for
> system-wide mode.
>
> But it should be able to track parallelism in each process and it'd
> useful to profile latency issues in multi-threaded programs.  So this
> patch tries to enable it.
>
> However using sched-switch info can be a problem since it may emit a lot
> more data and more chances for losing data when perf cannot keep up with
> it.
>
> Instead, it can maintain the current process for each CPU when it sees
> samples.

Interesting.

Few questions:
1. Do we always see a CPU sample when a CPU becomes idle? Otherwise we
will think that the last thread runs on that CPU for arbitrary long,
when it's actually not.
2. If yes, can we also lose that "terminating" even when a CPU becomes
idle? If yes, then it looks equivalent to missing a context switch
event.
3. Does this mode kick in even for non system-wide profiles (collected
w/o context switch events)? If yes, do we properly understand when a
thread stops running for such profiles? How do we do that? There won't
be samples for idle/other tasks.



> And the process updates parallelism so that it can calculate
> the latency based on the value.  One more point to improve is to remove
> the idle task from latency calculation.
>
> Here's an example:
>
>   # perf record -a -- perf bench sched messaging
>
> This basically forks each sender and receiver tasks for the run.
>
>   # perf report --latency -s comm --stdio
>   ...
>   #
>   #  Latency  Overhead  Command
>   # ........  ........  ...............
>   #
>       98.14%    95.97%  sched-messaging
>        0.78%     0.93%  gnome-shell
>        0.36%     0.34%  ptyxis
>        0.23%     0.23%  kworker/u112:0-
>        0.23%     0.44%  perf
>        0.08%     0.10%  KMS thread
>        0.05%     0.05%  rcu_preempt
>        0.05%     0.05%  kworker/u113:2-
>        ...
>
> So the latency profile is similar to the overhead.  But when you run
> with -t option to make it multi-threaded:
>
>   # perf record -a -- perf bench sched messaging -t
>
> Then the latency profile result differs with the overhead.
>
>   # perf report --latency -s comm --stdio
>   ...
>   #
>   #  Latency  Overhead  Command
>   # ........  ........  ...............
>   #
>       58.94%    94.52%  sched-messaging
>       19.12%     1.22%  perf
>       12.13%     0.77%  ptyxis
>        4.07%     0.28%  gnome-shell
>        1.31%     0.08%  perf-exec
>        0.95%     0.06%  kworker/u113:2-
>        0.86%     0.05%  KMS thread
>        0.85%     0.05%  kworker/18:1-mm
>        ...
>
> A side effect is that it will most likely show latency output column
> for system-wide mode by default.
>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c | 16 ++---------
>  tools/perf/builtin-report.c | 56 +++++++++++++++++++++++++++++--------
>  tools/perf/util/event.c     | 48 ++++++++++++++++++++++++-------
>  tools/perf/util/machine.c   | 21 ++++++++++++++
>  tools/perf/util/machine.h   |  4 +++
>  tools/perf/util/thread.h    | 23 +++++++++++++++
>  6 files changed, 133 insertions(+), 35 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8898357325cf4132..67f746601ac05e4d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -4062,19 +4062,9 @@ int cmd_record(int argc, const char **argv)
>         }
>
>         if (record.latency) {
> -               /*
> -                * There is no fundamental reason why latency profiling
> -                * can't work for system-wide mode, but exact semantics
> -                * and details are to be defined.
> -                * See the following thread for details:
> -                * https://lore.kernel.org/all/Z4XDJyvjiie3howF@google.com/
> -                */
> -               if (record.opts.target.system_wide) {
> -                       pr_err("Failed: latency profiling is not supported with system-wide collection.\n");
> -                       err = -EINVAL;
> -                       goto out_opts;
> -               }
> -               record.opts.record_switch_events = true;
> +               /* It can use sample->cpu to get process-level parallelism. */
> +               if (!target__has_cpu(&record.opts.target))
> +                       record.opts.record_switch_events = true;
>         }
>
>         if (rec->buildid_mmap) {
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f0299c7ee0254a37..4294508b9df52d83 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1280,6 +1280,22 @@ static int process_attr(const struct perf_tool *tool __maybe_unused,
>         return 0;
>  }
>
> +static bool is_latency_requested(void)
> +{
> +       if (symbol_conf.parallelism_list_str || symbol_conf.prefer_latency)
> +               return true;
> +
> +       if (sort_order && (strstr(sort_order, "latency") ||
> +                          strstr(sort_order, "parallelism")))
> +               return true;
> +
> +       if (field_order && (strstr(field_order, "latency") ||
> +                           strstr(field_order, "parallelism")))
> +               return true;
> +
> +       return false;
> +}
> +
>  #define CALLCHAIN_BRANCH_SORT_ORDER    \
>         "srcline,symbol,dso,callchain_branch_predicted," \
>         "callchain_branch_abort,callchain_branch_cycles"
> @@ -1735,18 +1751,10 @@ int cmd_report(int argc, const char **argv)
>         }
>
>         symbol_conf.enable_latency = true;
> -       if (report.disable_order || !perf_session__has_switch_events(session)) {
> -               if (symbol_conf.parallelism_list_str ||
> -                       symbol_conf.prefer_latency ||
> -                       (sort_order && (strstr(sort_order, "latency") ||
> -                               strstr(sort_order, "parallelism"))) ||
> -                       (field_order && (strstr(field_order, "latency") ||
> -                               strstr(field_order, "parallelism")))) {
> -                       if (report.disable_order)
> -                               ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
> -                       else
> -                               ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
> -                       return -1;
> +       if (report.disable_order) {
> +               if (is_latency_requested()) {
> +                       ui__error("Use of latency profile or parallelism is incompatible with --disable-order.\n");
> +                       goto error;
>                 }
>                 /*
>                  * If user did not ask for anything related to
> @@ -1755,6 +1763,30 @@ int cmd_report(int argc, const char **argv)
>                 symbol_conf.enable_latency = false;
>         }
>
> +       if (!perf_session__has_switch_events(session)) {
> +               if (evlist__combined_sample_type(session->evlist) & PERF_SAMPLE_CPU) {
> +                       struct machine *machine = &session->machines.host;
> +
> +                       /*
> +                        * Maintain current process for each CPU to track
> +                        * parallelism in process level.
> +                        */
> +                       ret = machine__create_current_table(machine);
> +                       if (ret < 0)
> +                               goto error;
> +               } else if (is_latency_requested()) {
> +                       ui__error("Use of latency profile or parallelism requires --latency flag during record.\n");
> +                       goto error;
> +               }
> +               else {
> +                       /*
> +                        * If user did not ask for anything related to
> +                        * latency/parallelism explicitly, just don't show it.
> +                        */
> +                       symbol_conf.enable_latency = false;
> +               }
> +       }
> +
>         if (last_key != K_SWITCH_INPUT_DATA) {
>                 if (sort_order && strstr(sort_order, "ipc")) {
>                         parse_options_usage(report_usage, options, "s", 1);
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c23b77f8f854ad21..6c2c9cd68e3afb5e 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -767,16 +767,44 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>                         al->socket = env->cpu[al->cpu].socket_id;
>         }
>
> -       /* Account for possible out-of-order switch events. */
> -       al->parallelism = max(1, min(machine->parallelism, machine__nr_cpus_avail(machine)));
> -       if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
> -               al->filtered |= (1 << HIST_FILTER__PARALLELISM);
> -       /*
> -        * Multiply it by some const to avoid precision loss or dealing
> -        * with floats. The multiplier does not matter otherwise since
> -        * we only print it as percents.
> -        */
> -       al->latency = sample->period * 1000 / al->parallelism;
> +       if (symbol_conf.enable_latency) {
> +               if (machine->current && al->cpu >= 0) {
> +                       struct thread *curr = machine->current[al->cpu];
> +
> +                       if (curr) {
> +                               thread__dec_parallelism(curr);
> +                               thread__put(curr);
> +                       }
> +
> +                       curr = machine__findnew_thread(machine, sample->pid,
> +                                                      sample->pid);
> +                       if (curr) {
> +                               machine->current[al->cpu] = curr;
> +
> +                               thread__inc_parallelism(curr);
> +                               thread__get(curr);
> +                       }
> +
> +                       al->parallelism = curr ? thread__parallelism(curr) : 1;
> +               } else {
> +                       /* Account for possible out-of-order switch events. */
> +                       al->parallelism = max(1, min(machine->parallelism,
> +                                                    machine__nr_cpus_avail(machine)));
> +               }
> +
> +               if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
> +                       al->filtered |= (1 << HIST_FILTER__PARALLELISM);
> +               /*
> +                * Multiply it by some const to avoid precision loss or dealing
> +                * with floats. The multiplier does not matter otherwise since
> +                * we only print it as percents.
> +                */
> +               al->latency = sample->period * 1000 / al->parallelism;
> +
> +               /* It won't be exciting to see idle threads in latency profile. */
> +               if (sample->pid == 0)
> +                       al->latency = 0;
> +       }
>
>         if (al->map) {
>                 if (symbol_conf.dso_list &&
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2531b373f2cf7ca0..8c0e7d418a88f528 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -117,6 +117,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>         }
>
>         machine->current_tid = NULL;
> +       machine->current = NULL;
>         err = 0;
>
>  out:
> @@ -183,6 +184,12 @@ void machine__exit(struct machine *machine)
>         zfree(&machine->current_tid);
>         zfree(&machine->kallsyms_filename);
>
> +       if (machine->current) {
> +               for (int i = 0; i < machine__nr_cpus_avail(machine); i++)
> +                       thread__put(machine->current[i]);
> +               zfree(&machine->current);
> +       }
> +
>         threads__exit(&machine->threads);
>  }
>
> @@ -3271,3 +3278,17 @@ int machine__hit_all_dsos(struct machine *machine)
>  {
>         return dsos__hit_all(&machine->dsos);
>  }
> +
> +int machine__create_current_table(struct machine *machine)
> +{
> +       int nr = machine__nr_cpus_avail(machine);
> +
> +       if (nr == 0)
> +               return -EINVAL;
> +
> +       machine->current = calloc(nr, sizeof(*machine->current));
> +       if (machine->current == NULL)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index b56abec84fed1e3f..13d23b14b25e51fc 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -64,6 +64,8 @@ struct machine {
>         };
>         struct machines   *machines;
>         bool              trampolines_mapped;
> +       /* per-CPU current process for parallelism */
> +       struct thread     **current;
>  };
>
>  /*
> @@ -332,4 +334,6 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>
>  int machine__hit_all_dsos(struct machine *machine);
>
> +int machine__create_current_table(struct machine *machine);
> +
>  #endif /* __PERF_MACHINE_H */
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index cd574a896418ac94..5233436404408d10 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -39,6 +39,7 @@ DECLARE_RC_STRUCT(thread) {
>         pid_t                   ppid;
>         int                     cpu;
>         int                     guest_cpu; /* For QEMU thread */
> +       int                     parallelism; /* Valid for group leaders */
>         refcount_t              refcnt;
>         /**
>          * @exited: Has the thread had an exit event. Such threads are usually
> @@ -359,4 +360,26 @@ void thread__free_stitch_list(struct thread *thread);
>  void thread__resolve(struct thread *thread, struct addr_location *al,
>                      struct perf_sample *sample);
>
> +static inline int thread__parallelism(const struct thread *thread)
> +{
> +       return RC_CHK_ACCESS(thread)->parallelism ? : 1;
> +}
> +
> +static inline void thread__set_parallelism(struct thread *thread, int parallelism)
> +{
> +       RC_CHK_ACCESS(thread)->parallelism = parallelism;
> +}
> +
> +static inline void thread__inc_parallelism(struct thread *thread)
> +{
> +       if (thread__pid(thread))
> +               RC_CHK_ACCESS(thread)->parallelism++;
> +}
> +
> +static inline void thread__dec_parallelism(struct thread *thread)
> +{
> +       if (thread__pid(thread) && RC_CHK_ACCESS(thread)->parallelism > 0)
> +               RC_CHK_ACCESS(thread)->parallelism--;
> +}
> +
>  #endif /* __PERF_THREAD_H */
> --
> 2.49.0
>

