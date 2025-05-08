Return-Path: <linux-kernel+bounces-639995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36AAAAFF52
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 17:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FD71BA08D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37CA279346;
	Thu,  8 May 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="on7dl3Xr"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62079277816
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718480; cv=none; b=Au27IIUsTMqoyY5dflfsfGNCsq7agCVA0KqUrOvtUSLvlmSU+vpnGnkx0JQ3+s53lHuoFUozjSJ+zkGBl8V1eyyODgWNO9Touu2DnUkJdI89FVlIhN13VzXambJmEnyLyqMVkEshfv3b9YNtrTjEq3H7zYWipEpD7c7lvBkzGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718480; c=relaxed/simple;
	bh=gcIxBck903wC6+fYbT1hPtb7Kf1widiij7ZBobmZTSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVOFVMJw5Wbn7KvkY/AD6DRgRE4lseO5+RCl8cRK25LsLej0gETAIyvebsDK0GT2JdN7v6NBVBh0zzDhwfUvQEy/+ftdTylWSoPhHueDjaE15DRYzhqGsmUzi6vnJVPnzkN12LonGqIslQajze4osNivwUraj92Uw5SWKcuyays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=on7dl3Xr; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3da73d35c11so188815ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 May 2025 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746718477; x=1747323277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXm0ZBrwABOf6g7AdY2Q3tjscZRI3pFxv+5nt0U5acw=;
        b=on7dl3XrGaFTWqXZ33VLhr3+KiUlRjOnMG9JMXJwzKnUxuVqBTWrRHW/81Z9GxgaqH
         qbGFtmz4mBBIUCu2VCLu7fAEzU8zMsGaY+0P+NaKGtqq6T5nW3O/GQ2KYnfmTs+qpis9
         EgAEm8bG21KKvgQsdp8ZYKyT6R8vkgXwD32AKOQ1bC2OgCTZXMsqzYStt99nwn+BG/3y
         A38wI5oDH4p/6JJriACzbJV8aXljjksMrNENGbIbBYcMiZYOc11/xdFAjT/WCrC+pUEr
         lJx4MiW9riEkUJkgq0etBFK7fJXMtUIi4h+0uVmdorH7VYFIxMGWX5lL1kc8m5eBCaWl
         2U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746718477; x=1747323277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXm0ZBrwABOf6g7AdY2Q3tjscZRI3pFxv+5nt0U5acw=;
        b=MXVrZLzcE8+AmMpitrGGxZ64T5GzWoWOjjTGF/CkzfOg7XQmToNP5C1ADtT3JMSE8S
         011O7faQfqjVhee1RMp+MnQWL0u0h/vhfKCqViSHXKoLL3szaJCa4cPcXxNxHqeWWdZN
         g62JDohTBaIX7gz5Pc0hRu+U9P3MFcAe0n0zd4PnU6Q02E9lAIXHDVfLfc9LiU4QvBTe
         r7rKQXGh71wk5EDKBDJg+McJ8sx8chmEUVa/0zotF1Ezmd05PZb4zpBr+CU4xyLCPp9u
         VufO1cQBfvcyScMeQ6/czAfg7gECkr/4PO9VR4UrZoys95JJii7VvxgS//6wckmAg5WX
         vNUw==
X-Forwarded-Encrypted: i=1; AJvYcCVMI2WOCFJwmt0v7vpdKbwBuDYRlu+YXqmbZmGdtCbfTLGPjJJH/N5baUyDhOo+Shjg5/0+knRc7lPmyZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszMH5zoxuWIoiJNrNaLeSQRkMlbDuKoGq2sx+BhtzoB0x2E9R
	IF9E/f7oUykxzyRwOoYG/xg8nTyBNLXJQpbgTM3Ayjf50ApmLB36FI4W74bLU2bICa2kemrKDNs
	pMGm5iN4vid82PuESX4v8DBjPeknfxhGQ85Oi
X-Gm-Gg: ASbGncvSMhYIwCZdo4B22lefiFbTbhMl0cVq4qcW46ECy4ddXpxLIuuayRliG5VTuYo
	vrdJZz7eMKwyyveGLVhWBNMKtrKt4Z3jvC4KfAUfZyb3fsX8Q2H2O0rGmQHiQv4owqJjaQ6lFEv
	reIl9MIQu11hA/nzg/ef8gPyWKqStnH9ezZTTiJz8fKLvXzKeXKuw=
X-Google-Smtp-Source: AGHT+IEmY29VLIxcHiOy88IrSXPvl4jrcnZ6oWdUWj9VlZWcwMFb59eThp1T3HbGq0HsKPusqumJ/JFwaYe/0SvE2tE=
X-Received: by 2002:a05:6e02:338f:b0:3d5:bb1f:843e with SMTP id
 e9e14a558f8ab-3da796a4745mr3873215ab.29.1746718477199; Thu, 08 May 2025
 08:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746627307.git.sandipan.das@amd.com> <CAP-5=fUEeFb3jh-MtxEEH0Z+HFAD0oxSc4uE66Rfg+BRzYRB5Q@mail.gmail.com>
 <9a76fcc7-a8e0-4b88-b93c-7dbf65bc695e@amd.com>
