Return-Path: <linux-kernel+bounces-887878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98972C39494
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3488B3B5568
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412B2D9EE2;
	Thu,  6 Nov 2025 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="igPW6I0e"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10F2D73A4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762411348; cv=none; b=fsqWMDZc0LkWMTw6vnobVrL8Wi+I+qaXTKygOlj52nqyZ5DiWU9VN5scJe+PF3IwqsyZgYFiGP1Zjo+AyGc+je0rpz3s8OSFwWlg6bomTg4jCLzv1jKg3e2wg5e4miDWEqLG5eiGf5ZEgzUx+C1f2F4GfXm7/eEQz5UUZzCRv2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762411348; c=relaxed/simple;
	bh=AeSCdyni83k4yUuA+0559bO8HAwzStYb9FVIwXJwHyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IahT5bVPwNIfHbiNzepDO4hKrqMTaTFKueNZVwbmPUn4OfKy0YjXMaidJGb9xzIf1HsTUSZSI1XrFWBKzi6HMQXmSy2TO/v+4Gop3fgLuFnlXw1aGCLYxxQfr+2uV5ECoSWoJJMZi0Cq0JZqm3bNXNBGBW3uqTE4eH5fHyzaT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=igPW6I0e; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-294f3105435so83265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762411346; x=1763016146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvO8RyImdodmU0WiqheiYuh6o925qsAYhxVdO/bn8JE=;
        b=igPW6I0eFrTFhOGUdBc+zPi18hWM07zWK8Z2j3Tlw8IsXt+wtAV/7QnjHzKKEh8ecO
         8cY62/OEpKVexuGsKL75HQWC/eOkoawLQ0np6DHqeZEkV5CZtyLxYpEokg3sw+XSlwff
         BEVfgwtQLtfgVnIqFlxFX9QZ4ENCRx8auMzJXmJyKCRSFM7ZqkjHmfJse3Xl783A6HW5
         5+mBoWX7pfKTpvhsuCspPn3E8CgPo5AuYFJcXC2yFQ06+ekH+5wg1i7oGr9UMRDvNr+M
         Ri/Kxv+GJpHqOixQM5FlSkFfwAXgiQ9HQEy3CT6/loEVFIy6RuDEddHodlJ5UrudYFUe
         iYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762411346; x=1763016146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvO8RyImdodmU0WiqheiYuh6o925qsAYhxVdO/bn8JE=;
        b=BQai16y5YFPpSvP7KSsu9FFG1GHim8qdKZQpBrqE0QLCLHObfj811JxZici3keVApD
         m5113PTI9aQNB5tollmmwVQyYiDdmTWG1qAmymMcAdbOUSk/2z5ZZO6hz7tx8TSND3MF
         99BIsZ2EumZlhF6S2WQLLxaId0jPvLqlSNsbb0mm5/FPjsM0EJ7yvaq+gHMNwC7CzJA+
         Ohi7NCY/q+1wAclwLu3yGtNkHe3Q2oBZHoRMzbC7TB5AD7EpcFVIYpn5NuA6c7OOMyUM
         RGLFVICHOuL6KAGwDd3TCVUbP+zy1TvIu6DDMbPtcYq53Ahg0JK+uBQLySFCOzyCskwJ
         4wgw==
X-Forwarded-Encrypted: i=1; AJvYcCWoBQTzDPaPwkciX1pf0Yl7fX1hXyFeu/NpX6d/qcsLAvsNk76qMOpgsHtyC+2+EfwpOoO13svDCv493x0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMqywV5Huvm16WIl0RwiKqlqEhdFDBNMuTuB4m/3Gw+v2JjTw
	imaMrd9yo1CD6pIf+tOQVQjTYoSGVlohwtxyoCajmKrzhmylZWuRgWzvEClYEQXaccqbYdjyb41
	GG+y2pgnWvzK3EFAWGxUapS5ohDho/Uy/FvjOEwzd
X-Gm-Gg: ASbGnctzV50CJNeagrmPoksqfL6jwXbMxz/41ijV/o6b+OZKlnSZnj2TIntPIk33wEK
	J3T2S6Sl+z6bN1y1rre95j8Cu5n5mF1FYipm3njUF7mKfbVWI6PTzlmmz5D8prrb/i1sagsz5B3
	re/8tWncpuLNyisvC51GnXcAT2YrLoX53S5jDuWj1f8cVS/n+mPHhrkMsRQnVF/kNl7D/To1kqj
	+TPfCF8kbqaGa8Rz5bUW9J+VD6Ovzzu+DCgY7RqNlchTNlUGhDCq7Dz9Fug
