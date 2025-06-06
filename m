Return-Path: <linux-kernel+bounces-675279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F830ACFB4E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 04:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1044F174235
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F261A5BA9;
	Fri,  6 Jun 2025 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PJWV9GbY"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9577FD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749177430; cv=none; b=AJy5vDL1n4vTMO5gBMTnJQYbcxBX5kLrsl+my6Db+BjJRGd9XBBAuSsWAGCoxxTnmFP900czbtnKuWKx0Maj7ztvYG/0bSDOorZMX+VdVeKbRpo5cPdbma6fc+UHD7HZQYJ9I9b/wqmkUxeUVMu0IyxHeEXthaHoFq/iQkeU/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749177430; c=relaxed/simple;
	bh=nzEsZobLXTdTuO4MlKPwcKlAos+/+mkMxxOXaTfoxWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NY/onDlckEUj5STciD1P3cqIgo4mzdhj76B3KmzQDcvzR9vVvJEI7eYj1nZbeQuYPBtRh9oULJj+2PedZjOg4bmnGYMvHfdJgYsGsDpkTjiiBerRTI1g2m8+B1hHDXi00ioG7qlPXtW9tSZUbieYqsvv2PBeG0APHcv/CVVQZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PJWV9GbY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <674ffa66-1145-4e89-b30f-04c55ff8eb02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749177416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t3hBQ1RXDJy1XF60ulrHvm75Jbv4mZNH1cILrTi8a3I=;
	b=PJWV9GbYBpr6PAAfmpKx+JYdZOUeG1jL1Z0n0xQWk0AIukfcsmjaU/9K701fXIQXlxiK68
	4og42AaH4MWancw7dP5aQSTm0GV3WiChcXsWPrgAII/R2Y73avSxhNeXpC5r3tA0tIXaR0
	6vl2x8wtZbOVkpPJUEtfKC14H6jbU7A=
Date: Fri, 6 Jun 2025 10:36:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add show_fdinfo for perf_event
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250604163723.3175258-1-chen.dylane@linux.dev>
 <CAEf4BzasaZYD7y+4Po=K=jBq3Q7JSUMpJ_NSQv7B9=v6fieZ7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzasaZYD7y+4Po=K=jBq3Q7JSUMpJ_NSQv7B9=v6fieZ7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/6 02:41, Andrii Nakryiko 写道:
> On Wed, Jun 4, 2025 at 9:37 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> After commit 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event") add
>> perf_event info, we can also show the info with the method of cat /proc/[fd]/fdinfo.
>>
>> kprobe fdinfo:
>> link_type:      perf
>> link_id:        2
>> prog_tag:       bcf7977d3b93787c
>> prog_id:        18
>> name:   bpf_fentry_test1
>> offset: 0
>> missed: 0
>> addr:   ffffffffaea8d134
>> event_type:     3
>> cookie: 3735928559
>>
>> uprobe fdinfo:
>> link_type:      perf
>> link_id:        6
>> prog_tag:       bcf7977d3b93787c
>> prog_id:        7
>> name:   /proc/self/exe
>> offset: 6507541
>> event_type:     1
>> cookie: 3735928559
>>
>> tracepoint fdinfo:
>> link_type:      perf
>> link_id:        4
>> prog_tag:       bcf7977d3b93787c
>> prog_id:        8
>> tp_name:        sched_switch
>> event_type:     5
>> cookie: 3735928559
>>
>> perf_event fdinfo:
>> link_type:      perf
>> link_id:        5
>> prog_tag:       bcf7977d3b93787c
>> prog_id:        9
>> type:   1
>> config: 2
>> event_type:     6
>> cookie: 3735928559
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/bpf/syscall.c | 126 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 126 insertions(+)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 9794446bc8..9af54852eb 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3793,6 +3793,35 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
>>          info->perf_event.kprobe.cookie = event->bpf_cookie;
>>          return 0;
>>   }
>> +
>> +static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
>> +                                       struct seq_file *seq)
>> +{
>> +       const char *name;
>> +       int err;
>> +       u32 prog_id, type;
>> +       u64 offset, addr;
>> +       unsigned long missed;
>> +
>> +       err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
>> +                                     &offset, &addr, &missed);
>> +       if (err)
>> +               return;
>> +
>> +       if (type == BPF_FD_TYPE_KRETPROBE)
>> +               type = BPF_PERF_EVENT_KRETPROBE;
>> +       else
>> +               type = BPF_PERF_EVENT_KPROBE;
> 
> maybe use "kretprobe" and "kprobe" strings?
> 

It looks more readable, i will change it in v2, thanks.

