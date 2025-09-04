Return-Path: <linux-kernel+bounces-801838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19927B44A90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BF31C84EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A61A2D7DCD;
	Thu,  4 Sep 2025 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s2q6tezP"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66D1A76BB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029829; cv=none; b=Wdl63SBQx7Vt1Ja5jIrq+d+Fwx6A3/YA0y8O4hHgGWZ172mbFU9Y8byucda4lNZDednMiOubQ/JkKiKYypswDIoJWC7wCmo/fOFVYMnnZDM6G4s4BmyeUT3+G71n++jKdTmFssT4J4K3cmGxnWtnu1QQkEM8SOejubdl33Ki6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029829; c=relaxed/simple;
	bh=cJRcgXduiHSal19odhrqMAyc1h/5FcDcOd6A03wo4FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE4lf5gj6enuoxizXur8Q09ebITWnTfpsPiLAPC82PWg0nKOdsXZNhw/dZPGUPIsqIaciQtOFMc4e1DkpmGv4m/tNXBYB4aS1keKDYLaDkPSTpsdrnBSPCr6H/WXfee7pNomfNaIw7GiycC2VSDPz4wWxgnkOqAUIE+ScsL5c/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s2q6tezP; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Sep 2025 16:50:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757029825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EcoOi63+8ErVCjATfSW78fVTOIe8m0/lvvNKJAzSLt8=;
	b=s2q6tezPZeSmesxSDgaE8+n9vbDTU0MO+2z+vXbPRt63svdVgoDc7UT3UpTt8DErPzsBX3
	NNNgUFCG0/CBwrrH/pfNyidiqF5MIc5F/hYr8KQoD7Ar9MYzP4muLgM9puSLmNvYcgi+2g
	ggq1GbrnOO9tWPypkcNpVLh64Ra0yes=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, surenb@google.com, 
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <llxw4jc4okxjxjcco5vacqiushvr642u2lto5sml3vc6wlqboe@lyfqb5anihq6>
References: <20250903092729.10611-1-zhongjinji@honor.com>
 <20250903092729.10611-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903092729.10611-3-zhongjinji@honor.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 03, 2025 at 05:27:29PM +0800, zhongjinji wrote:
> Although the oom_reaper is delayed and it gives the oom victim chance to
> clean up its address space this might take a while especially for
> processes with a large address space footprint. In those cases
> oom_reaper might start racing with the dying task and compete for shared
> resources - e.g. page table lock contention has been observed.
> 
> Reduce those races by reaping the oom victim from the other end of the
> address space.
> 
> It is also a significant improvement for process_mrelease(). When a process
> is killed, process_mrelease is used to reap the killed process and often
> runs concurrently with the dying task. The test data shows that after
> applying the patch, lock contention is greatly reduced during the procedure
> of reaping the killed process.
> 
> Without the patch:
> |--99.74%-- oom_reaper
> |  |--76.67%-- unmap_page_range
> |  |  |--33.70%-- __pte_offset_map_lock
> |  |  |  |--98.46%-- _raw_spin_lock
> |  |  |--27.61%-- free_swap_and_cache_nr
> |  |  |--16.40%-- folio_remove_rmap_ptes
> |  |  |--12.25%-- tlb_flush_mmu
> |  |--12.61%-- tlb_finish_mmu
> 
> With the patch:
> |--98.84%-- oom_reaper
> |  |--53.45%-- unmap_page_range
> |  |  |--24.29%-- [hit in function]
> |  |  |--48.06%-- folio_remove_rmap_ptes
> |  |  |--17.99%-- tlb_flush_mmu
> |  |  |--1.72%-- __pte_offset_map_lock
> |  |--30.43%-- tlb_finish_mmu
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

