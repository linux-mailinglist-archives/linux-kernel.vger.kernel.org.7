Return-Path: <linux-kernel+bounces-858796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7038DBEBDB3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCA0400632
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F902D97B9;
	Fri, 17 Oct 2025 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIaVQe5R"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7824C68B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760738021; cv=none; b=ngwDlRVDZAvIDXG5aN7VRLZB1jPhC9p+Wsos0Ev3fYIGqNR9OlAywd6cGWahhsY0fVa1TEIekotzgxn9IXxmYIXPr3tMSBCm8TvRy4GkSdeUM4HV38upoZZ3Do58v9sIFXn028RIT8q3xtyufSqSqSBQ5t0G2hqzNfaXs7KKTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760738021; c=relaxed/simple;
	bh=UIlnOch9wMHrGIbDDvJK/KgLmSG3kMGN7kKkng+aP/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oep931XcdgysR+6kz+RkQlfi4ZL6i0qATMu8XxAIqcS1YYXOKloRNuh53405fXzmuAQibPEeSuaxKdrTcU1BhTQdX8x6eleg6Am5gnVGH3ZHMmETd6Q8ovIsYB5s+hFKXb4uD44KB9HZGGFFtjtGx5LIZ5T5lDxy62T7ga3X9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIaVQe5R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290d48e9f1fso30435ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760738017; x=1761342817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lhu1FJE3o7a7slPawypKrYLVKmRa2jcCvhmHsGFEkKA=;
        b=zIaVQe5Ry+/VzmF8JM+OkroKJdF3KkuQJKGpeTR0htfhRVMC5YmVj9Y5lvlgw2h1Gd
         JUS2WB7K8bJfpcQF3SP2jDiiKkZ3ypHxfQ0epF/9jrx3ZkU9tPV6pAxwldYgiyCFr/WX
         c+VTVOmTNhL8BR9KoQZ2iiIEmBmoh6+vTaAAnOrj3MIUQORniBCmdbnCLf0sI3EHsCLE
         bTkTMlmMBBGHOHaRQNbyS3UtQmIcJ3aAJM8tq/ElYcOoSS6MiAfDARt/VgfDgXCFLCcl
         MS7Q7GlYOgzB0B+MytALR1jEOcarPMT3TNzEoAAayaGzh2JHWH1Sp+ttPq1wKaL5Fqsi
         6UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760738017; x=1761342817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lhu1FJE3o7a7slPawypKrYLVKmRa2jcCvhmHsGFEkKA=;
        b=BhA3TyMXR2u04Jws70QFjZw0YbioxjMnJmFurkU046ukazURU49vi8+zJefvmvzzYW
         xdTRzaMjBiKlLh69LU35sZy+GD3M28bnQ8luAi6OqI0aiBzCNfCiudW92Ils+VJUYImB
         bi3NffHOT1jOTgu7hxOhHC7CViwtK9lqcVeMyZM5EbtlOWDMpCbbzfPiXTODTeG0j2B+
         S+Q2A2cVeOixYG4agomx+eidWyziLrWw5nHOBg9Yv+fYfMFEPSRiHnCIAPSiQAXg2/YW
         k3ejTg2T+fGj/M4jRU8ZgsPBwRVDOEyQMKqIvBY25sram4NAktAPAoOWJYgHnPf/hmky
         kerQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4+bJ7Y2oIUSBLVhKQa45kqas4zts7dCUhW8pD6wsaq7uEtRCCZQZhuHDndSuzRg4dChNDJbDdykFIMBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4mUGE+sYuFA3FWKbMNsEqOQGZuBNj7Z1D3xJQZK4gCcoQUR8
	0NpTQutyJ5KBbYPx6N2GjPkiWYIw7r1Yt2WNn45aJZp3HeAROFFQij1tkb5QEg+gO6cJl8IdjjG
	dEC8WLa7t5bOzHPaR8o4CcESKNYqAkEN21KqNpI0n
