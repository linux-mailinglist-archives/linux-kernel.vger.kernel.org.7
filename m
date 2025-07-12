Return-Path: <linux-kernel+bounces-728452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB74B02856
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6572548550
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEC072615;
	Sat, 12 Jul 2025 00:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHlQoWdq"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03935946
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752280506; cv=none; b=ZcjJveF9/dADgli1JgX9s7YxczwRn3mFS1yutU+eNwgzPVNgBEaWejEOH6nOo6VMov4Ja6sNlYS8RckWUkNQCshQCMHy+fOyPV6ShyCYmze98fGCrQe1egKt4/iT2/eNCodio63trlxmK2W4Xz0KrqqM7NtAZV9sXEQoV0dUUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752280506; c=relaxed/simple;
	bh=rhW1qfA/v7dqWu5nn9APLo9HEYuIHb4Dz9BskyhYkZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjiKzM1omRRocs17CC3xrmhi9XqY+hbX99G7c74x/fzGFHjhLuosnfm2XVZQUzcUVCbkFNFm/o02DrmnJ9FtrfV19R2UNKhmDmc3Jzz8SwalfnAyTMeRoS8ygLt3KKawu8pLksN0bWMaevLAio1//8i7s43CevTO85xz/9SfQ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHlQoWdq; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so69005ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752280504; x=1752885304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve3aCZUJXo4KCVjwQrc5fBx/G8XlDEOo0fm5ktBuj7k=;
        b=BHlQoWdquLViWVC8JQJ3CHFAjc3S9zmFPNYflTkjklgvajJDo/E+AbAHklIgACIWPY
         JKh7vc/ynrczSA49kO9Iz6YwPj0FQpRqMnaTfzf5toF5c7KiIieeVbM0KIC+bG8X3sK+
         q3KnrC4jX68KmOlDaMVMZZ0FjWUJKXxMjhAG1EI7AQBYLefUP86ZOoEs+GS0koiGWK4t
         a5u5jyI/l/iPzxzctvlB4uTbS6BBdJFq2PpFDsZpADuPMlH4AS+kpyOFqehO91YW5b84
         bwfoUpu1GRhPYQfV2RAyCw8HebK+XZCJ9Cx5HFGSr3M3INWxPVvfmkxIO2zoU16PGwgU
         6Jeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752280504; x=1752885304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ve3aCZUJXo4KCVjwQrc5fBx/G8XlDEOo0fm5ktBuj7k=;
        b=koiFZrSb6q5+P4xmT6Bi2YUH/Gahqg2RcVsixhGimnv76CsIwWExl/KnE+x83Ht2id
         efD8BTjSTLQ9A5ABAlr40q5N2rSFjBNqo/RTB6ZtrKzmWtiwMQSLqzCQa6ji0mQpZEBU
         RXFaTBj+QNql6XpXD0qEledGHD9ZS1w0UYAlRK///u+49tyPWWBkC4p0pR5S0Bhn0k/h
         2FYc9L69Xr3yNy7S4gB2YCIEKD3eSIHtZgPHAHnRQXoFX9H1rB0j6lMKEPmn333UIrpw
         /K21gfB4ozsdp9cB7e+YFcGKrXvFfOTeOd1iCJHlKc/6WboirEGUxgZ8KO9fqvHmXbtF
         rdJA==
X-Forwarded-Encrypted: i=1; AJvYcCW0npiGDvdLiuiE9ZBt2xfRNH6o8cK273H4NLRQ0DODcPlyplS+H2wK13916GDORaf6MtH0jEsGsb9GQqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Hyl6C8Tg+I3Vj/Dn05GTKVUWkiyBwwJ/4l/KYu+N83Yhh6XV
	5Q8EvDvtbSGvUmhZ3zUNAFHDPmszSW6B4u1QS57jKAjXWU23d3QRAF1ay55SMwfAP7URBaexX0b
	LzBEMqtFn1IAtFQ3XSq+2Q6I4nw6yZLgYJxo4qpC/
X-Gm-Gg: ASbGnctfJrQguymXEKpdRK9Q53fHIw4887C5wP5Bmyv9KWtnjWw8yyNMnkVEFGdrMR5
	FTHfyx+yGp2fNJnBC47+FE2egSRosroBk4y2v8uO9GUdl2YxscrTmpulVKAIG3pTO1q0JuaSlM7
	NLAmn2KEkkchowWj1SPLMNW+k0FdxdEJ/k2kEzdAjdTSmvd07etGqMleLwWSRdSKExmL4U0b1z3
	ZZvjMit
