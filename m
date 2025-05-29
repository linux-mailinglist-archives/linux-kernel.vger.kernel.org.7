Return-Path: <linux-kernel+bounces-666255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFBAC7454
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 01:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC1A502966
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 23:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AC2221FA8;
	Wed, 28 May 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lJrmayNU"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48A207A20
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748473887; cv=none; b=GF/UvQ4s3KJIOEelK2WGOT9Mmexs8qE7et3BM+dXH/7835/uWuJT4mPdryOpr7TFB5gtwV/njJy5nkIzamqRgjznh3uipjgZjIbf4hpam+S5RADqin8qyWJPHeBh0edudMUfsC7F6k5AGrI7ScH2w3SiQuzLa6s6VZj52Gdq324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748473887; c=relaxed/simple;
	bh=5kskNdbmd1wbRPsnBB9OjSRJEFOXvFCXuGgfnm1cLRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9lZI+szXa/D/t/3yxCalNDbD0ccM4RSlhXDudcPTbBHTbgfwQInNga8eVGidsMuzB2Ts/kvZWRIzJpwdmuCFr4CZG32nCuFQvkwTfGlrnMjEq2thaFTHSoJG7g9cQgMZTLGUhuKln7lCxlDbxq0VuvRz0AJVi3VH1kN4tAOfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lJrmayNU; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dd89a85414so81975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748473884; x=1749078684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7TN5QXJhRSmfoM9Tpxod/qjmd6b/yxgCZaGEbMSEqQ=;
        b=lJrmayNUwI4B9XoW2GA4RluWFKBEcpold3+664rgEoLkrXDsSOlONc8FyCJp7pD2Lf
         Z9sL01KS9x61bfuhz5pVwADkp9TUeEI/XSuwNuODzrpHbIFyJxWfBMxlVPQsmgPSefLF
         b1KLTIuycV0EKjgCU4S1l3YImNWSWYeogSeauQ922VHOVyee9kPNQBndKQK+WHT84b0I
         kJuJUS7Fxp5FRFaRMc5LzF/+nvdBnMPJcZVqYO6OVGoYDymjYburjycxUVbwqtawpTMF
         6lvjcirF3koekUICdhzT0a9vMX14yaJ5zxD7OxdCh2caUJLVIYiKuI/850gzKAxGcG3z
         p8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748473884; x=1749078684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7TN5QXJhRSmfoM9Tpxod/qjmd6b/yxgCZaGEbMSEqQ=;
        b=LIEXPNXu3VgNy7Yni/g4pjs/J9OZF553hErb0mflH1rhXnZ/dwNzFNxjTx3WCdjWJp
         Iu9PEUeDChXfWTh1b8N4H814GJegqDGmMwb2DB5R9MA2MPkhAg8+MXF5gMWxqvMNp2Vv
         QSjnu77vM/aEQe9rkLBf2uXCX9Z+u9jdJWKd93AvVfACIxFvvmIp1U2xXO4TTCPN8xZB
         elFODW0sGWdJrG5lWl4IngwAIR3gXmgWjdG9FxrJmKhMqqi9KAsYhIhcxPhyr89KE1A9
         5Mhy/JoBWwObO9XTPV/IyBa0Nwfk3DX9R5hxRNjDHZamMNxqPXr2r9TWAS5CnTvA+lXk
         JiTA==
X-Forwarded-Encrypted: i=1; AJvYcCUeE2Jrc5Kyr9NtWkByEMpMPWExp6RDiWKgDbh16QiDl22K8PyJYJuWO57IE8H0znChtmF1gScVpaeXCoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPvr2SxDU4C9g4ZpOT7J5htjFss0XQoU5rQjDVBBlPiGa9TLv
	9KOCkrk8+Owctszhj1AykSJHe4HXyXihEZMIi/ZrHbOw8kjZ/cWC+zuU1Tnc4tQ02LU24Fod4rV
	VrbdEninHbIQ/bSMWNFs1zUn0L/F1+0EREkFfOd6t
X-Gm-Gg: ASbGncuy0tYlTl9kDsPJNdlcoEJN/FNg0HBJXdbDzf06R5mfA3Tbt22LFDaBlL8BsoW
	Q/ujsxMFwQzsRpvbLb8hmPBgkfk1cvljug+IUlRMinyOKrEno2ltkEEOf9PJFihugwPNA4kxqO8
	gbAvqCclZF92SeZMJ5zG2G5FWvLMuU3PTkgQWffzWJrTp6LDvX/1HAfEFAF7Y0RTiWZzSn015E
X-Google-Smtp-Source: AGHT+IGom8NrER1VE/kdfIaohwcyFm+hEoJj2YT3ebrUwFisS6NlVU5jYbwNmrwrJXLRXub0bv+so2t3+K4ZboOFJXg=
X-Received: by 2002:a05:6e02:1a83:b0:3db:831e:1bc3 with SMTP id
 e9e14a558f8ab-3dd9315c1dcmr544235ab.23.1748473884301; Wed, 28 May 2025
 16:11:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com> <20250428213409.1417584-6-irogers@google.com>
 <aDd06eK7fKFsFsVS@google.com> <CAP-5=fV-cLLpdyoqL8+Jrt3iYU7EbpZZDOyM1kBCc+54gA2Nzg@mail.gmail.com>
 <aDeLLvBVQnQqJT4b@google.com>
