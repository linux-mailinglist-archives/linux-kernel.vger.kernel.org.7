Return-Path: <linux-kernel+bounces-856244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E546BBE3997
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6709619A03D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85C262FE9;
	Thu, 16 Oct 2025 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFaCXYW0"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881432D430
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760620002; cv=none; b=TnZwhwZ48nsVbArDHopG7rQFHPceT4WBdYQ1X76ggBJ9UzlDUXhSXu60U7lBuQDSanpawEpbXdAj+NryyhXZnvRhxyzlH4tQUxI5idaH5uFKc/P6dwykj/eF7bMllB6av+uk4y+uhIpsQqAGMYZ1W0a73eM0vy2/XWco3WPHY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760620002; c=relaxed/simple;
	bh=Fwn3+ZFYb5NsnlKBkcO65ojh6VYPdytKWfwsuarGUkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjZpPb9ULzE1nFN9Plk9IsBurpCrNVU0VfY2kqZeyo6Xdo8aIh8oPv276mlvxHN3HuRbtWuFjvZPQ8uswMI5tOXg9FiZAPXdHnnQS9+BTDA6K8k1lLVwe8xAoFzyjt0i1cJguj0tw5aHoEAOOgfbtt2KFzEZ+yf3zA1H6iJbVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFaCXYW0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e47cca387so8980385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760619998; x=1761224798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yrj0EuMYUMjb61nC669ZSmcXTvCvxsCMsas8zbAn4Ys=;
        b=nFaCXYW0NNuQz2/AR3CRcf62e114ml9+XxFgUWJv2gn/9/gSpfPxbdbibP7SRgTw3q
         GAt+1COgEywA0cAEdy7Mt9ewzttXuBHXLaE41tjXQUCJ7w+7N97tNDyhLKh/24vO35vf
         TJ7DIIJvB9ReP0ti0bo2g9aoxW/7R1vG6mbe4xTRx4gJn7ToUDcwYKgkHzGR8FqefNsq
         eY7eBMQ5efoxSOBjwDtbUZmFaW76gdtmPVNtspfy8+sNbXN6COeamOE0zLjzQHz+JqIB
         ubBdpgaT79Vdph1SWJaah8Y7qy/WcjzhX9Y+tp0iaj3CGx6ljuT/dTmsVvoQ218E+xlT
         VuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760619998; x=1761224798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yrj0EuMYUMjb61nC669ZSmcXTvCvxsCMsas8zbAn4Ys=;
        b=j9ea8JeetKPRJQ/CFKf4Ek9Hsr8dq+X7oSz4wL4PmzcVu4pOcdYfVzwBjMZaNsM8Ip
         JwYWUmW/ohCEjMT7F/hNGoTLAXnHFjiezmRM5/E/iDEs5n+C4EbrlKdFC3oZmDtn+Dy2
         GI6KMcpHj9aRT1D6czUB5eKLZt7fxTJWXP74FRtwzG5AMqAZTEZeX62UJS/TBdvQ7g5Y
         8qa0UJYb55W+lzgpH8d9BTefkVymgocmjAXUl1hjJPaKl1aFXq8HmDn8lfZfwVtlIsbl
         JQDTZnCKXBAyH/oKlYNXfpHW64hX6xol2Oxerfof/zu271j+on0N7/YhCKVSfrQ/R2ha
         fLCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQlvYzqFC9diHCT55G1zunaEzPeT6K1mohalNfIrCtEqP7LOjf56gjmOsrc/87JqnusMmSxKzR2TqkX3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz811v7HIkfZc0A93wT475YyJUjLUvEfeQWUXrAM4YFgkSVgPL
	gnjKCxdNFD9lUC2UrRtMNPI80mAxXwTMEx9/QqtmmdA+nP/icnTnm6QHbOR+lfjzyLI=
X-Gm-Gg: ASbGncujn5VnF7mI2ModPXzPS/2ltQuctd57kJhHCb4D5DzPxSNbe0zwcEAkZAeDxtU
	X5Rieyqf9+dHImWAJ9hfY1Y4lzSXGdJH7B1HeqhI4JBCjISNzKnTn7AqaUy9BYKyiuswqK9ArZU
	JLZp72u1nm8QLHSzdQ4eSINGQo6Fw4jSXoUPHe3WIWA5g6rZGsHLScVXv2Jg/HO2Vj3Ggim4H5o
	A3mPVRtkdmbtGkqo2RkLiZYOWOyk257FvNEYbdaDEGNZ3W48jppBS+u+oa4zjJl861BI3r/FnyP
	i2lLbbKxO6Z/s0wDK7VmwzofFHOmSrpP6bKBKO9XebFDcdU7zz01uzlnK0RGawNvtQSF2zvUTcC
	zf/CWYryuvQZZXTWDq4ZKX7C+gZX0l6E/xVVwMbMo+KDUBir0jUh8ATmD7GHd0oCVCAOy6ix1N8
	mYCyxXJhCqbt+gTYSc0GUZ
X-Google-Smtp-Source: AGHT+IEUqzJncW1KLuaaZxFZq0oQsNB/SNkWr/7gM3JpKolH0PuH9eUb/N9FjZ6moSa6JyLQJPFbpQ==
X-Received: by 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr234953215e9.3.1760619998511;
        Thu, 16 Oct 2025 06:06:38 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5d48sm26671225e9.9.2025.10.16.06.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 06:06:38 -0700 (PDT)
