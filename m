Return-Path: <linux-kernel+bounces-831299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B8B9C4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B279618828BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D913286D76;
	Wed, 24 Sep 2025 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hz7yAft7"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBE25484D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750588; cv=none; b=j38XCzr65624RuguPShd+OyHxvz55gv8Gh/UXk8LiHfWJUBU4+vySfMWLMGttDry5LSaA2KwJyd/mw/bwf0bzDsL3bCCLSwcKZKK0UE2fA+ppY8CNdFaAgQNyP9Cvoon2TxgR+CrrMkO1UBoUIMuGpGl+GsdEwxjleEehvNC4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750588; c=relaxed/simple;
	bh=GWYtZbeYbpW8w97l5i6HJsikqt6icbDuVis+D9ScMc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaUloCEciqytq7N3jgTB/6XL9dtEov61gQBWIBxaW3368asCpxxtKGfvCTzRO3HZWFwqVS7JHXt7uEQMY/Qi7BSIQFnDFrdcrNWuOFVfMuiMJIetWjqMtsMqJli4wMNzmlWSqJ+zynJXzWkqbNZRZXMslAMNX/kCvlz+kheweZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hz7yAft7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2731ff54949so252665ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758750586; x=1759355386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3HDVNWJ9AP4sLfDQFWKcbzWNRC8jMSO7rPt8JusEKE=;
        b=hz7yAft7UC0q6Q62MvlEZcQfcjYvdim3e0PTNcSo5m9Ug7oy9vRGX3P0wDgQGtlkSm
         5woF8t81saIQP7Vrj3y2Be1tdjz5r8CUyrnLQvSHqwReFwX9poIGTfJMaXh5phJu0Erp
         26EA+hXvmzZ1jIqa1lfjyQ47RCyfSP9cR+OzpBBCg7COIpGabUbyVkfeaqtxidNACgtP
         I/7Osw/EWCFRtZeWgErPhE7Cxm9miS4mgPgULBuTTtAuUde+wFJA5yf2qYng1hLdzE+n
         sut6gCJvLlb/8E71MBxfoXHr8mVObER/1CGecixUU1mHiBFIzgqI1xTSwXxZxt0izxY9
         vqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758750586; x=1759355386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3HDVNWJ9AP4sLfDQFWKcbzWNRC8jMSO7rPt8JusEKE=;
        b=gngCh09aAHyb+iaICD5Cqzuog6yokNa1aeKHtnTHScEpffYPLOulJUhaMGJYaU06k3
         oMhRxgF5wSwX8SPZ/VWPxytqOyCOovA+nR/pk3ZKd6EN9k8wYev/bI8WoigED5x32x3e
         rKrsLfsx8OT4L/qfTRnUKVHzd9XJ2gVFteaTzuCukEsKBzV32YNl8Pn3JxuGJw5qllD4
         28jHZQkw9h5Sj5K9oNguud4IJSq2HaAhud6q1avB47Xs/f+QU3BidknG5KMajGVh5AXk
         uZYMKfeUGgtSJeUfopgv5C0HTxEG/r2Qlfri75oI07GX6dyEcBH7Xsg6H+OtuZc4ytkw
         ju5g==
X-Forwarded-Encrypted: i=1; AJvYcCUtpT9fb+wG90uNCuhoQcs1EFbwSyD0SH4KiFucZmYZb/QyXrem9mah9huqXMEM4V7QxSTC2MrU0PpOUWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcVzgXwGQrWN0Fh6+EnsO1jO4Mv4ZEFgOPcEu1lzKcxUJFKaRH
	r/C46+UGu3UzmUCMqjxkUqzqG2+S8toiDRkSH3ogLiUFkIEFtpofBQayY0fIlrFWFvIjcjfamB+
	K2rNo+yUcpoewp9IcP1FCOCKlV0JHlKNy2XxKAbeg
X-Gm-Gg: ASbGncvD4+bZHpArRKkDwpWWMwBZKGbFxPfgrphgefgG18Op+VqHAulSrB2or/PsgSy
	LslbPh7O0nZBmqHRAh/fpsTXb+SrFlSjPzItlSXAYPIDQ0w+PheDf11TJ1zyYl8b6N46wI5JSHq
	32aruEgSDaBgrQWwjNlcrlmxK7f4HN9A7VOAmmAga7hVsdUyU9vSNpzSnQy/ntlBh7wKiBVEywH
	Uem62f3KGlEvX0aMAFf4vtOFVODI9qFASVlMJ4AH9s+
X-Google-Smtp-Source: AGHT+IHgfh/bnEKI5ZG6ydJJO89r1MO2Jayc5KZ22fVyjJEtrbiWq4ff9SosWj/Hhe1/Rq3bn213LQ9prx7ajV1hK7k=
X-Received: by 2002:a17:902:e80b:b0:25b:fba3:afb5 with SMTP id
 d9443c01a7336-27ed4027f80mr2529035ad.11.1758750586153; Wed, 24 Sep 2025
 14:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com> <5275b98eff5e686521c407f4d38eed8448be5a3b.camel@intel.com>
