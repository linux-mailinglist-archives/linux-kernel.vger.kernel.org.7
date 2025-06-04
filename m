Return-Path: <linux-kernel+bounces-673491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC27ACE1DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 18:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5383189AF37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CEA14B08A;
	Wed,  4 Jun 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cxXIqpF/"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00D15665C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749052872; cv=none; b=C5OnbKZyImML0wic0JazTxVLpKPf4AMHytijN0ZrmzvngDZ0f52gjNd4Mz6Lc8C/PSb66qnlIwsyXvQP5IUK4bjIeQqngQb2DP2nI+m9kRxI8u9Po8iCiNyxQ+VeIa/Rzx/6ZQyB74x4HrQ7pTOwdLHuphjtiQz8mh0HCH68D0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749052872; c=relaxed/simple;
	bh=ZNaiqJz3y1AytvrDmYno/j8yL7gmDpOSKywYWodv1CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1CcBKxOWbxEpSHrQTy1QMGjDDYdPz5hRiOOCbL3tm2Ttbh1Qtd/h7NdqgJ45hgWZAsH10HZxlwOzVGIsxewJCRs3b8EUqkg30DMeO3GjbF8cS2znYjXrug/kmDvpIXunehGfYpwZCUPDignsOmPx/Y0z0qRceMCILrKEZ6RIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cxXIqpF/; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so169445ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749052868; x=1749657668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY3VE9czFQShKHXxZIP9vZtbMEDzffpXg7Q/CD6REI8=;
        b=cxXIqpF/ZDCtiHFTvEgqfM8TFUn9gF/6P1FlR9g2/VNLPqxOB5oTuiU91X8z+uifqG
         wLDlLWqzoNqyB9lR/2ArCHziTusiSYv6yAksJJ101Ih9EW3VjjRU3osrDbgYoybQ/NrQ
         4d0CWmVlY/q5lfC71AkfzetQ1M7a1401QAy4cuz9Kgf5JxSAS6YJ/d5O30NfIUj59K8b
         H829CR2B4E2Tx6IPJgI3+m5K+bHmWCc7iSoOvLfjAQiXBm3PJ/oN+NPfZ+H1knL9cEnU
         XLltSE8YUUNDZ0b2fVXgsjIG69bNfSWIO8jMSnrw/exgmZdunfwOARTjsAlC6ra8Oc0D
         Dlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749052868; x=1749657668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY3VE9czFQShKHXxZIP9vZtbMEDzffpXg7Q/CD6REI8=;
        b=P5msY4T7a4MG1GH2OJF3RI8PnatYqfn8Wd9EHoVBCqYS3hj0IqJj60rV0Ej7/p6gX4
         4S/q8E3xAVj/+b3wlFOsag1ApznsUbfCYKNWO7VTKh7rkffH9pi4RiOkRmTztkTY/A6A
         occ1DotQ43UtF96lOZ+soCZLUaP0PO3R21h/2kb70rCe1zWR6+fPNECX9tRHQqNd+2s6
         T5DMMgAlC0GwG9+fXqfNJ3dRsrr89f+OsjTcikVhOG8c/yV1pwnKvqlIN27HxjJ91Gde
         dwlrcR+PUy6tnBWk+r033m2FE2GnZWogEWb2rpGE+rkLAIE01ejjcdx4fGSzutpCEx0r
         SLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwws7YGRH34FuoVKeKcHxvBiyhv65wCavP1LHV5sStnoUd1qO5sXYemsCrYGwrQbm0256OwhHojdDzGe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2D7PqflLtAANfpTzTQ/hIuuS0nQ4x9FUoNw9YWeTXeNvK/0Cj
	yMwSrKgM/b1wS4w3kOoNZo/ewVGWkeE7/2Wlq3nLX3b95zeT9mAIZQxEE6Fd9Wr7uOV4gQcqibL
	THl0FTXNheqa0gn3djKKNuqWsTFBEn0ugU6tQkUzO
X-Gm-Gg: ASbGnctOI8RiqFvn8RALWKApZX/YeZQcggsKVpUn58Z5w3KfhH53XhOhhCymscrcMpG
	yhEa2yfxBEoENHs6RxPdMZhOQcVhXl6Jmw1fb8K2Cs2RFBVWBMeiAhfEaGHiL1h6p9SM9zSwPmm
	VzUcXWOFOLelNTWuwF2cJ2aAM9ovujbs6pjKorouzLJwMNB83Prsok7oWwrGJZfBUYk0+D8Xc+6
	V8V9s2JWg==
X-Google-Smtp-Source: AGHT+IG58E6QDHHMSgG62IIRKhYq/xB75dJaFUT7r81uMOGD1R9JRmeQRMlDFC4MLC5KlZ6EIiSSMdQcueXWylyXmEw=
X-Received: by 2002:a05:6e02:3712:b0:3dc:7e01:6f6a with SMTP id
 e9e14a558f8ab-3ddbe7f1920mr4326265ab.26.1749052868151; Wed, 04 Jun 2025
 09:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604054234.23608-1-namhyung@kernel.org>
