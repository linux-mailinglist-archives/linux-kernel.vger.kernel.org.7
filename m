Return-Path: <linux-kernel+bounces-843541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E896BBFB13
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A7E3A941D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134651DC1AB;
	Mon,  6 Oct 2025 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV2ooRbm"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D4196C7C
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789482; cv=none; b=rlllpxR6UZgO+YluxtmxGlluqo1z9PpzGvjjJg5RT5ykGz+jcyjEXGBl5spUfIKVnBagLe/64lWBK4RP70Qocf0kotHZ6NdNp2HaOy+iYP1seFcC4vO5P+Tx4v6q1G5YN0Saii5fYnOIsPPs3lA4GBwLlLUT1mF9ak8BATvu39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789482; c=relaxed/simple;
	bh=ZzEjdQ3Ctlt2q9UjuwjY8sL9bTZfjoRUrpSLbw/FI2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k5agJM6NmlHMN+ZuOQZUKKJTGpqNuyIgcWyS7AyDG94X2JHBTL27JYDuvgwBU/bi0ruaGUu8IZQx6iyQVGgspqtBkxrs4mn9qjg4/Wlvm2AXUTXZfQdfb7FBpurPlBiMF3PLMbYO+cVKK8GMjTcXjKAwAmCVUlmf5pwQgcXbbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LV2ooRbm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2681645b7b6so29555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759789480; x=1760394280; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csUKuBy/cfwB0rrhjYySeSh9a7d+66DcWdMpSkcGTEM=;
        b=LV2ooRbmrWd9BOCHXl+BHvv/ZahR/FBrj9jkbL2uPLmcYSqSAg354xhYOEkey/GSBz
         CZQYBbb9MAJzte3i3orlur2kFX5dqkhbJLGHmlFKCpvkKF77XecK19ysZTSO9zM/m1Qb
         0oEm5cXLNP0qNSh2KZcihBo7Ohkx8w2NcVYzjRjgi/tVzam3MlYw86Q2UMS+cqYj4DfI
         yVS9qax+5fGjV75XeyaL6wt7DB0/313to5XiPwDLrTjaV+ssxEWL8EX2+y147dUY4vwF
         l6Irciu2hRGWfzKV3x98HoRNvbOx8VNaQyxcM+8NvB7Sc+1/LoF9ub0v3aQj9dRb6ZhW
         KoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789480; x=1760394280;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csUKuBy/cfwB0rrhjYySeSh9a7d+66DcWdMpSkcGTEM=;
        b=qjEQBKPvhymEMBmhZMAD2XY3uCCuCc9qwT8ENQdMWiVPThYAVEnftIBvvuDIYoEcuW
         +6KVf/Y+3uYK7hjHbubNsfhPZMFFneKR7BpVFdGVDx63JKQ0j4Ase5+U2ygpu3SIwPhU
         jwsk8YA4LjoaUk8T33zN1TgfQ5JxLphtpskCSSNBAJsZVjUoqFvEIFJDZZdECmGJkFXa
         9JJDKCVbK1G7/VwcMlPv3RWH799viAo4LX7KHwkUNMwP4Ai8zNROny12Lv1ZV4+489ei
         6WpVeaZxMA7bf49sG4lGGlny75ILcnMzyncS1XmPPwI4q+JWqRQic4tCttltlzT1394V
         qLVg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Mj+ou9XYZMBs8PlR9L1+41ufA2m1qFmV5f5QdqvZxghN6yrMdtD9TkjDqfxOSkqhaeLcziqsKJcZlbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvdKjLPMYAL1+/R2OsNyOOcJoIXABetZPX1qsWzKDCrngE6Ua
	CbR16B1BQdOPXv1yYwlNKldor90MvOovW5oe4SqlTh+gRpdZS/6pBs4xaRF6eRap6ZFUt1tMLeb
	5uO1+ttH7EY4JaSQ+C6XVfThs7YPf2lhQUHA++6Nl
X-Gm-Gg: ASbGnctJ3ZGf9XtQjfvfLwsff5NWvYsHXT4dsbzzuQ5GscVNj6c3naOCLGdeIh8HluX
	LHM+zERhf9P9uO9RlYutvme06JS53/Goax9tCGqfcIj0fOCAAaC1YPM7MAEr0GJuA4v1M6i6Fer
	7VifgXr1p2Y7dMOD0kQf8kt24OiS2fuIQapp5oFf2CCzyyj5IjgUoC/tpLJmh6E6n8mlPeN/7L7
	WGHbtOxdaFCKJAd3Fx2PttwVi3AXSzIe7GWW6W9bX3uw2d5kkCA3fMsISDwtoXtg9W2
X-Google-Smtp-Source: AGHT+IG8G66y1nO9UVw8rOFx+n/thLkwl0ArE55uKz7jbSHnJDPIVWJsU206eEQU7TiWRH9QC9ziDBifo6OAAslWGrs=
X-Received: by 2002:a17:903:24d:b0:240:6076:20cd with SMTP id
 d9443c01a7336-28ecb769fd3mr795835ad.15.1759789479891; Mon, 06 Oct 2025
 15:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006222116.3335193-1-irogers@google.com>
In-Reply-To: <20251006222116.3335193-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 15:24:28 -0700
X-Gm-Features: AS18NWB_2GJZPs9mIpmzgg8B7DFq11s7c_bmSvm4OYKklR3eKQo9HSIAnjYj1E4
Message-ID: <CAP-5=fWo66PRxCBQSmwy4C0X75k9fagy8OrphUyh72ciwc1Ggg@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Don't leave a.out file when building with clang
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:21=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Testing clang features doesn't specify a "-o" option so an a.out file
> is created and left in the make directory (not the output). Fix this
> by specifying a "-o" of "/dev/null". Reorganize the code a little to
> help with readability.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Maybe a fixes tag of:
Fixes: 5508672d7f49 perf python: Remove -mcet and -fcf-protection when
building with clang

Thanks,
Ian

> ---
>  tools/perf/util/setup.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index dd289d15acfd..6caf2126b1cd 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -22,8 +22,16 @@ assert srctree, "Environment variable srctree, for the=
 Linux sources, not set"
>  src_feature_tests  =3D f'{srctree}/tools/build/feature'
>
>  def clang_has_option(option):
> -    cc_output =3D Popen([cc, cc_options + option, path.join(src_feature_=
tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is=
 not supported" in o) or (b"unknown warning option" in o))] =3D=3D [ ]
> +    error_substrings =3D (
> +        b"unknown argument",
> +        b"is not supported",
> +        b"unknown warning option"
> +    )
> +    clang_command =3D [cc, cc_options + option,
> +                     "-o", "/dev/null",
> +                     path.join(src_feature_tests, "test-hello.c") ]
> +    cc_output =3D Popen(clang_command, stderr=3DPIPE).stderr.readlines()
> +    return not any(any(error in line for error in error_substrings) for =
line in cc_output)
>
>  if cc_is_clang:
>      from sysconfig import get_config_vars
> --
> 2.51.0.618.g983fd99d29-goog
>