In-Reply-To: <5275b98eff5e686521c407f4d38eed8448be5a3b.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Sep 2025 14:49:35 -0700
X-Gm-Features: AS18NWCkawn9Aupm1GEZZqFcGGLsV0ngulWs5uUmK05QF9mk4JuEqEvJQDEGI0Y
Message-ID: <CAP-5=fVm+AY=cHE4izpwjUnSnZ=qyCmo55d6wJA-WCJo4Rp3cw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] perf vendor events intel update
To: "Falcon, Thomas" <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"afaerber@suse.de" <afaerber@suse.de>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mani@kernel.org" <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:13=E2=80=AFPM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
>
> On Tue, 2025-09-23 at 23:02 -0700, Ian Rogers wrote:
> > Update events and some metrics to the latest perfmon versions:
> >  - alderlake 1.34
> >  - arrowlake 1.13
> >  - emeraldrapids 1.20
> >  - grandridge 1.10
> >  - graniterapids 1.15
> >  - lunarlake 1.18
> >  - meteorlake 1.17
> >  - sapphirerapids 1.35
> >  - sierraforest 1.12
> >
>
> Metrics tests passed on Alder Lake, Sapphire Rapids, and Arrow Lake.
>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

Thanks! I think we found an issue on emeraldrapids that
pcu_0/UNC_P_CLOCKTICKS/ should be pcu/UNC_P_CLOCKTICKS/ in the
cpu_cstate metrics. The question is, how many PCUs does an
emeraldrapids have? Is it guaranteed to be 1 or do we need to support
suffixes when there is >1. I'm guessing the story on sapphirerapids is
similar, we just didn't test it.

The use of a suffix in the PMU of the event name is to avoid
aggregating all the clockticks together.  A less efficient way to do
this would be "UNC_P_CLOCKTICKS / source_count(UNC_P_CLOCKTICKS)"
which would compute an average of the clockticks. We could update perf
to ignore _0 suffixes when looking for PMUs, which feels kind of hacky
and ARM has different suffix conventions. We could do:
"pcu_0@UNC_P_CLOCKTICKS@ if has_event(pcu_0@UNC_P_CLOCKTICKS@) else
pcu@UNC_P_CLOCKTICKS@"
which feels a little long winded. If we know EMR and SPR have just 1
PCU I think I'd prefer just to turn pcu_0 into pcu as a fix.

Thanks,
Ian

> Thanks,
> Tom
>
> > Ian Rogers (10):
> >   perf vendor events intel: Update alderlake events to v1.34
> >   perf vendor events intel: Update arrowlake events to v1.13
> >   perf vendor events intel: Update emeraldrapids events to v1.20
> >   perf vendor events intel: Update grandridge events to v1.10
> >   perf vendor events intel: Update graniterapids events to v1.15
> >   perf vendor events intel: Update lunarlake events to v1.18
> >   perf vendor events intel: Update meteorlake events to v1.17
> >   perf vendor events intel: Update pantherlake events to v1.00
> >   perf vendor events intel: Update sapphirerapids events to v1.35
> >   perf vendor events intel: Update sierraforest events to v1.12
> >
> >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
> >  .../pmu-events/arch/x86/arrowlake/cache.json  |   46 +-
> >  .../pmu-events/arch/x86/arrowlake/memory.json |    6 +-
> >  .../pmu-events/arch/x86/arrowlake/other.json  |    2 +-
> >  .../arch/x86/emeraldrapids/cache.json         |   63 +
> >  .../arch/x86/emeraldrapids/emr-metrics.json   |   12 +
> >  .../arch/x86/emeraldrapids/uncore-cache.json  |   11 +
> >  .../arch/x86/emeraldrapids/uncore-memory.json |   22 +
> >  .../arch/x86/emeraldrapids/uncore-power.json  |    2 -
> >  .../pmu-events/arch/x86/grandridge/cache.json |   20 +-
> >  .../graniterapids/uncore-interconnect.json    |   10 +-
> >  .../arch/x86/graniterapids/uncore-memory.json |  112 ++
> >  .../pmu-events/arch/x86/lunarlake/cache.json  |   46 +-
> >  .../pmu-events/arch/x86/lunarlake/memory.json |    6 +-
> >  .../pmu-events/arch/x86/lunarlake/other.json  |    2 +-
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   20 +-
> >  .../pmu-events/arch/x86/meteorlake/cache.json |   36 +
> >  .../arch/x86/pantherlake/cache.json           | 1207 ++++++++++-
> >  .../arch/x86/pantherlake/counter.json         |    9 +-
> >  .../arch/x86/pantherlake/floating-point.json  |  286 +++
> >  .../arch/x86/pantherlake/frontend.json        |  535 +++++
> >  .../arch/x86/pantherlake/memory.json          |  106 +-
> >  .../arch/x86/pantherlake/other.json           |   44 +
> >  .../arch/x86/pantherlake/pipeline.json        | 1776
> > ++++++++++++++++-
> >  .../arch/x86/pantherlake/uncore-memory.json   |   26 +
> >  .../arch/x86/pantherlake/virtual-memory.json  |  248 +++
> >  .../arch/x86/sapphirerapids/cache.json        |   63 +
> >  .../arch/x86/sapphirerapids/spr-metrics.json  |   12 +
> >  .../arch/x86/sapphirerapids/uncore-cache.json |   11 +
> >  .../x86/sapphirerapids/uncore-memory.json     |   22 +
> >  .../arch/x86/sapphirerapids/uncore-power.json |    2 -
> >  .../arch/x86/sierraforest/cache.json          |   61 +-
> >  .../x86/sierraforest/uncore-interconnect.json |   10 +-
> >  .../arch/x86/sierraforest/uncore-io.json      |    1 -
> >  .../arch/x86/sierraforest/uncore-memory.json  |  103 +-
> >  35 files changed, 4712 insertions(+), 262 deletions(-)
> >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/pantherlake/floating-point.json
> >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/pantherlake/other.json
> >  create mode 100644 tools/perf/pmu-
> > events/arch/x86/pantherlake/uncore-memory.json
> >
>

