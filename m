Return-Path: <linux-kernel+bounces-672016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F25ACC9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 17:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2EE07A8550
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB023C503;
	Tue,  3 Jun 2025 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WnbNpVT1"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDC23A9AD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963252; cv=none; b=T57N71QDcMqJ/Mkhf0pTExg6LDNy1+LtJXST/r1BiQIxassJYp55D4/g6PrUklwORsYP3Ng5c/bF0jcsgGrBaeNSW2gAoxzKeZ+2iE6CRvHOC5a1J06nx0r3ENeAFGCiM3EeqNlChY9sfFBdnYGr7ZIHcjNNnuJM8YUwd0DKOqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963252; c=relaxed/simple;
	bh=RRUIgBZA7/RZuCTepb8TfhL+tkUhWcimMhe1FoMS5Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ9Q9L57yQpvQBgK/XAPikYXvP3r44FELcOveYZ/aFyVuNI9rFLsHWLhRB+sUCz8witTKOe/zmlTAg1vrsDksDPy6hgUrZtLQbnVxY6ufMQTAMC/NMEymJuuoXKrRRDOA+IPhGIpOueeUUst7cwHftCIV4at0g43oT5JfdbqWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WnbNpVT1; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <029e657a-cbf5-4db1-9ddb-5fbf75ea8f4e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748963236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/S8RT0q+1oRhcL15WhoKhfpGElrxWknt11mPVDpvpM=;
	b=WnbNpVT1Sydsz6sSCFK8n9wJMC4R0fge4PL9E1PGhGFHbo/rMlIy11Aj7TyISgwm6Bifm8
	6HfqOTUd38BaDNZ8nOWjK3JFU5H6N0XNp7ci9md+59/Kc6QopugCH5ZBZ0fF9XxP2gp98l
	c+e4s6HA+Ntv9pGntr2IWEKllpTv0Is=
Date: Tue, 3 Jun 2025 23:07:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add cookie to raw_tp bpf_link_info
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, qmo@kernel.org, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250603022610.3005963-1-chen.dylane@linux.dev>
 <48e85d82-e5c7-463a-aef3-f1ecbe863524@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <48e85d82-e5c7-463a-aef3-f1ecbe863524@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/3 22:52, Yonghong Song 写道:
> 
> 
> On 6/2/25 7:26 PM, Tao Chen wrote:
>> After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
>> (raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
>> like kprobe etc.
>>
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   include/uapi/linux/bpf.h       | 2 ++
>>   kernel/bpf/syscall.c           | 1 +
>>   tools/include/uapi/linux/bpf.h | 2 ++
>>   3 files changed, 5 insertions(+)
>>
>> Change list:
>> - v1 -> v2:
>>      - fill the hole in bpf_link_info.(Jiri)
>> - v1:
>>      https://lore.kernel.org/bpf/20250529165759.2536245-1- 
>> chen.dylane@linux.dev
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 07ee73cdf9..f3e2aae302 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>>           struct {
>>               __aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>>               __u32 tp_name_len;     /* in/out: tp_name buffer len */
>> +            __u32 reserved; /* just fill the hole */
> 
> See various examples in uapi/linux/bpf.h, '__u32 :32;' is the preferred
> apporach to fill the hole.

Well, it looks better, will change it in v3, thanks.

> 
>> +            __u64 cookie;
>>           } raw_tracepoint;
>>           struct {
>>               __u32 attach_type;
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index 9794446bc8..1c3dbe44ac 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3687,6 +3687,7 @@ static int bpf_raw_tp_link_fill_link_info(const 
>> struct bpf_link *link,
>>           return -EINVAL;
>>       info->raw_tracepoint.tp_name_len = tp_len + 1;
>> +    info->raw_tracepoint.cookie = raw_tp_link->cookie;
>>       if (!ubuf)
>>           return 0;
>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/ 
>> linux/bpf.h
>> index 07ee73cdf9..f3e2aae302 100644
>> --- a/tools/include/uapi/linux/bpf.h
>> +++ b/tools/include/uapi/linux/bpf.h
>> @@ -6644,6 +6644,8 @@ struct bpf_link_info {
>>           struct {
>>               __aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
>>               __u32 tp_name_len;     /* in/out: tp_name buffer len */
>> +            __u32 reserved; /* just fill the hole */
>> +            __u64 cookie;
>>           } raw_tracepoint;
>>           struct {
>>               __u32 attach_type;
> 


-- 
Best Regards
Tao Chen

