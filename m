Return-Path: <linux-kernel+bounces-616548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25423A98FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 17:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B71B3A98FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F382F2E;
	Wed, 23 Apr 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPVrjY2L"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592528A408
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420663; cv=none; b=iu4a3wj88nrUoES+fMb+SpC/w/WykBS62eZG6ib4KteXtyYD3evkm64AZgxpSBv0VHe7CuokZwpX+g80q9JwbNRCccvnVzGJsdJ2C9EgJuTQ2Mp3S7c2+U5Ng6ZXuNSB7gZMgy9xnogEkucVEwnj0x3hlrqu1g2HF5bnWZQ8TvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420663; c=relaxed/simple;
	bh=DPLc45KMTxkBLzBed9qrzfeDWpbWI0W7oasRoWyipEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/xAczsynSmGGEtKsRclW1k2Bpr0gz9U7jSB+3il/QLHIgBiH6V85kVtSh4YiZ4kdDIREe8HvzSAgCrLdPePVvGZgSCkwoNAusAOBG5dLh/ygic5VP5fxRWhsuhnLKYDTZj0xRko+RAU1aBanvhZ3fw885FWfaYBqpjt8zMrPkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cPVrjY2L; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d91a45d148so206315ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745420660; x=1746025460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzexhWIg3EMHi1CJeMd1OvZIsDmei5a5xqd4Iuet+68=;
        b=cPVrjY2Lcoq8GZYHQKu7jKCRr5HtBdaeCH4PM8F03dUx0w3EWJMzbXxI/h+Ge4G6Sb
         LoHrwZgixSp5UjYCPiWqCNl6B0BB2kNTdrRNO7BLM7Q//jX1KVLc3soJlt2CkR9+DlqN
         4UedLKCurL9UAIzi0SslQUUiVcxJzPyGs7hJV1H3IAQoWpzZ7NLRveOJhsXb/28KEWTg
         1/zuZr4zEOE9LKluPMHHOM2Z+n1g9We5V9x9sH2Pbl+q/9MySKe4En5pLkAgXvUHNmIn
         jo+43wpvbysT3GoVIjU1soOo0o9Qt1YHo0buOyG9GRRgMLe+CgBrZzRJqpZRzxKmHq95
         WGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420660; x=1746025460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzexhWIg3EMHi1CJeMd1OvZIsDmei5a5xqd4Iuet+68=;
        b=LKf+qT+QQJl1jKsrXtQU/d70EU6pa8S627oX7gi0g6LR2V7DWRBBWpGqyGUv4YbwOC
         bsPw0frA7C/7SR8cEHC4/wKjSAlGq/R/zFduqsz6dhiHCjM6TRyXH/nHwJDkOks5f40j
         YZdO9WP40mNyl9Qpk6UCvXE6HhU5qSFl7W3T1FoQJw64ZkhtSevD+qE3It2x2YkvyvZn
         N0IusM168cGtRsqh8DzOXC2D2fBPp+J+tOPTr3MJBwZM3iG193MXHSQ72y1qy7XTM0CS
         lP9Asp1TcqYMRvHwxWDGBahrCAPLTxIPu10f8fU5i/0wV/kcgUiZidTinCKgiFORNZVl
         AlcA==
X-Forwarded-Encrypted: i=1; AJvYcCVNn9SFAJnFdHsvvS+rwlNnD8DHo5cfIPvtVS6JyYskQRYWUWepKPw65d910F6j5IMB4SwENyFI1MrCXZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6C3HG7dXtqUEDqYDnnvUeqrk4pi2FE06sDk2APMb2uFmiCsD4
	FqwsIHJ52a6kS65gVWy/UyXfNlwlQeSFYhjvfXer9J6E9Ga/ncUYeiceJ3iS6XgzM1WW3473fLL
	M1GqU0VyrB+3/+OFk0nF9EsV8KLNylfUTJIPG
X-Gm-Gg: ASbGncs+ErOeqwv4MoahRt2nCqS+fN+vkaW6gyBxl/sLMGp8gEY4UmEyA2TF0s7MYwS
	zPnSCqaGkKUUSrt1dk6efa+sV+AeKfmGpJSGBoinSgX560exL9UugZM5ECwuUA7IUX33X0eBpDm
	CXPl3MxltX6V2Enr/p1zRQ3mz+a5GhIP2TPhrHF7ZLmT/7+sQ0dJaav6PeC6yJIg==
X-Google-Smtp-Source: AGHT+IF3PZaUnDkeugZi5BTEkQ9SIspZp/FunEE1JSBFPYs56uJgWolhG8G5edUkyJYEKqSBPl20/ri7za8HhXN3zn8=
X-Received: by 2002:a05:6e02:2592:b0:3d4:3ab3:172a with SMTP id
 e9e14a558f8ab-3d926f98a4fmr4805765ab.18.1745420659892; Wed, 23 Apr 2025
 08:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com> <20250414174134.3095492-10-irogers@google.com>
 <aAj30xLNXtXhn6IP@x1>
