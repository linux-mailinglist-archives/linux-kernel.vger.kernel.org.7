Return-Path: <linux-kernel+bounces-811619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46577B52B98
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0333BDD72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1852E2E0402;
	Thu, 11 Sep 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhHfrSZr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704AF2E0924
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579213; cv=none; b=K7l9WgCbiOE585IJqfyYcD4yBVFi9OJ4bd0mA1lnaafU463doZHkwN+hIkZkwACnN8GlGfPn/oxRf5ZgwJVd5HbWjOcUyhAQlqfGf9SG7jcblvXb4gy0yZ9o68MIbQoOxpQG9wlnLBg3kbBsyyQe28TDij+IO9HUCRq4FiMiYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579213; c=relaxed/simple;
	bh=DKTBpuEONVJR70U9ttKIpABJQPw9PwFQNxY5yDfots8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTFR1r5KG4lWYMDcGsuRSwZ1eoMouIfDqqMaWw85VfEj51MDPPRAIWNxm6ubA95bmuCNChs/F7L0QmKRxCN774DtU8GFodzBb1EZ1f//MKbfgghUosMePnZVQ3aEIX9jaGxN075iqzZQ6nSpndO30va9aq6cvtpuMB+tOxHnMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhHfrSZr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso2612825e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757579209; x=1758184009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmswRsDV85LAGSgZM1TnGtsRJLjTs07m6UjoRfbX1i8=;
        b=ZhHfrSZrU9rxPAR/2seHDjO/jneCvPL/eItUmibDvM41muqCVCSGbnoamC9QNot1lv
         30kxWfCZbjCE2LiFblOga0gDqVIf0c3NDenoEY6SXEiHSQP8+JcQAOKfy6jqqt48w/J9
         qETttRW2H6LJBhQB7PLOeO7zMvNDTyK7mdDVaFFfMs/Xb7y47mi0pNhx/59+Eo2bcUxd
         Wq5zalP8LAxhFvNf4elVCZUTw7hORTygV0GhCcqNJwYe4Ex83TVtKCKAlJ7ssOrIe2ob
         iV6JaG24fIp8wyFpiW9ClHjeMQTIHRJ+lH3bjgn9rdcsq2Yyo6C+kZhPGNLbmh2P+jvb
         BANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579209; x=1758184009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmswRsDV85LAGSgZM1TnGtsRJLjTs07m6UjoRfbX1i8=;
        b=l0WmAVb3TdF7OF49ehm07jDe1po0DErRejRZNBDQUWP+uyhO+T+CGs3VoozOUS6/gk
         GorOz6l1QzeMAIso7+mvYxjCsA+WlpI5Yy15bjpObRDT23CIBSAYHo8iMN+/tl6Aiqwa
         YBWdpSrHKQyWoTfGq77MjUzligI/CuXMIIrqWzu9IjGUCO50g4vBCtlHUNLrdIF+VrYA
         dMR+TBQuf8aqjL8DRW5wTdgTSHcR/a3QjjrSg6TVpOwbXXBY+K+ss9FLg68bkUXV0wxl
         oViPgbXt5DohBdZ6AoJIYBOiNh2s+BW+t3qUGXx+gntV4tk4pMYQxPDYDQZw4/aAGd8s
         DqzA==
X-Forwarded-Encrypted: i=1; AJvYcCVZQlVReQqAQnjzzEcCfjRYBCHHpI44JFWNhqHBxrdOCcWIW8QqCyKNEY5oex86yKIgJZCHmDbjdwPUDc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwVHSMkJolAbvgMxbDszgPEfj6xsbDyIhaGps/OLbm3kh79aZ
	d5elBdcZbjrfsESopGH0KCVowBELRPPGvGOXDy4uWR0vKdAO7LrgsRvYUhWKznoTVr8=
X-Gm-Gg: ASbGnct1emBONqYbToFTP1e+CYDiAT45qvGzI22+jRmMWPVehNf8Qzu7j0L5vctKfaZ
	eTZLv0yKErFuoUWRDiqk8TSc4o8r6gNygDlt91bI0I/eE71iiZmKr8/uXahyhBouGUc1HrCB6zX
	+p/s8Q0OXuZRgvzztD6XF/OQHNrPMTCiCw8WGLfq/rqqmrd7fS4nxF3VtMGq4gu6Gg7ESV/CRSg
	mBz4YBksST7REuXFGfVRTVm+WWgBSHxbcQ3CGv0OVX+2p9y2IQckBOlq+vlw7uGinU0n0f2pTGx
	7TowY8nru4QmIo43N6cXOHYyzXaMFcrXvNitq4Gki5UlORqv4LLU9Yd9dRB3zh0bcYO/EGnnEtO
	FqQaKx2cnH0qk4Kq0RhRLNSrDRc0=
X-Google-Smtp-Source: AGHT+IE7R9n09fdDc3gxKWMG8ZdQt1MVhy5CILGt7inGxYTFXeK21MqYcM9OgweBeDIjjRUpvgvRaA==
X-Received: by 2002:a05:600c:870f:b0:45b:8453:d7e with SMTP id 5b1f17b1804b1-45de072e865mr174352905e9.6.1757579208672;
        Thu, 11 Sep 2025 01:26:48 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ce5sm13955765e9.16.2025.09.11.01.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:26:48 -0700 (PDT)
Message-ID: <fc2ee38c-b163-4b7e-9ba2-c2b93d0fc691@linaro.org>
Date: Thu, 11 Sep 2025 09:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf vendor events arm64 AmpereOne: Fix typos in
 metrics' descriptions
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
References: <20250910195214.50814-1-ilkka@os.amperecomputing.com>
 <20250910195214.50814-3-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250910195214.50814-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2025 8:52 pm, Ilkka Koskinen wrote:
> While fixing a typo in "l1d_cache_access_prefetches" in AmpereOneX,
> a few other typos were found in metrics' descriptions too. While AmpereOne
> doesn't have the metric, it did have the typos in the descriptions.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../pmu-events/arch/arm64/ampere/ampereone/metrics.json   | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> index afcdad58ef89..324104438e78 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -113,7 +113,7 @@
>       {
>   	"MetricName": "load_store_spec_rate",
>   	"MetricExpr": "((LDST_SPEC / INST_SPEC) * 100)",
> -	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
> +	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "1percent of operations"
>       },
> @@ -132,7 +132,7 @@
>       {
>   	"MetricName": "pc_write_spec_rate",
>   	"MetricExpr": "((PC_WRITE_SPEC / INST_SPEC) * 100)",
> -	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
> +	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "1percent of operations"
>       },
> @@ -195,14 +195,14 @@
>       {
>   	"MetricName": "stall_frontend_cache_rate",
>   	"MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
> -	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
> +	"BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
>   	"MetricGroup": "Stall",
>           "ScaleUnit": "1percent of cycles"
>       },
>       {
>   	"MetricName": "stall_frontend_tlb_rate",
>   	"MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
> -	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
> +	"BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
>   	"MetricGroup": "Stall",
>           "ScaleUnit": "1percent of cycles"
>       },

Reviewed-by: James Clark <james.clark@linaro.org>


