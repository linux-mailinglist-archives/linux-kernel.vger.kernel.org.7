Return-Path: <linux-kernel+bounces-799095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBEB426EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD4F3B3DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533322F0C5F;
	Wed,  3 Sep 2025 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt827w6v"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC992E6CDB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756916937; cv=none; b=X3g1ZKu0sT/AnRP3uwQgng19F+aIRPqMJPFI58Bua1yjRiX2C8J2cCvw89DY2d7cTtWkJkjHR4E8CNRD0Yv7ymyR4nLpsqJgJhSGPwHgFGsJVZLfNhcpb20Re5ISvKiCjPTl2N5Os+X7RlGGzOCCM+CEfz2dSGPZ+XM3JgbHT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756916937; c=relaxed/simple;
	bh=gHqDPrgBowyiL/sR10xX7tCoLg/UtZOXeCKXzFhG97Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5F3QRHZ5BpnY5hONF5J35T5dfSdzaPhl7I9DX7HnJnezBYBFCg3bLDCaiegjk/wTXhHjoVSu0gmySYGuJNUOhB1SaIFby+kC9rCNpPz+jBhI6ylaPc8c8HHysA1PtJiMiUaQaeMV2iulOV8FK2bhS7i8hoPI32pHy/tIhJ+RbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt827w6v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24ab15b6f09so206025ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756916935; x=1757521735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkzaQdVLnKFZXbvLfVWTo4jS+1+R+7yKNhtbqs6gLsA=;
        b=Mt827w6vF0i26syQa7LEhglHJKz0of3DkFIlkfTZp9rSgQnrN4HepjSqpDvWO1GEjy
         yDMRJnJ7ghI7IBUnyQgYpvzWNhmXAR1G6210JuNvQ7lzap53HJj+FAaYP2Ibl0sIGZT7
         /wSxQNaxGCumXHeXRlbgpmK0x/K+M9pDLnO9E0fGMAq1WDeLSxqwFwMn9FLTi09AWevM
         XyiDjOG6ZX9LUfj2RqoUxPvenCLYGUzhJptaMD9deuCef7aoQnqmOpG0yr4BDtwl+VKI
         lBGlcdaT9sf0l/Tefy0nB592WtwozVAiEBvHHdhui8EeiDJDjSDoCr7a0C7hgUn+qnUN
         OQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756916935; x=1757521735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkzaQdVLnKFZXbvLfVWTo4jS+1+R+7yKNhtbqs6gLsA=;
        b=asFF5sxj9FswWWGDUsoTnpw5wRMuA75lwqxVebM6EC94Wjw4OebztZy/iFU76g9T+g
         9xJiRCUiCGsiT2SkPPS9C+OK3PJDEdKM+81aayHsf17+tNm+JpDwpiV/tmjdYZ5ICOWj
         Zcjtlwy1xLmdQ+Unb3ULfPjAoZRRo3WhfFrwmr+Xci6lLPu7OrzVKeIzSkH1YEz8wsKX
         qPK+6FEi3YaAqSwNikpBg6T6NG7ZcCfgMdKPXldGhYw8jortA3T7+8xSE4TN6Y6HUjYY
         npiYLDte/loxSzWjBw0F2Bem2te0sjCMBZ4v8wby9Wc2uBEvt1fB9HUMSwvF+5Vkw694
         OxGw==
X-Forwarded-Encrypted: i=1; AJvYcCWu2Q/yesQZA3/SIoOJHurOfPLOij7ckV4CCHr/9Hduk4gT2J3sFMtJAZti/JmB27z0k5t/N9zJCUJ7LGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCg8gPYrps6lVTEQxPy3GFQjcJkMJ27lDHsvhgVxht6TXYULR5
	RldapxJCWZlYr7qD1abgzQDJHAV/ZWHqKO3A1Hvaff8YRGfa19zVzzH0OvTOQWQFcqnJVI1IU9F
	Lvk/w1id5zoRg5LcMfoqQ0Qcg1Dv7Wg4hx6JDAbrO
X-Gm-Gg: ASbGnct5nhhwN/tB8IbkAFND1vIZmYrveTr26CwBHnWOIHffTQWU4WlLcVzoxAu0zUF
	ia+ggY5ZhIJaVu5NHCs+4wkfXjemRAgtOh8kxBofmsd7jKo38pkdKHunKVzKMCRSilA6f0hmn11
	Po/zLBGZouF7RkQ+mofCQiHaMjfL6eX6UKFJY89dDFGL3qQKh8mEQTs/7g0sd0G3FUmKRerXP0r
	0M+ozbSxp05NAwuM6EiGXAgbGiMe9T3YkfONyY0wjoD
X-Google-Smtp-Source: AGHT+IFLvogXoWj7bYgIYljO7Kq06b7Mx2huDYeeQfQOxWOFq1fwFiBFqisnFFT1giElvHyfpoFKP1+sUC4j9uhlhrw=
X-Received: by 2002:a17:902:c404:b0:248:f683:e980 with SMTP id
 d9443c01a7336-2493e7bec60mr5863425ad.2.1756916935150; Wed, 03 Sep 2025
 09:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-james-perf-read-build-id-fix-v1-0-6a694d0a980f@linaro.org>
 <20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org>
In-Reply-To: <20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 09:28:43 -0700
X-Gm-Features: Ac12FXxbJVOMs9ZoCA7IT5qWj0pUUT4GbYHwevYbRn2uBnh2ATV_lVvROKlpx8Q
Message-ID: <CAP-5=fXVw4zokEM2hUpbBbJyxQmE3YgyEf-umVzsFhw7vaSK9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tests: Fix "PE file support" test build
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:15=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> filename__read_build_id() now takes a blocking/non-blocking argument.
> The original behavior of filename__read_build_id() was blocking so add
> block=3Dtrue to fix the build.
>
> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__rea=
d_build_id")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the fix!
Ian

> ---
>  tools/perf/tests/pe-file-parsing.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-fil=
e-parsing.c
> index 30c7da79e109..8b31d1d05f90 100644
> --- a/tools/perf/tests/pe-file-parsing.c
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -37,7 +37,7 @@ static int run_dir(const char *d)
>         size_t idx;
>
>         scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
> -       ret =3D filename__read_build_id(filename, &bid);
> +       ret =3D filename__read_build_id(filename, &bid, /*block=3D*/true)=
;
>         TEST_ASSERT_VAL("Failed to read build_id",
>                         ret =3D=3D sizeof(expect_build_id));
>         TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_=
id,
> @@ -49,7 +49,7 @@ static int run_dir(const char *d)
>                         !strcmp(debuglink, expect_debuglink));
>
>         scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
> -       ret =3D filename__read_build_id(debugfile, &bid);
> +       ret =3D filename__read_build_id(debugfile, &bid, /*block=3D*/true=
);
>         TEST_ASSERT_VAL("Failed to read debug file build_id",
>                         ret =3D=3D sizeof(expect_build_id));
>         TEST_ASSERT_VAL("Wrong build_id", !memcmp(bid.data, expect_build_=
id,
>
> --
> 2.34.1
>

