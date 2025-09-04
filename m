Return-Path: <linux-kernel+bounces-801332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5DB443CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DDD1C87AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8673081C2;
	Thu,  4 Sep 2025 16:59:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990FC304BBC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005180; cv=none; b=g3PZq0dhRr6632dBEs+2blqNA2HmoO7QIQgMKShVW8WTC+vghoWuV5usRU8WTZ8i3Us4hnq6wzp2eCC6wAo+ScHWXncN7VayRWCHA+mr5nkP8IfMeRcCEjoNHmReY02pM0J/hoj8tBfugPuzSqC03XYNDAzKjuwOmTVj8t8yapQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005180; c=relaxed/simple;
	bh=EvlrGT6jRZ/SdOpiTsJSBYsdJ+ydpA2SasKIwowhrKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAJ4goVaoYyOl0v9Kot6lLs2Db6aXZja5Rg1Hbq6z9Nu/DuhK+2iytDJiADEpXW7p+8DJi2QIdZG86PKJ6/gp3XCtI6RfK+WRS3Y4+fdpZAS06wOfRv+010KV21lHxLBcgZgqHJ8ZAkvwt6hhmuOp5UGyY1podk/CiB5HaVIoBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC426C4CEF0;
	Thu,  4 Sep 2025 16:59:37 +0000 (UTC)
Date: Thu, 4 Sep 2025 17:59:35 +0100
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
Subject: Re: [PATCH v7 5/6] arm64: mm: split linear mapping if BBML2
 unsupported on secondary CPUs
Message-ID: <aLnFd1Hl_FSHZR3z@arm.com>
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-6-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829115250.2395585-6-ryan.roberts@arm.com>

On Fri, Aug 29, 2025 at 12:52:46PM +0100, Ryan Roberts wrote:
> The kernel linear mapping is painted in very early stage of system boot.
> The cpufeature has not been finalized yet at this point. So the linear
> mapping is determined by the capability of boot CPU only. If the boot
> CPU supports BBML2, large block mappings will be used for linear
> mapping.
> 
> But the secondary CPUs may not support BBML2, so repaint the linear
> mapping if large block mapping is used and the secondary CPUs don't
> support BBML2 once cpufeature is finalized on all CPUs.
> 
> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
> same BBML2 capability with the boot CPU, repainting the linear mapping
> is not needed.
> 
> Repainting is implemented by the boot CPU, which we know supports BBML2,
> so it is safe for the live mapping size to change for this CPU. The
> linear map region is walked using the pagewalk API and any discovered
> large leaf mappings are split to pte mappings using the existing helper
> functions. Since the repainting is performed inside of a stop_machine(),
> we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
> since we are still early in boot, it is expected that there is plenty of
> memory available so we will never need to sleep for reclaim, and so
> GFP_ATOMIC is acceptable here.
> 
> The secondary CPUs are all put into a waiting area with the idmap in
> TTBR0 and reserved map in TTBR1 while this is performed since they
> cannot be allowed to observe any size changes on the live mappings. Some
> of this infrastructure is reused from the kpti case. Specifically we
> share the same flag (was __idmap_kpti_flag, now idmap_kpti_bbml2_flag)
> since it means we don't have to reserve any extra pgtable memory to
> idmap the extra flag.
> 
> Co-developed-by: Yang Shi <yang@os.amperecomputing.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

I think this works, so:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

However, I wonder how likely we are to find this combination in the
field to be worth carrying this code upstream. With kpti, we were aware
of platforms requiring it but is this also the case for BBM? If not, I'd
keep the patch out until we get a concrete example.

-- 
Catalin

