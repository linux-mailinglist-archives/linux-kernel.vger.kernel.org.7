Return-Path: <linux-kernel+bounces-744224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6044B109C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117385A4F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB32BE7B8;
	Thu, 24 Jul 2025 11:58:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E42BE65D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358328; cv=none; b=u4j/rF12tcjOkyE+x0xXN3wk3BffJ5SpaHfTpYidFzY/WIQve+k09uI39uh1clpDP312aVTC4NvQAmmWtNOJVNuxZb+Htt628uVC6XkcmUEjJrvQWUZYHoLu+KvnP+zxgarkmkIbVCisRvn74KEPNTT9uOgPAZ29yCmPmN9vb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358328; c=relaxed/simple;
	bh=RRIAlM96U+2IbU+dQ21kVbmm9VezsqNkVUy2nIzQZkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6CPeoowqEtBat27p9fTWBsN577Tv3AVzUjOAuxAO2tLpYgQz8E4G2R6cpQB+9lVdWl8LDr1eINrX/SyGg+txO+OQPG3RmBdBHIiErv/5OaKDFE8FYAlyM0v9UNCBdkPD6ZnU2ogKxlRtq9nPmAl4MOfyldJ8dGu9Y6CZiBU/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A45DC4CEED;
	Thu, 24 Jul 2025 11:58:44 +0000 (UTC)
Date: Thu, 24 Jul 2025 12:58:41 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, will@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	suzuki.poulose@arm.com, steven.price@arm.com, gshan@redhat.com,
	linux-arm-kernel@lists.infradead.org, yang@os.amperecomputing.com,
	ryan.roberts@arm.com, anshuman.khandual@arm.com
Subject: Re: [PATCH v4] arm64: Enable permission change on arm64 kernel block
 mappings
Message-ID: <aIIf8Q7EVsQ5MGOX@arm.com>
References: <20250703151441.60325-1-dev.jain@arm.com>
 <aIHsiPtG0Ycm2DTe@arm.com>
 <b5570f50-8534-444b-8c7d-68d676840eef@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5570f50-8534-444b-8c7d-68d676840eef@arm.com>

On Thu, Jul 24, 2025 at 04:10:18PM +0530, Dev Jain wrote:
> On 24/07/25 1:49 pm, Catalin Marinas wrote:
> > On Thu, Jul 03, 2025 at 08:44:41PM +0530, Dev Jain wrote:
> > > arm64 currently changes permissions on vmalloc objects locklessly, via
> > > apply_to_page_range, whose limitation is to deny changing permissions for
> > > block mappings. Therefore, we move away to use the generic pagewalk API,
> > > thus paving the path for enabling huge mappings by default on kernel space
> > > mappings, thus leading to more efficient TLB usage. However, the API
> > > currently enforces the init_mm.mmap_lock to be held. To avoid the
> > > unnecessary bottleneck of the mmap_lock for our usecase, this patch
> > > extends this generic API to be used locklessly, so as to retain the
> > > existing behaviour for changing permissions.
> > 
> > Is it really a significant bottleneck if we take the lock? I suspect if
> > we want to make this generic and allow splitting, we'll need a lock
> > anyway (though maybe for shorter intervals if we only split the edges).
> 
> The splitting primitive may or may not require a lock, Ryan and Yang had
> some discussion on the linear map block mapping thread. I am assuming
> that since we didn't need a lock in the past, there is no need to take it now,
> since we are only changing the pagetable walk API being used.

I vaguely remember Ryan's and Yang's discussion. I'd have to revisit it.
In the past we were not replacing block/table entries since there was no
page table splitting. If we are to add some splitting, even at the
edges, what would prevent some other caller of this API overlapping and
attempting to do the same split? It's not just vmalloc ranges but the
linear map as well that's touched by __change_memory_common().

-- 
Catalin

