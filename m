Return-Path: <linux-kernel+bounces-840434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA95BB469C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1C2189B3AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781832367D2;
	Thu,  2 Oct 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IevSt1C/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB51224B04
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420630; cv=none; b=sk4ExMjXJSEy9YUjqSa6+rULb9hfAiY2drR/zljrFCTBxGTVzV5EFIG1spH3i1wj/OrM+v8DwMrx3ezzVHFH9J+d2+T1gZIWw0+Mf35UaNGz+sqWiMkR3ippX3yEI+E+TSeFJ9QI7r/QvpTm0FGs3kLba0Ii0FgLcp5jA/V7A7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420630; c=relaxed/simple;
	bh=XfUV5XegIWPsrtsXcJ939TwFlfhwct8RclP4jki8I7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOZqx8Rcdo+pbSrrzD2hj5fQDelziYMdu/JaH0PyPsYIfimda19oe3uoAQYGYHyZ/uCekJ8pkCT7LlEyD7qRjIhQhF9gt558e8uXStWFRRh5FxCxpQauw/wz7HOXe4/16AB7UKK5oh2RIMluq74s5rtdyh/Dsrj3LRByFskRPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IevSt1C/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2681645b7b6so169215ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759420629; x=1760025429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY0WE2c/yXBySLtJpxfHDCV+p1YIydI9WOBXVmdAH3E=;
        b=IevSt1C/tMLuZF+hRm2/IDpWwnZ16jCwsFF4vSYMxrKzB/KABFVyWNXViJYWdDRoUN
         NkDpYiFv4VsM3PparTjbmrkQH9+ieBzgb9Du2xLc0H7LIK49m5j0eT99R93OGFPC4ONY
         ZmV+tDGg99bOol4TUyGlLK+b/ceDH66o0gdHDbj5+QTssnneW33NPenTdU+MwG8hhS93
         dFivfc/HIkoVEzFhbxuwh3InXK9jhUBqYRKq89eLa1eECKx6pm1itEIDQvvXQGDRTN+J
         SAOB7XvX0t5tDPcYEE8FQ92quQqvh61e2E6nJkYFvrbL92inTZrMMU90TP9Q1fdyBa23
         50mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420629; x=1760025429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY0WE2c/yXBySLtJpxfHDCV+p1YIydI9WOBXVmdAH3E=;
        b=vUo4HfYkMRXdM1K3Va7kEB6L+oQq8EaWqHas/09zkHE2L5LDFYn4ABhGgWCfD8m8kY
         9q1KD8wBR9UCaTPIOaK7SSdXp3BPQwrsreh3lZessnQcDogdecq4ZBvs4tE0FQfk22Ue
         HVZuTKxcp8fGPcw0qpaHY5j62hi4tBi3ySRaP0lpQjDCTfK394KXfcbegR6XrCNeaoj4
         +mpV6/2iqWcmlu+DhPg1C7zt2jI+kA3RORUE20FKcZY2WRguisNgw7LZZxNDvdeiRw9s
         Qbixxv7YhEIBmJDf8vB7r1PX5lNm5qMIRrG/oyUopyHi9apSs3uAavAs8y1rIey+lLV9
         9M3A==
X-Forwarded-Encrypted: i=1; AJvYcCXC3MJ49vF8+WRArARGXSZw4anDxUHCGZihFpcMqylt9Gr3EdWyywRkIaar1orHtNcUAQya9Q1t+j7zGYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgowUH6L3LYXdzeeLKC0YyA2I3qJzoG41aC3X1bQZAON2aPAr
	UWUEGGEuvvhZimvgTwP+uxdQuPRlXJh3mIpUIEmUlpR9hSA2qOv/3GN8AOEJyhw7JeQoe0sRJtr
	eQ6edVOa/UMiZePQRppVS2msxXS78sdZL8MKPOA47
X-Gm-Gg: ASbGnctfWV9Y/zMPkVHgcy/l0a95FeYSOgfhruM2+q/PXGvcOgjAgRJ60KCsI/mVDZ0
	Z37DV3Xs4mBGX2FblC9Ou/KDhwvGLe3jviWRN3azYgDfKltm9z6mtqF9CMqIip51LRo4Y8afjXp
	keohr+VmAsASjoK5CnepAG7OmR9C7eoH/VovfCt4GlBwCoD96vjmfQxdlbTJspYBjuleQd15uQN
	OZrKWjj749J/qhC2NPFcu3lwzEeK/AvbgBrN6JQBBGFvShHzz6tDD8ENZ5SXqDjN8gRvp4v/D+f
	g0o=
X-Google-Smtp-Source: AGHT+IFbZu1sX8rBFZojBP9UQNCMTAzswKj1VcmmvPpI30Vfx/Wg4Icxratlw1QrTSPIXIcpDbqGAINXJPK4JsnalZw=
X-Received: by 2002:a17:903:2b0d:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-28e8ea7de2amr3923265ad.7.1759420628173; Thu, 02 Oct 2025
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN6eqf1nPwrfa4YU@x1>
In-Reply-To: <aN6eqf1nPwrfa4YU@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 08:56:56 -0700
X-Gm-Features: AS18NWAy6ttVGBpCCgBQZyRBauFGyVfxgmuuXkbFv4KEUdNgaAHzZZ7yH-EwHbQ
Message-ID: <CAP-5=fWBCcwF9jcOh+vWwKU0P04oiTSu2n+bO+X3SaqeDLtx=A@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] tools build: Don't assume libtracefs-devel is
 always available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:47=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> perf doesn't use libtracefs and so it doesn't make sense to assume it is
> always available when building test-all.bin, defeating the feature check
> speedup it provides.
>
> The other tools/build/ users such as rtla, rv, etc call $(feature_check
> libtracefs) to check its availability instead of using the test-all.bin
> mechanism, stopping the build and asking for libtracefs-devel to be
> installed.
>
> Remove it from FEATURE_TESTS_BASIC to not have it as available, as noted
> by Ian Rogers during review.
>
> Acked-by: Tomas Glozar <tglozar@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/build/Makefile.feature   | 1 -
>  tools/build/feature/test-all.c | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 9c1a69d26f5121fd..531f8fc4f7df9943 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -83,7 +83,6 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libpython                       \
>          libslang                        \
>          libtraceevent                   \
> -        libtracefs                      \
>          libcpupower                     \
>          pthread-attr-setaffinity-np     \
>          pthread-barrier                \
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index e1847db6f8e63750..2df593593b6ec15e 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -150,10 +150,6 @@
>  # include "test-libtraceevent.c"
>  #undef main
>
> -#define main main_test_libtracefs
> -# include "test-libtracefs.c"
> -#undef main
> -
>  int main(int argc, char *argv[])
>  {
>         main_test_libpython();
> @@ -187,7 +183,6 @@ int main(int argc, char *argv[])
>         main_test_reallocarray();
>         main_test_libzstd();
>         main_test_libtraceevent();
> -       main_test_libtracefs();
>
>         return 0;
>  }
> --
> 2.49.0
>

