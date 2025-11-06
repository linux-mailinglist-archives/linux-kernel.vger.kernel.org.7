Return-Path: <linux-kernel+bounces-889543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE705C3DDF1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2DC188956C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172C6345CB1;
	Thu,  6 Nov 2025 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zKwBgDF2"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241C27FD4B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472303; cv=none; b=XHRy7dnmfsT1d1K7RQM3U5hOjpa+vnMCY0UsQts0KhsX50QP73uKtFAuLZnF/36SuOZKN59Q0vDIkxmMi/TLLj8vzrbfqYBVyNPO2uZcJ5SfPNQOsVcEC10oFWyanOycJ9ExUzqomlbUW48lXn8OETNOYxBJeKntHdtfYUuDwJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472303; c=relaxed/simple;
	bh=kKtyHilJrCVcjsLPO9S7pGEmFqVZ69Za8aQVyn2N4Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+MKlIAZaC/O4+wdv03R4TPAUg0J+v9OIUi5mSWNK065J851FDpzSzFytSITMhX5fI1BwoJqMLyouUe6TY8F1E9UDG+hyMTZOebilllzFomI0kBmyoRS8gkdUMYeXihoxsrrC9kj9RRPQASzTBUfkg0n5/E2Ac5nfSrAPQe1u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zKwBgDF2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2959197b68eso35735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762472301; x=1763077101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1PwXAcT89HQpxUif4oSkILLGPMZg/5A5vnVf7vGCaY=;
        b=zKwBgDF2yJPBL8HDahvQ8OWyren7OfmN7C7MFigxW3Ye46OZSGPlqorMSnYLcbDy8X
         GOs4E5WcSCYhCPPzEFd6yBJLu+m+DIS2l/olcecUODMARN6g8bDyXmwIfhjgomVhbjjr
         54L8JPMAZNX/X4ZItAHh1Z2cFKSFC16kRZ9ip0qO/MTkvzS4O955ZzO99co8UlGqsxeS
         Wis1ratAJmZA5oaui7j60wmSQVqY74eMK4t0xxrHMeb18pZHbIcwGnlbbpzjZiMLvgia
         37V7ZpuDlbZg4X+fKxEvUWqWVCHD0pJoRn2meAchw8J6MN+8rmP1tZyRf7jogjylv+Q+
         C0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762472301; x=1763077101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j1PwXAcT89HQpxUif4oSkILLGPMZg/5A5vnVf7vGCaY=;
        b=uhr/id7KNf9hiKJ2uoFHVkKnPndF4pq3CsemOOhDYTQC7BK0kQ017Eow0Xv7paBJSM
         6Nuxes3nt4PyExbSfc1NkDmuHK1YNfkDEh9/syt6+W1POm0PLh9wOxLUNFIx742fXBqY
         IFlAQTYWEI4qVwU/iDTThSm+oSy3zbrKh4iJPEp428FGH9tTdVNVQOu9Fqo9ttNvGUWO
         L64ZgOOG/oZRFFUUsFsTu55tmYxK/6uvpNV2ZYFifGbtsl9xsAGCANdrd/J3BIxnT+sR
         xrzhRRDT0Ftfx0HnbvsJ97SKDQVoTMuNw9gF/+Lkt1Iz2xLT5J5Eekrsho3F4TKWBGQt
         VDIA==
X-Forwarded-Encrypted: i=1; AJvYcCVvpny512njjxWGe1X/QCJo6zj8PCJ4ii/f7l7zoQ/HNW6vIlw8aOSudTbncBqOGF4wwefmXz08Ib0Xg4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzyjfsIo6x7uUr3b/2wusB5ybz1QCHRMX82dXj6+F2JCbjG/D
	YwWQUvjFN6bTYRaUGHliL5nmv9m1klbWK976BPa4NAnDzCzoThkiNIDjXHAxtpuYvgflR9PR1d3
	YkpJKe7kHDnOrC8NP/o+SCn6v9znDX/bgSFOX3/zx
X-Gm-Gg: ASbGnct6pcqrbxXk7ztUYRgTb3OjbKjbLVX5zbV33ZiLApdqOv6qEEnCYAEHl7//BQU
	cWwVhgPBmfBhYniug/ci1sAIzC4OsWYibHXvzmO33bi0QZLrCcG0Z8wAFioevvAtVVyXaqH/vI+
	13oaYYUMAOY9Ec9G1E1xi8YR+AOzBTZRORleKy49ChCaxcVWK0oFKo7pl1klH5deaXVOfNA9poH
	8MvIhQd06DCia3vjc8fh6dND835qkOi9jO1GNm0e84VY/hngScAo5dElLpmv/0weorD1uhWBmhT
	DXnc2dbpjMiPgtQ=
