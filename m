Return-Path: <linux-kernel+bounces-699005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E71AE4CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 20:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA67A3695
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFC2D131A;
	Mon, 23 Jun 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KR9WVSwQ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0542065
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702654; cv=none; b=B1bdJyx3kpR6RqGLqmaiAH8IrMTiowhFISk3JSTFL44kgjAOxg5M/MV1At/kQKknYo/NZy+Tx0vqQWWOsaaUUOqpuTM7yQ2ccbq7voqYN728y2j45aCnH6Ic3I+/q2LI/4q+GqxpSvaCIJuweUNb8NnV2sFSEVKMqeuar0ISbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702654; c=relaxed/simple;
	bh=KjX9hbfC+EcV6h2iM+G+DkOUcQy4YEsEoFB6KGPRJiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk1O7SO/AllfE5ppbDx44/RuEwtx7UHA/BTTPeCodatmr+6WGOXIrwu7iSmi9wsWtTYEgdvgl6sSJqxRctl4gnNpO079ygZWyxAdxsDwyayFVHaG8LPVPnH3RcSy8e7I72zlE5JAPMI4iwJa1ZHvJs9qLGNjA24tg5C1BNNm24Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KR9WVSwQ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so18345ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 11:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750702652; x=1751307452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX5nmmgwY0hBVlf7aMoDZKsFfUCvDBd1UsXXJPvN9mg=;
        b=KR9WVSwQQBt7sfzF/1XMLux+WlKnj74YGki1pLl3EzIV/uBdw+4SZYi/0xmUYKXvJW
         k6LKIDdzx2PgvdvR4cy8aiSH3FH7qJRZgIBmGPzDOXwRRaMVD0pdWRWPZDvhfXCAnbfo
         07PrTT5ArA0qUe3QC0tEtGWVNTUvPxS2RbOACRlr5QjadoxlWjOZyvmwhKIhMQwzEdur
         6wLx1/JJtR2u9fZHTW8dRsbdlFr90qxjlUCos92L4uCD5JOTThKnpQsQ3oV4VPLVoRm/
         wEYRjWRUCQ04dfBEcdJUON4ZkM1B/z5YvA7Y2jIIRshYZF59/M/N36/jCNmV8ePD2aLW
         cZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702652; x=1751307452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dX5nmmgwY0hBVlf7aMoDZKsFfUCvDBd1UsXXJPvN9mg=;
        b=VKpobcDh6J1BqkxkfwjxPky0nO2jwMX1Lw8Tw/oGKMfj0x3QtMxHPluGWwxeqe1nmQ
         utMAiWDEhYC+n7B9S/ZiBTvJByB+pq9DvZUNRAj/CL0On5160Uh4YC1pmL4kbalEy2O/
         GrbLxKbk5NW4X6t6XMMKLxf0HmKGXaq/GMtgA02eWedtDv37lmK0T8KBsDNJn0zaCb/P
         zMugs9zreP7BzWGuhWfn9EKkqxSxnHcnkHrSLkasHAWtw82r4mHIBIUaw41FcDcHIOpW
         vZEkeDzPNlmg3Ao2t+BDjoPYx0He+gLU4/au/4fZUHRl4rFWYDqA+z4NV16Q2OzWY1OM
         B7/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKfyokdizFN9iQKS6dHR+CxJZAQle7CI9F0VBvNVcjhyI8orD4Jp+J26ihF59qAQVmR039nZ3Qd4zw+v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YynRnHzmQB4pLWoytjeozj+F878tbJ4IcgwpvghNkVQQ5TBytHT
	mvwTweAl48Ki38sng7EsvoP7qhnngW5F6LoLCC16AEoSzz9bF5ilLB2FE3lI3Otesd1t3x4S7C3
	VTJ+H4DRtDGeaY33M2/jOcv4LBbhB5z3F6yHmZeDF