In-Reply-To: <20250604054234.23608-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Jun 2025 09:00:56 -0700
X-Gm-Features: AX0GCFsPBzBYxeEG_xn9wHFKD76SA0WA2zT1oLAKGF42jZeceXnvQLoTylM5ZMY
Message-ID: <CAP-5=fUwjAwyhKc=RGfKnZoPz9iKiVyKfBOYxm7EuP2QRsnhgw@mail.gmail.com>
Subject: Re: [PATCH] perf bpf-filter: Improve error messages
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 10:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The BPF filter needs libbpf/BPF-skeleton support and root privilege.
> Add error messages to help users understand the problem easily.
>
> When it's not build with BPF support (make BUILD_BPF_SKEL=3D0).
>
>   $ sudo perf record -e cycles --filter "pid !=3D 0" true
>   Error: BPF filter is requested but perf is not built with BPF.
>         Please make sure to build with libbpf and BPF skeleton.
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>           --filter <filter>
>                             event filter
>
> When it supports BPF but runs without root or CAP_BPF.  Note that it
> also checks pinned BPF filters.
>
>   $ perf record -e cycles --filter "pid !=3D 0" -o /dev/null true
>   Error: BPF filter only works for users with the CAP_BPF capability!
>         Please run 'perf record --setup-filter pin' as root first.
>
>    Usage: perf record [<options>] [<command>]
>       or: perf record [<options>] -- <command> [<options>]
>
>           --filter <filter>
>                             event filter
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/bpf-filter.c | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/bpf-filter.h |  3 +++
>  tools/perf/util/cap.c        |  1 -
>  tools/perf/util/cap.h        |  5 +++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index a4fdf6911ec1c32e..92e2f054b45e91dd 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -52,6 +52,7 @@
>  #include <internal/xyarray.h>
>  #include <perf/threadmap.h>
>
> +#include "util/cap.h"
>  #include "util/debug.h"
>  #include "util/evsel.h"
>  #include "util/target.h"
> @@ -618,11 +619,38 @@ struct perf_bpf_filter_expr *perf_bpf_filter_expr__=
new(enum perf_bpf_filter_term
>         return expr;
>  }
>
> +static bool check_bpf_filter_capable(void)
> +{
> +       bool used_root;
> +
> +       if (perf_cap__capable(CAP_BPF, &used_root))
> +               return true;
> +
> +       if (!used_root) {
> +               /* Check if root already pinned the filter programs and m=
aps */
> +               int fd =3D get_pinned_fd("filters");
> +
> +               if (fd >=3D 0) {
> +                       close(fd);
> +                       return true;
> +               }
> +       }
> +
> +       pr_err("Error: BPF filter only works for %s!\n"
> +              "\tPlease run 'perf record --setup-filter pin' as root fir=
st.\n",
> +              used_root ? "root" : "users with the CAP_BPF capability");
> +
> +       return false;
> +}
> +
>  int perf_bpf_filter__parse(struct list_head *expr_head, const char *str)
>  {
>         YY_BUFFER_STATE buffer;
>         int ret;
>
> +       if (!check_bpf_filter_capable())
> +               return -EPERM;
> +
>         buffer =3D perf_bpf_filter__scan_string(str);
>
>         ret =3D perf_bpf_filter_parse(expr_head);
> diff --git a/tools/perf/util/bpf-filter.h b/tools/perf/util/bpf-filter.h
> index 916ed7770b734f15..187e5bbcc5910d78 100644
> --- a/tools/perf/util/bpf-filter.h
> +++ b/tools/perf/util/bpf-filter.h
> @@ -2,6 +2,7 @@
>  #ifndef PERF_UTIL_BPF_FILTER_H
>  #define PERF_UTIL_BPF_FILTER_H
>
> +#include <stdio.h>
>  #include <linux/list.h>
>
>  #include "bpf_skel/sample-filter.h"
> @@ -38,6 +39,8 @@ int perf_bpf_filter__unpin(void);
>  static inline int perf_bpf_filter__parse(struct list_head *expr_head __m=
aybe_unused,
>                                          const char *str __maybe_unused)
>  {
> +       fprintf(stderr, "Error: BPF filter is requested but perf is not b=
uilt with BPF.\n"
> +               "\tPlease make sure to build with libbpf and BPF skeleton=
.\n");

Generally LGTM. This needs to be a pr_err otherwise nothing will be
displayed with TUI.

Thanks,
Ian

>         return -EOPNOTSUPP;
>  }
>  static inline int perf_bpf_filter__prepare(struct evsel *evsel __maybe_u=
nused,
> diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
> index 69d9a2bcd40bfdd1..24a0ea7e6d97749b 100644
> --- a/tools/perf/util/cap.c
> +++ b/tools/perf/util/cap.c
> @@ -7,7 +7,6 @@
>  #include "debug.h"
>  #include <errno.h>
>  #include <string.h>
> -#include <linux/capability.h>
>  #include <sys/syscall.h>
>  #include <unistd.h>
>
> diff --git a/tools/perf/util/cap.h b/tools/perf/util/cap.h
> index 0c6a1ff55f07340a..c1b8ac033ccc5826 100644
> --- a/tools/perf/util/cap.h
> +++ b/tools/perf/util/cap.h
> @@ -3,6 +3,7 @@
>  #define __PERF_CAP_H
>
>  #include <stdbool.h>
> +#include <linux/capability.h>
>
>  /* For older systems */
>  #ifndef CAP_SYSLOG
> @@ -13,6 +14,10 @@
>  #define CAP_PERFMON    38
>  #endif
>
> +#ifndef CAP_BPF
> +#define CAP_BPF                39
> +#endif
> +
>  /* Query if a capability is supported, used_root is set if the fallback =
root check was used. */
>  bool perf_cap__capable(int cap, bool *used_root);
>
> --
> 2.49.0
>

