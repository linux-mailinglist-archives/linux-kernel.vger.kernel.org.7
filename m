Return-Path: <linux-kernel+bounces-893537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 368E5C47BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542FD4F4D35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDE314D3D;
	Mon, 10 Nov 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F47izqIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8B2727FC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789490; cv=none; b=Q+R63hmrci0U2BO8LdOBrKrR5Ws04p+hByTnOCcinvcT05sjGGbfBgPQ46xIM9Gcjwy+Rg8Hv3R0L/zUei0Q9C2zzGtzmhTN7sQp+aLPmEwIhbE2DUo/VNaeobxPam2Y8XnRD0CvbOt8tFBCZ2KhU2339MrSbwXHVKb26eahP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789490; c=relaxed/simple;
	bh=7ECB/Epw4N8G0fPSAf9HzVlYqXXeRmVNo6f6Ug/7m+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0E4KDy+uXzbhgxAuC44S/lfr/nmiYrU2VMjmHEPk6QwKq8/M9I2Yz75evLiGZRC+qpiV4/RTb+2Qk7Z0VTyjqWHxl7IybZ9PXimi2+LKqmlJgYW+R8t5Qhj7hkwkrRzg0Qa9nHwecK5KZhsJIe1zWBpTVPgHn132SVTnMaZiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F47izqIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB80C4CEF5;
	Mon, 10 Nov 2025 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789490;
	bh=7ECB/Epw4N8G0fPSAf9HzVlYqXXeRmVNo6f6Ug/7m+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F47izqIvDYv7w+GY/eGCtiRSRXvcX9+lbgTTRYtjo7OHpHNCi5gNSTxeJ1ehecWxs
	 QhEjvAJZWHBeO2YXuPRtZh8595tI11T+oBLryABPoc+HvAuxDmEAnmgVHs1ZLHGN7q
	 ex65oUEqxy2tO9KiKVp9fBleF62FCWu9uvgjA/DPOgj4cpQpDBIIhEO3mcXL90WeXt
	 +94jklpOLg1RAAhmMZmuQoFzI8wttAWhsrirxzhEIXUWk3jWHehXEehpGRUkHbYzv7
	 QvyniMWauBnYre+wYVHQPrHW2JQ4wQn+PaLRNcIAu1u5/2/ucyVvf3dbkDjEWNLI50
	 6Ykabp5DrdXTg==
Message-ID: <a65dcd48-d3aa-4372-9c58-2278fc161b68@kernel.org>
Date: Mon, 10 Nov 2025 16:44:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/madvise: allow guard page install/remove under VMA
 lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1762686301.git.lorenzo.stoakes@oracle.com>
 <d246c206e2df45cf15ccfeb33124809dafbe1eba.1762686301.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <d246c206e2df45cf15ccfeb33124809dafbe1eba.1762686301.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.11.25 12:16, Lorenzo Stoakes wrote:
> We only need to keep the page table stable so we can perform this operation
> under the VMA lock. PTE installation is stabilised via the PTE lock.
> 
> One caveat is that, if we prepare vma->anon_vma we must hold the mmap read
> lock. We can account for this by adapting the VMA locking logic to
> explicitly check for this case and prevent a VMA lock from being acquired
> should it be the case.
> 
> This check is safe, as while we might be raced on anon_vma installation,
> this would simply make the check conservative, there's no way for us to see
> an anon_vma and then for it to be cleared, as doing so requires the
> mmap/VMA write lock.
> 
> We abstract the VMA lock validity logic to is_vma_lock_valid() for this
> purpose, and add prepares_anon_vma() to abstract the anon_vma logic.
> 
> In order to do this we need to have a way of installing page tables
> explicitly for an identified VMA, so we export walk_page_range_vma() in an
> unsafe variant - walk_page_range_vma_unsafe() and use this should the VMA
> read lock be taken.
> 
> We additionally update the comments in madvise_guard_install() to more
> accurately reflect the cases in which the logic may be reattempted,
> specifically THP huge pages being present.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

[...]

> 
> +/* Does this operation invoke anon_vma_prepare()? */
> +static bool prepares_anon_vma(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_GUARD_INSTALL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/*
> + * We have acquired a VMA read lock, is the VMA valid to be madvise'd under VMA
> + * read lock only now we have a VMA to examine?
> + */
> +static bool is_vma_lock_valid(struct vm_area_struct *vma,
> +		struct madvise_behavior *madv_behavior)


Not sure about the "valid" terminology here.

Would "is_vma_lock_sufficient" be a better name, that would imply when 
"false" that another lock is required, because the VMA lock is insufficient?


-- 
Cheers

David

