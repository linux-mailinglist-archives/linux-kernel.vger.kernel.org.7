Return-Path: <linux-kernel+bounces-862414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E5EBF539A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EB73ABFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AA303A0B;
	Tue, 21 Oct 2025 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtiB+EBC"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0245302758
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035301; cv=none; b=ckUU6wWGxEI+F9P+D/xtmiHiQXF6cf1LpH/JnM1Al5CS0w1lHJ14YeMTIrmfQOY01e5EgEH1vqcEOGhp+jRxDfwrWlJxvfXD8BroyTmiLSNLgNgM48KdEzQlb/yO/VH2Iw1Vzgiox+Gr1EwO8SGja3gM0heoL7CnTWI8n7nILP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035301; c=relaxed/simple;
	bh=bzpOktbYO2tYBTucV155BxXIDpmGKecPOHUkItg8BLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+yPY0PLTg65eu9ouzr8hg5K8+6L8vLpoPV+cXEOrCr0dXAkNIaZ7KV9Vq5w6Z6I2I9Fpve7rqlMX0F/OJr/KPZ+OafKPS85JDpdbDa1ONbVsrQvY0U8iM2Dy79YK+xyMy20QcYeUYq3G3twaDcho8J2TboKZyESZTybNom6P1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtiB+EBC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47495477241so4952325e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761035298; x=1761640098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b52ybaDxDJQAgpDd+OquVpENnANEDzFwPJdoTxwdyo0=;
        b=TtiB+EBC6khzycTQDXFF0pZrO8uAvItn2dZX9PM0j0+F2KbUXquqVxw5H9YVDcpq2v
         WUIct6ryQjNYskp+AEpX/Z+pNAjOVJ5NhQf4NAzIn+tRAp8zqv7xbgP9N8hW62Wj30bm
         votBplHAmtYbQcl7M9OKGL82Zg3S+gHoiOcXLTZL02G/SUS0aC6df0ehEDm9vMD1EXGy
         O51F96nKYFuZpi2eHqPBGW/Uj5Co2wRXpZ57TMlviNpuPxPljpvnNe9eNGox6WoaSwMC
         SE84YFsb0PAWH+4ovJEOy0j8jmJBJ6aaoanMkVslbwk35vYjAHRQXT5/4CfQKI/Ds50u
         9rCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035298; x=1761640098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b52ybaDxDJQAgpDd+OquVpENnANEDzFwPJdoTxwdyo0=;
        b=OfeLvzfO2Mf+ZgIqPbwUBZTRfz0ylV8f1j4bjyoRzBQqmBpG0k2Bg14w+X8arWInCE
         55me3PUaHjmUIPiguPjYSe/R7DuDkQppHRnypoYQM+HZaeKdI87UFRS0wG0d65vh/Nug
         rgthCq6Grepj+l7pMf6kLQAVmGDltdxsNwRtuq0tOr9a3oO2DEtGm7hrcA9ezUa6Ey4w
         TohUnSUYMnId0UWe6zjH1KgUl5QrciaLMUGE1zlaBf7jbvq4TAq8FVn34mX5rAOE6yvV
         ZRI0bh2vqwPrHCJMBwnE1ZCIjpylY8qyGg8zwUxQWVeFgLXrdxj4R1A5RAmSTG5DQ71Z
         obFg==
X-Forwarded-Encrypted: i=1; AJvYcCWSy4uWODiHScEj+4ykVGlqipjT4DnCYKieo3ngzhO5xm0P6NtfHjnxSM8LHkI/Sj4otyftljTyH3oK/Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlleocU1dbPMlOXkQR51+rrxYSVgqzE46Kxc4UxAVqgiydCOnT
	V69e84LTCjJE0iNXT6z5of/JtE0BqftDnjOnIvRjc8JuBcxBaEg/ECo2z++oV7Fv3VY=
