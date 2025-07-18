Return-Path: <linux-kernel+bounces-736901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E8CB0A4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAAF5189FD07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDD2DC321;
	Fri, 18 Jul 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmBHYSo2"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264711E48A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844549; cv=none; b=Vn44tm3+KWd/1s+x52JD+39xrrcl5rqJkjRE5u8OuYUhsfvCIUiZQh5dAY+wef8xIehYlkEkWybJ7tcA5DX4bd32W1lTh7YNeaTrm+6FrVSAHyoNNBnrcPaEzDjmWpcDO5vU8agHLft4SGUdtelVkUqppLk9eXER6DQG6NEcNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844549; c=relaxed/simple;
	bh=EQgZJSsuPYW3/+utyey+P+3bmI0xt/GIsG4BRMZf97s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3ZtbTQ4dd2m0DOIIVFlNK3hjSRu6H4hPDrNWqGqKS4V7qrPk7euMCNOzlkgg6p8RAONF5PZ6pOpr5jKiLj11iQPfM+FGp6Mks7C0pW9fLhAXPDZav5txNyE4cgX6AR5I4AUF2d4asJ6BnkqrOONF+t5LyQdBgg9pTJHd/sxhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmBHYSo2; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so140205ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752844545; x=1753449345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyJF6PH11rdgVbDqPxX1cVknOxLnT64boCQwaZUUGAE=;
        b=rmBHYSo204tUc+wc63ki3o+FuvS91wkxdw2NbpLMm/Z6aIVyL0ucXxT75rXWpXBmG+
         dqgyOFEmiooB2/pX+jTUBvrnHiIT0ylfVLl1Kzpw5kwfNQ/FM0RlWpF0q+WInZ5UqZ4S
         Xn30wfL9TiEDXU3GNejS8wZrxmWvLOzS2TAmJNzpaX/R8fsWkJ8+AMvMkVKYXDtQGYdH
         sQf9Xl97cQ9x1du3XD1nl2ldpFChY6sqxcjzxueU2VoAoxrXZPT+RFpKBWw1O3kEcbeo
         BKX/Xcf+8nIQU4siJ9SkK7C8YK2pJB9Jh0TOwF7CdLRw3CU5lL+sJl5tsENaEr3no1yG
         EyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752844545; x=1753449345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyJF6PH11rdgVbDqPxX1cVknOxLnT64boCQwaZUUGAE=;
        b=lbOPiwbQx9OOGs3DEyK4SJgRhmk5xvSwujPITUN7QZp6PsNSo9zeiwFftBI6YaOU/j
         qCDMRuaspeSyiFfGe0EvvJouE8TE2hUIDYswRytbXABFpbAZJsz3/jmP5RsoDV1grcYT
         HDMCMRmu8Y/zfjKEwQOh2cGs5u9OGw70wm3XPj+8vNKCvcoHoUO9jXsSxgGNHlpOoYOy
         rJb8LlyKrkc/E8D9QY8baN9+zofqXZk4TSNSGJaLOyjS78CMj615ajf58DIGLQ7fm2do
         bvAuCQsT9m3YhaBmE/gzDqNlBCqphq2ex0zxNVLIchFdOsNOtNBUFG+Wg7jU4jAWHOfK
         ADjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqiu19fEaaD6Ijb2a8D09uosQsNUgRuijVGJQ9vH6dsEq8ya1+4H+fhRH2j84R/mrwk5GcXFgzduYiX70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQhr8YOZJry2qIhSTzP49kDcpuQZxomaN+lFVKIpK1YICxymNJ
	Yl8U1k0UTWrBLxBErqUYVR/vTgXSjfeTUADal8G21hqXpAHt2McNg5VR1oEn2pF9wboA/N3arzc
	c/lEOWPbQNl2NOcJEZcKmgmmTtEhCs0KDflU+wdGJ
X-Gm-Gg: ASbGncsTFsrbAqJMoDez+u/vxXsdi7JusiMxG5+qfZbbTT0Diz/A7FO3h+3zkmW7bxj
	6irCzWr4eLZvgNSWFAQV59O5m7aXXJdWCd3kV3jKSzafnZAUztI6/4k/0XpxTT1E1k4DV1xIq3e
	pUFJxqY4djBM4+8A1iahDqQgp1QsJxpIsTNQJ8RewYVHAIajQbDT5ADGYuTrDsexaIIxtX50uJ5
	E71Y7PS
X-Google-Smtp-Source: AGHT+IGPRwZkmzj+PbT/weanyevA2gWRhQC9b4iUdLrKapIzctrpmVm5dwuwPzpVSu01Nnf8PbLlm5FW3u8qEZg1zcA=
X-Received: by 2002:a05:6e02:2192:b0:3dd:a736:6768 with SMTP id
 e9e14a558f8ab-3e295e9d7c8mr4631155ab.2.1752844544228; Fri, 18 Jul 2025
 06:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718071734.1444891-1-irogers@google.com> <11829e3e-6d43-44f9-b008-6f6b828b7144@linux.intel.com>
