Return-Path: <linux-kernel+bounces-874153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FF2C15A24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C9D402402
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493DD345729;
	Tue, 28 Oct 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjEJfIzE"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48801340DAD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666650; cv=none; b=Nv9tv5jNF61ny9Jh17K0WK6hbO7r4Gyzai+q8Qj1FW83XzEQiFZ0E02hHyRGNkK3KSb2sGLMZHSsGybpRHVV3FjIbRHENCpEMNQmEq4lNc3zvZ1JKzCtIv1CotIhj8MOz/1aLTH7R50bYnULtSOZpZX7SmRJN6R0YPgOndickAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666650; c=relaxed/simple;
	bh=88Ig5SXzU0xfjbOiEco5NUjBioGuul5y6y7ZMnbc5JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjE9a+iv7p/xnkWf4/+NAmalrMz3QyFVWaY+Ym/fCZfiDA7pTH7oM6sDjTbnMls/BkDQH1K3yxBBGetanKqwAebLcJUNUN74n4AmuERRL7ziSen1JepiwthQbQpw5GngP5R+N+6Qji5QVlv+ehBawSShmtDEKCWHWSUrKEOXVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjEJfIzE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d67abd215so225385ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761666647; x=1762271447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBglozy/5pSdV0Z07/LiZrYZajL6P3fbq97wLRGjYCc=;
        b=jjEJfIzERRq1Nn6revit9YQOPx1f3ZphwJRLluKcT5nuWqDzpmvpm3rikgvalNS7wM
         djv8C+RQXdpYy+RIM/Fooyp8Iu5WzaZK9kAaWAAScfZtOlOh1+KZhWrTummX9FV+nEhI
         giKA4ab3iHWMCGn1Kxt9UPu/CeJ/kppmtM39YFXGH6ChB0Y+QJoIA6Z3BQXFXYckCgwA
         PdvF0lQMShah4PC5BI41NnOGt26a8bi6o6kB9u4F4DsmHzQwvhxYgAI8JRy7LohLj1Pa
         N8f8sY0pqHJ+6WgvlnxTc+YponIulO1mag9yqf47yyyR4Gl6Mm/bSFORI2skYLxVQ3s/
         NhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666647; x=1762271447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBglozy/5pSdV0Z07/LiZrYZajL6P3fbq97wLRGjYCc=;
        b=ClkOkkmY3zM9NTbLI7XgnxFjsTe0n4TjxImAANi4BhWv57laF5dnOu2VMTaHFrxnlC
         O9aRzFm7h4UN7JExhb9O3b3lDhUe9QfR2Q3zYr4jioQInpagJj/hqbHa3vhdNOe0vNBB
         xlQ4B+qIK1YG/JiNyYHWDPfx50yHrZHApPrpaC9AZzAkvwnNccSAiMjgwBktj0aLviK0
         lqE2hEfDhhe8EbC9bDCc0HqHAFx2xbFnHWUV5oay7hR2/RUglWVsVxtp6Dr/j6qfxTJ9
         r2GA3ZXp73NGCeE4R27IDlCitu7Q6PC9m4WK7ISLE5MGUF5A+6/wAY2um2246wgduSxo
         dJxg==
X-Forwarded-Encrypted: i=1; AJvYcCVp7x6v7UEDu/7ORPgHrJZds4F64LJrR8YGgtykSjgHknB4704cMafZwwmRzwHudoT7GNI0ap3umI0IUxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBOOqcRq4DQ33+R3GBvDmTXm8rP7tJpUiDvM98JErmOteEMm67
	MjpPbi/rrp1jID8Pkt+nwNvEQfU6g8okKZOFWPDj2Ex8yLr2EHuFgGgh+V3kh4VK2UfiY5iRDqo
	Xli+JmQ3teDL0HTeW0OBPO+Z+HCIwVujvryuXnAxe
X-Gm-Gg: ASbGncsqssrI0qGprRSKhyJNKVVCPCtcdhtp9EpNNY/5kIkGZfwhlQPXt4gNkXcQdzx
	37cUp6BMCRnKM2g88C4/7pFMA6Lw2uHXIUwO4FmoIpdtvVty/GxYGYK4Gqq4/QBYcFeOCR9ZMYF
	g53o0tW8gow7y1vZIlp3sXB+CTMmoqD20blVEGZdSr2BxY5qHPuchT9dTqdPJrdobum9nX454R/
	KEBjQjzz1tiqcRTikV4i4m9GcP6I0J/EXm8TUCakCvQp7Zf9xCfiOsXEIV8pkwiJLwKniJr5RNn
	LRxb9gXVPRJrQ99UZDGPZSgD2g==
