Return-Path: <linux-kernel+bounces-874026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1FEC155B9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 310E34E1B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50633CEB2;
	Tue, 28 Oct 2025 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dta2077t"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31E33B976
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664077; cv=none; b=OPOJGH2JGE46vDKr5zSX8VbPKjWJJ8i4LVVw/M3flHgmgH4yY0JvvobpK5R1CcfLWYeX0dzolpBV8VmJKPfn58/O7yiY96ybCe6kZ15pomkMRjowbGrh+GUW+P+qbA9hAwsmvcNyn6S8eBZw8a1uQpO4mvI8MOLA6+XzyClkZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664077; c=relaxed/simple;
	bh=JneaelrWdxFtENso1+ZWLmQ3kgUcu7bUt5bdftwUKy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ElBnAlfBerA/sj5RCADtrJFxGP7/UOjWI1QMXG8GSDM0braYjq4kOuHga5E2NniM9I5nABBzvqwZs5n4qAkDo0ZlRIjIVSKuWSQ+wD4tR6L/QqTY2tlgbb4K9vY60Kc7ZDQbCB3j6VgWEP4hJRlPeTXUB+Y40IC8y11A/ewSW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dta2077t; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27eeafd4882so240945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761664072; x=1762268872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3pdmXgfKnITH68QWyYdVu7Pdb87ggTAiSS8+raqM18=;
        b=dta2077t7to0lmhUqw9JPhudVBu3zjvxIsuXMOu9VlCBl5ORs1XJF1w0YAVTg/xxKq
         pjsnpDGaPdMQdPnEXo8LdTfpASNDpVPSt956Fur1fixdvGe2O8f8DQQWBKkhfo14o2nZ
         XBmIgWgzEa2NPGVMK9jv9Cu5CePZwi1yMd7yS634ozAPnrEQihWEwCcH6Oresa9AVwRO
         q9Hps9aS33IEuhzgW077QBBUqe76f134Su1udHOpD0qcHECP3v8KqSss71oMIjhHUgjx
         ncAP2bkSjA8/Hya1GjdpBDdf+E7ZKzlu+OKtOxiG7juIxVOrUA7uq6NJan+Rrrx0iMek
         BjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664073; x=1762268873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3pdmXgfKnITH68QWyYdVu7Pdb87ggTAiSS8+raqM18=;
        b=S5GUgWmv+4tpwE57XGqSdbZH8tfYcpPiAyo5+jNNghiWUpFyj5lfsFfC9+khhAjlR1
         98rdBQ/7dFy7UcEk3OuZehFwGPnh6uGHjf0E93ybGkb78vUx3jymX3A8wX1HGoW3WA2n
         vg5/Vwp6sW2ImF6SBSOaJIDgWXcucjgI/rxDYieG8qFcuVgAZ5Hr54qovgPcr/8r93VZ
         npzZT4HAZH3CaG3oQ+KdV/zOsmMavtQAEEl/GSlftv4z7a+llLc4S/NnWI0bb/uKs4PD
         2qWt9HbFv3kKW7nO/b8AKrJ7IAKO0ew4cXENAohp399IYDG1VMo/iz6x1e9eTmRu6HO5
         ZH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrk+d5jIQEU6nDgAbo5LX6zwGUPtF1/z3Zx4pgGDUC83idOnSTPrFj/K64P2mc+puFC7fyWkkOfZQsLO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQX4EInGxY2ifcH3AJf0Jhx4/ArPMYkU6yhf35oqcrBCy/TLes
	JK3Fa1D8Anr6pqdBiYcYf71TzKjc8325GJeZ7oHbIcNF+BqvEwljKRoMJUcL+O8GeviMTW4hkwd
	qRQFmXcLognzeIQMRqiO+Ulwr/ce8UKpiFD+lHQSX
