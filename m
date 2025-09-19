Return-Path: <linux-kernel+bounces-825260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA8B8B706
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F663AA99D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37AB2C21D8;
	Fri, 19 Sep 2025 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d07SdBEq"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF30A21CC4B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319512; cv=none; b=jR6LfZkT/yDwjrMdzLapjRKpNjF4Vzay69wmQAndqdgy9bqnfl93hVNJl5mPgJXYfAXuORHwydAK+y9KmM1MtP5Kfkh9EK6DjBu5eJRoipQHJDX741r4VK39kwoBuM7mAmPZlskOis2PJleiMIAY6sHs1Al2kOWk8Re0pwRQKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319512; c=relaxed/simple;
	bh=6KcwGbyKyWd04fTuFc3L7FmrReNWN2OApLVAZkWwYvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7NKuE00WgCA4eWomCiDqN6ZI49Y0c3WdkBLFPV4onP+Y3VzZYKzRVGcXVfdl8xkaH5ksN8+pfy1eIjxn+u5I4f3ujq8trz6bNiNYZDj3DC7Ko1fF6vlU+qOd1z3pWlmGcaivvMaTwY1ON7MLg9/ZsUKiN+P4QiTjrU3VjfVlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d07SdBEq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26d9cd643eeso51685ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319510; x=1758924310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJoMMMDvtSGIW+dsiHUkoZlTKzG4OpnrIcCQBgjIcf8=;
        b=d07SdBEqnxUVGgzdeOcH1p7FZMtn5hoi2DaTYhtYEs1tvkJnMPhLNBDjaGYl5kWKhc
         S9bnfihoMMHgtX7c2jUxuNt+rT6gDJv8umeGyBKFpCF5fE9NQEUsW4kBP/Y8uAsJT4/X
         /Cg+tqRHmyfPvfXP6lisq/y9rq1eK1umPqyfU7QU/TXBWfdKFpOKVSl4RQg3P03wYop8
         oevxrW7+/iRLmnpzYvQjDQk0/3a0UYR7kBs8t4ADRZHrJlBQjqLvQqGOfgk5KJXjHHhh
         vIQTfj0J3X6sjotml7XSPo53YMGXXvsSegLZ3OH1Ex9Ycy6RdpuXV7VNsAyAigEFkss/
         QX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319510; x=1758924310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJoMMMDvtSGIW+dsiHUkoZlTKzG4OpnrIcCQBgjIcf8=;
        b=h5YNVFSpkfmE8JQR6cM38i76XTLQDWf3II+TyKNrMSe9exVyR1hwKwlY5qM6XhdU/K
         oGCZjYYkq6EgOtuMDhMOUJSrmeigKZ7rnR3eCTVaXM0X1JGyh11/HrYh53Rgpi5ePAFM
         jy8LVnNpFA0Nf3dGZb+S5UAVpRkK4PGa/u3MXxqHyBaQo7fKohUi7NBsterQUBqYAJvs
         fjKFz6IN8a6DX6tIQjz0fdSmQWG3KL0cORlyj2OeJUDx2vJwq/bmxjcxviVS+SZrlvhP
         gEURkRtm06Z2VIFxNpUM6R/4Jgkhui8iR6VHmWMmiImmIsRpvWiNOkzAmF5q1FO374LJ
         3HMA==
X-Forwarded-Encrypted: i=1; AJvYcCXcez4K5NKg1XIytg9p026E/zahIupKNWvwS471xl60naJWzX6VCECy7SmLeMWuBASJqEPrqHGmV2m6BWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7ZPYmsI+YmMonYX6rAGZ8tBJs4f8Q7/o6DKw5oCGDPMzUr/2
	ptW9CpoTVUqOT5g/R4aNRB7D0Vy3hiRVBJaSAejTv3/Lpir/Tqurere3Ci7b35Av8QRiOKj/xKQ
	wwtkPTymkTx/DjWq0H15+IGQM8RptWozBGU6zNx3P
X-Gm-Gg: ASbGnctFPJm1myI3BgT6e1szPiBKJy7J+6gtZN3DC1V4WiwwvK5eGarXYsvCSNMRX3z
	d5HiPH6QisWSPCHrdC+poRI09fVmDfpQoPnq7QvlS4UU0LrSOZ+XGDY/FTsGMLYdZmJrgwPAYHh
	09nMLkiotIg2mOB7wloo1Gug8HoWwexrdi7ZFANpclf1EhQdBDZ+uNN206Ykf508d8XftWC9r48
	kARTj1ssWP5jrZ6Jl8=
X-Google-Smtp-Source: AGHT+IHAJgOzbjIExfxgko6BvGtIfBkWT0zKJTuV+/XWfcDOQjts0tJ7Ntd88E7Ua88b/BhYT1lyoSnTK+B/nQQsEDU=
X-Received: by 2002:a17:902:ce84:b0:25b:ce96:7109 with SMTP id
 d9443c01a7336-26808a34a15mr14928385ad.3.1758319509760; Fri, 19 Sep 2025
 15:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <20250919210654.317656-2-acme@kernel.org>
In-Reply-To: <20250919210654.317656-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Sep 2025 15:04:57 -0700
X-Gm-Features: AS18NWBqVCsN5p-tZ2_6bLdC8uuLwNKZxkJKKqGFC1TELiX6OJM09P1JQhExQKc
Message-ID: <CAP-5=fV2dWSczTMpvRA_byh++tXta2vB2OT1ehSiTVSFtEBkPg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro
 to bpf-utils.h
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> We need it to fix some other libbpf version dependent issues when
> building with LIBBPF_DINAMYC=3D1

nit: s/DINAMYC/DYNAMIC/ :-)

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/bpf-filter.c | 5 +----
>  tools/perf/util/bpf-utils.h  | 5 +++++
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 92308c38fbb567ba..1a2e7b388d57d367 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -56,6 +56,7 @@
>  #include "util/debug.h"
>  #include "util/evsel.h"
>  #include "util/target.h"
> +#include "util/bpf-utils.h"
>
>  #include "util/bpf-filter.h"
>  #include <util/bpf-filter-flex.h>
> @@ -443,10 +444,6 @@ static int create_idx_hash(struct evsel *evsel, stru=
ct perf_bpf_filter_entry *en
>         return -1;
>  }
>
> -#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)                       \
> -       (LIBBPF_MAJOR_VERSION > (major) ||                              \
> -        (LIBBPF_MAJOR_VERSION =3D=3D (major) && LIBBPF_MINOR_VERSION >=
=3D (minor)))
> -
>  int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
>  {
>         int i, x, y, fd, ret;
> diff --git a/tools/perf/util/bpf-utils.h b/tools/perf/util/bpf-utils.h
> index 86a5055cdfad6689..eafc43b8731f1e31 100644
> --- a/tools/perf/util/bpf-utils.h
> +++ b/tools/perf/util/bpf-utils.h
> @@ -8,6 +8,11 @@
>  #ifdef HAVE_LIBBPF_SUPPORT
>
>  #include <bpf/libbpf.h>
> +#include <bpf/libbpf_version.h>
> +
> +#define LIBBPF_CURRENT_VERSION_GEQ(major, minor)                       \
> +       (LIBBPF_MAJOR_VERSION > (major) ||                              \
> +        (LIBBPF_MAJOR_VERSION =3D=3D (major) && LIBBPF_MINOR_VERSION >=
=3D (minor)))
>
>  /*
>   * Get bpf_prog_info in continuous memory
> --
> 2.51.0
>

