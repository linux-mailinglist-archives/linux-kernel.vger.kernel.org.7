Return-Path: <linux-kernel+bounces-823309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1294EB8616E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E872486202
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AD23D7F2;
	Thu, 18 Sep 2025 16:46:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F37464
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213968; cv=none; b=ej8HSlUcl0avvT8g7PNgJaObzVanvIHTxL2pK/vnblY/P1fapoJ8FCeOrSvHbVRLZ7oLCtv0vsl0g7aYFVObYBcL58FWxwEUJH8P68gHpm8QnQUxcOIVsFUssvl154jLfYM94tyR1T8rgw+FLWpb1mAC2ndb1MU0/0lMisCYAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213968; c=relaxed/simple;
	bh=M7hqFCFJi4BA1MHZbyJkv+OfcRZBHs2FT1B2eRcTQtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aN07i3xV/O9rk5TUj0fCHDPASGr39QHPdQHVauj3OMfA/VyaqoLb/38jc3MBKjibCSRfwYrvIvS0Rmyxni3j2XQLDD1VMm01iQUZhbrgFBvJZptaHLT/STkADO2c6mpKFaV44jPAG/tqo44dpaFxtaLNA8ciJA16zFtbPG3XG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B8AA176C;
	Thu, 18 Sep 2025 09:45:56 -0700 (PDT)
Received: from [10.1.32.55] (e127648.arm.com [10.1.32.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AE5C3F673;
	Thu, 18 Sep 2025 09:46:03 -0700 (PDT)
Message-ID: <65fa569f-befc-48cf-b89e-5ef3ee8541de@arm.com>
Date: Thu, 18 Sep 2025 17:46:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Acquire task reference in
 scx_bpf_cpu_curr()
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250909195709.92669-1-arighi@nvidia.com>
 <aMCHjFwwjqvKsZBg@slm.duckdns.org> <aMCRzXgDv6PGqLwp@gpd4>
 <16b9e714-e6f8-49e5-a885-3c9e85f873b7@arm.com> <aMwuFX4glQ0YZGb0@gpd4>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aMwuFX4glQ0YZGb0@gpd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 17:06, Andrea Righi wrote:
> Hi Christian,
> 
> On Thu, Sep 18, 2025 at 04:48:14PM +0100, Christian Loehle wrote:
>> On 9/9/25 21:45, Andrea Righi wrote:
>>> Hi Tejun,
>>>
>>> On Tue, Sep 09, 2025 at 10:01:16AM -1000, Tejun Heo wrote:
>>>> Hello, Andrea.
>>>>
>>>> On Tue, Sep 09, 2025 at 09:57:09PM +0200, Andrea Righi wrote:
>>>>> scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
>>>>> given runqueue, allowing schedulers to interact with that task.
>>>>>
>>>>> The kfunc assumes that it is always called in an RCU context, but this
>>>>> is not always guaranteed and some BPF schedulers can trigger the
>>>>> following warning:
>>>>>
>>>>>   WARNING: suspicious RCU usage
>>>>>   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
>>>>>   6.17.0-rc1 #1-NixOS Not tainted
>>>>>   -----------------------------
>>>>>   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
>>>>>
>>>>> The correct behavior is to acquire a reference to the returned task, so
>>>>> the scheduler can safely access it and then release it with
>>>>> bpf_task_release().
>>>>>
>>>>> Update the kfunc and the corresponding compatibility helper to implement
>>>>> reference acquisition and prevent potential RCU warnings.
>>>>
>>>> I think KF_RCU likely fits better for peeking kernel data structures than
>>>> having to acquire/release them. Can you post the full backtrace? Is it being
>>>> called from a sleepable bpf prog? Or is it that we just need to expand the
>>>> rcu check scope to cover regular rcu, bh and sched? And, everything aside,
>>>> if KF_RCU, should we be tripping on rcu_dereference() in the first place?
>>>
>>> For the records, as discussed offline, we should be fine marking the kfunc
>>> as KF_RCU_PROTECTED instead of acquiring the reference to the task.
>>>
>>> Right now the kfunc is marked as KF_RCU, which is not really necessary,
>>> because KF_RCU ensures the kfunc *arguments* are either RCU-protected or
>>> trusted.
>>>
>>> KF_RCU_PROTECTED, instead, should ensure that the kfunc is called inside an
>>> RCU read-side critical section, that is what we need.
>>>
>>> In this way the kfunc can safely return a pointer to the task and sleepable
>>> BPF programs can wrap the call in a bpf_rcu_read_lock/unlock() section.
>>> This should prevent the RCU warning while still letting schedulers safely
>>> use the returned task.
>>>
>>> I'll send a new patch with a proper fix.
>>>
>> Hi Andrea,
>> is this patch still outstanding or am I out of the loop now?
> 
> I have a fix in my tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/arighi/linux.git/commit/?h=scx-6.18&id=225dccfba74877ba7c74971801f8d8f47d124373
> 
> But it also requires this fix for BPF as well:
> https://lore.kernel.org/all/20250917032755.4068726-1-memxor@gmail.com/

Ah I missed that, thanks for the hint!

> 
> I was waiting for the BPF fix to land in bpf-next, then I was planning to
> send the fix for the scx_bpf_cpu_curr() kfunc (I'll add you in cc).
> 
> -Andrea


