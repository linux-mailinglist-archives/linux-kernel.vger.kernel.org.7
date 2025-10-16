Return-Path: <linux-kernel+bounces-856445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C09BE42BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709DD189F2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A133EB0E;
	Thu, 16 Oct 2025 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VIGdjzXy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB850276
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627903; cv=none; b=MRhzHRUbYvjBXOsvN/xvsId37r2WZDu9wEwLGVxQPDOzylc7Bh9S2HSJAwWcb5w3VYaVZ62nk+h4QgbWQiGBJL4QiXc6ukVA91/PjeFdTH5MbQRZbB73CEugmlotjQQmeGLP18XPP7Cm2xFaEFYxRbFWa2eP2XLalzkgnN3W5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627903; c=relaxed/simple;
	bh=7LEZ+CUSc9CTakkJdufxFxvli6EaUU1u2PWScHtXUyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT00aZcVmiMbz0onl3HEMQIMrkSQce0hG98/3qgDYGSQMxOlEYJ0YwcZ2BCq35uw5ZuOkUsFjOLDXzGuonahpEmWouLUL/rKNpmJ7WdMjHz9r+FaAQ/bORBSFQE9MY1wR2BOq0jCr1u0ZNHXkW9/zMDTjFl2bAQTl83Ygv7BRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VIGdjzXy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710665e7deso4380595e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627900; x=1761232700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqdlCt5BKKyX7yhbZ4ebQoWy8WoAZk9NCmehMG9I47A=;
        b=VIGdjzXytxJOukGmzUrfV7rc1o648XK1b4FM6sljPtsNp0lHmsNzGAwZQs8RLD/kmu
         e8AUG1SUL+7h/yWHc8Pe1h6hk+66P+xvEQl7AEukE8+GZOVj8aTkt8dNzkt8ahBF8ca+
         FIuicomTtkk5709x9sbBn9Z4i0SWImUt/KpWULkAGRM2A7zne9M8lCdVy5m9psbD8yUi
         VWi4gg37A+81tK2ZLaCBijRG0kw9hEoeHZ5c2nfAcWMcw7Oz2ac9ypdbGmwOQ2pOhryt
         OhjFhGnflRNmD9PJs77RDsBFR8AoUpJiCtO2PlZ7U9warbrnRuU3Cz1kK9St8zM77Ajv
         qsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627900; x=1761232700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqdlCt5BKKyX7yhbZ4ebQoWy8WoAZk9NCmehMG9I47A=;
        b=BtkmVQ7praFdS50AQ+6xxYOqDqip2Qb5QbVJ99reP/ovxg1Ls0RODwEiMA7qmI83ks
         7zsrO9XprPvxm81bluiPIXu9q465u+N0z9tSpNwFov5Hkh1LAo+i90kdITtB/PgZzLUl
         CVV8QwcRIU/aohhe6zo281URQ8DD6sfUkly8NY0QR18j2PEaU7rrXmKk7wOmmbk9rj8F
         H7ZVKJAOamtxwi3E2gRiqkKUGg+tNPsMHpcUqJ5c3aMUCSr57AHdTY27H12SsWTVA4fU
         T4+ct9N6GGRphEEsuEIyO5CY2lC5aU/ArOED9BH/XZizXJqMp9bZi3dsqFp3BTYZdd2B
         eEZw==
X-Forwarded-Encrypted: i=1; AJvYcCX97nFdUPqCExGrTf2AkIR4/KGYa8UpIq6gJ0VcFevKYhkKi2BFhZZUQTC+Wgl3qd5qlUZne+tXh8vEfrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw7bT3TI6xMq1NyRocZnncnKMECytbNCmV6ciLkoRMdOGceWvW
	a2wvUYEfqogp68ym/idv54gIH43a8WBAAdEmmzn/FMqH5oA1tV6EYAILEmrPPyatoeY=
X-Gm-Gg: ASbGncsmEk6rZel5hsTT1iaikQHJCQqxnJwKMCD6vuV8tLXmG110VhkfFW00g4YNVzt
	OdfD/2tQsLsfQlcbHfQsasxKxSUOpWJi4PKOI5cacA1eaon0lWweSV+S9k+IX4fPejWCJm8ITtK
	93GLGQoX6jGBAuqe0VkIbS9ow+1Qxg3TwXUZrFDVk6u3gVpNEnvckWgROcYsEOajGhXGpVU0i9O
	0G3sTkUjcA+YPor4zcT15WHk5I1NJRkspGhVc1aigweFyZq4l8oWkGA15L/s4ktqnPEVSTqq9Za
	KiPCjgav51BgjfrI438XjBmo7q4c3mhBBTH2ycr8mWYk/rRyYW9b/uKSKnXKihY4x7CAeefBDrL
	y3H2YAnqAIOOQ0L2+eXTrfxDJBRoDjJs2qD70eyooU7txygoNQWcKuc42r5rSikKJFHTjq3TCBj
	DPLBjniw==