X-Gm-Gg: ASbGncvldZfky0XzL+jS624vddu4gstj28hrP+Jl3Z0zRboiXwfBEN41UArxGneBo7M
	YP4WyowcqQq//HHkQUiSN0dWMFj2tqDvGUO1PNlUMPV2D/5/KEs8TBa1vLKUs+Ue3m4+aVL9DBt
	xT6NCQr0uIfeHrjedYV6xp6VvKxjMSWG2ZpyJivsfEvi7PgoraRRjzk75JFFEWmd15H6IFrKaWN
	CnTLE270iuPJnnPCQ0mvYzM5FXhb5b09LjNLJtL4p0PECiROt3ujE1B3eCohjwt02XAw3/dWvf0
	c7FyL4tElnvDMQQ=
X-Google-Smtp-Source: AGHT+IEOlvVtwGNnqC8paYpbBBQKfjh0eLvOLkPByI+QC7ZQ5JRLxVmurG9wk/i3Am3u/Q+hzxpqeiezGwPQo9uD3M4=
X-Received: by 2002:a17:902:e849:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-294ccb34cf2mr4880225ad.10.1761664071643; Tue, 28 Oct 2025
 08:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
 <aP1kSdZJKYIpnRia@google.com> <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
 <17f00d4d-5cbf-4c9c-a51a-f0ae34f181cf@linaro.org>
In-Reply-To: <17f00d4d-5cbf-4c9c-a51a-f0ae34f181cf@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Oct 2025 08:07:38 -0700
X-Gm-Features: AWmQ_bmcfb_MIHCzdYrjjAXAPPE4Yy-cOVHzUbX693z5ZFThEg6Ih8u-aGxe0v8
Message-ID: <CAP-5=fV-g1CeJCoEnNnz_eFsks01JyUR3Fxz_H0X_rdTzOGuAw@mail.gmail.com>
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:33=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 26/10/2025 4:52 am, Ian Rogers wrote:
> > On Sat, Oct 25, 2025 at 4:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> >>
> >> Hello,
> >>
> >> On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
> >>> On Wed, Oct 22, 2025 at 8:46=E2=80=AFAM James Clark <james.clark@lina=
ro.org> wrote:
> >>>>
> >>>> The following command will hang consistently when the GPU is being u=
sed
> >>>> due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
> >>>> being opened to read build IDs:
> >>>>
> >>>>   $ perf record -asdg -e cpu-clock -- true
> >>>>
> >>>> Change to non blocking reads to avoid the hang here:
> >>>>
> >>>>    #0  __libc_pread64 (offset=3D<optimised out>, count=3D0, buf=3D0x=
7fffffffa4a0, fd=3D237) at ../sysdeps/unix/sysv/linux/pread64.c:25
> >>>>    #1  __libc_pread64 (fd=3D237, buf=3D0x7fffffffa4a0, count=3D0, of=
fset=3D0) at ../sysdeps/unix/sysv/linux/pread64.c:23
> >>>>    #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
> >>>>    #3  read_build_id (filename=3D0x5555562df333 "/dev/dri/card2", bi=
d=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:880
> >>>>    #4  filename__read_build_id (filename=3D0x5555562df333 "/dev/dri/=
card2", bid=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:924
> >>>>    #5  dsos__read_build_ids_cb (dso=3D0x5555562df1d0, data=3D0x7ffff=
fffb750) at util/dsos.c:84
> >>>>    #6  __dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e7=
030 <dsos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:59
> >>>>    #7  dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e703=
0 <dsos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:503
> >>>>    #8  dsos__read_build_ids (dsos=3D0x55555623de68, with_hits=3Dtrue=
) at util/dsos.c:107
> >>>>    #9  machine__read_build_ids (machine=3D0x55555623da58, with_hits=
=3Dtrue) at util/build-id.c:950
> >>>>    #10 perf_session__read_build_ids (session=3D0x55555623d840, with_=
hits=3Dtrue) at util/build-id.c:956
> >>>>    #11 write_build_id (ff=3D0x7fffffffb958, evlist=3D0x5555562323d0)=
 at util/header.c:327
