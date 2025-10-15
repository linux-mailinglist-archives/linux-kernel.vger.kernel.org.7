Return-Path: <linux-kernel+bounces-855005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75085BDFE6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 991BB354FED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA32FF172;
	Wed, 15 Oct 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkyeFNOh"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661327E05F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549950; cv=none; b=jrmVJCnrypChZ9jIqp5W+HmMwYP46r3cJYtyrZ10r3lLqLPmR7InBO40caDsYuY9+xrzi58NuR2923pSF1QmkxGDPVK3PuvcnaWQBIuWf7/G2Ee022cUdd/g23AsHaAxMN7l1oANuKvnA9OWjiX2yNpdXcmxX0ROpkzZOZIkOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549950; c=relaxed/simple;
	bh=QqFjS0dofGd23R/Vl/Q9AbMhq0HpMlDoOWoGpFbXhOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ngiGTBN4KAaR7LQeTYGYZcRzvIHFw5rtw26jzxywQGlPAWstEg9oAcwqymaiRqldngUa6OcHeJkLEZKirIqbMFgLjWVcTvkhzch8p9Mpq5h+XsI8pgpItvXFjausmmt97GfEMWlBgtCiLzz5JonigFB3gK9Oue1JPtRJvYqVye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tkyeFNOh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471076f819bso6267735e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760549946; x=1761154746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxF13IYBqPGtR5vpSfjG+eCrKpOfLtPiG/9JvCrM9vU=;
        b=tkyeFNOhi0s2A/VVrwm6TCyxzNo6xWqdQ4huZO615R8SgpGbJX3p16R38dHpyCLNAh
         1ZsA1vCLJAnT3F+VOwBSHVa2TfTDNRKTdkNS2usWLUYhYcbWAok1y25WoZJqSeEbGlMi
         mnWyk/JmwQWGhZxFOQip4Ti/G5qKLSU6zaahWvcTs6vBE+LKjt4+fJsQZb3gMbNaA7wZ
         3HKQ4xR8+DvLzYQm+UtM0+Yi6OcKHUJDB9QmFFB2QF5UDx18P4lgSU84/5ar63h7j8y5
         IqJCE7qUis/6+W/4V4uB+BQI2GVdjgWZuhYnAS1X+VYLzhdRbFCEAvEgsSDcOjd5hMqx
         XJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549946; x=1761154746;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxF13IYBqPGtR5vpSfjG+eCrKpOfLtPiG/9JvCrM9vU=;
        b=My0mya5e2ZlgC1ms/6emooai1/65TXpg9AZsAjHExrYsJCHom2Ni4sxAd6FRIHRfoY
         QUCCotfl/DSJijIwFxEIu3MWwNyv/l5A5rt5dVh1BrqWUD9BEvpS6GWS/MX/xkMdgc6v
         +vNviSQau/YwZlygJpNSDfFmR2AuLk0Nriuj3TwD3zRkvLFb3X140tznhPGKTx5g88na
         0Km0zyi45Klbl9yxx8WB1qg6E+Mi1A7W4fmgAFbbysdJFWPuy0e1g0FYEs/UIU9sc7c6
         ZhnQ/Jgd3ZPFj7W+kyWFiJaCJq/cvPEzkThWVeWQGBWIJ8pe44i66YllNmcLcaoODCbg
         dgkw==
X-Forwarded-Encrypted: i=1; AJvYcCXMbJg6Ld6E08hqHD6x2yAv6l31QXnmkAi1UFi2WORkPZBhLiWkosrTNBt2sp+C4I/65HkQ4ynV9sJ2wvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYatwq+R8PdHc43glWvD25bAql7X6hkpSsBhvpIk+8k33aSg9
	JGnTWgf0JLVPM6hxhWX4PudxHarZ3duydgSEQHCUr5b6ftKFd56kg/t0U1x8zpLtwqo=
X-Gm-Gg: ASbGnctzbyxwaRwbSbudCyKeXaxKZE3IRvgK9VPcOd0hownxX+HOQUoHVWjz8YMd1fq
	U7uxj90Uq+K5KiDAwnlGPEUa/5XbcSv1jKpMIF169L32uQbpE1FiDSCTdPkF7TJklAzxvlbRlCy
	KMTmmgppC+WGiryD+y/5QmY5kqHwJchgWRYYvjeaPd5II+J+jGylqnupA1M8f72QBfL/EdZdC98
	OVcCGQOy+L1Fl4Vs1LBsMtTvi2R46mZcSXoCuPnI/m9SHQ1B57mdWl/RKqSaEb+IUq9xoXN2vAT
	KN7Tb8G+UhcNejsyTfQ7kPIiwD5Bbq/3M3vP7V39pgl8tbduk05NFWwyH4dWU/uZI6YiNE7Eibb
	Y4NhUXyaWNI/si70dql6LRxk4ZXuop6m/37eHDLmWJgSULDANMYmbXHS001AJKw==
X-Google-Smtp-Source: AGHT+IFpK9jgy1axnrHwt8bxNrIDpfIAGB6jxP21sfrlK0Qs+Bqe9AnJfPR/yP9WWp76Use+S0n0eg==
X-Received: by 2002:a05:600c:3e15:b0:471:a3b:56d with SMTP id 5b1f17b1804b1-4710a3b063bmr5658705e9.34.1760549945781;
        Wed, 15 Oct 2025 10:39:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb55ac08dsm302624115e9.13.2025.10.15.10.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:39:05 -0700 (PDT)
Message-ID: <a9f3b996-4fb4-463a-8392-16115862903a@linaro.org>
Date: Wed, 15 Oct 2025 18:39:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: Namhyung Kim <namhyung@kernel.org>
References: <20251005182430.2791371-1-irogers@google.com>
 <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>, Ian Rogers <irogers@google.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <176054362630.22559.13423487878652916137.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/10/2025 4:53 pm, Namhyung Kim wrote:
> On Sun, 05 Oct 2025 11:24:03 -0700, Ian Rogers wrote:
> 
>> Mirroring similar work for software events in commit 6e9fa4131abb
>> ("perf parse-events: Remove non-json software events"). These changes
>> migrate the legacy hardware and cache events to json.  With no hard
>> coded legacy hardware or cache events the wild card, case
>> insensitivity, etc. is consistent for events. This does, however, mean
>> events like cycles will wild card against all PMUs. A change doing the
>> same was originally posted and merged from:
>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>> his dislike for the cycles behavior on ARM with perf record. Earlier
>> patches in this series make perf record event opening failures
>> non-fatal and hide the cycles event's failure to open on ARM in perf
>> record, so it is expected the behavior will now be transparent in perf
>> record on ARM. perf stat with a cycles event will wildcard open the
>> event on all PMUs, however, with default events the cycles event will
>> only be opened on core PMUs.
>>
>> [...]
> 
> Applied to perf-tools-next, thanks!
> 
> Best regards,
> Namhyung
> 

Hi Namhyung,

I'm still getting the build failure that I mentioned on patch 5. This 
only seems to happen with out of source builds:

   $ make -C tools/perf O=../build/local/ V=1


   static const struct pmu_sys_events pmu_sys_event_tables[] = {
         {
-               .event_table = {
-                       .pmus = pmu_events__test_soc_sys,
-                       .num_pmus = ARRAY_SIZE(pmu_events__test_soc_sys)
-               },
-               .name = "pmu_events__test_soc_sys",
-       },
-       {
                 .event_table = { 0, 0 },
                 .metric_table = { 0, 0 },
         },
make[3]: *** [pmu-events/Build:54: 
/home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log] 
Error 1

Thanks
James