X-Google-Smtp-Source: AGHT+IHcjxIuJUADvEeSg80rV196e9ChPbc4NFwgIKdbo4+9HLOkAjzR8Da0uchrwyMcsyYyjnSBS5Ri3s/KPGuvPpw=
X-Received: by 2002:a05:6e02:3487:b0:3dc:8596:b0e with SMTP id
 e9e14a558f8ab-3e25e06d882mr1899005ab.6.1752280503220; Fri, 11 Jul 2025
 17:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711223525.323906-1-namhyung@kernel.org>
In-Reply-To: <20250711223525.323906-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Jul 2025 17:34:50 -0700
X-Gm-Features: Ac12FXx8DPLyOwrTliDPD-Nh0FXGCvU3MI4eFY5hVkXEu6ys8Y2-i_NfSwrBsyA
Message-ID: <CAP-5=fXzbqoqV2YUbVV_BMVNrwtddi65=YrbqD6hMaywNxU53A@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace latency: Add -e option to measure time
 between two events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> In addition to the function latency, it can measure events latencies.
> Some kernel tracepoints are paired and it's menningful to measure how
> long it takes between the two events.  The latency is tracked for the
> same thread.
>
> Currently it only uses BPF to do the work but it can be lifted later.
> Instead of having separate a BPF program for each tracepoint, it only
> uses generic 'event_begin' and 'event_end' programs to attach to any
> (raw) tracepoints.
>
>   $ sudo perf ftrace latency -a -b --hide-empty \
>     -e i915_request_wait_begin,i915_request_wait_end -- sleep 1
>   #   DURATION     |      COUNT | GRAPH                                |
>      256 -  512 us |          4 | ######                               |
>        2 -    4 ms |          2 | ###                                  |
>        4 -    8 ms |         12 | ###################                  |
>        8 -   16 ms |         10 | ################                     |
>
>   # statistics  (in usec)
>     total time:               194915
>       avg time:                 6961
>       max time:                12855
>       min time:                  373
>          count:                   28

