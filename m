Return-Path: <linux-kernel+bounces-809796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3549BB51225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3613B4119
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA02311C32;
	Wed, 10 Sep 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBILnl95"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42720E6F3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495276; cv=none; b=q1Txs5vhJx0DasN5sNKGy/3Pbrl+dsy6PLmld792wINxRp9csmzRRoIX7OtWMz1abt+Kp6IeiYn/2Rfkx8UgAcZR0ubkax6klAyUdZ4im8tQ8JXtCofpEbj6KrT6wqFaJo2aHtgDdXaW+e+Kd0p8JZkdw/Uzz0hjrbEz7KHQyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495276; c=relaxed/simple;
	bh=/KqdALodTvjwyORqZoZyMhakuzS/aLa1iSvmfExarKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCbe8h1TXEN+NSH7RuXrCe9ghAiLwOwB8rrq+MICVNvFtH8Vnb9KfvhN9CfR/7PT2oNP7dJ9dSis63ChbqEOOGdbLFLmR/nj2zsUu66BKiZV1TqQCXYZUk2oFsMoSSYfHyHHqL2Ox7AKANhRj+xdjPU0Tqu/zoT/XUKHh9+raiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBILnl95; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45de60d39b7so21746325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757495272; x=1758100072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZBBmutpjOIPvfZmjaAjseI7obq3YWyXTkmlz+MKTww=;
        b=EBILnl95nPIYk/viFeNuqWCIgBxqGpZtgcRojsOwJrvGc3upeDovdzZEaGUp0c/88w
         aWUF8gsVSD3t5mxWajgF0NKbPRS1oysuzcwDHfEwr1IITURJ1gssjwRwR/o1nd9/KNa/
         HTV6N7i0WOv/4IHr6mcCk2Ewse1NYEcrRgXO4mhfvYwhipwjxsFsLGbdA2UdB1EXuY+X
         sSd96sY4hu/waa75DlbrARyM37QwOyZo2Sg8ENoowwAVLNqbybWwPRv6CfsXm8+jBIug
         Gbp4WcpgeFG3zpaBk/r9oSAlsLSd1d1n10Pf95Fqyo3pvLCGhPeNkoAbZKYC0xHPTjU+
         bYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495272; x=1758100072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZBBmutpjOIPvfZmjaAjseI7obq3YWyXTkmlz+MKTww=;
        b=VMwPeGXPT5YvLRJa/t71R9k66/QtZsNi6e+NJsi0MWR3uSETBZVYu2Oqq0tuBQKBAe
         MNZ4wVpo6KgLAaRp2b3NaKy5axXdCd4bAwZ4KT0+5zJwYkLYV4uk8A3uZurxAsuSItNp
         /9fC2s7XrW2jhXu4UvOkLsSMpPT+kJK+OfG10RYApMdrFNbcZbh3a3NLqoZRHSOUij2a
         VWJWVgcZY/Denpf+uQXZLfWBfHBSAKUAcHEvqonBoGWbEg4wWUMfuM6LHBII8yE355Lk
         CcnEeSka5FVxSDja2brc104u0aKDuScuS+FUkQudLomqy1BNMdM9bx/5C/bMu5Q9Gu/8
         QYAg==
X-Forwarded-Encrypted: i=1; AJvYcCUiXu4YablFaVafud8766r4QKqQA6K4ZivRMdopuODfnH/DF3+3egR3YEtrjYi8VdqjAp5lGuqOJ914yWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPr842hmxqzGKBAQ3y4z6UTzlGdNyplc8ZTbBZUk+hYP5Byrxj
	NKJk/Sa3v8E0nF6sJCgLiSErkajt2QGHojoPpw7zzvM2TvFK5oqQi4cgI9PgIShjZO0=
X-Gm-Gg: ASbGncslo6URlFhZ6yfvY5rD3vXnu5DjqSv08z/Z4g+mNAQhONWkKv8aYNLFdHGxnVq
	2kpxLVOk0a8b9IdWUj9z1iVJPJe+yO7TWYXk1/Pfmdiiz/px5xYbsx8Jw8D9Tg9WinHi8lFBRHM
	jEimntibuRtujlsNgoVIBlAk85fyKzgeiPE6SXS5WpZLZvxBHwOmvnohb5OSQy9/Hsgq50JlTfd
	8ImuLWIOTRvfBfubzy1sMBeZAtBZuKaXpWEI1WSNUXPyIzGXW2PkyZEoidZWiVhEGYtI3SALFoy
	oPwl3zFNgFgY81cEbOrwjcq0Bq7hrk4YGL6LMl/k87KzskpdwG6RkD2JySkvElNs+gqAviRQwxS
	p+nUbc0kOtO0yXzvlW2bKhFvxqn5Oh0Xthb1b6Q==
X-Google-Smtp-Source: AGHT+IEG71ndzP2J+YPiEtMfuV9I+O4GNXaDUWAmn6I8ie847qJ1Bh8O6y5TTlHM2Sn0Ba4AliZgNw==
X-Received: by 2002:a05:600c:a05:b0:45d:d5c6:97b4 with SMTP id 5b1f17b1804b1-45ded2fb475mr47976605e9.9.1757495272369;
        Wed, 10 Sep 2025 02:07:52 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm6457092f8f.19.2025.09.10.02.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:07:51 -0700 (PDT)
Message-ID: <6a24df18-832c-41b8-8226-5dc5b3c9995d@linaro.org>
Date: Wed, 10 Sep 2025 10:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix typo - should be
 l1d_cache_access_prefetches
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20250909210120.9823-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250909210120.9823-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/09/2025 10:01 pm, Ilkka Koskinen wrote:
> Add missing 'h' to l1d_cache_access_prefetces
> 
> Also fix a couple of typos and use consistent term in brief descriptions
> 
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----

The same typos are in arch/arm64/ampere/ampereone/metrics.json as well.

Reviewed-by: James Clark <james.clark@linaro.org>

>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index 5228f94a793f..6817cac149e0 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -113,7 +113,7 @@
>       {
>           "MetricName": "load_store_spec_rate",
>           "MetricExpr": "LDST_SPEC / INST_SPEC",
> -        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
> +        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "100percent of operations"
>       },
> @@ -132,7 +132,7 @@
>       {
>           "MetricName": "pc_write_spec_rate",
>           "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
> -        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
> +        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "100percent of operations"
>       },
> @@ -195,14 +195,14 @@
>       {
>           "MetricName": "stall_frontend_cache_rate",
>           "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> -        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
> +        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
>           "MetricGroup": "Stall",
>           "ScaleUnit": "100percent of cycles"
>       },
>       {
>           "MetricName": "stall_frontend_tlb_rate",
>           "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
> -        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
> +        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
>           "MetricGroup": "Stall",
>           "ScaleUnit": "100percent of cycles"
>       },
> @@ -391,7 +391,7 @@
>           "ScaleUnit": "100percent of cache acceses"
>       },
>       {
> -        "MetricName": "l1d_cache_access_prefetces",
> +        "MetricName": "l1d_cache_access_prefetches",
>           "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
>           "BriefDescription": "L1D cache access - prefetch",
>           "MetricGroup": "Cache",


