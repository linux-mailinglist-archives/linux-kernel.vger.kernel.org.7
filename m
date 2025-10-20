Return-Path: <linux-kernel+bounces-861302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A8BF253E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E575A3AA98A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEFB191F92;
	Mon, 20 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqj5Bj/l"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D725776
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976657; cv=none; b=m5su3wECJ8S9Dn2KgaV2YCbraI6BpAQFZW0Xbb7CHxhKntG+1sPR69b8na8XaXtbNTbH49UgQPTOHV0mzKmu+IZORzuWuuc54OV4V4yTCoLGbGMkbpMwUOP6dVisDHCIExCa87rWoN7nKm28V0kVIklpFGaTKW0CQhjoFAH5I2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976657; c=relaxed/simple;
	bh=atlvMgRm+hS9Ugv97pz3Qaw9ZHe2wJvCA4y4Y/WoWHw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iaY3EwtfZ8IaCb0VmSIJ+NUj2GOoIHW6O1f+Wx1mASfJRXd8SQ1whkvIIcuBMXAV353NxEfIEMVoC/dF231bUHOq6QGwlB1QsSRWh3AGkByA8DDx2RFUvdjQCtiChOXRHiM8egIql+YCNQbyOuBTcgFwFmaL1HGfeN4onXW5IMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqj5Bj/l; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46b303f7469so35905695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976654; x=1761581454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwoZbVRQTt+W1c+EeTF1T/2iGQVGJEAF5xGXmi6G/Rw=;
        b=rqj5Bj/lH6Vv2W7sKXk4m6QAl7LPvOgfSYTjOwTjeJQSpdAccXAQUNFUk8lAR95jWR
         jkn7dpZlqAePkKVsXxRtF2EVeHRVSnCsawIO4LV/FdMqzxuoEqzFZ6P9QpRktz5f6P+g
         A+lePpXkiKp/oVKMeHV+PYam4Ol/oWVLAa9ynnOXwwHGJhoIG1KblIbuO1leM4J9sezd
         4FU/9yViQlb03GAeGMHyQiSduPKagGokxQdF31EFh82fbigLTOwAakEwCwsKvfB+s9Kn
         skAx/P7gTH2UbNm9yEnQSi+BOWCmM3TvDNEEMInFCMVMghjsEtOP6995j0M42IhnsfSZ
         EemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976654; x=1761581454;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwoZbVRQTt+W1c+EeTF1T/2iGQVGJEAF5xGXmi6G/Rw=;
        b=AnzTuCC7vEZuHql6yUEUq90khixft1ANcWQf7OHv72CXkElU5MlGXdAumKkL/RKi79
         MaNSaOp8sQe8nFzqQcJ3xTPzz5Q8kXHcDAhu8WdUbLd69X+UOaYQbd89gjAnIHUr9/yZ
         smpS+ntSBDJDOjCuTs3xq+U9lYiAJmhL84NMG8QIXYbgriClK/9EuRMZOBGzo80qdq1T
         CCsWVfm39H7o1SOIVkWRF0iURc+68le5IzcXbr0G4vsH1KCLzc4iNdKrnMM8blsv6fPV
         OF3+rFqOuXJRu1Dg8v+yp7o9LBIQFTHGt8pXUqqxhlIQ8H6d5XdBaKLkLLNEES+JOy6z
         Bfxg==
X-Forwarded-Encrypted: i=1; AJvYcCX6uHoL7h0VTImzvRuF5ygJcG1pgsGNSQdOa0ox3+Rl0VmWq6F4hEMcUqFVrtmpRy5X3gV+mXlU3yHidto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxXPtF2sZiKWHu1aPHda2ux5C29J1xwUegd0NvbLc/Y15AJS8
	NSG391vqlZUbWGdzQ8CrAHl9/iuoLOpiw1Bh4t9nq3pByPYo00TzGoMlNscFpsAQ2qk=
