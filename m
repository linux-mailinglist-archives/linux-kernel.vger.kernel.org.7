Return-Path: <linux-kernel+bounces-707348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7584AEC2E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 01:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E9D4A77D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 23:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED822900A4;
	Fri, 27 Jun 2025 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsk3g/3Q"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387128D8C7
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751065876; cv=none; b=jLAgRRaVH6UKfPqC0DFOGj03jWUHG1Nynd0PWdMJ0sG9FPzk32jbI5SU2jnBpTjgq+JzOd2sr3euztfDshhhITeXs4evxfyj+DPHh+ygvKwxhCUVKHwQS4l9qQUDTn7CpLfH5E/EzXKTh95/bqRtaoR44cileAYJQ5HKM1nH2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751065876; c=relaxed/simple;
	bh=BAMzKo8cv7ru+aWsN4XS2dPIapPyqPMn5l1eLT4nrvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgpMZeeAfrO3ub0tOi5m5wYzUXpSSZ/F5Q3LBbkjLZNG1S9y0fj6pnIuJHXSkaVkXXUpUUZU/+JxcaJJD2oEzlkrPOS+if/19ClX/dMMSC+dTRLmVazUtTjsvM1YVPUgRFY55Fm7OLf0fUWH5jHJ3nknjgYghWSUKmvs7D2kZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsk3g/3Q; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so55305ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751065874; x=1751670674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r1k/4QEtOdvaCXklZVZbc3BxCMGTSAo6KfvEM+1WJU=;
        b=dsk3g/3Qk9BZULFQya3YSOtM+XYDZ+g/BeXxFnHZNpgUl5QthxMy6cQj9g6Jtcs8SS
         iiOG07mvRp3eVpxupK0VjOq46flaV/wBbdZiL7+XK+IOhMkdyCyDR3S3mVOtRan6IzlK
         BOcwZ75VzZyJVAh0ekozeV7opO7XFDUGwr1E6gOB8odw/kqzfAjt7rQuLB2Dhc5HgzTL
         8bPwc32nZZvXo/Jyrfakoq5KpDMGnycW6QnjDCLRTrwlrqd9caLSQadG1un7BuRFZxou
         0zrsSe82XkAUok7g12MXaLDDJnAsa7H4ZHu8KhIspyeUWmxYDY2EMkqNB4fxaDWljNqD
         PPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751065874; x=1751670674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r1k/4QEtOdvaCXklZVZbc3BxCMGTSAo6KfvEM+1WJU=;
        b=nSDkTadKrh7P8KT/geAqiO6f0DagkV/1T8giHp9JZjlDMMzXrjJxmsKquN9LWiJ6uf
         1ZecOZDjkSr6Fd453ojI4EfuPROkiiONojEkg0l/Jk4RKqF3X543Pbv6J9pOCdiT8jcX
         KN/ok+JFnE9jQzX0RDTL3joGUbBaxuYOFZQ3Xp/Qr3oI4vZakxNgf8U7rr3+cQ2sWg/A
         RulDrfuPpxrzP+oVvt8l3Eyfspq1KterV4PHZj0pJfThSuTT+wjN17xGklVjeOjQkdFH
         sjMp0mqxk9/+qyTDyx0/qve4DtYpfYB58Dby3s0cqNPEabHgTSHrurgEy8q/nm0tNejK
         QEQw==
X-Forwarded-Encrypted: i=1; AJvYcCVZQgqlWhAYfhZ7PwhwzxIOUEDxkljD4qAIMqAKvtqTR5jLtMYIG7j0UsoWCKkDXYv9pjGB4pMAU9QhwEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhdslncG9kKEXf4BZDDy4a9c4VpZngyNq8ASx57QSUO1mEsKc
	h3z1WLoWqEbN8Ge5rSWkdqkG0HnPiBa9IEa5t1GOAV5CrpTo6sYoc1tJUfMLjLstguOZeZ4uHYZ
	azjIdmMynPhPXUrMb5BVcs7uyx7ihg02h0pPeswI8
X-Gm-Gg: ASbGnctif8gVJ35rRYqeL5yRrVCe9ewR9rnaLv0d8pK2wwAWW3ky38euyL65O0v75di
	0AXExGThRkfku99LWHMzrnrvxrqz9ualYq+9KrSAXcbMEf6/QqsfHT2gERB5tBDcCRiRthha0vI
	ctSsqRMgespwyID3o2flCCpkvqQnd80iAOvsqSbqnWDNSc
