Return-Path: <linux-kernel+bounces-849087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C08BCF2D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDBC14E06C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC923AE9A;
	Sat, 11 Oct 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MEAzV81d"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28731DE3DB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173771; cv=none; b=gngux21BkYzE6jE3pH23r+S9VtjeWkZw9X4gCno39VFb0r4A1AsZud/Ctjdw8+yPoBKm+k1syW1WKBy5rdGkgbVDgDdYOK9LWOG9HRm89U0ihND7/SLNc6tYCbt4epxT6v6OylrDxTHdrKyUtTcELaIlpvAA9ClWOnrSbpFyzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173771; c=relaxed/simple;
	bh=BprEeYMQFlQbcNoDv11DHUl93ohmJYiM68Xkzmvku6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzNTQkxU6n6tvlqB3gZbWYPhWSu5DSWxSvlNEksxzYxjaEFetLOBfGZDO8hJkC9lfl3tYlcLkv/vjOzt/+dKCKPghey7Fz1GmfeiFeNska5i/yQLy3SrKJxz7baAmXv7qRnUM6gnIERufLtrxD5CrX6NWx9Jh2UBnnxloqVVO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MEAzV81d; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ba6767a4-8211-45b0-bf37-5a0bb303866d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760173761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ro+Dc7WyqU/UiRkMuFCkVqn4KXP2e3oEFRnHobzOqKU=;
	b=MEAzV81d3jpuc6iCH8cytejEyMFYxaPwwDFwfc2hBhOzNd9NCQLsx+wNdMr97gGTkIaHDo
	2Z2F/EGxSIKPdnUhoT9y0SO/Q6doTwmS22+PRezhNBdYudJ+3CwOJypgjG5bxFYole85Vi
	ym9kGF0qUmfBaNGw8rssozyq866zFU8=
Date: Sat, 11 Oct 2025 17:09:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] mm: prevent poison consumption when splitting THP
Content-Language: en-US
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lorenzo.stoakes@oracle.com,
 nao.horiguchi@gmail.com, farrah.chen@intel.com, jiaqiyan@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tony.luck@intel.com,
 linmiaohe@huawei.com, david@redhat.com
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <20251011075520.320862-1-qiuxu.zhuo@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251011075520.320862-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/11 15:55, Qiuxu Zhuo wrote:
> When performing memory error injection on a THP (Transparent Huge Page)
> mapped to userspace on an x86 server, the kernel panics with the following
> trace. The expected behavior is to terminate the affected process instead
> of panicking the kernel, as the x86 Machine Check code can recover from an
> in-userspace #MC.
> 
>    mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80000000070134
>    mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
>    mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e741e77539027db
>    mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC 0 microcode 80000320
>    mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>    mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
>    Kernel panic - not syncing: Fatal local machine check
> 
> The root cause of this panic is that handling a memory failure triggered by
> an in-userspace #MC necessitates splitting the THP. The splitting process
> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), which
> reads the sub-pages of the THP to identify zero-filled pages. However,
> reading the sub-pages results in a second in-kernel #MC, occurring before
> the initial memory_failure() completes, ultimately leading to a kernel
> panic. See the kernel panic call trace on the two #MCs.
> 
>    First Machine Check occurs // [1]
>      memory_failure()         // [2]
>        try_to_split_thp_page()
>          split_huge_page()
>            split_huge_page_to_list_to_order()
>              __folio_split()  // [3]
>                remap_page()
>                  remove_migration_ptes()
>                    remove_migration_pte()
>                      try_to_map_unused_to_zeropage()  // [4]
>                        memchr_inv()                   // [5]
>                          Second Machine Check occurs  // [6]
>                            Kernel panic
> 
> [1] Triggered by accessing a hardware-poisoned THP in userspace, which is
>      typically recoverable by terminating the affected process.
> 
> [2] Call folio_set_has_hwpoisoned() before try_to_split_thp_page().
> 
> [3] Pass the RMP_USE_SHARED_ZEROPAGE remap flag to remap_page().
> 
> [4] Try to map the unused THP to zeropage.
> 
> [5] Re-access sub-pages of the hw-poisoned THP in the kernel.
> 
> [6] Triggered in-kernel, leading to a panic kernel.
> 
> In Step[2], memory_failure() sets the poisoned flag on the sub-page of the
> THP by TestSetPageHWPoison() before calling try_to_split_thp_page().
> 
> As suggested by David Hildenbrand, fix this panic by not accessing to the
> poisoned sub-page of the THP during zeropage identification, while
> continuing to scan unaffected sub-pages of the THP for possible zeropage
> mapping. This prevents a second in-kernel #MC that would cause kernel
> panic in Step[4].
> 
> [ Credits to Andrew Zaborowski <andrew.zaborowski@intel.com> for his
>    original fix that prevents passing the RMP_USE_SHARED_ZEROPAGE flag
>    to remap_page() in Step[3] if the THP has the has_hwpoisoned flag set,
>    avoiding access to the entire THP for zero-page identification. ]
> 

Thanks for the fix!

But one thing is missing: a "Fixes:" tag here. And also add:

Cc: <stable@vger.kernel.org>

> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---

Well, I think this fix should work ;)

Acked-by: Lance Yang <lance.yang@linux.dev>