X-Google-Smtp-Source: AGHT+IE6+h4Um8smZPkUD2SrL3DzIVBc6xR+scPeuMDSNyFFIqzvO2ieUSv3BlwJX7cNWMs0IAObw1WEuJUpgo21hGE=
X-Received: by 2002:a17:902:e749:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-294ccb420dcmr5216975ad.12.1761666646899; Tue, 28 Oct 2025
 08:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
 <aP1kSdZJKYIpnRia@google.com> <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
 <17f00d4d-5cbf-4c9c-a51a-f0ae34f181cf@linaro.org> <CAP-5=fV-g1CeJCoEnNnz_eFsks01JyUR3Fxz_H0X_rdTzOGuAw@mail.gmail.com>
 <643e2956-2ddb-45a8-9c8f-c77a73bac4d2@linaro.org>
In-Reply-To: <643e2956-2ddb-45a8-9c8f-c77a73bac4d2@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Oct 2025 08:50:34 -0700
X-Gm-Features: AWmQ_bn5rWRzDfdJU0npvQcZTGM7YZuQEfW3GS4xstr8ijH2c6oHqlg3HEw7Uys
Message-ID: <CAP-5=fXvyv17hHkyovys4XPNuEu1gZ9L2in6DOgd+PBPpGx=9A@mail.gmail.com>
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:26=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 28/10/2025 3:07 pm, Ian Rogers wrote:
> > On Tue, Oct 28, 2025 at 3:33=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> On 26/10/2025 4:52 am, Ian Rogers wrote:
> >>> On Sat, Oct 25, 2025 at 4:59=E2=80=AFPM Namhyung Kim <namhyung@kernel=
.org> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
> >>>>> On Wed, Oct 22, 2025 at 8:46=E2=80=AFAM James Clark <james.clark@li=
naro.org> wrote:
> >>>>>>
> >>>>>> The following command will hang consistently when the GPU is being=
 used
> >>>>>> due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2=
)
> >>>>>> being opened to read build IDs:
> >>>>>>
> >>>>>>    $ perf record -asdg -e cpu-clock -- true
> >>>>>>
> >>>>>> Change to non blocking reads to avoid the hang here:
> >>>>>>
> >>>>>>     #0  __libc_pread64 (offset=3D<optimised out>, count=3D0, buf=
=3D0x7fffffffa4a0, fd=3D237) at ../sysdeps/unix/sysv/linux/pread64.c:25
> >>>>>>     #1  __libc_pread64 (fd=3D237, buf=3D0x7fffffffa4a0, count=3D0,=
 offset=3D0) at ../sysdeps/unix/sysv/linux/pread64.c:23
> >>>>>>     #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
> >>>>>>     #3  read_build_id (filename=3D0x5555562df333 "/dev/dri/card2",=
 bid=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:880
