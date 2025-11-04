Return-Path: <linux-kernel+bounces-884874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E7C315E9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A701889151
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9AC23B627;
	Tue,  4 Nov 2025 14:02:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632AE21CC49
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264929; cv=none; b=RGAUNRbiKiEjPuh83NiXUgCWy/OUvsqFDkW0IPiX8ogOENVC3Tg5q8ZkEkeRTgmtcAcmmFfhgTz6kns5PYwKoonZHwbYKws3BPYz5zhC0KskHEuO4xXUWnDcUFDSTXTCG6tLx/JsKx+rwFjVKDEGUXM8r6015Puj9m9kfeB2NVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264929; c=relaxed/simple;
	bh=wlH1mNse9Oj7SY+5J8LZQOY+NiGMKFixFpk3OT5mNGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYGfuGxqgB5Hi7s0TZQ8UIr2OOUDwn65l94MfTNn5HakbaazjVLDzPO5aWpvPuEeQ4wZP1HWeMWPKOY7TQ9zLyhiZugOJoH8s28cuF6b+Mw96w+PXYxnW/YeesLbUfGIHDrmoZOcKADrwsL8VY1BjmdwkWCoE6+cvl5H02gYwDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E79C01CE0;
	Tue,  4 Nov 2025 06:01:58 -0800 (PST)
Received: from [10.164.18.64] (unknown [10.164.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B037C3F694;
	Tue,  4 Nov 2025 06:02:04 -0800 (PST)
Message-ID: <053b2bfd-df5e-41fe-854c-f0eb96564dcb@arm.com>
Date: Tue, 4 Nov 2025 19:32:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: kprobes: check the return value of
 set_memory_rox()
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, ryan.roberts@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251103194505.4077265-1-yang@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251103194505.4077265-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/11/25 1:15 am, Yang Shi wrote:
> Since commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"), __change_memory_common has more chance to fail due to
> memory allocation fialure when splitting page table. So check the return
> value of set_memory_rox(), then bail out if it fails otherwise we may have
> RW memory mapping for kprobes insn page.
>
> Fixes: 195a1b7d8388 ("arm64: kprobes: call set_memory_rox() for kprobe page")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
> I actually epxected 195a1b7d8388 ("arm64: kprobes: call set_memory_rox()
> for kprobe page") can be merged in 6.17-rcX, so I just restored it to
> before commit 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in
> alloc_insn_page"), however it turned out to be merged in 6.18-rc1 and it
> is after commit a166563e7ec3 ("arm64: mm: support large block mapping when
> rodata=full"). So I made the fix tag point to it.
> And I don't think we need to backport this patch to pre-6.18.
>
>   arch/arm64/kernel/probes/kprobes.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 8ab6104a4883..43a0361a8bf0 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -49,7 +49,10 @@ void *alloc_insn_page(void)
>   	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
>   	if (!addr)
>   		return NULL;
> -	set_memory_rox((unsigned long)addr, 1);
> +	if (set_memory_rox((unsigned long)addr, 1)) {
> +		execmem_free(addr);
> +		return NULL;
> +	}
>   	return addr;
>   }

Looks obviously correct:

Reviewed-by: Dev Jain <dev.jain@arm.com>

Although I got confused by why set_memory_rox() is being called; it is being used
only to handle the linear map alias perm change, which is not nice :) but I don't
see an obvious way to refactor the code to only perform the needed functionality here,
and probably this is not a hot path that we care about.

>   