X-Google-Smtp-Source: AGHT+IGJJ3lwB085iP2R/ZlwLMAsIYSqK7dqqcBXU8QJ5rl7grXhyqG76mtWDwM5t9Dngt+P3bg/XnF0LKLCG25A2Qs=
X-Received: by 2002:a17:902:db09:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-297c65eea8bmr623025ad.5.1762472300935; Thu, 06 Nov 2025
 15:38:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106190023.1772629-1-namhyung@kernel.org>
In-Reply-To: <20251106190023.1772629-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Nov 2025 15:38:09 -0800
X-Gm-Features: AWmQ_bljI_f2uytnloy0lA6O16iAz_x-MIuDDey7DKEd94Wwo6VIX3aA9bDHXQA
Message-ID: <CAP-5=fV-cCjdKim8G6OuA5u8n6AE+Bgt3brN2eWd8YxgFGx7xA@mail.gmail.com>
Subject: Re: [PATCH v2] perf record: Make sure to update build-ID cache
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:00=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Recent change on enabling --buildid-mmap by default brought an issue
> with build-id handling.  With build-ID in MMAP2 records, we don't need
> to save the build-ID table in the header of a perf data file.
>
> But the actual file contents still need to be cached in the debug
> directory for annotation etc.  Split the build-ID header processing and
> caching and make sure perf record to save hit DSOs in the build-ID cache
> by moving perf_session__cache_build_ids() to the end of the record__
> finish_output().
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> * fixed commit log  (Ian)
>
>  tools/perf/builtin-record.c | 30 +++++++++++++++---------------
>  tools/perf/util/header.c    |  1 -
>  2 files changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index ffb94a8339b03ec2..fe10bb7f35cbea05 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1890,15 +1890,14 @@ record__finish_output(struct record *rec)
>         }
>
>         /* Buildid scanning disabled or build ID in kernel and synthesize=
d map events. */
> -       if (!rec->no_buildid) {
> +       if (!rec->no_buildid || !rec->no_buildid_cache) {
>                 process_buildids(rec);
>
>                 if (rec->buildid_all)
>                         perf_session__dsos_hit_all(rec->session);
>         }
>         perf_session__write_header(rec->session, rec->evlist, fd, true);
> -
> -       return;
> +       perf_session__cache_build_ids(rec->session);
>  }
>
>  static int record__synthesize_workload(struct record *rec, bool tail)
> @@ -3083,7 +3082,7 @@ static int perf_record_config(const char *var, cons=
t char *value, void *cb)
>                 else if (!strcmp(value, "no-cache"))
>                         rec->no_buildid_cache =3D true;
>                 else if (!strcmp(value, "skip"))
> -                       rec->no_buildid =3D true;
> +                       rec->no_buildid =3D rec->no_buildid_cache =3D tru=
e;
>                 else if (!strcmp(value, "mmap"))
>                         rec->buildid_mmap =3D true;
>                 else if (!strcmp(value, "no-mmap"))
> @@ -4192,24 +4191,25 @@ int cmd_record(int argc, const char **argv)
>                 record.opts.record_switch_events =3D true;
>         }
>
> -       if (!rec->buildid_mmap) {
> -               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> -               symbol_conf.no_buildid_mmap2 =3D true;
> -       } else if (rec->buildid_mmap_set) {
> -               /*
> -                * Explicitly passing --buildid-mmap disables buildid pro=
cessing
> -                * and cache generation.
> -                */
> -               rec->no_buildid =3D true;
> -       }
>         if (rec->buildid_mmap && !perf_can_record_build_id()) {
>                 pr_warning("Missing support for build id in kernel mmap e=
vents.\n"
>                            "Disable this warning with --no-buildid-mmap\n=
");
>                 rec->buildid_mmap =3D false;
>         }
> +
>         if (rec->buildid_mmap) {
>                 /* Enable perf_event_attr::build_id bit. */
>                 rec->opts.build_id =3D true;
> +               /* Disable build-ID table in the header. */
> +               rec->no_buildid =3D true;
> +       } else {
> +               pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> +               symbol_conf.no_buildid_mmap2 =3D true;
> +       }
> +
> +       if (rec->no_buildid_set && rec->no_buildid) {
> +               /* -B implies -N for historic reasons. */
> +               rec->no_buildid_cache =3D true;
>         }
>
>         if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> @@ -4306,7 +4306,7 @@ int cmd_record(int argc, const char **argv)
>
>         err =3D -ENOMEM;
>
> -       if (rec->no_buildid_cache || rec->no_buildid) {
> +       if (rec->no_buildid_cache) {
>                 disable_buildid_cache();
>         } else if (rec->switch_output.enabled) {
>                 /*
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4f2a6e10ed5cc0bd..4de7ca16b5522c47 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -335,7 +335,6 @@ static int write_build_id(struct feat_fd *ff,
>                 pr_debug("failed to write buildid table\n");
>                 return err;
>         }
> -       perf_session__cache_build_ids(session);
>
>         return 0;
>  }
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>

