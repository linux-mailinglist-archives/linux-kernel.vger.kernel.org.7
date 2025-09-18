Return-Path: <linux-kernel+bounces-822492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28FB84056
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BE81C82875
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716662F7442;
	Thu, 18 Sep 2025 10:13:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC810F1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190396; cv=none; b=P0/TjBMw8gpcSF3/tIY8Kr7eTkD930Bj2bsuSU7p2GxIEFUk/Ic/7VF/yAEMgd8ZV+mOmjhZnGztkzJDiuXVENNRMkKuWOBZVl0SUNxtA4JT9IdHcIQ3ULtMcfRazWEiuRnJLel7few6q5GX34nl8w3DAv6HEqYTMfHELQjeyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190396; c=relaxed/simple;
	bh=Vo4S8nMksme7gP+SBjztPTrSXHOnZau6V4Sr34jrOO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqWvG+G0hhgtSu1PO8QLa9KNCW4QM8pgZSYgEi5OrR0daBftuJjgX7Nc078qfprpRrwyz4xqHLHl0ZRmtTBVA3Li+qgqN1DPynhLFB2Gk4r2Lt5YAy9TxIM+GchhqLHQCsjvvROqXvQv1yI8si0CFGELvX6mp70lzRwH3BUEfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86177C4CEE7;
	Thu, 18 Sep 2025 10:13:12 +0000 (UTC)
Date: Thu, 18 Sep 2025 11:13:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Yin Fengwei <fengwei_yin@linux.alibaba.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
Message-ID: <aMvbNvCsSxQjA2rq@arm.com>
References: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
 <20250915032946.33203-3-ying.huang@linux.alibaba.com>
 <46dcddec-88a9-4b22-920c-8a3edeb2f027@arm.com>
 <87o6r833li.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6r833li.fsf@DESKTOP-5N7EMDA>

On Thu, Sep 18, 2025 at 10:18:49AM +0800, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> > contpte_ptep_set_access_flags() currently does a (broadcast) __flush_tlb_range()
> > on the (pte_write(orig_pte) == pte_write(entry)) path. I think that should be
> > changed to a local range invalidation to be consistent with this change.
> 
> Yes.  This should be changed too.  However, it means we need a local
> variant of __flush_tlb_range() and flush_tlb_mm().  Is it OK to
> introduce them first and tidy up later?

If it's just for contpte, we'd never take the flush_tlb_mm() path. So we
could instead add a specific local_flush_tlb_contpte_range().

-- 
Catalin

