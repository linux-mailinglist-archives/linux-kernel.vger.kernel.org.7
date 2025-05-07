Return-Path: <linux-kernel+bounces-637684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86905AADC03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 11:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1ED1C209D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 09:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA769215F5D;
	Wed,  7 May 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLNwEBxp"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F9D20C005
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611906; cv=none; b=ifKuog/lAJqydgiCWJ/hzhN64/gn6EQqXO1a7C1W4cwifTSsZ2vE3PwTJvYEtWaQDPbQbRwW5/nDoN+PaFvafuaTd4S15KnJCNLQVFclOaeRf/IaFml9WiC1yexaQcRQDnNmBIuszDhVKNlFo8bXxWzHFu8PNFgQZXcdw5HB4Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611906; c=relaxed/simple;
	bh=XFgZtcoLkhyNUROFBBsfK3A6oxSGmK9k5IgnGXbA59o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKImxvOpTTgmO/28kbxwwkqA4IEYka8cIm3Y9xCMYpV8u0krIGI5xxJjIM5VSLkR5MzYThXiwLTBQLqsT4tsI/RAe+qNeopnHmXNf3AXtAxvpfLKzPrwK2AejMbCLXkV/xJfLouxgLksWscRKjV5N7qDKhwQrerXF91NkzWWysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLNwEBxp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30beedb99c9so57234451fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746611902; x=1747216702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXwWfv9Y6m7fKiVmRbaKc0nnBUxgLNgKEyyeKygDRoo=;
        b=aLNwEBxpoz12lpsTIJR5TfwkYuPys7TWoEPRfq5jDZy0bDC/BLqtMMvezs6usxwNiS
         EhxrL98iagXvEEc5eZolPJ8WBbOnrUaoHaKsGN9wGhatpm+NXzZWcDGLlz5t03zAo8mG
         yuzlHFbzjlLTxZl5UCBX32jOq+bIm4d0TL4be9gmi0u36dynpHUF8UBGetVDKZ8PqwPA
         +fv/vJXIjc/YwgVykkuxQyNRWInhUjvbbtFfi6Jjqm/cPWdMxSCd4TI1PeQeqYriBR+n
         zlMhAq2McJGmPsx29JF2p2mvHzZ8Zhi5B3y4J8vVqaXCEyiXMAPLptZkbQwuxS2AngYi
         v91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746611902; x=1747216702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXwWfv9Y6m7fKiVmRbaKc0nnBUxgLNgKEyyeKygDRoo=;
        b=BpnUmoh6VU+0W+E6TkkttAbF2T9dg3c9JZnDXKLqslhk6oNA0UklBneCsFx9xE6/fY
         ise4QvXfecEF96//WrHJSAE30iGNSzG8fT6+hdNdnmJ8sunXEm3NROM//XKZD44dKQg+
         DWXq/2LXwE77ytKHSjKScfNW3efqrPebSaryttaMgRSuhm4t2V7vDj04fvTf51mndnIV
         UcGxmYm8K1NrXdh5yhTNrdHvyveZju35Pm+/bEYz6wNPUemzWHj2RsJbFGhZ8fVvkU7S
         YuFmWWsP8n3Ug5xd9+Zm5b6xd6XyyEBGmgy5jT1ctzRG5YWb9o5mlUNXolFYJYObWGhu
         BgCA==
X-Forwarded-Encrypted: i=1; AJvYcCX4EPh4lirL9AJg8BMpXnqCrv8WGxEJdKY/cnCYL2FR6jL1lfTLxZFMZBq8H7p3tb2FHKAHAA9d798U794=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzdc7rY1pZR/fZe1BTra8C+UCWbidyjnkg+sxNZy0K6eT3lfj4
	NM2f762KoxhmiMpP4DpTSHaV263mmQXZgkICTpgR/DsrXOelnUEtvqnQufatbfHAuB9+BkC0L2B
	p4G41k2aTIra4xN/pXKnee1DHODX6o+M4zrL9
X-Gm-Gg: ASbGncsN3/JOW0v0df3UxqUlY1+afntoxgaWWRMhDarZUWx7koL2kUxqMi1qBMa6V1s
	FgL1dWkET+Ul2l9uJWLdtO2IwkAATvYcZePNcVsOUlKrzPwhR91Eb9uF2hSeeavzHc03nUbw2M6
	G3yQRdImI8IAdaS9pEhvi5MvbOznTq/nG1BQJqJkcnWw/ePkLD6vSOcA4=
X-Google-Smtp-Source: AGHT+IH0nmguA5kmGfa+Jl62Im4bswR065WDLtDiHTlXIIynmZg5V0baBKOHGZ6yFCYiOEEqBKRsxwDBltscNuJZEKg=
X-Received: by 2002:a05:651c:2221:b0:310:856b:6862 with SMTP id
 38308e7fff4ca-326ad18b8cbmr7187081fa.12.1746611901682; Wed, 07 May 2025
 02:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503003620.45072-1-namhyung@kernel.org> <aBcjwoINtWRWKMIJ@gmail.com>
 <aBfFlT0l05yBbZBj@google.com> <CACT4Y+YvWYFBkZ9jQ2kuTOHb6pZQwWXc9sOJ5Km0Wr1fLi-94A@mail.gmail.com>
 <aBojTzsa5mSAGziP@x1> <aBo_z8Q87gflYyuX@x1>
