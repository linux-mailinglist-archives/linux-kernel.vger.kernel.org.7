Return-Path: <linux-kernel+bounces-839302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AB5BB14C5
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF487ADA71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEB027F000;
	Wed,  1 Oct 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrLf9AbQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AA223DD1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759337484; cv=none; b=S4fd3Eh81jfRB53PvOFBRMfVkjDg8OVn1LLafNKEbacHcCthTeS6rfP13ud5fwHN/d4IahnmO8E12MdLvFGdN7g+n2GzpczpbCLi2pPAqChnxgfANpp6jKUlKfltuz103i35zEzTqyc/4EHx5olj1ETQ8vQdaxWmxuYNS20Xd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759337484; c=relaxed/simple;
	bh=sq47SPnNubBaOrDYNmqLZOFhbgnhc5uNep+QUZv1fr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QueLyVPO9w4j8RaE9ph+Py7f5iYn0a0ABxFaAcDffLy0Ta4/Th1lIVpCB1ULhROpN2AAPZQzg8lDorxTHrVWKMLEhPYynGwnyS5Nt79un9ovhX4whsUioShjNH7ZOpNwcDuVVkEwpcymc3IGKrIJRnJpeqcPMYFxyMWU78vvgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrLf9AbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757A3C4CEF1;
	Wed,  1 Oct 2025 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759337483;
	bh=sq47SPnNubBaOrDYNmqLZOFhbgnhc5uNep+QUZv1fr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrLf9AbQ0lrvaZltk4zWolRVs+DxIrNghRLqz+NqgIY+KLEdCzqdVHtQSe+jmUWxe
	 DF3qJ27ROq6HsizQbqkhxWz5IshERT8hP0rw7siC50Sk5cfmuezbfpqPBoyLcX17sD
	 J3rtaKGevmQDXOFNmKx7U5s4S30BSI4Mx9MZACFtQTRYds+Z8HVTbWTDX74slWOhFD
	 RoEtEG5B+Hn0EvNxtz903vreJVeXqw//T6ndav7vRRwy0pRCn+1q4JzKusExjbHDmW
	 JG1esOFkVb0Cql53UuxMgTPc6BMoxBk5SKrAXBl/Dm2bX1VGDUOekA7E3w4SlxJ0Dk
	 +H1ICsR4Ik2jQ==
From: SeongJae Park <sj@kernel.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	peterx@redhat.com,
	axelrasmussen@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: redefine VM_* flag constants with BIT()
Date: Wed,  1 Oct 2025 09:51:21 -0700
Message-Id: <20251001165121.54258-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251001090353.57523-3-acsjakub@amazon.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 1 Oct 2025 09:03:53 +0000 Jakub Acs <acsjakub@amazon.de> wrote:

> Make VM_* flag constant definitions consistent - unify all to use BIT()
> macro.
> 
> This is a separete follow-up fix after we changed VM_MERGEABLE
> separately to isolate bugfix for easier backporting. As suggested by
> David in [1]. 
> 
> [1]: https://lore.kernel.org/all/85f852f9-8577-4230-adc7-c52e7f479454@redhat.com/
> 
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mm.h | 66 +++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c6794d0e24eb..88cab3d7eea2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -246,56 +246,56 @@ extern unsigned int kobjsize(const void *objp);
>   * vm_flags in vm_area_struct, see mm_types.h.
>   * When changing, update also include/trace/events/mmflags.h
>   */
> -#define VM_NONE		0x00000000
> +#define VM_NONE		0

I'm wondering if it could be more consistent to use 0UL instead.