In-Reply-To: <aAj30xLNXtXhn6IP@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Apr 2025 08:04:07 -0700
X-Gm-Features: ATxdqUF3UrMRyXP46kIQeXHqlhgeONntjsi_Zq-I8xQYrzKXTCh7V9H-ePZlfDo
Message-ID: <CAP-5=fWMcOic=S9vra9ZdJjypmt0Cy=--vpxOhrTnG28ujro6A@mail.gmail.com>
Subject: Re: [PATCH v5 09/16] perf intel-tpebs: Refactor tpebs_results list
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 7:23=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 14, 2025 at 10:41:27AM -0700, Ian Rogers wrote:
> > evsel names and metric-ids are used for matching but this can be
> > problematic, for example, multiple occurrences of the same retirement
> > latency event become a single event for the record. Change the name of
> > the record events so they are unique and reflect the evsel of the
> > retirement latency event that opens them (the retirement latency
> > event's evsel address is embedded within them). This allows an evsel
> > based close to close the event when the retirement latency event is
> > closed. This is important as perf stat has an evlist and the session
> > listen to the record events has an evlist, knowing which event should
> > remove the tpebs_retire_lat can't be tied to an evlist list as there
> > is more than 1, so closing which evlist should cause the tpebs to
> > stop? Using the evsel and the last one out doing the tpebs_stop is
> > cleaner.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Weilin Wang <weilin.wang@intel.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c     |   2 -
> >  tools/perf/util/evlist.c      |   1 -
> >  tools/perf/util/evsel.c       |   2 +-
> >  tools/perf/util/intel-tpebs.c | 150 +++++++++++++++++++++-------------
> >  tools/perf/util/intel-tpebs.h |   2 +-
> >  5 files changed, 93 insertions(+), 64 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 68ea7589c143..80e491bd775b 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -681,8 +681,6 @@ static enum counter_recovery stat_handle_error(stru=
ct evsel *counter)
> >       if (child_pid !=3D -1)
> >               kill(child_pid, SIGTERM);
> >
> > -     tpebs_delete();
> > -
> >       return COUNTER_FATAL;
> >  }
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index c1a04141aed0..0a21da4f990f 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -183,7 +183,6 @@ void evlist__delete(struct evlist *evlist)
> >       if (evlist =3D=3D NULL)
> >               return;
> >
> > -     tpebs_delete();
> >       evlist__free_stats(evlist);
> >       evlist__munmap(evlist);
> >       evlist__close(evlist);
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 121283f2f382..554252ed1aab 100644
> > --- a/tools/perf/util/evsel.c
> <SNIP>
>
> >  static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *e=
vsel)
> >  {
> >       struct tpebs_retire_lat *t;
> > +     uint64_t num;
> > +     const char *evsel_name;
> >
> > +     /*
> > +      * Evsels will match for evlist with the retirement latency event=
. The
> > +      * name with "tpebs_event_" prefix will be present on events bein=
g read
> > +      * from `perf record`.
> > +      */
> > +     if (evsel__is_retire_lat(evsel)) {
> > +             list_for_each_entry(t, &tpebs_results, nd) {
> > +                     if (t->evsel =3D=3D evsel)
> > +                             return t;
> > +             }
> > +             return NULL;
> > +     }
> > +     evsel_name =3D strstr(evsel->name, "tpebs_event_");
> > +     if (!evsel_name) {
> > +             /* Unexpected that the perf record should have other even=
ts. */
> > +             return NULL;
> > +     }
> > +     errno =3D 0;
> > +     num =3D strtoull(evsel_name + 12, NULL, 16);
> > +     if (errno) {
> > +             pr_err("Bad evsel for tpebs find '%s'\n", evsel->name);
> > +             return NULL;
> > +     }
> >       list_for_each_entry(t, &tpebs_results, nd) {
> > -             if (t->tpebs_name =3D=3D evsel->name ||
> > -                 !strcmp(t->tpebs_name, evsel->name) ||
> > -                 (evsel->metric_id && !strcmp(t->tpebs_name, evsel->me=
tric_id)))
> > +             if ((uint64_t)t->evsel =3D=3D num)
> >                       return t;
>
> I'm adding the following patch to address building on 32-bit systems:
>
>   20     4.97 debian:experimental-x-mips    : FAIL gcc version 14.2.0 (De=
bian 14.2.0-13)
>     util/intel-tpebs.c: In function 'tpebs_retire_lat__find':
>     util/intel-tpebs.c:377:21: error: cast from pointer to integer of dif=
ferent size [-Werror=3Dpointer-to-int-cast]
>       377 |                 if ((uint64_t)t->evsel =3D=3D num)
>           |                     ^
>     cc1: all warnings being treated as errors

Thanks! Lgtm.

Ian

> - Arnaldo
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git diff
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.=
c
> index a723687e67f6d7b3..b48f3692c798f924 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -242,7 +242,7 @@ static void tpebs_retire_lat__delete(struct tpebs_ret=
ire_lat *r)
>  static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *evs=
el)
>  {
>         struct tpebs_retire_lat *t;
> -       uint64_t num;
> +       unsigned long num;
>         const char *evsel_name;
>
>         /*
> @@ -269,7 +269,7 @@ static struct tpebs_retire_lat *tpebs_retire_lat__fin=
d(struct evsel *evsel)
>                 return NULL;
>         }
>         list_for_each_entry(t, &tpebs_results, nd) {
> -               if ((uint64_t)t->evsel =3D=3D num)
> +               if ((unsigned long)t->evsel =3D=3D num)
>                         return t;
>         }
>         return NULL;
>

