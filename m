Return-Path: <linux-kernel+bounces-812602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDCDB53A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A8A188B786
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0B362060;
	Thu, 11 Sep 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o64UTpl6"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64688362081
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610936; cv=none; b=ieSg30IlNqBAOa8fBvMOPApYNJIVfqxR8k9AY/KCjh9d/TlygO8Hh9MTNDT4R+1RNZyooc4g442rdmqpkS+i7JagEz6tfLZ6xzXO72FMw0mp3Ps2MJrgu9Kh9yL5somVxhBxhIbRYSyFgrqthxi0Disid6WI2BArUZ15QCqGqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610936; c=relaxed/simple;
	bh=GVg9rfxN7Ewe9BWFA9Gq1wUs8H/AM44DmlKLGGM+zqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iaCq/W1/a+6atCZYAXSECSUdlIORBCKoxI7dqRvW8PiOspiCswolRBansDcA4ZhGnifWc+u8ZevSjuKZdp4zm18fcG7+OEZwaYRZ8N9Jc6O3LS1c+XOdSq8WUOpwGRNDBpaAvFLgukQ5Ve2mjnqnaTziFsyAcnb2uJUqdTFmy2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o64UTpl6; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25c90c3ba65so13685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757610933; x=1758215733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doxaJGFNeStb7VBc9RthoxQBEA/0luHOGNxKRv+roJ0=;
        b=o64UTpl6HdKpD/bp6iuBnpa+RAZCxwAtCIlBCNiO5aYaGWF4lJFSR6avkepQr36HK0
         gtG92AXA0SlqFXDhffku5ZLeiSk2zYrxb0d6n8zAmhUFxoQzM5XjsYqfFQeXUQqo/F+q
         Ao5m+Skb5iBVMllRcRyW9o6W+eQTHK2dtjsmGzS179uSrbuDZlVXkhFz1fw0PTdHwfSB
         PuhwVbU0o1d9ypEgCgdO9VfthgHw9JCpgDD/w+HF7qfjkMALX+QF+tjqCspy0el+jeev
         y6wVBPOOLFiFoQu7dlXLKSXaHZdA08SojqRlWsZig3CWvnqW1rGTsCHoinr+0bG14UgZ
         pa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610933; x=1758215733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=doxaJGFNeStb7VBc9RthoxQBEA/0luHOGNxKRv+roJ0=;
        b=Hk2hnmQo6hIL4iBOOfuILjzRewELmpnuGPhbpO2kLFa4APkg4m/vdr+ZPSW3oEN3N8
         du6d1AKabBo3fgqfu/Vm4ZlHFYdiqiu60P6fJ6dEePds/hqmAXz3drwIJrmq6dcitVDW
         OAuvUJyP6EQtDQPa4n292nkzz1nsWj0K5DOpYbEXo8ki7EWmrT1rnyYufO5tUHxnus3P
         sm7uL6doCwoFybzigSrJmiG05WBCwNtlL/v6hpKEFhU3sScfN/fmmwUx/Vax5SK7EJUC
         LTwN/xyM64YHe1S2u5K0u0L8e2JIsvNJTd6uWwbwIEi9HAIZJgI30tRiYk234LOFKOML
         ecEA==
X-Forwarded-Encrypted: i=1; AJvYcCWJX4XbfWDiFvf0uW0i3+415Gjy09BGPsHcGIeVuzQpBcIMIhySn1S+oIB8XQs2dZvXUKrxSN/4ZYj72UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1CuOzkSsMhkFWEHmvvM252M01dsLGfv1/EHkwgOj0VrqqYl3
	EA72pEBMmY5MH70yQRu4IdGFLfDQ9uFPJ9Y6r1WfccWGJRxayOixEqpfSdYRAHiOb3Wj4MZDtlr
	0pKhNejidQng1YR3ZOUonTKmqmOASGtd+QlVI5arV
X-Gm-Gg: ASbGncuMn+v6ghs+1kNIxIaaByEwlDS7zTNuQmy6QN18CiI/+KBfblpTcYo/cGCpPw7
	4m92MCEmrenJGumHz4cOBquxT3bJSgqAj+EYLBcGPaYYIgKsT3iWUWxQPoHkJS4ftBhZWA/w+nd
	4EygJfoeAxVvVU1cv0gAFW7MgoygeB6NaspjaR8IZABoSdK4CcF6hnl/fLIWG9ZHNjS9S4rnUIj
	zzn8IZotB1wKyPtzr4RMfFEHPKAaPki2hCCEzjHbZkOVXLDqjzW1hU=
