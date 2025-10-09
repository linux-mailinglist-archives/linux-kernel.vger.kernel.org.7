Return-Path: <linux-kernel+bounces-846836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCBBC92C0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF1964E5FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5B2E2DFA;
	Thu,  9 Oct 2025 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbMXzilR"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00F11713
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015050; cv=none; b=NaNHdRcaRhmRC43tij2Lxb2DYaDeTRXTcZul1Jgd730sfxRVLZmSKsbNW9suHGIHdslTf4cstI3UoTtagzSrhTXcMLGWDuPP6Jf4SD8297a+6Ar1LNHDMj/preuxYM5MA+22oT7LH77GTdRmY0Ec7xhCMbwjNQmINi4hV9bHjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015050; c=relaxed/simple;
	bh=LG4Z5WVNlgp3hIwMCXh9D2qWKpYs23znPnTeOZfOuSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t372hAbPhBU62y6trYUrn4g3znoOLS1qMyO+FvVrkcAjr4r6o6f3x6LV95HTbwBc/WU10uxAVohpMq5zLxl8ImNoI2ZeJ1Moup3Wd6etRikJIKH1wd1Nf63cKaJu36apDElojSNWuFJU1ZX6Nb/gUAcSLpdGtVyT2GL3hdVJ0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbMXzilR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2731ff54949so176795ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760015047; x=1760619847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl/RSfrwlYvyA1qHmEIVwvLYIxXODeI2qbIcJFQoTrQ=;
        b=bbMXzilRPY4Moh3u4Pdvs25FNhWtsHCs/UQ+mo8tM0C/eGGnW5NTVSVCBx2dlxoZov
         6+XU9O7EOcICH958ZVsU8jdjvdHh2R4ObvS6ALe5G510gQMjIoN0Sv1DSnGBPrwWJ9OH
         9hAdpz82Jgq5iupVvigG+9Xe8Wz6MRAVGJb1ddDDW6wZtEcHHGAf3ckLjNHkgF1xcqzM
         KM5LfftpPszLQ3oqeHRd7UA14VKdUomEXgc/6R+mwzwQ6BN922q9VbIsh5LLrmMfqv81
         SwvyMX4rrYu53QThbo8oIzokld2NTRE/LGHcxg2vWCAebMdpMhnbWZuoPFEkx/5hjZbz
         KkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015047; x=1760619847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fl/RSfrwlYvyA1qHmEIVwvLYIxXODeI2qbIcJFQoTrQ=;
        b=X/ERDRGXbdhKMUFvoVJJq6yWoBYZhsQeUd2ZIy/qO4TISOb5Kik3OFDDD7FQck3+y9
         ZC0m+DgQa4xuQ6XtKhAZ9RIMg+4860rnTNqUci4xmDb7u1zrxT/UI1Uvm/xzZwBbumHB
         cRkVQpIq+X+JN+q9c5RFCNKzFoX/NdDHKxKXAqMvDHSyCvR49wC68vBEIqAFlzksgiLk
         LZQIoz93Uzu6npIklouOHNxTJruSypc2lJe5b7I6S+YEB31Uta9K6WYWOhxYK19YAklI
         DrMGyEuMAlhB+g46th5m7iw8dBqq7HZaqsZ/LXmrEayjMI7AI2BjEMpJ7mdgesu3Fzg6
         26UA==
X-Forwarded-Encrypted: i=1; AJvYcCXL9HpsPi9ahJuotoO49KLGgm8skWHT5WLzuQD32YdFj+R9e0QcJWkmA4ybse3BDjN8EGjSLTPOVVSz9WA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1C3zeYVPMHpoWhb0qsJ+biBW4B0QpeUmfFzkEs6d2QseGYlBB
	DjdD9dUu2jlAoPlK7bgMB7/pTQqQgaNaasTqe38wY9Es5PPviQAk/UxkOzoeO4mBGUEngYwx/pa
	OdyQHd0oTdjykSv0EGPja76j8N7Stdg8DyCTaQ8qD
X-Gm-Gg: ASbGncs/tMxUvUSKA9ziqFFrpqceOZRi5xiIqd1Ii6Ey+28NdiJAX+eYCNZZpzt8QqH
	BJShEild1wCP2vc/Hwf62IR3/p2ADPPr/P/5t2j50Hw3Hl/Mua6KEN/nxy6lqaqf4T1JZc1iRYh
	TZwmulhBZkH67iIDF7ioTNs1118qNa8ujGk9kCijcZs6MIrJ389dQXvz/Zw+aM3oi7Nhnn/+Lml
	fHOyj0LM/8d3doRio07fSIjeZlpD0VQH9xh+c0=
X-Google-Smtp-Source: AGHT+IHmGo/yOZgI4rXtBpU3aqsyiUBab973QHCIWTjzRzsVK57ncfjWXOU8KLSK0RcpNfhT0Re007HssfcMf8SFlvI=
X-Received: by 2002:a17:902:f545:b0:27e:e96a:4c6 with SMTP id
 d9443c01a7336-290275dda35mr12806125ad.2.1760015044872; Thu, 09 Oct 2025
 06:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008162347.4005288-1-irogers@google.com> <02ac6916-7bfa-4b6b-8bae-64fe02580731@huaweicloud.com>