Message-ID: <046f1441-bc18-44e0-9bd0-f98a62ebbf9b@linaro.org>
Date: Thu, 16 Oct 2025 14:06:36 +0100
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <db33a977-c712-48b7-9be1-83721b23635f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/10/2025 4:36 am, Li, Tianyou wrote:
> Hi James,
> 
> Thanks for your time to review. Please see my comments inlined.
> 
> Regards,
> 
> Tianyou
> 
> On 10/16/2025 1:30 AM, James Clark wrote:
>>
>>
>> On 15/10/2025 6:20 pm, Tianyou Li wrote:
>>> When perf report with annotation for a symbol, press 's' and 'T', 
>>> then exit
>>> the annotate browser. Once annotate the same symbol, the annotate 
>>> browser
>>> will crash.
>>>
>>> The browser.arch was required to be correctly updated when data type
>>> feature was enabled by 'T'. Usually it was initialized by 
>>> symbol__annotate2
>>> function. If a symbol has already been correctly annotated at the first
>>> time, it should not call the symbol__annotate2 function again, thus the
>>> browser.arch will not get initialized. Then at the second time to 
>>> show the
>>> annotate browser, the data type needs to be displayed but the 
>>> browser.arch
>>> is empty.
>>>
>>> Stack trace as below:
>>>
>>> Perf: Segmentation fault
>>> -------- backtrace --------
>>>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>>>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>>>      #2 0x570f08 in arch__is perf[570f08]
>>>      #3 0x562186 in annotate_get_insn_location perf[562186]
>>>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>>>      #5 0x56476d in annotation_line__write perf[56476d]
>>>      #6 0x54e2db in annotate_browser__write annotate.c:0
>>>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>>>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>>>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>>>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>>>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>>>      #12 0x552293 in do_annotate hists.c:0
>>>      #13 0x55941c in evsel__hists_browse hists.c:0
>>>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>>>      #15 0x42ff02 in cmd_report perf[42ff02]
>>>      #16 0x494008 in run_builtin perf.c:0
>>>      #17 0x494305 in handle_internal_command perf.c:0
>>>      #18 0x410547 in main perf[410547]
>>>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>>>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 
>>> libc.so.6[29680]
>>>      #21 0x410b75 in _start perf[410b75]
>>>
>>> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data 
>>> type display")
>>> Reviewed-by: James Clark <james.clark@linaro.org>
>>> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
>>> ---
>>>   tools/perf/ui/browsers/annotate.c | 3 +++
>>>   tools/perf/util/annotate.c        | 2 +-
>>>   tools/perf/util/annotate.h        | 2 ++
>>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/ 
>>> browsers/annotate.c
>>> index 8fe699f98542..3b27ef1e8490 100644
>>> --- a/tools/perf/ui/browsers/annotate.c
>>> +++ b/tools/perf/ui/browsers/annotate.c
>>> @@ -1161,6 +1161,9 @@ int __hist_entry__tui_annotate(struct 
>>> hist_entry *he, struct map_symbol *ms,
>>>               if (!annotation__has_source(notes))
>>>                   ui__warning("Annotation has no source code.");
>>>           }
>>> +    } else if (evsel__get_arch(evsel, &browser.arch)) {
>>> +        ui__error("Couldn't get architecture for event '%s'", evsel- 
>>> >name);
>>> +        return -1;
>>>       }
>>
>> symbol_annotate() only fails for negative return values of 
>> evsel__get_arch(), but evsel__get_arch() has at least two positive 
>> error return values.
>>
>> If symbol_annotate() is wrong and it should be != 0 like you have, 
>> then maybe symbol_annotate() should be fixed in another commit in the 
>> same patchset as this one. Otherwise you have two calls to the same 
>> thing right next to each other that handle errors differently.
> 
> 
> Thanks James. I will give a try on handling the error message with 
> symbol__strerror_disassemble. I am conservative to change the code in 
> symbol_annotate, agreed it should be considered in another patch. Would 
> like to focus this particular issue and get it fixed properly. Thanks.
> 
> 

Looks like there was a misunderstanding. I'm not saying that the error 
is _reported_ differently, it's that the condition that triggers the 
error is different.

symbol__annotate():

   err = evsel__get_arch(evsel, &arch);
   if (err < 0)
       return err;

You added:

   if (evsel__get_arch(evsel, &browser.arch))
      ...

evsel__get_arch() returns positive error values (and maybe also 
negative?), so "< 0" behaves differently to "!= 0".

You either have to assume that "< 0" is correct and not change it, but 
then you have to also check the return value in the same way. Or if by 
doing "!= 0" you're implying that symbol__annotate() is wrong to do "< 
0", then you should fix it now to not leave __hist_entry__tui_annotate() 
doing the same thing two different ways at different times.

>>
>>>         /* Copy necessary information when it's called from perf top */
>>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>>> index a2e34f149a07..39d6594850f1 100644
>>> --- a/tools/perf/util/annotate.c
>>> +++ b/tools/perf/util/annotate.c
>>> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, 
>>> struct evsel *evsel)
>>>       annotation__calc_percent(notes, evsel, symbol__size(sym));
>>>   }
>>>   -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>>>   {
>>>       struct perf_env *env = evsel__env(evsel);
>>>       const char *arch_name = perf_env__arch(env);
>>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>>> index eaf6c8aa7f47..d4990bff29a7 100644
>>> --- a/tools/perf/util/annotate.h
>>> +++ b/tools/perf/util/annotate.h
>>> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>>>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>>>                    int num_aggr, struct evsel *evsel);
>>>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, 
>>> bool header);
>>> +
>>> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>>>   #endif    /* __PERF_ANNOTATE_H */
>>
>>