In-Reply-To: <aBo_z8Q87gflYyuX@x1>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 May 2025 11:58:10 +0200
X-Gm-Features: ATxdqUE2PC2As493JjnQWWXVxL49H-woPEJSwzDPASz1ZQ5sZV00TE2_CZ9jlO0
Message-ID: <CACT4Y+YG61CUPG1WRSGWgv00eP9aPYLELvDVmjK9ULJwNiiMgw@mail.gmail.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in system-wide mode
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 May 2025 at 18:58, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> On Tue, May 06, 2025 at 11:57:19AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, May 05, 2025 at 10:03:05AM +0200, Dmitry Vyukov wrote:
> > > On Sun, 4 May 2025 at 21:52, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Sun, May 04, 2025 at 10:22:26AM +0200, Ingo Molnar wrote:
> > > > > > Here's an example:
> >
> > > > > >   # perf record -a -- perf bench sched messaging
> >
> > > > > > This basically forks each sender and receiver tasks for the run.
> >
> > > > > >   # perf report --latency -s comm --stdio
> > > > > >   ...
> > > > > >   #
> > > > > >   #  Latency  Overhead  Command
> > > > > >   # ........  ........  ...............
> > > > > >   #
> > > > > >       98.14%    95.97%  sched-messaging
> > > > > >        0.78%     0.93%  gnome-shell
> > > > > >        0.36%     0.34%  ptyxis
> > > > > >        0.23%     0.23%  kworker/u112:0-
> > > > > >        0.23%     0.44%  perf
> > > > > >        0.08%     0.10%  KMS thread
> > > > > >        0.05%     0.05%  rcu_preempt
> > > > > >        0.05%     0.05%  kworker/u113:2-
> > > > > >        ...
> >
> > > > > Just a generic user-interface comment: I had to look up what 'latency'
> > > > > means in this context, and went about 3 hops deep into various pieces
> > > > > of description until I found Documentation/cpu-and-latency-overheads.txt,
> > > > > where after a bit of head-scratching I realized that 'latency' is a
> > > > > weird alias for 'wall-clock time'...
> >
> > > > > This is *highly* confusing terminology IMHO.
> >
> > > > Sorry for the confusion.  I know I'm terrible at naming things. :)
> >
> > > > Actually Dmitry used the term 'wall-clock' profiling at first when he
> > > > implemented this feature but I thought it was not clear how it meant
> > > > for non-cycle events.  As 'overhead' is also a generic term, we ended
> > > > up with 'latency'.
> >
> > > Exactly :)
> >
> > So, the 'cycles' event is the most commonly used, its the default if one
> > does 'perf record' and don't ask for a specific event.
> >
> > When we notice that 'cycles' and 'instructions' are counted, we provide
> > an IPC, as that is a well known metric for that combo:
> >
> >   root@number:~# perf stat -e cycles,instructions sleep 1
> >
> >    Performance counter stats for 'sleep 1':
> >
> >            1,149,493      cycles
> >            1,197,279      instructions                     #    1.04  insn per cycle
> >
> >          1.000645408 seconds time elapsed
> >
> >          0.000599000 seconds user
> >          0.000000000 seconds sys
> >
> >
> >   root@number:~#
> >
> > So maybe when we notice that cycles was used 'perf report/top' should
> > use the term 'wall-clock' for the column name?
> >
> > So instead of having a --latency we could have a hint that would tell
> > the user that if this knob was set:
> >
> >   $ perf config report.wall-clock=true


I am not sure it can be as simple as a single global knob.

First, record needs to collect additional info and that may be
somewhat expensive.

Second, report now has several modes:
 - it can show latency, but order by the current overhead
 - it can also show latency, and order by latency
A user wants one or another depending on what they are optimizing
(possibly looking at both).

I also feel that global config switches are even less discoverable by
median users (read -- ~nobody will know about that). If these things
are normal flags with a help description, then some users may
eventually discover them.



> > Then if 'cycles' is present we would have:
>
> Something along the lines of the patch below, but there are several
> details to take into account with what is in the current codebase, only
> if what is needed for doing the latency/wall-clock time is present in
> the perf.data being used is present that knob would be used or suggested
> to the user, so some refactorings are needed, I'll try to folow on it.
>
> But just for reference:
>
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f0299c7ee0254a37..20874800d967ffb5 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -51,6 +51,7 @@
>  #include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
> +#include "ui/util.h"
>  #include "util/block-info.h"
>
>  #include <dlfcn.h>
> @@ -127,6 +128,11 @@ static int report__config(const char *var, const char *value, void *cb)
>  {
>         struct report *rep = cb;
>
> +       if (!strcmp(var, "report.prefer_latency")) {
> +               symbol_conf.prefer_latency = perf_config_bool(var, value);
> +               symbol_conf.prefer_latency_set = true;
> +               return 0;
> +       }
>         if (!strcmp(var, "report.group")) {
>                 symbol_conf.event_group = perf_config_bool(var, value);
>                 return 0;
> @@ -1734,6 +1740,15 @@ int cmd_report(int argc, const char **argv)
>                 symbol_conf.annotate_data_sample = true;
>         }
>
> +       if (!symbol_conf.prefer_latency) {
> +               if (ui__dialog_yesno("Do you want to use latency mode?\n"
> +                                    "That will add a 'Latency' column that would mean\n"
> +                                    "'wall-clock' time when used with cycles, for instance\n")) {
> +                       symbol_conf.prefer_latency = symbol_conf.prefer_latency_set = true;
> +                       perf_config__set_variable("report.prefer_latency", "yes");
> +               }
> +       }
> +
>         symbol_conf.enable_latency = true;
>         if (report.disable_order || !perf_session__has_switch_events(session)) {
>                 if (symbol_conf.parallelism_list_str ||
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index cd9aa82c7d5ad941..f87071f5dedd94ca 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -51,6 +51,7 @@ struct symbol_conf {
>                         annotate_data_sample,
>                         skip_empty,
>                         enable_latency,
> +                       prefer_latency_set,
>                         prefer_latency;
>         const char      *vmlinux_name,
>                         *kallsyms_name,