X-Gm-Gg: ASbGnctZxcIKGQGwmTtorTv4v7yLr7MTP93XDMNAVLKH7hnldlEwwjvXhvHI6sr0W1G
	Eezawi7aF8wStdT0OxcjWOOxbNHJeP9tZXNjS7TpNGtwmWQQHVczp+hk/MIyqdAXWNF4qoNMSpa
	y95jRyCOrLuu0V1hcBfPuxE2RwOUD10/GKoz8yTZaRRDMj0a8Y800W96F2agz5nQUKMPOfah0h
X-Google-Smtp-Source: AGHT+IHEDu+O4BUFjCcxZ1MyvRO2QKXmrDxBbVyqySqQfqkGQ/ogiMm9DV5FMVW18S7/nFksxFh4G8srlNjVUvQL3BA=
X-Received: by 2002:a05:6e02:156e:b0:3dd:b826:deca with SMTP id
 e9e14a558f8ab-3df0cefdc17mr6671585ab.26.1750702651524; Mon, 23 Jun 2025
 11:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611233239.3098064-1-ctshao@google.com> <CAP-5=fXyB3H-msiSUGH_XqOntJNv-A2X7DtjvZO=nLzJgdTY+A@mail.gmail.com>
 <CAJpZYjVxs3yAS1-Uj_aQjkHGo+hRkHnwCbWxNsS4pT50-rvRPg@mail.gmail.com>
 <CAP-5=fWvnALUJiHrb_xzHXjseD88HF7LExs4N_Okg+UguuXsXg@mail.gmail.com>
 <CAJpZYjWUUbnNyBYXNSu_mmUrYLhNHHmdro8r08Xe0tN7nAanxg@mail.gmail.com> <aFXctF683XlLmiRy@google.com>
In-Reply-To: <aFXctF683XlLmiRy@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Jun 2025 11:17:20 -0700
X-Gm-Features: AX0GCFuF0EDqZmQkD-2YOLJszX4GEWfGRbqDf0jEzTi5oWlapQSru5F_wWVYkXk
Message-ID: <CAP-5=fW39O4=fu4CkcZSJWMA-5gkPaixGhWZecqMnrQt_vYsCg@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix uncore aggregation number
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 3:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi CT,
>
> On Thu, Jun 12, 2025 at 03:55:59PM -0700, Chun-Tse Shao wrote:
> > Hi Ian, I actually renamed it to `aggr_nr` in v2 patch so it should be
> > better aligned to json mode, which is using `aggregate-nunber`. But
> > anyway I think any name other than `cpus` is better.
> > v2 patch: lore.kernel.org/20250612225324.3315450-1-ctshao@google.com
>
> I think "aggregation-count" is a better name, maybe abbreviated to
> "ag_cnt".  Can we rename the JSON as well?  I'm not sure if it's
> documented somewhere.

Fwiw, I still think "counters" is a clearer, more intention revealing
definition than "aggregation count" or "aggregation number". The term
counter appears in the perf-stat and perf_event_open man page. In the
perf-stat man page we have a pattern of:

       --per-XXX
           Aggregate counts per XXX for system-wide mode measurements. This=
 is a
           useful mode to .... To enable this mode, use --per-XXX
           in addition to -a. (system-wide). The output includes the ...
          This is useful to gauge the amount of aggregation.

