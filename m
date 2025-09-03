Return-Path: <linux-kernel+bounces-799288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5192B42999
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A627B10CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32B2D8798;
	Wed,  3 Sep 2025 19:15:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8F27A900
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926929; cv=none; b=FWBcvDW9NT5WbvEDr/MI3/vqPgFPqeCqXPH98akcaxhsR1aa2zX07p9MfaFY5XIsu/6DOZqjd+HujeZuqn2QeizW9Cj9P+UUc/pFiYzZyHnJoszmjQSVmr+UrIPYI8pcEbba0K7gGEwUYXdops1xUduLzE/ZFjp7ROEggbXNc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926929; c=relaxed/simple;
	bh=8ZantAMwHAfo7UwZPXPk0uYK3UyLAM6zpL3QhoNQEaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMQUbkLm44yG/z4DgUFrbCyOHMNS3vv03vb2rTfduqoUO4c++RHu3/0LS9vaO1M+BvYdNLZTzod/RgLyxkNvTHiu2/YAFQ0GZa2vL800cj5mq0/wSFdZesIKncm9f5x2VJpv2NISmZAcgJImtuKVdOIPGS6gzx7sfrNxF9IhqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB42C4CEE7;
	Wed,  3 Sep 2025 19:15:26 +0000 (UTC)
Date: Wed, 3 Sep 2025 20:15:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v7 3/6] arm64: mm: support large block mapping when
 rodata=full
Message-ID: <aLiTzJ6E-YBIYuGo@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-4-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829115250.2395585-4-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 12:52:44PM +0100, Ryan Roberts wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 34e5d78af076..114b88216b0c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -481,6 +481,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>  			     int flags);
>  #endif
>  
> +#define INVALID_PHYS_ADDR	-1

Nitpick: (-1UL) (or (-1ULL), KVM_PHYS_INVALID is defined as the latter).

Otherwise the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

