Return-Path: <linux-kernel+bounces-879892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA692C2459C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB8D1896281
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E3331A7E;
	Fri, 31 Oct 2025 10:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV9fPo2h"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90291F94A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904888; cv=none; b=f8cUrrdWYm1qo28fAZpp0neQEbDq1jpwPM2p12Q/1BbsK1YipvSReCLofcG4x6sdtCyWI6KpsBKlk3vJm/sfLvT2Zyl9i9MJ2R4xePHRtgNJDhRWRSv8HN0eqY8Lc8/WbkVYmY+Dd3jSY93h8XA1eufvnshEnJl+D4gsGdiJASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904888; c=relaxed/simple;
	bh=RxlkwJ3Ojt2di/C4sMLH7o3fnCk6IDvZ1msbl1LANHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUigpdKGOZD+HSOmZ/5lh9S4OpV/XPgrhmuHDQJNSniwXUhOazEsrEmp/FEV2ImoeJ6V5S4x0QnaNBct0xx2smT6wtvt5RrwjtVXOHQQeM+2/TiITwKpcNGe50abXuU8Zg1v5qCXo7J+58rZlMf9BDRQ+SZ4NO8bxmMJVW8BCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YV9fPo2h; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429bccca1e8so612280f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761904885; x=1762509685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXkLRXL/09XSTQrXWbf80a0LR0KorpKiDD0bgtjB+w0=;
        b=YV9fPo2h3fbM/tKXpU2B05GgGTaHE1f9Cy0JtbhLQPI3iLcIti7wtdA3vpOVdh2JBx
         yclLSaGRiPcKPpyKa+yCoJk04n5aX7asY0MNea3NjJvYUBJ8nCx1UT6Hwh9zamW4A0/0
         9y5xbxzc2B7q9UwvQ/7C6Zs9u9sj1Pq68Do+yo2FEaC8UeSl/9OqoP/yeHW0UDPNtq9I
         2cCLElWRlc6WT3McHf/xcttvNs6hXzwa6Wu8wkKQ5T8nVDF0mawKGtbZcxqlEmMPVLZd
         j1lfq3h85Aw23c4zyK95dJZq5fwmXMt2FZx0FUHPfl2B3WaBsJ/SMbFp2lhMyzI3yfr3
         ZCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904885; x=1762509685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXkLRXL/09XSTQrXWbf80a0LR0KorpKiDD0bgtjB+w0=;
        b=QE1fXNqMDtOuRHi25/vhZl0eMw67doJ1KJR5D+SymyhfZEdjt58hoWFPY4cJkpXUkD
         7EdIiwRZSEzjzOO51NM4QA4A06HUsLkDF8cMPNAsPMb3FJ6Kmob6RcReqNRVBJtGaYFO
         RhsCEx7bNL0x62kHGSoa2HCw56bb0X9awuWVvJ04Z7lt7jpy3XUIME65H35qfjZcKfiv
         eKVRRjiIki0awp9rINLVjlp7a86Fdm1MWkrqN0Mm4HIaKSInY7vHW9PxsK8/OexzoKng
         2NOJF8+w+aH7ecw39UEV6i2KTdN6MgQSe0jeKZBZeQ+yU9Mq6G5pFqxze3euS+H7I4zV
         UlcA==
X-Forwarded-Encrypted: i=1; AJvYcCUbDs3VXFhR59llGBFpJAV2sCFUMAXubKWG77fwpQUcDHiipMETxSF1dvRSprB6omalwwIOrqDSgu5xTME=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjT6Sr7Hn7eVq09vr55HJHwvoNj+gIKjlgB2uXXGAEdgZJ2WB
	LJlhYHLkNTi6UPqi7d2tCpGj5UX2a3xDOFzyFIzaW1G46/+/ydxYzVuBxpylOXbTmqk=
X-Gm-Gg: ASbGncsMkfBcTArXpASuqBzF4lquBS81RyX4lVf9UP8nr9B6ZRdJns3HCH3SrtqriAT
	JOuWdM+9e+Dg1RhdANCPrpq7zX1bgCmRFAyJhRRuYhVxq7YxmV7aN6rGOrZte0O7elTc7HbBc90
	I/zg6k8LzPNUEsZ4m/ZTMWw9THDvO6gOSOiOywFFN3BDcONcP36infp1JPbZzc487UMj6gkOWeI
	X3TWYTC0EQ/Xvnd+eHwgpZys7ObkWdQaWqTwBveTnJHGNlgDc03eNG4Q0rUJqt+AWbgiypxH+Kz
	PskFC2PCgIdawtWX/5cl59n/TWk4H0iZPoPjD+vSdjjIlv94D5IhHplX/ZtHtixlDCW2X6uZq9y
	i5ziZSXa6NlAtk9Nb8dsb/LFuDUPTp+zhxm5y7CM4InuYYjJj+uK17QOJyyVPal0j+INyAANWOL
	hgUEjCmA==
X-Google-Smtp-Source: AGHT+IHILJYq01/jPqFwMyYGkOIuHAOSQvgFVwRuLZ95ODjEyBBLX/lDvwSOY0yg1h/riowuUMPwIg==
X-Received: by 2002:a05:6000:471c:b0:429:c4ce:eeaa with SMTP id ffacd0b85a97d-429c4ceefd6mr167558f8f.60.1761904885065;
        Fri, 31 Oct 2025 03:01:25 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d8bsm2600821f8f.25.2025.10.31.03.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:01:24 -0700 (PDT)
Message-ID: <7fbec952-dfbc-4d6d-a6af-819ec9c81dd5@linaro.org>
Date: Fri, 31 Oct 2025 10:01:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf: Fix spelling typo in tools/perf
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.g.garry@oracle.com, will@kernel.org,
 mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com
References: <20251031025810.1939-1-chuguangqing@inspur.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251031025810.1939-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/10/2025 2:58 am, Chu Guangqing wrote:
> The json file incorrectly used "acceses" instead of "accesses".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   .../arch/arm64/ampere/ampereonex/metrics.json    | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index 6817cac149e0..a29aadc9b2e3 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -388,55 +388,55 @@
>           "MetricExpr": "L1D_CACHE_RW / L1D_CACHE",
>           "BriefDescription": "L1D cache access - demand",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_access_prefetches",
>           "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
>           "BriefDescription": "L1D cache access - prefetch",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_demand_misses",
>           "MetricExpr": "L1D_CACHE_REFILL_RW / L1D_CACHE",
>           "BriefDescription": "L1D cache demand misses",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_demand_misses_read",
>           "MetricExpr": "L1D_CACHE_REFILL_RD / L1D_CACHE",
>           "BriefDescription": "L1D cache demand misses - read",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_demand_misses_write",
>           "MetricExpr": "L1D_CACHE_REFILL_WR / L1D_CACHE",
>           "BriefDescription": "L1D cache demand misses - write",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_prefetch_misses",
>           "MetricExpr": "L1D_CACHE_REFILL_PRFM / L1D_CACHE",
>           "BriefDescription": "L1D cache prefetch misses",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "ase_scalar_mix",
>           "MetricExpr": "ASE_SCALAR_SPEC / OP_SPEC",
>           "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) scalar operations",
>           "MetricGroup": "Instructions",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "ase_vector_mix",
>           "MetricExpr": "ASE_VECTOR_SPEC / OP_SPEC",
>           "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) vector operations",
>           "MetricGroup": "Instructions",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       }
>   ]


