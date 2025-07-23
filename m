Return-Path: <linux-kernel+bounces-743072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB82B0FA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E0F1C862F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164A22A4F1;
	Wed, 23 Jul 2025 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyKzs9QZ"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05548225779
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294892; cv=none; b=ZvV6ADeCOQaGHvo8aRAHfRVR5GLhcXuY+XprEZupyF+pNMJLNin8lLuPF5BLFPXkolPAeAxZewxBYZxmXEoUhj2P6Mg/5GJJOSX0Brr6OjtPWwuhvsIFY4pDY+GYUalEQfd7devwSwRwrssgmNzu9u9L8OWKRoKrpPLzlQ39YxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294892; c=relaxed/simple;
	bh=x/f9IRuutxykfXqdhJQOESHNxKfFRj+OQF7+8Xsi5iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxVY+SJ7xnIu2FUQGlPa2p7NUO+GqCEG8pMx/QeXRnoJ4QmDjhZlRgL7koQQOSD9Hos7xbPsnt95X5XRmJ6YKc1ngn3n2BNGxPZ59Y+6FBavLBKT5XEj6WKXJIAqioIdqRpA97Ng1XzH04ML4fMDFI5D8wmtCqgx0oBNqOZ4fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyKzs9QZ; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e283b2d065so25025ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294890; x=1753899690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ1mEiwCWRTYXkSoTNUc0GD/vI93aJ+12BCapC+1BjI=;
        b=KyKzs9QZFijiU12NfaAV4399RE9t29oM4+xtAN75dIlZ9A9oDoN1NPD/qL8sjdpZv2
         CBboGDJhdN6jAVQBGlP1oz3F+wAd5114/9M0sYd+NoGkeJjSZdhhAol9qjtmnH7EubTk
         GSAy1VXmn1BPb1DhPr0mm5SEJIp8I7sVNSbo8SRHCem7y9MbYBNYafPfY+GvZVBFL102
         uirotl0BofF/GcQKiKr6X/uezcMwqBhb7MXV/JIWZip4ZMBGhArDhkQ49IMim9tZuE/K
         yCxeXAO6uFgjs7Dt/PnOXE3UgXtlmddsKtCbak77JKBcEQcnVcHOjpqWrXHD83sp1Olt
         5ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294890; x=1753899690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZ1mEiwCWRTYXkSoTNUc0GD/vI93aJ+12BCapC+1BjI=;
        b=eJywLckMOHaebVqqTv2AtInBshdCaPXq74G4xBZOTFoQhlQqbOh2vW/57qmlKHlqHU
         ojGNWtrXJLC6Dq28+Dt1f8sRs8KKQi0Hh1SXDG18XUoIK28vMkp13PSXJSaZQIw0uwQS
         YeH7Bl64vNbrvMQdv8cYKk4zo9TL++7szYUwHqHoOtZhj4mMYdg6K7Vu491Ftohfk2Sc
         PYUYVdg72shlsiYHM3auFdnDNHnfY8m6UonVkUcz1LSdxrxVR3S69zq9E3pQNIOO1iV0
         rk+fuxCLa08I9I8e08mtjZI5xn5PVo1eUC3OEVoHzB0M+KEZ95gT6UuulcZkgNM9nC2S
         MQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA4KVPhIJqdPM+bX9gxlhuXyqPT5j3UMjhYjqoHJvIc2snUB0HP7LHqWJyu114koy1OhMpO7Wk25A8mkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJC287Kvn8UuNOsfegtQlASB6j9ZcR6EQHp3WU4b3iZbspAtSy
	AJP+pVLfPhnj37iZ98Otnky4blugi8HxXSGxfkGTnvK3WkcImSUUlR4Ls5nb7LNAEA9AA8/sZ/5
	Q6JXWbNHwozRXNoRfsdP3ZZI1NO0U6c+Z+8oNhOfH
