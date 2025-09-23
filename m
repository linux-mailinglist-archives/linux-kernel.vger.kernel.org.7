Return-Path: <linux-kernel+bounces-828972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4FFB95F3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD57B27E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D9321425;
	Tue, 23 Sep 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wUkB1xKV"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A98324B06
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633001; cv=none; b=IsLjuGGYClM5Kq2o7aOGgNqrB33Fhr19ZO04m+qcln9rbgS9tMyV1GjMfl9QubsiTgaIweqHjfqp7dtrzcfFBMTx/NYsOeiypEMu8YvI6TgOSfI7+UDyLxTNFSeH7Fn0PFTDohUjlZJHGcsr8kYiXFy/KPjIqDihzmIMonQpm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633001; c=relaxed/simple;
	bh=6faPrKhC4NMG6PQdq9dP76Bloco49H2pxLGyjKfV+Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAcvtdUMw7xs/6kyauEekVlpEEbulEtTpEqzspFLwUiqlxDaKakUVGmt0goee9QtITi0Td79KZnti0dRmezE/pB8T1sfBQHMKXP1E8HS7mnffFWZmh/SBJCRK0IpjQmvtT6PvGR7HciTVkAeI3AA1UrigWN3GDDiKAJkQA63nO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wUkB1xKV; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <11ee08fb-a7a9-4b9d-a842-cced1c58ca62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758632996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tapR2V/1AAphhU0r21EryB+FStxCZR4Nu+likupyaP8=;
	b=wUkB1xKVaQPhh8k6SK23+ZCoHfUvbrmAJnUV4N/GY5HQcATpGfiYyrfnNweAoxPciwxOAv
	R0vcpXgrv84arFOqfCkOCO0ljGnSGTYvgmKsVTYuIquYXdd6xtDCM7Pja0fJuM1m2gThbp
	FZGM5olXk+0tGPLh9khPXLU34J7yMe0=
Date: Tue, 23 Sep 2025 21:09:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add stacktrace map
 lookup_and_delete_elem test case
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250922140317.1468691-1-chen.dylane@linux.dev>
 <20250922140317.1468691-2-chen.dylane@linux.dev>
 <CAEf4BzbwkmeiRb5v3TRLxNEywvtn7tynYu850E-sh8Z--hM-dg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4BzbwkmeiRb5v3TRLxNEywvtn7tynYu850E-sh8Z--hM-dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/23 04:58, Andrii Nakryiko 写道:
> On Mon, Sep 22, 2025 at 7:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Add tests for stacktrace map lookup and delete:
>> 1. use bpf_map_lookup_and_delete_elem to lookup and delete the target
>>     stack_id,
>> 2. lookup the deleted stack_id again to double check.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   .../selftests/bpf/prog_tests/stacktrace_map.c | 21 ++++++++++++++++++-
>>   .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>> index 84a7e405e91..d50659fc25e 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
>> @@ -3,7 +3,7 @@
>>
>>   void test_stacktrace_map(void)
>>   {
>> -       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
>> +       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, stack_key_map_fd;
>>          const char *prog_name = "oncpu";
>>          int err, prog_fd, stack_trace_len;
>>          const char *file = "./test_stacktrace_map.bpf.o";
>> @@ -11,6 +11,8 @@ void test_stacktrace_map(void)
>>          struct bpf_program *prog;
>>          struct bpf_object *obj;
>>          struct bpf_link *link;
>> +       __u32 stack_id;
>> +       char val_buf[PERF_MAX_STACK_DEPTH * sizeof(struct bpf_stack_build_id)];
>>
>>          err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
>>          if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
>> @@ -41,6 +43,10 @@ void test_stacktrace_map(void)
>>          if (CHECK_FAIL(stack_amap_fd < 0))
>>                  goto disable_pmu;
>>
>> +       stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
>> +       if (CHECK_FAIL(stack_key_map_fd < 0))
> 
> please don't use CHECK*() macros, they are superseded by more targeted
> ASSERT_xxx() ones
> 

got it, thanks.

> pw-bot: cr
> 
> 
>> +               goto disable_pmu;
>> +
>>          /* give some time for bpf program run */
>>          sleep(1);
>>
>> @@ -68,6 +74,19 @@ void test_stacktrace_map(void)
>>                    "err %d errno %d\n", err, errno))
>>                  goto disable_pmu;
>>
>> +       err = bpf_map_lookup_elem(stack_key_map_fd, &key, &stack_id);
>> +       if (CHECK(err, "stack_key_map lookup", "err %d errno %d\n", err, errno))
>> +               goto disable_pmu;
>> +
>> +       err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id, &val_buf);
>> +       if (CHECK(err, "stackmap lookup and delete",
>> +                 "err %d errno %d\n", err, errno))
>> +               goto disable_pmu;
>> +
>> +       err = bpf_map_lookup_elem(stackmap_fd, &stack_id, &val_buf);
>> +       CHECK((!err || errno != ENOENT), "stackmap lookup deleted stack_id",
>> +             "err %d errno %d\n", err, errno);
> 
> bpf_map_lookup_elem() returns error code directly, no need to use
> errno, just check that err == -ENOENT
> 

ok.

>> +
>>   disable_pmu:
>>          bpf_link__destroy(link);
>>   close_prog:
>> diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
>> index 47568007b66..3bede76c151 100644
>> --- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
>> +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
>> @@ -38,6 +38,13 @@ struct {
>>          __type(value, stack_trace_t);
>>   } stack_amap SEC(".maps");
>>
>> +struct {
>> +       __uint(type, BPF_MAP_TYPE_ARRAY);
>> +       __uint(max_entries, 1);
>> +       __type(key, __u32);
>> +       __type(value, __u32);
>> +} stack_key_map SEC(".maps");
>> +
>>   /* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
>>   struct sched_switch_args {
>>          unsigned long long pad;
>> @@ -64,6 +71,7 @@ int oncpu(struct sched_switch_args *ctx)
>>          /* The size of stackmap and stackid_hmap should be the same */
>>          key = bpf_get_stackid(ctx, &stackmap, 0);
>>          if ((int)key >= 0) {
>> +               bpf_map_update_elem(&stack_key_map, &val, &key, 0);
> 
> ugh... you'd just use a global variable if this test was used through
> skeleton... maybe convert the test to skeleton and get rid of all
> those unnecessary bpf_find_map() calls as well?
> 

Yes, the test case seems too old, i will refactor it with skeleton.
>>                  bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
>>                  stack_p = bpf_map_lookup_elem(&stack_amap, &key);
>>                  if (stack_p)
>> --
>> 2.48.1
>>


-- 
Best Regards
Tao Chen

