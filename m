Return-Path: <linux-kernel+bounces-884107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24359C2F5FE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 06:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 094BC4E74B7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 05:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB02C158A;
	Tue,  4 Nov 2025 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0twRMHLx"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64292C17B2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 05:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762234139; cv=none; b=IdZrNS6nvsVwd1/ys3MoXomjJPtdAKlmsAOwApLMsQTp/sPsYs7YeVl27hev8dSDOweKwCrFm1sEIdHPWtxphRFEAUxYBxvvLCIfR3eF/LYdFbPn09H++f9SttsC5svb7SKoW7jZ53Kk2TJnRzaOtou3LOAEmHkZWie6wRd1Su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762234139; c=relaxed/simple;
	bh=dMOEAA8GWYIubycfTVBkI9jKxhkLcP0bVyeDigKDK0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbr/mZjM1Z8p8lB+EAZ7cn3Eg3eEpkXguC0jMg67DLFsQBWqDXtyx+oKg5DaTEgNgPN/wBpeL/MJV/vre/9X4wIJqxyNBeuwWaDKffApQ1QtfazxszcyKSPWC6s0V6f5P0N0BPOwg2qx+NIR9H10nw7IRAjRQMv82689B6wZJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0twRMHLx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-294f3105435so79905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 21:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762234137; x=1762838937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2aWs57zSxHlJgbuktEHfucwrB4ITcuv2AKwjP/Wk0w=;
        b=0twRMHLx5skbsoP7FCWbPDevt6lB6uSszgUQTRwCYyg2yc7XD8N1Gvek1AzH76lEl0
         pzgKBA1leBzr3ZJO20jKOGIq3o5QPVlva9Gfx3XacAQOUOcQOkQ0WOpH1p3byc8pRlTH
         fQAc+qayV+bOe7hFisxy/Ra3bBvMBC+KewOwCARH4duUEJSYsEyoWBjWcuYF9TPEHuAo
         vmnTGTyfzYTK0a0ys2qJvBlbsGmsD7ald/b9hDN0xRLsd1iPn8CC/q6GABkTvMXKvxU7
         rOOBA5rvinoIsm7BzOMeKuNhVaVkgZ7BK1PlQtrM7wcgTc7fpg1TDbpwsVzot5y10+in
         fzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762234137; x=1762838937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2aWs57zSxHlJgbuktEHfucwrB4ITcuv2AKwjP/Wk0w=;
        b=CpCrSjyFbV0Wj30apuIv7tzPH0JrksduxXmmGw2eqvvk06Jo+efBLzNEz6h/hxaw2h
         r2qsH6DaEt3MXeoLzOcJavEt+SqH9et/OnbZ3Vjr/wreLWo2jUCUL5bxiVD/S6WjA8k1
         gvBpjxNM8JpNuTanpFwwPHX1istXax6oinqNHioOktdN7sMJC+o04Xgmj8wbgp8U3Qee
         DOkC+Ew7HNORtGHh/9bFyJWT4YclxMv4kYpDISLgu90Bp74dH+td6kwwsBsVfa+FAE3T
         7FgpYqvPWX9Tuzb+BNr9kYFsgWJtix7LwGVxrc4+2I6fTZq2RNk22xJmOY6sqF59abbK
         p/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVFDecQnlGctxtsDFhDswVyhK5ZIrS/Ap6upTJs2b202QtbS0jdwTExetPL0PA2h/O6hL0jjnVwtRnAnS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnISrfHkdAycPSRqQoALiOvH2CjqX4Pjr9UWVrEqH035p8ZT6
	DiVHfEq0l5Jgde5yHI93jOyDrf8dAd7VMwCRnWQVkdJIaLtUUnzprXAIdqy+6Ci9pYNeR7ceFUa
	9s1Mtrg1/D45LXHoeqmPIH9ZVEAzsDhYnp33zwthZ
X-Gm-Gg: ASbGncumNUG4XYUbvL19WyNIYB94WzVItDhIQ6st0Xpzq1T9XhxmEG/GnEBxWPd6cpD
	XG9hGgH4dDg2QIdqSdAWbnlr3H9f9nwHUmp2zq77LUQ4bYgUa8iNrWBV5Sgr27v73K5JFIJn6eN
	Z/uHGrs6x8r5hLQqG1601RFQU49kct6DwiN+pTAaTgrUy0P9MwxrxEbI0LaJvmSAmG7tMNZMcrB
	AqZHIM0n42DHRKZawXYETFJVLbon3Bx+PDoaZriVazj2Oetg3KXgmm7ITTq
