Return-Path: <linux-kernel+bounces-896934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA0FC51992
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A52B3ABF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDED30146D;
	Wed, 12 Nov 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipFvEp/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F4C2798EA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942196; cv=none; b=fFXmedNNKvOw9KsgxShheaAPDbbLI1yzjQivwYnSNBUTLTXfGFgZGYdNUXRaSxmdERrXGNPAzxT8iSEZFogMVWIEL3ZMQMB/jxyP1WyEUo4jf0em/5zptD94Kp6KBDVKh7xWwoCepySj3Qk0Pvk8qNdXgjo5kmLVCoTLvUno9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942196; c=relaxed/simple;
	bh=0pN/N/WAEGV8G73wqQYsy1NYVE302SNrvtLisTX/RFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmpE3JAjztgjP0HNmE8F6xdbd4PfBNzbA6A1ZmdD05mG5+pM3BgdGEerMx/wm6ymu/Gzazc9t9ykerm1C3yQnBS2//Ir5AghVXVzqOd6CbQ2pHT+jk6iK8TuH9wUgX3YHnJ9QEtBqG9h+xXIhDY7+BT5aEUum/8fij9/9VmvDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipFvEp/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF3C116B1;
	Wed, 12 Nov 2025 10:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762942196;
	bh=0pN/N/WAEGV8G73wqQYsy1NYVE302SNrvtLisTX/RFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ipFvEp/hfILLkxsY+k06HidEsIf8ffPVLU466T+rWPF18sHN42s39t8W5OlLwF0z/
	 lr6PIvS4/3zfBmi0nnpAHZRlwFz2ly+RoNeUYXVCNUdKXZTsZc9kcl/xUvxsPhu0+J
	 WHC/KK9Hbx/fSQdNJOTteV9VznFF964AGjiNI9PO2E0mPbDodJPtvQ0fjF+m+fE4eX
	 4PqWdflNQCw4yhQbbtfxOd7ka/AMObTnz//MZaOqv/Rslr4pKDUgL7FkRa4MdHD2/U
	 cJHKybdmQJuqzbjMmpd7LA7Zx0JYL6YpTKPnzkEfFAw1NqiMcVHk4e5kbLuGSHqzoK
	 zf40DMoPvzYYw==
Message-ID: <6a63dbb8-58f7-4511-8090-18a58c3206d8@kernel.org>
Date: Wed, 12 Nov 2025 11:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
To: Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, baolin.wang@linux.alibaba.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
References: <20251112031631.2315651-1-kartikey406@gmail.com>
 <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com>
 <aRRPvn4DYAhuGtq3@localhost.localdomain>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <aRRPvn4DYAhuGtq3@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.25 10:13, Oscar Salvador wrote:
> On Tue, Nov 11, 2025 at 10:55:03PM -0800, Hugh Dickins wrote:
>> Thanks a lot, Deepanshu and syzbot: this sounds horrid, and important
>> to fix very soon; and wlll need a Fixes tag (with stable Cc'ed when
>> the fix goes into mm.git), I presume it's
>>
>> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>>
>> But although my name appears against mm/memfd.c, the truth is I know
>> little of hugetlb (maintainers now addressed), and when its folios
>> are supposed to get zeroed (would a __GFP_ZERO somewhere be better?).
>>
>> I was puzzled by how udmabuf came into the picture, since hugetlbfs
>> has always supported the read (not write) system call: but see now
>> that there is this surprising backdoor into the hugetlb subsystem,
>> via memfd and GUP pinning.
>>
>> And where does that folio get marked uptodate, or is "uptodate"
>> irrelevant on hugetlbfs?  Are the right locks taken, or could
>> there be races when adding to hugetlbfs cache in this way?
> 
> Thanks Hugh for raising this up.
> 
> memfd_alloc_folio() seems to try to recreate what hugetlb_no_page()
> would do (slightly different though).

Can we factor that out to merge both paths?

> 
> The thing is that as far as I know, we should grab hugetlb mutex before
> trying to add a new page in the pagecache, per comment in
> hugetlb_fault():
> 
>   "
>     /*
>      * Serialize hugepage allocation and instantiation, so that we don't
>      * get spurious allocation failures if two CPUs race to instantiate
>      * the same page in the page cache.
>      */
>   "
> 
> and at least that is what all callers of hugetlb_add_to_page_cache() do
> at this moment, all except memfd_alloc_folio(), so I guess this one
> needs fixing.
> 
> Regarding the uptodate question, I do not see what is special about this situation
> that we would not need it.
> We seem to be marking the folio uptodate every time we do allocate a folio __and__
> before adding it into the pagecache (which is expected, right?).

Right, at least filemap.c heavily depends on it being set (I don't think 
hugetlb itself needs it).

> 
> Now, for the GFP_ZERO question.
> This one is nasty.
> hugetlb_reserve_pages() will allocate surplus folios without zeroing, but those
> will be zeroed in the faulting path before mapping them into userspace pagetables
> (see folio_zero_user() in hugetlb_no_page()).
> So unless I am missing something we need to zero them in this case as well.

I assume we want to avoid GFP_ZERO and use folio_zero_user(), which is 
optimized for zeroing huge/gigantic pages.


-- 
Cheers

David