> >>>>    #12 do_write_feat (ff=3D0x7fffffffb958, type=3D2, p=3D0x7fffffffb=
950, evlist=3D0x5555562323d0, fc=3D0x0) at util/header.c:3588
> >>>>    #13 perf_header__adds_write (header=3D0x55555623d840, evlist=3D0x=
5555562323d0, fd=3D3, fc=3D0x0) at util/header.c:3632
> >>>>    #14 perf_session__do_write_header (session=3D0x55555623d840, evli=
st=3D0x5555562323d0, fd=3D3, at_exit=3Dtrue, fc=3D0x0, write_attrs_after_da=
ta=3Dfalse) at util/header.c:3756
> >>>>    #15 perf_session__write_header (session=3D0x55555623d840, evlist=
=3D0x5555562323d0, fd=3D3, at_exit=3Dtrue) at util/header.c:3796
> >>>>    #16 record__finish_output (rec=3D0x5555561838d8 <record>) at buil=
tin-record.c:1899
> >>>>    #17 __cmd_record (rec=3D0x5555561838d8 <record>, argc=3D2, argv=
=3D0x7fffffffe320) at builtin-record.c:2967
> >>>>    #18 cmd_record (argc=3D2, argv=3D0x7fffffffe320) at builtin-recor=
d.c:4453
> >>>>    #19 run_builtin (p=3D0x55555618cbb0 <commands+288>, argc=3D9, arg=
v=3D0x7fffffffe320) at perf.c:349
> >>>>    #20 handle_internal_command (argc=3D9, argv=3D0x7fffffffe320) at =
perf.c:401
> >>>>    #21 run_argv (argcp=3D0x7fffffffe16c, argv=3D0x7fffffffe160) at p=
erf.c:445
> >>>>    #22 main (argc=3D9, argv=3D0x7fffffffe320) at perf.c:553
> >>>>
> >>>> Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
> >>>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>>> ---
> >>>> I'm not actually sure if this is the right fix for this. Commit
> >>>> 2c369d91d093 ("perf symbol: Add blocking argument to
> >>>> filename__read_build_id") which added the blocking argument says tha=
t it
> >>>> should be non-blocking reads for event synthesis, but the callstack =
here
> >>>> is when writing the header out.
> >>>>
> >>>> There was also an is_regular_file() check added in commit c21986d33d=
6b
> >>>> ("perf unwind-libdw: skip non-regular files"), which presumably fall=
s
> >>>> afoul of the "which unfortunately fails for symlinks" part of the ot=
her
> >>>> linked commit message?
> >>>>
> >>>> So I can't tell if we should add the is_regular_file() check here to=
o,
> >>>> or just set it to non-blocking, or it needs some extra state to be
> >>>> passed all the way down to dsos__read_build_ids_cb() to do different
> >>>> things.
> >>>
> >>> The fix lgtm but I worry about making all the build ID reading
> >>> non-blocking meaning build IDs getting lost.
> >>
> >> I'm not sure what non-blocking means for regular file system operation=
s
> >> on a block device.  But it may have some impact on regular files on a
> >> network filesystem.
>
> It depends on the filesystem, but I think the assurances given by
> O_NONBLOCK are very weak anyway. It can be practically ignored or do
> different things in different situations. Especially as we don't handle
> EAGAIN or do anything fancy we shouldn't use it.
>
> For our case it looks like we should always do blocking reads but make
> sure to not open a non-regular file.
>
> >
> > Agreed. Prior to using blocking we tried to imply from the file type
> > from stat, but that skipped things like symlinks :-/
> >
>
> Am I missing something here? is_regular_file() uses stat() which returns
> info about the target file, rather than the symlink, so they wouldn't be
> skipped. lstat() is the one that returns info about the link file.
>
> I tested is_regular_file() with links, links to links, pipes, files and
> devices and it works as expected and would avoid the need to use O_NONBLO=
CK.

I don't mind we back out the use of the is_block parameter and use
is_regular_file. In the code before the change to use is_block the
callers would call is_regular_file and then call
filename__read_build_id. This seemed error prone as some callers were
doing the is_regular_file check and others not. I think I favor just
getting rid of the argument but putting the is_regular_file check in
filename__read_build_id. I'd switched to using O_NONBLOCK rather than
is_regular_file not just because of symlinks but just because it
wasn't clear that anything non-regular may still have a build id.

There's the separate issue of why are we writing out buildids in the
features when the buildid-mmaps contain the same data. It seems
Namhyung has a patch just about optimizing that case :-)

