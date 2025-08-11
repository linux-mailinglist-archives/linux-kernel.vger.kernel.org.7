Return-Path: <linux-kernel+bounces-763176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606E0B211B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0F5053DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49BF6F06B;
	Mon, 11 Aug 2025 16:02:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E4529BDA9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928130; cv=none; b=dH+7ugNo/fXGLAW7tN+c3NgH6ejOaEeEQ9RHDaoKBgVvTjvI02GUU1hVV5/U0zqmuUtbSgJTQo+yB16ayXFktcMjvcLOdBZ+b0zPvn/f5vx2AoxtanFtnpBuea+rKZWaXY1R7R66zD2fmAeRo+ELcjuQuZBQseLOKLUhQL7nd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928130; c=relaxed/simple;
	bh=Qj13QBAwJ77MFXFG1RJS3Noyd9BQgNdqtzWsMbAqH4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+YYg3jWpn9lzlkWqHuLBGjv+NyiIayOvPox4ZFftTj4o4x7JVE5YLU60H2IkDf6DnR0+bSN14dYWfmlqyU8kgTYYsgZhgWMBimVQ8hT3lhGIeJgZIkFEBPvUQ27wktfnGsLFF5gWkqs5w+Snwk35us27aJPfqfV0wzpqwIyZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDC66266C;
	Mon, 11 Aug 2025 09:01:59 -0700 (PDT)
Received: from [10.1.28.163] (e137867.arm.com [10.1.28.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0D163F738;
	Mon, 11 Aug 2025 09:02:03 -0700 (PDT)
Message-ID: <4b18c96b-116b-417d-ab98-eb81b80c9897@arm.com>
Date: Mon, 11 Aug 2025 17:01:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 2/7] arm64: entry: Refactor the entry and exit
 for exceptions from EL1
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
 sstabellini@kernel.org, mark.rutland@arm.com, puranjay@kernel.org,
 broonie@kernel.org, mbenes@suse.cz, ryan.roberts@arm.com,
 akpm@linux-foundation.org, chenl311@chinatelecom.cn,
 anshuman.khandual@arm.com, kristina.martsenko@arm.com,
 liaochang1@huawei.com, ardb@kernel.org, leitao@debian.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ada Couprie Diaz <ada.coupriediaz@arm.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-3-ruanjinjie@huawei.com>
 <df50cc99-027e-4182-ba4c-9837b354a062@arm.com>
 <6825c4c4-2c48-db3b-55e2-97922f25897f@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <6825c4c4-2c48-db3b-55e2-97922f25897f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/08/2025 03:49, Jinjie Ruan wrote:

> On 2025/8/5 23:06, Ada Couprie Diaz wrote:
>> Hi,
>>
>> On 29/07/2025 02:54, Jinjie Ruan wrote:
>>
>>> [...]
>>> diff --git a/arch/arm64/kernel/entry-common.c
>>> b/arch/arm64/kernel/entry-common.c
>>> index 8e798f46ad28..97e0741abde1 100644
>>> --- a/arch/arm64/kernel/entry-common.c
>>> +++ b/arch/arm64/kernel/entry-common.c
>>> [...]
>>> @@ -475,73 +497,81 @@ UNHANDLED(el1t, 64, error)
>>>    static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
>>>    {
>>>        unsigned long far = read_sysreg(far_el1);
>>> +    arm64_irqentry_state_t state;
>>>    -    enter_from_kernel_mode(regs);
>>> +    state = enter_from_kernel_mode(regs);
>> Nit: There is some inconsistencies with some functions splitting state's
>> definition
>> and declaration (like el1_abort here), while some others do it on the
>> same line
>> (el1_undef() below for example).
>> In some cases it is welcome as the entry function is called after some
>> other work,
>> but here for example it doesn't seem to be beneficial ?
> Both methods can keep the modifications to `enter_from_kernel_mode()` on
> the same line as the original code, which will facilitate code review.
>
> I think it is also fine to do it on the same line here, which can reduce
> one line code, which method is better may be a matter of personal opinion.
Fair point !
Then, as mentioned previously, I'm happy to leave my Reviewed-By.
>>>        local_daif_inherit(regs);
>>>        do_mem_abort(far, esr, regs);
>>>        local_daif_mask();
>>> -    exit_to_kernel_mode(regs);
>>> +    exit_to_kernel_mode(regs, state);
>>>    }
>>>      static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
>>>    {
>>>        unsigned long far = read_sysreg(far_el1);
>>> +    arm64_irqentry_state_t state;
>>>    -    enter_from_kernel_mode(regs);
>>> +    state = enter_from_kernel_mode(regs);
>>>        local_daif_inherit(regs);
>>>        do_sp_pc_abort(far, esr, regs);
>>>        local_daif_mask();
>>> -    exit_to_kernel_mode(regs);
>>> +    exit_to_kernel_mode(regs, state);
>>>    }
>>>      static void noinstr el1_undef(struct pt_regs *regs, unsigned long
>>> esr)
>>>    {
>>> -    enter_from_kernel_mode(regs);
>>> +    arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
>>> +
>>>        local_daif_inherit(regs);
>>>        do_el1_undef(regs, esr);
>>>        local_daif_mask();
>>> -    exit_to_kernel_mode(regs);
>>> +    exit_to_kernel_mode(regs, state);
>>>    }
>>>
>>> [...]
>> Other than the small nit:
>> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>

