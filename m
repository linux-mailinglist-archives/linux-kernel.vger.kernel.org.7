Return-Path: <linux-kernel+bounces-855492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 585C6BE16B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131305414F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026CE213E9F;
	Thu, 16 Oct 2025 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pvVkZIX8"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE971F131A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760588340; cv=none; b=CuXqWX11YMNP5FWekExQDHHCQkH4e11nth6w30WwRTTp6ipf/s15QsG0JNmbET7Nhrp4Nvf9hsvZunwJykuIvl0mBE9d0N7qFOCSrPlgJFftKA8K/gqVCCeBaC0DmxarSfuJT9awWGvW9J9cR3qjVhpWT6WzeKt6DA9q3U5hXSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760588340; c=relaxed/simple;
	bh=iWyh5tgjEeMnhxeipX44mO0VXx2Xk41sBqaFgRoaWyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOwjea18q2DLIVPcVFXmpuYT/AiZ7U90q3H/UxVhnZ4qksV242S73fwdqEzY/xBErYWeiIpT+GBqyE6pRtUhwJ2MR6yMSHnFv3JmjvXCTZLImkSVT0Yq2dql6RYg+fqDRsSHVIEYPYJ7WlTriJQYdRxaljKXMFGd4rNmyhjSXZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pvVkZIX8; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <987ef44e-55ef-4e6c-92e8-daaf005701b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760588335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j74IkFY/9p07YTv56+MgM3TYZlLX13fwYDRNS0UGDp4=;
	b=pvVkZIX83jiJ/l+3B/CwdBQUhQL29T6Aj19njZ+XX6q1LWoomT7wZsh5h1ncbJVRXdf4vr
	gjEhpT8HhNyc47WmdOIbHNdqLpCbpbnhoMkVsax9ENfy7QAqeeLTOp0dsGdFxAPjfwPVBX
	yv6tpCQoAyeGEWWTPOZGCcRpcgwqZPQ=
Date: Wed, 15 Oct 2025 21:18:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
Content-Language: en-GB
To: Song Liu <song@kernel.org>, JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, andrii@kernel.org, ast@kernel.org,
 mkoutny@suse.com, yosryahmed@google.com, hannes@cmpxchg.org, tj@kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-2-inwardvessel@gmail.com>
 <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAHzjS_s3L7f=Rgux_Y3NQ7tz+Jmec5T8hLyQCxseLJ9-T-9xuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/15/25 4:12 PM, Song Liu wrote:
> On Wed, Oct 15, 2025 at 12:08 PM JP Kobryn <inwardvessel@gmail.com> wrote:
> [...]
>> ---
>>   mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 4deda33625f4..6547c27d4430 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>>   }
>>   #endif
>>
>> +static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
>> +{
>> +       return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
>> +}
>> +
> We should add __bpf_kfunc_start_defs() here, and __bpf_kfunc_end_defs()
> after all the kfuncs.
>
>> +__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
> We mostly do not make kfunc static, but it seems to also work.

Let us remove 'static' in __bpf_kfunc functions in order to be consistent
with other existing kfuncs.


The __bpf_kfunc macro is
    linux/btf.h:#define __bpf_kfunc __used __retain __noclone noinline

__used and __retain attributes ensure the function won't be removed
by compiler/linker.

>
>> +{
>> +       struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
>> +
>> +       if (!memcg)
>> +               return;
> Maybe we can let memcg_flush_stats return int, and return -EINVAL
> on memcg == NULL cases?
>
>> +
>> +       mem_cgroup_flush_stats(memcg);
>> +}
>> +
> [...]
>


