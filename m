Return-Path: <linux-kernel+bounces-877188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE5C1D640
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D34DE4E162E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B78312836;
	Wed, 29 Oct 2025 21:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDhBbShD"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54541315D43
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772349; cv=none; b=IAMc/EZFNx1Pk4jMjK/hi1WDq4IdONtjbR269nOBVgCTrdY6nm484mcIJX9ibfQC6Z00CLFf6swIqB91+UJJBtvnAbEO9uAhySmwwPmt7CgnpJNbAvSmOaR0NbEiiMNNw+JsefUOZks6ggvQzGVM6YFxV0rqqhPE0nGPtKZ8xyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772349; c=relaxed/simple;
	bh=nK1MxjwKYVPwg2GF7YL902YDACd5VNwdD8V5aL42bz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwyK55fbuqMtSyUh6YYN1CMHNQqKFh8wUpFC41JPOETq+sKVmck9C8KDri16oc1um1THbQoMEeWBGm9ktoHh2vbJY+9/DqZnqlP0EdSSl0AxXAiaHIwLOV6ZFnWdxirXPGwtJumN/hMlf+BZbZbc+17p7J3UURAReIId6NIq0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDhBbShD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eeafd4882so25035ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761772344; x=1762377144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqxnzXbPo4+df3L3OF/til7pllxsyeK27S94f4J93TA=;
        b=hDhBbShD0YmWRC3iTIpNWQdoQbOXGmkLYfsG4K8q84nksnKGmQpPWnQzxM2bFxY2Hc
         FmN+dOML0gjFvP74lWGElW26r/z7/G4UA2mdwwR8im1VLBI92am1v07Y3q0ASwI5jLzh
         mastUx7VQ4fyALBcDz5L/qtRduogybDf012+A2XhJ+etdqX70vpVib6gnDmCP/F9miDZ
         zlu8vLdF/o6Ai3lquJDiL3LqyVo4nTRbTBHt9jzL68uzcdxtoX2vxDdCtd8te4IPoRz/
         vW29+tDKWl9DB135SRxxV07V5wZ3u4VQLDSRjqaMUBjkqLOeTupvTiHVGWrQFf+93IMj
         LM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761772344; x=1762377144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqxnzXbPo4+df3L3OF/til7pllxsyeK27S94f4J93TA=;
        b=u0H3lFN7BnykP/5Flo8pXouBSA+NDhaSTHlXJjOKcA2Qpoi1i7qHGssoU6UsY/ib5R
         4kU2ac6JL6B3EAUEiNu5WUNuLO4iepmqBDzgMcbnq0L652YcDYE//rmjanTJphq9q9XW
         A81186QHbtc82BkCkQivT8g6z3mHf83CmBANUCFjYo5XMwzWJQiyGjwowARe24nHh//+
         06zPrS3WQcTgTGCx4gx4e2ZJ5SdnzWUL/tsEzLe8Zvk3FShxdjuoNM1+JbOFYPJjR2Pm
         SkbUrVokTgfWyl4C1VawQFcdMVnFFtQZZ4R2QNeKAPjdc9fV/UrNlWWJv3YhNy7uMOlv
         w8ww==
X-Forwarded-Encrypted: i=1; AJvYcCXnlAhmaPUi50ArbCE15XABBa0Xvj/TQDjJ7WJky6kZSGYjdxFXNM7Fy2BK+husOKKkF59zdMHzIYl/XAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRxxQx6kxST4Zt7ys+oF/W95VF33cIHCw9ELnDIA4xJFu/uezv
	pgkt5GPq+DeKDOEJ2ZOlDqx/c3m7iQCt0f0/ssVm3Cz7s2JtB7HtLgSc2aWBDMez20DJfBwziUK
	ISCcPc4kc1ERbXaL1u1c0CPtPSacI0MvFi34CJtbk
X-Gm-Gg: ASbGncvjLexziwqfxIWTGIZqNFRVfq3umVNhlSdwIdhUFvc5oOd3aeSHsEAneT+9oA1
	4YT6UXMq6AlAgjtRJLHs+sQzqxMVD7oRMNvgcCKQgvcUyqZ+U6/i6r2J7sZMeczz2ksk+524iPp
	xbAiIP/4o/X3rUEVLLkwK4+lyn8ztiVt+Wke3P77ke9POCrkeAJlBljqFK6YUihLTSbsj+n5pZW
	wQCp/+WKcR0dRx2ywOsePHRQOfjUBNWIDPkG/gSY9ysphc/hdRJhpBX/DWmEODN8SdNPrxONV7S
	eAvkfhAZMwn+n9fY26r7LxNbWQ==
X-Google-Smtp-Source: AGHT+IH3JVVjLgBZiL4UJC5w5KSpkIYafcZBAP53ZzIvNVuzMAfkUeDWfhj5LzCnJayuccvZmI2qYfZF5jPzDHnUreg=
X-Received: by 2002:a17:902:c950:b0:274:506d:7fea with SMTP id
 d9443c01a7336-294ef888c75mr439715ad.5.1761772342628; Wed, 29 Oct 2025
 14:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029053413.355154-1-irogers@google.com> <20251029053413.355154-13-irogers@google.com>
 <aQI_OJziRPMRqzM9@x1> <CAP-5=fXz+tG-6q54FNY2OrKcz4zjncRXEWzV8E2suXmOA4MzEw@mail.gmail.com>
 <aQJeEFKHUfevLB50@x1>
In-Reply-To: <aQJeEFKHUfevLB50@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 14:12:11 -0700
X-Gm-Features: AWmQ_blc7P4RGTz5LlXE5FmiMUZYedh_a0LfTWqZMnLd833iBQJ67_oAKtLCmqY
Message-ID: <CAP-5=fX=oDBeJ4aLW4ARB3x_=UJ7zSYQWjJf28E2jgTc_rxJyg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 12/15] perf evlist: Add reference count
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Song Liu <song@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:33=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 29, 2025 at 09:56:50AM -0700, Ian Rogers wrote:
> > On Wed, Oct 29, 2025 at 9:22=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Tue, Oct 28, 2025 at 10:34:10PM -0700, Ian Rogers wrote:
> > > > This a no-op for most of the perf tool. The reference count is set =
to
> > > > 1 at allocation, the put will see the 1, decrement it and perform t=
he
> > > > delete. The purpose for adding the reference count is for the pytho=
n
> > > > code. Prior to this change the python code would clone evlists, but
> > > > this has issues if events are opened, etc. This change adds a
> > > > reference count for the evlists and a later change will add it to
> > > > evsels. The combination is needed for the python code to operate
> > > > correctly (not hit asserts in the evsel clone), but the changes are
> > > > broken apart for the sake of smaller patches.
> > >
> > > Looks ok, noisy for all the s/delete/put/ but that is ok, but then yo=
u
> > > are not using the RC_CHK_ACCESS stuff from the get go, why not?
> >
> > So if I did RC_CHK_ACCESS then every evsel access would need updating,
>
> Fair enough, I think it would be informative to have a comment
> mentioning this near the refcount_t to avoid this question popping up
> again.

Sgtm. I think we can also add the RC_CHK_ACCESS to evlist as that is a
boring blob of a thing to pass around.

How are things outside of this? The python changes, how to do the
process_events callbacks, etc. Any thoughts on the tool API vs the
script API (stat vs stat_round) ?

Thanks,
Ian

