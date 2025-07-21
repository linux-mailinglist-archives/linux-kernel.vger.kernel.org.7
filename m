Return-Path: <linux-kernel+bounces-739606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF6AB0C875
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAF117A489
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0246283FC3;
	Mon, 21 Jul 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjbLsZrt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8162E03ED
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114435; cv=none; b=HSGp5qbalHa8EHI4Z2LQy+rMefxR09I49fVy/RBKgeX1eUUFeGAkYDOe5ecNWoZE2sddw0LSf6ImcXYxLx7n8azrYM0+smAamS1oeEiJRiOFPWdoqu3im4zWVSt5khA9ee6X/OkBJFFW+FBZyO9mUZHwb1Yhn4XjR4c1ynUNG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114435; c=relaxed/simple;
	bh=GGSxE1Hu/CmOz5hk4iCIXmBgYdKQBmbj6Z4PL8VgTak=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Q8Bnc0usmIsE2J20zOeIWtRD1EsRzwDWmNFwrtZffexOWyOITvQa3qf+kwQiP9OkHsOYNg/+uxO4E1p7PHBF+wSwr8JsKk74l4JNhGr+9slJHKzjr/oJbUbEu3xXTp5H4qSNOeMplODj/FnSDliKnFcyiQp5NZVHwMnyvFJXST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjbLsZrt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-455b00339c8so32286525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753114431; x=1753719231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9BReN8kFhNkqoSb3wxSgjEPGo+Of3+hoptB67zyAW78=;
        b=cjbLsZrt6/2Ve0zjFZmbBZsIfjFeqQw/cid/lH3mmtdqJFhMH0jLZT206f357Z69Rr
         jO7DfJyH73EIiPzhrWInpI0ENkhXy+Gm6mE4ER3pspP5zAouql/Xbk3hwnT0traxZhu2
         Mhgvs7d0HqSX4bwUbvaQOlAcerIeJvoHU5QN63Wq5GxznO3/TnpF4hMlb8zj+A6nU9Du
         wMd4l0CAh5O2Lu0ocfPCP19GX0h2qXBpGZVBQeJFLNCeIcLhRL3JsyaBQB8xU8w0x1Vc
         /YupH4fg+JGERAuWgx4+B8aHU6otjdePAirmuwWjVbHOYPhax0Fskoyhi2qRP3vlX302
         j8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114431; x=1753719231;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BReN8kFhNkqoSb3wxSgjEPGo+Of3+hoptB67zyAW78=;
        b=L+mH1b+TLqF1OJQ0IdggwG/iJP5Tp+oP7kgJS4Viqhdtjy2LJC6ci9UMftd9X2x6/N
         QUAcQUv8WekPUJiQzeBSJ1kN9iQC5+l+Gs9LmXICYTiQDNiqnrSof5CDHT5LnUlFLKJm
         9YoZaRpmIW9MFoQPfxnTdLxQ41dWUPaoz+DtMcDGMZ30U8DpwwtOBtN3/hlBslHVKG8M
         VrO8tHdDLWnav8tNOYmfx6pgzGXxpWVUGZmnJ7M44AL4imTkC/4tlmANzzBK7x+4Dow6
         sxu4eLtqbhsJSzQ5rZP9V9DNAXc77UTKFfPCkkjqje6GGJn7kUdns0kIlYaFqSKBzqcC
         gsmg==
X-Forwarded-Encrypted: i=1; AJvYcCVtJarlYW5s1rjuW2IYWA0nw+3WUNXSyJaq5m5Uat57SifpAY+UEWNgzWtqb0x03+65rCjMSF9BeuyEZdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglReROfF7s/eiz7dPuuuS/9JHxazV62i6QdbLYdCfGs8Khgup
	XZJj/TzdbF1OgXvrkEIERPxhpJMZRSJgORJwj8Qnd70xOAIkjPrGq0IUZ4vkc5PNsh0=
X-Gm-Gg: ASbGncsFVVFXwtf0fajHaVe1q58Hly7zRSs2xIGrf8UJ/s3aqYA6lIBV9VfeJnqnFBp
	oTu/6X8KLuC0DahOnzH76eRmM/2MLcMiCffcU8F5ZOVEljpJSQAUj7+wIi7lf3FEG8+vZBBKys4
	rVp+8F56ucQhdv0Nk75j3nU3Gjimlzz2d0PT+EGDNGCgh5M7Z0LtZF3OEE+StVbjvwUC0BHpIOm
	Mb35oMZvlL4IwDkMZULceeGbTYktqvXCiP+6a/zEbvTKVkOnqPECSjiSDVw3QqN8ZtpHHYiWnOZ
	pDM22B09xU2o8l48mV+UXJ4phVvqpAltqmCYnt9IFlmRJisxOaWG8KuS7oPch+BnpEvojo2217g
	oXiKLAZLae9Kt5GxvHa/kPo9M1gtANAUHPsIy9g==