Thanks,
Ian

> James
>
> >>> It seems that generating
> >>> the build ID feature table is unnecessary if we have build ID mmap
> >>> events, including synthesized ones that will have read the build IDs.
> >>> I wonder if a better "fix" is:
> >>> ```
> >>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.=
c
> >>> index cb52aea9607d..15f75c70eb76 100644
> >>> --- a/tools/perf/builtin-record.c
> >>> +++ b/tools/perf/builtin-record.c
> >>> @@ -1842,7 +1842,7 @@ static void record__init_features(struct record=
 *rec)
> >>>         for (feat =3D HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATUR=
E; feat++)
> >>>                 perf_header__set_feat(&session->header, feat);
> >>>
> >>> -       if (rec->no_buildid)
> >>> +       if (rec->no_buildid || rec->buildid_mmap)
> >>>                 perf_header__clear_feat(&session->header, HEADER_BUIL=
D_ID);
> >>>
> >>>         if (!have_tracepoints(&rec->evlist->core.entries))
> >>> ```
> >>> that should disable the build ID feature table generation when build
> >>> ID mmaps are in use (the default). Having the build IDs twice in the
> >>> data file feels redundant. Or we could do your fix or both, wdyt?
> >>
> >> I'm ok to remove the header feature but I think it should update
> >> build-ID cache even with this change.
> >
> > Yeah, dropping the feature writing also impacts updating the build ID
> > cache because:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/header.c?h=3Dperf-tools-next#n338
> > It is kind of strange that writing a header feature does this. What if
> > I want to write a header with build IDs but not update the cache? It'd
> > make more sense, I think, for perf_session__cache_build_ids to be
> > called explicitly. There is also the global no_buildid_cache
> > controlling behavior:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/build-id.c?h=3Dperf-tools-next#n43
> > But that's kind of a hack as we may have >1 session such as with TPEBS.
> >
> >> I'm also curious if the device has samples actually.  It should be
> >> checked by dso->hit.
> >
> > In this case the header writing is happening after the samples have
> > been processed, but it looks like marking of samples doesn't consider
> > data addresses:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/build-id.c?h=3Dperf-tools-next#n55
> > just sample->ip and the callchain. If the marking was updated for data
> > pages then just writing build IDs for marked dsos would make sense.
> > There could be callers not marking dsos so they'd need altering, or
> > two versions of the code.
> >
> > Thanks,
> > Ian
> >
> >> Thanks,
> >> Namhyung
> >>
> >>>
> >>> Thanks,
> >>> Ian
> >>>
> >>>> ---
> >>>>   tools/perf/util/dsos.c | 5 +++--
> >>>>   1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> >>>> index 64c1d65b0149..5e1c815d7cb0 100644
> >>>> --- a/tools/perf/util/dsos.c
> >>>> +++ b/tools/perf/util/dsos.c
> >>>> @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *d=
so, void *data)
> >>>>                  return 0;
> >>>>          }
> >>>>          nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> >>>> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*blo=
ck=3D*/true) > 0) {
> >>>> +       /* Don't block in case path isn't for a regular file. */
> >>>> +       if (filename__read_build_id(dso__long_name(dso), &bid, /*blo=
ck=3D*/false) > 0) {
> >>>>                  dso__set_build_id(dso, &bid);
> >>>>                  args->have_build_id =3D true;
> >>>>          } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
> >>>>                  char *new_name =3D dso__filename_with_chroot(dso, d=
so__long_name(dso));
> >>>>
> >>>> -               if (new_name && filename__read_build_id(new_name, &b=
id, /*block=3D*/true) > 0) {
> >>>> +               if (new_name && filename__read_build_id(new_name, &b=
id, /*block=3D*/false) > 0) {
> >>>>                          dso__set_build_id(dso, &bid);
> >>>>                          args->have_build_id =3D true;
> >>>>                  }
> >>>>
> >>>> ---
> >>>> base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
> >>>> change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> James Clark <james.clark@linaro.org>
> >>>>
>

