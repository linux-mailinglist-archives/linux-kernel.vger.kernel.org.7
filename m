Return-Path: <linux-kernel+bounces-589907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32353A7CC3A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC0E188857F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Apr 2025 23:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DC1D61B5;
	Sat,  5 Apr 2025 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sW0432Wa"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB91A9B4D
	for <linux-kernel@vger.kernel.org>; Sat,  5 Apr 2025 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743894381; cv=none; b=d5r5BTpuDdJKKW9t47aalK1Hna4y0hjRQG7vSAFBgretrqWdT53uJ1DwMP875U3+lTZcNgO5+/+z8+Uy/n+ENbWKvEspgOJOMdsq8wZOu7JF/wcqbnGdsx2FiRqnonvllktdqKo3TKCLRe+o9f9gHVAeZxLm9zvyw8G8ZqfeQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743894381; c=relaxed/simple;
	bh=0v8cRu38jhoEvajLr3/Yy6r1v7oNO3+xH7Dq99LVUQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A52T8WfVeCpm92pfXobBY56ljdJdmu+ikX4Oguq0vV5s3Vp13WZLmJTaQa5vvCr5jcwyCMtqvoxx/AxV/ze0X0JwVdaYkRKdF5acneqU6XcBh6Wr/7XBJkEyz64xivlVzJpZJ8v/nrfOfMhNxIkq8DlKxYITj54+Uu3pGhTX9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sW0432Wa; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <659945fe-3ed8-4c1c-8d25-99a187bbda8a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743894366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kgau1UgxxQ9YuYZL9yzM9VjfRAvhpGuLePfS/enPJc8=;
	b=sW0432WaOd1QFVFIbDPwJOwUh8EiJtSSPYoseYiv8+KYUZyF0WWi2FB7V2q/sx1Dnw6Efe
	eZtGAhptRbsrtjzXJY/J+tb9vw2twhLWLGbOfN4lZndK9yxLMAEG3H3nneGGLgk6Uyqzs5
	nLsDcJzmd90d2lYABvxaNB/xDza0dzo=
Date: Sun, 6 Apr 2025 07:05:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: Check link_create parameter for
 multi_uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, laoar.shao@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev> <Z-vH_HiJhR3cwLhF@krava>
 <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
 <CAEf4BzbOirQiAmowckX8OeiFUTR8yfkO6m+kY96VMy5f9rG26A@mail.gmail.com>
 <Z-z8_HlpMk39SHUD@krava> <Z-2N0Z6UxVx7mpYp@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z-2N0Z6UxVx7mpYp@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/3 03:19, Jiri Olsa 写道:
> On Wed, Apr 02, 2025 at 11:01:48AM +0200, Jiri Olsa wrote:
>> On Tue, Apr 01, 2025 at 03:06:22PM -0700, Andrii Nakryiko wrote:
>>> On Tue, Apr 1, 2025 at 5:40 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>>>
>>>> 在 2025/4/1 19:03, Jiri Olsa 写道:
>>>>> On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
>>>>>> The target_fd and flags in link_create no used in multi_uprobe
>>>>>> , return -EINVAL if they assigned, keep it same as other link
>>>>>> attach apis.
>>>>>>
>>>>>> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
>>>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>>>> ---
>>>>>>    kernel/trace/bpf_trace.c | 3 +++
>>>>>>    1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>>>>> index 2f206a2a2..f7ebf17e3 100644
>>>>>> --- a/kernel/trace/bpf_trace.c
>>>>>> +++ b/kernel/trace/bpf_trace.c
>>>>>> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>>>>>       if (sizeof(u64) != sizeof(void *))
>>>>>>               return -EOPNOTSUPP;
>>>>>>
>>>>>> +    if (attr->link_create.target_fd || attr->link_create.flags)
>>>>>> +            return -EINVAL;
>>>>>
>>>>> I think the CI is failing because usdt code does uprobe multi detection
>>>>> with target_fd = -1 and it fails and perf-uprobe fallback will fail on
>>>>> not having enough file descriptors
>>>>>
>>>>
>>>> Hi jiri
>>>>
>>>> As you said, i found it, thanks.
>>>>
>>>> static int probe_uprobe_multi_link(int token_fd)
>>>> {
>>>>           LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
>>>>                   .expected_attach_type = BPF_TRACE_UPROBE_MULTI,
>>>>                   .token_fd = token_fd,
>>>>                   .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
>>>>           );
>>>>           LIBBPF_OPTS(bpf_link_create_opts, link_opts);
>>>>           struct bpf_insn insns[] = {
>>>>                   BPF_MOV64_IMM(BPF_REG_0, 0),
>>>>                   BPF_EXIT_INSN(),
>>>>           };
>>>>           int prog_fd, link_fd, err;
>>>>           unsigned long offset = 0;
>>>>
>>>>           prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
>>>>                                   insns, ARRAY_SIZE(insns), &load_opts);
>>>>           if (prog_fd < 0)
>>>>                   return -errno;
>>>>
>>>>           /* Creating uprobe in '/' binary should fail with -EBADF. */
>>>>           link_opts.uprobe_multi.path = "/";
>>>>           link_opts.uprobe_multi.offsets = &offset;
>>>>           link_opts.uprobe_multi.cnt = 1;
>>>>
>>>>           link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI,
>>>> &link_opts);
>>>>
>>>>> but I think at this stage we will brake some user apps by introducing
>>>>> this check, link ebpf go library, which passes 0
>>>>>
>>>>
>>>> So is it ok just check the flags?
>>>
>>> good catch, Jiri! Yep, let's validate just flags?
>>
>> I think so.. I'll test that with ebpf/go to make sure we are safe
>> at least there ;-) I'll let you know
> 
> sorry, got stuck.. link_create.flags are initialized to zero,
> so I think flags check should be fine (at least for ebpf/go)

Thank you very much for your detailed check. I will send it v2.

> 
> jirka


-- 
Best Regards
Tao Chen

