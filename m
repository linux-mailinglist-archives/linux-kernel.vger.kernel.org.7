Return-Path: <linux-kernel+bounces-846878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D091ABC94FB
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27611A618E9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA31714B7;
	Thu,  9 Oct 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYXDwAUs"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F034BA2F
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016728; cv=none; b=iPZsR05c6t2Z7TSTDf6A4mm9mYKEPsaoG4qM6mNGYtlopS3uetoLqjG43YejJtyMEYyKv/6xMwFrat5Ye0c/ThHgWfmiBj7prOTyD5MU6RcAvxH0xICXsrVr/aglLb/aC+LI4ScxblmbXCUW559DuNbagQM2o+5FBViZtfFhR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016728; c=relaxed/simple;
	bh=h3NuZ12K3/lElcibtGA+QG5w/yrJTAfAVGN7114N2I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Af+dXgh/iZXM2xhUV4N0wD8uBZ5X+J7zTYBiiomFsTYvyt4mbCadvvaOxxCeLEvZNTpqHs3ZYWl9m/xHoti0Ken70omfac0KxPkWv9KqgxTMYzozwkPznfDhnRL7lu7uZYx25DQih1l6CwAwdkjHsAXJdHZ53DW8Aq1vQbd2nRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYXDwAUs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so252585ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760016724; x=1760621524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKgrX9I9H1E8Rzi9UZJixQg4AVl3hxGPKMOGQpXFZKY=;
        b=WYXDwAUslJVv9B33sTxrzUROyXOdUAJUw2I83Y+TRSakmd8R6qjzVononSGrBedWj4
         PQFAohIt7qKAuSUL/MOIPMtG6Y998nhRKt+1FII330JKyO0opC0iz9QbfKmOHyTrIVuS
         da3b5Rrl1Nt9t0q/Bao99IRJqrh6nqJpqCf1RSMwn84560wKYIfUFGCjp0vUuuNfyaPh
         BW/y3pzQjc9d7zSjN8FKsy7p73Yvw4r7Fs4bq/np0cToxTGTbE/w74C/YT0iWwga6Pls
         ZiEpTOT614sGGlriz+QAtxCKQq68N/Zos2sgJBQRBjQJBPVsohWl9ku3aUJznPncEnWC
         8vGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016724; x=1760621524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKgrX9I9H1E8Rzi9UZJixQg4AVl3hxGPKMOGQpXFZKY=;
        b=QaBcUjZFYZ09RfqTlmnHC84CiwrWSrQ4/ub4X7sqvuRFko5kTsB4zCKSNbxcXAvXKK
         1TB3Q6jbe9bnNcgoveDDqDcDhNFvhznR6z2ugKtooNZJ3sATxMfVqod0uSBy7+KfzXp0
         kX7+1HKLgEmQGlhUcDfkyByKAyPY6v8iNDttIhdOO/a1bJ2PvjNDHZk4TNivs9WyERkm
         bEVyJs3Ieduix2MtNBsCYpyeEJxBQePwsrfWz+5hYPIFHANEEJMCiHjI5G/+/4u8V2a+
         /rEwcHruYSH80q0O6PDxMt+LF8hTdI7YEPFb+Jx7UJySv60NNH7uyNiCYXSNYKGdeBth
         yUvA==
X-Forwarded-Encrypted: i=1; AJvYcCVJV1oEcBFULvOLba/BMNXEGLj5FRJEislZHIDeXdV1gvFaffYsxuJew6oLgpnEsF2wjIkpPD5ikxi/b8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxIaBt1u5a3Rzd1LcJnst8W4qJmQUGpODFbJVhCePeoEEGqG1
	5O4OycGXrKIJIJblI8lMidIa1RXnzYxPfiiaBzKk9+7yOxUxIhLKPuyzn0CZGOv8oDtJOA/o3aO
	PXb1feSKVo/O3+RuYWAVlwMbfBfTXQPiIWLOrwhtX