X-Gm-Gg: ASbGnctVCI/uldTdpvJHMhTGMbTFk8IO9GnchMuYBUMsld3o0ZYu9v7nY/I6x5MaF0G
	c7oO4fORwpFTpyf/OYtTisbv0E2hs9AUY+KGut0udIzclqwhCD+4LppPSshpZ4D78qvPKsqE6xL
	KDCUZHEtRPRw0Lf0RHUrTlJJz3i79U1vf6+NnjeXVKozwK/nTtc9Ud2gKuYRwMG7tmBkbEhWWUe
	wYahgWPLf542xy/opYE7kz7WQG7KoghMHLhNlCa5TONbB0D5CSte3ZLVnTvbXretPzOunBITnqe
	zLShwwEVfwGZ25G1lDdUTc130bh+HhFZqo8Uxn8iaemJcAdYeJomOjCE6Joe+BQZmS2n0OZPxn+
	1k8+/IKJ3FkUZkcJkCAgUvaFGffo/VluLVjqre2kRZWTFNh+4whs7MZ64yE3meG2GPSHbHPTu5H
	cJKQCuj0DuHOLA9kJLmbUgaDnL8l8=
X-Google-Smtp-Source: AGHT+IEPnIGwsuZY+46A6PpcAFpc8Ia5wCuHzXWDH7VRfIxTAeoRBvtxAHsNgzzUSluVxH++2wSTuA==
X-Received: by 2002:a05:6000:26c8:b0:427:72d1:e3b2 with SMTP id ffacd0b85a97d-42772d1f234mr7266592f8f.35.1760976653835;
        Mon, 20 Oct 2025 09:10:53 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710cda4ecasm113706775e9.4.2025.10.20.09.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 09:10:53 -0700 (PDT)
Message-ID: <cf9aa030-1ac0-4b40-a613-d50a6feb138a@linaro.org>
Date: Mon, 20 Oct 2025 17:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
From: James Clark <james.clark@linaro.org>
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20251005182430.2791371-1-irogers@google.com>
 <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
 <a9f3b996-4fb4-463a-8392-16115862903a@linaro.org>
 <CAP-5=fX8ZV6WTmKcrrfPo0MUFiruJoWhYeUk3JrToEP=9-aPCA@mail.gmail.com>
 <b1a461b4-4358-4556-80ef-e7abd686f2e5@linaro.org>
