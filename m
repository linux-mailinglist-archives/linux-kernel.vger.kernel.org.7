Return-Path: <linux-kernel+bounces-890821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74CC410B3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982653A65FE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C83346A6;
	Fri,  7 Nov 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYgSftOL"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F21F03D2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762536569; cv=none; b=SPpo7GAe9qrN+HaSs7l6p+E+eBxLApqFnGqbtT0vQx+RCQXncpnV3LxMIioHWW2RtX3X/gHKDLvzG65UsOA5JGTp9TBB0PtXW8EYsraraofgYSrVHq8/KG3K4qV8I/IYknyfpGHhh38QAq0U98CsF8utmBcjaM7i7mf/RVvTSM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762536569; c=relaxed/simple;
	bh=zbewp8TVHFiVctPyX8mXT7il2x1kV98kuvq153m+fKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrtVxhc/7KfuYucO/zW5We381bgpKchh3Q6gljypz4zIpmngVcaV0H+IHmoG9snpgXDVySEl7rjVm5CoMyqpLA7FVhOOCr3ObcoPOTmwHZCl+/CpstDneyGclSPKqrzd82TeI3V/awpI2KAsuZ2Wld7MMQptDXT3Vui5/yhVQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZYgSftOL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-297e13bf404so21975ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762536567; x=1763141367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7nPM32QNJlieCE/UriyUldASiXn2yq1oLIPB222rdg=;
        b=ZYgSftOLT7dVTmXt0Vcw2QFA1m4y3NEcRO3EQYy7ztEED0Wlv0Qz+Tx3ZeI1Y7ZmSM
         e1KiSyDWIO2A7434UwNsBQwxIisNgH+H2Kiq8buwprDC1o+QW7Qo19dMzRuNdLLeBLh3
         PWxA9Az1fciNVzY7BSHJVbr+9xNdpcEhCVD2Sr5C2eY1JZN50dGWj3gL+8NVlFrN0Dgh
         2o2lu5cReVdJvjSxuHpsQFt1Chsawee5WEePTtoVCKLgWFRQg6omn+QtPI7M9xhLVLqv
         wQ7ydhgOB+Kntchvr4x70G7RljocJe1O4zG1zm/eubUis5E6oZa+YOieIC8KInx4U39o
         8DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762536567; x=1763141367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7nPM32QNJlieCE/UriyUldASiXn2yq1oLIPB222rdg=;
        b=BH/3iXiG4rFdG4eUDi18jOJeeWuyrDmI4VsqgwbuiRpdawjOU3hldsxa9bD59SB4dO
         gXXSamfp92S0jktA+dON2FfNvIiTo641FGqbR9V1l9FaYU2Ozieu1lvNDGk0bchUruhl
         +GNi2v6G+4Osd8UWgDuwF8rflCKTYcVsovbg4uw3cW3rCxiU+19jGMPiNqjDyXkVD9oQ
         6NMlPOWCqB14TJrwO5WOicKm0Gj0saEBmzETnxivQ1ft3uclC2lsfmXl4vS5YlVRNtSq
         lMRh5OmcCPqT2qyoXpGfkvanENu6WeFxKZV96bxSGIoaO20hCRSgvu+hhNJ8rIfguSlK
         7SRg==
X-Forwarded-Encrypted: i=1; AJvYcCUz0hBTt3SQMwzTOkf72tMXF1uWgY2Uyhf0Y7jLFuEKDPw3prZ5a9nB/fKbcq+yp6CicnDbCXPfV8DlTzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+tiXoxdN2102Y6WiuqJHEJfnilB/X69tuufV5lbxPBUKl+8c0
	W7Nx7yj03VEkSC+hDCvyL17OyCEkmIqCCwf/3/FfKy1yKtm5FY2F6+VfWcaj4zYSzbxKqs/AVbx
	WCGwWKc9GKo74wz8UlkFUgl5+VweRKjRsOb55Eubi
