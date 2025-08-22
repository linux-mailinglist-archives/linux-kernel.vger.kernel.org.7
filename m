Return-Path: <linux-kernel+bounces-782524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA6B3218F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687AB1BA8515
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13034313524;
	Fri, 22 Aug 2025 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Su7hx7+C"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B268F287247
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884160; cv=none; b=Y6Ya73m+EOEZTxySpBsanOBLjwTS6R6i/jLTj172Re/wiTkX74K0sx3qzELqocPiFWFOmAhPVzXEhga63ORTMD2lWYMV0Np1Ti6FStHUhDpzQsRtTMJQdPDgB1VQdrcfHtyl1yjBFLXPPTK8yV0l9tbiWbT18QTLxgFRTmYbyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884160; c=relaxed/simple;
	bh=eJsMynx83l0LBznNXYP1HGV979DlG3NlfRAfiPZlRkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=girP09UqcDOmX6SbWAly+LpoRxygINY6/B/4JuppD5S9gBbSS88AGOMwoVTrfeD8S/sgZhm6u4pJbkj73xUXf1prmQa48Iu8N2tAqOERTt8bv1BCmGtWPqAEET5ad586rssP9sXMbTg8j/2ZGRLNJVoKfOSpP/uK3YDBxszCDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Su7hx7+C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24611734e50so10205ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755884158; x=1756488958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxMIAYsmBX7pQetf20qwDs7pp1uN+xZt/escuuakgQs=;
        b=Su7hx7+CStv37at5uCI8iBUqAOe7Pqx1QM0vUWxQewWSUuQ5uFqvmiQUs8kIKfQor0
         EK7z7CTTHONAMyh9O++vSGoxdiYKVFj8tVxhEiFm0emFHcw6SAQQOYUrhLBkdnHTYwf/
         dO6YHQOjkEalr4Zh9hAZnA8o8iE/bFLhnSX2GNdozAcctKyhywYoxWsc30gU8P1j+HNw
         cOv2LpFDh3E/w6H49nRduv5wm7E7prZzR+25eBJCYrpqkLIaDd3hCHlgVHTFKcGbzf8M
         oeAn8g+KFqVYWut7PESQJjQKbIevLS1Bp0r2Rsp5i8TxDm8D4uETm0GbR6ok7et+TlNg
         JsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755884158; x=1756488958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxMIAYsmBX7pQetf20qwDs7pp1uN+xZt/escuuakgQs=;
        b=Dds7zibTVhGNeTOI+NB++U1NcVrBwCxgve6yB+9J2JQk50cEGORpWwcS0W5GxHnsoT
         lK0orI1YSMJ4Hng+64Fvm2JYYOgi2VWTjvg1QRf1gamq3CMUxFOap9f4tuJGpZuJgxi4
         O6aBaXX/lT4vzeKQJvZyOsJPrEuYanYwfX68e4RYy7Z/IKWu7zd7ZYrVJJo/hum2Jypc
         P+Go3LGl6amrguL5hfsXzxmAcew+00Om1cLDg55YLDbxJF0wzy0bAXVLVr2F/iPYWtkK
         qLQoY45AeFPv8Sn9GFITCFcKgAsYT4upjPl2BCtBLdjptk3JoOH0lnSUIv1JCL/pPxIk
         veAw==
X-Forwarded-Encrypted: i=1; AJvYcCUyPW6CsbN7c6MkSqNAoYe+llz9ug+TPPGauKoMrVYJs2+lUCStMPYeRaLlbWxpYIA99uBx9VoqvnNR5Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+wtxu0XqGBo1nCL5m5W88INQ4xI/4M6MNShO7FKi7IrtBXba
	wtHTJ6icG2cTnVqN0O5VCQfaRd08SAMH6GwwqyeENmA5pW0dsRH0M43KNE1Y86cQG8A7Dm6kvT9
	bnavYYYox0v6DG9TJD0TUOaLuNVum+T5kXjw7CIdJ
X-Gm-Gg: ASbGncsNfQfqP9iiW0JcJY70hSwOvYbxaY1lotJ/yHploe0Aq0HvkoHJoIBki8QcBIS
	AAQI7ZgwpNakRBMG/FSuRnMzrINQSLET9t4hIDXdRv3xAQJx04KyL/rZSTph5ebcsElABBlK2jI
	JBMnKjBpC5qO8Rbeo0cGNiLlqkFPGO6w/vovJ5YkMw8WtQSNE0xGoTI8nOQoV99NPuDrk3g1ntZ
	wJd8PJfPBct3gE=
X-Google-Smtp-Source: AGHT+IGzGTMvlHX2cgWkj/d+BDv4aPkPacgILHNz/inq23p+dXXG8eVDIN3nVmeYKRVb+nyH2Y5WHPASBq1Vm3O3ITw=
X-Received: by 2002:a17:902:ceca:b0:240:8f2:6442 with SMTP id
 d9443c01a7336-24639fc92d8mr4117895ad.15.1755884157656; Fri, 22 Aug 2025
 10:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082233.1850417-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250822082233.1850417-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 10:35:45 -0700
