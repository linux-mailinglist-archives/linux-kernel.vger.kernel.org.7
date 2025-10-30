Return-Path: <linux-kernel+bounces-878439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B96C2099B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F761A22D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2369E272803;
	Thu, 30 Oct 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TE2P2+uV"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7620C26C3BD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834617; cv=none; b=n817s6u28rV+KUntUsy8Hvzl2LLXr0enkPd1F0QIOrn0ZP9lp/h7CbWnHhQhbGts9WtQtMesfs/Z34oNxgxHuoALHUqv0QCg5m+jKI9HuLMQ81VRzJmUMoFmwBnQE6Y9ZY+WhMsBKDbUuaujjMSut0QJBP9qMGjsqPw1eoyUxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834617; c=relaxed/simple;
	bh=Exy7QyU1oeByTEpDwoCCXCl4P8vmuSXO+nlH7c8iTSY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hsQqh9Y6vYJpRVKJx/N3vyyHJ0dPV87AAtHOuih4K8rUz5d1hJPFqtPcIpLfngFxebN03mggnZrb+BlQSP5afLRFGmkpXFv8djflwLi+qARp3HjsxnUzQMQ3sv6khglPYvvSeF5VDvPmLUz67pJ77APD1lQer2bvi1FuFI3eO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TE2P2+uV; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca00af4c-39bd-455c-889e-044fcf9cf09f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761834613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYiXMuswR1+jgLjGoqjnHkFPcb2vIu0Q7bxZbMV3VUc=;
	b=TE2P2+uVGQB+GtTNh1Af5qAqnZ30YTbmg4L1+QZMmgjHcT7hy7bVY0d6kRank3Y6KSpEvZ
	PlqBwxBhMsFlYZNjhMT6laI9E9MK0eaYfk8+D1DVtyMIQfZMqyLUCxvisZlVYBPlIqpudm
	DSmlAwsLk/r/m/RywdvxixuuNPWky8Q=
Date: Thu, 30 Oct 2025 22:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Add tests to verify freeing the
 special fields when update hash and local storage maps
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251026154000.34151-1-leon.hwang@linux.dev>
 <20251026154000.34151-5-leon.hwang@linux.dev>
 <CAMB2axN6bsrMH6_qVz9eHY1HLp6SQmM-nOUEXUOOiibZFMzXMw@mail.gmail.com>
 <a798d47e-4ab8-423a-b8ef-e42ff9760324@linux.dev>
Content-Language: en-US
In-Reply-To: <a798d47e-4ab8-423a-b8ef-e42ff9760324@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/29 22:58, Leon Hwang wrote:
> 
> 
> On 2025/10/28 00:34, Amery Hung wrote:
>> On Sun, Oct 26, 2025 at 8:42 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>
>>> Add tests to verify that updating hash and local storage maps decrements
>>> refcount when BPF_KPTR_REF objects are involved.
>>>
>>> The tests perform the following steps:
>>>
>>> 1. Call update_elem() to insert an initial value.
>>> 2. Use bpf_refcount_acquire() to increment the refcount.
>>> 3. Store the node pointer in the map value.
>>> 4. Add the node to a linked list.
>>> 5. Probe-read the refcount and verify it is *2*.
>>> 6. Call update_elem() again to trigger refcount decrement.
>>> 7. Probe-read the refcount and verify it is *1*.
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>  .../bpf/prog_tests/refcounted_kptr.c          | 178 +++++++++++++++++-
>>>  .../selftests/bpf/progs/refcounted_kptr.c     | 160 ++++++++++++++++
>>>  2 files changed, 337 insertions(+), 1 deletion(-)
>>>
> 
> [...]
> 
>>> @@ -44,3 +44,179 @@ void test_refcounted_kptr_wrong_owner(void)
>>>         ASSERT_OK(opts.retval, "rbtree_wrong_owner_remove_fail_a2 retval");
>>>         refcounted_kptr__destroy(skel);
>>>  }
>>> +
>>> +static void test_refcnt_leak(void *values, size_t values_sz, u64 flags, struct bpf_map *map,
>>> +                            struct bpf_program *prog_leak, struct bpf_program *prog_check)
>>> +{
> 
> [...]
> 
>>> +}
>>
>> Just use syscall BPF programs across different subtests, and you can
>> share this test_refcnt_leak() across subtests.
>>
>> It also saves you some code setting up bpf_test_run_opts. You can just
>> call bpf_prog_test_run_opts(prog_fd, NULL) as you don't pass any input
>> from ctx.
>>
>>> +
>>> +static void test_percpu_hash_refcount_leak(void)
>>> +{
> 
> [...]
> 
>>> +out:
>>> +       close(cgroup);
>>> +       refcounted_kptr__destroy(skel);
>>> +       if (client_fd >= 0)
>>> +               close(client_fd);
>>> +       if (server_fd >= 0)
>>> +               close(server_fd);
>>> +}
>>
>> Then, you won't need to set up server, connection.... just to
>> read/write cgroup local storage. Just call test_refcnt_leak() that
>> runs the two BPF syscall programs for cgroup local storage.
>>
> 
> [...]
> 
>>
>>
>> And in syscall BPF program, you can simply get the cgroup through the
>> current task
>>
>> SEC("syscall")
>> int syscall_prog(void *ctx)
>> {
>>         struct task_struct *task = bpf_get_current_task_btf();
>>
>>         v = bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0,
>>                                BPF_LOCAL_STORAGE_GET_F_CREATE);
>>         ...
>> }
>>
> 
> Hi Amery,
> 
> Thanks for the suggestion.
> 
> I tried your approach, but the verifier rejected it with the following
> error:
> 
> 0: R1=ctx() R10=fp0
> ; task = bpf_get_current_task_btf(); @ refcounted_kptr.c:686
> 0: (85) call bpf_get_current_task_btf#158     ; R0=trusted_ptr_task_struct()
> ; v = bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0, @
> refcounted_kptr.c:687
> 1: (79) r1 = *(u64 *)(r0 +4856)       ; R0=trusted_ptr_task_struct()
> R1=untrusted_ptr_css_set()
> 2: (79) r2 = *(u64 *)(r1 +96)         ; R1=untrusted_ptr_css_set()
> R2=untrusted_ptr_cgroup()
> 3: (18) r1 = 0xffffa1b442a4b800       ; R1=map_ptr(map=cgrp_strg,ks=4,vs=16)
> 5: (b7) r3 = 0                        ; R3=0
> 6: (b7) r4 = 1                        ; R4=1
> 7: (85) call bpf_cgrp_storage_get#210
> R2 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
> processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
> peak_states 0 mark_read 0
> 

After analyzing the verifier log (with a bit of AI help), it turned out
that 'task->cgroups->dfl_cgrp' wasn't protected by an RCU read lock.
According to verifier.c::btf_ld_kptr_type(), this pointer must be
accessed either within an RCU critical section or in a non-sleepable
program.

Adding RCU protection fixed the issue:

    bpf_rcu_read_lock()
    v = bpf_cgrp_storage_get(&cgrp_strg, task->cgroups->dfl_cgrp, 0,
                             BPF_LOCAL_STORAGE_GET_F_CREATE);
    bpf_rcu_read_unlock()

With this change, test_refcnt_leak() can now be used across all subtests.

Thanks again for the helpful suggestion.

Thanks,
Leon