> - Arnaldo
>
> > accessor functions, and a lot of lines of code. As the reference count
> > checking doesn't work with invasive lists, you need to interpose prev
> > and next, I think we'd need to specially handle the case probably with
> > an extra variable in evsel for reference count checking like:
> > ```
> > RC_STRUCT(evsel) {
> > ...
> >    struct evsel *evlist_ptr;
> > ...
> > }
> > ```
> > and things like evlist__for_each_entry need changes like:
> > ```
> > #define evlist__for_each_entry(evlist, evsel) \
> >        __evlist__for_each_entry(&(evlist)->core.entries, orig_evsel) {
> >            evsel =3D orig_evsel->evlist_ptr
> > ```
> > but it may be simpler to change evlist to use an array of evsel* as
> > was done in places like `struct maps`.
> >
> > Anyway, those changes I think would have taken away from what the
> > series was trying to do and so weren't done here.
> >
> > Thanks,
> > Ian
> >
> > > All the prep patches looks ok, assuming they build in succession.
> > >
> > > - Arnaldo
> > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/arch/x86/tests/hybrid.c          |   2 +-
> > > >  tools/perf/arch/x86/tests/topdown.c         |   2 +-
> > > >  tools/perf/arch/x86/util/iostat.c           |   2 +-
> > > >  tools/perf/bench/evlist-open-close.c        |  18 +-
> > > >  tools/perf/builtin-ftrace.c                 |   8 +-
> > > >  tools/perf/builtin-kvm.c                    |   4 +-
> > > >  tools/perf/builtin-lock.c                   |   2 +-
> > > >  tools/perf/builtin-record.c                 |   4 +-
> > > >  tools/perf/builtin-stat.c                   |   8 +-
> > > >  tools/perf/builtin-top.c                    |  52 +++---
> > > >  tools/perf/builtin-trace.c                  |  26 +--
> > > >  tools/perf/tests/backward-ring-buffer.c     |  18 +-
> > > >  tools/perf/tests/code-reading.c             |   4 +-
> > > >  tools/perf/tests/event-times.c              |   4 +-
> > > >  tools/perf/tests/event_update.c             |   2 +-
> > > >  tools/perf/tests/evsel-roundtrip-name.c     |   8 +-
> > > >  tools/perf/tests/expand-cgroup.c            |   8 +-
> > > >  tools/perf/tests/hists_cumulate.c           |   2 +-
> > > >  tools/perf/tests/hists_filter.c             |   2 +-
> > > >  tools/perf/tests/hists_link.c               |   2 +-
> > > >  tools/perf/tests/hists_output.c             |   2 +-
> > > >  tools/perf/tests/hwmon_pmu.c                |   2 +-
> > > >  tools/perf/tests/keep-tracking.c            |   2 +-
> > > >  tools/perf/tests/mmap-basic.c               |  18 +-
> > > >  tools/perf/tests/openat-syscall-tp-fields.c |  18 +-
> > > >  tools/perf/tests/parse-events.c             |   4 +-
> > > >  tools/perf/tests/parse-metric.c             |   4 +-
> > > >  tools/perf/tests/parse-no-sample-id-all.c   |   2 +-
> > > >  tools/perf/tests/perf-record.c              |  18 +-
> > > >  tools/perf/tests/perf-time-to-tsc.c         |   2 +-
> > > >  tools/perf/tests/pfm.c                      |   4 +-
> > > >  tools/perf/tests/pmu-events.c               |   6 +-
> > > >  tools/perf/tests/pmu.c                      |   2 +-
> > > >  tools/perf/tests/sw-clock.c                 |  14 +-
> > > >  tools/perf/tests/switch-tracking.c          |   2 +-
> > > >  tools/perf/tests/task-exit.c                |  14 +-
> > > >  tools/perf/tests/tool_pmu.c                 |   2 +-
> > > >  tools/perf/tests/topology.c                 |   2 +-
> > > >  tools/perf/util/cgroup.c                    |   4 +-
> > > >  tools/perf/util/data-convert-bt.c           |   2 +-
> > > >  tools/perf/util/evlist.c                    |  20 ++-
> > > >  tools/perf/util/evlist.h                    |   7 +-
> > > >  tools/perf/util/expr.c                      |   2 +-
> > > >  tools/perf/util/header.c                    |  12 +-
> > > >  tools/perf/util/metricgroup.c               |   6 +-
> > > >  tools/perf/util/parse-events.c              |   4 +-
> > > >  tools/perf/util/perf_api_probe.c            |   2 +-
> > > >  tools/perf/util/python.c                    | 176 +++++++---------=
----
> > > >  tools/perf/util/record.c                    |   2 +-
> > > >  tools/perf/util/session.c                   |   2 +-
> > > >  tools/perf/util/sideband_evlist.c           |  16 +-
> > > >  51 files changed, 252 insertions(+), 299 deletions(-)
> > > >
> > > > diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x=
86/tests/hybrid.c
> > > > index e221ea104174..dfb0ffc0d030 100644
> > > > --- a/tools/perf/arch/x86/tests/hybrid.c
> > > > +++ b/tools/perf/arch/x86/tests/hybrid.c
> > > > @@ -268,7 +268,7 @@ static int test_event(const struct evlist_test =
*e)
> > > >               ret =3D e->check(evlist);
> > > >       }
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >
> > > >       return ret;
> > > >  }
> > > > diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/=
x86/tests/topdown.c
> > > > index 1eba3b4594ef..b31aef4ef28b 100644
> > > > --- a/tools/perf/arch/x86/tests/topdown.c
> > > > +++ b/tools/perf/arch/x86/tests/topdown.c
> > > > @@ -55,7 +55,7 @@ static int event_cb(void *state, struct pmu_event=
_info *info)
> > > >                       *ret =3D TEST_FAIL;
> > > >               }
> > > >       }
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return 0;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x8=
6/util/iostat.c
> > > > index 7442a2cd87ed..e0417552b0cb 100644
> > > > --- a/tools/perf/arch/x86/util/iostat.c
> > > > +++ b/tools/perf/arch/x86/util/iostat.c
> > > > @@ -337,7 +337,7 @@ int iostat_prepare(struct evlist *evlist, struc=
t perf_stat_config *config)
> > > >       if (evlist->core.nr_entries > 0) {
> > > >               pr_warning("The -e and -M options are not supported."
> > > >                          "All chosen events/metrics will be dropped=
\n");
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               evlist =3D evlist__new();
> > > >               if (!evlist)
> > > >                       return -ENOMEM;
> > > > diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/benc=
h/evlist-open-close.c
> > > > index bfaf50e4e519..a802fb005ee3 100644
> > > > --- a/tools/perf/bench/evlist-open-close.c
> > > > +++ b/tools/perf/bench/evlist-open-close.c
> > > > @@ -75,7 +75,7 @@ static struct evlist *bench__create_evlist(char *=
evstr, const char *uid_str)
> > > >               parse_events_error__exit(&err);
> > > >               pr_err("Run 'perf list' for a list of valid events\n"=
);
> > > >               ret =3D 1;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >       parse_events_error__exit(&err);
> > > >       if (uid_str) {
> > > > @@ -84,24 +84,24 @@ static struct evlist *bench__create_evlist(char=
 *evstr, const char *uid_str)
> > > >               if (uid =3D=3D UINT_MAX) {
> > > >                       pr_err("Invalid User: %s", uid_str);
> > > >                       ret =3D -EINVAL;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >               ret =3D parse_uid_filter(evlist, uid);
> > > >               if (ret)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >       }
> > > >       ret =3D evlist__create_maps(evlist, &opts.target);
> > > >       if (ret < 0) {
> > > >               pr_err("Not enough memory to create thread/cpu maps\n=
");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__config(evlist, &opts, NULL);
> > > >
> > > >       return evlist;
> > > >
> > > > -out_delete_evlist:
> > > > -     evlist__delete(evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(evlist);
> > > >       return NULL;
> > > >  }
> > > >
> > > > @@ -150,7 +150,7 @@ static int bench_evlist_open_close__run(char *e=
vstr, const char *uid_str)
> > > >               evlist->core.nr_entries, evlist__count_evsel_fds(evli=
st));
> > > >       printf("  Number of iterations:\t%d\n", iterations);
> > > >
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >
> > > >       for (i =3D 0; i < iterations; i++) {
> > > >               pr_debug("Started iteration %d\n", i);
> > > > @@ -161,7 +161,7 @@ static int bench_evlist_open_close__run(char *e=
vstr, const char *uid_str)
> > > >               gettimeofday(&start, NULL);
> > > >               err =3D bench__do_evlist_open_close(evlist);
> > > >               if (err) {
> > > > -                     evlist__delete(evlist);
> > > > +                     evlist__put(evlist);
> > > >                       return err;
> > > >               }
> > > >
> > > > @@ -170,7 +170,7 @@ static int bench_evlist_open_close__run(char *e=
vstr, const char *uid_str)
> > > >               runtime_us =3D timeval2usec(&diff);
> > > >               update_stats(&time_stats, runtime_us);
> > > >
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               pr_debug("Iteration %d took:\t%" PRIu64 "us\n", i, ru=
ntime_us);
> > > >       }
> > > >
> > > > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrac=
e.c
> > > > index 6b6eec65f93f..4a2fe05e9786 100644
> > > > --- a/tools/perf/builtin-ftrace.c
> > > > +++ b/tools/perf/builtin-ftrace.c
> > > > @@ -1993,20 +1993,20 @@ int cmd_ftrace(int argc, const char **argv)
> > > >
> > > >       ret =3D evlist__create_maps(ftrace.evlist, &ftrace.target);
> > > >       if (ret < 0)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       if (argc) {
> > > >               ret =3D evlist__prepare_workload(ftrace.evlist, &ftra=
ce.target,
> > > >                                              argv, false,
> > > >                                              ftrace__workload_exec_=
failed_signal);
> > > >               if (ret < 0)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >       }
> > > >
> > > >       ret =3D cmd_func(&ftrace);
> > > >
> > > > -out_delete_evlist:
> > > > -     evlist__delete(ftrace.evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(ftrace.evlist);
> > > >
> > > >  out_delete_filters:
> > > >       delete_filter_func(&ftrace.filters);
> > > > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > > > index f0f285763f19..b07cbe051e33 100644
> > > > --- a/tools/perf/builtin-kvm.c
> > > > +++ b/tools/perf/builtin-kvm.c
> > > > @@ -1806,7 +1806,7 @@ static struct evlist *kvm_live_event_list(voi=
d)
> > > >
> > > >  out:
> > > >       if (err) {
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               evlist =3D NULL;
> > > >       }
> > > >
> > > > @@ -1937,7 +1937,7 @@ static int kvm_events_live(struct perf_kvm_st=
at *kvm,
> > > >  out:
> > > >       perf_session__delete(kvm->session);
> > > >       kvm->session =3D NULL;
> > > > -     evlist__delete(kvm->evlist);
> > > > +     evlist__put(kvm->evlist);
> > > >
> > > >       return err;
> > > >  }
> > > > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > > > index 078634461df2..2a57767f03a9 100644
> > > > --- a/tools/perf/builtin-lock.c
> > > > +++ b/tools/perf/builtin-lock.c
> > > > @@ -2143,7 +2143,7 @@ static int __cmd_contention(int argc, const c=
har **argv)
> > > >
> > > >  out_delete:
> > > >       lock_filter_finish();
> > > > -     evlist__delete(con.evlist);
> > > > +     evlist__put(con.evlist);
> > > >       lock_contention_finish(&con);
> > > >       perf_session__delete(session);
> > > >       perf_env__exit(&host_env);
> > > > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-recor=
d.c
> > > > index 3d8cf4090a92..738dbae80eac 100644
> > > > --- a/tools/perf/builtin-record.c
> > > > +++ b/tools/perf/builtin-record.c
> > > > @@ -4349,7 +4349,7 @@ int cmd_record(int argc, const char **argv)
> > > >                       goto out;
> > > >
> > > >               evlist__splice_list_tail(rec->evlist, &def_evlist->co=
re.entries);
> > > > -             evlist__delete(def_evlist);
> > > > +             evlist__put(def_evlist);
> > > >       }
> > > >
> > > >       if (rec->opts.target.tid && !rec->opts.no_inherit_set)
> > > > @@ -4460,7 +4460,7 @@ int cmd_record(int argc, const char **argv)
> > > >       auxtrace_record__free(rec->itr);
> > > >  out_opts:
> > > >       evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack,=
 &rec->opts.ctl_fd_close);
> > > > -     evlist__delete(rec->evlist);
> > > > +     evlist__put(rec->evlist);
> > > >       return err;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 886727ae8529..282926c6abd4 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -2067,7 +2067,7 @@ static int add_default_events(void)
> > > >                       metricgroup__copy_metric_events(evlist, /*cgr=
p=3D*/NULL,
> > > >                                                       &evlist->metr=
ic_events,
> > > >                                                       &metric_evlis=
t->metric_events);
> > > > -                     evlist__delete(metric_evlist);
> > > > +                     evlist__put(metric_evlist);
> > > >               }
> > > >       }
> > > >
> > > > @@ -2142,7 +2142,7 @@ static int add_default_events(void)
> > > >       metricgroup__copy_metric_events(evsel_list, /*cgrp=3D*/NULL,
> > > >                                       &evsel_list->metric_events,
> > > >                                       &evlist->metric_events);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -2373,7 +2373,7 @@ static int __cmd_report(int argc, const char =
**argv)
> > > >
> > > >       perf_stat.session  =3D session;
> > > >       stat_config.output =3D stderr;
> > > > -     evlist__delete(evsel_list);
> > > > +     evlist__put(evsel_list);
> > > >       evsel_list         =3D session->evlist;
> > > >
> > > >       ret =3D perf_session__process_events(session);
> > > > @@ -3042,7 +3042,7 @@ int cmd_stat(int argc, const char **argv)
> > > >       if (smi_cost && smi_reset)
> > > >               sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
> > > >
> > > > -     evlist__delete(evsel_list);
> > > > +     evlist__put(evsel_list);
> > > >
> > > >       evlist__close_control(stat_config.ctl_fd, stat_config.ctl_fd_=
ack, &stat_config.ctl_fd_close);
> > > >
> > > > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> > > > index 710604c4f6f6..45d5dae54dcd 100644
> > > > --- a/tools/perf/builtin-top.c
> > > > +++ b/tools/perf/builtin-top.c
> > > > @@ -1641,14 +1641,14 @@ int cmd_top(int argc, const char **argv)
> > > >       perf_env__init(&host_env);
> > > >       status =3D perf_config(perf_top_config, &top);
> > > >       if (status)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       /*
> > > >        * Since the per arch annotation init routine may need the cp=
uid, read
> > > >        * it here, since we are not getting this from the perf.data =
header.
> > > >        */
> > > >       status =3D perf_env__set_cmdline(&host_env, argc, argv);
> > > >       if (status)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       status =3D perf_env__read_cpuid(&host_env);
> > > >       if (status) {
> > > > @@ -1669,44 +1669,44 @@ int cmd_top(int argc, const char **argv)
> > > >               annotate_opts.disassembler_style =3D strdup(disassemb=
ler_style);
> > > >               if (!annotate_opts.disassembler_style) {
> > > >                       status =3D -ENOMEM;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >       if (objdump_path) {
> > > >               annotate_opts.objdump_path =3D strdup(objdump_path);
> > > >               if (!annotate_opts.objdump_path) {
> > > >                       status =3D -ENOMEM;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >       if (addr2line_path) {
> > > >               symbol_conf.addr2line_path =3D strdup(addr2line_path)=
;
> > > >               if (!symbol_conf.addr2line_path) {
> > > >                       status =3D -ENOMEM;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >
> > > >       status =3D symbol__validate_sym_arguments();
> > > >       if (status)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       if (annotate_check_args() < 0)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       if (!top.evlist->core.nr_entries) {
> > > >               struct evlist *def_evlist =3D evlist__new_default();
> > > >
> > > >               if (!def_evlist)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >
> > > >               evlist__splice_list_tail(top.evlist, &def_evlist->cor=
e.entries);
> > > > -             evlist__delete(def_evlist);
> > > > +             evlist__put(def_evlist);
> > > >       }
> > > >
> > > >       status =3D evswitch__init(&top.evswitch, top.evlist, stderr);
> > > >       if (status)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       if (symbol_conf.report_hierarchy) {
> > > >               /* disable incompatible options */
> > > > @@ -1717,18 +1717,18 @@ int cmd_top(int argc, const char **argv)
> > > >                       pr_err("Error: --hierarchy and --fields optio=
ns cannot be used together\n");
> > > >                       parse_options_usage(top_usage, options, "fiel=
ds", 0);
> > > >                       parse_options_usage(NULL, options, "hierarchy=
", 0);
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >
> > > >       if (top.stitch_lbr && !(callchain_param.record_mode =3D=3D CA=
LLCHAIN_LBR)) {
> > > >               pr_err("Error: --stitch-lbr must be used with --call-=
graph lbr\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (nr_cgroups > 0 && opts->record_cgroup) {
> > > >               pr_err("--cgroup and --all-cgroups cannot be used tog=
ether\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (branch_call_mode) {
> > > > @@ -1752,7 +1752,7 @@ int cmd_top(int argc, const char **argv)
> > > >               status =3D perf_env__read_core_pmu_caps(&host_env);
> > > >               if (status) {
> > > >                       pr_err("PMU capability data is not available\=
n");
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >
> > > > @@ -1775,7 +1775,7 @@ int cmd_top(int argc, const char **argv)
> > > >       if (IS_ERR(top.session)) {
> > > >               status =3D PTR_ERR(top.session);
> > > >               top.session =3D NULL;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >       top.evlist->session =3D top.session;
> > > >
> > > > @@ -1785,7 +1785,7 @@ int cmd_top(int argc, const char **argv)
> > > >               if (field_order)
> > > >                       parse_options_usage(sort_order ? NULL : top_u=
sage,
> > > >                                           options, "fields", 0);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       status =3D target__validate(target);
> > > > @@ -1800,11 +1800,11 @@ int cmd_top(int argc, const char **argv)
> > > >               if (uid =3D=3D UINT_MAX) {
> > > >                       ui__error("Invalid User: %s", top.uid_str);
> > > >                       status =3D -EINVAL;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >               status =3D parse_uid_filter(top.evlist, uid);
> > > >               if (status)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (target__none(target))
> > > > @@ -1814,7 +1814,7 @@ int cmd_top(int argc, const char **argv)
> > > >               ui__error("Couldn't create thread/CPU maps: %s\n",
> > > >                         errno =3D=3D ENOENT ? "No such process" : s=
tr_error_r(errno, errbuf, sizeof(errbuf)));
> > > >               status =3D -errno;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (top.delay_secs < 1)
> > > > @@ -1822,7 +1822,7 @@ int cmd_top(int argc, const char **argv)
> > > >
> > > >       if (record_opts__config(opts)) {
> > > >               status =3D -EINVAL;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       top.sym_evsel =3D evlist__first(top.evlist);
> > > > @@ -1837,14 +1837,14 @@ int cmd_top(int argc, const char **argv)
> > > >
> > > >       status =3D symbol__annotation_init();
> > > >       if (status < 0)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       annotation_config__init();
> > > >
> > > >       symbol_conf.try_vmlinux_path =3D (symbol_conf.vmlinux_name =
=3D=3D NULL);
> > > >       status =3D symbol__init(NULL);
> > > >       if (status < 0)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       sort__setup_elide(stdout);
> > > >
> > > > @@ -1864,13 +1864,13 @@ int cmd_top(int argc, const char **argv)
> > > >               if (top.sb_evlist =3D=3D NULL) {
> > > >                       pr_err("Couldn't create side band evlist.\n."=
);
> > > >                       status =3D -EINVAL;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               if (evlist__add_bpf_sb_event(top.sb_evlist, &host_env=
)) {
> > > >                       pr_err("Couldn't ask for PERF_RECORD_BPF_EVEN=
T side band events.\n.");
> > > >                       status =3D -EINVAL;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >  #endif
> > > > @@ -1885,8 +1885,8 @@ int cmd_top(int argc, const char **argv)
> > > >       if (!opts->no_bpf_event)
> > > >               evlist__stop_sb_thread(top.sb_evlist);
> > > >
> > > > -out_delete_evlist:
> > > > -     evlist__delete(top.evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(top.evlist);
> > > >       perf_session__delete(top.session);
> > > >       annotation_options__exit();
> > > >       perf_env__exit(&host_env);
> > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.=
c
> > > > index a743bda294bd..c056df42a78f 100644
> > > > --- a/tools/perf/builtin-trace.c
> > > > +++ b/tools/perf/builtin-trace.c
> > > > @@ -4364,7 +4364,7 @@ static int trace__run(struct trace *trace, in=
t argc, const char **argv)
> > > >
> > > >       if (trace->summary_bpf) {
> > > >               if (trace_prepare_bpf_summary(trace->summary_mode) < =
0)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >
> > > >               if (trace->summary_only)
> > > >                       goto create_maps;
> > > > @@ -4432,19 +4432,19 @@ static int trace__run(struct trace *trace, =
int argc, const char **argv)
> > > >       err =3D evlist__create_maps(evlist, &trace->opts.target);
> > > >       if (err < 0) {
> > > >               fprintf(trace->output, "Problems parsing the target t=
o trace, check your options!\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       err =3D trace__symbols_init(trace, argc, argv, evlist);
> > > >       if (err < 0) {
> > > >               fprintf(trace->output, "Problems initializing symbol =
libraries!\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (trace->summary_mode =3D=3D SUMMARY__BY_TOTAL && !trace->s=
ummary_bpf) {
> > > >               trace->syscall_stats =3D alloc_syscall_stats();
> > > >               if (IS_ERR(trace->syscall_stats))
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__config(evlist, &trace->opts, &callchain_param);
> > > > @@ -4453,7 +4453,7 @@ static int trace__run(struct trace *trace, in=
t argc, const char **argv)
> > > >               err =3D evlist__prepare_workload(evlist, &trace->opts=
.target, argv, false, NULL);
> > > >               if (err < 0) {
> > > >                       fprintf(trace->output, "Couldn't run the work=
load!\n");
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >               workload_pid =3D evlist->workload.pid;
> > > >       }
> > > > @@ -4501,7 +4501,7 @@ static int trace__run(struct trace *trace, in=
t argc, const char **argv)
> > > >
> > > >       err =3D trace__expand_filters(trace, &evsel);
> > > >       if (err)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       err =3D evlist__apply_filters(evlist, &evsel, &trace->opts.ta=
rget);
> > > >       if (err < 0)
> > > >               goto out_error_apply_filters;
> > > > @@ -4618,12 +4618,12 @@ static int trace__run(struct trace *trace, =
int argc, const char **argv)
> > > >               }
> > > >       }
> > > >
> > > > -out_delete_evlist:
> > > > +out_put_evlist:
> > > >       trace_cleanup_bpf_summary();
> > > >       delete_syscall_stats(trace->syscall_stats);
> > > >       trace__symbols__exit(trace);
> > > >       evlist__free_syscall_tp_fields(evlist);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       cgroup__put(trace->cgroup);
> > > >       trace->evlist =3D NULL;
> > > >       trace->live =3D false;
> > > > @@ -4648,22 +4648,22 @@ static int trace__run(struct trace *trace, =
int argc, const char **argv)
> > > >
> > > >  out_error:
> > > >       fprintf(trace->output, "%s\n", errbuf);
> > > > -     goto out_delete_evlist;
> > > > +     goto out_put_evlist;
> > > >
> > > >  out_error_apply_filters:
> > > >       fprintf(trace->output,
> > > >               "Failed to set filter \"%s\" on event %s with %d (%s)=
\n",
> > > >               evsel->filter, evsel__name(evsel), errno,
> > > >               str_error_r(errno, errbuf, sizeof(errbuf)));
> > > > -     goto out_delete_evlist;
> > > > +     goto out_put_evlist;
> > > >  }
> > > >  out_error_mem:
> > > >       fprintf(trace->output, "Not enough memory to run!\n");
> > > > -     goto out_delete_evlist;
> > > > +     goto out_put_evlist;
> > > >
> > > >  out_errno:
> > > >       fprintf(trace->output, "errno=3D%d,%s\n", errno, strerror(err=
no));
> > > > -     goto out_delete_evlist;
> > > > +     goto out_put_evlist;
> > > >  }
> > > >
> > > >  static int trace__replay(struct trace *trace)
> > > > @@ -5331,7 +5331,7 @@ static void trace__exit(struct trace *trace)
> > > >               zfree(&trace->syscalls.table);
> > > >       }
> > > >       zfree(&trace->perfconfig_events);
> > > > -     evlist__delete(trace->evlist);
> > > > +     evlist__put(trace->evlist);
> > > >       trace->evlist =3D NULL;
> > > >       ordered_events__free(&trace->oe.data);
> > > >  #ifdef HAVE_LIBBPF_SUPPORT
> > > > diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/t=
ests/backward-ring-buffer.c
> > > > index c5e7999f2817..2b49b002d749 100644
> > > > --- a/tools/perf/tests/backward-ring-buffer.c
> > > > +++ b/tools/perf/tests/backward-ring-buffer.c
> > > > @@ -111,7 +111,7 @@ static int test__backward_ring_buffer(struct te=
st_suite *test __maybe_unused, in
> > > >       err =3D evlist__create_maps(evlist, &opts.target);
> > > >       if (err < 0) {
> > > >               pr_debug("Not enough memory to create thread/cpu maps=
\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       parse_events_error__init(&parse_error);
> > > > @@ -124,7 +124,7 @@ static int test__backward_ring_buffer(struct te=
st_suite *test __maybe_unused, in
> > > >       if (err) {
> > > >               pr_debug("Failed to parse tracepoint event, try use r=
oot\n");
> > > >               ret =3D TEST_SKIP;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__config(evlist, &opts, NULL);
> > > > @@ -133,19 +133,19 @@ static int test__backward_ring_buffer(struct =
test_suite *test __maybe_unused, in
> > > >       if (err < 0) {
> > > >               pr_debug("perf_evlist__open: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       ret =3D TEST_FAIL;
> > > >       err =3D do_test(evlist, opts.mmap_pages, &sample_count,
> > > >                     &comm_count);
> > > >       if (err !=3D TEST_OK)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       if ((sample_count !=3D NR_ITERS) || (comm_count !=3D NR_ITERS=
)) {
> > > >               pr_err("Unexpected counter: sample_count=3D%d, comm_c=
ount=3D%d\n",
> > > >                      sample_count, comm_count);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__close(evlist);
> > > > @@ -154,16 +154,16 @@ static int test__backward_ring_buffer(struct =
test_suite *test __maybe_unused, in
> > > >       if (err < 0) {
> > > >               pr_debug("perf_evlist__open: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       err =3D do_test(evlist, 1, &sample_count, &comm_count);
> > > >       if (err !=3D TEST_OK)
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       ret =3D TEST_OK;
> > > > -out_delete_evlist:
> > > > -     evlist__delete(evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/cod=
e-reading.c
> > > > index 5927d1ea20e2..8da8951154d8 100644
> > > > --- a/tools/perf/tests/code-reading.c
> > > > +++ b/tools/perf/tests/code-reading.c
> > > > @@ -806,7 +806,7 @@ static int do_test_code_reading(bool try_kcore)
> > > >                       }
> > > >
> > > >                       perf_evlist__set_maps(&evlist->core, NULL, NU=
LL);
> > > > -                     evlist__delete(evlist);
> > > > +                     evlist__put(evlist);
> > > >                       evlist =3D NULL;
> > > >                       continue;
> > > >               }
> > > > @@ -843,7 +843,7 @@ static int do_test_code_reading(bool try_kcore)
> > > >  out_put:
> > > >       thread__put(thread);
> > > >  out_err:
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       perf_cpu_map__put(cpus);
> > > >       perf_thread_map__put(threads);
> > > >       machine__delete(machine);
> > > > diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/even=
t-times.c
> > > > index ae3b98bb42cf..94ab54ecd3f9 100644
> > > > --- a/tools/perf/tests/event-times.c
> > > > +++ b/tools/perf/tests/event-times.c
> > > > @@ -186,7 +186,7 @@ static int test_times(int (attach)(struct evlis=
t *),
> > > >       err =3D attach(evlist);
> > > >       if (err =3D=3D TEST_SKIP) {
> > > >               pr_debug("  SKIP  : not enough rights\n");
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               return err;
> > > >       }
> > > >
> > > > @@ -205,7 +205,7 @@ static int test_times(int (attach)(struct evlis=
t *),
> > > >                count.ena, count.run);
> > > >
> > > >  out_err:
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return !err ? TEST_OK : TEST_FAIL;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/eve=
nt_update.c
> > > > index cb9e6de2e033..8de66dac52b0 100644
> > > > --- a/tools/perf/tests/event_update.c
> > > > +++ b/tools/perf/tests/event_update.c
> > > > @@ -115,7 +115,7 @@ static int test__event_update(struct test_suite=
 *test __maybe_unused, int subtes
> > > >       TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> > > >                       !perf_event__synthesize_event_update_cpus(&tm=
p.tool, evsel, process_event_cpus));
> > > >
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return 0;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/t=
ests/evsel-roundtrip-name.c
> > > > index 1922cac13a24..6a220634c52f 100644
> > > > --- a/tools/perf/tests/evsel-roundtrip-name.c
> > > > +++ b/tools/perf/tests/evsel-roundtrip-name.c
> > > > @@ -33,7 +33,7 @@ static int perf_evsel__roundtrip_cache_name_test(=
void)
> > > >                               if (err) {
> > > >                                       pr_debug("Failure to parse ca=
che event '%s' possibly as PMUs don't support it",
> > > >                                               name);
> > > > -                                     evlist__delete(evlist);
> > > > +                                     evlist__put(evlist);
> > > >                                       continue;
> > > >                               }
> > > >                               evlist__for_each_entry(evlist, evsel)=
 {
> > > > @@ -42,7 +42,7 @@ static int perf_evsel__roundtrip_cache_name_test(=
void)
> > > >                                               ret =3D TEST_FAIL;
> > > >                                       }
> > > >                               }
> > > > -                             evlist__delete(evlist);
> > > > +                             evlist__put(evlist);
> > > >                       }
> > > >               }
> > > >       }
> > > > @@ -66,7 +66,7 @@ static int perf_evsel__name_array_test(const char=
 *const names[], int nr_names)
> > > >               if (err) {
> > > >                       pr_debug("failed to parse event '%s', err %d\=
n",
> > > >                                names[i], err);
> > > > -                     evlist__delete(evlist);
> > > > +                     evlist__put(evlist);
> > > >                       ret =3D TEST_FAIL;
> > > >                       continue;
> > > >               }
> > > > @@ -76,7 +76,7 @@ static int perf_evsel__name_array_test(const char=
 *const names[], int nr_names)
> > > >                               ret =3D TEST_FAIL;
> > > >                       }
> > > >               }
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >       }
> > > >       return ret;
> > > >  }
> > > > diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/ex=
pand-cgroup.c
> > > > index c7b32a220ca1..9060b085e3de 100644
> > > > --- a/tools/perf/tests/expand-cgroup.c
> > > > +++ b/tools/perf/tests/expand-cgroup.c
> > > > @@ -104,7 +104,7 @@ static int expand_default_events(void)
> > > >       TEST_ASSERT_VAL("failed to get evlist", evlist);
> > > >
> > > >       ret =3D test_expand_events(evlist);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -131,7 +131,7 @@ static int expand_group_events(void)
> > > >       ret =3D test_expand_events(evlist);
> > > >  out:
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -162,7 +162,7 @@ static int expand_libpfm_events(void)
> > > >
> > > >       ret =3D test_expand_events(evlist);
> > > >  out:
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -186,7 +186,7 @@ static int expand_metric_events(void)
> > > >       ret =3D test_expand_events(evlist);
> > > >
> > > >  out:
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/h=
ists_cumulate.c
> > > > index 3eb9ef8d7ec6..8f7cce7b5085 100644
> > > > --- a/tools/perf/tests/hists_cumulate.c
> > > > +++ b/tools/perf/tests/hists_cumulate.c
> > > > @@ -744,7 +744,7 @@ static int test__hists_cumulate(struct test_sui=
te *test __maybe_unused, int subt
> > > >
> > > >  out:
> > > >       /* tear down everything */
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       machines__exit(&machines);
> > > >       put_fake_samples();
> > > >
> > > > diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/his=
ts_filter.c
> > > > index 1cebd20cc91c..447fb2b5947c 100644
> > > > --- a/tools/perf/tests/hists_filter.c
> > > > +++ b/tools/perf/tests/hists_filter.c
> > > > @@ -331,7 +331,7 @@ static int test__hists_filter(struct test_suite=
 *test __maybe_unused, int subtes
> > > >
> > > >  out:
> > > >       /* tear down everything */
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       reset_output_field();
> > > >       machines__exit(&machines);
> > > >       put_fake_samples();
> > > > diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists=
_link.c
> > > > index 996f5f0b3bd1..9646c3b7b4de 100644
> > > > --- a/tools/perf/tests/hists_link.c
> > > > +++ b/tools/perf/tests/hists_link.c
> > > > @@ -352,7 +352,7 @@ static int test__hists_link(struct test_suite *=
test __maybe_unused, int subtest
> > > >
> > > >  out:
> > > >       /* tear down everything */
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       reset_output_field();
> > > >       machines__exit(&machines);
> > > >       put_fake_samples();
> > > > diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/his=
ts_output.c
> > > > index ee5ec8bda60e..aa8565fbaf90 100644
> > > > --- a/tools/perf/tests/hists_output.c
> > > > +++ b/tools/perf/tests/hists_output.c
> > > > @@ -631,7 +631,7 @@ static int test__hists_output(struct test_suite=
 *test __maybe_unused, int subtes
> > > >
> > > >  out:
> > > >       /* tear down everything */
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       machines__exit(&machines);
> > > >       put_fake_samples();
> > > >
> > > > diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_=
pmu.c
> > > > index 97ea036ebae6..7d1040619575 100644
> > > > --- a/tools/perf/tests/hwmon_pmu.c
> > > > +++ b/tools/perf/tests/hwmon_pmu.c
> > > > @@ -211,7 +211,7 @@ static int do_test(size_t i, bool with_pmu, boo=
l with_alias)
> > > >
> > > >  out:
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/ke=
ep-tracking.c
> > > > index 729cc9cc1cb7..51cfd6522867 100644
> > > > --- a/tools/perf/tests/keep-tracking.c
> > > > +++ b/tools/perf/tests/keep-tracking.c
> > > > @@ -153,7 +153,7 @@ static int test__keep_tracking(struct test_suit=
e *test __maybe_unused, int subte
> > > >  out_err:
> > > >       if (evlist) {
> > > >               evlist__disable(evlist);
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >       }
> > > >       perf_cpu_map__put(cpus);
> > > >       perf_thread_map__put(threads);
> > > > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-=
basic.c
> > > > index a622bb8d4cc8..2591b6fbec3f 100644
> > > > --- a/tools/perf/tests/mmap-basic.c
> > > > +++ b/tools/perf/tests/mmap-basic.c
> > > > @@ -93,7 +93,7 @@ static int test__basic_mmap(struct test_suite *te=
st __maybe_unused, int subtest
> > > >                               /* Permissions failure, flag the fail=
ure as a skip. */
> > > >                               err =3D TEST_SKIP;
> > > >                       }
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               evsels[i]->core.attr.wakeup_events =3D 1;
> > > > @@ -105,7 +105,7 @@ static int test__basic_mmap(struct test_suite *=
test __maybe_unused, int subtest
> > > >                       pr_debug("failed to open counter: %s, "
> > > >                                "tweak /proc/sys/kernel/perf_event_p=
aranoid?\n",
> > > >                                str_error_r(errno, sbuf, sizeof(sbuf=
)));
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               nr_events[i] =3D 0;
> > > > @@ -115,7 +115,7 @@ static int test__basic_mmap(struct test_suite *=
test __maybe_unused, int subtest
> > > >       if (evlist__mmap(evlist, 128) < 0) {
> > > >               pr_debug("failed to mmap events: %d (%s)\n", errno,
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       for (i =3D 0; i < nsyscalls; ++i)
> > > > @@ -133,7 +133,7 @@ static int test__basic_mmap(struct test_suite *=
test __maybe_unused, int subtest
> > > >               if (event->header.type !=3D PERF_RECORD_SAMPLE) {
> > > >                       pr_debug("unexpected %s event\n",
> > > >                                perf_event__name(event->header.type)=
);
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               perf_sample__init(&sample, /*all=3D*/false);
> > > > @@ -141,7 +141,7 @@ static int test__basic_mmap(struct test_suite *=
test __maybe_unused, int subtest
> > > >               if (err) {
> > > >                       pr_err("Can't parse sample, err =3D %d\n", er=
r);
> > > >                       perf_sample__exit(&sample);
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               err =3D -1;
> > > > @@ -150,7 +150,7 @@ static int test__basic_mmap(struct test_suite *=
test __maybe_unused, int subtest
> > > >               if (evsel =3D=3D NULL) {
> > > >                       pr_debug("event with id %" PRIu64
> > > >                                " doesn't map to an evsel\n", sample=
.id);
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >               nr_events[evsel->core.idx]++;
> > > >               perf_mmap__consume(&md->core);
> > > > @@ -165,12 +165,12 @@ static int test__basic_mmap(struct test_suite=
 *test __maybe_unused, int subtest
> > > >                                expected_nr_events[evsel->core.idx],
> > > >                                evsel__name(evsel), nr_events[evsel-=
>core.idx]);
> > > >                       err =3D -1;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >
> > > > -out_delete_evlist:
> > > > -     evlist__delete(evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(evlist);
> > > >  out_free_cpus:
> > > >       perf_cpu_map__put(cpus);
> > > >  out_free_threads:
> > > > diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/pe=
rf/tests/openat-syscall-tp-fields.c
> > > > index 2a139d2781a8..3ff595c7a86a 100644
> > > > --- a/tools/perf/tests/openat-syscall-tp-fields.c
> > > > +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> > > > @@ -51,7 +51,7 @@ static int test__syscall_openat_tp_fields(struct =
test_suite *test __maybe_unused
> > > >       if (IS_ERR(evsel)) {
> > > >               pr_debug("%s: evsel__newtp\n", __func__);
> > > >               ret =3D PTR_ERR(evsel) =3D=3D -EACCES ? TEST_SKIP : T=
EST_FAIL;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__add(evlist, evsel);
> > > > @@ -59,7 +59,7 @@ static int test__syscall_openat_tp_fields(struct =
test_suite *test __maybe_unused
> > > >       err =3D evlist__create_maps(evlist, &opts.target);
> > > >       if (err < 0) {
> > > >               pr_debug("%s: evlist__create_maps\n", __func__);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evsel__config(evsel, &opts, NULL);
> > > > @@ -70,14 +70,14 @@ static int test__syscall_openat_tp_fields(struc=
t test_suite *test __maybe_unused
> > > >       if (err < 0) {
> > > >               pr_debug("perf_evlist__open: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       err =3D evlist__mmap(evlist, UINT_MAX);
> > > >       if (err < 0) {
> > > >               pr_debug("evlist__mmap: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__enable(evlist);
> > > > @@ -115,7 +115,7 @@ static int test__syscall_openat_tp_fields(struc=
t test_suite *test __maybe_unused
> > > >                               if (err) {
> > > >                                       pr_debug("Can't parse sample,=
 err =3D %d\n", err);
> > > >                                       perf_sample__exit(&sample);
> > > > -                                     goto out_delete_evlist;
> > > > +                                     goto out_put_evlist;
> > > >                               }
> > > >
> > > >                               tp_flags =3D evsel__intval(evsel, &sa=
mple, "flags");
> > > > @@ -123,7 +123,7 @@ static int test__syscall_openat_tp_fields(struc=
t test_suite *test __maybe_unused
> > > >                               if (flags !=3D tp_flags) {
> > > >                                       pr_debug("%s: Expected flags=
=3D%#x, got %#x\n",
> > > >                                                __func__, flags, tp_=
flags);
> > > > -                                     goto out_delete_evlist;
> > > > +                                     goto out_put_evlist;
> > > >                               }
> > > >
> > > >                               goto out_ok;
> > > > @@ -136,13 +136,13 @@ static int test__syscall_openat_tp_fields(str=
uct test_suite *test __maybe_unused
> > > >
> > > >               if (++nr_polls > 5) {
> > > >                       pr_debug("%s: no events!\n", __func__);
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >       }
> > > >  out_ok:
> > > >       ret =3D TEST_OK;
> > > > -out_delete_evlist:
> > > > -     evlist__delete(evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(evlist);
> > > >  out:
> > > >       return ret;
> > > >  }
> > > > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/par=
se-events.c
> > > > index e4cdb517c10e..0778462016f7 100644
> > > > --- a/tools/perf/tests/parse-events.c
> > > > +++ b/tools/perf/tests/parse-events.c
> > > > @@ -2550,7 +2550,7 @@ static int test_event(const struct evlist_tes=
t *e)
> > > >               ret =3D e->check(evlist);
> > > >       }
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >
> > > >       return ret;
> > > >  }
> > > > @@ -2576,7 +2576,7 @@ static int test_event_fake_pmu(const char *st=
r)
> > > >       }
> > > >
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >
> > > >       return ret;
> > > >  }
> > > > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/par=
se-metric.c
> > > > index 66a5275917e2..b343628c7a7e 100644
> > > > --- a/tools/perf/tests/parse-metric.c
> > > > +++ b/tools/perf/tests/parse-metric.c
> > > > @@ -83,7 +83,7 @@ static int __compute_metric(const char *name, str=
uct value *vals,
> > > >
> > > >       cpus =3D perf_cpu_map__new("0");
> > > >       if (!cpus) {
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               return -ENOMEM;
> > > >       }
> > > >
> > > > @@ -112,7 +112,7 @@ static int __compute_metric(const char *name, s=
truct value *vals,
> > > >       /* ... cleanup. */
> > > >       evlist__free_stats(evlist);
> > > >       perf_cpu_map__put(cpus);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return err;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf=
/tests/parse-no-sample-id-all.c
> > > > index 50e68b7d43aa..d5a8d065809e 100644
> > > > --- a/tools/perf/tests/parse-no-sample-id-all.c
> > > > +++ b/tools/perf/tests/parse-no-sample-id-all.c
> > > > @@ -49,7 +49,7 @@ static int process_events(union perf_event **even=
ts, size_t count)
> > > >       for (i =3D 0; i < count && !err; i++)
> > > >               err =3D process_event(&evlist, events[i]);
> > > >
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >
> > > >       return err;
> > > >  }
> > > > diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf=
-record.c
> > > > index efbd9cd60c63..babec674b83c 100644
> > > > --- a/tools/perf/tests/perf-record.c
> > > > +++ b/tools/perf/tests/perf-record.c
> > > > @@ -102,7 +102,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >       err =3D evlist__create_maps(evlist, &opts.target);
> > > >       if (err < 0) {
> > > >               pr_debug("Not enough memory to create thread/cpu maps=
\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       /*
> > > > @@ -114,7 +114,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >       err =3D evlist__prepare_workload(evlist, &opts.target, argv, =
false, NULL);
> > > >       if (err < 0) {
> > > >               pr_debug("Couldn't run the workload!\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       /*
> > > > @@ -131,7 +131,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >               pr_debug("sched__get_first_possible_cpu: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > >               evlist__cancel_workload(evlist);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       cpu =3D err;
> > > > @@ -143,7 +143,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >               pr_debug("sched_setaffinity: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > >               evlist__cancel_workload(evlist);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       /*
> > > > @@ -155,7 +155,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >               pr_debug("perf_evlist__open: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > >               evlist__cancel_workload(evlist);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       /*
> > > > @@ -168,7 +168,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >               pr_debug("evlist__mmap: %s\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > >               evlist__cancel_workload(evlist);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       /*
> > > > @@ -206,7 +206,7 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >                                       if (verbose > 0)
> > > >                                               perf_event__fprintf(e=
vent, NULL, stderr);
> > > >                                       pr_debug("Couldn't parse samp=
le\n");
> > > > -                                     goto out_delete_evlist;
> > > > +                                     goto out_put_evlist;
> > > >                               }
> > > >
> > > >                               if (verbose > 0) {
> > > > @@ -346,9 +346,9 @@ static int test__PERF_RECORD(struct test_suite =
*test __maybe_unused, int subtest
> > > >               pr_debug("PERF_RECORD_MMAP for %s missing!\n", "[vdso=
]");
> > > >               ++errs;
> > > >       }
> > > > -out_delete_evlist:
> > > > +out_put_evlist:
> > > >       CPU_FREE(cpu_mask);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >  out:
> > > >       perf_sample__exit(&sample);
> > > >       if (err =3D=3D -EACCES)
> > > > diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests=
/perf-time-to-tsc.c
> > > > index cca41bd37ae3..d3538fa20af3 100644
> > > > --- a/tools/perf/tests/perf-time-to-tsc.c
> > > > +++ b/tools/perf/tests/perf-time-to-tsc.c
> > > > @@ -201,7 +201,7 @@ static int test__perf_time_to_tsc(struct test_s=
uite *test __maybe_unused, int su
> > > >       err =3D TEST_OK;
> > > >
> > > >  out_err:
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       perf_cpu_map__put(cpus);
> > > >       perf_thread_map__put(threads);
> > > >       return err;
> > > > diff --git a/tools/perf/tests/pfm.c b/tools/perf/tests/pfm.c
> > > > index 2e38dfa34b6c..099a50dec37e 100644
> > > > --- a/tools/perf/tests/pfm.c
> > > > +++ b/tools/perf/tests/pfm.c
> > > > @@ -79,7 +79,7 @@ static int test__pfm_events(struct test_suite *te=
st __maybe_unused,
> > > >                               evlist__nr_groups(evlist),
> > > >                               0);
> > > >
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >       }
> > > >       return 0;
> > > >  }
> > > > @@ -164,7 +164,7 @@ static int test__pfm_group(struct test_suite *t=
est __maybe_unused,
> > > >                               evlist__nr_groups(evlist),
> > > >                               table[i].nr_groups);
> > > >
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >       }
> > > >       return 0;
> > > >  }
> > > > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-e=
vents.c
> > > > index f40a828c9861..ab547f301c61 100644
> > > > --- a/tools/perf/tests/pmu-events.c
> > > > +++ b/tools/perf/tests/pmu-events.c
> > > > @@ -797,7 +797,7 @@ static int check_parse_id(const char *id, struc=
t parse_events_error *error)
> > > >                            /*warn_if_reordered=3D*/true, /*fake_tp=
=3D*/false);
> > > >       free(dup);
> > > >
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > @@ -844,7 +844,7 @@ static int test__parsing_callback(const struct =
pmu_metric *pm,
> > > >
> > > >       cpus =3D perf_cpu_map__new("0");
> > > >       if (!cpus) {
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               return -ENOMEM;
> > > >       }
> > > >
> > > > @@ -901,7 +901,7 @@ static int test__parsing_callback(const struct =
pmu_metric *pm,
> > > >       /* ... cleanup. */
> > > >       evlist__free_stats(evlist);
> > > >       perf_cpu_map__put(cpus);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return err;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > > > index cbded2c6faa4..bd3f4a2806ed 100644
> > > > --- a/tools/perf/tests/pmu.c
> > > > +++ b/tools/perf/tests/pmu.c
> > > > @@ -249,7 +249,7 @@ static int test__pmu_events(struct test_suite *=
test __maybe_unused, int subtest
> > > >       ret =3D TEST_OK;
> > > >  err_out:
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       test_pmu_put(dir, pmu);
> > > >       return ret;
> > > >  }
> > > > diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-cloc=
k.c
> > > > index 4a2ad7176fa0..f7f1f16638b4 100644
> > > > --- a/tools/perf/tests/sw-clock.c
> > > > +++ b/tools/perf/tests/sw-clock.c
> > > > @@ -58,7 +58,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids=
 clock_id)
> > > >       evsel =3D evsel__new(&attr);
> > > >       if (evsel =3D=3D NULL) {
> > > >               pr_debug("evsel__new\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >       evlist__add(evlist, evsel);
> > > >
> > > > @@ -67,7 +67,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids=
 clock_id)
> > > >       if (!cpus || !threads) {
> > > >               err =3D -ENOMEM;
> > > >               pr_debug("Not enough memory to create thread/cpu maps=
\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > > @@ -79,14 +79,14 @@ static int __test__sw_clock_freq(enum perf_sw_i=
ds clock_id)
> > > >               pr_debug("Couldn't open evlist: %s\nHint: check %s, u=
sing %" PRIu64 " in this test.\n",
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)),
> > > >                        knob, (u64)attr.sample_freq);
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       err =3D evlist__mmap(evlist, 128);
> > > >       if (err < 0) {
> > > >               pr_debug("failed to mmap event: %d (%s)\n", errno,
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__enable(evlist);
> > > > @@ -112,7 +112,7 @@ static int __test__sw_clock_freq(enum perf_sw_i=
ds clock_id)
> > > >               if (err < 0) {
> > > >                       pr_debug("Error during parse sample\n");
> > > >                       perf_sample__exit(&sample);
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               total_periods +=3D sample.period;
> > > > @@ -130,10 +130,10 @@ static int __test__sw_clock_freq(enum perf_sw=
_ids clock_id)
> > > >               err =3D -1;
> > > >       }
> > > >
> > > > -out_delete_evlist:
> > > > +out_put_evlist:
> > > >       perf_cpu_map__put(cpus);
> > > >       perf_thread_map__put(threads);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return err;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/=
switch-tracking.c
> > > > index 15791fcb76b2..c3d5825df0a8 100644
> > > > --- a/tools/perf/tests/switch-tracking.c
> > > > +++ b/tools/perf/tests/switch-tracking.c
> > > > @@ -577,7 +577,7 @@ static int test__switch_tracking(struct test_su=
ite *test __maybe_unused, int sub
> > > >  out:
> > > >       if (evlist) {
> > > >               evlist__disable(evlist);
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >       }
> > > >       perf_cpu_map__put(cpus);
> > > >       perf_thread_map__put(threads);
> > > > diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-e=
xit.c
> > > > index 4053ff2813bb..a46650b10689 100644
> > > > --- a/tools/perf/tests/task-exit.c
> > > > +++ b/tools/perf/tests/task-exit.c
> > > > @@ -74,7 +74,7 @@ static int test__task_exit(struct test_suite *tes=
t __maybe_unused, int subtest _
> > > >       if (!cpus || !threads) {
> > > >               err =3D -ENOMEM;
> > > >               pr_debug("Not enough memory to create thread/cpu maps=
\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > > @@ -82,7 +82,7 @@ static int test__task_exit(struct test_suite *tes=
t __maybe_unused, int subtest _
> > > >       err =3D evlist__prepare_workload(evlist, &target, argv, false=
, workload_exec_failed_signal);
> > > >       if (err < 0) {
> > > >               pr_debug("Couldn't run the workload!\n");
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evsel =3D evlist__first(evlist);
> > > > @@ -101,14 +101,14 @@ static int test__task_exit(struct test_suite =
*test __maybe_unused, int subtest _
> > > >       if (err < 0) {
> > > >               pr_debug("Couldn't open the evlist: %s\n",
> > > >                        str_error_r(-err, sbuf, sizeof(sbuf)));
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (evlist__mmap(evlist, 128) < 0) {
> > > >               pr_debug("failed to mmap events: %d (%s)\n", errno,
> > > >                        str_error_r(errno, sbuf, sizeof(sbuf)));
> > > >               err =3D -1;
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist__start_workload(evlist);
> > > > @@ -133,7 +133,7 @@ static int test__task_exit(struct test_suite *t=
est __maybe_unused, int subtest _
> > > >               if (retry_count++ > 1000) {
> > > >                       pr_debug("Failed after retrying 1000 times\n"=
);
> > > >                       err =3D -1;
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >               }
> > > >
> > > >               goto retry;
> > > > @@ -144,10 +144,10 @@ static int test__task_exit(struct test_suite =
*test __maybe_unused, int subtest _
> > > >               err =3D -1;
> > > >       }
> > > >
> > > > -out_delete_evlist:
> > > > +out_put_evlist:
> > > >       perf_cpu_map__put(cpus);
> > > >       perf_thread_map__put(threads);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return err;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pm=
u.c
> > > > index 1e900ef92e37..e78ff9dcea97 100644
> > > > --- a/tools/perf/tests/tool_pmu.c
> > > > +++ b/tools/perf/tests/tool_pmu.c
> > > > @@ -67,7 +67,7 @@ static int do_test(enum tool_pmu_event ev, bool w=
ith_pmu)
> > > >
> > > >  out:
> > > >       parse_events_error__exit(&err);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topolog=
y.c
> > > > index af4618c3124a..b88447899021 100644
> > > > --- a/tools/perf/tests/topology.c
> > > > +++ b/tools/perf/tests/topology.c
> > > > @@ -55,7 +55,7 @@ static int session_write_header(char *path)
> > > >                       !perf_session__write_header(session, session-=
>evlist,
> > > >                                                   perf_data__fd(&da=
ta), true));
> > > >
> > > > -     evlist__delete(session->evlist);
> > > > +     evlist__put(session->evlist);
> > > >       perf_session__delete(session);
> > > >
> > > >       return 0;
> > > > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > > > index 25e2769b5e74..ed230cd44ba7 100644
> > > > --- a/tools/perf/util/cgroup.c
> > > > +++ b/tools/perf/util/cgroup.c
> > > > @@ -503,8 +503,8 @@ int evlist__expand_cgroup(struct evlist *evlist=
, const char *str, bool open_cgro
> > > >       cgrp_event_expanded =3D true;
> > > >
> > > >  out_err:
> > > > -     evlist__delete(orig_list);
> > > > -     evlist__delete(tmp_list);
> > > > +     evlist__put(orig_list);
> > > > +     evlist__put(tmp_list);
> > > >       metricgroup__rblist_exit(&orig_metric_events);
> > > >       release_cgroup_list();
> > > >
> > > > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/da=
ta-convert-bt.c
> > > > index 3d2e437e1354..1166cdb00aca 100644
> > > > --- a/tools/perf/util/data-convert-bt.c
> > > > +++ b/tools/perf/util/data-convert-bt.c
> > > > @@ -1331,7 +1331,7 @@ static void cleanup_events(struct perf_sessio=
n *session)
> > > >               zfree(&evsel->priv);
> > > >       }
> > > >
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       session->evlist =3D NULL;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > > index d99a3f12606f..ea1f398c14e3 100644
> > > > --- a/tools/perf/util/evlist.c
> > > > +++ b/tools/perf/util/evlist.c
> > > > @@ -73,7 +73,7 @@ int sigqueue(pid_t pid, int sig, const union sigv=
al value);
> > > >  #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
> > > >  #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
> > > >
> > > > -void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus=
,
> > > > +static void evlist__init(struct evlist *evlist, struct perf_cpu_ma=
p *cpus,
> > > >                 struct perf_thread_map *threads)
> > > >  {
> > > >       perf_evlist__init(&evlist->core);
> > > > @@ -85,6 +85,7 @@ void evlist__init(struct evlist *evlist, struct p=
erf_cpu_map *cpus,
> > > >       evlist->ctl_fd.pos =3D -1;
> > > >       evlist->nr_br_cntr =3D -1;
> > > >       metricgroup__rblist_init(&evlist->metric_events);
> > > > +     refcount_set(&evlist->refcnt, 1);
> > > >  }
> > > >
> > > >  struct evlist *evlist__new(void)
> > > > @@ -116,7 +117,7 @@ struct evlist *evlist__new_default(void)
> > > >                        can_profile_kernel ? "P" : "Pu");
> > > >               err =3D parse_event(evlist, buf);
> > > >               if (err) {
> > > > -                     evlist__delete(evlist);
> > > > +                     evlist__put(evlist);
> > > >                       return NULL;
> > > >               }
> > > >       }
> > > > @@ -136,13 +137,19 @@ struct evlist *evlist__new_dummy(void)
> > > >       struct evlist *evlist =3D evlist__new();
> > > >
> > > >       if (evlist && evlist__add_dummy(evlist)) {
> > > > -             evlist__delete(evlist);
> > > > +             evlist__put(evlist);
> > > >               evlist =3D NULL;
> > > >       }
> > > >
> > > >       return evlist;
> > > >  }
> > > >
> > > > +struct evlist *evlist__get(struct evlist *evlist)
> > > > +{
> > > > +     refcount_inc(&evlist->refcnt);
> > > > +     return evlist;
> > > > +}
> > > > +
> > > >  /**
> > > >   * evlist__set_id_pos - set the positions of event ids.
> > > >   * @evlist: selected event list
> > > > @@ -181,7 +188,7 @@ static void evlist__purge(struct evlist *evlist=
)
> > > >       evlist->core.nr_entries =3D 0;
> > > >  }
> > > >
> > > > -void evlist__exit(struct evlist *evlist)
> > > > +static void evlist__exit(struct evlist *evlist)
> > > >  {
> > > >       metricgroup__rblist_exit(&evlist->metric_events);
> > > >       event_enable_timer__exit(&evlist->eet);
> > > > @@ -190,11 +197,14 @@ void evlist__exit(struct evlist *evlist)
> > > >       perf_evlist__exit(&evlist->core);
> > > >  }
> > > >
> > > > -void evlist__delete(struct evlist *evlist)
> > > > +void evlist__put(struct evlist *evlist)
> > > >  {
> > > >       if (evlist =3D=3D NULL)
> > > >               return;
> > > >
> > > > +     if (!refcount_dec_and_test(&evlist->refcnt))
> > > > +             return;
> > > > +
> > > >       evlist__free_stats(evlist);
> > > >       evlist__munmap(evlist);
> > > >       evlist__close(evlist);
> > > > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > > > index 61acbb10d9a5..66fb5da08160 100644
> > > > --- a/tools/perf/util/evlist.h
> > > > +++ b/tools/perf/util/evlist.h
> > > > @@ -59,6 +59,7 @@ struct event_enable_timer;
> > > >
> > > >  struct evlist {
> > > >       struct perf_evlist core;
> > > > +     refcount_t       refcnt;
> > > >       bool             enabled;
> > > >       int              id_pos;
> > > >       int              is_pos;
> > > > @@ -104,10 +105,8 @@ struct evsel_str_handler {
> > > >  struct evlist *evlist__new(void);
> > > >  struct evlist *evlist__new_default(void);
> > > >  struct evlist *evlist__new_dummy(void);
> > > > -void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus=
,
> > > > -               struct perf_thread_map *threads);
> > > > -void evlist__exit(struct evlist *evlist);
> > > > -void evlist__delete(struct evlist *evlist);
> > > > +struct evlist *evlist__get(struct evlist *evlist);
> > > > +void evlist__put(struct evlist *evlist);
> > > >
> > > >  void evlist__add(struct evlist *evlist, struct evsel *entry);
> > > >  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
> > > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > > index 7fda0ff89c16..4304b53b5a37 100644
> > > > --- a/tools/perf/util/expr.c
> > > > +++ b/tools/perf/util/expr.c
> > > > @@ -451,7 +451,7 @@ double expr__has_event(const struct expr_parse_=
ctx *ctx, bool compute_ids, const
> > > >               ret =3D parse_event(tmp, id) ? 0 : 1;
> > > >       }
> > > >  out:
> > > > -     evlist__delete(tmp);
> > > > +     evlist__put(tmp);
> > > >       return ret;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > index 4f2a6e10ed5c..e959ddb12dc8 100644
> > > > --- a/tools/perf/util/header.c
> > > > +++ b/tools/perf/util/header.c
> > > > @@ -4307,12 +4307,12 @@ int perf_session__read_header(struct perf_s=
ession *session)
> > > >               evsel =3D evsel__new(&f_attr.attr);
> > > >
> > > >               if (evsel =3D=3D NULL)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >
> > > >               evsel->needs_swap =3D header->needs_swap;
> > > >               /*
> > > >                * Do it before so that if perf_evsel__alloc_id fails=
, this
> > > > -              * entry gets purged too at evlist__delete().
> > > > +              * entry gets purged too at evlist__put().
> > > >                */
> > > >               evlist__add(session->evlist, evsel);
> > > >
> > > > @@ -4323,7 +4323,7 @@ int perf_session__read_header(struct perf_ses=
sion *session)
> > > >                * hattr->ids threads.
> > > >                */
> > > >               if (perf_evsel__alloc_id(&evsel->core, 1, nr_ids))
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >
> > > >               lseek(fd, f_attr.ids.offset, SEEK_SET);
> > > >
> > > > @@ -4342,7 +4342,7 @@ int perf_session__read_header(struct perf_ses=
sion *session)
> > > >                                     perf_file_section__process);
> > > >
> > > >       if (evlist__prepare_tracepoint_events(session->evlist, sessio=
n->tevent.pevent))
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >  #else
> > > >       perf_header__process_sections(header, fd, NULL, perf_file_sec=
tion__process);
> > > >  #endif
> > > > @@ -4351,8 +4351,8 @@ int perf_session__read_header(struct perf_ses=
sion *session)
> > > >  out_errno:
> > > >       return -errno;
> > > >
> > > > -out_delete_evlist:
> > > > -     evlist__delete(session->evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(session->evlist);
> > > >       session->evlist =3D NULL;
> > > >       return -ENOMEM;
> > > >  }
> > > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metric=
group.c
> > > > index 595b83142d2c..64c64dff7424 100644
> > > > --- a/tools/perf/util/metricgroup.c
> > > > +++ b/tools/perf/util/metricgroup.c
> > > > @@ -212,7 +212,7 @@ static void metric__free(struct metric *m)
> > > >       zfree(&m->metric_refs);
> > > >       expr__ctx_free(m->pctx);
> > > >       zfree(&m->modifier);
> > > > -     evlist__delete(m->evlist);
> > > > +     evlist__put(m->evlist);
> > > >       free(m);
> > > >  }
> > > >
> > > > @@ -1318,7 +1318,7 @@ static int parse_ids(bool metric_no_merge, bo=
ol fake_pmu,
> > > >       parsed_evlist =3D NULL;
> > > >  err_out:
> > > >       parse_events_error__exit(&parse_error);
> > > > -     evlist__delete(parsed_evlist);
> > > > +     evlist__put(parsed_evlist);
> > > >       strbuf_release(&events);
> > > >       return ret;
> > > >  }
> > > > @@ -1470,7 +1470,7 @@ static int parse_groups(struct evlist *perf_e=
vlist,
> > > >
> > > >       if (combined_evlist) {
> > > >               evlist__splice_list_tail(perf_evlist, &combined_evlis=
t->core.entries);
> > > > -             evlist__delete(combined_evlist);
> > > > +             evlist__put(combined_evlist);
> > > >       }
> > > >
> > > >       list_for_each_entry(m, &metric_list, nd) {
> > > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse=
-events.c
> > > > index 0c0dc20b1c13..607ab7b82486 100644
> > > > --- a/tools/perf/util/parse-events.c
> > > > +++ b/tools/perf/util/parse-events.c
> > > > @@ -2223,7 +2223,7 @@ int __parse_events(struct evlist *evlist, con=
st char *str, const char *pmu_filte
> > > >
> > > >       /*
> > > >        * There are 2 users - builtin-record and builtin-test object=
s.
> > > > -      * Both call evlist__delete in case of error, so we dont
> > > > +      * Both call evlist__put in case of error, so we dont
> > > >        * need to bother.
> > > >        */
> > > >       return ret;
> > > > @@ -2424,7 +2424,7 @@ int parse_events_option_new_evlist(const stru=
ct option *opt, const char *str, in
> > > >       }
> > > >       ret =3D parse_events_option(opt, str, unset);
> > > >       if (ret) {
> > > > -             evlist__delete(*args->evlistp);
> > > > +             evlist__put(*args->evlistp);
> > > >               *args->evlistp =3D NULL;
> > > >       }
> > > >
> > > > diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/per=
f_api_probe.c
> > > > index 3345145a9307..8cd254d36220 100644
> > > > --- a/tools/perf/util/perf_api_probe.c
> > > > +++ b/tools/perf/util/perf_api_probe.c
> > > > @@ -56,7 +56,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn,=
 struct perf_cpu cpu, const cha
> > > >       err =3D 0;
> > > >
> > > >  out_delete:
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >       return err;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > > index dfc6e9299af9..4149a51e9878 100644
> > > > --- a/tools/perf/util/python.c
> > > > +++ b/tools/perf/util/python.c
> > > > @@ -1273,7 +1273,7 @@ static int pyrf_evsel__setup_types(void)
> > > >  struct pyrf_evlist {
> > > >       PyObject_HEAD
> > > >
> > > > -     struct evlist evlist;
> > > > +     struct evlist *evlist;
> > > >  };
> > > >
> > > >  static int pyrf_evlist__init(struct pyrf_evlist *pevlist,
> > > > @@ -1286,15 +1286,21 @@ static int pyrf_evlist__init(struct pyrf_ev=
list *pevlist,
> > > >       if (!PyArg_ParseTuple(args, "OO", &pcpus, &pthreads))
> > > >               return -1;
> > > >
> > > > +     pevlist->evlist =3D evlist__new();
> > > > +     if (!pevlist->evlist) {
> > > > +             PyErr_NoMemory();
> > > > +             return -1;
> > > > +     }
> > > >       threads =3D ((struct pyrf_thread_map *)pthreads)->threads;
> > > >       cpus =3D ((struct pyrf_cpu_map *)pcpus)->cpus;
> > > > -     evlist__init(&pevlist->evlist, cpus, threads);
> > > > +     perf_evlist__set_maps(&pevlist->evlist->core, cpus, threads);
> > > > +
> > > >       return 0;
> > > >  }
> > > >
> > > >  static void pyrf_evlist__delete(struct pyrf_evlist *pevlist)
> > > >  {
> > > > -     evlist__exit(&pevlist->evlist);
> > > > +     evlist__put(pevlist->evlist);
> > > >       Py_TYPE(pevlist)->tp_free((PyObject*)pevlist);
> > > >  }
> > > >
> > > > @@ -1303,7 +1309,7 @@ static PyObject *pyrf_evlist__all_cpus(struct=
 pyrf_evlist *pevlist)
> > > >       struct pyrf_cpu_map *pcpu_map =3D PyObject_New(struct pyrf_cp=
u_map, &pyrf_cpu_map__type);
> > > >
> > > >       if (pcpu_map)
> > > > -             pcpu_map->cpus =3D perf_cpu_map__get(pevlist->evlist.=
core.all_cpus);
> > > > +             pcpu_map->cpus =3D perf_cpu_map__get(pevlist->evlist-=
>core.all_cpus);
> > > >
> > > >       return (PyObject *)pcpu_map;
> > > >  }
> > > > @@ -1316,7 +1322,7 @@ static PyObject *pyrf_evlist__metrics(struct =
pyrf_evlist *pevlist)
> > > >       if (!list)
> > > >               return NULL;
> > > >
> > > > -     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.=
entries); node;
> > > > +     for (node =3D rb_first_cached(&pevlist->evlist->metric_events=
.entries); node;
> > > >            node =3D rb_next(node)) {
> > > >               struct metric_event *me =3D container_of(node, struct=
 metric_event, nd);
> > > >               struct list_head *pos;
> > > > @@ -1400,7 +1406,7 @@ static PyObject *pyrf_evlist__compute_metric(=
struct pyrf_evlist *pevlist,
> > > >       if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
> > > >               return NULL;
> > > >
> > > > -     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.=
entries);
> > > > +     for (node =3D rb_first_cached(&pevlist->evlist->metric_events=
.entries);
> > > >            mexp =3D=3D NULL && node;
> > > >            node =3D rb_next(node)) {
> > > >               struct metric_event *me =3D container_of(node, struct=
 metric_event, nd);
> > > > @@ -1456,7 +1462,7 @@ static PyObject *pyrf_evlist__compute_metric(=
struct pyrf_evlist *pevlist,
> > > >  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
> > > >                                  PyObject *args, PyObject *kwargs)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >       static char *kwlist[] =3D { "pages", "overwrite", NULL };
> > > >       int pages =3D 128, overwrite =3D false;
> > > >
> > > > @@ -1476,7 +1482,7 @@ static PyObject *pyrf_evlist__mmap(struct pyr=
f_evlist *pevlist,
> > > >  static PyObject *pyrf_evlist__poll(struct pyrf_evlist *pevlist,
> > > >                                  PyObject *args, PyObject *kwargs)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >       static char *kwlist[] =3D { "timeout", NULL };
> > > >       int timeout =3D -1, n;
> > > >
> > > > @@ -1496,7 +1502,7 @@ static PyObject *pyrf_evlist__get_pollfd(stru=
ct pyrf_evlist *pevlist,
> > > >                                        PyObject *args __maybe_unuse=
d,
> > > >                                        PyObject *kwargs __maybe_unu=
sed)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >          PyObject *list =3D PyList_New(0);
> > > >       int i;
> > > >
> > > > @@ -1525,7 +1531,7 @@ static PyObject *pyrf_evlist__add(struct pyrf=
_evlist *pevlist,
> > > >                                 PyObject *args,
> > > >                                 PyObject *kwargs __maybe_unused)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >       PyObject *pevsel;
> > > >       struct evsel *evsel;
> > > >
> > > > @@ -1557,7 +1563,7 @@ static struct mmap *get_md(struct evlist *evl=
ist, int cpu)
> > > >  static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevl=
ist,
> > > >                                         PyObject *args, PyObject *k=
wargs)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >       union perf_event *event;
> > > >       int sample_id_all =3D 1, cpu;
> > > >       static char *kwlist[] =3D { "cpu", "sample_id_all", NULL };
> > > > @@ -1614,7 +1620,7 @@ static PyObject *pyrf_evlist__read_on_cpu(str=
uct pyrf_evlist *pevlist,
> > > >  static PyObject *pyrf_evlist__open(struct pyrf_evlist *pevlist,
> > > >                                  PyObject *args, PyObject *kwargs)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >
> > > >       if (evlist__open(evlist) < 0) {
> > > >               PyErr_SetFromErrno(PyExc_OSError);
> > > > @@ -1627,7 +1633,7 @@ static PyObject *pyrf_evlist__open(struct pyr=
f_evlist *pevlist,
> > > >
> > > >  static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
> > > >  {
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >
> > > >       evlist__close(evlist);
> > > >
> > > > @@ -1653,7 +1659,7 @@ static PyObject *pyrf_evlist__config(struct p=
yrf_evlist *pevlist)
> > > >               .no_buffering        =3D true,
> > > >               .no_inherit          =3D true,
> > > >       };
> > > > -     struct evlist *evlist =3D &pevlist->evlist;
> > > > +     struct evlist *evlist =3D pevlist->evlist;
> > > >
> > > >       evlist__config(evlist, &opts, &callchain_param);
> > > >       Py_INCREF(Py_None);
> > > > @@ -1662,14 +1668,14 @@ static PyObject *pyrf_evlist__config(struct=
 pyrf_evlist *pevlist)
> > > >
> > > >  static PyObject *pyrf_evlist__disable(struct pyrf_evlist *pevlist)
> > > >  {
> > > > -     evlist__disable(&pevlist->evlist);
> > > > +     evlist__disable(pevlist->evlist);
> > > >       Py_INCREF(Py_None);
> > > >       return Py_None;
> > > >  }
> > > >
> > > >  static PyObject *pyrf_evlist__enable(struct pyrf_evlist *pevlist)
> > > >  {
> > > > -     evlist__enable(&pevlist->evlist);
> > > > +     evlist__enable(pevlist->evlist);
> > > >       Py_INCREF(Py_None);
> > > >       return Py_None;
> > > >  }
> > > > @@ -1760,7 +1766,23 @@ static Py_ssize_t pyrf_evlist__length(PyObje=
ct *obj)
> > > >  {
> > > >       struct pyrf_evlist *pevlist =3D (void *)obj;
> > > >
> > > > -     return pevlist->evlist.core.nr_entries;
> > > > +     return pevlist->evlist->core.nr_entries;
> > > > +}
> > > > +
> > > > +static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
> > > > +{
> > > > +     struct pyrf_evsel *pevsel =3D PyObject_New(struct pyrf_evsel,=
 &pyrf_evsel__type);
> > > > +
> > > > +     if (!pevsel)
> > > > +             return NULL;
> > > > +
> > > > +     memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
> > > > +     evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.id=
x);
> > > > +
> > > > +     evsel__clone(&pevsel->evsel, evsel);
> > > > +     if (evsel__is_group_leader(evsel))
> > > > +             evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
> > > > +     return (PyObject *)pevsel;
> > > >  }
> > > >
> > > >  static PyObject *pyrf_evlist__item(PyObject *obj, Py_ssize_t i)
> > > > @@ -1768,17 +1790,16 @@ static PyObject *pyrf_evlist__item(PyObject=
 *obj, Py_ssize_t i)
> > > >       struct pyrf_evlist *pevlist =3D (void *)obj;
> > > >       struct evsel *pos;
> > > >
> > > > -     if (i >=3D pevlist->evlist.core.nr_entries) {
> > > > +     if (i >=3D pevlist->evlist->core.nr_entries) {
> > > >               PyErr_SetString(PyExc_IndexError, "Index out of range=
");
> > > >               return NULL;
> > > >       }
> > > >
> > > > -     evlist__for_each_entry(&pevlist->evlist, pos) {
> > > > +     evlist__for_each_entry(pevlist->evlist, pos) {
> > > >               if (i-- =3D=3D 0)
> > > >                       break;
> > > >       }
> > > > -
> > > > -     return Py_BuildValue("O", container_of(pos, struct pyrf_evsel=
, evsel));
> > > > +     return pyrf_evsel__from_evsel(pos);
> > > >  }
> > > >
> > > >  static PyObject *pyrf_evlist__str(PyObject *self)
> > > > @@ -1790,7 +1811,7 @@ static PyObject *pyrf_evlist__str(PyObject *s=
elf)
> > > >       PyObject *result;
> > > >
> > > >       strbuf_addstr(&sb, "evlist([");
> > > > -     evlist__for_each_entry(&pevlist->evlist, pos) {
> > > > +     evlist__for_each_entry(pevlist->evlist, pos) {
> > > >               if (!first)
> > > >                       strbuf_addch(&sb, ',');
> > > >               if (!pos->pmu)
> > > > @@ -1931,110 +1952,30 @@ static PyObject *pyrf__tracepoint(struct p=
yrf_evsel *pevsel,
> > > >       return PyLong_FromLong(tp_pmu__id(sys, name));
> > > >  }
> > > >
> > > > -static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
> > > > -{
> > > > -     struct pyrf_evsel *pevsel =3D PyObject_New(struct pyrf_evsel,=
 &pyrf_evsel__type);
> > > > -
> > > > -     if (!pevsel)
> > > > -             return NULL;
> > > > -
> > > > -     memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
> > > > -     evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.id=
x);
> > > > -
> > > > -     evsel__clone(&pevsel->evsel, evsel);
> > > > -     if (evsel__is_group_leader(evsel))
> > > > -             evsel__set_leader(&pevsel->evsel, &pevsel->evsel);
> > > > -     return (PyObject *)pevsel;
> > > > -}
> > > > -
> > > > -static int evlist__pos(struct evlist *evlist, struct evsel *evsel)
> > > > -{
> > > > -     struct evsel *pos;
> > > > -     int idx =3D 0;
> > > > -
> > > > -     evlist__for_each_entry(evlist, pos) {
> > > > -             if (evsel =3D=3D pos)
> > > > -                     return idx;
> > > > -             idx++;
> > > > -     }
> > > > -     return -1;
> > > > -}
> > > > -
> > > > -static struct evsel *evlist__at(struct evlist *evlist, int idx)
> > > > -{
> > > > -     struct evsel *pos;
> > > > -     int idx2 =3D 0;
> > > > -
> > > > -     evlist__for_each_entry(evlist, pos) {
> > > > -             if (idx =3D=3D idx2)
> > > > -                     return pos;
> > > > -             idx2++;
> > > > -     }
> > > > -     return NULL;
> > > > -}
> > > > -
> > > >  static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
> > > >  {
> > > >       struct pyrf_evlist *pevlist =3D PyObject_New(struct pyrf_evli=
st, &pyrf_evlist__type);
> > > > -     struct evsel *pos;
> > > > -     struct rb_node *node;
> > > >
> > > >       if (!pevlist)
> > > >               return NULL;
> > > >
> > > > -     memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
> > > > -     evlist__init(&pevlist->evlist, evlist->core.all_cpus, evlist-=
>core.threads);
> > > > -     evlist__for_each_entry(evlist, pos) {
> > > > -             struct pyrf_evsel *pevsel =3D (void *)pyrf_evsel__fro=
m_evsel(pos);
> > > > -
> > > > -             evlist__add(&pevlist->evlist, &pevsel->evsel);
> > > > -     }
> > > > -     evlist__for_each_entry(&pevlist->evlist, pos) {
> > > > -             struct evsel *leader =3D evsel__leader(pos);
> > > > -
> > > > -             if (pos !=3D leader) {
> > > > -                     int idx =3D evlist__pos(evlist, leader);
> > > > -
> > > > -                     if (idx >=3D 0)
> > > > -                             evsel__set_leader(pos, evlist__at(&pe=
vlist->evlist, idx));
> > > > -                     else if (leader =3D=3D NULL)
> > > > -                             evsel__set_leader(pos, pos);
> > > > -             }
> > > > -     }
> > > > -     metricgroup__copy_metric_events(&pevlist->evlist, /*cgrp=3D*/=
NULL,
> > > > -                                     &pevlist->evlist.metric_event=
s,
> > > > -                                     &evlist->metric_events);
> > > > -     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.=
entries); node;
> > > > -          node =3D rb_next(node)) {
> > > > -             struct metric_event *me =3D container_of(node, struct=
 metric_event, nd);
> > > > -             struct list_head *mpos;
> > > > -             int idx =3D evlist__pos(evlist, me->evsel);
> > > > -
> > > > -             if (idx >=3D 0)
> > > > -                     me->evsel =3D evlist__at(&pevlist->evlist, id=
x);
> > > > -             list_for_each(mpos, &me->head) {
> > > > -                     struct metric_expr *e =3D container_of(mpos, =
struct metric_expr, nd);
> > > > -
> > > > -                     for (int j =3D 0; e->metric_events[j]; j++) {
> > > > -                             idx =3D evlist__pos(evlist, e->metric=
_events[j]);
> > > > -                             if (idx >=3D 0)
> > > > -                                     e->metric_events[j] =3D evlis=
t__at(&pevlist->evlist, idx);
> > > > -                     }
> > > > -             }
> > > > -     }
> > > > +     pevlist->evlist =3D evlist__get(evlist);
> > > >       return (PyObject *)pevlist;
> > > >  }
> > > >
> > > >  static PyObject *pyrf__parse_events(PyObject *self, PyObject *args=
)
> > > >  {
> > > >       const char *input;
> > > > -     struct evlist evlist =3D {};
> > > > +     struct evlist *evlist =3D evlist__new();
> > > >       struct parse_events_error err;
> > > >       PyObject *result;
> > > >       PyObject *pcpus =3D NULL, *pthreads =3D NULL;
> > > >       struct perf_cpu_map *cpus;
> > > >       struct perf_thread_map *threads;
> > > >
> > > > +     if (!evlist)
> > > > +             return PyErr_NoMemory();
> > > > +
> > > >       if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads=
))
> > > >               return NULL;
> > > >
> > > > @@ -2042,35 +1983,38 @@ static PyObject *pyrf__parse_events(PyObjec=
t *self, PyObject *args)
> > > >       cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> > > >
> > > >       parse_events_error__init(&err);
> > > > -     evlist__init(&evlist, cpus, threads);
> > > > -     if (parse_events(&evlist, input, &err)) {
> > > > +     perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > > +     if (parse_events(evlist, input, &err)) {
> > > >               parse_events_error__print(&err, input);
> > > >               PyErr_SetFromErrno(PyExc_OSError);
> > > >               return NULL;
> > > >       }
> > > > -     result =3D pyrf_evlist__from_evlist(&evlist);
> > > > -     evlist__exit(&evlist);
> > > > +     result =3D pyrf_evlist__from_evlist(evlist);
> > > > +     evlist__put(evlist);
> > > >       return result;
> > > >  }
> > > >
> > > >  static PyObject *pyrf__parse_metrics(PyObject *self, PyObject *arg=
s)
> > > >  {
> > > >       const char *input, *pmu =3D NULL;
> > > > -     struct evlist evlist =3D {};
> > > > +     struct evlist *evlist =3D evlist__new();
> > > >       PyObject *result;
> > > >       PyObject *pcpus =3D NULL, *pthreads =3D NULL;
> > > >       struct perf_cpu_map *cpus;
> > > >       struct perf_thread_map *threads;
> > > >       int ret;
> > > >
> > > > +     if (!evlist)
> > > > +             return PyErr_NoMemory();
> > > > +
> > > >       if (!PyArg_ParseTuple(args, "s|sOO", &input, &pmu, &pcpus, &p=
threads))
> > > >               return NULL;
> > > >
> > > >       threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->=
threads : NULL;
> > > >       cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
> > > >
> > > > -     evlist__init(&evlist, cpus, threads);
> > > > -     ret =3D metricgroup__parse_groups(&evlist, pmu ?: "all", inpu=
t,
> > > > +     perf_evlist__set_maps(&evlist->core, cpus, threads);
> > > > +     ret =3D metricgroup__parse_groups(evlist, pmu ?: "all", input=
,
> > > >                                       /*metric_no_group=3D*/ false,
> > > >                                       /*metric_no_merge=3D*/ false,
> > > >                                       /*metric_no_threshold=3D*/ tr=
ue,
> > > > @@ -2082,8 +2026,8 @@ static PyObject *pyrf__parse_metrics(PyObject=
 *self, PyObject *args)
> > > >               PyErr_SetFromErrno(PyExc_OSError);
> > > >               return NULL;
> > > >       }
> > > > -     result =3D pyrf_evlist__from_evlist(&evlist);
> > > > -     evlist__exit(&evlist);
> > > > +     result =3D pyrf_evlist__from_evlist(evlist);
> > > > +     evlist__put(evlist);
> > > >       return result;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
> > > > index e867de8ddaaa..8a5fc7d5e43c 100644
> > > > --- a/tools/perf/util/record.c
> > > > +++ b/tools/perf/util/record.c
> > > > @@ -264,7 +264,7 @@ bool evlist__can_select_event(struct evlist *ev=
list, const char *str)
> > > >       ret =3D true;
> > > >
> > > >  out_delete:
> > > > -     evlist__delete(temp_evlist);
> > > > +     evlist__put(temp_evlist);
> > > >       return ret;
> > > >  }
> > > >
> > > > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > > > index 081e68c72c30..f241d91221d7 100644
> > > > --- a/tools/perf/util/session.c
> > > > +++ b/tools/perf/util/session.c
> > > > @@ -256,7 +256,7 @@ void perf_session__delete(struct perf_session *=
session)
> > > >       machines__exit(&session->machines);
> > > >       if (session->data) {
> > > >               if (perf_data__is_read(session->data))
> > > > -                     evlist__delete(session->evlist);
> > > > +                     evlist__put(session->evlist);
> > > >               perf_data__close(session->data);
> > > >       }
> > > >  #ifdef HAVE_LIBTRACEEVENT
> > > > diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/si=
deband_evlist.c
> > > > index 388846f17bc1..b84a5463e039 100644
> > > > --- a/tools/perf/util/sideband_evlist.c
> > > > +++ b/tools/perf/util/sideband_evlist.c
> > > > @@ -102,7 +102,7 @@ int evlist__start_sb_thread(struct evlist *evli=
st, struct target *target)
> > > >               return 0;
> > > >
> > > >       if (evlist__create_maps(evlist, target))
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       if (evlist->core.nr_entries > 1) {
> > > >               bool can_sample_identifier =3D perf_can_sample_identi=
fier();
> > > > @@ -116,25 +116,25 @@ int evlist__start_sb_thread(struct evlist *ev=
list, struct target *target)
> > > >       evlist__for_each_entry(evlist, counter) {
> > > >               if (evsel__open(counter, evlist->core.user_requested_=
cpus,
> > > >                               evlist->core.threads) < 0)
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >       }
> > > >
> > > >       if (evlist__mmap(evlist, UINT_MAX))
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       evlist__for_each_entry(evlist, counter) {
> > > >               if (evsel__enable(counter))
> > > > -                     goto out_delete_evlist;
> > > > +                     goto out_put_evlist;
> > > >       }
> > > >
> > > >       evlist->thread.done =3D 0;
> > > >       if (pthread_create(&evlist->thread.th, NULL, perf_evlist__pol=
l_thread, evlist))
> > > > -             goto out_delete_evlist;
> > > > +             goto out_put_evlist;
> > > >
> > > >       return 0;
> > > >
> > > > -out_delete_evlist:
> > > > -     evlist__delete(evlist);
> > > > +out_put_evlist:
> > > > +     evlist__put(evlist);
> > > >       evlist =3D NULL;
> > > >       return -1;
> > > >  }
> > > > @@ -145,5 +145,5 @@ void evlist__stop_sb_thread(struct evlist *evli=
st)
> > > >               return;
> > > >       evlist->thread.done =3D 1;
> > > >       pthread_join(evlist->thread.th, NULL);
> > > > -     evlist__delete(evlist);
> > > > +     evlist__put(evlist);
> > > >  }
> > > > --
> > > > 2.51.1.851.g4ebd6896fd-goog