X-Gm-Gg: ASbGncum9JOyTOxWtQmVvJHGiCyABhYvVCSP6FgJT1B//V4hM1sZvMB6+K+NU5ADMHB
	Wotn1LTp6zHDvyAFNNJ21k6p0Cr4B48JV+zWM1d/XR8ztgSFukmTC/yIndy7GkkhL/i49SowP0R
	hYiotLUlfyXwdCxv4GRVhuTQ0/oVKfnKp3uHzgU6Wa9GbAyOr5SJF0itOCHnna7wvOqDIdwCWpH
	G2KZorxjTzYxGrrhdcevtp0vdsLp4F8rSWuve/V/6MKR27Xfw==
X-Google-Smtp-Source: AGHT+IFZJq65ep3s4bVMk6jxRxVRnjn2WyK+ZNQwtHI4t4HXIP6rXT96ATbGdNG/wBUzAgqVESqMBEwAWlzsE5261Jc=
X-Received: by 2002:a17:902:d548:b0:25b:ce96:7109 with SMTP id
 d9443c01a7336-290275de5a5mr9131235ad.3.1760016723556; Thu, 09 Oct 2025
 06:32:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005181421.2787960-1-irogers@google.com> <aOYkRdU5pn_jTOq3@google.com>
 <CAP-5=fUqYeaE_P3ApXvq7j9SRuNXpLf+mK-4XBsvv2R=OTccbQ@mail.gmail.com> <aOdNWrIAQMkaVsqR@google.com>
In-Reply-To: <aOdNWrIAQMkaVsqR@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Oct 2025 06:31:51 -0700
X-Gm-Features: AS18NWBVDbTPoqSC3Meaoii89yADm94rw5shK2Rf50XwIFJD_M3dwkPQDvt3OEs
Message-ID: <CAP-5=fVERf8jf3MrwiEfQtChvC1KUe0EEASK1aVk-UKkk=Pb0w@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Additional verbose details for <not
 supported> events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Oct 08, 2025 at 09:31:53AM -0700, Ian Rogers wrote:
> > On Wed, Oct 8, 2025 at 1:43=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > On Sun, Oct 05, 2025 at 11:14:21AM -0700, Ian Rogers wrote:
> > > > If an event shows as "<not supported>" in perf stat output, in verb=
ose
> > > > mode add the strerror output to help diagnose the issue.
> > > >
> > > > Consider:
> > > > ```
> > > > $ perf stat -e cycles,data_read,instructions true
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >            357,457      cycles:u
> > > >    <not supported> MiB  data_read:u
> > > >            156,182      instructions:u                   #    0.44 =
 insn per cycle
> > > >
> > > >        0.001250315 seconds time elapsed
> > > >
> > > >        0.001283000 seconds user
> > > >        0.000000000 seconds sys
> > > > ```
> > > >
> > > > To understand why the data_read uncore event failed, with this chan=
ge:
> > > > ```
> > > > $ perf stat -v -e cycles,data_read,instructions true
> > > > Using CPUID GenuineIntel-6-8D-1
> > > > cycles -> cpu/cycles/
> > > > data_read -> uncore_imc_free_running_0/data_read/
> > > > data_read -> uncore_imc_free_running_1/data_read/
> > > > instructions -> cpu/instructions/
> > > > Control descriptor is not initialized
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > data_read:u event is not supported by the kernel.
> > > > Invalid event (data_read:u) in per-thread mode, enable system wide =
with '-a'.
> > > > Warning:
> > > > kernel.perf_event_paranoid=3D2, trying to fall back to excluding ke=
rnel and hypervisor  samples
> > > > Warning:
> > > > data_read:u event is not supported by the kernel.
> > > > Invalid event (data_read:u) in per-thread mode, enable system wide =
with '-a'.
> > > > cycles:u: 351621 362833 362833
> > > > failed to read counter data_read:u
> > > > failed to read counter data_read:u
> > > > instructions:u: 156184 362833 362833
> > > >
> > > >  Performance counter stats for 'true':
> > > >
> > > >            351,621      cycles:u
> > > >    <not supported> MiB  data_read:u
> > > >            156,184      instructions:u                   #    0.44 =
 insn per cycle
> > > >
> > > >        0.001584472 seconds time elapsed
> > > >
> > > >        0.001811000 seconds user
> > > >        0.000000000 seconds sys
> > > > ```
> > > > where without this change only "data_read:u event is not supported =
by
> > > > the kernel." is shown.
> > >
> > > I think what you say is:
> > >
> > > Before:
> > >   data_read:u event is not supported by the kernel.
> > >
> > > After:
> > >   data_read:u event is not supported by the kernel.
> > >   Invalid event (data_read:u) in per-thread mode, enable system wide =
with '-a'.
> >
> > I kept things verbose as unfortunately the
> > "kernel.perf_event_paranoid=3D2" is important as is the use of
> > per-thread mode. Different paranoia levels lead to different errors
> > and unfortunately a lot of the time the error gets reported as "
> > data_read:u event is not supported by the kernel." and I'm not sure
> > all users will get that the key part there is the :u modifier.
>
> Yep, I'm ok with the change.  But the changelog was a bit unclear what
> is being added exactly.  IIUC we already have the paranoid message with
> the verbose level 1.

