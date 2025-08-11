Return-Path: <linux-kernel+bounces-763178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7816B2118E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448E1502637
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE82E2DD2;
	Mon, 11 Aug 2025 16:02:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AFB311C01
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928153; cv=none; b=LZlf1k19NUdMgjraYf/E80A6hRCF53yK5Um7m2jmB1lgrut0b8WguYSUcaxNd6jqYJdEv/iqBpPwpKXSDTBjDGoDfGHXig4gj7h9ajtM7DV6ZOHuftDIEtIJ4+PdKGAGo/digAHxGavdihQyH72VgN63fTh8QGJWh1+XvNBKooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928153; c=relaxed/simple;
	bh=kNLSl65ljpcvx0dl4AnonJBTXcS5M2u0FzI2WwfAp3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q68YGmhTbxdAxWv29miOF9BXN2IWWbfrJeNhcxFBiso+KHDYtBIhMup5vuXlUNI0ZuRtjurEhQBRRq+X/TDRhOvofL4Knp0O8gsIWQxUuoUORKRSHohUqsRZH8OkQLWbvVi91mpMFXHZ+yodRBAANZMn4alhfkdnrap+yIeYBb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0293A267F;
	Mon, 11 Aug 2025 09:02:23 -0700 (PDT)
Received: from [10.1.28.163] (e137867.arm.com [10.1.28.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271C53F738;
	Mon, 11 Aug 2025 09:02:26 -0700 (PDT)
Message-ID: <ced13246-4c00-4837-9d8a-1d140eb0bcb3@arm.com>
Date: Mon, 11 Aug 2025 17:02:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 5/7] arm64: entry: Refactor
 preempt_schedule_irq() check code
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
 <20250729015456.3411143-6-ruanjinjie@huawei.com>
 <44fd646c-4e31-4ca6-9e22-f715ad19e0d7@arm.com>
 <bedb35be-100b-95fb-64e4-b38edd3cd327@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <bedb35be-100b-95fb-64e4-b38edd3cd327@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/08/2025 07:39, Jinjie Ruan wrote:

> On 2025/8/5 23:06, Ada Couprie Diaz wrote:
>> Hi Jinjie,
>>
>> On 29/07/2025 02:54, Jinjie Ruan wrote:
>>> ARM64 requires an additional check whether to reschedule on return
>>> from interrupt. So add arch_irqentry_exit_need_resched() as the default
>>> NOP implementation and hook it up into the need_resched() condition in
>>> raw_irqentry_exit_cond_resched(). This allows ARM64 to implement
>>> the architecture specific version for switching over to
>>> the generic entry code.
>>> [...]
>> I've had some trouble reviewing this patch : on the one hand because
>> I didn't notice `arch_irqentry_exit_need_resched()` was added in
>> the common entry code, which is on me !
>> On the other hand, I felt that the patch itself was a bit disconnected :
>> we add `arch_irqentry_exit_need_resched()` in the common entry code,
>> with a default NOP, but in the same function we add to arm64,
>> while mentioning that this is for arm64's additional checks,
>> which we only implement in patch 7.
> Yes, it does.
>
>> Would it make sense to move the `arch_irqentry_exit_need_resched()`
>> part of the patch to patch 7, so that the introduction and
>> arch-specific implementation appear together ?
>> To me it seems easier to wrap my head around, as it would look like
>> "Move arm64 to generic entry, but it does additional checks : add a new
>> arch-specific function controlling re-scheduling, defaulting to true,
>> and implement it for arm64". I feel it could help making patch 7's
>> commit message clearer as well.
>>
>>  From what I gathered on the archive `arch_irqentry_exit_need_resched()`
>> being added here was suggested previously, so others might not have the
>> same opinion.
> Yes, introduce `arch_irqentry_exit_need_resched()` here may help
> understand the patch's refactoring purpose.
I can see that as well.
I shared my opinion in case it could be useful, but as I mentioned
in my reply to the cover : it's not a big issue and I'm happy for
`arch_irqentry_exit_need_resched()` to be implemented here if that
makes more sense !
>> Maybe improving the commit message and comment for this would be enough
>> as well, as per my suggestions above.
> Thank you! I'll improve the commit message and comment.
>
My pleasure !
Ada

