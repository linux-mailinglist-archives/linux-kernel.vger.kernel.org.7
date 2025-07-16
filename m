Return-Path: <linux-kernel+bounces-734242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9DB07ED5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086B8584698
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39629ACFC;
	Wed, 16 Jul 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kh4y9W6A"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B419755B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697532; cv=none; b=Tz+t3BwnN3YeCMHngg2eRuIpDpe29Ihv39rio16MGiseHTiEgmmgxd3VuipheY7wlNkOg7wjg3AXyl+eopHCxYIZJFkevWSpe0ZgU88qV2hKDabIZlMW9UHlKLyw1sPecwDcRrAvLgpCK84dG/EOFhQzAS9H9B2Vwxq4i13l3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697532; c=relaxed/simple;
	bh=VAfCUtP3I/jxADnLqcT4chrha2yC4Nh00rThl4dglC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjGnuOCu/ymxlB5A0ejw5BwwwJzjSUvB2QCIQixtkYgEhrqWcRlTS6Goo6D2Ll38/zHCrSwiiQ8GdnBwtQgqepTl5xOoMv2neox4/MUV/AanP89QkKan6me/8rKWrRo0WMnZXv2F1ZDEHibs1k3AHDehN3gr668kN+Rt8Wsi3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kh4y9W6A; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e283b2d065so7965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752697530; x=1753302330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OprCsR0r5YkOp2GbZhU68EsInxcmI2yJSoF9sWxVfA=;
        b=kh4y9W6AKqItpHSF4lEMGTWrkio6tIpBDUA/ii3M+FfKzTSBldgul4Ohv6MlDW7a+D
         SYlQwm/f4wQXgtj7zVxoiHRVjEEOE7QPVWNeRbMy2FyHzcIyWrVYjGct02iJotVgxneA
         scvMntBK8FPEi4/NqsggZQw19rEO6Bm9HT2uC0b3FbhphUha0n75GrDX4Q3JenxD9tNu
         jAq5llRYufDq9YJjJD87qOqgYq7EAPwd5ii920BhzI/lEVzumsJ9Igz+eeJ9VTznKQPy
         XTUzMZZ3mpRRQH77mw6Q5Dwnq/YaoylEiTRIEIMfXGV4fzRN8HSws78YskI9UqyPay8r
         eeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752697530; x=1753302330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OprCsR0r5YkOp2GbZhU68EsInxcmI2yJSoF9sWxVfA=;
        b=pyEegKuThKkDzaUfXLTq/1Pm6crmwu88A2Ggd8IleT+gin7BXli3/Ei5Z7Pet+qjZt
         +x3qjpsYAXtt3+EPA1O+3gZEdRmlVtTrBZdCSG6eXff63eTVrrNfTg7n9GXKjCs0xqQT
         oJOq5gCjnU3E7V/RupDM7TgmqUw7ZtZD7+gegxT8sQ6gs+ulbVYmeTCVtSWXPgNkM1Y/
         5v88ZBpa9UZIqvSvP5WJ/qYihF2AL8WOapthGydi/QP3ALvuACtArrwWDzKfF3LGjbFM
         J89aaXCT114DOnNBLMW9i1T65VD3+1UdRrBTH+0tekBngPzxbTCc8mx+KN8q3B93iMZw
         /8vA==
X-Forwarded-Encrypted: i=1; AJvYcCUbRUs4x5CwcjzZ3aCIzn4oPTyca0Udb4CDuhFcXqYmp5WQQk83o50dQpkjyMGqutigBtjOVd7tbvOfzLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUExisCceIyC5dlXlPSaFWbU+N8u14jhFyCQ8O2zU8JbANaEA3
	EHglr+aSvpLWTlenTs1pIRaN0puyQ4YdaLFd+xUiRWY6vD44Iisl+J/X4FSLP2oDSjX30plwFHP
	FUlJoj4O1w59B4griON1ZPnoL+E7wam1LUfWcDugC
X-Gm-Gg: ASbGnctN9JJqy4TtHEwaIbTn1DGjwj5cUK1wKhhg4OHO1i2eJmioCi4XYj08m8JcE7I
	actl+MF2gRfU5J/ZBb6rVREeQ4mbePo3PJQ4FIgoKO6eDEeITzDV8kUexfLUoIl9S5KJsyopoo1
	vmbxejt0OGyjPEvk5YahLbx7vNgEiEqGgppbcSr9se6L/6T15ODgI73hseCcWNXemU6oYUtpNNX
	/7cdg5d2ba5YppYCrStkXT8w7aNnZLS6w/GvTjcdpjo
X-Google-Smtp-Source: AGHT+IEH0eJvl4k8B/0SPTv/FbzPdEDeNK4Z3vnBWPURgnivIoBRlL9dUiwci7UUjYG+8XUD6bmX6Gpq3NxLzwKRNeo=
X-Received: by 2002:a05:6e02:3813:b0:3de:215d:c9bd with SMTP id
 e9e14a558f8ab-3e28caa46e0mr987685ab.20.1752697529344; Wed, 16 Jul 2025
 13:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com> <20250627192417.1157736-5-irogers@google.com>
 <aHgG-9iuoj4B72SU@google.com>
