Return-Path: <linux-kernel+bounces-844007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC9DBC0D23
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91B9189B66C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70552D6E62;
	Tue,  7 Oct 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEkE620G"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554E2797BE
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828217; cv=none; b=FNZ0AjgCJzeTjblbxi/xQnMQG2LqRwNjuD7fBoWuzaFw4VqQUVC4nyV1jr2LUVpX5UZe2tgBNEIsBjzDEsLb3r1+Wo06YZM/IuMBCQ3iRxcZ9RuI0lceOSwOfyBWv14Je7gftFHSSmfUgI/dD3MeXd+ToHqS4uSUrG7+SZLHdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828217; c=relaxed/simple;
	bh=xkurHUrHiDvxiaLEkzB8GFBV/iCz22WvC9ERFE1fsyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruHctz80SW3k/u9mIgpzVBEfw7AqmYyCgoWutEmumRjHfTNTuqKDbXhdf1AFeqxw2XCfMN42R0JXAbmqqJ8XxcELZ2auxNBuAbdqpFLaWfrRopPhrHs30onSAlCYs3f6T1G4w+2h/P3yQwa2vY51gaAjkCI0/d4WlKIIZaxWz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEkE620G; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46b303f755aso46053175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759828214; x=1760433014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A5grJalUNQTGqrKuVDzibQGrnaKKNODDxPG9phNRc4=;
        b=VEkE620GO+P0p3Kl0IhNLbTLGXNiylhm8Uzo2xfxp8/jOR0WuAqG3sUNL8PjADOo20
         oTHtrtITiaAt19/OqyVmJ6KL88ECRkSOP+WeDv45m32kT5hFYQzz+w/7q75P1GLpr+fW
         bGB898LsHqpTqCVNcuPixVkdPeHqcpANCed3u9dOjEY3Fuj/Yl/WV2PsLoNajvO9lp/5
         cucyxZmvPN5yNmTz/o2K26DMspSXS1xs0xnlDnA7VWMX8C0NSwdjiAgGwy+EAvu4i+hZ
         Z1FORkaW6COnrX75lZiC8o3Tg0iJqddDh0s4CQcp/s8Jc+No+lUWATBmpgQNZQdTAPp3
         CFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759828214; x=1760433014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1A5grJalUNQTGqrKuVDzibQGrnaKKNODDxPG9phNRc4=;
        b=GSA3LKXAq7S8wayRhuz/tn73KHWBPJFnpJc2N/bopDOasRymQl/RpEvrWlAFQNq0uU
         bqcM5y8vE7gtfPI+kbdotQ3SwXtS8MwYXlYddKwtplMNmDSwm8lzQ+TgITZuqNJ2US0b
         Km4rSzdgZW2w66hbExrBAaIZdxRIh45uaieTrEqXytDpO8Kft70higvSUH8VYipU09sX
         WAhki37o5D3uHFngRSRVgGN+L1Z+nQRBi3ilh1h3Z6exx8qRYBFJPvBqq3wZKwjiTh4y
         4UYURP7JOl/aEQzFj7iSPmJJonrch+xS9ndaXGJlNeSG4Mm7XsGtZ2S791a0+n+L4PWT
         okYg==
X-Forwarded-Encrypted: i=1; AJvYcCVHmU9idOELMGJX7sNn7oLZuoRG7E+vREww8McOqULiCBPXFTm/nWqsmi7jlKXG5O7V15Xd3CgyRh1vbuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Lteea11o9w9qG0a6g8BN2pu2cpGm303J8VTz93ajKyxytGwo
	6HtChwb6F4ZkTv3L6FjUOwZTFoXKZdvJZ9WFuVyJzCyIrNNW44SwGDXYyO+cSWDhyRw=