X-Google-Smtp-Source: AGHT+IGS05W2n0Cs3+lkmQ0hawv/FUnUeJ4fwkqkj5rDTWEAfnRp5XtI8zOuQ9QBwRb1AvWITpdyfA==
X-Received: by 2002:adf:9dc3:0:b0:3a4:f918:9db9 with SMTP id ffacd0b85a97d-3b60e5127e4mr14240084f8f.32.1753114431398;
        Mon, 21 Jul 2025 09:13:51 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80731bsm163234685e9.15.2025.07.21.09.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:13:50 -0700 (PDT)
Message-ID: <2b51b856-a1c6-4ff1-b336-ae612e5d1cf5@linaro.org>
Date: Mon, 21 Jul 2025 17:13:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/12] CPU mask improvements/fixes particularly for
 hybrid
To: Ian Rogers <irogers@google.com>
References: <20250627192417.1157736-1-irogers@google.com>
Content-Language: en-US
Cc: Thomas Falcon <thomas.falcon@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>,
 Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250627192417.1157736-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/06/2025 8:24 pm, Ian Rogers wrote:
> On hybrid systems some PMUs apply to all core types, particularly for
> metrics the msr PMU and the tsc event. The metrics often only want the
> values of the counter for their specific core type. These patches
> allow the cpu term in an event to give a PMU name to take the cpumask
> from. For example:
> 
>    $ perf stat -e msr/tsc,cpu=cpu_atom/ ...
> 
> will aggregate the msr/tsc/ value but only for atom cores. In doing
> this problems were identified in how cpumasks are handled by parsing
> and event setup when cpumasks are specified along with a task to
> profile. The event parsing, cpumask evlist propagation code and perf
> stat code are updated accordingly.
> 
> The final result of the patch series is to be able to run:
> ```
> $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=cpu_core/,msr/tsc,cpu=cpu_atom/' perf test -F 10
>   10.1: Basic parsing test                                            : Ok
>   10.2: Parsing without PMU name                                      : Ok
>   10.3: Parsing with PMU name                                         : Ok
> 
>   Performance counter stats for 'perf test -F 10':
> 
>          63,704,975      msr/tsc/
>          47,060,704      msr/tsc,cpu=cpu_core/                        (4.62%)
>          16,640,591      msr/tsc,cpu=cpu_atom/                        (2.18%)
> ```
> 
> This has (further) identified a kernel bug for task events around the
> enabled time being too large leading to invalid scaling (hence the
>   --no-scale in the command line above).
> 
> Ian Rogers (12):
>    perf parse-events: Warn if a cpu term is unsupported by a CPU
>    perf stat: Avoid buffer overflow to the aggregation map
>    perf stat: Don't size aggregation ids from user_requested_cpus
>    perf parse-events: Allow the cpu term to be a PMU
>    perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
>    libperf evsel: Rename own_cpus to pmu_cpus
>    libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
>    perf evsel: Use libperf perf_evsel__exit
>    perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
>    perf parse-events: Minor __add_event refactoring
>    perf evsel: Add evsel__open_per_cpu_and_thread
>    perf parse-events: Support user CPUs mixed with threads/processes
> 
>   tools/lib/perf/evlist.c                 | 118 ++++++++++++++++--------
>   tools/lib/perf/evsel.c                  |   9 +-
>   tools/lib/perf/include/internal/evsel.h |   3 +-
>   tools/perf/builtin-stat.c               |   9 +-
>   tools/perf/tests/event_update.c         |   4 +-
>   tools/perf/util/evlist.c                |  15 +--
>   tools/perf/util/evsel.c                 |  55 +++++++++--
>   tools/perf/util/evsel.h                 |   5 +
>   tools/perf/util/expr.c                  |   2 +-
>   tools/perf/util/header.c                |   4 +-
>   tools/perf/util/parse-events.c          | 102 ++++++++++++++------
>   tools/perf/util/pmus.c                  |  29 +++---
>   tools/perf/util/pmus.h                  |   2 +
>   tools/perf/util/stat.c                  |   6 +-
>   tools/perf/util/synthetic-events.c      |   4 +-
>   tools/perf/util/tool_pmu.c              |  56 +++++++++--
>   tools/perf/util/tool_pmu.h              |   2 +-
>   17 files changed, 297 insertions(+), 128 deletions(-)
> 

Tested-by: James Clark <james.clark@linaro.org>


