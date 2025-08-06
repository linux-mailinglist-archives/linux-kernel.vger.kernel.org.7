Return-Path: <linux-kernel+bounces-757190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C40A1B1BEE2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4098962627D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D7F1A3165;
	Wed,  6 Aug 2025 02:49:30 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE023CE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 02:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754448569; cv=none; b=gBI5Fzs7HyBhfGcZn7YamzMhDUczIzOlyZbGvjTkdgsJU+1/x3QK0QRxRKE0wmD9bIDP4YzRy3PtT2KUAbleMJA/GoHZQxSmmm4a/OC8PhaHS5RGWi7iofP065JVkBXKSC3HLA7YTTKQBMBwzRACLemeWx70pIglO2zeA2jXCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754448569; c=relaxed/simple;
	bh=0BmMkPKxthCidJu5e8ogZHf/bKGYor1BsxkiRpDVriQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VYb2dugWeFH/vbtjrdksOIUP1Mvm1pHb+n5a3pmSLa+B3NY1EX8WjP6HJm3CqlQg7XI/8ugmLtMTrc5sYDeVMuLnG777KIGFPTJYMPYTWqXeFAWpt04jLm2H7KLq3QXB9Ykp4Yx92n/WCtppDbkiiruusaRTYwx3VFvVjiXxiNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bxZQV4lLmz14MLW;
	Wed,  6 Aug 2025 10:45:06 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E366180B54;
	Wed,  6 Aug 2025 10:49:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 dggpemf500011.china.huawei.com (7.185.36.131) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 10:49:21 +0800
Message-ID: <6825c4c4-2c48-db3b-55e2-97922f25897f@huawei.com>
Date: Wed, 6 Aug 2025 10:49:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v7 2/7] arm64: entry: Refactor the entry and exit
 for exceptions from EL1
Content-Language: en-US
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<sstabellini@kernel.org>, <mark.rutland@arm.com>, <puranjay@kernel.org>,
	<broonie@kernel.org>, <mbenes@suse.cz>, <ryan.roberts@arm.com>,
	<akpm@linux-foundation.org>, <chenl311@chinatelecom.cn>,
	<anshuman.khandual@arm.com>, <kristina.martsenko@arm.com>,
	<liaochang1@huawei.com>, <ardb@kernel.org>, <leitao@debian.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-3-ruanjinjie@huawei.com>
 <df50cc99-027e-4182-ba4c-9837b354a062@arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <df50cc99-027e-4182-ba4c-9837b354a062@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500011.china.huawei.com (7.185.36.131)



On 2025/8/5 23:06, Ada Couprie Diaz wrote:
> Hi,
> 
> On 29/07/2025 02:54, Jinjie Ruan wrote:
> 
>> The generic entry code uses irqentry_state_t to track lockdep and RCU
>> state across exception entry and return. For historical reasons, arm64
>> embeds similar fields within its pt_regs structure.
>>
>> In preparation for moving arm64 over to the generic entry code, pull
>> these fields out of arm64's pt_regs, and use a separate structure,
>> matching the style of the generic entry code.
>>
>> No functional changes.
> As far as I understand and checked, we used the two fields
> in an exclusive fashion, so there is indeed no functional change.
>> Suggested-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> [...]
>> diff --git a/arch/arm64/kernel/entry-common.c
>> b/arch/arm64/kernel/entry-common.c
>> index 8e798f46ad28..97e0741abde1 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> [...]
>> @@ -475,73 +497,81 @@ UNHANDLED(el1t, 64, error)
>>   static void noinstr el1_abort(struct pt_regs *regs, unsigned long esr)
>>   {
>>       unsigned long far = read_sysreg(far_el1);
>> +    arm64_irqentry_state_t state;
>>   -    enter_from_kernel_mode(regs);
>> +    state = enter_from_kernel_mode(regs);
> Nit: There is some inconsistencies with some functions splitting state's
> definition
> and declaration (like el1_abort here), while some others do it on the
> same line
> (el1_undef() below for example).
> In some cases it is welcome as the entry function is called after some
> other work,
> but here for example it doesn't seem to be beneficial ?

Both methods can keep the modifications to `enter_from_kernel_mode()` on
the same line as the original code, which will facilitate code review.

I think it is also fine to do it on the same line here, which can reduce
one line code, which method is better may be a matter of personal opinion.

>>       local_daif_inherit(regs);
>>       do_mem_abort(far, esr, regs);
>>       local_daif_mask();
>> -    exit_to_kernel_mode(regs);
>> +    exit_to_kernel_mode(regs, state);
>>   }
>>     static void noinstr el1_pc(struct pt_regs *regs, unsigned long esr)
>>   {
>>       unsigned long far = read_sysreg(far_el1);
>> +    arm64_irqentry_state_t state;
>>   -    enter_from_kernel_mode(regs);
>> +    state = enter_from_kernel_mode(regs);
>>       local_daif_inherit(regs);
>>       do_sp_pc_abort(far, esr, regs);
>>       local_daif_mask();
>> -    exit_to_kernel_mode(regs);
>> +    exit_to_kernel_mode(regs, state);
>>   }
>>     static void noinstr el1_undef(struct pt_regs *regs, unsigned long
>> esr)
>>   {
>> -    enter_from_kernel_mode(regs);
>> +    arm64_irqentry_state_t state = enter_from_kernel_mode(regs);
>> +
>>       local_daif_inherit(regs);
>>       do_el1_undef(regs, esr);
>>       local_daif_mask();
>> -    exit_to_kernel_mode(regs);
>> +    exit_to_kernel_mode(regs, state);
>>   }
>>
>> [...]
> Other than the small nit:
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 
> 