It seems that the aggregated value of the counters could be confused
for being an "aggregation count" or "aggregation number" given the man
page definition. I think "counters" to some extent avoids this, we
giving the number of counters aggregated. The perf-stat man page could
certainly be clearer :-)

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >
> > On Wed, Jun 11, 2025 at 10:12=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 8:18=E2=80=AFPM Chun-Tse Shao <ctshao@google.=
com> wrote:
> > > >
> > > > Thanks for your test, Ian!
> > > >
> > > > I wonder if `nr_pmus` makes sense, since the column would be shared
> > > > with multiple different pmus. WDYT?
> > >
> > > So each PMU in sysfs has a cpumask that specifies which CPUs perf
> > > should pass to perf_event_open. For example, on a two socket machine
> > > the cpumask will typically have the first CPU of each socket. If the
> > > cpumask (or cpus) file isn't present then the cpumask is implicitly
> > > all online CPUs. Given that the aggregation number is the number of
> > > CPUs in the cpumask multiplied by the number of PMUs, I think the mos=
t
> > > neutral name is probably "counters" possibly shortened down to "ctrs"=
.
> > > I suspect others have better suggestions :-)
> > >
> > > Thanks,
> > > Ian
> > >
> > > > -CT
> > > >
> > > > On Wed, Jun 11, 2025 at 5:16=E2=80=AFPM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > On Wed, Jun 11, 2025 at 4:36=E2=80=AFPM Chun-Tse Shao <ctshao@goo=
gle.com> wrote:
> > > > > >
> > > > > > Follow up:
> > > > > > lore.kernel.org/CAP-5=3DfVDF4-qYL1Lm7efgiHk7X=3D_nw_nEFMBZFMcsn=
OOJgX4Kg@mail.gmail.com/
> > > > > >
> > > > > > The patch adds unit aggregation during evsel merge the aggregat=
ed uncore
> > > > > > counters.
> > > > > >
> > > > > > Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
> > > > > > cpumask=3D"0,120"
> > > > > > Before:
> > > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > > >   #           time socket cpus             counts unit events
> > > > > >        1.001085024 S0        1         9615386315      clocktic=
ks
> > > > > >        1.001085024 S1        1         9614287448      clocktic=
ks
> > > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > > >   #           time node   cpus             counts unit events
> > > > > >        1.001029867 N0        1         3205726984      clocktic=
ks
> > > > > >        1.001029867 N1        1         3205444421      clocktic=
ks
> > > > > >        1.001029867 N2        1         3205234018      clocktic=
ks
> > > > > >        1.001029867 N3        1         3205224660      clocktic=
ks
> > > > > >        1.001029867 N4        1         3205207213      clocktic=
ks
> > > > > >        1.001029867 N5        1         3205528246      clocktic=
ks
> > > > > > After:
> > > > > >   perf stat -e clockticks -I 1000 --per-socket
> > > > > >   #           time socket cpus             counts unit events
> > > > >
> > > > > I wonder if there is a better column heading than "cpus" given th=
at
> > > > > these are imc PMUs.
> > > > >
> > > > > >        1.001022937 S0       12         9621463177      clocktic=
ks
> > > > > >        1.001022937 S1       12         9619804949      clocktic=
ks
> > > > > >   perf stat -e clockticks -I 1000 --per-node
> > > > > >   #           time node   cpus             counts unit events
> > > > > >        1.001029867 N0        4         3206782080      clocktic=
ks
> > > > > >        1.001029867 N1        4         3207025354      clocktic=
ks
> > > > > >        1.001029867 N2        4         3207067946      clocktic=
ks
> > > > > >        1.001029867 N3        4         3206871733      clocktic=
ks
> > > > > >        1.001029867 N4        4         3206199005      clocktic=
ks
> > > > > >        1.001029867 N5        4         3205525058      clocktic=
ks
> > > > > >
> > > > > > Suggested-by: Ian Rogers <irogers@google.com>
> > > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > >
> > > > Added Namhyung's ack from the previous email.
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > >
> > > > > Tested-by: Ian Rogers <irogers@google.com>
> > > > >
> > > > > Thanks,
> > > > > Ian
> > > > >
> > > > > > ---
> > > > > >  tools/perf/util/stat.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > > > > > index 355a7d5c8ab8..52266d773353 100644
> > > > > > --- a/tools/perf/util/stat.c
> > > > > > +++ b/tools/perf/util/stat.c
> > > > > > @@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struc=
t evsel *evsel, struct evsel *alias)
> > > > > >                 struct perf_counts_values *aggr_counts_b =3D &p=
s_b->aggr[i].counts;
> > > > > >
> > > > > >                 /* NB: don't increase aggr.nr for aliases */
> > > > > > +               ps_a->aggr[i].nr +=3D ps_b->aggr[i].nr;
> > > > > >
> > > > > >                 aggr_counts_a->val +=3D aggr_counts_b->val;
> > > > > >                 aggr_counts_a->ena +=3D aggr_counts_b->ena;
> > > > > > --
> > > > > > 2.50.0.rc1.591.g9c95f17f64-goog
> > > > > >