> >>>>>>     #4  filename__read_build_id (filename=3D0x5555562df333 "/dev/d=
ri/card2", bid=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:924
> >>>>>>     #5  dsos__read_build_ids_cb (dso=3D0x5555562df1d0, data=3D0x7f=
ffffffb750) at util/dsos.c:84
> >>>>>>     #6  __dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x555555=
7e7030 <dsos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:59
> >>>>>>     #7  dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e=
7030 <dsos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:503
> >>>>>>     #8  dsos__read_build_ids (dsos=3D0x55555623de68, with_hits=3Dt=
rue) at util/dsos.c:107
> >>>>>>     #9  machine__read_build_ids (machine=3D0x55555623da58, with_hi=
ts=3Dtrue) at util/build-id.c:950
> >>>>>>     #10 perf_session__read_build_ids (session=3D0x55555623d840, wi=
th_hits=3Dtrue) at util/build-id.c:956
> >>>>>>     #11 write_build_id (ff=3D0x7fffffffb958, evlist=3D0x5555562323=
d0) at util/header.c:327
> >>>>>>     #12 do_write_feat (ff=3D0x7fffffffb958, type=3D2, p=3D0x7fffff=
ffb950, evlist=3D0x5555562323d0, fc=3D0x0) at util/header.c:3588
> >>>>>>     #13 perf_header__adds_write (header=3D0x55555623d840, evlist=
=3D0x5555562323d0, fd=3D3, fc=3D0x0) at util/header.c:3632
> >>>>>>     #14 perf_session__do_write_header (session=3D0x55555623d840, e=
vlist=3D0x5555562323d0, fd=3D3, at_exit=3Dtrue, fc=3D0x0, write_attrs_after=
_data=3Dfalse) at util/header.c:3756
> >>>>>>     #15 perf_session__write_header (session=3D0x55555623d840, evli=
st=3D0x5555562323d0, fd=3D3, at_exit=3Dtrue) at util/header.c:3796
> >>>>>>     #16 record__finish_output (rec=3D0x5555561838d8 <record>) at b=
uiltin-record.c:1899
> >>>>>>     #17 __cmd_record (rec=3D0x5555561838d8 <record>, argc=3D2, arg=
v=3D0x7fffffffe320) at builtin-record.c:2967
> >>>>>>     #18 cmd_record (argc=3D2, argv=3D0x7fffffffe320) at builtin-re=
cord.c:4453
> >>>>>>     #19 run_builtin (p=3D0x55555618cbb0 <commands+288>, argc=3D9, =
argv=3D0x7fffffffe320) at perf.c:349
> >>>>>>     #20 handle_internal_command (argc=3D9, argv=3D0x7fffffffe320) =
at perf.c:401
> >>>>>>     #21 run_argv (argcp=3D0x7fffffffe16c, argv=3D0x7fffffffe160) a=
t perf.c:445
> >>>>>>     #22 main (argc=3D9, argv=3D0x7fffffffe320) at perf.c:553
> >>>>>>
> >>>>>> Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default=
")
> >>>>>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>>>>> ---
> >>>>>> I'm not actually sure if this is the right fix for this. Commit
> >>>>>> 2c369d91d093 ("perf symbol: Add blocking argument to
> >>>>>> filename__read_build_id") which added the blocking argument says t=
hat it
> >>>>>> should be non-blocking reads for event synthesis, but the callstac=
k here
> >>>>>> is when writing the header out.
> >>>>>>
> >>>>>> There was also an is_regular_file() check added in commit c21986d3=
3d6b
> >>>>>> ("perf unwind-libdw: skip non-regular files"), which presumably fa=
lls
> >>>>>> afoul of the "which unfortunately fails for symlinks" part of the =
other
> >>>>>> linked commit message?
> >>>>>>
> >>>>>> So I can't tell if we should add the is_regular_file() check here =
too,
> >>>>>> or just set it to non-blocking, or it needs some extra state to be
> >>>>>> passed all the way down to dsos__read_build_ids_cb() to do differe=
nt
> >>>>>> things.
> >>>>>
> >>>>> The fix lgtm but I worry about making all the build ID reading
> >>>>> non-blocking meaning build IDs getting lost.
> >>>>
> >>>> I'm not sure what non-blocking means for regular file system operati=
ons
> >>>> on a block device.  But it may have some impact on regular files on =
a
> >>>> network filesystem.
> >>
> >> It depends on the filesystem, but I think the assurances given by
> >> O_NONBLOCK are very weak anyway. It can be practically ignored or do
> >> different things in different situations. Especially as we don't handl=
e
> >> EAGAIN or do anything fancy we shouldn't use it.
> >>
> >> For our case it looks like we should always do blocking reads but make
> >> sure to not open a non-regular file.
> >>
> >>>
> >>> Agreed. Prior to using blocking we tried to imply from the file type
> >>> from stat, but that skipped things like symlinks :-/
> >>>
> >>
> >> Am I missing something here? is_regular_file() uses stat() which retur=
ns
> >> info about the target file, rather than the symlink, so they wouldn't =
be
> >> skipped. lstat() is the one that returns info about the link file.
> >>
> >> I tested is_regular_file() with links, links to links, pipes, files an=
d
> >> devices and it works as expected and would avoid the need to use O_NON=
BLOCK.
> >
> > I don't mind we back out the use of the is_block parameter and use
> > is_regular_file. In the code before the change to use is_block the
> > callers would call is_regular_file and then call
> > filename__read_build_id. This seemed error prone as some callers were
> > doing the is_regular_file check and others not. I think I favor just
> > getting rid of the argument but putting the is_regular_file check in
> > filename__read_build_id. I'd switched to using O_NONBLOCK rather than
>
> That makes sense to me. Should I make that change in addition to
> Namhyung's patch?
>
> > is_regular_file not just because of symlinks but just because it
> > wasn't clear that anything non-regular may still have a build id.
>
> That I'm not sure about either. Can we assume that no non-regular files
> have build IDs as we're not handling EAGAIN anyway? Or at least if they
> do it's not currently supported.

Perhaps what we want is to O_NONBLOCK just when !is_regular_file in
the filename__read_build_id functions (there's one in symbol-minimal
and another in symbol-elf). That way we read regular files without
worry that O_NONBLOCK could fail for say a network filesystem. If a
non-regular file fails to open with O_NONBLOCK then it was probably a
block device, ... If it does open then we can try to get a build-ID
just in case this is just something weird. But tbh, we could skip the
whole O_NONBLOCK thing until we have evidence it is actually a problem
somewhere. It'd be cool if you could make a patch for this.

Thanks,
Ian

> >
> > There's the separate issue of why are we writing out buildids in the
> > features when the buildid-mmaps contain the same data. It seems
> > Namhyung has a patch just about optimizing that case :-)
> >
> > Thanks,
> > Ian
> >
> >> James
> >>
> >>>>> It seems that generating
> >>>>> the build ID feature table is unnecessary if we have build ID mmap
> >>>>> events, including synthesized ones that will have read the build ID=
s.
> >>>>> I wonder if a better "fix" is:
> >>>>> ```
> >>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-recor=
d.c
> >>>>> index cb52aea9607d..15f75c70eb76 100644
> >>>>> --- a/tools/perf/builtin-record.c
> >>>>> +++ b/tools/perf/builtin-record.c
> >>>>> @@ -1842,7 +1842,7 @@ static void record__init_features(struct reco=
rd *rec)
> >>>>>          for (feat =3D HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEA=
TURE; feat++)
> >>>>>                  perf_header__set_feat(&session->header, feat);
> >>>>>
> >>>>> -       if (rec->no_buildid)
> >>>>> +       if (rec->no_buildid || rec->buildid_mmap)
> >>>>>                  perf_header__clear_feat(&session->header, HEADER_B=
UILD_ID);
> >>>>>
> >>>>>          if (!have_tracepoints(&rec->evlist->core.entries))
> >>>>> ```
> >>>>> that should disable the build ID feature table generation when buil=
d
> >>>>> ID mmaps are in use (the default). Having the build IDs twice in th=
e
> >>>>> data file feels redundant. Or we could do your fix or both, wdyt?
> >>>>
> >>>> I'm ok to remove the header feature but I think it should update
> >>>> build-ID cache even with this change.
> >>>
> >>> Yeah, dropping the feature writing also impacts updating the build ID
> >>> cache because:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/header.c?h=3Dperf-tools-next#n338
> >>> It is kind of strange that writing a header feature does this. What i=
f
> >>> I want to write a header with build IDs but not update the cache? It'=
d
> >>> make more sense, I think, for perf_session__cache_build_ids to be
> >>> called explicitly. There is also the global no_buildid_cache
> >>> controlling behavior:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/build-id.c?h=3Dperf-tools-next#n43
> >>> But that's kind of a hack as we may have >1 session such as with TPEB=
S.
> >>>
> >>>> I'm also curious if the device has samples actually.  It should be
> >>>> checked by dso->hit.
> >>>
> >>> In this case the header writing is happening after the samples have
> >>> been processed, but it looks like marking of samples doesn't consider
> >>> data addresses:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/build-id.c?h=3Dperf-tools-next#n55
> >>> just sample->ip and the callchain. If the marking was updated for dat=
a
> >>> pages then just writing build IDs for marked dsos would make sense.
> >>> There could be callers not marking dsos so they'd need altering, or
> >>> two versions of the code.
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> Thanks,
> >>>> Namhyung
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>> ---
> >>>>>>    tools/perf/util/dsos.c | 5 +++--
> >>>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> >>>>>> index 64c1d65b0149..5e1c815d7cb0 100644
> >>>>>> --- a/tools/perf/util/dsos.c
> >>>>>> +++ b/tools/perf/util/dsos.c
> >>>>>> @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso =
*dso, void *data)
> >>>>>>                   return 0;
> >>>>>>           }
> >>>>>>           nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> >>>>>> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*b=
lock=3D*/true) > 0) {
> >>>>>> +       /* Don't block in case path isn't for a regular file. */
> >>>>>> +       if (filename__read_build_id(dso__long_name(dso), &bid, /*b=
lock=3D*/false) > 0) {
> >>>>>>                   dso__set_build_id(dso, &bid);
> >>>>>>                   args->have_build_id =3D true;
> >>>>>>           } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
> >>>>>>                   char *new_name =3D dso__filename_with_chroot(dso=
, dso__long_name(dso));
> >>>>>>
> >>>>>> -               if (new_name && filename__read_build_id(new_name, =
&bid, /*block=3D*/true) > 0) {
> >>>>>> +               if (new_name && filename__read_build_id(new_name, =
&bid, /*block=3D*/false) > 0) {
> >>>>>>                           dso__set_build_id(dso, &bid);
> >>>>>>                           args->have_build_id =3D true;
> >>>>>>                   }
> >>>>>>
> >>>>>> ---
> >>>>>> base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
> >>>>>> change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
> >>>>>>
> >>>>>> Best regards,
> >>>>>> --
> >>>>>> James Clark <james.clark@linaro.org>
> >>>>>>
> >>
>

