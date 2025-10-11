Return-Path: <linux-kernel+bounces-849256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8D6BCFAB8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F9318912C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E84284665;
	Sat, 11 Oct 2025 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DmGGkDAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E627B338
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760206740; cv=none; b=ErruOphWOkywStpu2wYAgvkNIjy6mtWqoxwQDVyHxmGHdF2r00DUEURs9ynJqxQ9EnsfK57jmwOH6BXjh0prtXqmtdWqbHBa92uixBBXc+z9sUXfPA4uv+V9+DAqGebQZhzXHclfU1NYu8au7P5/w5DSAktI7lwX6i0tCMO+wWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760206740; c=relaxed/simple;
	bh=MPdjkQnoZTr/N788IvZN1eosYtsrWQ4gFL5Wool50+I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RoxWi6NVgqVIotbasbEraPhqq2Ld+Vj+eymAUC6mJO/+KfGOIQHsTaeyymTlBejj8bQrbAgLaf1evtOSQN9px58hhs1MbrrgE53JZX1jBDArJ6O9cC4tRDjkNyYdtwgnJi50HXdjl9Ao8qyed9kvlt8R/B4k27bGzULtfZkNpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DmGGkDAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A3CC4CEF4;
	Sat, 11 Oct 2025 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760206739;
	bh=MPdjkQnoZTr/N788IvZN1eosYtsrWQ4gFL5Wool50+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DmGGkDAWyxw6viSxHi+wXwHoIs/wtxfbFrp8PXdOaFKdhHAkvu640pgNrP1RuzKPX
	 rd64pTypgtTSHWy/PY7AV4KGqcwGqw74ou1UGkZekuM1MP/fL7rCqfc1RnbghdfCKl
	 ZyScDxgh35p+cvheSFmMIKwnMBMwtAqhDjC8zWP0=
Date: Sat, 11 Oct 2025 11:18:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, linmiaohe@huawei.com,
 tony.luck@intel.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, nao.horiguchi@gmail.com,
 farrah.chen@intel.com, jiaqiyan@google.com, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: prevent poison consumption when splitting
 THP
Message-Id: <20251011111858.952f08213da2a9018cfbe2b3@linux-foundation.org>
In-Reply-To: <20251011075520.320862-1-qiuxu.zhuo@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
	<20251011075520.320862-1-qiuxu.zhuo@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Oct 2025 15:55:19 +0800 Qiuxu Zhuo <qiuxu.zhuo@intel.com> wrote:

> When performing memory error injection on a THP (Transparent Huge Page)
> mapped to userspace on an x86 server, the kernel panics with the following
> trace. The expected behavior is to terminate the affected process instead
> of panicking the kernel, as the x86 Machine Check code can recover from an
> in-userspace #MC.
> 
>   mce: [Hardware Error]: CPU 0: Machine Check Exception: f Bank 3: bd80000000070134
>   mce: [Hardware Error]: RIP 10:<ffffffff8372f8bc> {memchr_inv+0x4c/0xf0}
>   mce: [Hardware Error]: TSC afff7bbff88a ADDR 1d301b000 MISC 80 PPIN 1e741e77539027db
>   mce: [Hardware Error]: PROCESSOR 0:d06d0 TIME 1758093249 SOCKET 0 APIC 0 microcode 80000320
>   mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>   mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
>   Kernel panic - not syncing: Fatal local machine check
> 
> The root cause of this panic is that handling a memory failure triggered by
> an in-userspace #MC necessitates splitting the THP. The splitting process
> employs a mechanism, implemented in try_to_map_unused_to_zeropage(), which
> reads the sub-pages of the THP to identify zero-filled pages. However,
> reading the sub-pages results in a second in-kernel #MC,

Well that sounds dumb.  To me this suggests a lack of selftesting code.
Perhaps someone could prepare a test for this case.

> occurring before
> the initial memory_failure() completes, ultimately leading to a kernel
> panic. See the kernel panic call trace on the two #MCs.
> 
> ...
>
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Yes please, a Fixes: would be good.

> +	if (folio_contain_hwpoisoned_page(folio))

Offtopic, that should have been "folio_contains_hwpoisoned_page".



