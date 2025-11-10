Return-Path: <linux-kernel+bounces-893890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B707C48970
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E1C44F41DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4991F330303;
	Mon, 10 Nov 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZronPL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71831BCBD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799367; cv=none; b=jPOTePTHVG5P5dhuNedZArmLDuqpNMptYdhZsT3Xp6N72epwDk/bSat8qTW2Tl74xBhEpy02rzflvxK8xlE63QcRwhwh7MnTYS6jZoDEuGbM+SeKybZBgavZpk8Nk6i4B6OAvKCEleNxR+2EksLA6nWTdhx1kyaAiVG/MuF7CGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799367; c=relaxed/simple;
	bh=vnrR8EFpufqGwq1f5pDV0cFkGbmnECjWMICT4b0JH7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb9xV94Zl9JXKfpLklSHBjCRiYEBH/fuAOds4klXmPKnKy4IK4ykp8EWnaFy/D7huCXO6m781h893eIWxqEz1C7J/HPiFvYUXk9uJGWgrivL3IvPHPPZSORSNuhKH+JcxNc4MaPvBuippxIs/Dqkob/ILju1yx+mk9tNV1xTcKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZronPL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14F8C116B1;
	Mon, 10 Nov 2025 18:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799367;
	bh=vnrR8EFpufqGwq1f5pDV0cFkGbmnECjWMICT4b0JH7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HZronPL2JFd0m3EVOakqveMN0/VpvlI0Hr9SxZxRe8KASYthT2jZ2rKJ6xHcVWGhc
	 jrN0x/CbOpU4mjGorNKiX6KhJ3JDEK5WB0WLC89Zn5ofFvyIeCX957WVtJULeMvaa0
	 b3nLdNd8JdoqI7mIfssUKcRqkXaIzFuiOrk+og9hcKbMg2zaQKqe+4wIxNzqZoOJdJ
	 4RZGLeGUxSfpeIsPT3if0GlEWFKrEcg/Ml0BmyJ9jUJo3R9PuZaelTy9OUZVlpeRL6
	 c9dmDjF2CBZxRwoVxEV2kr7vBXsL1MGp2OCry/K+K2WHLs5XASJR5dOBf4pjmZ1ITy
	 /y+tODM2PyvNA==
Message-ID: <760aef03-54c6-452e-b507-6210433f9943@kernel.org>
Date: Mon, 10 Nov 2025 19:29:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/madvise: allow guard page install/remove under
 VMA lock
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1762795245.git.lorenzo.stoakes@oracle.com>
 <cca1edbd99cd1386ad20556d08ebdb356c45ef91.1762795245.git.lorenzo.stoakes@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <cca1edbd99cd1386ad20556d08ebdb356c45ef91.1762795245.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 18:22, Lorenzo Stoakes wrote:
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
> We abstract the VMA lock validity logic to is_vma_lock_sufficient() for
> this purpose, and add prepares_anon_vma() to abstract the anon_vma logic.
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
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Looks good to me

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

