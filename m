Return-Path: <linux-kernel+bounces-854986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE0BDFE29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBFD3A9F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DBD2F99A6;
	Wed, 15 Oct 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zQ/N+zK2"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5628BAB9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760549451; cv=none; b=UDHsBYBmOdVCHY78lWrdr1JK7Tmd9ngwaDTRLGOJGYvNZbFmHnWJmyblu+f8x9J89x1hp6+2ZEHne7dgBpvsOHz/m/+qX42xezzd/F8md4e/Fl5C3afL7FiVSE4nF6l2vlFClFJczSLVN073b353K6obPPNSfhisgHJwfdZe27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760549451; c=relaxed/simple;
	bh=V0wrARj4KWv4xJSe64DNiDyHKIsl+Venk5aa5zheHW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3KMCtaB5fut9YZGir+JnziKtCYHVPk1wuohOwjHGXzyzCid4bRvvKhxdwmglVasWfcC8XNxkOcXFqHYn8VQkj3uU7dc7yP2AbNe7SBWumtFmMisiEcr6VGogsVtbDXFwY/C8CWxz2QIfXSnZTkHV1K+dra0ryVie69gRqXNN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zQ/N+zK2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso5076587f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760549448; x=1761154248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDcNZGtS8KzGIECWrjIMP0Q7h9U4tn90v5She1AYbvQ=;
        b=zQ/N+zK2Xa39coKE3klolHn6CGjH35x+R1sX1v3N0m2J+JTlLAKM9K6TxGuBUPEZwj
         dQpTZL/tDHtxULoDOEOjf20I3CyQ+L2N7XBViuE1USNVc13SOisIGFi+EMXrJPAHPaiz
         O1vxvj/VGRB8ZAWEOM7lOoaMsgpc2G2C+O9ezFkLEBv92g4OmV9X8mk5BKBKTg832mvw
         ozD/2mkfqqZ57XF2DYcgbb+o1EPRlAK3YkJMAlghG9WU4FLsxaWwtomzBmaJb7jiS5YE
         NWcRwWEjOl2gSlrUidWKROMz4T0Z9Vow9v0An84jKyCy8aB1lWY37ej3ccv1H6d8Gjtd
         8whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760549448; x=1761154248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDcNZGtS8KzGIECWrjIMP0Q7h9U4tn90v5She1AYbvQ=;
        b=A6KvmOPCH8NY1EnK0cnj5SHvuy5o7akm52hB1R33GYTjbAI0bXAWOGLsiGB0OYHmvQ
         FrCk/Anh2/yW/ZRBpFAJAuXkTGX5ahiF3eHJmRVbJzBFBAiMZAxcuuB+T4hDiuZjrqDk
         HjRcJs40FH75+KAWuIxTahYRyG+WvkfW7+1ZQuM6sU9E8Ez5Rbqi4nnieunR0dCbi8RD
         9gaS//VPPirBICWzIaDHYYj2MCJ2zyOJqB/WzRU1+ULLWNptc3gL04UYYWzvQPXuwo9o
         PUWUCYQQMFQGo/7ZBoH1UvHnzSUnyhD8MoWBSSBlhoqXt62Q+SY4ylchhy9bbFEdUkF0
         k9pA==
X-Forwarded-Encrypted: i=1; AJvYcCVYFsJMI6YDLsbLhwx13bBPUKNwDdo/rHLqoi3yo8thNxDanWQWByY/aX23POZunXi+JOvWQIfRfyI5IFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5a6Njih6hfRsFf/wZ/GB0Gk/d13FkrsgSWVdWjpOcrlKuMU2
	yShcaDVsmKQ30JOXyUjwZFXkQ2sZaDolBrbYSadQKg+D5vnOEyYOlJLErhThTNAa36U=
X-Gm-Gg: ASbGncvlJiWJdgD/Aw/qzxWIO4+INGFhMmeM7CfA1SB1bWls+Y5lJXv3jnX39yNi5IM
	lcNisXsuuCU2kVdVBfk+HG9Yx9gDCR046BFFCbXexqObfw9S3zHXbhEm7AI+3TanIn0XVrq0BGq
	QwOHIRpFMi39shRoEYQImWIMkEwVcIfAVGGeJPZCo6XC8W46uIb+OQaPugLz3+0K1cpp/LbFPN1
	K5WHBIE4SE6fxsALZO+MsaOwpTlkUK05/iycK8YA1aH2txg+WJn34Uh6iqGX3dqbg5hCXqa9vMF
	HKMjJhWq8X828QiXiH+T0k+Uhgrd9Vt04v+7m1qeOOrbsa3bGtOQtqTfRzDQBtaK23/5TxAHlJo
	qzfI7N6+lIaRwQJg55/11r0GpHmXteUvvjMMUzEwc6B+Zln9EpQPNbIVwvVK3PQ==
X-Google-Smtp-Source: AGHT+IE15Ue4wkQtE4rhbm/mVXaDKMWSJhGFsg8zWWcs9wH28c9LW5s7l8v+up0OURuqO3XiGGFr7Q==
X-Received: by 2002:a05:6000:4210:b0:3f2:b077:94bc with SMTP id ffacd0b85a97d-42666ac4119mr17087793f8f.4.1760549448027;
        Wed, 15 Oct 2025 10:30:48 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce589b3dsm30716389f8f.24.2025.10.15.10.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 10:30:47 -0700 (PDT)