In-Reply-To: <02ac6916-7bfa-4b6b-8bae-64fe02580731@huaweicloud.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Oct 2025 06:03:53 -0700
X-Gm-Features: AS18NWBzhV5frQ3wC17J_JhLbuYI1J4mS1vSXlezOvijWUH7DT-G2L4MGan8hz0
Message-ID: <CAP-5=fV7hhHYAgDp1kR=gjJb2jdrR7GfgKi1mvob4OavhcyHmg@mail.gmail.com>
Subject: Re: [PATCH v2] perf bpf_counter: Fix opening of "any"(-1) CPU events
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 12:52=E2=80=AFAM Tengda Wu <wutengda@huaweicloud.com=
> wrote:
> On 2025/10/9 0:23, Ian Rogers wrote:
> > The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> > wanting to aggregate a count against a CPU, which avoids the need for
> > atomics so let's not change that. Force evsels used for BPF counters
> > to require a CPU when not in system-wide mode so that the "any"(-1)
> > value isn't used during map propagation and evsel's CPU map matches
> > that of the PMU.
> >
> > Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing h=
ybrid")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c     | 13 +++++++++++++
> >  tools/perf/util/bpf_counter.c |  1 +
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 7006f848f87a..0fc6884c1bf1 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2540,6 +2540,7 @@ int cmd_stat(int argc, const char **argv)
> >       unsigned int interval, timeout;
> >       const char * const stat_subcommands[] =3D { "record", "report" };
> >       char errbuf[BUFSIZ];
> > +     struct evsel *counter;
> >
> >       setlocale(LC_ALL, "");
> >
> > @@ -2797,6 +2798,18 @@ int cmd_stat(int argc, const char **argv)
> >
> >       evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
> >
> > +     evlist__for_each_entry(evsel_list, counter) {
> > +             /*
> > +              * Setup BPF counters to require CPUs as any(-1) isn't
> > +              * supported. evlist__create_maps below will propagate th=
is
> > +              * information to the evsels. Note, evsel__is_bperf isn't=
 yet
> > +              * set up, and this change must happen early, so directly=
 use
> > +              * the bpf_counter variable.
> > +              */
> > +             if (counter->bpf_counter)
> > +                     counter->core.requires_cpu =3D true;
> > +     }
> > +
> >       if (evlist__create_maps(evsel_list, &target) < 0) {
> >               if (target__has_task(&target)) {
> >                       pr_err("Problems finding threads of monitor\n");
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counte=
r.c
> > index ca5d01b9017d..d3e5933b171b 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -495,6 +495,7 @@ static int bperf_reload_leader_program(struct evsel=
 *evsel, int attr_map_fd,
> >        * following evsel__open_per_cpu call
> >        */
> >       evsel->leader_skel =3D skel;
> > +     assert(!perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus));
> >       evsel__open(evsel, evsel->core.cpus, evsel->core.threads);
> >
> >  out:
>
>
> I must point out that `requires_cpu + evsel__open(evsel, evsel->core.cpus=
, evsel->core.threads)`
> is not equivalent to the original `evsel__open_per_cpu(evsel, all_cpu_map=
, -1)`. The former
> specifies a pid, while the latter does not. This will lead to inaccurate =
final event counting.
>
>
> For `evsel__open_per_cpu(evsel, all_cpu_map, -1)`:
>
> $ ./perf stat -vv --bpf-counters -e task-clock ./perf test -w sqrtloop
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 =3D 13
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 =3D 14
> sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 =3D 15
> [...]
>  Performance counter stats for './perf test -w sqrtloop':
>
>      1,016,156,671      task-clock                       #    1.000 CPUs =
utilized
>
>        1.016294745 seconds time elapsed
>
>        1.005710000 seconds user
>        0.010637000 seconds sys
>
>
> For `requires_cpu + evsel__open(evsel, evsel->core.cpus, evsel->core.thre=
ads)`:
>
> $ ./perf stat -vv --bpf-counters -e task-clock ./perf test -w sqrtloop
> sys_perf_event_open: pid 75099  cpu 0  group_fd -1  flags 0x8 =3D 13
> sys_perf_event_open: pid 75099  cpu 1  group_fd -1  flags 0x8 =3D 14
> sys_perf_event_open: pid 75099  cpu 2  group_fd -1  flags 0x8 =3D 15
> [...]
>  Performance counter stats for './perf test -w sqrtloop':
>
>         16,184,507      task-clock                       #    0.016 CPUs =
utilized
>
>        1.018540734 seconds time elapsed
>
>        1.009143000 seconds user
>        0.009497000 seconds sys
>
>
> As you can see, after specifying a pid, the task-clock count has signific=
antly decreased.
> So to correct the counting, we may also need to keep the pid as -1 withou=
t specifying it.

Yeah, it look like the running time is off and so the count is being scaled=
:
```
$ perf stat -e task-clock:b,task-clock /tmp/perf/perf test -w noploop

 Performance counter stats for '/tmp/perf/perf test -w noploop':

     3,776,663,297      task-clock:b                     #    3.701
CPUs utilized               (26.96%)
     1,017,400,438      task-clock                       #    0.997
CPUs utilized

       1.020467405 seconds time elapsed

       1.008409000 seconds user
       0.012004000 seconds sys
```
will fix in v3.

Thanks,
Ian

> Thanks,
> Tengda
>

