Return-Path: <linux-kernel+bounces-650220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9725AB8EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 20:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C927ABAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727325C70D;
	Thu, 15 May 2025 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPMh+X0M"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8213E25B697
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333225; cv=none; b=crytt/WccdZ3HohmXbgPPExAG83vZN99MiGsFMS8RUmP9tk9QcG/QxsoWL8Q8665OTnsiuXQ15qDJOb08Rf05MbPdb2NsnSmi1HK3xoql5QR3PpuKEsLKraQWJvGLrTTTtp5/nc3FMlguUxslAKRkpla8glbSgR8qFWIcSYTbzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333225; c=relaxed/simple;
	bh=OFQJFxNEJqELWJaBN8ZVm02CI2xaoxqAGDZdrfqhTII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brZmZuLspSld0QyNCC6v/D0mjVHRYxpZNNoI64GaE8BfP94tJFLwTmd7yvavIhrK93Pi982Qiu+aWE26crhevZZkjlvmTP2h3ND0IB1WGc7UZqf8XQcvHeRFGS27eTCKxopqhCMpt2z1YZ024vIAYw7vKsMDlF//CA1DFdtVZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPMh+X0M; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3da73d35c11so14915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747333222; x=1747938022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O63afm2VlIQSQza7BQRIQ/xdhW0az9PDJoewqUEykng=;
        b=XPMh+X0M1f7nJarUW9bgqZh+OIjpwpXY5/HunbmqJCc8NsY4IYGe5NzwXRa4rIpDe/
         wcAOje8nWRhHS1aXEgLpfpMPeghUkPfar5F0FGIfAC843FBhisglIUX/jiclH/qaMiMW
         z0aqmrIEOpl9ieBfjyd4G6D1UNaynEvO+zJNusS644OhCcZVyEUKSlkr+61mRt7n1+wj
         8eqV/mlLc4nbKR52/gIIJOUHqGTZZx+NrMr/KNgWeQIHV0pQJu4AG/ngvuj4/NHVtf/q
         fmtMp8aRem8rGscS5hFSkIfJ0SVFTHnKW56Pe+IhvL3/UTupWosqs7O5cMffTD3JmbrW
         NrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333222; x=1747938022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O63afm2VlIQSQza7BQRIQ/xdhW0az9PDJoewqUEykng=;
        b=gqJJTS/cHLT5H0xCwlXjrKEqTWOY0DTM/6dlEkq29hYJSLLWSsU3p9uJH1Y9qQCwa4
         c4RE0YFxpLQc0LZVGGSBTMx3xC6q5yHDUgjG8E0Oqdes2ifgKhGc6mEssqiQ6qOsqlET
         wLC/DadhbJ9DBX12C9rd7YU5+qFykRErb4MC+QMeAIC/Vgmy7NejdkZhppnDt2CrjSqN
         Lc8AIRfYqsT0h53b9OXwPhP2nrmADcbSvYLbzsT4pVyBkyI3tpcUARVMhnf84DYaw/zh
         pPJVc27d8bifYi/bi0GQh0L+ys+6tggakJHr/1hsx4VPLp6g8JhuzHMOte4eMJ/jgVSP
         ds+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZxEnYOVhLykB2C+Hh/IPzwhidVlHQRdmMSnluZn3rgNbvMW7KTDvE5/AdGPPkLGCk8KtNIYEJThmOVRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbmG56/YE+3qk+HXyORYFd5Q0M6EZ1xYCMi2QDd72tuoyx+DsK
	FUcp/FedE6oTtOvn39lWr2E8OyZ2yNlJvg22oA8nBq/GSRFt6rNfqBj0ZbHKTz5IelVBV5SHTBY
	NGDbFVfwQw68ugheXbrVetgbXC37lnvDhbHWnV3Rf
X-Gm-Gg: ASbGncsSkON+kFRbr6oHPzE+LJejtN6ZuKHBpENEwqLmktQRTHBo1KD6JRJNNjd4/nu
	S+a2ZwCcPjaXBEDGOuWaVSVnYRX7tyIh9+omGoTgt6q2crtIMUnbfmWKMozAx7qu/PdS09EVMQx
	2voxhWRmXQTqB7fvtfWAM01ZXEhLn3p7h9r/2Skdqk6rCCBj0r4PrCD3kat4yeu0DbuMh2Xkbq
X-Google-Smtp-Source: AGHT+IHxywpS3vYTcikvJFkskiAkXcjtoKimej+IX3453AjHRldxM8Iu/0iE5TCAiDL7Ohn6Vyr2bCnr89AIycM2SlY=
X-Received: by 2002:a05:6e02:3399:b0:3d9:6e55:2aae with SMTP id
 e9e14a558f8ab-3db77f13930mr5539735ab.0.1747333222382; Thu, 15 May 2025
 11:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515043818.236807-1-irogers@google.com> <aCYTG12gSmv0OtXN@x1>
 <aCYTaveeziFiF3kw@x1> <CAP-5=fWBdCVSM_QLcLJ66g+LC0ykrJbZA6mQUsH_++xLormFzQ@mail.gmail.com>
 <aCYv9KBA0fYlT143@x1>