X-Google-Smtp-Source: AGHT+IEi9YdW9GTsQGZs+7zC0lFkbYEYBddSvfjzjf/CDH3HqUjOBKghCy5qDZrBQQWFPlYhJpCebKvj5EuNvo4P1P4=
X-Received: by 2002:a17:902:ec81:b0:290:d7fd:6297 with SMTP id
 d9443c01a7336-295fd265e91mr3206885ad.2.1762234136685; Mon, 03 Nov 2025
 21:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <20251024175857.808401-6-irogers@google.com>
 <aQmGfLVKk0UFGAyd@google.com>
In-Reply-To: <aQmGfLVKk0UFGAyd@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Nov 2025 21:28:44 -0800
X-Gm-Features: AWmQ_bm65uB0uiBSTUWEdAcPUVhrFMoOgwM3eGlAJSJdxgFlP3ezGoqnZJfmvAM
Message-ID: <CAP-5=fXmT-1io1k1O5d2QMken9aJmGTiuDEz2f-7k8-n=GCWtA@mail.gmail.com>
Subject: Re: [PATCH v1 05/22] perf metricgroup: Add care to picking the evsel
 for displaying a metric
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Oct 24, 2025 at 10:58:40AM -0700, Ian Rogers wrote:
> > Rather than using the first evsel in the matched events, try to find
> > the least shared non-tool evsel. The aim is to pick the first evsel
> > that typifies the metric within the list of metrics.
> >
> > This addresses an issue where Default metric group metrics may lose
> > their counter value due to how the stat displaying hides counters for
> > default event/metric output.
>
> Do you have a command line example to show impact of this change?

You can just run a Topdown metricgroup on Intel to see differences,
but they are minor. The main impact is on the Default legacy metrics
as those have a counter then a metric, but without this change you get
everything grouped on the cpu-clock event and the formatting gets
broken. As --metric-only is popular when looking at a group of events
and the Default legacy metrics are added in subsequent changes it
didn't seem right to include the output (it either shows broken things
keeping to be somewhat broken or output from later patches).

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 48 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 48936e517803..76092ee26761 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, bool =
fake_pmu,
> >       return ret;
> >  }
> >
> > +/* How many times will a given evsel be used in a set of metrics? */
> > +static int count_uses(struct list_head *metric_list, struct evsel *evs=
el)
> > +{
> > +     const char *metric_id =3D evsel__metric_id(evsel);
> > +     struct metric *m;
> > +     int uses =3D 0;
> > +
> > +     list_for_each_entry(m, metric_list, nd) {
> > +             if (hashmap__find(m->pctx->ids, metric_id, NULL))
> > +                     uses++;
> > +     }
> > +     return uses;
> > +}
> > +
> > +/*
> > + * Select the evsel that stat-display will use to trigger shadow/metri=
c
> > + * printing. Pick the least shared non-tool evsel, encouraging metrics=
 to be
> > + * with a hardware counter that is specific to them.
> > + */
> > +static struct evsel *pick_display_evsel(struct list_head *metric_list,
> > +                                     struct evsel **metric_events)
> > +{
> > +     struct evsel *selected =3D metric_events[0];
> > +     size_t selected_uses;
> > +     bool selected_is_tool;
> > +
> > +     if (!selected)
> > +             return NULL;
> > +
> > +     selected_uses =3D count_uses(metric_list, selected);
> > +     selected_is_tool =3D evsel__is_tool(selected);
> > +     for (int i =3D 1; metric_events[i]; i++) {
> > +             struct evsel *candidate =3D metric_events[i];
> > +             size_t candidate_uses =3D count_uses(metric_list, candida=
te);
> > +
> > +             if ((selected_is_tool && !evsel__is_tool(candidate)) ||
> > +                 (candidate_uses < selected_uses)) {
> > +                     selected =3D candidate;
> > +                     selected_uses =3D candidate_uses;
> > +                     selected_is_tool =3D evsel__is_tool(selected);
> > +             }
> > +     }
> > +     return selected;
> > +}
> > +
> >  static int parse_groups(struct evlist *perf_evlist,
> >                       const char *pmu, const char *str,
> >                       bool metric_no_group,
> > @@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_evlis=
t,
> >                       goto out;
> >               }
> >
> > -             me =3D metricgroup__lookup(&perf_evlist->metric_events, m=
etric_events[0],
> > +             me =3D metricgroup__lookup(&perf_evlist->metric_events,
> > +                                      pick_display_evsel(&metric_list,=
 metric_events),
> >                                        /*create=3D*/true);
> >
> >               expr =3D malloc(sizeof(struct metric_expr));
> > --
> > 2.51.1.821.gb6fe4d2222-goog
> >