>> +
>> +       seq_printf(seq,
>> +                  "name:\t%s\n"
>> +                  "offset:\t%llu\n"
> 
> llx, hex makes most sense (we had similar discussion within the
> context of bpftool reporting)
> 
> pw-bot: cr
> 
>> +                  "missed:\t%lu\n"
>> +                  "addr:\t%llx\n"
> 
> ditto, address -> hex
> 

will change it in v2, thanks.

>> +                  "event_type:\t%u\n"
>> +                  "cookie:\t%llu\n",
>> +                  name, offset, missed, addr, type, event->bpf_cookie);
>> +}
>>   #endif
>>
>>   #ifdef CONFIG_UPROBE_EVENTS
>> @@ -3820,6 +3849,34 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
>>          info->perf_event.uprobe.cookie = event->bpf_cookie;
>>          return 0;
>>   }
>> +
>> +static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
>> +                                       struct seq_file *seq)
>> +{
>> +       const char *name;
>> +       int err;
>> +       u32 prog_id, type;
>> +       u64 offset, addr;
>> +       unsigned long missed;
>> +
>> +       err = bpf_get_perf_event_info(event, &prog_id, &type, &name,
>> +                                     &offset, &addr, &missed);
>> +       if (err)
>> +               return;
>> +
>> +       if (type == BPF_FD_TYPE_URETPROBE)
>> +               type = BPF_PERF_EVENT_URETPROBE;
>> +       else
>> +               type = BPF_PERF_EVENT_UPROBE;
> 
> strings, just as above
> 

get it.

>> +
>> +       seq_printf(seq,
>> +                  "name:\t%s\n"
>> +                  "offset:\t%llu\n"
> 
> hex

get it.

> 
>> +                  "event_type:\t%u\n"
>> +                  "cookie:\t%llu\n",
>> +                  name, offset, type, event->bpf_cookie);
>> +
>> +}
>>   #endif
>>
>>   static int bpf_perf_link_fill_probe(const struct perf_event *event,
>> @@ -3888,10 +3945,79 @@ static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
>>          }
>>   }
>>
>> +static void bpf_perf_event_link_show_fdinfo(const struct perf_event *event,
>> +                                           struct seq_file *seq)
>> +{
>> +       seq_printf(seq,
>> +                  "type:\t%u\n"
>> +                  "config:\t%llu\n"
>> +                  "event_type:\t%u\n"
> 
> string?
> 

sure.

>> +                  "cookie:\t%llu\n",
>> +                  event->attr.type, event->attr.config,
>> +                  BPF_PERF_EVENT_EVENT, event->bpf_cookie);
>> +}
>> +
>> +static void bpf_tracepoint_link_show_fdinfo(const struct perf_event *event,
>> +                                           struct seq_file *seq)
>> +{
>> +       int err;
>> +       const char *name;
>> +       u32 prog_id;
>> +
>> +       err = bpf_get_perf_event_info(event, &prog_id, NULL, &name, NULL,
>> +                                     NULL, NULL);
>> +       if (err)
>> +               return;
>> +
>> +       seq_printf(seq,
>> +                  "tp_name:\t%s\n"
>> +                  "event_type:\t%u\n"
> 
> string
> 

get it.

>> +                  "cookie:\t%llu\n",
>> +                  name, BPF_PERF_EVENT_TRACEPOINT, event->bpf_cookie);
>> +}
>> +
>> +static void bpf_probe_link_show_fdinfo(const struct perf_event *event,
>> +                                      struct seq_file *seq)
>> +{
>> +#ifdef CONFIG_KPROBE_EVENTS
>> +       if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
>> +               return bpf_perf_link_fdinfo_kprobe(event, seq);
>> +#endif
>> +
>> +#ifdef CONFIG_UPROBE_EVENTS
>> +       if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
>> +               return bpf_perf_link_fdinfo_uprobe(event, seq);
>> +#endif
>> +}
>> +
>> +static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>> +                                     struct seq_file *seq)
>> +{
>> +       struct bpf_perf_link *perf_link;
>> +       const struct perf_event *event;
>> +
>> +       perf_link = container_of(link, struct bpf_perf_link, link);
>> +       event = perf_get_event(perf_link->perf_file);
>> +       if (IS_ERR(event))
>> +               return;
>> +
>> +       switch (event->prog->type) {
>> +       case BPF_PROG_TYPE_PERF_EVENT:
>> +               return bpf_perf_event_link_show_fdinfo(event, seq);
>> +       case BPF_PROG_TYPE_TRACEPOINT:
>> +               return bpf_tracepoint_link_show_fdinfo(event, seq);
>> +       case BPF_PROG_TYPE_KPROBE:
>> +               return bpf_probe_link_show_fdinfo(event, seq);
>> +       default:
>> +               return;
>> +       }
>> +}
>> +
>>   static const struct bpf_link_ops bpf_perf_link_lops = {
>>          .release = bpf_perf_link_release,
>>          .dealloc = bpf_perf_link_dealloc,
>>          .fill_link_info = bpf_perf_link_fill_link_info,
>> +       .show_fdinfo = bpf_perf_link_show_fdinfo,
>>   };
>>
>>   static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>> --
>> 2.43.0
>>


-- 
Best Regards
Tao Chen