X-Google-Smtp-Source: AGHT+IHOrtjjnavLeFmnxRzUKctDiOqRlZqpa3B6VBvWXIZQMbA5CqO1kSxXEHqdcMJotrOKU1tEB580gSfXEF5bIO4=
X-Received: by 2002:a05:6e02:11:b0:3dd:b59b:8da5 with SMTP id
 e9e14a558f8ab-3df55381c7amr1542175ab.0.1751065873440; Fri, 27 Jun 2025
 16:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com> <20250417230740.86048-7-irogers@google.com>
 <aF3Vd0C-7jqZwz91@google.com> <CAP-5=fV4x0q7YdeYJd6GAHXd48Qochpa-+jq5jsRJWK36v7rSA@mail.gmail.com>
 <CAP-5=fXLUO3yvSmM4nSnNV_qQGGLP_XTcfPgOhgOkuaNnr3Hvw@mail.gmail.com> <aF7wesWHTv_Wp-8y@google.com>
In-Reply-To: <aF7wesWHTv_Wp-8y@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Jun 2025 16:11:02 -0700
X-Gm-Features: Ac12FXyr3ntBENxGcNDQ5WuQEl_ZSKMbc68-z87tHPtttLtfqAEggfiOqd6-r3s
Message-ID: <CAP-5=fU+t=pB1TmE5DBGphaunZLCdGnRtHdxy3suCQMhxFjOiQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] perf capstone: Support for dlopen-ing libcapstone.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 12:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Fri, Jun 27, 2025 at 09:44:02AM -0700, Ian Rogers wrote:
> > On Thu, Jun 26, 2025 at 9:53=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > On Thu, Jun 26, 2025 at 4:19=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > On Thu, Apr 17, 2025 at 04:07:27PM -0700, Ian Rogers wrote:
> > > > > If perf wasn't built against libcapstone, no HAVE_LIBCAPSTONE_SUP=
PORT,
> > > > > support dlopen-ing libcapstone.so and then calling the necessary
> > > > > functions by looking them up using dlsym. Reverse engineer the ty=
pes
> > > > > in the API using pahole, adding only what's used in the perf code=
 or
> > > > > necessary for the sake of struct size and alignment.
> > > >
> > > > I still think it's simpler to require capstone headers at build tim=
e and
> > > > add LIBCAPSTONE_DYNAMIC=3D1 or something to support dlopen.
> > >
> > > I agree, having a header file avoids the need to declare the header
> > > file values. This is simpler. Can we make the build require
> > > libcapstone and libLLVM in the same way that libtraceevent is
> > > required? That is you have to explicitly build with NO_LIBTRACEEVENT=
=3D1
> > > to get a no libtraceevent build to succeed. If we don't do this then
> > > having LIBCAPSTONE_DYNAMIC will most likely be an unused option and
> > > not worth carrying in the code base, I think that's sad. If we requir=
e
> > > the libraries I don't like the idea of people arguing, "why do I need
> > > to install libcapstone and libLLVM just to get the kernel/perf to
> > > build now?" The non-simple, but still not very complex, approach take=
n
> > > here was taken as a compromise to get the best result (a perf that
> > > gets faster, BPF support, .. when libraries are available without
> > > explicitly depending on them) while trying not to offend kernel
> > > developers who are often trying to build on minimal systems.
> >
> > Fwiw, a situation that I think is analogous (and was playing on my
> > mind while writing the code) is that we don't require python to build
> > perf and carry around empty-pmu-events.c:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/empty-pmu-events.c?h=3Dperf-tools-next
> > It would be simpler (in the code base and in general) to require
> > everyone building perf to have python.
> > Having python on a system seems less of a stretch than requiring
> > libcapstone and libLLVM.
> >
> > If we keep the existing build approach, optional capstone and libLLVM
> > by detecting it as a feature, then just linking against the libraries
> > is natural. Someone would need to know they care about optionality and
> > enable LIBCAPSTONE_DYNAMIC=3D1. An average build where the libraries
> > weren't present would lose the libcapstone and libLLVM support. We
> > could warn about this situation but some people are upset about build
> > warnings, and if we do warn we could be pushing people into just
> > linking against libcapstone and libLLVM which seems like we'll fall
> > foul of the, "perf has too many library dependencies," complaint. We
> > could warn about linking against libraries when there is a _DYNAMIC
> > alternative like this available, but again people don't like build
> > warnings and they could legitimately want to link against libcapstone
> > or libLLVM.
> >
> > Anyway, that's why I ended up with the code in this state, to best try
> > to play off all the different compromises and complaints that have
> > been dealt with in the past.
>
> I can see your point.  Adding new build flags is likely to be unused and
> forgotten.

There's also more code to support the neither linked or nor dlopened approa=
ch.

> But I also think is that this dlopen support is mostly useful to distro
> package managers who want to support more flexible environment and
> regular dynamic linking is preferred to local builds over dlopen.  Then
> adding a note to a pull request and contacting them directly (if needed)
> might work?

If you want to run with this then I don't mind.

Thanks,
Ian

> Thanks,
> Namhyung
>

