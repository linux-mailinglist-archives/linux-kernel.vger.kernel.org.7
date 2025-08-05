Return-Path: <linux-kernel+bounces-756642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4708B1B724
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B501893CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608AB2797A5;
	Tue,  5 Aug 2025 15:07:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987A5258CFF
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406442; cv=none; b=DbdPIDugBJIP5jJwTnvKOFvslFWTzc9NlDXkT7CrHi+H4yh4AjtIvHXfQPse4XZly0oHoL1eAAnvIOWMxVg17A9wqWHD4y0xb8Y7PP/li72hUfE/Lx5hv1EyAT6qI4FFOq3UzZa50D7ZCEAHfz/Ak5YrE5lAfq4rjb0guY5UQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406442; c=relaxed/simple;
	bh=5T8wkERoCErG1exwBUE1ZAb7GD8RHCyfx23z/wcXmFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=QpIBdFHxRnBPL2X3yCR8fHoCAqVMcntnBN1W1/Gnd1f/WI8+9GjjosJ+p1JQoIdtpyz5aAoH4OO8EDNbzEzzGnLicKfnpaqlL8NflPUauBTjQUHmOMM50p0OA/IpNoEWQTyxzqhgokuRxtg3WI5iw60zOQWleFucRn/6bjVmEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ABA12BCE;
	Tue,  5 Aug 2025 08:07:12 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E03633F673;
	Tue,  5 Aug 2025 08:07:15 -0700 (PDT)
Message-ID: <dbe56865-392e-4705-b841-5612aecd016b@arm.com>
Date: Tue, 5 Aug 2025 16:07:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 6/7] arm64: entry: Move
 arm64_preempt_schedule_irq() into __exit_to_kernel_mode()
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-7-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: mbenes@suse.cz, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 leitao@debian.org, ardb@kernel.org, liaochang1@huawei.com,
 kristina.martsenko@arm.com, anshuman.khandual@arm.com,
 chenl311@chinatelecom.cn, akpm@linux-foundation.org, ryan.roberts@arm.com,
 broonie@kernel.org, puranjay@kernel.org, mark.rutland@arm.com,
 sstabellini@kernel.org, oleg@redhat.com, will@kernel.org,
 catalin.marinas@arm.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-7-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 02:54, Jinjie Ruan wrote:

> The arm64 entry code only preempts a kernel context upon a return from
> a regular IRQ exception. The generic entry code may preempt a kernel
> context for any exception return where irqentry_exit() is used, and so
> may preempt other exceptions such as faults.
>
> In preparation for moving arm64 over to the generic entry code, align
> arm64 with the generic behaviour by calling
> arm64_preempt_schedule_irq() from exit_to_kernel_mode(). To make this
> possible, arm64_preempt_schedule_irq()
> and dynamic/raw_irqentry_exit_cond_resched() are moved earlier in
> the file, with no changes.
>
> As Mark pointed out, this change will have the following 2 key impact:
>
> - " We'll preempt even without taking a "real" interrupt. That
>      shouldn't result in preemption that wasn't possible before,
>      but it does change the probability of preempting at certain points,
>      and might have a performance impact, so probably warrants a
>      benchmark."
>
> - " We will not preempt when taking interrupts from a region of kernel
>      code where IRQs are enabled but RCU is not watching, matching the
>      behaviour of the generic entry code.
>
>      This has the potential to introduce livelock if we can ever have a
>      screaming interrupt in such a region, so we'll need to go figure out
>      whether that's actually a problem.
>
>      Having this as a separate patch will make it easier to test/bisect
>      for that specifically."
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---

Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>