I thought the line:
"""
where without this change only "data_read:u event is not supported by
the kernel." is shown.
"""
covered this?

Thanks,
Ian

> > However, fixing  evsel__open_strerror wasn't in scope for this change.
>
> Sure, we can handle that separately.
>
> Thanks,
> Namhyung
>
> >
> > > Off-topic, it'd be great if we reduce the number of the same warning
> > > messages.  I think the data_read is from two uncore PMUs so the messa=
ge
> > > was repeated.  If we can connect the related evsels and show the
> > > messages once, then the output is more readable.  Maybe we also want =
to
> > > show the fallback message just once (globally).
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/builtin-stat.c | 12 +++++++-----
> > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > > index 7006f848f87a..84e06ec09cc2 100644
> > > > --- a/tools/perf/builtin-stat.c
> > > > +++ b/tools/perf/builtin-stat.c
> > > > @@ -624,8 +624,9 @@ static enum counter_recovery stat_handle_error(=
struct evsel *counter, int err)
> > > >        */
> > > >       if (err =3D=3D EINVAL || err =3D=3D ENOSYS || err =3D=3D ENOE=
NT || err =3D=3D ENXIO) {
> > > >               if (verbose > 0) {
> > > > -                     ui__warning("%s event is not supported by the=
 kernel.\n",
> > > > -                                 evsel__name(counter));
> > > > +                     evsel__open_strerror(counter, &target, err, m=
sg, sizeof(msg));
> > > > +                     ui__warning("%s event is not supported by the=
 kernel.\n%s\n",
> > > > +                                 evsel__name(counter), msg);
> > > >               }
> > > >               return COUNTER_SKIP;
> > > >       }
> > > > @@ -649,10 +650,11 @@ static enum counter_recovery stat_handle_erro=
r(struct evsel *counter, int err)
> > > >               }
> > > >       }
> > > >       if (verbose > 0) {
> > > > +             evsel__open_strerror(counter, &target, err, msg, size=
of(msg));
> > > >               ui__warning(err =3D=3D EOPNOTSUPP
> > > > -                     ? "%s event is not supported by the kernel.\n=
"
> > > > -                     : "skipping event %s that kernel failed to op=
en.\n",
> > > > -                     evsel__name(counter));
> > > > +                     ? "%s event is not supported by the kernel.\n=
%s\n"
> > > > +                     : "skipping event %s that kernel failed to op=
en.\n%s\n",
> > > > +                     evsel__name(counter), msg);
> > > >       }
> > > >       return COUNTER_SKIP;
> > > >  }
> > > > --
> > > > 2.51.0.618.g983fd99d29-goog
> > > >