>  
> -#define VM_READ		0x00000001	/* currently active flags */
> -#define VM_WRITE	0x00000002
> -#define VM_EXEC		0x00000004
> -#define VM_SHARED	0x00000008
> +#define VM_READ		BIT(0)		/* currently active flags */
> +#define VM_WRITE	BIT(1)
> +#define VM_EXEC		BIT(2)
> +#define VM_SHARED	BIT(3)
>  
>  /* mprotect() hardcodes VM_MAYREAD >> 4 == VM_READ, and so for r/w/x bits. */
> -#define VM_MAYREAD	0x00000010	/* limits for mprotect() etc */
> -#define VM_MAYWRITE	0x00000020
> -#define VM_MAYEXEC	0x00000040
> -#define VM_MAYSHARE	0x00000080
> +#define VM_MAYREAD	BIT(4)		/* limits for mprotect() etc */
> +#define VM_MAYWRITE	BIT(5)
> +#define VM_MAYEXEC	BIT(6)
> +#define VM_MAYSHARE	BIT(7)
>  
> -#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
> +#define VM_GROWSDOWN	BIT(8)		/* general info on the segment */
>  #ifdef CONFIG_MMU
> -#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
> +#define VM_UFFD_MISSING	BIT(9)		/* missing pages tracking */
>  #else /* CONFIG_MMU */
> -#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> +#define VM_MAYOVERLAY	BIT(10)		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */

s/10/9/ ?

>  #define VM_UFFD_MISSING	0
>  #endif /* CONFIG_MMU */
> -#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> -#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
> +#define VM_PFNMAP	BIT(11)		/* Page-ranges managed without "struct page", just pure PFN */

s/11/10/ ?

> +#define VM_UFFD_WP	BIT(12)		/* wrprotect pages tracking */
>  
> -#define VM_LOCKED	0x00002000
> -#define VM_IO           0x00004000	/* Memory mapped I/O or similar */
> +#define VM_LOCKED	BIT(13)
> +#define VM_IO           BIT(14)		/* Memory mapped I/O or similar */
>  
>  					/* Used by sys_madvise() */
> -#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
> -#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
> -
> -#define VM_DONTCOPY	0x00020000      /* Do not copy this vma on fork */
> -#define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
> -#define VM_LOCKONFAULT	0x00080000	/* Lock the pages covered when they are faulted in */
> -#define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
> -#define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
> -#define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
> -#define VM_SYNC		0x00800000	/* Synchronous page faults */
> -#define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
> -#define VM_WIPEONFORK	0x02000000	/* Wipe VMA contents in child. */
> -#define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
> +#define VM_SEQ_READ	BIT(15)		/* App will access data sequentially */
> +#define VM_RAND_READ	BIT(16)		/* App will not benefit from clustered reads */
> +
> +#define VM_DONTCOPY	BIT(17)		/* Do not copy this vma on fork */
> +#define VM_DONTEXPAND	BIT(18)		/* Cannot expand with mremap() */
> +#define VM_LOCKONFAULT	BIT(19)		/* Lock the pages covered when they are faulted in */
> +#define VM_ACCOUNT	BIT(20)		/* Is a VM accounted object */
> +#define VM_NORESERVE	BIT(21)		/* should the VM suppress accounting */
> +#define VM_HUGETLB	BIT(22)		/* Huge TLB Page VM */
> +#define VM_SYNC		BIT(23)		/* Synchronous page faults */
> +#define VM_ARCH_1	BIT(24)		/* Architecture-specific flag */
> +#define VM_WIPEONFORK	BIT(25)		/* Wipe VMA contents in child. */
> +#define VM_DONTDUMP	BIT(26)		/* Do not include in the core dump */
>  
>  #ifdef CONFIG_MEM_SOFT_DIRTY
> -# define VM_SOFTDIRTY	0x08000000	/* Not soft dirty clean area */
> +# define VM_SOFTDIRTY	BIT(27)		/* Not soft dirty clean area */
>  #else
>  # define VM_SOFTDIRTY	0
>  #endif
>  
> -#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
> -#define VM_HUGEPAGE	0x20000000	/* MADV_HUGEPAGE marked this vma */
> -#define VM_NOHUGEPAGE	0x40000000	/* MADV_NOHUGEPAGE marked this vma */
> +#define VM_MIXEDMAP	BIT(28)		/* Can contain "struct page" and pure PFN pages */
> +#define VM_HUGEPAGE	BIT(29)		/* MADV_HUGEPAGE marked this vma */
> +#define VM_NOHUGEPAGE	BIT(30)		/* MADV_NOHUGEPAGE marked this vma */
>  #define VM_MERGEABLE	BIT(31)		/* KSM may merge identical pages */
>  
>  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> -- 
> 2.47.3


Thanks,
SJ

[...]

