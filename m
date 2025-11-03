Return-Path: <linux-kernel+bounces-883440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54537C2D76D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7641887FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F93431AF22;
	Mon,  3 Nov 2025 17:26:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A1826AA88
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190804; cv=none; b=PYex6TY7Q4GLgk2j3wuqm75vR90LL72HCm/tv1GFIDiAhqWIDi5/3LdDex2EQbuMhMSlmCTMhv6+jPzg68t8TuyBhdVX4gnvICC9O7tzYx0CdzG6slpBO1y2RrY5jS3T2x1nhWpYUGv8MeMyjUyy2ax9vk+vd4rZM5EQRP54KC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190804; c=relaxed/simple;
	bh=Ots5AR48JHSxZj3bul/uTIGyMsHRJiHUllSeE5+DSNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP8lG/mUw4OubrCInEfuZFJUHVFU7QMihyS97vK6adq1lchCwyzZptwBHgXuOAvyVB6IysOoOxDoxE3adYyZG2Mjkd38SOSgaCGKmqjl3D+zBw09zi/4XMQHUl9e/eMnHoIF/T5CX/nNDY11cIRZiZ8NpJt6abprV0Q3yhvZ9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BBF31D14;
	Mon,  3 Nov 2025 09:26:33 -0800 (PST)
Received: from arm.com (unknown [10.1.25.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23C253F66E;
	Mon,  3 Nov 2025 09:26:40 -0800 (PST)
Date: Mon, 3 Nov 2025 17:26:37 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH] arch/arm64/mm/fault: Implement exceptions tracepoints
Message-ID: <aQjlzbkdzzYL2xJR@arm.com>
References: <20251013035532.1793181-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013035532.1793181-1-balbirs@nvidia.com>

On Mon, Oct 13, 2025 at 02:55:32PM +1100, Balbir Singh wrote:
> x86 and riscv provide trace points for page-faults (user and kernel
> tracepoints). Some scripts [1],[2] rely on these trace points. The
> tracepoint is useful for tracking faults and their reasons.
> 
> Adding the tracepoints is simple and straight-forward. For arm64
> use esr as error code and untagged memory address as addr.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> 
> [1] https://www.brendangregg.com/FlameGraphs/memoryflamegraphs.html
> [2] https://taras.glek.net/posts/ebpf-mmap-page-fault-tracing/
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
> 
> Tested at my end with a kernel-compile and running a user space
> program to check that the trace points are indeed reported.
> 
>  arch/arm64/mm/fault.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index d816ff44faff..9d7b86e92434 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -44,6 +44,9 @@
>  #include <asm/tlbflush.h>
>  #include <asm/traps.h>
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/exceptions.h>
> +
>  struct fault_info {
>  	int	(*fn)(unsigned long far, unsigned long esr,
>  		      struct pt_regs *regs);
> @@ -572,8 +575,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (faulthandler_disabled() || !mm)
>  		goto no_context;
>  
> -	if (user_mode(regs))
> +	if (user_mode(regs)) {
>  		mm_flags |= FAULT_FLAG_USER;
> +		trace_page_fault_user(addr, regs, esr);
> +	} else {
> +		trace_page_fault_kernel(addr, regs, esr);
> +	}

This has come up before and rejected:

https://lore.kernel.org/all/aG0aIKzxApp9j7X0@willie-the-truck/

-- 
Catalin

