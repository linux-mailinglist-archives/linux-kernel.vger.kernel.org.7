Return-Path: <linux-kernel+bounces-845335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47C0BC480A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736DF3C17A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D392F6183;
	Wed,  8 Oct 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fk1SIjNC"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6262F617B
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921580; cv=none; b=L/S1YXUdCe/gbX9H4Cnss1ncYErOPxXstRhtiKIViuC/kI2r+y8AbHNVZ10c1aQZPxZeyd0eNzVM8Q7AE0nH7vDWJsJpCYdcCEAzJSbAUvAPYNagZ61+csijs82BjFil8hHbnGHKrpCiJqQ5MYG4UYQ3D9rWxzcsSX9Mv7bwNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921580; c=relaxed/simple;
	bh=rcwtB4rVyCBzKNTcc0KmvFQOQiz2Q3Ry7cOYyj+n2BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=rOxsfneo9oiNtC6r5v8evBaSonlxL82L1yC3UEVRJfAhmAJBDwvr6QbXOWOlZqJwFLUltTredfKQn/Kb3J6cV0onB/s3HZlWNvErrb6fRt4tghJNQ/fTJODG2vw0TliSF7uQbAs92VvN0dfJBovl3xSN/0YvYGHQUWhYzLUHW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fk1SIjNC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso5163572f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759921577; x=1760526377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w9skgAXCV5SdOI7tzHYlaMNV43kkRs+2XgsWaNKtkOk=;
        b=Fk1SIjNCrHv0AxtqYk2mp3gjmEcQ6zcKnSkltZ5aawyp3tkWuoysQohc1wQUHkkxAW
         3u2vs8e91wf6Wa3Sz81XMBR0uLWnE22r9PMzfDBcHGeFG+wOAKiD/F52LihigHvOgbkN
         eAKR9gZGv6shkuluRUWJX0FbCa2W/AckgWDRCJxy8Mlo1HJC+tvjWgDOmKgKiezWbAUW
         vwbhn6elwbrnD5DKau19HrU/lWnS4AiJ2TbTtigM6d8YnPAt9KjxrjN5NaQeIif7SDnD
         mcOMP8hAgd+CdS5qcwpBg4wwIyHR24XLXZTOcOvNn8424A5paI1M3D+VrpJqF9i7FIfk
         GMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759921577; x=1760526377;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9skgAXCV5SdOI7tzHYlaMNV43kkRs+2XgsWaNKtkOk=;
        b=ACKrOZvevHaSyOzKnAQvqwoBl0XpnpPFU6sxBJ2Lk2T2pOk0pmCQVlnziWILt1DPsZ
         FhRGCrsEj1RyCU1mpvWJbX3re/m9JxqDDGPiyxH1f50q+nsSjcnJwqjY+INixHWTcVc/
         yST23Ouh6olTzjZXHe8TTOWmT57TkvLaWBv0HeFfFBCDblPWu01roVeai848eMzcRkje
         1zNwuFLLJqOGOpPZFHM3exeOHwlt/6LKwH7SxIz5bzP6fp7Q5EkPXgWtB8CfsbRVkK5s
         zqk457XlPrnZJKNSw/Iylndj+0mJzWLvMBDva+W34lvbKDcw3VP3gMK2pEp53589sUJw
         4vkw==
X-Forwarded-Encrypted: i=1; AJvYcCWLYPchvGfuAVDmwMbpGoYS41KKU5Ry4r0QqubTCnuce2MAGIPwK6l7UgDbJXZh7d0Pf7K3ytncYbp5Kes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERSKXc0trC30RWR9Ey6muT65+zQAPqM/d+DyQmlGbH8L0Hj0e
	WYB8tAruD7oYnmzDfh62mHPDrkBsAu7X4Yb+BRJesTcF1+Vlf+hSEkAzejY7c/hYb1c=
X-Gm-Gg: ASbGncvwDpvSQgBP86i87plyxespZgSImap5yoR5/q7cH48YjGjMv7LnYbaV1BProdt
	W1MuY6ZGk+3bMR3L8V2/hmpyaQLI/kSqCWvB/431z6wPeZviEEINYjMcLFtRx94RLWOVioPURaw
	lGrKkT9JjWTW49BKUxUFcAiprttu84dV4wiyTqCADw0c4sJbpJQROoKfNmpfAkwhbPvliXxGRpL
	f0i32TeRLYZpy+MgRAFoOMnaIYbNSfyUor3/UCArruCUnmAuGydBK8zxmIeYq0y0/sLIcK4Nc8k
	sBbbDz6lcEFPw5LFGJAozxkk+OczXFDARuxW65LLh/qYeR8k9zEr+e0x7gm7UG96u36PIq1oP5c
	+3e8SwuylPcWE2esPvissb1tZSe1amM82xQJWK408HtmC6j3k0XIQt+GDmRM7kEpw9Cg=
X-Google-Smtp-Source: AGHT+IFCaW9bqzii0o/1hvZKcttM6MZo9qaAIXOGfzuzrPpIJh30cCzasApmxEzd6HrEw7WMhn6Zsg==
X-Received: by 2002:a05:6000:2c0d:b0:3e2:da00:44af with SMTP id ffacd0b85a97d-4266e8d8d0dmr1918170f8f.36.1759921576763;
        Wed, 08 Oct 2025 04:06:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42585989607sm6721887f8f.53.2025.10.08.04.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:06:16 -0700 (PDT)
Message-ID: <8ddd5f97-79a9-4608-8a40-871fb70f2725@linaro.org>
Date: Wed, 8 Oct 2025 12:06:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/27] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
References: <20251005182430.2791371-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/10/2025 7:24 pm, Ian Rogers wrote:
> Mirroring similar work for software events in commit 6e9fa4131abb
> ("perf parse-events: Remove non-json software events"). These changes
> migrate the legacy hardware and cache events to json.  With no hard
> coded legacy hardware or cache events the wild card, case
> insensitivity, etc. is consistent for events. This does, however, mean
> events like cycles will wild card against all PMUs. A change doing the
> same was originally posted and merged from:
> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
> his dislike for the cycles behavior on ARM with perf record. Earlier
> patches in this series make perf record event opening failures
> non-fatal and hide the cycles event's failure to open on ARM in perf
> record, so it is expected the behavior will now be transparent in perf
> record on ARM. perf stat with a cycles event will wildcard open the
> event on all PMUs, however, with default events the cycles event will
> only be opened on core PMUs.
> 

Hi Ian,

The previous issues seem to be fixed, I don't see any Perf test 
regressions or issues when there is an uncore PMU with a cycles event.

Tested-by: James Clark <james.clark@linaro.org>



