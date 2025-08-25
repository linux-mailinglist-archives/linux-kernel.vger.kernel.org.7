Return-Path: <linux-kernel+bounces-784552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42004B33D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146222030EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CEA2DCF4C;
	Mon, 25 Aug 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OH4dziab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBA51F461D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119347; cv=none; b=AAiPK4M/QjMQITJ5wLbhk2SDH9daOPC5RWZDmQuIvw+6V4eTVNUSSxapEvzj7/McFqQzn5eiFtVLkkg728dBklCqDZzo+dOhCYtP7mBZW5lPkXjpx9wy5E5K1O0YGIe+zB+ulmXum3eHq3P11XjRaqDdK4sFKf8PfzS/Id3DK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119347; c=relaxed/simple;
	bh=7Eo++RSHk60jXhrBRV6DAWQrmxZrOjIBQJ88YUsXAzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMpquabwj/gNBvz5PplFolhV4Be/N3hFttDRR0rtLQPxrR5EcnOUT7sdQQjnwngtKzyRhEv0ezW+FgKsoFl54b1omvT4izbImvNPnE43Hr9BwH+Y4NRRA5HzuwEXHxpg6i949Mx7/VACq35P86p7RpQxGJvSZsvRVFebxxwg0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OH4dziab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E22C113D0;
	Mon, 25 Aug 2025 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756119346;
	bh=7Eo++RSHk60jXhrBRV6DAWQrmxZrOjIBQJ88YUsXAzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OH4dziab8ewgT4fEKyE+VyC3wpI2KXsmvXVPNsOjfPFPCZ2IT3bNvsdcInGitkyKc
	 KSIKLew8SsCYuyelEeMvqEkarU/6kEl3OHHHkrgbBLb/FHLvxjR5BTyTS9i39gdv+4
	 d9gUiRJ5OHmavsw0f5OjzLR5QB8gi0hxwQ2mmDiG+lBiYp9cwLHSLVA0vU40xV68mO
	 0mL2MaN2cv6JRZiGwb5J1xVV/sWs0QYYiGs5FgYjxsB+pdbwcGZsXiNHwJc8kIs9WH
	 +7MhTHO1ntgh79jrZN2+Zl5IF0g8MxPGd1TQJtQOfuHGpcTZbYsgGtvASuTBjLYpph
	 i4pjfnqOAUKzA==
Message-ID: <a77f4199-dc21-4817-b08a-823d0753a303@kernel.org>
Date: Mon, 25 Aug 2025 05:55:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nios2: ensure that memblock.current_limit is set when
 setting pfn limits
To: schuster.simon@siemens-energy.com
Cc: linux-kernel@vger.kernel.org,
 Andreas Oetken <andreas.oetken@siemens-energy.com>
References: <20250821-nios2-adjust-lowmem-bounds-v1-1-ea2dd8661ae5@siemens-energy.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250821-nios2-adjust-lowmem-bounds-v1-1-ea2dd8661ae5@siemens-energy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 05:37, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> On nios2, with CONFIG_FLATMEM set, the kernel relies on
> memblock_get_current_limit() to determine the limits of mem_map, in
> particular for max_low_pfn.
> Unfortunately, memblock.current_limit is only default initialized to
> MEMBLOCK_ALLOC_ANYWHERE at this point of the bootup, potentially leading
> to situations where max_low_pfn can erroneously exceed the value of
> max_pfn and, thus, the valid range of available DRAM.
> 
> This can in turn cause kernel-level paging failures, e.g.:
> 
> [   76.900000] Unable to handle kernel paging request at virtual address 20303000
> [   76.900000] ea = c0080890, ra = c000462c, cause = 14
> [   76.900000] Kernel panic - not syncing: Oops
> [   76.900000] ---[ end Kernel panic - not syncing: Oops ]---
> 
> This patch fixes this by pre-calculating memblock.current_limit
> based on the upper limits of the available memory ranges via
> adjust_lowmem_bounds, a simplified version of the equivalent
> implementation within the arm architecture.
> 
> Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
> Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
> ---
> This patch was tested internally on 5.10.x stable for some time now and
> applies and boots cleanly on next-20250815, as well.
> ---
>   arch/nios2/kernel/setup.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
> index 2a40150142c3..f43f01c4ab93 100644
> --- a/arch/nios2/kernel/setup.c
> +++ b/arch/nios2/kernel/setup.c
> @@ -142,6 +142,20 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
>   	*max_high = PFN_DOWN(memblock_end_of_DRAM());
>   }
>   
> +static void __init adjust_lowmem_bounds(void)
> +{
> +	phys_addr_t block_start, block_end;
> +	u64 i;
> +	phys_addr_t memblock_limit = 0;
> +
> +	for_each_mem_range(i, &block_start, &block_end) {
> +		if (block_end > memblock_limit)
> +			memblock_limit = block_end;
> +	}
> +
> +	memblock_set_current_limit(memblock_limit);
> +}
> +
>   void __init setup_arch(char **cmdline_p)
>   {
>   	console_verbose();
> @@ -157,6 +171,7 @@ void __init setup_arch(char **cmdline_p)
>   	/* Keep a copy of command line */
>   	*cmdline_p = boot_command_line;
>   
> +	adjust_lowmem_bounds();
>   	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
>   
>   	memblock_reserve(__pa_symbol(_stext), _end - _stext);
> 
> ---
> base-commit: 1357b2649c026b51353c84ddd32bc963e8999603
> change-id: 20250818-nios2-adjust-lowmem-bounds-5d2d98af0fa8
> 
> Best regards,


Applied! Queued for v6.18.

Thanks,
Dinh

