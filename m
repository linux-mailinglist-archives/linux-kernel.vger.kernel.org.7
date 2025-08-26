Return-Path: <linux-kernel+bounces-786259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BA2B3575E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B00A683B36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF942FD1D4;
	Tue, 26 Aug 2025 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIh6tYod"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4B2FD1D5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197510; cv=none; b=lKkjCWBpbFIWUoM41Gkk4DcEkkDNwD5uaqUXSvVwDW9aLuFHV554jV838LZc0BwuzjGg7FpZymWcXY5KlW/1npIOIAHP7K+vgIhTHtYJ7WO0cKxkIltIx0myeqffzg3AYtz0xhuOmnrfhs1cmDS1ZjcpTBc9QORKAkbf5vm8EPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197510; c=relaxed/simple;
	bh=TuGhfyWtejXoSJXXQd3ZBKxoBEDJ+7uL75KJD3StkDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ur5qltf75hmEQAqziB0j2oBON7BvB9idoRumsFKfT9fkGB2uahTsF5buryy/d9TDPmmvPU8jm1YSvHy5ByAwldhQ2SrIAMRHaCPDjyFoff2LbagLviY+2R5banc5Na8f8VhXXLp9jMTmXOnoihh0bCB7tuzwCyJwsUZucdfkzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mIh6tYod; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso2751329f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756197504; x=1756802304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bcapay0b5BMrsUC3omNVwn5FU3Q2XQrVHbsogJXMiPw=;
        b=mIh6tYod/vpqm5G0V8VuNmrD0M6esjeFN9i9wxvuX1DElC1iDgAGgUJGHwmy+NJtSm
         ER0HOik+HLK7EgtkpWtaEppd7RyctPSDljn/MpNGo8wP3j5N6vD40HwbSzqgI58dGeAf
         fkM/Aipy6SU+YZP1zCC36dlhbUP979vMD9qpC0tTPFq8EVojwgHLREajyJbHApNVB5ud
         oSLfABMu/bFxFMBPkMDeMVTk67Z6PRvHJ9fpV9YkU2ayegKYcDO2a52RJKCXI+lMB92d
         OogwIJi2JbHlBA3YWT1PWpe+pg5AdWFWqTEtaOGkLw33zOAaQqMFDCELhA6U3KaA5bxA
         KSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197504; x=1756802304;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcapay0b5BMrsUC3omNVwn5FU3Q2XQrVHbsogJXMiPw=;
        b=nJ8BF7zuEbH0f365TT3JDTTQd7wOFt8ldUzGv6k5JG/8MCynXX3svTSQ9ENURJKhzY
         l0EBAHqQy6IQh+tiE2MKMcbInSANR08snb+koBHN4C4oNxhTzftV5L1EMjBuBuSw2Tym
         XRMbkg7PqzT6aCMez2eH4mog5pQ3t5LVdjt76iouEQagOC8LDUbC6AC1JuKoQ6PYQTFn
         srQkCl/AIXwnW4oeR9wIynhaBgsV+7p9wRah6nxttgoDvnphqzT9unVc8qnmTemFlEiE
         VAAjVO2fiJCtV5ExAaHI7oaSgvqBVn3WDfxiG1MXnhhWPVt6dDoAielQahoNq017dcSO
         MUOw==
X-Forwarded-Encrypted: i=1; AJvYcCVq6uwIl525Ml25q2JPkhG4xG7YSqZjAJUYweBh3thjLyil28ukobvQSBnfZ3sAQCJkbKDqgIX1eRmugLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFC66pT93U71F4k4khFqDuKF2kmu+gGUz8tbqjoweJ97EBeUXc
	eUK71+IrZD+uMenWvYoHaaRCK/VvGCV/Me5JAMO4fhQo8l55aMcTPhw0JXPIR1fq0Zw=
X-Gm-Gg: ASbGnctuVj3jtGa7kk+Itwk4mw2uiYYWrnEwu5eg8cg+UFgBIVRdnZV8AwNqAjpFN0o
	h66Q7esHMet4eErwM4OMCNsG/atA+WyxSLNmqOv/OGNuEbwrI5RmnWf4/CwqNdUGxNwQmDkguj2
	nKF4jFH4jCCrLgfcn8xyMiuxP3FdqXftMWJ5r0H6Gl89t1j+1SHKB0fNqnwC/Q4VxMCRfXq5BkL
	gTt6L332IXnH5pA41YuRPUW5S6ryjNn5bxKQYjSrF03umu7QHXlygVOCRZiUgUN0w0mjnbkCRFj
	LO1QbODxSigOi4wIo6rOPwfOPMk0D3qqWXFYZpBcgrrOmeleuskoLWiMPQWKka6Qi0KSpzvQgdO
	tqH3QAx5ZKQb3O2NfTc2sj3lnqeuTvLPrF29IzA==
X-Google-Smtp-Source: AGHT+IFeEqRJ21XXnuc1DJjIvgLFKOV7L5q0hp++j6i1DLS6bEL3rc78ittualLZitamll1u+nuxmQ==
X-Received: by 2002:a05:6000:2404:b0:3b8:d30c:885f with SMTP id ffacd0b85a97d-3c5dcefe32fmr12441530f8f.53.1756197504511;
        Tue, 26 Aug 2025 01:38:24 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm16293557f8f.14.2025.08.26.01.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 01:38:24 -0700 (PDT)
Message-ID: <8b7351d2-6a45-4fef-a149-ae511b52f552@linaro.org>
Date: Tue, 26 Aug 2025 09:38:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Various fixes around undefined behavior
To: Ian Rogers <irogers@google.com>
References: <20250821163820.1132977-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Chun-Tse Shao <ctshao@google.com>,
 Blake Jones <blakejones@google.com>, Jan Polensky <japo@linux.ibm.com>,
 Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250821163820.1132977-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/08/2025 5:38 pm, Ian Rogers wrote:
> Fix various undefined behavior issues, improve tests to make them
> easier to diagnose and add assertions so that problems don't recur.
> 
> v2: Add Namhyung's acked-by. Drop container_of assert that ptr !=
>      NULL, to simplify the series. The bsearch UB fix was picked up as
>      a patch by CT:
>      https://lore.kernel.org/r/20250303183646.327510-2-ctshao@google.com
>      It seems this patch series fell-through the cracks as v1 was
>      sent/acked 9 months ago.
> 
> v1: https://lore.kernel.org/lkml/20241213210425.526512-1-irogers@google.com/
> 
> Ian Rogers (5):
>    perf disasm: Avoid undefined behavior in incrementing NULL
>    perf test trace_btf_enum: Skip if permissions are insufficient
>    perf evsel: Avoid container_of on a NULL leader
>    perf test shell lock_contention: Extra debug diagnostics
>    libperf event: Ensure tracing data is multiple of 8 sized
> 
>   tools/lib/perf/include/perf/event.h       |  1 +
>   tools/perf/tests/shell/lock_contention.sh |  7 ++++++-
>   tools/perf/tests/shell/trace_btf_enum.sh  | 11 +++++++++++
>   tools/perf/util/disasm.c                  |  7 +++++--
>   tools/perf/util/evsel.c                   |  2 ++
>   5 files changed, 25 insertions(+), 3 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>


