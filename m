Return-Path: <linux-kernel+bounces-822781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFEB84A87
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1B53B0717
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079872FD1B6;
	Thu, 18 Sep 2025 12:48:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DC1D416E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199715; cv=none; b=UKyuZdK3d0LKd2V34odvxXhXDP5MiwEUu4mhkZ6dqWqvUyZHLTcd5cluFvpv/AJyk1GFGZndrgQpqfRSSQm65j1R8nW7irqNvNU8EGWAI+dwgRsBQz+a6T17cA5RpRWWnUiOHBfdR3o8iTh2NZzRoEUUbodfzkkG2mdwV77ylik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199715; c=relaxed/simple;
	bh=CSCTh5dh5EwW5bvk1b3fFpJTWVywrby9NozpUVBF4Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYnsneErrjvayB5WnN9GyWpL58E074M+rXNw+5WMK7l+fGQiUxOL2jJBZH0GpcRjEoCOj31J+T9HfUDNTnlvdZWGt7GgfOyJJMQoD0QHzTbi+9lAQaCxtLrJXtp7z03POByi09R9e2RppMoBHqzT/xioxvgo2xvPtU4BcyQbUiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC16C4CEE7;
	Thu, 18 Sep 2025 12:48:32 +0000 (UTC)
Date: Thu, 18 Sep 2025 13:48:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, ryan.roberts@arm.com, akpm@linux-foundation.org,
	david@redhat.com, lorenzo.stoakes@oracle.com, ardb@kernel.org,
	dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 5/5] arm64: kprobes: call set_memory_rox() for kprobe
 page
Message-ID: <aMv_nhEuCSHKp5J6@arm.com>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-6-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917190323.3828347-6-yang@os.amperecomputing.com>

On Wed, Sep 17, 2025 at 12:02:11PM -0700, Yang Shi wrote:
> The kprobe page is allocated by execmem allocator with ROX permission.
> It needs to call set_memory_rox() to set proper permission for the
> direct map too. It was missed.
> 
> And the set_memory_rox() guarantees the direct map will be split if it
> needs so that set_direct_map calls in vfree() won't fail.
> 
> Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>  arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> index 0c5d408afd95..c4f8c4750f1e 100644
> --- a/arch/arm64/kernel/probes/kprobes.c
> +++ b/arch/arm64/kernel/probes/kprobes.c
> @@ -10,6 +10,7 @@
>  
>  #define pr_fmt(fmt) "kprobes: " fmt
>  
> +#include <linux/execmem.h>
>  #include <linux/extable.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
> @@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>  static void __kprobes
>  post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
>  
> +void *alloc_insn_page(void)
> +{
> +	void *page;

Nit: I'd call this 'addr'. 'page' makes me think of a struct page.

> +
> +	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
> +	if (!page)
> +		return NULL;
> +	set_memory_rox((unsigned long)page, 1);

It's unfortunate that we change the attributes of the ROX vmap first to
RO, then to back to ROX so that we get the linear map changed. Maybe
factor out some of the code in change_memory_common() to only change the
linear map.

Otherwise it looks fine.

-- 
Catalin