In-Reply-To: <aCYv9KBA0fYlT143@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 May 2025 11:20:10 -0700
X-Gm-Features: AX0GCFvn9tLQx10HojBrW8CVpvMI5SDjtSE51P_ZxB_B3dIPMWecGGXiaF440uE
Message-ID: <CAP-5=fX2UfyCLwxDzvt=xy_2yA9-450x0gGVebrhzXwWH4-b7g@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA clusters
 on graniterapids
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Weilin Wang <weilin.wang@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 11:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, May 15, 2025 at 10:02:44AM -0700, Ian Rogers wrote:
> > On Thu, May 15, 2025 at 9:16=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, May 15, 2025 at 01:15:26PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > > On Wed, May 14, 2025 at 09:38:18PM -0700, Ian Rogers wrote:
> > > > > On graniterapids the cache home agent (CHA) and memory controller
> > > > > (IMC) PMUs all have their cpumask set to per-socket information. =
In
> > > > > order for per NUMA node aggregation to work correctly the PMUs cp=
umask
> > > > > needs to be set to CPUs for the relevant sub-NUMA grouping.
> > > >
> > > > I'm blindly applying it as I can't test these changes, and I think =
this
> > > > is bad.
> > >
> > > In the end the only review/action I could do was to turn:
> > >
> > > Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumaks for sub-NUMA c=
lusters
> > >
> > > Into:
> > >
> > > Subject: Re: [PATCH v1] perf pmu intel: Adjust cpumasks for sub-NUMA =
clusters
> > >
> > > :-(
> > >
> > > Besides the build tests, etc.
> >
> > It isn't the easiest to test. Let me add Weilin Wang on v3 as I think
> > she has a graniterapids and could hopefully provide a tested-by tag
> > :-)
>
> But, one more review action, will wait for v2:
>
>          make_refcnt_check_O: cd . && make EXTRA_CFLAGS=3D-DREFCNT_CHECKI=
NG=3D1 FEATURES_DUMP=3D/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST=
_FEATURE_DUMP -j32 O=3D/tmp/tmp.HAAu6nXJ16 DESTDIR=3D/tmp/tmp.NpycD5uTsi
> cd . && make EXTRA_CFLAGS=3D-DREFCNT_CHECKING=3D1 FEATURES_DUMP=3D/home/a=
cme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=3D/tmp/tm=
p.HAAu6nXJ16 DESTDIR=3D/tmp/tmp.NpycD5uTsi
>   BUILD:   Doing 'make -j32' parallel build
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi=
/linux/vhost.h
> Makefile.config:968: No libllvm 13+ found, slower source file resolution,=
 please install llvm-devel/llvm-dev
> Makefile.config:1147: No openjdk development package found, please instal=
l JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>
>   GEN     /tmp/tmp.HAAu6nXJ16/common-cmds.h
> <SNIP>
>   CC      /tmp/tmp.HAAu6nXJ16/arch/x86/util/pmu.o
>   TEST    /tmp/tmp.HAAu6nXJ16/pmu-events/empty-pmu-events.log
>   GEN     /tmp/tmp.HAAu6nXJ16/pmu-events/pmu-events.c
>   CC      /tmp/tmp.HAAu6nXJ16/arch/x86/tests/hybrid.o
>   CC      /tmp/tmp.HAAu6nXJ16/arch/x86/tests/intel-pt-test.o
>   CC      /tmp/tmp.HAAu6nXJ16/util/block-info.o
>   CC      /tmp/tmp.HAAu6nXJ16/util/block-range.o
>   CC      /tmp/tmp.HAAu6nXJ16/util/build-id.o
>   CC      /tmp/tmp.HAAu6nXJ16/tests/pmu.o
>   MKDIR   /tmp/tmp.HAAu6nXJ16/ui/browsers/
>   CC      /tmp/tmp.HAAu6nXJ16/ui/browsers/annotate-data.o
>   CC      /tmp/tmp.HAAu6nXJ16/bench/futex-wake.o
>   CC      /tmp/tmp.HAAu6nXJ16/arch/x86/util/kvm-stat.o
>   CC      /tmp/tmp.HAAu6nXJ16/builtin-help.o
>   MKDIR   /tmp/tmp.HAAu6nXJ16/ui/tui/
>   MKDIR   /tmp/tmp.HAAu6nXJ16/ui/tui/
>   CC      /tmp/tmp.HAAu6nXJ16/ui/tui/setup.o
>   CC      /tmp/tmp.HAAu6nXJ16/ui/browsers/hists.o
>   CC      /tmp/tmp.HAAu6nXJ16/ui/tui/util.o
> arch/x86/util/pmu.c: In function =E2=80=98gnr_uncore_cha_imc_adjust_cpuma=
sk_for_snc=E2=80=99:
> arch/x86/util/pmu.c:249:42: error: =E2=80=98struct perf_cpu_map=E2=80=99 =
has no member named =E2=80=98map=E2=80=99
>   249 |                         adjusted[pmu_snc]->map[idx].cpu =3D cpu.c=
pu + cpu_adjust;
>       |                                          ^~
>   CC      /tmp/tmp.HAAu6nXJ16/builtin-buildid-list.o
> make[8]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:8=
6: /tmp/tmp.HAAu6nXJ16/arch/x86/util/pmu.o] Error 1
> make[8]: *** Waiting for unfinished jobs....
>   CC      /tmp/tmp.HAAu6nXJ16/arch/x86/tests/bp-modify.o
>   LD      /tmp/tmp.HAAu6nXJ16/scripts/python/Perf-Trace-Util/perf-util-in=
.o
>

Yep asan/refcnt checker was fixed in v2. I just sent v3 to hopefully
address Kan's feedback:
https://lore.kernel.org/lkml/20250515181417.491401-1-irogers@google.com/

Thanks,
Ian