In-Reply-To: <9a76fcc7-a8e0-4b88-b93c-7dbf65bc695e@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 8 May 2025 08:34:26 -0700
X-Gm-Features: ATxdqUFgDyfNDRfGkNXB5R6CnIvZeH9JhkEGpxdXOLCOBuOArjupnMk_-ndllEQ
Message-ID: <CAP-5=fU3fk79xtNAGwk35PCkiii=QoBdhbzit1Ax9OsEtrPExg@mail.gmail.com>
Subject: Re: [PATCH 0/3] perf vendor events amd: Address event errata
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 3:56=E2=80=AFAM Sandipan Das <sandipan.das@amd.com> =
wrote:
>
> On 5/7/2025 9:26 PM, Ian Rogers wrote:
> > On Wed, May 7, 2025 at 7:28=E2=80=AFAM Sandipan Das <sandipan.das@amd.c=
om> wrote:
> >>
> >> Remove unreliable Zen 5 events and metrics. The following errata from
> >> the Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors have
> >> been addressed.
> >> #1569 PMCx078 Counts Incorrectly in Unpredictable Ways
> >> #1583 PMCx18E May Overcount Instruction Cache Accesses
> >> #1587 PMCx188 May Undercount IBS (Instruction Based Sampling) Fetch Ev=
ents
> >>
> >> The document can be downloaded from
> >> https://bugzilla.kernel.org/attachment.cgi?id=3D308095
> >
> > Hi Sandipan,
> >
> > the document is somewhat brief, for example:
> > ```
> > 1583 PMCx18E May Overcount Instruction Cache Accesses
> >
> > Description
> > If PMCx18E[IcAccessTypes] is programmed to 18x (Instruction Cache
> > Miss) or 1Fx (All Instruction Cache Accesses) then the performance
> > counter may overcount.
> >
> > Potential Effect on System
> > Inaccuracies in performance monitoring software may be experienced.
> >
> > Suggested Workaround
> > None
> >
> > Fix Planned
> > No fix planned
> > ```
> > Given being able to count instruction cache accesses (for example) is
> > a useful feature, would it be possible to change:
> > ```
> > -  {
> > -    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
> > -    "EventCode": "0x18e",
> > -    "BriefDescription": "Instruction cache hits.",
> > -    "UMask": "0x07"
> > -  },
> > ...
> > ```
> > to be say:
> > ```
> >   {
> >     "EventName": "ic_tag_hit_miss.instruction_cache_hit",
> >     "EventCode": "0x18e",
> >     "BriefDescription": "Instruction cache hits. Note, this counter is
> > affected by errata 1583.",
> >     "UMask": "0x07",
> >     "Experimental": "1"
> >   },
> > ```
> > That is rather than remove the event, the event is tagged as
> > experimental (taken to mean accuracy isn't guaranteed) and the errata
> > is explicitly noted in the description. Currently the Experimental tag
> > has no impact on what happens in the perf tool, for example, the
> > "Deprecated" tag hides events in the `perf list` command and is
> > commonly used when an event is renamed.
> >
>
> I agree that events like IC hits and misses are generally useful and am
> fine with the idea of keeping them but my concern is that unless users
> read the event description, there is no way for them to know if the
> perf output that they are seeing may be unreliable. There is also no
> guarantee that such events will be fixed in a future uarch. From a
> quick glance, I couldn't find a mechanism that makes perf stat/report
> show a warning for named events with known issues.

So I'm forgetting the flow, but rediscovering it. We do have an Errata
json value as shown in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/arm64/ampere/ampereone/memory.json?h=3Dpe=
rf-tools-next#n2
```
    {
       "ArchStdEvent": "LD_RETIRED",
       "Errata": "Errata AC03_CPU_52",
       "BriefDescription": "Instruction architecturally executed,
condition code check pass, load.
Impacted by errata -"
   },
```
It doesn't impact perf stat/record but it does get added to the event
description for perf list:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/jevents.py?h=3Dperf-tools-next#n340
```
    if 'Errata' in jd:
      extra_desc +=3D '  Spec update: ' + jd['Errata']
```
which means the perf list description ends up as "Instruction
architecturally executed, condition code check pass, load. Impacted by
errata -  Spec update: Errata AC03_CPU_52". We could change this so
that the Errata is distinct in the encoded in perf json and then we
could display the errata when perf stat/record parses the event. I'd
be a little worried about this breaking things that parse perf's text
output, but the impact would be limited to Zen5, Ampere and older
Intel CPUs. We could also make the errata output conditional on
passing a verbose flag to perf. Would just `perf list` support work
for you or would the perf stat/record changes be a requirement for
keeping these events?

Thanks,
Ian

