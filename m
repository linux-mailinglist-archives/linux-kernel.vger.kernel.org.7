Return-Path: <linux-kernel+bounces-860636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161ABF0909
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51A734F29B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488CC2F6929;
	Mon, 20 Oct 2025 10:34:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B31E2F6906
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956493; cv=none; b=cHWrhNCBCvrWet6yv73J9vd3lAOs60/qT6DDEJ/+zzD5T4uW2AcPAhwxjv4X/OYVCa1MYIP3rjkkijPtjbuZhlV1h91VCowmagupXMwYzAjt7w0abq2gZjQNJgAEDhN6yNnhXHtGbBlRCB4+FfqZNK0BVGau1gkxItsLrsAy3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956493; c=relaxed/simple;
	bh=OSpkohzgE+qUHMLKqrL2b8TAwWc0e3Xq99CapyzCujk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cS4r4k8L1DS+tHifDYhEQFtycZO59ed27CGZqmqA/Wagu1gCH64aWbeayup1JytGWR4HcZQVPrDCqTbBfpdJuG6DC4WKCZnPCJLe+Ahlkolib8+AI02lZTaaHYXKFzGbcZOpBw8ShOZOHb5AgeMLXs+JY3RIBB/dvJUGrDlMxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28D61063;
	Mon, 20 Oct 2025 03:34:43 -0700 (PDT)
Received: from [10.57.65.147] (unknown [10.57.65.147])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256FA3F63F;
	Mon, 20 Oct 2025 03:34:48 -0700 (PDT)
Message-ID: <75a8f465-f831-4bf9-a48f-94c05470e900@arm.com>
Date: Mon, 20 Oct 2025 12:34:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Remove unused variable in mm_cid_get()
To: Christian Loehle <christian.loehle@arm.com>,
 linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
References: <20251017073050.2411988-1-kevin.brodsky@arm.com>
 <d76040f3-40d2-4cc3-bf59-cdd9f6673ad2@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <d76040f3-40d2-4cc3-bf59-cdd9f6673ad2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 12:16, Christian Loehle wrote:
> On 10/17/25 08:30, Kevin Brodsky wrote:
>> The cpumask variable in mm_cid_get() has never been used, remove it.
>>
>> This fixes a -Wunused-but-set-variable warning when building with
>> W=1.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> ---
>>  kernel/sched/sched.h | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 1f5d07067f60..361f9101cef9 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3740,11 +3740,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
>>  			     struct mm_struct *mm)
>>  {
>>  	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
>> -	struct cpumask *cpumask;
>>  	int cid;
>>  
>>  	lockdep_assert_rq_held(rq);
>> -	cpumask = mm_cidmask(mm);
>>  	cid = __this_cpu_read(pcpu_cid->cid);
>>  	if (mm_cid_is_valid(cid)) {
>>  		mm_cid_snapshot_time(rq, mm);
>>
>> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> Andy also posted this:
> https://lore.kernel.org/lkml/20251015091935.2977229-1-andriy.shevchenko@linux.intel.com/

Ah I missed it, thanks! Please ignore my patch then (especially since it
misses a Fixes: tag).

- Kevin