X-Google-Smtp-Source: AGHT+IHoL0kcYp8Ehx0b6dmg0F6kenCMihXnIul6fIeeNituNRNhE09K8KPJqY1M8T6v2PhbX0XDD6ZFw6HCuLnM/HU=
X-Received: by 2002:a17:902:d2c5:b0:240:6076:20cd with SMTP id
 d9443c01a7336-25a7f1c8525mr9778055ad.15.1757610933279; Thu, 11 Sep 2025
 10:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com> <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
 <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com> <055e677e-2a2f-4c56-abe0-9a437dc14d69@linaro.org>
In-Reply-To: <055e677e-2a2f-4c56-abe0-9a437dc14d69@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Sep 2025 10:15:22 -0700
X-Gm-Features: Ac12FXzkvRE9Agk_U6Dg9wQhnAA_eljHGZMItsflVapQ1XoiLs_H5vpTnfGYKKo
Message-ID: <CAP-5=fUsZCz8Li1noKMODKXTLYFH9FsDCpXqCUxfu1h+s4c6Vw@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 6:00=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 10/09/2025 4:00 pm, Ian Rogers wrote:
> > On Wed, Sep 10, 2025 at 4:14=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> On 28/08/2025 9:59 pm, Ian Rogers wrote:
> >>> Mirroring similar work for software events in commit 6e9fa4131abb
> >>> ("perf parse-events: Remove non-json software events"). These changes
> >>> migrate the legacy hardware and cache events to json.  With no hard
> >>> coded legacy hardware or cache events the wild card, case
> >>> insensitivity, etc. is consistent for events. This does, however, mea=
n
> >>> events like cycles will wild card against all PMUs. A change doing th=
e
> >>> same was originally posted and merged from:
> >>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> >>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> >>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> >>> his dislike for the cycles behavior on ARM with perf record. Earlier
> >>> patches in this series make perf record event opening failures
> >>> non-fatal and hide the cycles event's failure to open on ARM in perf
> >>> record, so it is expected the behavior will now be transparent in per=
f
> >>> record on ARM. perf stat with a cycles event will wildcard open the
> >>> event on all PMUs.
> >>
> >> Hi Ian,
> >>
> >> Briefly testing perf record and perf stat seem to work now. i.e "perf
> >> record -e cycles" doesn't fail and just skips the uncore cycles event.
> >> And "perf stat" now includes the uncore cycles event which I think is
> >> harmless.
> >
> > Thanks for confirming this.
> >
> >> But there are a few perf test failures. For example "test event parsin=
g":
> >>
> >>     evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
> >>       misses,branch-misses}'
> >>     FAILED tests/parse-events.c:1589 wrong number of entries
> >>     Event test failure: test 57 '{cycles,cache-misses,branch-
> >>       misses}:e'running test 58 'cycles/name=3Dname/'
> >
> > I suspect the easiest fix for this is to change "cycles" to the
> > "cpu-cycles" legacy hardware event for this test. The test has always
> > had issues on ARM due to hardcoded expectations of the core PMU being
> > "cpu".
> >
> >> The tests "Perf time to TSC" and "Use a dummy software event to keep
> >> tracking" are using libperf to open the cycles event as a sampling eve=
nt
> >> which now fails. It seems like we've fixed Perf record to ignore this
> >> failure, but we didn't think about libperf until now.
> >
> > I'm not clear on the connection here. libperf doesn't do event parsing
> > and so there are no changes in tools/lib/perf. If a test has an
> > expectation that "cycles" is a core event, again we can change it to
> > "cpu-cycles" as a workaround for ARM. As "cycles" will wildcard now,
> > we don't want that behavior in say API probing as we'll end up never
> > lazily processing the PMUs. That code has been altered in these
> > changes to specify the core PMU. For tests it is less of an issue and
> > so the changes are more limited.
> >
> > Thanks,
> > Ian
>
> Sure makes sense if there's an easy fix for the tests, we can do that. I
> suppose the main reason I mentioned it was that the tests might be
> highlighting that other genuine non-Perf and non-test users would see
> the same breakage though.

For a non-perf user to see a perf change they must transitively depend
on perf to care. I think the complaint is that we've gone from 1 event
(ignoring BIG.little/hybrid) to possibly many, particularly on ARM.
What I'm thinking is we should have something like:

#if defined(__aarch64__) || defined(__arm__)
#define HW_CYCLES_STR "cpu-cycles"
#else
#define HW_CYCLES_STR "cycles"
#endif

and remove all use of just raw "cycles" in the code to use this
#define. This should avoid the >1 event issue on ARM in things like
tests. It does cause a new problem if the evsel->name is assumed to be
cycles, which is something that can happen a lot in shell scripts.
Perhaps all those use-cases should switch to specifying a PMU, which
would be a good thing performance wise to avoid scanning lots of PMUs.
I'll add somethings to v4 to do a mix of this.

Thanks,
Ian