X-Gm-Gg: ASbGncshToLrEzQaQ+bspwXodLrW3hL5oNm5+fskUecYKBO49xPTgIS6xK2OtG1KiWn
	1e5ek2X6Q/S0XI6mLFwkP8nQwcTqM9RmoDqFmwSupgznxzt9JIW1Au0UM7Fv3KvM0SwH3k8A3Ef
	Qv+NmRxQLdYsIzG47Sr1WO8dMycQvDcnsIt/1xpXYXtwWRTvWwwvPo7siwevqndEyfJgCEUb2uo
	sogt7WfLHvwe3CVRjLW7jlQ0IrJlVYFk4snG3BzGusBB0h2QyRIUVQCWdYcroL9ryno10xJKp+M
	nnozLQS8PpA0egXAH/W0tUG4PzEEGF6170N/vwT2wMOvK9yLLr8q5Bxciat2BFKGDAvpOvEYYwj
	TvNBdBJRrwAnHv+BYVwBtvKKUSAEMsBHuITSMMplRNhCDQ+juQVa21I1z
X-Google-Smtp-Source: AGHT+IGMFiVKJp39q+pMns0W0NskfICt/r26mga3cpyM8uAPmyuedwXmOqFinHFTEHYx9lKQOrElfw==
X-Received: by 2002:a05:600d:41f3:b0:46e:4a78:dea9 with SMTP id 5b1f17b1804b1-46e71145dc7mr133486085e9.17.1759828213740;
        Tue, 07 Oct 2025 02:10:13 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c396esm292761625e9.8.2025.10.07.02.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 02:10:13 -0700 (PDT)
Message-ID: <b39ffdd5-1692-46ed-86d9-726011c92036@linaro.org>
Date: Tue, 7 Oct 2025 10:10:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Don't retest sections in "Object code
 reading"
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251006-james-perf-object-code-reading-v1-1-acab2129747d@linaro.org>
 <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXmAbz7Gp5eCRFYsYu_pZoFNSR+mcJgE6Eu6YewHyLNtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 06/10/2025 4:21 pm, Ian Rogers wrote:
