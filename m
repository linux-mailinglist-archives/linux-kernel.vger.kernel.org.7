Return-Path: <linux-kernel+bounces-807143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3EFB4A0B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A2A7A5DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A3B2E888F;
	Tue,  9 Sep 2025 04:29:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492102D46C6;
	Tue,  9 Sep 2025 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757392167; cv=none; b=T80HuVU66cjkg22gdP+kLVWQJ/UlESxW+W5lPWjwV6ij1dem/gdAtqdBvbq16+oFC4rmhvK5LksaVOpnY7kY6E3PJSgSmpuaKYBT8tW7B1guNCfj7dHmNMBE9kgRv3YMgwSR7aAtBTUtHwJegbN0T83a0MLj2d5/6LAMq0ZO268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757392167; c=relaxed/simple;
	bh=IepMFzkXN6oJpvS5mgBFY8hpz2AT9un2uq64C9FMB3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjwX0rCqVL3fcaQmFVL6ntEJJmwcEndty3sI9VhkWvmH7RKjM5zZ3XK4gEUCSYmXMIC1TmNyMckJIEviuppi4560MJiNw5P/KANSk4MmxWHISW88knyXIfaL3zfoJnn+NmTn1J2knLJWeP0P+vcaCAQxKBUFd4W0EK40IfVgYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBE612FC;
	Mon,  8 Sep 2025 21:29:16 -0700 (PDT)
Received: from [10.163.72.34] (unknown [10.163.72.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9094F3F66E;
	Mon,  8 Sep 2025 21:29:18 -0700 (PDT)
Message-ID: <bc0ae013-2314-4513-a759-cbf2b922aa6a@arm.com>
Date: Tue, 9 Sep 2025 09:59:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] arm64: refactor the rodata=xxx
To: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: patches@amperecomputing.com, cl@linux.com,
 Shubhang@os.amperecomputing.com, corbet@lwn.net, paulmck@kernel.org,
 akpm@linux-foundation.org, rostedt@goodmis.org, Neeraj.Upadhyay@amd.com,
 bp@alien8.de, ardb@kernel.org, suzuki.poulose@arm.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org
References: <20250909033236.4099-1-shijie@os.amperecomputing.com>
 <20250909033236.4099-2-shijie@os.amperecomputing.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250909033236.4099-2-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/25 9:02 AM, Huang Shijie wrote:
> As per admin guide documentation, "rodata=on" should be the default on
> platforms. Documentation/admin-guide/kernel-parameters.txt describes
> these options as
> 
>    rodata=         [KNL,EARLY]
>            on      Mark read-only kernel memory as read-only (default).
>            off     Leave read-only kernel memory writable for debugging.
>            full    Mark read-only kernel memory and aliases as read-only
>                    [arm64]
> 
> But on arm64 platform, RODATA_FULL_DEFAULT_ENABLED is enabled by default,
> so "rodata=full" is the default instead.
> 
> This patch implements the following changes:
>  - Make "rodata=on" behaviour same as the original "rodata=full".
>    This keeps align with the x86.
>  - Make "rodata=noalias" (new) behaviour same as the original "rodata=on"
>  - Drop the original "rodata=full"
> 
> After this patch, the "rodata=on" will be the default on arm64 platform
> as well.
> 
> Different rodata options may have different performance, so record more
> detail information here:
> 
>  rodata=on (default)
>     This applies read-only attributes to VM areas and to the linear
>     alias of the backing pages as well. This prevents code or read-
>     only data from being modified (inadvertently or intentionally),
>     via another mapping for the same memory page.
> 
>     But this might cause linear map region to be mapped down to base
>     pages, which may adversely affect performance in some cases.
> 
>  rodata=off
>     This provides more block mappings and contiguous hints for linear
>     map region which would minimize TLB footprint. This also leaves
>     read-only kernel memory writable for debugging.
> 
>  rodata=noalias
>     This provides more block mappings and contiguous hints for linear
>     map region which would minimize TLB footprint. This leaves the linear
>     alias of read-only mappings in the vmalloc space writeable, making

						typo     ^^^^^^^^
>     them susceptible to inadvertent modification by software.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  arch/arm64/include/asm/setup.h                  | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index db84a629f7b1..138e0db5af64 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6418,8 +6418,9 @@
>  	rodata=		[KNL,EARLY]
>  		on	Mark read-only kernel memory as read-only (default).
>  		off	Leave read-only kernel memory writable for debugging.
> -		full	Mark read-only kernel memory and aliases as read-only
> -		        [arm64]
> +		noalias	Mark read-only kernel memory as read-only but retain
> +			writable aliases in the direct map for regions outside
> +			of the kernel image. [arm64]

Should not the arm64 specific performance implications be mentioned
in the above documentation update as well ? But in case this appears
too much platform specific - probably do consider adding them above
or inside arch_parse_debug_rodata() as an in-code documentation. 

     rodata=on (default)
        This applies read-only attributes to VM areas and to the linear
        alias of the backing pages as well. This prevents code or read-
        only data from being modified (inadvertently or intentionally),
        via another mapping for the same memory page.

        But this might cause linear map region to be mapped down to base
        pages, which may adversely affect performance in some cases.

     rodata=off
        This provides more block mappings and contiguous hints for linear
        map region which would minimize TLB footprint. This also leaves
        read-only kernel memory writable for debugging.

     rodata=noalias
        This provides more block mappings and contiguous hints for linear
        map region which would minimize TLB footprint. This leaves the linear
        alias of read-only mappings in the vmalloc space writeable, making
        them susceptible to inadvertent modification by software.

>  
>  	rockchip.usb_uart
>  			[EARLY]
> diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
> index ba269a7a3201..3d96dde4d214 100644
> --- a/arch/arm64/include/asm/setup.h
> +++ b/arch/arm64/include/asm/setup.h
> @@ -21,7 +21,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  	if (!arg)
>  		return false;
>  
> -	if (!strcmp(arg, "full")) {
> +	if (!strcmp(arg, "on")) {
>  		rodata_enabled = rodata_full = true;
>  		return true;
>  	}
> @@ -31,7 +31,7 @@ static inline bool arch_parse_debug_rodata(char *arg)
>  		return true;
>  	}
>  
> -	if (!strcmp(arg, "on")) {
> +	if (!strcmp(arg, "noalias")) {
>  		rodata_enabled = true;
>  		rodata_full = false;
>  		return true;