X-Gm-Gg: ASbGncsZJ5KrBxK7YS6oDfYakK4gNDtCqo0Z45sWDQb9pjnnWQBAWQpY5wh6hMqxPPY
	Ef1boZPkCXeQ3cYiroX78qVQWlPOaon47h/DjrfFTry/QLiv6skEHVnCoRpYF3/QiVXDO5D3Ggc
	ZWToNfHDt50hHh9XVgiB9RTSpXKu0eiZ/1ix+r402uFVn09gOrMX/SO/mXtuIq27oCKfe9Asd+5
	jhkz8hWzq040gvqZwj3xoz8YY4XnSCc4pQCLeI0B4oKsTNDMiUuR2QS8XDa+zc5MLqaG7TvTzKU
	wOViLc5odD3nwnN08MH+3RZBp0Yy0m1HAbabzn7wd09ewQKADf53qlY4CNcW2V8U4fmZH+//hte
	kYl71uxS6tkXuM3c5Iqh7sF+RrcJfY5lekqp5plkJ3/VIbBqWMAvEPFJAji/eOGR4Vcwn38PdXl
	GCJgoAg7gl44RVHN2B
X-Google-Smtp-Source: AGHT+IEf+14wrIR+AkVBMF4pU21DeYP3U2sM85qOJiSGJSUOr3M9WjJk+DnUtO/N8Z7K2WyYMosFog==
X-Received: by 2002:a05:600c:1994:b0:471:a73:9c49 with SMTP id 5b1f17b1804b1-471178745fdmr135759115e9.2.1761035298036;
        Tue, 21 Oct 2025 01:28:18 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bab52sm18943601f8f.22.2025.10.21.01.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:28:17 -0700 (PDT)
Message-ID: <de62f91e-b081-4cf5-8052-0b910ccf1b41@linaro.org>
Date: Tue, 21 Oct 2025 09:28:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf jevents: Fix build when there are other json
 files in the tree
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251020-james-perf-fix-json-find-v1-0-627b938ccf0d@linaro.org>
 <20251020-james-perf-fix-json-find-v1-1-627b938ccf0d@linaro.org>
 <20251020163835.GI281971@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251020163835.GI281971@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2025 5:38 pm, Leo Yan wrote:
> On Mon, Oct 20, 2025 at 05:08:26PM +0100, James Clark wrote:
>> The unquoted glob *.json will expand to a real file if, for example,
>> there is any file in the Perf source ending in .json. This can happen
>> when using tools like Bear and clangd which generate a
>> compile_commands.json file. With the glob already expanded by the shell,
>> the find command will fail to wildcard any real json events files.
>>
>> Fix it by wrapping the star in quotes so it's passed to find rather than
>> the shell.
>>
>> This fixes the following build error (most of the diff output omitted):
>>
>>    $ make V=1 -C tools/perf O=/tmp/perf_build_with_json
>>
>>    TEST    /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log
>>    ...
>>     /* offset=121053 */ "node-access\000legacy cache\000Local memory read accesses\000legacy-cache-config=6\000\00010\000\000\000\000\000"
>>     /* offset=121135 */ "node-misses\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
>>     /* offset=121221 */ "node-miss\000legacy cache\000Local memory read misses\000legacy-cache-config=0x10006\000\00010\000\000\000\000\000"
>>    ...
>>    -       {
>>                    .event_table = { 0, 0 },
>>                    .metric_table = { 0, 0 },
>>            },
>>    make[3]: *** [pmu-events/Build:54: /tmp/perf_build_with_json/pmu-events/empty-pmu-events.log] Error 1
>>
>> Fixes: 4bb55de4ff03 ("perf jevents: Support copying the source json files to OUTPUT")
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Searched a bit, if without quotes, the wildcard will be expanded by make
> but not by shell.  It makes sense for me to fix it with quotes.
> 

I think it is the shell. The only * expanded by make is file names on 
the right hand side of rules. Either way it only makes a difference to 
the commit message.

> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks for the review.