In-Reply-To: <aDeLLvBVQnQqJT4b@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 16:11:13 -0700
X-Gm-Features: AX0GCFufqlmUjrJuC0NBNqF7z_kwH0km2z1g4J15ITd67IMLnpSSJlAZbK8v7Ds
Message-ID: <CAP-5=fWJMFYBtwPeH8DhzUG2jbjJ865sLojDtEc1+HDQZdpPoA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] perf build-id: Mark DSO in sample callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	James Clark <james.clark@linaro.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 3:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, May 28, 2025 at 01:54:41PM -0700, Ian Rogers wrote:
> > On Wed, May 28, 2025 at 1:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Apr 28, 2025 at 02:34:04PM -0700, Ian Rogers wrote:
> > > > Previously only the sample IP's map DSO would be marked hit for the
> > > > purposes of populating the build ID cache. Walk the call chain to m=
ark
> > > > all IPs and DSOs.
> > >
> > > I think this is correct, but I'm afraid it'd also increase the proces=
sing
> > > time.  Do you happen to have any numbers?
> >
> > It increases time spent processing the data file but to get a large
> > data file I had to run for multiple seconds and I struggled to get the
> > performance cost of this to be in the milliseconds (ie a tiny fraction
> > of the record time). Ultimately I found the change imperceptible and
> > couldn't think of a good command line to make it perceptible.
>
> The worst case would be dwarf unwinding.  Maybe we can skip the
> processing if it takes too long..

This doesn't sound unreasonable but is somewhat beyond the scope of
what I wanted to do here, which relates to migrating from inodes to
buildids as identifiers for DSOs. It would be useful to get a bug
report on this being too slow.

> >
> > If the time is spent populating ~/.debug because more DSOs are marked
> > then this is fixing a bug and isn't a problem with the patch.
>
> Right, it's a good thing.
>
> >
> > My personal opinion is that it is somewhat surprising `perf record` is
> > post-processing the perf.data file at all, and -B and -N would be my
> > expected defaults - just as --buildid-mmap implies --no-buildid (-B).
>
> Otherwise nobody will run perf buildid-cache to add the info. :)

Right, but we know it is high overhead as we run a number of tests with -B:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record_sideband.sh?h=3Dperf-tools-next#n25
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/test_arm_spe.sh?h=3Dperf-tools-next#n94

I agree that populating the buildid cache immediately after perf
record minimizes a gap where DSOs may change prior to perf report. If
the DSO changes midway through perf record it doesn't help as the
buildid information is only computed at the end of perf record.

Isn't there an argument that because we have build IDs we don't care
about the record to report race any more as debuginfod can find the
prior version by means of the build ID? What I mean:

Current perf default way:
1) Run perf record with mmap2 inode rather the buildid data
1.1) To avoid any DSOs in the perf.data from not being available
populate the buildid header in the perf.data and the buildid cache at
the end of perf record
2) Replace some DSO that's got a sample in the perf.data with a different D=
SO
3) Run perf report
3.1) The DSO's buildid is known via the header and the buildid cache
already contains the DSO

Current way with -N:
1) Run perf record with mmap2 inode rather the buildid data
1.1) To ensure DSOs have buildid data populate the buildid header in
the perf.data  at the end of perf record
2) Replace some DSO that's got a sample in the perf.data with a different D=
SO
3) Run perf report
3.1) The DSO's buildid is known via the header, debuginfod can
populate the buildid cache as needed

With --buildid-mmap:
1) Run perf record with mmap2 buildid data
1.1) No need to post process file to gather buildids
2) Replace some DSO that's got a sample in the perf.data with a different D=
SO
3) Run perf report
3.1) The DSO's buildid is known via the mmap2 events, debuginfod can
populate the buildid cache as needed

With the current way and the current way with -N there is a race with
the DSO changing midway through perf record. The buildid mmap closes
the race.
With -N and --buildid-mmap the buildid cache is populated based on use
by a tool trying to read the DSO, rather than ahead of time at the end
of perf record.

Is the risk of the race that much of an issue? I'm not sure, that's
why I'd say default to using -B (if we didn't switch to buildid mmaps
by default, but this series does that). You could opt into to covering
the race by adding a flag so the data is processed at the end of perf
record. You could use perf inject to add the build IDs.

As you say there's the cost at the end of perf record and I'm not sure
it is worth it, which is why I'd expect the default to be to opt into
having the cost. With --buildid-mmap I'm not seeing a race to cover
but this series populates the buildid cache as I know you've argued
that perf record should do this by default.

Thanks,
Ian

> > I didn't want to modify existing behaviors in these changes, however,
> > in this case I was just trying to make the existing behavior correct,
> > similar to fixing the same bug in `perf inject`.
>
> Thanks for your work,
> Namhyung
>