X-Gm-Gg: ASbGncvs2SQNJDyKut4FMGbbj7pbnr6MRRuX1MmGdnvbthrpAfSiVnn1CCeiUVcnwX/
	TRnjpjeU6ryHTdxDBILyXSq7Ef9iu28dlduDkJzK5HgvoSSeoiKkRXZOfibC9SsYQyng2ufXszR
	brGi30v7wcc1xClxl8RxBPKeNH0AOkP1MhzBn3zVFtfbls33up1BftBzn02kugqUcZjVI7R2Rvr
	gXGsaSiZrG8t4OalBK/C2YsEJ4ihhMXV4dPkNSwq5zIIfV0blNdO4cq97wX/SfWBySHajo=
X-Google-Smtp-Source: AGHT+IHmiYWWoKGzhCftgUdfhUqWcdQwpSIhAHzu4GGeJICMEicdD1aeJu4r+l9eMiR8qEw767/n2UE4sdWtgdbxtJ0=
X-Received: by 2002:a17:903:37c3:b0:26a:8171:daf8 with SMTP id
 d9443c01a7336-29087a16bacmr19268955ad.8.1760738016568; Fri, 17 Oct 2025
 14:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017165753.206608-1-irogers@google.com> <6ffbfa494002d3ed85a160c2f2a6e1881dfdd304.camel@intel.com>
In-Reply-To: <6ffbfa494002d3ed85a160c2f2a6e1881dfdd304.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 Oct 2025 14:53:25 -0700
X-Gm-Features: AS18NWAMlJReP3U2HQK5VZKL5WjliRppJkXqeUDi3l6eJ-KfM0rhUVdMqf1DaEo
Message-ID: <CAP-5=fUi+oF8kzjYguDz6yjLVL-crFKrLGw7=3jgUeFik_p-_g@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Make X modifier more respectful of groups
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:55=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Fri, 2025-10-17 at 09:57 -0700, Ian Rogers wrote:
> > Events with an X modifier were reordered within a group, for example
> > slots was made the leader in:
> > ```
> > $ perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
> > ```
> >
> > Fix by making `dont_regroup` evsels always use their index for
> > sorting. Make the cur_leader, when fixing the groups, be that of
> > `dont_regroup` evsel so that the `dont_regroup` evsel doesn't become
> > a
> > leader.
> >
> > On a tigerlake this patch corrects this and meets expectations in:
> > ```
> > $ perf stat -e '{cpu/mem-stores/,cpu/slots/uX}' -a -- sleep 0.1
> >
> >  Performance counter stats for 'system wide':
> >
> >         83,458,652      cpu/mem-stores/
> >      2,720,854,880      cpu/slots/uX
> >
> >        0.103780587 seconds time elapsed
> >
> > $ perf stat -e 'slots,slots:X' -a -- sleep 0.1
> >
> >  Performance counter stats for 'system wide':
> >
> >        732,042,247      slots                (48.96%)
> >        643,288,155      slots:X              (51.04%)
> >
> >        0.102731018 seconds time elapsed
> > ```
> >
>
> Hi Ian, just confirming the results on an Alder Lake:
>
> % sudo ./perf stat -e '{cpu_core/mem-stores/,cpu_core/slots/uX}' -a --
> sleep 0.1
>
>  Performance counter stats for 'system wide':
>
>         23,097,346      cpu_core/mem-stores/
>        666,910,974      cpu_core/slots/uX
>
>        0.101369982 seconds time elapsed
>
>  % sudo ./perf stat -e 'slots,slots:X' -a -- sleep 0.1
>
>  Performance counter stats for 'system wide':
>
>      1,775,555,180      cpu_core/slots/
> (50.08%)
>      1,910,073,872      cpu_core/slots/X
> (49.92%)
>
>        0.101368283 seconds time elapsed
>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