X-Google-Smtp-Source: AGHT+IEOawCy5/GAXPnxxA+0diZLg3UbKkqKE1h3l1GKVOEsTZ2Caris70qbzdRnQsmj6XRUsCpJEQ==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4711791c88bmr3180465e9.29.1760627899669;
        Thu, 16 Oct 2025 08:18:19 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm35712921f8f.2.2025.10.16.08.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:18:19 -0700 (PDT)
Message-ID: <9f33a736-ad3f-426c-93db-b5acca34e5f1@linaro.org>
Date: Thu, 16 Oct 2025 16:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: "Li, Tianyou" <tianyou.li@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, wangyang.guo@intel.com, pan.deng@intel.com,
 zhiguo.zhou@intel.com, jiebin.sun@intel.com, thomas.falcon@intel.com,
 dapeng1.mi@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
 <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
 <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
 <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
 <9f843a5b-4fa1-4abf-9c4b-1e5433ab9704@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <9f843a5b-4fa1-4abf-9c4b-1e5433ab9704@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 4:04 pm, Li, Tianyou wrote:
> 
> On 10/16/2025 9:06 PM, James Clark wrote:
>>
>>
>> On 16/10/2025 4:36 am, Li, Tianyou wrote:
>>> Hi James,
>>>
>>> Thanks for your time to review. Please see my comments inlined.
>>>
>>> Regards,
>>>
>>> Tianyou
>>>
>>> On 10/16/2025 1:30 AM, James Clark wrote:
>>>>
>>>>
>>>> On 15/10/2025 6:20 pm, Tianyou Li wrote:
>>>>> When perf report with annotation for a symbol, press 's' and 'T', 
>>>>> then exit
>>>>> the annotate browser. Once annotate the same symbol, the annotate 
>>>>> browser
>>>>> will crash.
>>>>>
>>>>> The browser.arch was required to be correctly updated when data type
>>>>> feature was enabled by 'T'. Usually it was initialized by 
>>>>> symbol__annotate2
>>>>> function. If a symbol has already been correctly annotated at the 
>>>>> first
>>>>> time, it should not call the symbol__annotate2 function again, thus 
>>>>> the
>>>>> browser.arch will not get initialized. Then at the second time to 
>>>>> show the
>>>>> annotate browser, the data type needs to be displayed but the 
>>>>> browser.arch
>>>>> is empty.
>>>>>
>>>>> Stack trace as below:
>>>>>
>>>>> Perf: Segmentation fault
>>>>> -------- backtrace --------
>>>>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>>>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>>>>      #2 0x570f08 in arch__is perf[570f08]
>>>>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>>>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>>>>      #5 0x56476d in annotation_line__write perf[56476d]
>>>>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>>>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>>>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>>>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>>>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>>>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>>>>      #12 0x552293 in do_annotate hists.c:0
>>>>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>>>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>>>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>>>>      #16 0x494008 in run_builtin perf.c:0
>>>>>      #17 0x494305 in handle_internal_command perf.c:0
>>>>>      #18 0x410547 in main perf[410547]
>>>>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>>>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 
>>>>> libc.so.6[29680]
>>>>>      #21 0x410b75 in _start perf[410b75]
>>>>>
>>>>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data 
>>>>> type display")
>>>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>>>> ---
>>>>>   tools/perf/ui/browsers/annotate.c | 3 +++
>>>>>   tools/perf/util/annotate.c        | 2 +-
>>>>>   tools/perf/util/annotate.h        | 2 ++
>>>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/ 
>>>>> browsers/annotate.c
>>>>> index 8fe699f98542..3b27ef1e8490 100644
>>>>> --- a/tools/perf/ui/browsers/annotate.c
>>>>> +++ b/tools/perf/ui/browsers/annotate.c
>>>>> @@ -1161,6 +1161,9 @@ int __hist_entry__tui_annotate(struct 
>>>>> hist_entry *he, struct map_symbol *ms,
>>>>>               if (!annotation__has_source(notes))
>>>>>                   ui__warning("Annotation has no source code.");
>>>>>           }
>>>>> +    } else if (evsel__get_arch(evsel, &browser.arch)) {
>>>>> +        ui__error("Couldn't get architecture for event '%s'", 
>>>>> evsel- >name);
>>>>> +        return -1;
>>>>>       }
>>>>
>>>> symbol_annotate() only fails for negative return values of 
>>>> evsel__get_arch(), but evsel__get_arch() has at least two positive 
>>>> error return values.
>>>>
>>>> If symbol_annotate() is wrong and it should be != 0 like you have, 
>>>> then maybe symbol_annotate() should be fixed in another commit in 
>>>> the same patchset as this one. Otherwise you have two calls to the 
>>>> same thing right next to each other that handle errors differently.
>>>
>>>
>>> Thanks James. I will give a try on handling the error message with 
>>> symbol__strerror_disassemble. I am conservative to change the code in 
>>> symbol_annotate, agreed it should be considered in another patch. 
>>> Would like to focus this particular issue and get it fixed properly. 
>>> Thanks.
>>>
>>>
>>
>> Looks like there was a misunderstanding. I'm not saying that the error 
>> is _reported_ differently, it's that the condition that triggers the 
>> error is different.
>>
>> symbol__annotate():
>>
>>   err = evsel__get_arch(evsel, &arch);
>>   if (err < 0)
>>       return err;
>>
>> You added:
>>
>>   if (evsel__get_arch(evsel, &browser.arch))
>>      ...
>>
>> evsel__get_arch() returns positive error values (and maybe also 
>> negative?), so "< 0" behaves differently to "!= 0".
>>
>> You either have to assume that "< 0" is correct and not change it, but 
>> then you have to also check the return value in the same way. Or if by 
>> doing "!= 0" you're implying that symbol__annotate() is wrong to do "< 
>> 0", then you should fix it now to not leave 
>> __hist_entry__tui_annotate() doing the same thing two different ways 
>> at different times.
>>
> Thanks James. I looked at the code of symbol__annotate, and noticed the 
> if (err<0) statement. I did not mean to change the code in 
> symbol__annotate because I did not understand why it handled the error 
> code that way. The positive return value of evsel__get_arch indicates 
> some error happens, eg in arm__annotate_init, so I use the 
> symbol__strerror_disassemble function to handle both positive and 
> negative error code.
> 
> I do agree we should check the error code of evsel__get_arch, but I am 
> hesitate to touch the code which I am not sure the consequences. I agree 
> it may deserve another patch but not in this patchset if we have clear 
> answers on why "<0" is not correct, or we have a case to break the 
> current code as a evidence. Thanks.
> 
> 
> Regards,
> 
> Tianyou
> 