X-Google-Smtp-Source: AGHT+IHC+tliRZizWFcSYLcf5QMiPn7Oq+hZB4RN/+YM9E3o/Jahu+vLtbbDG6NA9xu77vW5B1wRahXndakIa0XJHko=
X-Received: by 2002:a17:902:f818:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-2965b1dba42mr1678855ad.13.1762411345890; Wed, 05 Nov 2025
 22:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <20251024175857.808401-6-irogers@google.com>
 <aQmGfLVKk0UFGAyd@google.com> <CAP-5=fXmT-1io1k1O5d2QMken9aJmGTiuDEz2f-7k8-n=GCWtA@mail.gmail.com>
 <aQw6Jje7bSpywGqq@google.com>
In-Reply-To: <aQw6Jje7bSpywGqq@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Nov 2025 22:42:13 -0800
X-Gm-Features: AWmQ_bk_ICs-PvZxmDtwMA5i1WiR0FyuaXdsrA9bzvplc08ela5Gm4UCfQidVCU
Message-ID: <CAP-5=fV666tSv+3=6t-UobtGuzvw4g2oQZZScCX-P7oqDz+4Rg@mail.gmail.com>
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

On Wed, Nov 5, 2025 at 10:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 03, 2025 at 09:28:44PM -0800, Ian Rogers wrote:
> > On Mon, Nov 3, 2025 at 8:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Fri, Oct 24, 2025 at 10:58:40AM -0700, Ian Rogers wrote:
> > > > Rather than using the first evsel in the matched events, try to fin=
d
> > > > the least shared non-tool evsel. The aim is to pick the first evsel
> > > > that typifies the metric within the list of metrics.
> > > >
> > > > This addresses an issue where Default metric group metrics may lose
> > > > their counter value due to how the stat displaying hides counters f=
or
> > > > default event/metric output.
> > >
> > > Do you have a command line example to show impact of this change?
> >
> > You can just run a Topdown metricgroup on Intel to see differences,
>
> Ok, before this change.
>
>   $ perf stat -M topdownL1 true
>
>    Performance counter stats for 'true':
>
>            7,754,275      TOPDOWN.SLOTS                    #     37.1 %  =
tma_backend_bound
>                                                     #     38.7 %  tma_fro=
ntend_bound
>                                                     #      8.8 %  tma_bad=
_speculation
>                                                     #     15.3 %  tma_ret=
iring
>            1,185,947      topdown-retiring
>            3,010,483      topdown-fe-bound
>            2,828,029      topdown-be-bound
>              729,814      topdown-bad-spec
>                9,987      INT_MISC.CLEARS_COUNT
>              221,405      IDQ.MS_UOPS
>                6,352      INT_MISC.UOP_DROPPING
>            1,212,644      UOPS_RETIRED.SLOTS
>              119,895      UOPS_DECODED.DEC0
>               60,975      cpu/UOPS_DECODED.DEC0,cmask=3D1/
>            1,639,442      UOPS_ISSUED.ANY
>              820,982      IDQ.MITE_UOPS
>
>          0.001172956 seconds time elapsed
>
>          0.001269000 seconds user
>          0.000000000 seconds sys
>
>
> And with this change, it does look better.
>
>   $ perf stat -M topdownL1 true
>
>    Performance counter stats for 'true':
>
>            7,977,430      TOPDOWN.SLOTS
>            1,188,793      topdown-retiring
>            3,159,687      topdown-fe-bound
>            2,940,699      topdown-be-bound
>              688,248      topdown-bad-spec
>                9,749      INT_MISC.CLEARS_COUNT            #     37.5 %  =
tma_backend_bound
>                                                     #      8.1 %  tma_bad=
_speculation
>              219,145      IDQ.MS_UOPS                      #     14.9 %  =
tma_retiring
>                6,188      INT_MISC.UOP_DROPPING            #     39.5 %  =
tma_frontend_bound
>            1,205,712      UOPS_RETIRED.SLOTS
>              117,505      UOPS_DECODED.DEC0
>               59,891      cpu/UOPS_DECODED.DEC0,cmask=3D1/
>            1,625,232      UOPS_ISSUED.ANY
>              805,560      IDQ.MITE_UOPS
>
>          0.001629344 seconds time elapsed
>
>          0.001672000 seconds user
>          0.000000000 seconds sys
>
> > but they are minor. The main impact is on the Default legacy metrics
> > as those have a counter then a metric, but without this change you get
> > everything grouped on the cpu-clock event and the formatting gets broke=
n.
>
> Do you mean with other changes in this series?  I don't see any
> differences in the output just after this patch..
>
> Before:
>
>   $ perf stat -a true
>
>    Performance counter stats for 'system wide':
>
>           19,078,719      cpu-clock                        #    7.256 CPU=
s utilized
>                   94      context-switches                 #    4.927 K/s=
ec
>                   14      cpu-migrations                   #  733.802 /se=
c
>                   61      page-faults                      #    3.197 K/s=
ec
>           43,304,957      instructions                     #    1.10  ins=
n per cycle
>           39,281,107      cycles                           #    2.059 GHz
>            5,012,071      branches                         #  262.705 M/s=
ec
>              128,358      branch-misses                    #    2.56% of =
all branches
>    #     24.4 %  tma_retiring
>    #     33.7 %  tma_backend_bound
>                                                     #      5.9 %  tma_bad=
_speculation
>    #     36.0 %  tma_frontend_bound
>
>          0.002629534 seconds time elapsed
>
> After:
>
>   $ perf stat -a true
>
>    Performance counter stats for 'system wide':
>
>            6,201,661      cpu-clock                        #    3.692 CPU=
s utilized
>                   24      context-switches                 #    3.870 K/s=
ec
>                    7      cpu-migrations                   #    1.129 K/s=
ec
>                   60      page-faults                      #    9.675 K/s=
ec
>           11,458,681      instructions                     #    1.07  ins=
n per cycle
>           10,704,978      cycles                           #    1.726 GHz
>            2,457,704      branches                         #  396.298 M/s=
ec
>               54,553      branch-misses                    #    2.22% of =
all branches
>    #     21.4 %  tma_retiring
>    #     36.1 %  tma_backend_bound
>                                                     #     10.2 %  tma_bad=
_speculation
>    #     32.3 %  tma_frontend_bound
>
>          0.001679679 seconds time elapsed