X-Gm-Gg: ASbGnctxp3kfuUHoV0Qp/aJuElyPPwihgBulH7QQgcgsKslajd+FidWASlYd9/1xz4n
	y+cX73vLcYfDjB4u3aKae4zcT516bXPLFWR6rduOdDRUyKDD2uqdGNGiTKMHZcKl+gIyctGbdNf
	ClGmvO7H/SSH99Q4foTY1ZjhS78rxe2xzFttr6VXeEASVkhQP1jvOzyLcYE7jfwWRAidKZh6mC8
	bWs1SHmaKJ3BFb8VExhiGWFCrbYUN2TBCzf
X-Google-Smtp-Source: AGHT+IHqmXfCM/EX0UmPWRDWW0pZtA/fTrJTv/qu9dbk1MufwPFd2Dkshn9UT6yLQfswZ6HMg5S/ms+kgNYYEyYUXEc=
X-Received: by 2002:a05:6e02:378f:b0:3e2:c639:8279 with SMTP id
 e9e14a558f8ab-3e3b64c0974mr266085ab.20.1753294889714; Wed, 23 Jul 2025
 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-2-irogers@google.com>
 <aIEmK1Ekly_HUJvV@google.com>
In-Reply-To: <aIEmK1Ekly_HUJvV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 11:21:18 -0700
X-Gm-Features: Ac12FXzL_ebj06u9FHjMPYfp1dXDwRW9s3Yop9iiUU4T-Uxt6PSsK3CaksJYluE
Message-ID: <CAP-5=fWQQoo9OQhiQEyAGvUm-LVs7vpkbvEdnw7OO+KGBXiHqA@mail.gmail.com>
Subject: Re: [PATCH v7 01/16] perf python: Add more exceptions on error paths
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:13=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Jul 14, 2025 at 09:43:49AM -0700, Ian Rogers wrote:
> > Returning NULL will cause the python interpreter to fail but not
> > report an error. If none wants to be returned then Py_None needs
> > returning. Set the error for the cases returning NULL so that more
> > meaningful interpreter behavior is had.
>
> It looks like you are adding error messages for the failure cases, not
> adding new exceptions, right?  IIUC returning NULL in pyrf_event__new()
> ends up having PyErr_NoMemory().  Then now it has different messages?

This change doesn't alter the exception if there already is one. There
are lots of cases where NULL is being returned for an error but that
causes the python interpreter to fail/crash. This patch is just adding
the exceptions and still returning NULL, previously set exceptions are
left alone. With the exceptions returned the python interpreter does
something more useful than fail/crash :-)

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/python.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 2f28f71325a8..02544387f39d 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union perf=
_event *event)
> >       if ((event->header.type < PERF_RECORD_MMAP ||
> >            event->header.type > PERF_RECORD_SAMPLE) &&
> >           !(event->header.type =3D=3D PERF_RECORD_SWITCH ||
> > -           event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE))
> > +           event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE)){
> > +             PyErr_Format(PyExc_TypeError, "Unexpected header type %u"=
,
> > +                          event->header.type);
> >               return NULL;
> > +     }
> >
> >       // FIXME this better be dynamic or we need to parse everything
> >       // before calling perf_mmap__consume(), including tracepoint fiel=
ds.
> > -     if (sizeof(pevent->event) < event->header.size)
> > +     if (sizeof(pevent->event) < event->header.size) {
> > +             PyErr_Format(PyExc_TypeError, "Unexpected event version: =
%zd < %u",
>
> Maybe "Unexpected event size" instead?

I think size is more accurate to the code, version is more useful to
the user. I believe there is existing use of the event size being used
as a quasi version number, so I think this description is consistent.
If you feel strongly I can change it.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                          sizeof(pevent->event), event->header.size);
> >               return NULL;
> > +     }
> >
> >       ptype =3D pyrf_event__type[event->header.type];
> >       pevent =3D PyObject_New(struct pyrf_event, ptype);
> > @@ -1199,8 +1205,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct=
 pyrf_evlist *pevlist,
> >               return NULL;
> >
> >       md =3D get_md(evlist, cpu);
> > -     if (!md)
> > +     if (!md) {
> > +             PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
> >               return NULL;
> > +     }
> >
> >       if (perf_mmap__read_init(&md->core) < 0)
> >               goto end;
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >

