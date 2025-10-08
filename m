Return-Path: <linux-kernel+bounces-845614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233A8BC5857
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE86440360B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187A2F360C;
	Wed,  8 Oct 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGylAEVa"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF47298CDE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936121; cv=none; b=ekcclPhKXMDcOroWU5wkOs6qWg2smNg60nXA4bNRR7T+eEnKZtfUtoMODjAOUa5QqvcCBGVM7LT9/u0LcGGNs3LtSLIaGnQx8PJfAxw6mG0QvmMxBAs9nMl3pdBiYg4kfU79S4J/NtOY1NaRmN7vKD4Tukf49lSFRU5qqh/wx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936121; c=relaxed/simple;
	bh=0jgaG0UnD4RYPzbpJrP+C6lzU5NmS3WZz+jQE8vDcWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjFQR5RVr6VIPCQUwHnZHtHHasymb/fxFzU+2ASsvGUNUX7nEDy8gJIgIBpFS9c/Rml9YbebuhEmC0hU/aIUiYPK7KM7Dfq7gYH4S9cXa1peM7hVobsMobvgpBsVXvjzUn47AQyWF6kYMSyyumePkmki1pzPbvpz1RzXwaef88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGylAEVa; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2731ff54949so198835ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759936119; x=1760540919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10+A/Wgf9iHzcdJ56ejMI3GBStWLH8FDWnolqzz3WNY=;
        b=fGylAEVa1+rMWFxR8aIYsgd4HAFrEWuTWQ0Durw2Y1lIrlkwPDiCsARBuLbQ4Quvmq
         s1K+Q3smkBZn1xEuATIzNYrD+YaZ2TkedFkMasuYe4nHtX8I9O1xvjUowBYWoJg3uRmg
         f6RFidLAukUwKIFxL8/MixQMj6uQdY+iNwJIcaQSel2MABZ1yLTSAgO7iqfafMc/GSJs
         v3Gs9c/UXjmH9rxUvhUlivTG4fw4m0w6qNDfLgUGeqGRdEqikMcc5RkPJQvhdxbAfVKP
         ZrCvZ2IMDM8ErVCGpzDtyhvnSvRiU+pAOEPyNEU/fwHW3kW2KqcaVz5SuQHStP+LRskr
         X5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936119; x=1760540919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10+A/Wgf9iHzcdJ56ejMI3GBStWLH8FDWnolqzz3WNY=;
        b=J9rLFrITW7Ra4PPVKmqKRiP/d65p9QKGo0jsXeoNUQmRBkphCNJXiW8UA6ngzQsIwN
         Mx1zDzVUrasr55wvQa70Uq7xPgOH1KAzy3d8AgAn1z3dCj/W4J9KR25TuKEQOJSQvYS4
         HleG3MHH1S6DSPteOVqcr3MLWMYeuoBx0qGMMGc8YKQdp1RDjT1O3aNSSZpkja9j958t
         J41Na0S0D0seWkQzMOgTc4qhH0MXsUQTtIlU7s+7Kx1/xe2evzUpnT6EHYUyF2OqNJz4
         8pDbj5LvhRULN3Np7AA1Nas8RZ1WtMEKzNZmadJnnwqB4+m74EDbZT1a7LrziAMv7wf8
         gbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2vPJlx/FUCZf37LcHQ/82edg/IGEe5q9QBQ2DeMeflPXnwiTrMSunr2trLRr/XAQrWkWdfzD+X4qtq2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YztHSPxz4o+nJOaxmWoQDM7bsVKhN84HBzj46RJ6fo7mQLDmvbB
	NGSu2kimsXwypi/fR8rGsjNjsN5u1zDpVJAkoNyKM6kVwo9mdUvxzXPa54styz4lNcCZGqn7h2H
	G0flxFH50I7wbnr3F0y+RZwjRtDJ+XRTBVIGd8moW
X-Gm-Gg: ASbGncvQt6nSRpooxUOSvOmaoATvUSosJ/rvp59YHb/e7ELppzHZFfC48N5LtY2b3vm
	AokXVbOw4kYalaBgGkSorgsCQumn6kGzp7REOTWab3QxnHzF5QkMqpCeVbaL/SnzL6VmD/7531D
	20v4cveXll0sTMBCQ2QXf974ooNsQOSvzVAFJfDBA/cvahpGefbRSsfOHz42VsRnT/ikZBA53Uv
	q+4r7Sp0PEQGPzTMSUUMTGX0UTlVBqhRLy046+hy5PL431Ha7HGhnNli8gdiEVgxvXZrw0VRlPL
	YjI=
X-Google-Smtp-Source: AGHT+IEA5bfAGEnmxgkEpgYbLlFKR6/UnvKbH6owwoQlKj5SmNQgcG1ODYv9uPu3CrB5mPkR3Em57VbOB1dHDQGAg9U=
X-Received: by 2002:a17:903:2408:b0:261:83d2:9d91 with SMTP id
 d9443c01a7336-290276de56cmr5322015ad.15.1759936118954; Wed, 08 Oct 2025
 08:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007185826.3674908-1-irogers@google.com> <aOYUPWbyQv53hrjE@google.com>
In-Reply-To: <aOYUPWbyQv53hrjE@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Oct 2025 08:08:27 -0700
X-Gm-Features: AS18NWBWQqG-RTUR2EkYdMU1qeQqpxuHV0_UrNufBtuGJQoxMeBwbPhE2TZXFrc
Message-ID: <CAP-5=fW946mri4wEKBzR+XYzbfBH_foV8KW+AG6bU=H=byt2_Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf bpf_counter: Fix opening of "any"(-1) CPU events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Tue, Oct 07, 2025 at 11:58:26AM -0700, Ian Rogers wrote:
> > The bperf BPF counter code doesn't handle "any"(-1) CPU events, always
> > wanting to aggregate a count against a CPU, which avoids the need for
> > atomics. Force evsels used for BPF counters to require a CPU when not
> > in system-wide mode so that the "any"(-1) value isn't used during map
> > propagation and evsel's CPU map matches that of the PMU.
> >
> > Fixes: b91917c0c6fa ("perf bpf_counter: Fix handling of cpumap fixing h=
ybrid")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c     | 12 ++++++++++++
> >  tools/perf/util/bpf_counter.c |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 7006f848f87a..7fdc7f273a48 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2797,6 +2797,18 @@ int cmd_stat(int argc, const char **argv)
> >
> >       evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
> >
> > +     if (target.use_bpf && !target.system_wide) {
>
> The target.use_bpf only checks the --bpf-counters option.  But IIUC it's
> possible to use BPF only for selected events with ':b' modifier.  I
> think you need to check each evsel with evsel__is_bperf().
>
> Also system_wide might not be set for -C/--cpu option.  Probably you
> want target__has_cpu() instead of target.system_wide.

Thanks Namhyung, I'll fix in v2.

Ian

> Thanks,
> Namhyung
>
>
> > +             /*
> > +              * Setup BPF counters to require CPUs as any(-1) isn't
> > +              * supported. evlist__create_maps below will propagate th=
is
> > +              * information to the evsels.
> > +              */
> > +             struct evsel *counter;
> > +
> > +             evlist__for_each_entry(evsel_list, counter)
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
> > --
> > 2.51.0.710.ga91ca5db03-goog
> >