In-Reply-To: <11829e3e-6d43-44f9-b008-6f6b828b7144@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Jul 2025 06:15:32 -0700
X-Gm-Features: Ac12FXxNIb3bK4Uls5-zLsDRmK8r1t7ckh0sU2qOVaYJzQl770g6s6xO69A-mbs
Message-ID: <CAP-5=fVzJHm94T5c2CCPwzLzUweuQuzgppdECNoW4Ju-47m2LQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf topdown: Use attribute to see an event is a
 topdown metic or slots
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 1:51=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 7/18/2025 3:17 PM, Ian Rogers wrote:
> > The string comparisons were overly broad and could fire for the
> > incorrect PMU and events. Switch to using the config in the attribute
> > then add a perf test to confirm the attribute config values match
> > those of parsed events of that name and don't match others. This
> > exposed matches for slots events that shouldn't have matched as the
> > slots fixed counter event, such as topdown.slots_p.
> >
> > Fixes: fbc798316bef ("perf x86/topdown: Refine helper arch_is_topdown_m=
etrics()")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/include/arch-tests.h |  4 ++
> >  tools/perf/arch/x86/tests/Build          |  1 +
> >  tools/perf/arch/x86/tests/arch-tests.c   |  1 +
> >  tools/perf/arch/x86/tests/topdown.c      | 76 ++++++++++++++++++++++++
> >  tools/perf/arch/x86/util/evsel.c         | 46 ++++----------
> >  tools/perf/arch/x86/util/topdown.c       | 31 ++++------
> >  tools/perf/arch/x86/util/topdown.h       |  4 ++
> >  7 files changed, 108 insertions(+), 55 deletions(-)
> >  create mode 100644 tools/perf/arch/x86/tests/topdown.c
> >
> > diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch=
/x86/include/arch-tests.h
> > index 4fd425157d7d..8713e9122d4c 100644
> > --- a/tools/perf/arch/x86/include/arch-tests.h
> > +++ b/tools/perf/arch/x86/include/arch-tests.h
> > @@ -2,6 +2,8 @@
> >  #ifndef ARCH_TESTS_H
> >  #define ARCH_TESTS_H
> >
> > +#include "tests/tests.h"
> > +
> >  struct test_suite;
> >
> >  /* Tests */
> > @@ -17,6 +19,8 @@ int test__amd_ibs_via_core_pmu(struct test_suite *tes=
t, int subtest);
> >  int test__amd_ibs_period(struct test_suite *test, int subtest);
> >  int test__hybrid(struct test_suite *test, int subtest);
> >
> > +DECLARE_SUITE(x86_topdown);
> > +
> >  extern struct test_suite *arch_tests[];
> >
> >  #endif
> > diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/test=
s/Build
> > index 01d5527f38c7..311b6b53d3d8 100644
> > --- a/tools/perf/arch/x86/tests/Build
> > +++ b/tools/perf/arch/x86/tests/Build
> > @@ -11,6 +11,7 @@ endif
> >  perf-test-$(CONFIG_X86_64) +=3D bp-modify.o
> >  perf-test-y +=3D amd-ibs-via-core-pmu.o
> >  perf-test-y +=3D amd-ibs-period.o
> > +perf-test-y +=3D topdown.o
> >
> >  ifdef SHELLCHECK
> >    SHELL_TESTS :=3D gen-insn-x86-dat.sh
> > diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x=
86/tests/arch-tests.c
> > index bfee2432515b..29ec1861ccef 100644
> > --- a/tools/perf/arch/x86/tests/arch-tests.c
> > +++ b/tools/perf/arch/x86/tests/arch-tests.c
> > @@ -53,5 +53,6 @@ struct test_suite *arch_tests[] =3D {
> >       &suite__amd_ibs_via_core_pmu,
> >       &suite__amd_ibs_period,
> >       &suite__hybrid,
> > +     &suite__x86_topdown,
> >       NULL,
> >  };
> > diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/=
tests/topdown.c
> > new file mode 100644
> > index 000000000000..ba2c163945d8
> > --- /dev/null
> > +++ b/tools/perf/arch/x86/tests/topdown.c
> > @@ -0,0 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include "arch-tests.h"
> > +#include "../util/topdown.h"
> > +#include "evlist.h"
> > +#include "parse-events.h"
> > +#include "pmu.h"
> > +#include "pmus.h"
> > +
> > +static int event_cb(void *state, struct pmu_event_info *info)
> > +{
> > +     char buf[256];
> > +     struct parse_events_error parse_err;
> > +     int *ret =3D state, err;
> > +     struct evlist *evlist =3D evlist__new();
> > +     struct evsel *evsel;
> > +
> > +     if (!evlist)
> > +             return -ENOMEM;
> > +
> > +     parse_events_error__init(&parse_err);
> > +     snprintf(buf, sizeof(buf), "%s/%s/", info->pmu->name, info->name)=
;
> > +     err =3D parse_events(evlist, buf, &parse_err);
> > +     if (err) {
> > +             parse_events_error__print(&parse_err, buf);
> > +             *ret =3D TEST_FAIL;
> > +     }
> > +     parse_events_error__exit(&parse_err);
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             bool fail =3D false;
> > +             bool topdown_pmu =3D evsel->pmu->type =3D=3D PERF_TYPE_RA=
W;

I think this should be called p_core_pmu as e_cores can have topdown
events, we just don't need to fix their grouping. I'll send a v2 for
this.

> > +             const char *name =3D evsel__name(evsel);
> > +
> > +             if (strcasestr(name, "uops_retired.slots") ||
> > +                 strcasestr(name, "topdown.backend_bound_slots") ||
> > +                 strcasestr(name, "topdown.br_mispredict_slots") ||
> > +                 strcasestr(name, "topdown.memory_bound_slots") ||
> > +                 strcasestr(name, "topdown.bad_spec_slots") ||
> > +                 strcasestr(name, "topdown.slots_p")) {
> > +                     if (arch_is_topdown_slots(evsel) || arch_is_topdo=
wn_metrics(evsel))
> > +                             fail =3D true;
> > +             } else if (strcasestr(name, "slots")) {
> > +                     if (arch_is_topdown_slots(evsel) !=3D topdown_pmu=
 ||
> > +                         arch_is_topdown_metrics(evsel))
> > +                             fail =3D true;
> > +             } else if (strcasestr(name, "topdown")) {
> > +                     if (arch_is_topdown_slots(evsel) ||
> > +                         arch_is_topdown_metrics(evsel) !=3D topdown_p=
mu)
> > +                             fail =3D true;
> > +             } else if (arch_is_topdown_slots(evsel) || arch_is_topdow=
n_metrics(evsel)) {
> > +                     fail =3D true;
> > +             }
> > +             if (fail) {
> > +                     pr_debug("Broken topdown information for '%s'\n",=
 evsel__name(evsel));
> > +                     *ret =3D TEST_FAIL;
> > +             }
> > +     }
> > +     evlist__delete(evlist);
> > +     return 0;
> > +}
> > +
> > +static int test__x86_topdown(struct test_suite *test __maybe_unused, i=
nt subtest __maybe_unused)
> > +{
> > +     int ret =3D TEST_OK;
> > +     struct perf_pmu *pmu =3D NULL;
> > +
> > +     if (!topdown_sys_has_perf_metrics())
> > +             return TEST_OK;
> > +
> > +     while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > +             if (perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=
=3D*/false, &ret, event_cb))
> > +                     break;
> > +     }
> > +     return ret;
> > +}
> > +
> > +DEFINE_SUITE("x86 topdown", x86_topdown);
> > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/uti=
l/evsel.c
> > index 3dd29ba2c23b..9bc80fff3aa0 100644
> > --- a/tools/perf/arch/x86/util/evsel.c
> > +++ b/tools/perf/arch/x86/util/evsel.c
> > @@ -23,47 +23,25 @@ void arch_evsel__set_sample_weight(struct evsel *ev=
sel)
> >  bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
> >  {
> >       struct perf_pmu *pmu;
> > -     u32 type =3D evsel->core.attr.type;
> >
> > -     /*
> > -      * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
> > -      * on a non-hybrid machine, "cpu_core" PMU on a hybrid machine.
> > -      * The slots event is only available for the core PMU, which
> > -      * supports the perf metrics feature.
> > -      * Checking both the PERF_TYPE_RAW type and the slots event
> > -      * should be good enough to detect the perf metrics feature.
> > -      */
> > -again:
> > -     switch (type) {
> > -     case PERF_TYPE_HARDWARE:
> > -     case PERF_TYPE_HW_CACHE:
> > -             type =3D evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
> > -             if (type)
> > -                     goto again;
> > -             break;
> > -     case PERF_TYPE_RAW:
> > -             break;
> > -     default:
> > +     if (!topdown_sys_has_perf_metrics())
> >               return false;
> > -     }
> > -
> > -     pmu =3D evsel->pmu;
> > -     if (pmu && perf_pmu__is_fake(pmu))
> > -             pmu =3D NULL;
> >
> > -     if (!pmu) {
> > -             while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> > -                     if (pmu->type =3D=3D PERF_TYPE_RAW)
> > -                             break;
> > -             }
> > -     }
> > -     return pmu && perf_pmu__have_event(pmu, "slots");
> > +     /*
> > +      * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU o=
n a
> > +      * non-hybrid machine, "cpu_core" PMU on a hybrid machine.  The
> > +      * topdown_sys_has_perf_metrics checks the slots event is only av=
ailable
> > +      * for the core PMU, which supports the perf metrics feature. Che=
cking
> > +      * both the PERF_TYPE_RAW type and the slots event should be good=
 enough
> > +      * to detect the perf metrics feature.
> > +      */
> > +     pmu =3D evsel__find_pmu(evsel);
> > +     return pmu && pmu->type =3D=3D PERF_TYPE_RAW;
>
> Do I miss something? But it seems not check if the PMU has slots event he=
re.