These are the hardcoded metrics that aren't impacted by my changes to
the json metric's behavior. Patch 8 will add json for the legacy
metrics.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > As --metric-only is popular when looking at a group of events
> > and the Default legacy metrics are added in subsequent changes it
> > didn't seem right to include the output (it either shows broken things
> > keeping to be somewhat broken or output from later patches).
> >
> > Thanks,
> > Ian
> >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/metricgroup.c | 48 +++++++++++++++++++++++++++++++=
+++-
> > > >  1 file changed, 47 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metric=
group.c
> > > > index 48936e517803..76092ee26761 100644
> > > > --- a/tools/perf/util/metricgroup.c
> > > > +++ b/tools/perf/util/metricgroup.c
> > > > @@ -1323,6 +1323,51 @@ static int parse_ids(bool metric_no_merge, b=
ool fake_pmu,
> > > >       return ret;
> > > >  }
> > > >
> > > > +/* How many times will a given evsel be used in a set of metrics? =
*/
> > > > +static int count_uses(struct list_head *metric_list, struct evsel =
*evsel)
> > > > +{
> > > > +     const char *metric_id =3D evsel__metric_id(evsel);
> > > > +     struct metric *m;
> > > > +     int uses =3D 0;
> > > > +
> > > > +     list_for_each_entry(m, metric_list, nd) {
> > > > +             if (hashmap__find(m->pctx->ids, metric_id, NULL))
> > > > +                     uses++;
> > > > +     }
> > > > +     return uses;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Select the evsel that stat-display will use to trigger shadow/m=
etric
> > > > + * printing. Pick the least shared non-tool evsel, encouraging met=
rics to be
> > > > + * with a hardware counter that is specific to them.
> > > > + */
> > > > +static struct evsel *pick_display_evsel(struct list_head *metric_l=
ist,
> > > > +                                     struct evsel **metric_events)
> > > > +{
> > > > +     struct evsel *selected =3D metric_events[0];
> > > > +     size_t selected_uses;
> > > > +     bool selected_is_tool;
> > > > +
> > > > +     if (!selected)
> > > > +             return NULL;
> > > > +
> > > > +     selected_uses =3D count_uses(metric_list, selected);
> > > > +     selected_is_tool =3D evsel__is_tool(selected);
> > > > +     for (int i =3D 1; metric_events[i]; i++) {
> > > > +             struct evsel *candidate =3D metric_events[i];
> > > > +             size_t candidate_uses =3D count_uses(metric_list, can=
didate);
> > > > +
> > > > +             if ((selected_is_tool && !evsel__is_tool(candidate)) =
||
> > > > +                 (candidate_uses < selected_uses)) {
> > > > +                     selected =3D candidate;
> > > > +                     selected_uses =3D candidate_uses;
> > > > +                     selected_is_tool =3D evsel__is_tool(selected)=
;
> > > > +             }
> > > > +     }
> > > > +     return selected;
> > > > +}
> > > > +
> > > >  static int parse_groups(struct evlist *perf_evlist,
> > > >                       const char *pmu, const char *str,
> > > >                       bool metric_no_group,
> > > > @@ -1430,7 +1475,8 @@ static int parse_groups(struct evlist *perf_e=
vlist,
> > > >                       goto out;
> > > >               }
> > > >
> > > > -             me =3D metricgroup__lookup(&perf_evlist->metric_event=
s, metric_events[0],
> > > > +             me =3D metricgroup__lookup(&perf_evlist->metric_event=
s,
> > > > +                                      pick_display_evsel(&metric_l=
ist, metric_events),
> > > >                                        /*create=3D*/true);
> > > >
> > > >               expr =3D malloc(sizeof(struct metric_expr));
> > > > --
> > > > 2.51.1.821.gb6fe4d2222-goog
> > > >