I found an issue when the slots event is injected and will look at it in v2=
:
```
$ perf stat -v -e 'topdown-retiring' -a -- sleep 0.1
Using CPUID GenuineIntel-6-8D-1
topdown-retiring -> cpu/topdown-retiring/
WARNING: events were regrouped to match PMUs
evlist after sorting/fixing: '{slots,topdown-retiring}'
Control descriptor is not initialized
perf: util/evsel.c:2028: get_group_fd: Assertion `!(!leader->core.fd)' fail=
ed.
Aborted
```

Thanks,
Ian

> Thanks,
> Tom
>
> > Closes:
> > https://lore.kernel.org/lkml/18f20d38-070c-4e17-bc90-cf7102e1e53d@linux=
.intel.com/
> > Fixes: 035c17893082 ("perf parse-events: Add 'X' modifier to exclude
> > an event from being regrouped")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-
> > events.c
> > index 3aec86aebdc6..1a5da93f4094 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -1973,14 +1973,18 @@ static int evlist__cmp(void *_fg_idx, const
> > struct list_head *l, const struct li
> >        * event's index is used. An index may be forced for events
> > that
> >        * must be in the same group, namely Intel topdown events.
> >        */
> > -     if (*force_grouped_idx !=3D -1 &&
> > arch_evsel__must_be_in_group(lhs)) {
> > +     if (lhs->dont_regroup) {
> > +             lhs_sort_idx =3D lhs_core->idx;
> > +     } else if (*force_grouped_idx !=3D -1 &&
> > arch_evsel__must_be_in_group(lhs)) {
> >               lhs_sort_idx =3D *force_grouped_idx;
> >       } else {
> >               bool lhs_has_group =3D lhs_core->leader !=3D lhs_core ||
> > lhs_core->nr_members > 1;
> >
> >               lhs_sort_idx =3D lhs_has_group ? lhs_core->leader->idx
> > : lhs_core->idx;
> >       }
> > -     if (*force_grouped_idx !=3D -1 &&
> > arch_evsel__must_be_in_group(rhs)) {
> > +     if (rhs->dont_regroup) {
> > +             rhs_sort_idx =3D rhs_core->idx;
> > +     } else if (*force_grouped_idx !=3D -1 &&
> > arch_evsel__must_be_in_group(rhs)) {
> >               rhs_sort_idx =3D *force_grouped_idx;
> >       } else {
> >               bool rhs_has_group =3D rhs_core->leader !=3D rhs_core ||
> > rhs_core->nr_members > 1;
> > @@ -2078,10 +2082,10 @@ static int
> > parse_events__sort_events_and_fix_groups(struct list_head *list)
> >        */
> >       idx =3D 0;
> >       list_for_each_entry(pos, list, core.node) {
> > -             const struct evsel *pos_leader =3D evsel__leader(pos);
> > +             struct evsel *pos_leader =3D evsel__leader(pos);
> >               const char *pos_pmu_name =3D pos->group_pmu_name;
> >               const char *cur_leader_pmu_name;
> > -             bool pos_force_grouped =3D force_grouped_idx !=3D -1 &&
> > +             bool pos_force_grouped =3D force_grouped_idx !=3D -1 &&
> > !pos->dont_regroup &&
> >                       arch_evsel__must_be_in_group(pos);
> >
> >               /* Reset index and nr_members. */
> > @@ -2095,8 +2099,8 @@ static int
> > parse_events__sort_events_and_fix_groups(struct list_head *list)
> >                * groups can't span PMUs.
> >                */
> >               if (!cur_leader || pos->dont_regroup) {
> > -                     cur_leader =3D pos;
> > -                     cur_leaders_grp =3D &pos->core;
> > +                     cur_leader =3D pos_leader;
> > +                     cur_leaders_grp =3D &cur_leader->core;
> >                       if (pos_force_grouped)
> >                               force_grouped_leader =3D pos;
> >               }
>