X-Gm-Features: Ac12FXysTUm0GAbFNO6Cf4WvcoN9Lpc0qV80egGEyKFhkBN6cdDaYlaM9UbojHM
Message-ID: <CAP-5=fW6N+eE0KTyV7F4wm=KBwk46QbXjwwG9POtZxEDhbRqRQ@mail.gmail.com>
Subject: Re: [PATCH] perf tools topdown: Fix incorrect topdown slots regroup
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:23=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> When running the command "perf stat -e "slots,slots" -C0 sleep 1", we
> see below error.
>
> perf stat -e "slots,slots" -C0 sleep 1
> WARNING: events were regrouped to match PMUs
>  Performance counter stats for 'CPU(s) 0':
>      <not counted>      slots
>    <not supported>      slots
>
>      1.002265769 seconds time elapsed
>
> The topdown slots events are not correctly counted. The root cause is
> that perf tools incorrectly regroup these 2 slots events into a group.
> If there are only topdown slots events but no topdown metrics events,
> the regroup should not be done since topdown slots event can only be
> programed on fixed counter 3 and multiple slots events can only be
> multiplexed to run on fixed counter 3, but grouping them blocks
> multiplexing.
>
> So avoid to regroup topdown slots events if there is no topdown metrics
> events.
>
> With this change, above command can be run successfully.
>
> perf stat -e "slots,slots" -C0 sleep 1
>  Performance counter stats for 'CPU(s) 0':
>        103,973,791      slots
>        106,488,170      slots
>
>        1.003517284 seconds time elapsed
>
> Besides, run perf stats/record test on SPR and PTL, both passed.
>
> Reported-by: Xudong Hao <xudong.hao@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

I don't think we should do this and if we were to do it we shouldn't
do it in the common code. The perf metrics requiring a slots event is
a massive mess that never seems to end. What should we do with:
```
$ perf stat -e "topdown-fe-bound,topdown-fe-bound" true

Performance counter stats for 'true':

    <not counted>      slots
    <not counted>      topdown-fe-bound
  <not supported>      topdown-fe-bound

      0.000960472 seconds time elapsed

      0.001060000 seconds user
      0.000000000 seconds sys


Some events weren't counted. Try disabling the NMI watchdog:
       echo 0 > /proc/sys/kernel/nmi_watchdog
       perf stat ...
       echo 1 > /proc/sys/kernel/nmi_watchdog
```

We've injected the slots event but the repeated topdown-fe-bound
causes the group to fail in a similar way. Why is repeating slots a
case we care about more?
Were we to say, okay slots is more special than the other perf metric
events then I'd prefer arch_evsel__must_be_in_group to return false
for the slots event when there are no other perf metric events in the
evlist. But then what do you do if the slots event is in a different
group like:
```
$ perf stat -e "slots,{slots,topdown-fe-bound}" true
```
It is pretty easy to teach the code to deduplicate events, but then
again, what about the group behavior?
It is not clear to me we can ever clean up all the mess that the perf
metric events on p-cores create and I'm in favor of having the code be
no more complex than it needs to be, so I'm not sure we should be
solving this problem.

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/topdown.h |  2 --
>  tools/perf/util/evsel.c            | 10 ++++++++++
>  tools/perf/util/evsel.h            |  2 ++
>  tools/perf/util/parse-events.c     | 11 +++++++++++
>  4 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/uti=
l/topdown.h
> index 69035565e649..6a917b2066f7 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -8,8 +8,6 @@ struct evsel;
>  struct list_head;
>
>  bool topdown_sys_has_perf_metrics(void);
> -bool arch_is_topdown_slots(const struct evsel *evsel);
> -bool arch_is_topdown_metrics(const struct evsel *evsel);
>  int topdown_insert_slots_event(struct list_head *list, int idx, struct e=
vsel *metric_event);
>
>  #endif
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d264c143b592..6aaae1ac026e 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3965,6 +3965,16 @@ int evsel__source_count(const struct evsel *evsel)
>         return count;
>  }
>
> +bool __weak arch_is_topdown_slots(const struct evsel *evsel __maybe_unus=
ed)
> +{
> +       return false;
> +}
> +
> +bool __weak arch_is_topdown_metrics(const struct evsel *evsel __maybe_un=
used)
> +{
> +       return false;
> +}
> +
>  bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __may=
be_unused)
>  {
>         return false;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 5797a02e5d6a..33f8aab675a9 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -556,6 +556,8 @@ void evsel__set_leader(struct evsel *evsel, struct ev=
sel *leader);
>  int evsel__source_count(const struct evsel *evsel);
>  void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)=
;
>
> +bool arch_is_topdown_slots(const struct evsel *evsel);
> +bool arch_is_topdown_metrics(const struct evsel *evsel);
>  bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>
>  bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_=
stat_config *config);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 8282ddf68b98..bd09fc47ea90 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2127,6 +2127,8 @@ static int parse_events__sort_events_and_fix_groups=
(struct list_head *list)
>         int ret;
>         struct evsel *force_grouped_leader =3D NULL;
>         bool last_event_was_forced_leader =3D false;
> +       bool has_slots =3D false;
> +       bool has_metrics =3D false;
>
>         /* On x86 topdown metrics events require a slots event. */
>         ret =3D arch_evlist__add_required_events(list);
> @@ -2147,6 +2149,11 @@ static int parse_events__sort_events_and_fix_group=
s(struct list_head *list)
>                 if (pos =3D=3D pos_leader)
>                         orig_num_leaders++;
>
> +               if (!has_slots)
> +                       has_slots =3D arch_is_topdown_slots(pos);
> +               if (!has_metrics)
> +                       has_metrics =3D arch_is_topdown_metrics(pos);
> +
>                 /*
>                  * Ensure indexes are sequential, in particular for multi=
ple
>                  * event lists being merged. The indexes are used to dete=
ct when
> @@ -2163,6 +2170,10 @@ static int parse_events__sort_events_and_fix_group=
s(struct list_head *list)
>                         force_grouped_idx =3D pos_leader->core.idx;
>         }
>
> +       /* Don't regroup if there are only topdown slots events. */
> +       if (force_grouped_idx !=3D -1 && has_slots && !has_metrics)
> +               force_grouped_idx =3D -1;
> +
>         /* Sort events. */
>         list_sort(&force_grouped_idx, list, evlist__cmp);
>
>
> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
> --
> 2.34.1
>