It may take a little bit of effort to follow the code and look at the 
git blame to see what happened, but it's really not going to be that hard.

You're basically suggesting to add code that (when expanded) does this:

   if (first_run) {
      if (do_important_thing() < 0)
         return err;
   } else { // second run
      if (do_important_thing() != 0)
         return err;
   }

It's not going to help anyone who looks at it in the future. It's going 
to make future refactors of evsel__get_arch() more difficult, and 
without knowing why it's like that, it's possibly introducing another bug.

It surely has to be consistent otherwise it doesn't make sense. And if 
you sent a patch that did "< 0" I would still say "but it can return 
positive errors, so the new code isn't right".

I did suggest in the beginning to not check the error at all and add a 
comment saying it must succeed at that point because it's already done 
once before, but that's not very defensive and it doesn't fix the other 
possible bug.

>>>>
>>>>>         /* Copy necessary information when it's called from perf 
>>>>> top */
>>>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>>>> index a2e34f149a07..39d6594850f1 100644
>>>>> --- a/tools/perf/util/annotate.c
>>>>> +++ b/tools/perf/util/annotate.c
>>>>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, 
>>>>> struct evsel *evsel)
>>>>>       annotation__calc_percent(notes, evsel, symbol__size(sym));
>>>>>   }
>>>>>   -static int evsel__get_arch(struct evsel *evsel, struct arch 
>>>>> **parch)
>>>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>>>>   {
>>>>>       struct perf_env *env = evsel__env(evsel);
>>>>>       const char *arch_name = perf_env__arch(env);
>>>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>>>> index eaf6c8aa7f47..d4990bff29a7 100644
>>>>> --- a/tools/perf/util/annotate.h
>>>>> +++ b/tools/perf/util/annotate.h
>>>>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>>>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 
>>>>> *br_cntr,
>>>>>                    int num_aggr, struct evsel *evsel);
>>>>>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, 
>>>>> bool header);
>>>>> +
>>>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>>>>   #endif    /* __PERF_ANNOTATE_H */
>>>>
>>>>
>>
>>


