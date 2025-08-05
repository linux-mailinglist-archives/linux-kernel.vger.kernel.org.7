Return-Path: <linux-kernel+bounces-756637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD595B1B71D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC53189A945
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E1279DA1;
	Tue,  5 Aug 2025 15:05:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D02279780
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406358; cv=none; b=dtGtb1tvsGT75U/KGnLUTDO366x9S7XIufUg7VTU8Erp9ME0zx+XdYRDdMu8tEK9vENfnrpeDcuFK5IFrzjyoEIL0KVCap9WzGgT1x9+Co8J42uFx/bCbToOgMb3zXCBfkLvuRGEv9ZmfI+1WMGHBwMkNtuOVhm2wz+AA4+9lP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406358; c=relaxed/simple;
	bh=tvxlP81aKz8S/NAeTbKmd9r5u+msKQDBBxTVogFOe54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=iZtjZX3/Y3dq12uqv4fO5kI64xE8Od9TTPpXhKxilv251XioflKYXjEO6SDRC9Bv6CL5E0lOomTCxh7as9AVkaXxcIXJcqK7SyzJzv880VVObP/vnvG70zDPRXzsznjdaWBZKbszaI7qRabIbWh2yM/FRTKIddZ31IuBOaqlhBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C11B1424;
	Tue,  5 Aug 2025 08:05:48 -0700 (PDT)
Received: from [10.1.29.177] (e137867.arm.com [10.1.29.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55FA3F673;
	Tue,  5 Aug 2025 08:05:51 -0700 (PDT)
Message-ID: <beb7e8f2-39f8-499f-a173-b8bf2d3296ea@arm.com>
Date: Tue, 5 Aug 2025 16:05:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v7 1/7] arm64: ptrace: Replace interrupts_enabled()
 with regs_irqs_disabled()
To: Jinjie Ruan <ruanjinjie@huawei.com>
References: <20250729015456.3411143-1-ruanjinjie@huawei.com>
 <20250729015456.3411143-2-ruanjinjie@huawei.com>
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
 mark.rutland@arm.com, puranjay@kernel.org, broonie@kernel.org,
 mbenes@suse.cz, ryan.roberts@arm.com, akpm@linux-foundation.org,
 chenl311@chinatelecom.cn, anshuman.khandual@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, ardb@kernel.org,
 leitao@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Content-Language: en-US
Organization: Arm Ltd.
In-Reply-To: <20250729015456.3411143-2-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 02:54, Jinjie Ruan wrote:

> The generic entry code expects architecture code to provide
> regs_irqs_disabled(regs) function, but arm64 does not have this and
> provides inerrupts_enabled(regs), which has the opposite polarity.
Nit: "interrupts_enabled(regs)"
> In preparation for moving arm64 over to the generic entry code,
> relace arm64's interrupts_enabled() with regs_irqs_disabled() and
> update its callers under arch/arm64.
>
> For the moment, a definition of interrupts_enabled() is provided for
> the GICv3 driver. Once arch/arm implement regs_irqs_disabled(), this
> can be removed.
>
> Delete the fast_interrupts_enabled() macro as it is unused and we
> don't want any new users to show up.
>
> No functional changes.
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
Otherwise looks good to me !
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>