Message-ID: <4151e2e4-b7df-4c04-b038-71ff2612ee8d@linaro.org>
Date: Wed, 15 Oct 2025 18:30:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tools annotate: fix a crash when annotate the
 same symbol with 's' and 'T'
To: Tianyou Li <tianyou.li@intel.com>, Namhyung Kim <namhyung@kernel.org>
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
 linux-kernel@vger.kernel.org
References: <baea1e93-5e30-404e-8a5d-8b1d20cf8761@linaro.org>
 <20251015172017.2115213-1-tianyou.li@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251015172017.2115213-1-tianyou.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/10/2025 6:20 pm, Tianyou Li wrote:
> When perf report with annotation for a symbol, press 's' and 'T', then exit
> the annotate browser. Once annotate the same symbol, the annotate browser
> will crash.
> 
> The browser.arch was required to be correctly updated when data type
> feature was enabled by 'T'. Usually it was initialized by symbol__annotate2
> function. If a symbol has already been correctly annotated at the first
> time, it should not call the symbol__annotate2 function again, thus the
> browser.arch will not get initialized. Then at the second time to show the
> annotate browser, the data type needs to be displayed but the browser.arch
> is empty.
> 
> Stack trace as below:
> 
> Perf: Segmentation fault
> -------- backtrace --------
>      #0 0x55d365 in ui__signal_backtrace setup.c:0
>      #1 0x7f5ff1a3e930 in __restore_rt libc.so.6[3e930]
>      #2 0x570f08 in arch__is perf[570f08]
>      #3 0x562186 in annotate_get_insn_location perf[562186]
>      #4 0x562626 in __hist_entry__get_data_type annotate.c:0
>      #5 0x56476d in annotation_line__write perf[56476d]
>      #6 0x54e2db in annotate_browser__write annotate.c:0
>      #7 0x54d061 in ui_browser__list_head_refresh perf[54d061]
>      #8 0x54dc9e in annotate_browser__refresh annotate.c:0
>      #9 0x54c03d in __ui_browser__refresh browser.c:0
>      #10 0x54ccf8 in ui_browser__run perf[54ccf8]
>      #11 0x54eb92 in __hist_entry__tui_annotate perf[54eb92]
>      #12 0x552293 in do_annotate hists.c:0
>      #13 0x55941c in evsel__hists_browse hists.c:0
>      #14 0x55b00f in evlist__tui_browse_hists perf[55b00f]
>      #15 0x42ff02 in cmd_report perf[42ff02]
>      #16 0x494008 in run_builtin perf.c:0
>      #17 0x494305 in handle_internal_command perf.c:0
>      #18 0x410547 in main perf[410547]
>      #19 0x7f5ff1a295d0 in __libc_start_call_main libc.so.6[295d0]
>      #20 0x7f5ff1a29680 in __libc_start_main@@GLIBC_2.34 libc.so.6[29680]
>      #21 0x410b75 in _start perf[410b75]
> 
> Fixes: 1d4374afd000 ("perf annotate: Add 'T' hot key to toggle data type display")
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> ---
>   tools/perf/ui/browsers/annotate.c | 3 +++
>   tools/perf/util/annotate.c        | 2 +-
>   tools/perf/util/annotate.h        | 2 ++
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 8fe699f98542..3b27ef1e8490 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -1161,6 +1161,9 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
>   			if (!annotation__has_source(notes))
>   				ui__warning("Annotation has no source code.");
>   		}
> +	} else if (evsel__get_arch(evsel, &browser.arch)) {
> +		ui__error("Couldn't get architecture for event '%s'", evsel->name);
> +		return -1;
>   	}

symbol_annotate() only fails for negative return values of 
evsel__get_arch(), but evsel__get_arch() has at least two positive error 
return values.

If symbol_annotate() is wrong and it should be != 0 like you have, then 
maybe symbol_annotate() should be fixed in another commit in the same 
patchset as this one. Otherwise you have two calls to the same thing 
right next to each other that handle errors differently.

>   
>   	/* Copy necessary information when it's called from perf top */
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a2e34f149a07..39d6594850f1 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -980,7 +980,7 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
>   	annotation__calc_percent(notes, evsel, symbol__size(sym));
>   }
>   
> -static int evsel__get_arch(struct evsel *evsel, struct arch **parch)
> +int evsel__get_arch(struct evsel *evsel, struct arch **parch)
>   {
>   	struct perf_env *env = evsel__env(evsel);
>   	const char *arch_name = perf_env__arch(env);
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index eaf6c8aa7f47..d4990bff29a7 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -585,4 +585,6 @@ void debuginfo_cache__delete(void);
>   int annotation_br_cntr_entry(char **str, int br_cntr_nr, u64 *br_cntr,
>   			     int num_aggr, struct evsel *evsel);
>   int annotation_br_cntr_abbr_list(char **str, struct evsel *evsel, bool header);
> +
> +int evsel__get_arch(struct evsel *evsel, struct arch **parch);
>   #endif	/* __PERF_ANNOTATE_H */


