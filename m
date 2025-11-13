Return-Path: <linux-kernel+bounces-900075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C21C598E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D671E348533
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973E63101B2;
	Thu, 13 Nov 2025 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC0cZpHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3630F52B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059480; cv=none; b=atSdF5MP8ZeUrPcGKXHXsrqRuLB83ytI2LRzSGlUHwZD8zYXAGbCeRCCJFzQ0RNm26ZRhh+v6jmEXA+s6zwOqHXZx+0JpwGdLQkpZePatDN7tfdGpNtbqZk6ZQobgEJmdVXD1TOXELLOfOOLk27kttTi11E+NDZDra8CxP5FaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059480; c=relaxed/simple;
	bh=RE5P0X9RyxwuZjuBP8m4q0k+WYSIyGbR3hJ44uf4r7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pwkz69vaTBky/wT6T8EvvyTmsx6ymmwgRJ5uzyXhx1seqefQeTY9sPB16rypIsL1UgDGnE+tiZt0ykuSl0FbsUwde60BIUFIdblELCy5dngUPkyRwaBFz6sSlsCP1sHB2YUfNBXu3eo5ME/ibflNfd8l45fj3dOWMCT+0lGQy/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC0cZpHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9161C19421;
	Thu, 13 Nov 2025 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763059479;
	bh=RE5P0X9RyxwuZjuBP8m4q0k+WYSIyGbR3hJ44uf4r7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pC0cZpHvF6d0hLbVgoHS87+c6/lwBz35mdlUvl+etMUkoQnyYhzYKdq2Y6LU9nGsL
	 TyIbKCToQbXil/j7Hqc2snvjgEbSuvrBmloVgxHooOPwgNH+R0THEcYG4brJgOo6M8
	 bqZp04im0C6eLsy+xT+Mro2rnnIa+sLi32Njq6GAliFD2kKvOJkNmUSsSp6CSqWxjD
	 gXUyK8iE4eLp8CE7dWr+FSbvrhhoxms/LwucBVOTfQjAdZGyUEuJe5ycL/jzDB7B5G
	 c+urL7KgfK111uclHjIboI/TfOcSAS6d252bJxTcdqfHzq3R+2MwtEVtqZJeohqgxr
	 eCxQROZG94TZg==
Message-ID: <027b6ac9-836d-4f89-a819-e24d487f9c8e@kernel.org>
Date: Thu, 13 Nov 2025 19:44:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: fix MAX_FOLIO_ORDER on powerpc configs with
 hugetlb
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Donet Tom
 <donettom@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20251112145632.508687-1-david@kernel.org>
 <eaf2e733-f967-43bb-88e6-7876a28a370c@lucifer.local>
 <3fa6d496-b9de-4b66-a7db-247eebec92ca@kernel.org>
From: Christophe Leroy <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <3fa6d496-b9de-4b66-a7db-247eebec92ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/11/2025 à 16:21, David Hildenbrand (Red Hat) a écrit :
> On 13.11.25 14:01, Lorenzo Stoakes wrote:
> 
> [...]
> 
>>> @@ -137,6 +137,7 @@ config PPC
>>>       select ARCH_HAS_DMA_OPS            if PPC64
>>>       select ARCH_HAS_FORTIFY_SOURCE
>>>       select ARCH_HAS_GCOV_PROFILE_ALL
>>> +    select ARCH_HAS_GIGANTIC_PAGE        if ARCH_SUPPORTS_HUGETLBFS
>>
>> Given we know the architecture can support it (presumably all powerpc
>> arches or all that can support hugetlbfs anyway?), this seems reasonable.
> 
> powerpc allows for quite some different configs, so I assume there are 
> some configs that don't allow ARCH_SUPPORTS_HUGETLBFS.

Yes indeed. For instance the powerpc 603 and 604 have no huge pages.

> 
> [...]
> 
>>>   /*
>>>    * There is no real limit on the folio size. We limit them to the 
>>> maximum we
>>> - * currently expect (e.g., hugetlb, dax).
>>> + * currently expect: with hugetlb, we expect no folios larger than 
>>> 16 GiB.
>>
>> Maybe worth saying 'see CONFIG_HAVE_GIGANTIC_FOLIOS definition' or 
>> something?
> 
> To me that's implied from the initial ifdef. But not strong opinion 
> about spelling that out.
> 
>>
>>> + */
>>> +#define MAX_FOLIO_ORDER        get_order(SZ_16G)
>>
>> Hmm, is the base page size somehow runtime adjustable on powerpc? Why 
>> isn't
>> PUD_ORDER good enough here?
> 
> We tried P4D_ORDER but even that doesn't work. I think we effectively 
> end up with cont-pmd/cont-PUD mappings (or even cont-p4d, I am not 100% 
> sure because the folding code complicates that).
> 
> See powerpcs variant of huge_pte_alloc() where we have stuff like
> 
> p4d = p4d_offset(pgd_offset(mm, addr), addr);
> if (!mm_pud_folded(mm) && sz >= P4D_SIZE)
>      return (pte_t *)p4d;
> 
> As soon as we go to things like P4D_ORDER we're suddenly in the range of 
> 512 GiB on x86 etc, so that's also not what we want as an easy fix. (and 
> it didn't work)
> 

On 32 bits there are only PGDIR et Page Table,

PGDIR_SHIFT = P4D_SHIFT = PUD_SHIFT = PMD_SHIFT

For instance on powerpc 8xx,
PGDIR_SIZE is 4M
Largest hugepage is 8M.

So even PGDIR_ORDER isn't enough.

Christophe