X-Gm-Gg: ASbGncuoiUgatH2gm4OZnUyiF93odorzK9/NqFjDaww3Y+XeJgSZkd48mkb9iweTtln
	z+uVnPYFzM8lI4kzI+yBv8/qKQPMZON+mAEizlsRrkL0pYzagdd7QR+2Y7oFSU2cUkytbzHDA2u
	+YejQs6246/qwIkRMgrq86QyMBUsGyLIVi/XW8DPkeSzAr8NpznA1JBOaErX80xK1wIdRJu+v/K
	KccTHjvKyleu5HA7D38KxE7OO3aeT52ReFPXNvnihRDjM+06ukuecZEortVbQ==
X-Google-Smtp-Source: AGHT+IHCCUmUqaHnyD1k0tKIu+ZoYBxsPXIJYmkwBgjVCQSW1dvsFN6SmcJdhqi/iyTh3WwlCS+ZKG4Vy9eekXFn/AE=
X-Received: by 2002:a17:903:3e22:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-297c55f18e5mr2887095ad.14.1762536566512; Fri, 07 Nov 2025
 09:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106233710.463949-1-irogers@google.com> <20251106233710.463949-2-irogers@google.com>
 <aQ1NwHzzBjA75w5G@google.com>
In-Reply-To: <aQ1NwHzzBjA75w5G@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Nov 2025 09:29:15 -0800
X-Gm-Features: AWmQ_bkM5BIcKezQ522lHMOqG2MaSEYxoH0S9wPp51pzDlcUltfoHRzwdvlS0aE
Message-ID: <CAP-5=fUG65e4JzqKbJrJY2DAsj56ZLJwFqekgDScMWTCtzycdg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf test: Add test that command line period
 overrides sysfs/json values
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 06, 2025 at 03:37:10PM -0800, Ian Rogers wrote:
> > The behavior of weak terms is subtle, add a test that they aren't
> > accidentally broken.
>
> I've got this error.
>
>   $ sudo ./perf test -v 'record weak terms'
>   --- start ---
>   test child forked, pid 4014275
>   Testing that for cpu/event=3D0..0xfff,edge,inv,.../modifier the period =
is overridden with 1000
>   Fail: Unexpected verbose output and sample period

Ah, the raw encoding from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n745
this will need skipping.

Thanks,
Ian

>   ---- end(-1) ----
>    92: record weak terms                                               : =
FAILED!
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > v2: Add more comments to the test code and reduce the line length (Namh=
yung).
> > ---
> >  tools/perf/tests/shell/record_weak_term.sh | 36 ++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/record_weak_term.sh
> >
> > diff --git a/tools/perf/tests/shell/record_weak_term.sh b/tools/perf/te=
sts/shell/record_weak_term.sh
> > new file mode 100755
> > index 000000000000..ee4bcc792aeb
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/record_weak_term.sh
> > @@ -0,0 +1,36 @@
> > +#!/bin/bash
> > +# record weak terms
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Test that command line options override weak terms from sysfs or inb=
uilt json.
> > +set -e
> > +
> > +shelldir=3D$(dirname "$0")
> > +# shellcheck source=3Dlib/setup_python.sh
> > +. "${shelldir}"/lib/setup_python.sh
> > +
> > +# Find the first event with a specified period, such as
> > +# "cpu_core/event=3D0x24,period=3D200003,umask=3D0xff/"
> > +event=3D$(perf list --json | $PYTHON -c '
> > +import json, sys
> > +for e in json.load(sys.stdin):
> > +    if "Encoding" in e and "period=3D" in e["Encoding"]:
> > +       print(e["EventName"])
> > +       sys.exit(0)
> > +sys.exit(1)
> > +')
> > +if [[ "$?" !=3D "0" ]]
> > +then
> > +  echo "Skip: No sysfs/json events with inbuilt period."
> > +  exit 2
> > +fi
> > +
> > +echo "Testing that for $event the period is overridden with 1000"
> > +perf list --detail "$event"
> > +if ! perf record -c 1000 -vv -e "$event" -o /dev/null true 2>&1 | \
> > +  grep -q -F '{ sample_period, sample_freq }   1000'
> > +then
> > +  echo "Fail: Unexpected verbose output and sample period"
> > +  exit 1
> > +fi
> > +echo "Success"
> > +exit 0
> > --
> > 2.51.2.1041.gc1ab5b90ca-goog
> >

