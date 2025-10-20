Return-Path: <linux-kernel+bounces-861678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE61BF3531
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5665418C067F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3252D5C97;
	Mon, 20 Oct 2025 20:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL1/GB9I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55042A9D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760990835; cv=none; b=O8TsHoHAoZ+DvQSGgQPJpyH+nXsswZ24lrNbKD1XDmS7B5WAwoi0efZxwrI8XyHLwV2gIuFPG0XMkG0HIH87t1YxmsDk+3LEo+wIdUxvQ9ntic5u/ZgEU3AixO2PKabIHn03gIrB/ShGuLz4hdM6SAdch5WHHvEnWVk63K1QVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760990835; c=relaxed/simple;
	bh=TepVpHg8AVpSrg+5W+IoBXQqQu1WmaltNqJVHkqahjw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QL44E8JfUShHjjaFQeXEfjK5NxloqIBnp49ul6J5vwy/RuOOqAOUhxbFnb1C710ksWYWUWUMTVW16cEq9zdCb646LCnZrJ7tZdbthiXujQrxvXQ14SmhFPYfz599h+dipaP6XiyB0ajGz2ozJ28gpijrh9AKRfvmAWEqMTDi178=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL1/GB9I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760990832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKh7G80lkv2sTBwVQW8NOrlVTbOZbgJeWVR4B2ZVux0=;
	b=AL1/GB9IT5RuH8NL7fNvby3mH6ehTa8EKulEEnOyKIkURf0/ZPHVY8u2B0OW35Xa/9nqkY
	dSXPQ/hsWfUGNZCE0rMVAxDorydPWuG8Gl9W8xPEzm/oN/5fspCwXr99G//GXgJkKOZir7
	JQ/v54hwqS+ihmAfsEIPkJuUzaKJvtk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-UcgF6J0DP-SeadZDxJo9Zw-1; Mon, 20 Oct 2025 16:07:01 -0400
X-MC-Unique: UcgF6J0DP-SeadZDxJo9Zw-1
X-Mimecast-MFC-AGG-ID: UcgF6J0DP-SeadZDxJo9Zw_1760990821
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-798920399a6so5912162b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:07:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760990821; x=1761595621;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKh7G80lkv2sTBwVQW8NOrlVTbOZbgJeWVR4B2ZVux0=;
        b=YhNEryQWzSYv5RgrSjw1gBe26AdIkrWpxAlIjYGvOUkx9XtkAEkMQbibfImAgRn1ck
         cvcrRbUczusGLUt3TCFgeFqPhHPOsnIXSYJQ46SUHld2fIdpe+UMvRXzhi5TkPblNyRW
         DCxkQtOHwTll9HzRyhr1swMTGRqAAt6wMwkSU/dBfIs1z2WQo3kJ/dV5cL7B32wWkYRM
         FZRofu4gRNsZp7JUzp2F9ifpV9T+5e0S093XbkP1J17fUuIRcPTN2NK+9oIA4tgTMdTs
         blaiJXz3pyYGw1G3/JRcxGipjVCMp7xraUcc/FkdSCAC+hAvvZzUeCwLFKHVGyRFjxqP
         bFZQ==
X-Gm-Message-State: AOJu0YwnodxsRNjGksl6SNk545xLR2Fp/vUSR9r+5UBx9TICJ2WfLRLC
	pMUOHYSxbCc/SgbcNe3a6zIBMSAStG6QMTmPcRrS2K1gM1ohqY62kkQiq/oNFwosFaboAmxLBNx
	jNGIDNnO5vyfalYihhPkXQQyah7B/7Z8Qi857sXVOJFWOUsVfy7vPeuDHVYM/clFFnA==
X-Gm-Gg: ASbGncuLzrFtRayCjbe6pgevZJPps+Kbtu/cs5CWolTwKalZg0AEgRwvACoKot2OWgl
	Tro8dVxgGLX20LOsbxSEuIHAs5qQNnclxLTrSOCgnM3fa3y3HEB60FoPTYqX9XDltbhwmXyKdrZ
	vb7u+11yFCOkCAXPLW2427ST+v37Cea4AjMI6AgoA2iHfTsNuzn/+LdIxIkrbOBOht3mxQwB2nK
	gm1EIYKM5iD0Y9UhjiokiHbOxCm7sulvmDBDTkfhiFR2I02PtjCSKBJspM5AEVbVgdImT7AtP8u
	+CrB7Oqq6BzHMLtIQ4+AdVs3dZFFESeG9Pviag80EbcTsYpLECwzbOvgOB04dh14na5HFlrlDGj
	SuHZ9aN5OurbSmw+Lc2ByOUSNmhMV+WIWqZ5qYPhW3+/RrA==
X-Received: by 2002:a05:6a20:2443:b0:334:92ac:602e with SMTP id adf61e73a8af0-334a7a5ff7dmr20340278637.30.1760990820900;
        Mon, 20 Oct 2025 13:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELfTrmFc6qObTq7RgTaOXi9eaIyZMYW7lgC66KaADWOu31BdOjK1L/BD4LajKA4fu+SbfJTg==
X-Received: by 2002:a05:6a20:2443:b0:334:92ac:602e with SMTP id adf61e73a8af0-334a7a5ff7dmr20340236637.30.1760990820374;
        Mon, 20 Oct 2025 13:07:00 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff39442sm9136114b3a.20.2025.10.20.13.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 13:06:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9160740c-a56f-4fb0-bda7-bbdaa04f1d3d@redhat.com>
Date: Mon, 20 Oct 2025 16:06:58 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/core: Enable full cpumask to clear user cpumask
 in sched_setaffinity()
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Nico Pache <npache@redhat.com>,
 Phil Auld <pauld@redhat.com>, John Coleman <jocolema@redhat.com>
References: <20250923175447.116782-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250923175447.116782-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/25 1:54 PM, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset.
> However, that affinity is also being inherited by any subsequently
> created child processes which may not want or be aware of that affinity.
>
> One way to solve this problem is to provide a way to back off from
> that user provided CPU affinity.  This patch implements such a scheme
> by using a full cpumask (a cpumask with all bits set) to signal the
> clearing of the user cpumask to follow the default as allowed by
> the current cpuset.  In fact, with a full cpumask in user_cpus_ptr,
> the task behavior should be the same as with a NULL user_cpus_ptr.
> This patch just formalizes it without causing any incompatibility and
> discard an otherwise useless cpumask.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/sched/syscalls.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 77ae87f36e84..d68c7a4ee525 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1229,14 +1229,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>   		return retval;
>   
>   	/*
> -	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
> -	 * alloc_user_cpus_ptr() returns NULL.
> +	 * If a full cpumask is passed in, clear user_cpus_ptr and reset the
> +	 * current cpu affinity to the default for the current cpuset.
>   	 */
> -	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> -	if (user_mask) {
> -		cpumask_copy(user_mask, in_mask);
> +	if (cpumask_full(in_mask)) {
> +		user_mask = NULL;
>   	} else {
> -		return -ENOMEM;
> +		/*
> +		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
> +		 * alloc_user_cpus_ptr() returns NULL.
> +		 */
> +		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> +		if (user_mask) {
> +			cpumask_copy(user_mask, in_mask);
> +		} else {
> +			return -ENOMEM;
> +		}
>   	}
>   
>   	ac = (struct affinity_context){

Any comment or suggested improvement on this patch and the following one?

Thanks,
Longman


