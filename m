Return-Path: <linux-kernel+bounces-844379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA68BC1C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CB9734D7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0551F4C84;
	Tue,  7 Oct 2025 14:33:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEB42C9D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847630; cv=none; b=dXLlVPOdCdfb6mVk8zK9gNufLbKi1PwAXVHLpMbplSdaCpW0KWHKZf009SGSV01K78Gfr1Pja8cUZXJ3nUUGB7Eea2sXPl0IiEG5W72SM5IRF0f+tKBweH+TMdy3zKi3cPuN82HtFKaNMRWqL3MpPI7TSkDEsx8VoYoYbHPnagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847630; c=relaxed/simple;
	bh=3s5knbfgY4mqprNlHcxFKLMdwitcF201XsyLYqBZVko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xkr51Z/R5XDHW8FgSppD1wVOdyZFCm2jQUAabg0NbCDjm1IQe57SqOqtUWZXbzqPlxQFXFuW2Kxbmp/EeSV6CNHtY7THev1ULoM5DE8jyMzOj2+Jt2bvsVTIa0ECgjl7eNOGEyWvLRQw9YS7r3akplKGbRErLJVMIUm33LTvsDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E0591424;
	Tue,  7 Oct 2025 07:33:39 -0700 (PDT)
Received: from [10.44.160.66] (e126510-lin.lund.arm.com [10.44.160.66])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 804133F738;
	Tue,  7 Oct 2025 07:33:45 -0700 (PDT)
Message-ID: <4001ebcc-7516-4bea-a920-8750f029b442@arm.com>
Date: Tue, 7 Oct 2025 16:33:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] powerpc/64s: Do not re-activate batched TLB flush
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1749747752.git.agordeev@linux.ibm.com>
 <8625a1d97dcf4ae499b4bb341e27346f768a7248.1749747752.git.agordeev@linux.ibm.com>
 <aFGFl9Dvb9zdC3JS@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <ef5d851b-0f67-410e-9479-0f6d344fa17b@arm.com>
 <68e4e0f8.050a0220.1e89ea.1c6f@mx.google.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <68e4e0f8.050a0220.1e89ea.1c6f@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2025 11:40, Ritesh Harjani (IBM) wrote:
> Kevin Brodsky <kevin.brodsky@arm.com> writes:
>
>> On 17/06/2025 17:11, Alexander Gordeev wrote:
>>> On Thu, Jun 12, 2025 at 07:36:13PM +0200, Alexander Gordeev wrote:
>>>> Since commit b9ef323ea168 ("powerpc/64s: Disable preemption in hash
>>>> lazy mmu mode") a task can not be preempted while in lazy MMU mode.
>>>> Therefore, the batch re-activation code is never called, so remove it.
>>>>
>>>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>>>> ---
>>>>  arch/powerpc/include/asm/thread_info.h |  2 --
>>>>  arch/powerpc/kernel/process.c          | 25 -------------------------
>>>>  2 files changed, 27 deletions(-)
>>> Hi All,
>>>
>>> (I trimmed non-ppc mailing lists/people).
>>>
>>> The whole series does not seem to make it, but this patch alone is still
>>> applicable and makes sence, if I am not mistaken.
>> Yes, I agree. I arrived at the same conclusion working on the next
>> version of the nested lazy_mmu series [1].
>> [1]
>> https://lore.kernel.org/all/20250908073931.4159362-1-kevin.brodsky@arm.com/
> Yes, we disable preemption while in lazy mmu mode for Hash, so I agree that
> we won't call into __switch_to() in between preempt_disable()/_enable().
> So it does look like that we don't need that code.

Thanks for confirming.

>> May I include this patch in v3?
>>
> That should be ok.

Thanks!

- Kevin