Nice!

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/Documentation/perf-ftrace.txt    |   6 +
>  tools/perf/builtin-ftrace.c                 |  50 ++++++-
>  tools/perf/util/bpf_ftrace.c                |  69 ++++++---
>  tools/perf/util/bpf_skel/func_latency.bpf.c | 148 +++++++++++++-------
>  tools/perf/util/ftrace.h                    |   1 +
>  5 files changed, 199 insertions(+), 75 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Docume=
ntation/perf-ftrace.txt
> index b77f58c4d2fdcff9..914457853bcf53ac 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -139,6 +139,12 @@ OPTIONS for 'perf ftrace latency'
>         Set the function name to get the histogram.  Unlike perf ftrace t=
race,
>         it only allows single function to calculate the histogram.
>
> +-e::
> +--events=3D::
> +       Set the pair of events to get the histogram.  The histogram is ca=
lculated
> +       by the time difference between the two events from the same threa=
d.  This
> +       requires -b/--use-bpf option.
> +
>  -b::
>  --use-bpf::
>         Use BPF to measure function latency instead of using the ftrace (=
it
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 3a253a1b9f4526b9..e1f2f3fb1b0850a3 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1549,6 +1549,33 @@ static void delete_filter_func(struct list_head *h=
ead)
>         }
>  }
>
> +static int parse_filter_event(const struct option *opt, const char *str,
> +                            int unset __maybe_unused)
> +{
> +       struct list_head *head =3D opt->value;
> +       struct filter_entry *entry;
> +       char *s, *p;
> +       int ret =3D -ENOMEM;
> +
> +       s =3D strdup(str);
> +       if (s =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       while ((p =3D strsep(&s, ",")) !=3D NULL) {
> +               entry =3D malloc(sizeof(*entry) + strlen(p) + 1);
> +               if (entry =3D=3D NULL)
> +                       goto out;
> +
> +               strcpy(entry->name, p);
> +               list_add_tail(&entry->list, head);
> +       }
> +       ret =3D 0;
> +
> +out:
> +       free(s);
> +       return ret;
> +}
> +
>  static int parse_buffer_size(const struct option *opt,
>                              const char *str, int unset)
>  {
> @@ -1711,6 +1738,8 @@ int cmd_ftrace(int argc, const char **argv)
>         const struct option latency_options[] =3D {
>         OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
>                      "Show latency of given function", parse_filter_func)=
,
> +       OPT_CALLBACK('e', "events", &ftrace.event_pair, "event1,event2",
> +                    "Show latency between the two events", parse_filter_=
event),
>  #ifdef HAVE_BPF_SKEL
>         OPT_BOOLEAN('b', "use-bpf", &ftrace.target.use_bpf,
>                     "Use BPF to measure function latency"),
> @@ -1763,6 +1792,7 @@ int cmd_ftrace(int argc, const char **argv)
>         INIT_LIST_HEAD(&ftrace.notrace);
>         INIT_LIST_HEAD(&ftrace.graph_funcs);
>         INIT_LIST_HEAD(&ftrace.nograph_funcs);
> +       INIT_LIST_HEAD(&ftrace.event_pair);
>
>         signal(SIGINT, sig_handler);
>         signal(SIGUSR1, sig_handler);
> @@ -1817,9 +1847,24 @@ int cmd_ftrace(int argc, const char **argv)
>                 cmd_func =3D __cmd_ftrace;
>                 break;
>         case PERF_FTRACE_LATENCY:
> -               if (list_empty(&ftrace.filters)) {
> -                       pr_err("Should provide a function to measure\n");
> +               if (list_empty(&ftrace.filters) && list_empty(&ftrace.eve=
nt_pair)) {
> +                       pr_err("Should provide a function or events to me=
asure\n");
>                         parse_options_usage(ftrace_usage, options, "T", 1=
);
> +                       parse_options_usage(NULL, options, "e", 1);
> +                       ret =3D -EINVAL;
> +                       goto out_delete_filters;
> +               }
> +               if (!list_empty(&ftrace.filters) && !list_empty(&ftrace.e=
vent_pair)) {
> +                       pr_err("Please specify either of function or even=
ts\n");
> +                       parse_options_usage(ftrace_usage, options, "T", 1=
);
> +                       parse_options_usage(NULL, options, "e", 1);
> +                       ret =3D -EINVAL;
> +                       goto out_delete_filters;
> +               }
> +               if (!list_empty(&ftrace.event_pair) && !ftrace.target.use=
_bpf) {
> +                       pr_err("Event processing needs BPF\n");
> +                       parse_options_usage(ftrace_usage, options, "b", 1=
);
> +                       parse_options_usage(NULL, options, "e", 1);
>                         ret =3D -EINVAL;
>                         goto out_delete_filters;
>                 }
> @@ -1910,6 +1955,7 @@ int cmd_ftrace(int argc, const char **argv)
>         delete_filter_func(&ftrace.notrace);
>         delete_filter_func(&ftrace.graph_funcs);
>         delete_filter_func(&ftrace.nograph_funcs);
> +       delete_filter_func(&ftrace.event_pair);
>
>         return ret;
>  }
> diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
> index 7324668cc83e747e..34ac0adf841c27ee 100644
> --- a/tools/perf/util/bpf_ftrace.c
> +++ b/tools/perf/util/bpf_ftrace.c
> @@ -21,16 +21,21 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftra=
ce *ftrace)
>  {
>         int fd, err;
>         int i, ncpus =3D 1, ntasks =3D 1;
> -       struct filter_entry *func;
> +       struct filter_entry *func =3D NULL;
>
> -       if (!list_is_singular(&ftrace->filters)) {
> -               pr_err("ERROR: %s target function(s).\n",
> -                      list_empty(&ftrace->filters) ? "No" : "Too many");
> -               return -1;
> +       if (!list_empty(&ftrace->filters)) {
> +               if (!list_is_singular(&ftrace->filters)) {
> +                       pr_err("ERROR: Too many target functions.\n");
> +                       return -1;
> +               }
> +               func =3D list_first_entry(&ftrace->filters, struct filter=
_entry, list);
> +       } else {
> +               if (list_is_singular(&ftrace->event_pair)) {

Should there be a list length function and then check the length =3D=3D 2
here? An empty list or list of length >2 will otherwise pass.

Thanks,
Ian

> +                       pr_err("ERROR: Needs two target events.\n");
> +                       return -1;
> +               }
>         }
>
> -       func =3D list_first_entry(&ftrace->filters, struct filter_entry, =
list);
> -
>         skel =3D func_latency_bpf__open();
>         if (!skel) {
>                 pr_err("Failed to open func latency skeleton\n");
> @@ -93,20 +98,44 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftra=
ce *ftrace)
>
>         skel->bss->min =3D INT64_MAX;
>
> -       skel->links.func_begin =3D bpf_program__attach_kprobe(skel->progs=
.func_begin,
> -                                                           false, func->=
name);
> -       if (IS_ERR(skel->links.func_begin)) {
> -               pr_err("Failed to attach fentry program\n");
> -               err =3D PTR_ERR(skel->links.func_begin);
> -               goto out;
> -       }
> +       if (func) {
> +               skel->links.func_begin =3D bpf_program__attach_kprobe(ske=
l->progs.func_begin,
> +                                                                   false=
, func->name);
> +               if (IS_ERR(skel->links.func_begin)) {
> +                       pr_err("Failed to attach fentry program\n");
> +                       err =3D PTR_ERR(skel->links.func_begin);
> +                       goto out;
> +               }
>
> -       skel->links.func_end =3D bpf_program__attach_kprobe(skel->progs.f=
unc_end,
> -                                                         true, func->nam=
e);
> -       if (IS_ERR(skel->links.func_end)) {
> -               pr_err("Failed to attach fexit program\n");
> -               err =3D PTR_ERR(skel->links.func_end);
> -               goto out;
> +               skel->links.func_end =3D bpf_program__attach_kprobe(skel-=
>progs.func_end,
> +                                                                 true, f=
unc->name);
> +               if (IS_ERR(skel->links.func_end)) {
> +                       pr_err("Failed to attach fexit program\n");
> +                       err =3D PTR_ERR(skel->links.func_end);
> +                       goto out;
> +               }
> +       } else {
> +               struct filter_entry *event;
> +
> +               event =3D list_first_entry(&ftrace->event_pair, struct fi=
lter_entry, list);
> +
> +               skel->links.event_begin =3D bpf_program__attach_raw_trace=
point(skel->progs.event_begin,
> +                                                                        =
    event->name);
> +               if (IS_ERR(skel->links.event_begin)) {
> +                       pr_err("Failed to attach first tracepoint program=
\n");
> +                       err =3D PTR_ERR(skel->links.event_begin);
> +                       goto out;
> +               }
> +
> +               event =3D list_next_entry(event, list);
> +
> +               skel->links.event_end =3D bpf_program__attach_raw_tracepo=
int(skel->progs.event_end,
> +                                                                        =
    event->name);
> +               if (IS_ERR(skel->links.event_end)) {
> +                       pr_err("Failed to attach second tracepoint progra=
m\n");
> +                       err =3D PTR_ERR(skel->links.event_end);
> +                       goto out;
> +               }
>         }
>
>         /* XXX: we don't actually use this fd - just for poll() */
> diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/uti=
l/bpf_skel/func_latency.bpf.c
> index e731a79a753a4d2d..621e2022c8bc9648 100644
> --- a/tools/perf/util/bpf_skel/func_latency.bpf.c
> +++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
> @@ -52,34 +52,89 @@ const volatile unsigned int min_latency;
>  const volatile unsigned int max_latency;
>  const volatile unsigned int bucket_num =3D NUM_BUCKET;
>
> -SEC("kprobe/func")
> -int BPF_PROG(func_begin)
> +static bool can_record(void)
>  {
> -       __u64 key, now;
> -
> -       if (!enabled)
> -               return 0;
> -
> -       key =3D bpf_get_current_pid_tgid();
> -
>         if (has_cpu) {
>                 __u32 cpu =3D bpf_get_smp_processor_id();
>                 __u8 *ok;
>
>                 ok =3D bpf_map_lookup_elem(&cpu_filter, &cpu);
>                 if (!ok)
> -                       return 0;
> +                       return false;
>         }
>
>         if (has_task) {
> -               __u32 pid =3D key & 0xffffffff;
> +               __u32 pid =3D bpf_get_current_pid_tgid();
>                 __u8 *ok;
>
>                 ok =3D bpf_map_lookup_elem(&task_filter, &pid);
>                 if (!ok)
> -                       return 0;
> +                       return false;
>         }
> +       return true;
> +}
> +
> +static void update_latency(__s64 delta)
> +{
> +       __u64 val =3D delta;
> +       __u32 key =3D 0;
> +       __u64 *hist;
> +       __u64 cmp_base =3D use_nsec ? 1 : 1000;
> +
> +       if (delta < 0)
> +               return;
>
> +       if (bucket_range !=3D 0) {
> +               val =3D delta / cmp_base;
> +
> +               if (min_latency > 0) {
> +                       if (val > min_latency)
> +                               val -=3D min_latency;
> +                       else
> +                               goto do_lookup;
> +               }
> +
> +               // Less than 1 unit (ms or ns), or, in the future,
> +               // than the min latency desired.
> +               if (val > 0) { // 1st entry: [ 1 unit .. bucket_range uni=
ts )
> +                       key =3D val / bucket_range + 1;
> +                       if (key >=3D bucket_num)
> +                               key =3D bucket_num - 1;
> +               }
> +
> +               goto do_lookup;
> +       }
> +       // calculate index using delta
> +       for (key =3D 0; key < (bucket_num - 1); key++) {
> +               if (delta < (cmp_base << key))
> +                       break;
> +       }
> +
> +do_lookup:
> +       hist =3D bpf_map_lookup_elem(&latency, &key);
> +       if (!hist)
> +               return;
> +
> +       __sync_fetch_and_add(hist, 1);
> +
> +       __sync_fetch_and_add(&total, delta); // always in nsec
> +       __sync_fetch_and_add(&count, 1);
> +
> +       if (delta > max)
> +               max =3D delta;
> +       if (delta < min)
> +               min =3D delta;
> +}
> +
> +SEC("kprobe/func")
> +int BPF_PROG(func_begin)
> +{
> +       __u64 key, now;
> +
> +       if (!enabled || !can_record())
> +               return 0;
> +
> +       key =3D bpf_get_current_pid_tgid();
>         now =3D bpf_ktime_get_ns();
>
>         // overwrite timestamp for nested functions
> @@ -92,7 +147,6 @@ int BPF_PROG(func_end)
>  {
>         __u64 tid;
>         __u64 *start;
> -       __u64 cmp_base =3D use_nsec ? 1 : 1000;
>
>         if (!enabled)
>                 return 0;
> @@ -101,56 +155,44 @@ int BPF_PROG(func_end)
>
>         start =3D bpf_map_lookup_elem(&functime, &tid);
>         if (start) {
> -               __s64 delta =3D bpf_ktime_get_ns() - *start;
> -               __u64 val =3D delta;
> -               __u32 key =3D 0;
> -               __u64 *hist;
> -
> +               update_latency(bpf_ktime_get_ns() - *start);
>                 bpf_map_delete_elem(&functime, &tid);
> +       }
>
> -               if (delta < 0)
> -                       return 0;
> +       return 0;
> +}
>
> -               if (bucket_range !=3D 0) {
> -                       val =3D delta / cmp_base;
> +SEC("raw_tp")
> +int BPF_PROG(event_begin)
> +{
> +       __u64 key, now;
>
> -                       if (min_latency > 0) {
> -                               if (val > min_latency)
> -                                       val -=3D min_latency;
> -                               else
> -                                       goto do_lookup;
> -                       }
> +       if (!enabled || !can_record())
> +               return 0;
>
> -                       // Less than 1 unit (ms or ns), or, in the future=
,
> -                       // than the min latency desired.
> -                       if (val > 0) { // 1st entry: [ 1 unit .. bucket_r=
ange units )
> -                               key =3D val / bucket_range + 1;
> -                               if (key >=3D bucket_num)
> -                                       key =3D bucket_num - 1;
> -                       }
> +       key =3D bpf_get_current_pid_tgid();
> +       now =3D bpf_ktime_get_ns();
>
> -                       goto do_lookup;
> -               }
> -               // calculate index using delta
> -               for (key =3D 0; key < (bucket_num - 1); key++) {
> -                       if (delta < (cmp_base << key))
> -                               break;
> -               }
> +       // overwrite timestamp for nested events
> +       bpf_map_update_elem(&functime, &key, &now, BPF_ANY);
> +       return 0;
> +}
>
> -do_lookup:
> -               hist =3D bpf_map_lookup_elem(&latency, &key);
> -               if (!hist)
> -                       return 0;
> +SEC("raw_tp")
> +int BPF_PROG(event_end)
> +{
> +       __u64 tid;
> +       __u64 *start;
>
> -               __sync_fetch_and_add(hist, 1);
> +       if (!enabled)
> +               return 0;
>
> -               __sync_fetch_and_add(&total, delta); // always in nsec
> -               __sync_fetch_and_add(&count, 1);
> +       tid =3D bpf_get_current_pid_tgid();
>
> -               if (delta > max)
> -                       max =3D delta;
> -               if (delta < min)
> -                       min =3D delta;
> +       start =3D bpf_map_lookup_elem(&functime, &tid);
> +       if (start) {
> +               update_latency(bpf_ktime_get_ns() - *start);
> +               bpf_map_delete_elem(&functime, &tid);
>         }
>
>         return 0;
> diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
> index a9bc47da83a56cd6..3f5094ac59080310 100644
> --- a/tools/perf/util/ftrace.h
> +++ b/tools/perf/util/ftrace.h
> @@ -17,6 +17,7 @@ struct perf_ftrace {
>         struct list_head        notrace;
>         struct list_head        graph_funcs;
>         struct list_head        nograph_funcs;
> +       struct list_head        event_pair;
>         struct hashmap          *profile_hash;
>         unsigned long           percpu_buffer_size;
>         bool                    inherit;
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

