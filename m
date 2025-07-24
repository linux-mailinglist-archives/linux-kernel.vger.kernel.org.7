Return-Path: <linux-kernel+bounces-743627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1DDB1010B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640F51CC59CF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478C3221F34;
	Thu, 24 Jul 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiyeNwW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8584BA36
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339657; cv=none; b=hXum434B2aIvE73zDTKPS9fDa+9Dw2BW1uVyhWWC5Zn8/vM5M4RvNqO2H+tdx/Fj1xW2AjcwrfqKWzhT/rin5APCduPDvUw6cIdGGuZH1ksx649q+RVXXqaR6218WdFy6pPzIVbp5KrzzKxMMVa5HmoRfYutSRVNs1V1u2RkaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339657; c=relaxed/simple;
	bh=csTsbkp93NJRtM4YbopZiMpO/7B2FNB1bYVQvq4Gu8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erzvq3cMeOgGPAgHfPiMFH8qiXHMURxUDE4ZkrN5zOuxSS+lxAc9QVJwpdNg4AwRUC9+8e1lMnacUOUSYl9CSCHVhWsc9Yi4k3z0Az9varNhb4yC82NndelgzNuuLNYGy7fAaCSPGdNaY/P6S6zfkxfCWz7HNp8XUKkIsjj4IWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiyeNwW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C39FC4CEF1;
	Thu, 24 Jul 2025 06:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753339657;
	bh=csTsbkp93NJRtM4YbopZiMpO/7B2FNB1bYVQvq4Gu8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiyeNwW9FSXVQdf4EQIVZt5/CPNXF5UMFZvCWr4eXLRAEYT/QVUbSIL6Yn8BxFDfB
	 APMYAPa9KV5RKE4rOUMR60FhZQuZWKMNRfHF2LsW4nfglewY4O4/bnyU4XcQR/DYMU
	 FP2UNyPz58ah+A2siP1KKh6qJPrUYZovswwCSXMTz9OeGGDIfF7tnkEzR6AqnL48l2
	 kJNL5ORY4Bg7SuXvcsYsC1+kER29kfT4O0lsyCRc73L58wNWEq0w9J0GdxIfZQLdnb
	 GidBmwLI0QEl4x+mR2E29CADPKupMoF/T2EOd5XcGXlCZcdv+ISbHe9lDlrLUkdbzA
	 S52eZLseracTQ==
Date: Thu, 24 Jul 2025 09:47:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>
Cc: Francois Dugast <francois.dugast@intel.com>, airlied@gmail.com,
	akpm@linux-foundation.org, apopple@nvidia.com, baohua@kernel.org,
	baolin.wang@linux.alibaba.com, dakr@kernel.org, david@redhat.com,
	donettom@linux.ibm.com, jane.chu@oracle.com, jglisse@redhat.com,
	kherbst@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lyude@redhat.com, peterx@redhat.com,
	ryan.roberts@arm.com, shuah@kernel.org, simona@ffwll.ch,
	wangkefeng.wang@huawei.com, willy@infradead.org, ziy@nvidia.com,
	Balbir Singh <balbirs@nvidia.com>, jgg@nvidia.com
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by
 the caller
Message-ID: <20250724064732.GQ402218@unreal>
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
 <023ab16d-f3af-487e-a7ce-929bf7b2fe3e@nvidia.com>
 <aIG+gqY2YRqBeKlh@lstrano-desk.jf.intel.com>
 <dad71615-0eba-4a8d-abfc-979fb815511c@redhat.com>
 <aIHLWnjzKWma1NLC@lstrano-desk.jf.intel.com>
 <368fa1c1-fccc-445d-bd22-0053fd2db29c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <368fa1c1-fccc-445d-bd22-0053fd2db29c@redhat.com>

On Thu, Jul 24, 2025 at 09:04:36AM +0300, Mika Penttilä wrote:
> 
> On 7/24/25 08:57, Matthew Brost wrote:
> > On Thu, Jul 24, 2025 at 08:46:11AM +0300, Mika Penttilä wrote:
> >> On 7/24/25 08:02, Matthew Brost wrote:
> >>> On Thu, Jul 24, 2025 at 10:25:11AM +1000, Balbir Singh wrote:
> >>>> On 7/23/25 05:34, Francois Dugast wrote:
> >>>>> When the PMD swap entry is device private and owned by the caller,
> >>>>> skip the range faulting and instead just set the correct HMM PFNs.
> >>>>> This is similar to the logic for PTEs in hmm_vma_handle_pte().
> >>>>>
> >>>>> For now, each hmm_pfns[i] entry is populated as it is currently done
> >>>>> in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> >>>>> optimization could be to make use of the order and skip populating
> >>>>> subsequent PFNs.
> >>>> I think we should test and remove these now
> >>>>
> >>> +Jason, Leon – perhaps either of you can provide insight into why
> >>> hmm_vma_handle_pmd fully populates the HMM PFNs when a higher-order page
> >>> is found.
> >>>
> >>> If we can be assured that changing this won’t break other parts of the
> >>> kernel, I agree it should be removed. A snippet of documentation should
> >>> also be added indicating that when higher-order PFNs are found,
> >>> subsequent PFNs within the range will remain unpopulated. I can verify
> >>> that GPU SVM works just fine without these PFNs being populated.
> >> afaics the device can consume the range as smaller pages also, and some
> >> hmm users depend on that.
> >>
> > Sure, but I think that should be fixed in the device code. If a
> > large-order PFN is found, the subsequent PFNs can clearly be inferred.
> > It's a micro-optimization here, but devices or callers capable of
> > handling this properly shouldn't force a hacky, less optimal behavior on
> > core code. If anything relies on the current behavior, we should fix it
> > and ensure correctness.
> 
> Yes sure device code can be changed but meant to say we can't just
> delete those lines without breaking existing users.

Mika is right. RDMA subsystem and HMM users there need to be updated.

We have special flag (IB_ACCESS_HUGETLB) that prepare whole RDMA stack
to handle large order PFNs. If this flag is not provided, we need to
fallback to basic device page size (4k) and for that we expect fully
populated PFN list.

Thanks

