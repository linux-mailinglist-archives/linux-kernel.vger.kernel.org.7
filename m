Return-Path: <linux-kernel+bounces-583459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE619A77B26
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0DC16ACB0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143E201249;
	Tue,  1 Apr 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fchy4Nkx"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4301F0E56
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511240; cv=none; b=nPCrul5h/RSDkHc04ZPH4GF8lIR39MtkqdIoF+OrQUFn682YYlmROSeMmdGcfGIbR+dlX6Ctr37VXGZW6CgCeKYKLa/2jfl6sy67PmPsrqD+KyAlv1taIS44OjPyH8JJIh+8ILqmVul/Iy7cPqaV73HO4DcRCYWvE0lBbkSUTVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511240; c=relaxed/simple;
	bh=f7HZvkkUjREv5E0SrXmMOMtofQNQWMeSVV+VWTUHkYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB8lAoJATFQmEkxgfNAJEPOSFqqdwTP052uzMm5Vnv+97QfO+vPTuwDXZOVTeI4IyWJjd3Oq6TrXpp6sNHN0xWWF5Tu0hqCgcxZAy1GCzbg8GEIt3DH2I5pl++MdJLoQ214Jl4uWLnUlZb3uYO6aGNTuxgKk4GPtLv44Imwe4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fchy4Nkx; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <918395a6-122c-4fb0-9761-892b8020b95e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743511227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxXB0v/fRE15xa1xwGjpmAOOzPKuIdD5kdimGTGzH+g=;
	b=Fchy4Nkx5sjdVRFqStHp/4fJ9CvOVIz1lWoNOxriM4dNDNYiQYgPPLqB4J+DachbihZSdO
	eaUmeVwvGSLSb4xO3JB5SyCiJ1OUWFG8rkVq82L8O7/7B/Elj9RKyF3b1Xa+rNbNkxOWoe
	pBzoFSWxh+/rKTKTk49yTQwX22+c4hc=
Date: Tue, 1 Apr 2025 20:40:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpf: Check link_create parameter for
 multi_uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: song@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, laoar.shao@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250331094745.336010-1-chen.dylane@linux.dev>
 <20250331094745.336010-2-chen.dylane@linux.dev> <Z-vH_HiJhR3cwLhF@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <Z-vH_HiJhR3cwLhF@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/1 19:03, Jiri Olsa 写道:
> On Mon, Mar 31, 2025 at 05:47:45PM +0800, Tao Chen wrote:
>> The target_fd and flags in link_create no used in multi_uprobe
>> , return -EINVAL if they assigned, keep it same as other link
>> attach apis.
>>
>> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   kernel/trace/bpf_trace.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 2f206a2a2..f7ebf17e3 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3385,6 +3385,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>>   	if (sizeof(u64) != sizeof(void *))
>>   		return -EOPNOTSUPP;
>>   
>> +	if (attr->link_create.target_fd || attr->link_create.flags)
>> +		return -EINVAL;
> 
> I think the CI is failing because usdt code does uprobe multi detection
> with target_fd = -1 and it fails and perf-uprobe fallback will fail on
> not having enough file descriptors
> 

Hi jiri

As you said, i found it, thanks.

static int probe_uprobe_multi_link(int token_fd)
{
         LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
                 .expected_attach_type = BPF_TRACE_UPROBE_MULTI,
                 .token_fd = token_fd,
                 .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
         );
         LIBBPF_OPTS(bpf_link_create_opts, link_opts);
         struct bpf_insn insns[] = {
                 BPF_MOV64_IMM(BPF_REG_0, 0),
                 BPF_EXIT_INSN(),
         };
         int prog_fd, link_fd, err;
         unsigned long offset = 0;

         prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
                                 insns, ARRAY_SIZE(insns), &load_opts);
         if (prog_fd < 0)
                 return -errno;

         /* Creating uprobe in '/' binary should fail with -EBADF. */
         link_opts.uprobe_multi.path = "/";
         link_opts.uprobe_multi.offsets = &offset;
         link_opts.uprobe_multi.cnt = 1;

         link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_UPROBE_MULTI, 
&link_opts);

> but I think at this stage we will brake some user apps by introducing
> this check, link ebpf go library, which passes 0
> 

So is it ok just check the flags?

> jirka
> 
> 
>> +
>>   	if (!is_uprobe_multi(prog))
>>   		return -EINVAL;
>>   
>> -- 
>> 2.43.0
>>


-- 
Best Regards
Tao Chen