Content-Language: en-US
In-Reply-To: <b1a461b4-4358-4556-80ef-e7abd686f2e5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 11:29 am, James Clark wrote:
> 
> 
> On 15/10/2025 10:24 pm, Ian Rogers wrote:
>> On Wed, Oct 15, 2025 at 10:39 AM James Clark <james.clark@linaro.org> 
>> wrote:
>>>
>>>
>>>
>>> On 15/10/2025 4:53 pm, Namhyung Kim wrote:
>>>> On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:
>>>>
>>>>> Mirroring similar work for software events in commit 6e9fa4131abb
>>>>> ("perf parse-events: Remove non-json software events"). These changes
>>>>> migrate the legacy hardware and cache events to json.  With no hard
>>>>> coded legacy hardware or cache events the wild card, case
>>>>> insensitivity, etc. is consistent for events. This does, however, mean
>>>>> events like cycles will wild card against all PMUs. A change doing the
>>>>> same was originally posted and merged from:
>>>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>>>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>>>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>>>>> his dislike for the cycles behavior on ARM with perf record. Earlier
>>>>> patches in this series make perf record event opening failures
>>>>> non-fatal and hide the cycles event's failure to open on ARM in perf
>>>>> record, so it is expected the behavior will now be transparent in perf
>>>>> record on ARM. perf stat with a cycles event will wildcard open the
>>>>> event on all PMUs, however, with default events the cycles event will
>>>>> only be opened on core PMUs.
>>>>>
>>>>> [...]
>>>>
>>>> Applied to perf-tools-next, thanks!
>>>>
>>>> Best regards,
>>>> Namhyung
>>>>
>>>
>>> Hi Namhyung,
>>>
>>> I'm still getting the build failure that I mentioned on patch 5. This
>>> only seems to happen with out of source builds:
>>>
>>>     $ make -C tools/perf O=../build/local/ V=1
>>>
>>>
>>>     static const struct pmu_sys_events pmu_sys_event_tables[] = {
>>>           {
>>> -               .event_table = {
>>> -                       .pmus = pmu_events__test_soc_sys,
>>> -                       .num_pmus = ARRAY_SIZE(pmu_events__test_soc_sys)
>>> -               },
>>> -               .name = "pmu_events__test_soc_sys",
>>> -       },
>>> -       {
>>>                   .event_table = { 0, 0 },
>>>                   .metric_table = { 0, 0 },
>>>           },
>>> make[3]: *** [pmu-events/Build:54:
>>> /home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log]
>>> Error 1
>>
>> Sorry for the issue. Is this happening when you don't do a clean
>> first? I tried recreating your output path, but I can't reproduce the
>> issue on a clean build. The diff above indicates some issue with the
> 
> The clean issue was separate to the build failure. I meant that the 
> build failure was sticky when I was bisecting. So after commit 5 the 
> build breaks on a clean build but then it stayed broken even on builds 
> before commit 5 unless I cleaned. I think we can ignore this for now.
> 
>> Makefile processing tools/perf/pmu-events/arch/test/test_soc/. This
>> directory should be copied to
>> ../build/local/pmu-events/arch/test/test_soc/ and so I wonder if the
>> copy failed for some reason.
>>
>> The copy rule is:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n33
>> ```
>> # Copy checked-in json for generation.
>> $(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
>> $(call rule_mkdir)
>> $(Q)$(call echo-cmd,gen)cp $< $@
>> ```
>>
>> The mapping of file names happens in the patsubst in:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools- 
>> next.git/tree/tools/perf/pmu-events/Build?h=perf-tools-next#n42
>> ```
>> GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON)) $(LEGACY_CACHE_JSON)
>> ```
>>
>> Those files are dependencies for the empty-pmu-events.c test so I'm
>> not sure how this can be failing for you.
>>
>> Thanks,
>> Ian
> 
> If I apply this patchset to commit 2a67955de136 ("perf bpf_counter: Fix 
> opening of "any"(-1) CPU events"), then:
> 
>    $ rm -r ../build/local ; mkdir ../build/local
>    $ git clean -xfd
>    $ make -C tools/perf O=../build/local/ -j1 V=1
> 
> I get no copy of the test jsons:
> 
>    $ ls ../build/local/pmu-events/arch/test/test_soc/
> 
>    ls: cannot access '../build/local/pmu-events/arch/test/test_soc/': No
>    such file or directory
> 
> Looking at the dependencies of the rule for $(PMU_EVENTS_C), it's 
> $(JSON_TEST), but JSON_TEST is the in-source version without the 
> $(OUTPUT) prefix. That's already satisfied so it skips the copy.
> 
> If I modify the generator for JSON_TEST to include the OUTPUT prefix:
> 
> JSON_TEST    =  $(shell [ -d $(JDIR_TEST) ] &   \
>      find $(JDIR_TEST) -name '*.json' | sed -e 's|^|$(OUTPUT)|g')
> 
> Now I get the copy:
> 
>    $ ls ../build/local/pmu-events/arch/test/test_soc/
> 
>    total 0
>    drwxrwxr-x 1 james  56 Oct 16 11:13 ..
>    drwxrwxr-x 1 james 108 Oct 16 11:13 cpu
>    drwxrwxr-x 1 james  12 Oct 16 11:13 .
>    drwxrwxr-x 1 james  22 Oct 16 11:13 sys
> 
> Now the diff check is slightly different/better, but the build still 
> fails. Weirdly I don't see this failure on my Arm machine which is where 
> I tested the whole set, I only see this failure on x86. Maybe some 
> difference in the version of make?
> 

Turned out to be an extra json file I had in the Perf tree for my 
compilation database, so that explains why I was the only person seeing 
it. Sent a fix.