> On Mon, Oct 6, 2025 at 6:11 AM James Clark <james.clark@linaro.org> wrote:
>>
>> We already only test each kcore map once, but on slow systems
>> (particularly with network filesystems) even the non-kcore maps are
>> slow. The test can test the same objump output over and over which only
>> wastes time. Generalize the skipping mechanism to track all DSOs and
>> addresses so that each section is only tested once.
>>
>> On a fully loaded Arm Juno (simulating a parallel Perf test run) with a
>> network filesystem, the original runtime is:
>>
>>    real  1m51.126s
>>    user  0m19.445s
>>    sys   1m15.431s
>>
>> And the new runtime is:
>>
>>    real  0m48.873s
>>    user  0m8.031s
>>    sys   0m32.353s
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
>> ---
>>   tools/perf/tests/code-reading.c | 119 ++++++++++++++++++++++++++++------------
>>   1 file changed, 85 insertions(+), 34 deletions(-)
>>
>> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
>> index 9c2091310191..4c9fbf6965c4 100644
>> --- a/tools/perf/tests/code-reading.c
>> +++ b/tools/perf/tests/code-reading.c
>> @@ -2,6 +2,7 @@
>>   #include <errno.h>
>>   #include <linux/kconfig.h>
>>   #include <linux/kernel.h>
>> +#include <linux/rbtree.h>
>>   #include <linux/types.h>
>>   #include <inttypes.h>
>>   #include <stdlib.h>
>> @@ -39,11 +40,64 @@
>>   #define BUFSZ  1024
>>   #define READLEN        128
>>
>> -struct state {
>> -       u64 done[1024];
>> -       size_t done_cnt;
>> +struct tested_section {
>> +       struct rb_node rb_node;
>> +       u64 addr;
>> +       char path[PATH_MAX];
>>   };
>>
>> +static bool tested_code_insert_or_exists(const char *path, u64 addr,
>> +                                        struct rb_root *tested_sections)
>> +{
>> +       struct rb_node **node = &tested_sections->rb_node;
>> +       struct rb_node *parent = NULL;
>> +       struct tested_section *data;
>> +
>> +       while (*node) {
>> +               int cmp;
>> +
>> +               parent = *node;
>> +               data = rb_entry(*node, struct tested_section, rb_node);
>> +               cmp = strcmp(path, data->path);
>> +               if (!cmp) {
>> +                       if (addr < data->addr)
>> +                               cmp = -1;
>> +                       else if (addr > data->addr)
>> +                               cmp = 1;
>> +                       else
>> +                               return true; /* already tested */
>> +               }
>> +
>> +               if (cmp < 0)
>> +                       node = &(*node)->rb_left;
>> +               else
>> +                       node = &(*node)->rb_right;
>> +       }
>> +
>> +       data = zalloc(sizeof(*data));
>> +       if (!data)
>> +               return true;
>> +
>> +       data->addr = addr;
>> +       strlcpy(data->path, path, sizeof(data->path));
> 
> nit: perhaps strdup rather than having 4kb per tested_section.
> 
> Thanks,
> Ian
> 

Oh yeah that would have been better, not sure why I didn't do it that 
way. Although the max sections I saw was around 50, and it's usually a 
lot less so it's probably not worth the churn to change it now that 
Arnaldo's applied it?

Thanks
James

>> +       rb_link_node(&data->rb_node, parent, node);
>> +       rb_insert_color(&data->rb_node, tested_sections);
>> +       return false;
>> +}
>> +
>> +static void tested_sections__free(struct rb_root *root)
>> +{
>> +       while (!RB_EMPTY_ROOT(root)) {
>> +               struct rb_node *node = rb_first(root);
>> +               struct tested_section *ts = rb_entry(node,
>> +                                                    struct tested_section,
>> +                                                    rb_node);
>> +
>> +               rb_erase(node, root);
>> +               free(ts);
>> +       }
>> +}
>> +
>>   static size_t read_objdump_chunk(const char **line, unsigned char **buf,
>>                                   size_t *buf_len)
>>   {
>> @@ -316,13 +370,15 @@ static void dump_buf(unsigned char *buf, size_t len)
>>   }
>>
>>   static int read_object_code(u64 addr, size_t len, u8 cpumode,
>> -                           struct thread *thread, struct state *state)
>> +                           struct thread *thread,
>> +                           struct rb_root *tested_sections)
>>   {
>>          struct addr_location al;
>>          unsigned char buf1[BUFSZ] = {0};
>>          unsigned char buf2[BUFSZ] = {0};
>>          size_t ret_len;
>>          u64 objdump_addr;
>> +       u64 skip_addr;
>>          const char *objdump_name;
>>          char decomp_name[KMOD_DECOMP_LEN];
>>          bool decomp = false;
>> @@ -350,6 +406,18 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>>                  goto out;
>>          }
>>
>> +       /*
>> +        * Don't retest the same addresses. objdump struggles with kcore - try
>> +        * each map only once even if the address is different.
>> +        */
>> +       skip_addr = dso__is_kcore(dso) ? map__start(al.map) : al.addr;
>> +       if (tested_code_insert_or_exists(dso__long_name(dso), skip_addr,
>> +                                        tested_sections)) {
>> +               pr_debug("Already tested %s @ %#"PRIx64" - skipping\n",
>> +                        dso__long_name(dso), skip_addr);
>> +               goto out;
>> +       }
>> +
>>          pr_debug("On file address is: %#"PRIx64"\n", al.addr);
>>
>>          if (len > BUFSZ)
>> @@ -387,24 +455,6 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>>                  goto out;
>>          }
>>
>> -       /* objdump struggles with kcore - try each map only once */
>> -       if (dso__is_kcore(dso)) {
>> -               size_t d;
>> -
>> -               for (d = 0; d < state->done_cnt; d++) {
>> -                       if (state->done[d] == map__start(al.map)) {
>> -                               pr_debug("kcore map tested already");
>> -                               pr_debug(" - skipping\n");
>> -                               goto out;
>> -                       }
>> -               }
>> -               if (state->done_cnt >= ARRAY_SIZE(state->done)) {
>> -                       pr_debug("Too many kcore maps - skipping\n");
>> -                       goto out;
>> -               }
>> -               state->done[state->done_cnt++] = map__start(al.map);
>> -       }
>> -
>>          objdump_name = dso__long_name(dso);
>>          if (dso__needs_decompress(dso)) {
>>                  if (dso__decompress_kmodule_path(dso, objdump_name,
>> @@ -471,9 +521,9 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>>          return err;
>>   }
>>
>> -static int process_sample_event(struct machine *machine,
>> -                               struct evlist *evlist,
>> -                               union perf_event *event, struct state *state)
>> +static int process_sample_event(struct machine *machine, struct evlist *evlist,
>> +                               union perf_event *event,
>> +                               struct rb_root *tested_sections)
>>   {
>>          struct perf_sample sample;
>>          struct thread *thread;
>> @@ -494,7 +544,8 @@ static int process_sample_event(struct machine *machine,
>>                  goto out;
>>          }
>>
>> -       ret = read_object_code(sample.ip, READLEN, sample.cpumode, thread, state);
>> +       ret = read_object_code(sample.ip, READLEN, sample.cpumode, thread,
>> +                              tested_sections);
>>          thread__put(thread);
>>   out:
>>          perf_sample__exit(&sample);
>> @@ -502,10 +553,11 @@ static int process_sample_event(struct machine *machine,
>>   }
>>
>>   static int process_event(struct machine *machine, struct evlist *evlist,
>> -                        union perf_event *event, struct state *state)
>> +                        union perf_event *event, struct rb_root *tested_sections)
>>   {
>>          if (event->header.type == PERF_RECORD_SAMPLE)
>> -               return process_sample_event(machine, evlist, event, state);
>> +               return process_sample_event(machine, evlist, event,
>> +                                           tested_sections);
>>
>>          if (event->header.type == PERF_RECORD_THROTTLE ||
>>              event->header.type == PERF_RECORD_UNTHROTTLE)
>> @@ -525,7 +577,7 @@ static int process_event(struct machine *machine, struct evlist *evlist,
>>   }
>>
>>   static int process_events(struct machine *machine, struct evlist *evlist,
>> -                         struct state *state)
>> +                         struct rb_root *tested_sections)
>>   {
>>          union perf_event *event;
>>          struct mmap *md;
>> @@ -537,7 +589,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
>>                          continue;
>>
>>                  while ((event = perf_mmap__read_event(&md->core)) != NULL) {
>> -                       ret = process_event(machine, evlist, event, state);
>> +                       ret = process_event(machine, evlist, event, tested_sections);
>>                          perf_mmap__consume(&md->core);
>>                          if (ret < 0)
>>                                  return ret;
>> @@ -637,9 +689,7 @@ static int do_test_code_reading(bool try_kcore)
>>                          .uses_mmap   = true,
>>                  },
>>          };
>> -       struct state state = {
>> -               .done_cnt = 0,
>> -       };
>> +       struct rb_root tested_sections = RB_ROOT;
>>          struct perf_thread_map *threads = NULL;
>>          struct perf_cpu_map *cpus = NULL;
>>          struct evlist *evlist = NULL;
>> @@ -773,7 +823,7 @@ static int do_test_code_reading(bool try_kcore)
>>
>>          evlist__disable(evlist);
>>
>> -       ret = process_events(machine, evlist, &state);
>> +       ret = process_events(machine, evlist, &tested_sections);
>>          if (ret < 0)
>>                  goto out_put;
>>
>> @@ -793,6 +843,7 @@ static int do_test_code_reading(bool try_kcore)
>>          perf_thread_map__put(threads);
>>          machine__delete(machine);
>>          perf_env__exit(&host_env);
>> +       tested_sections__free(&tested_sections);
>>
>>          return err;
>>   }
>>
>> ---
>> base-commit: a22d167ed82505f770340c3a7c257c04ba24dac9
>> change-id: 20251006-james-perf-object-code-reading-9646e486d595
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>