In-Reply-To: <aHgG-9iuoj4B72SU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Jul 2025 13:25:17 -0700
X-Gm-Features: Ac12FXyTzd6y6_b90XDj1o_JruSGmIwR4XIzRkBBPx7eYsVK0jSaCbYbmg7dEic
Message-ID: <CAP-5=fVt4Nu3ZtKD+DWn9iT1XRzbbzvE3WXaO51V+8UGCE56cg@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] perf parse-events: Allow the cpu term to be a PMU
To: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Blake Jones <blakejones@google.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 1:09=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Jun 27, 2025 at 12:24:09PM -0700, Ian Rogers wrote:
> > On hybrid systems, events like msr/tsc/ will aggregate counts across
> > all CPUs. Often metrics only want a value like msr/tsc/ for the cores
> > on which the metric is being computed. Listing each CPU with terms
> > cpu=3D0,cpu=3D1.. is laborious and would need to be encoded for all
> > variations of a CPU model.
> >
> > Allow the cpumask from a PMU to be an argument to the cpu term. For
> > example in the following the cpumask of the cstate_pkg PMU selects the
> > CPUs to count msr/tsc/ counter upon:
> > ```
> > $ cat /sys/bus/event_source/devices/cstate_pkg/cpumask
> > 0
> > $ perf stat -A -e 'msr/tsc,cpu=3Dcstate_pkg/' -a sleep 0.1
>
> It can be confusing if 'cpu' takes a number or a PMU name.  What about
> adding a new term (maybe 'cpu_from') to handle this case?

So it is possible for terms to be defined in sysfs in the 'format/' folder:
```
$ ls /sys/bus/event_source/devices/cpu_core/format/
cmask  edge  event  frontend  inv  ldlat  offcore_rsp  pc  umask
```
By not introducing a new term we leave 'cpu_from' open for use in this
way. When I spoke to Kan we thought using the existing term made sense
and fits the idea of leaving things open for the kernel/drivers to
use. It is possible to add a new term though. Let me know and I can
update the patch and documentation accordingly.

Thanks,
Ian

> Also please update the documentation.
>
> Thanks,
> Namhyung
>
> >
> >  Performance counter stats for 'system wide':
> >
> > CPU0          252,621,253      msr/tsc,cpu=3Dcstate_pkg/
> >
> >        0.101184092 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 37 +++++++++++++++++++++++++---------
> >  1 file changed, 28 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 7a32d5234a64..ef38eb082342 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -192,10 +192,20 @@ static struct perf_cpu_map *get_config_cpu(const =
struct parse_events_terms *head
> >
> >       list_for_each_entry(term, &head_terms->terms, list) {
> >               if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_CPU) {
> > -                     struct perf_cpu_map *cpu =3D perf_cpu_map__new_in=
t(term->val.num);
> > +                     struct perf_cpu_map *term_cpus;
> >
> > -                     perf_cpu_map__merge(&cpus, cpu);
> > -                     perf_cpu_map__put(cpu);
> > +                     if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE=
_NUM) {
> > +                             term_cpus =3D perf_cpu_map__new_int(term-=
>val.num);
> > +                     } else {
> > +                             struct perf_pmu *pmu =3D perf_pmus__find(=
term->val.str);
> > +
> > +                             if (perf_cpu_map__is_empty(pmu->cpus))
> > +                                     term_cpus =3D pmu->is_core ? cpu_=
map__online() : NULL;
> > +                             else
> > +                                     term_cpus =3D perf_cpu_map__get(p=
mu->cpus);
> > +                     }
> > +                     perf_cpu_map__merge(&cpus, term_cpus);
> > +                     perf_cpu_map__put(term_cpus);
> >               }
> >       }
> >
> > @@ -1054,12 +1064,21 @@ do {                                           =
                          \
> >               }
> >               break;
> >       case PARSE_EVENTS__TERM_TYPE_CPU:
> > -             CHECK_TYPE_VAL(NUM);
> > -             if (term->val.num >=3D (u64)cpu__max_present_cpu().cpu) {
> > -                     parse_events_error__handle(err, term->err_val,
> > -                                             strdup("too big"),
> > -                                             NULL);
> > -                     return -EINVAL;
> > +             if (term->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM) {
> > +                     if (term->val.num >=3D (u64)cpu__max_present_cpu(=
).cpu) {
> > +                             parse_events_error__handle(err, term->err=
_val,
> > +                                                     strdup("too big")=
,
> > +                                                     /*help=3D*/NULL);
> > +                             return -EINVAL;
> > +                     }
> > +             } else {
> > +                     assert(term->type_val =3D=3D PARSE_EVENTS__TERM_T=
YPE_STR);
> > +                     if (perf_pmus__find(term->val.str) =3D=3D NULL) {
> > +                             parse_events_error__handle(err, term->err=
_val,
> > +                                                     strdup("not a val=
id PMU"),
> > +                                                     /*help=3D*/NULL);
> > +                             return -EINVAL;
> > +                     }
> >               }
> >               break;
> >       case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >

