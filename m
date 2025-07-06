Return-Path: <linux-kernel+bounces-715774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D4AF7D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 18:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0224A77D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C224C060;
	Thu,  3 Jul 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="snG+Tv8P"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C824A06A
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559596; cv=none; b=PQojCfjowptt9mbJOgGkWKWUPKlm4WEe5mKRME0WJaapfxnGu3zIeQ5PYgbks7kzfqZQ/YYFP6fQoVGsUPOORpgGdkIVoebq+ALyVs95x9g+8qVtyU9lwpN65QnW/RZWFTqTdotN3q980p9oIw73U1zzyhwM7ARYqayDxCQwSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559596; c=relaxed/simple;
	bh=q02bGARieuxgdtpwcecUrsh2UB+xxm0pXzRux2V4+DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWcRT5O4gBf2FP/JUCPVDqzxslcu3kgMF+s5xxYA342/bcb0vcwoZ4XUGwYyU4oUz8MduwjthPDy6BiXSKTquUwBcQoKNZsicjpmbYyBpF8zwxd9PqaQDLcfD4TJDWfBhcezzjoppKd/2NRjH5ddxZFP1tg1hDLuq5FT/JItR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=snG+Tv8P; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9f92515f-6dad-4ff6-884e-e60016e36ae7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751559592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jIy4SHLmWq0/AA6YBqPeQShRVfTHyDh6SEOPcXL8Y68=;
	b=snG+Tv8PocPhxjsk3ia2l4qp6I+1qY55Oa2XAiNezZ2Z/76ZpcMMrKQ1CVXLK9O6NAM3m5
	U52op/SbNoGmWhIwdODWWwacz4JXKwi493fM5qhno8vrT5ZjWC7UIZ90JOJQhNQTHNS4v+
	kb4Fy6AtJ/AFb0cHYlxCsSZvS7DUOAk=
Date: Fri, 4 Jul 2025 00:19:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Clean code with bpf_copy_to_user
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250703124336.672416-1-chen.dylane@linux.dev>
 <b4925bd4-8169-47c2-9cff-5a4023f07a32@linux.dev>
 <9447cc50-03be-4eba-809d-f9e3381654fa@linux.dev>
 <d9c78add-d2e0-4d7c-a5a3-2355417cf9a6@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <d9c78add-d2e0-4d7c-a5a3-2355417cf9a6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/4 00:14, Yonghong Song 写道:
> 
> 
> On 7/3/25 9:03 AM, Tao Chen wrote:
>> 在 2025/7/3 23:35, Yonghong Song 写道:
>>>
>>>
>>> On 7/3/25 5:43 AM, Tao Chen wrote:
>>>> No logic change, just use bpf_copy_to_user to clean code.
>>>>
>>>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>>>> ---
>>>>   kernel/bpf/syscall.c | 17 +++--------------
>>>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index e6eea594f1c..ca152d36312 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -5208,21 +5208,10 @@ static int bpf_task_fd_query_copy(const 
>>>> union bpf_attr *attr,
>>>>               if (put_user(zero, ubuf))
>>>>                   return -EFAULT;
>>>> -        } else if (input_len >= len + 1) {
>>>> -            /* ubuf can hold the string with NULL terminator */
>>>> -            if (copy_to_user(ubuf, buf, len + 1))
>>>> -                return -EFAULT;
>>>>           } else {
>>>> -            /* ubuf cannot hold the string with NULL terminator,
>>>> -             * do a partial copy with NULL terminator.
>>>> -             */
>>>> -            char zero = '\0';
>>>> -
>>>> -            err = -ENOSPC;
>>>> -            if (copy_to_user(ubuf, buf, input_len - 1))
>>>> -                return -EFAULT;
>>>> -            if (put_user(zero, ubuf + input_len - 1))
>>>> -                return -EFAULT;
>>>> +            err = bpf_copy_to_user(ubuf, buf, input_len, len);
>>>> +            if (err)
>>>> +                return err;
>>>>           }
>>>>       }
>>>
>>> Actually, there is a return value change with this patch.
>>> bpf_copy_to_user() return returns -ENOSPC while the original
>>> implementation may return -EFAULT due to following code.
>>>
>>>          if (put_user(prog_id, &uattr->task_fd_query.prog_id) ||
>>>              put_user(fd_type, &uattr->task_fd_query.fd_type) ||
>>>              put_user(probe_offset, &uattr- 
>>> >task_fd_query.probe_offset) ||
>>>              put_user(probe_addr, &uattr->task_fd_query.probe_addr))
>>>                  return -EFAULT;
>>>
>>>          return err;
>>>
>>
>> You are right, maybe we can just use:
>>     err = bpf_copy_to_user(ubuf, buf, input_len, len);
>> and no return check
>> or move these put_user code to the front.
> 
> Maybe do the following?
> 
>     err = bpf_copy_to_user(ubuf, buf, input_len, len);
>     if (err && err != -ENOSPC)
>       return err;
> 

Well, it looks better, i will change it in v2, thanks.

-- 
Best Regards
Tao Chen

