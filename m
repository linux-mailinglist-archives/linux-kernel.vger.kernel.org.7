Return-Path: <linux-kernel+bounces-807330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D8B4A312
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8220D7ACAE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01714305065;
	Tue,  9 Sep 2025 07:11:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0502EB856
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401891; cv=none; b=IIOHwqrgxBMaVDYiC9/Ap12vQ4v/OsKfoGG1vwak4BJ4V1lRL5fDR2NZ9fufFGXCZ7Wrvl4RkDx7CSmv5UpL2hJP6UXj/l/xsCEsK9VmwZJgdMA33VILwW7MuW7wMjznejSr6UIxK74KnuX9AZnJpwNrW0w6fUG5NGOgt9MXPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401891; c=relaxed/simple;
	bh=EOg3b+nmkp7xWwnuuWBSDgB7U+I6D9JPAcRKjlRWa3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnINB6SXaZg0m/kC7iU+2HbW7ivs/EIkWYtjHXO7ZDuGnNVSQ0LKeG3XXO79GqFJ2RqdZwvrp4yxlmGf4LDOWzjTHtBkfAsTu/BkxCw+YheROsIDwKgc254HJM3t5QgDLr9T28sdBpt9vMSnFhM9caLu3yk17cNrkB4cymAjNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC68815A1;
	Tue,  9 Sep 2025 00:11:19 -0700 (PDT)
Received: from [10.163.72.34] (unknown [10.163.72.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AF733F63F;
	Tue,  9 Sep 2025 00:11:20 -0700 (PDT)
Message-ID: <949a4c77-06d8-4975-b81b-ea7df2babcb9@arm.com>
Date: Tue, 9 Sep 2025 12:41:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav
 <p.raghav@samsung.com>, Kiryl Shutsemau <kas@kernel.org>,
 kernel test robot <lkp@intel.com>
References: <20250905150012.93714-1-kernel@pankajraghav.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250905150012.93714-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/25 8:30 PM, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
> 
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.
> 
> Make all these functions return -EINVAL to indicate failure instead of
> 0. As large folios depend on CONFIG_THP, issue warning as this function
> should not be called without a large folio.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Kiryl Shutsemau <kas@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509051753.riCeG7LC-lkp@intel.com/
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Changes since v3:
>   - use VM_WARN_ON_ONCE_PAGE instead of the folio version in functions
>     that take a page.
> 
> Changes since v2:
>   - use page_folio(page) directly in VM_WARN_ON_ONCE_FOLIO
> 
>  include/linux/huge_mm.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..cd61d2b789ec 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -553,22 +553,26 @@ static inline int
>  split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>  		unsigned int new_order)
>  {
> -	return 0;
> +	VM_WARN_ON_ONCE_PAGE(1, page);
> +	return -EINVAL;
>  }
>  static inline int split_huge_page(struct page *page)
>  {
> -	return 0;
> +	VM_WARN_ON_ONCE_PAGE(1, page);
> +	return -EINVAL;
>  }
>  
>  static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
>  {
> -	return 0;
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> +	return -EINVAL;
>  }
>  
>  static inline int try_folio_split(struct folio *folio, struct page *page,
>  		struct list_head *list)
>  {
> -	return 0;
> +	VM_WARN_ON_ONCE_FOLIO(1, folio);
> +	return -EINVAL;
>  }
>  
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> 
> base-commit: e6b9dce0aeeb91dfc0974ab87f02454e24566182

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