topdown_sys_has_perf_metrics checks this and caches the result of
true/false (I also tweaked the comment to mention this).
Thinking about this I spotted the issue above.

Thanks,
Ian


>
> >  }
> >
> >  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >  {
> > -     if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
> > -         strcasestr(evsel->name, "uops_retired.slots"))
> > +     if (!evsel__sys_has_perf_metrics(evsel))
> >               return false;
> >
> >       return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(ev=
sel);
> > diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/u=
til/topdown.c
> > index d1c654839049..66b231fbf52e 100644
> > --- a/tools/perf/arch/x86/util/topdown.c
> > +++ b/tools/perf/arch/x86/util/topdown.c
> > @@ -1,6 +1,4 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include "api/fs/fs.h"
> > -#include "util/evsel.h"
> >  #include "util/evlist.h"
> >  #include "util/pmu.h"
> >  #include "util/pmus.h"
> > @@ -8,6 +6,9 @@
> >  #include "topdown.h"
> >  #include "evsel.h"
> >
> > +// cmask=3D0, inv=3D0, pc=3D0, edge=3D0, umask=3D4, event=3D0
> > +#define TOPDOWN_SLOTS                0x0400
> > +
> >  /* Check whether there is a PMU which supports the perf metrics. */
> >  bool topdown_sys_has_perf_metrics(void)
> >  {
> > @@ -32,31 +33,19 @@ bool topdown_sys_has_perf_metrics(void)
> >       return has_perf_metrics;
> >  }
> >
> > -#define TOPDOWN_SLOTS                0x0400
> >  bool arch_is_topdown_slots(const struct evsel *evsel)
> >  {
> > -     if (evsel->core.attr.config =3D=3D TOPDOWN_SLOTS)
> > -             return true;
> > -
> > -     return false;
> > +     return evsel->core.attr.type =3D=3D PERF_TYPE_RAW &&
> > +            evsel->core.attr.config =3D=3D TOPDOWN_SLOTS &&
> > +            evsel->core.attr.config1 =3D=3D 0;
> >  }
> >
> >  bool arch_is_topdown_metrics(const struct evsel *evsel)
> >  {
> > -     int config =3D evsel->core.attr.config;
> > -     const char *name_from_config;
> > -     struct perf_pmu *pmu;
> > -
> > -     /* All topdown events have an event code of 0. */
> > -     if ((config & 0xFF) !=3D 0)
> > -             return false;
> > -
> > -     pmu =3D evsel__find_pmu(evsel);
> > -     if (!pmu || !pmu->is_core)
> > -             return false;
> > -
> > -     name_from_config =3D perf_pmu__name_from_config(pmu, config);
> > -     return name_from_config && strcasestr(name_from_config, "topdown"=
);
> > +     // cmask=3D0, inv=3D0, pc=3D0, edge=3D0, umask=3D0x80-0x87, event=
=3D0
> > +     return evsel->core.attr.type =3D=3D PERF_TYPE_RAW &&
> > +             (evsel->core.attr.config & 0xFFFFF8FF) =3D=3D 0x8000 &&
> > +             evsel->core.attr.config1 =3D=3D 0;
> >  }
> >
> >  /*
> > diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/u=
til/topdown.h
> > index 1bae9b1822d7..2349536cf882 100644
> > --- a/tools/perf/arch/x86/util/topdown.h
> > +++ b/tools/perf/arch/x86/util/topdown.h
> > @@ -2,6 +2,10 @@
> >  #ifndef _TOPDOWN_H
> >  #define _TOPDOWN_H 1
> >
> > +#include <stdbool.h>
> > +
> > +struct evsel;
> > +
> >  bool topdown_sys_has_perf_metrics(void);
> >  bool arch_is_topdown_slots(const struct evsel *evsel);
> >  bool arch_is_topdown_metrics(const struct evsel *evsel);

