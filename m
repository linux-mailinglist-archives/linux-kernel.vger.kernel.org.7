Return-Path: <linux-kernel+bounces-881185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3252DC27A94
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2FB634A46F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47128CF4A;
	Sat,  1 Nov 2025 09:08:44 +0000 (UTC)
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB541D5147
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988123; cv=none; b=mpyGjIMv3FidaJ8kmsUwURgAeKFnUr1gOGJkh7q458O4n+rmoSfgTtWYnGbVj6TYcTUu68VSQXzKDceiwMpnMm3JEiCOO0kfFwctfDpkQ1m9cVev+3h4EjdRMtmgHUQbHzkBAQ9dYwuOS1j/YL+cC6pfT4CZZoqAcKOFfAKWmtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988123; c=relaxed/simple;
	bh=+6dJDLZcTgjdYhpzK73Dcxd2EjK9ifpHcESZa7cBKG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVSS0fq1wGdJ92Tp62aZ0z/R0HED7Uf5CyOba8AkWxBoxrRMQyfQ5V8gas5T4STshIefzxPsnoj4o1A219AhG+taHhOKfoWN5L+TO5TnlBjD39hHdTXZJnHPJc/i4ZWsZ5qiO7w3Vd/vdmsInVeMKC8eCDLU0DAmd/QTv9LoNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 1 Nov 2025 18:08:33 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 1 Nov 2025 18:08:33 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/19] mm, swap: sanitize swap entry management workflow
Message-ID: <aQXOESm58xvqS7sx@yjaykim-PowerEdge-T330>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-14-3d43f3b6ec32@tencent.com>
 <aQWR3fK/GtTkx0kX@yjaykim-PowerEdge-T330>
 <CAMgjq7DtP4j4kQp-bM+jrVSkCh26+8U-TkENxUmPkmEJyZg9YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7DtP4j4kQp-bM+jrVSkCh26+8U-TkENxUmPkmEJyZg9YA@mail.gmail.com>

On Sat, Nov 01, 2025 at 04:59:05PM +0800, Kairui Song wrote:
> On Sat, Nov 1, 2025 at 12:51 PM YoungJun Park <youngjun.park@lge.com> wrote:
> >
> > On Wed, Oct 29, 2025 at 11:58:40PM +0800, Kairui Song wrote:
> > > From: Kairui Song <kasong@tencent.com>

> > During the code review, I found something to be verified.
> > It is not directly releavant your patch,
> > I send the email for checking it right and possible fix on this patch.
> >
> > on the swap_alloc_hibernation_slot function
> > nr_swap_pages is decreased. but as I think it is decreased on swap_range_alloc.
> >
> > The nr_swap_pages are decremented as the callflow as like the below.
> >
> > cluster_alloc_swap_entry -> alloc_swap_scan_cluster
> > -> closter_alloc_range -> swap_range_alloc
> >
> > Introduced on
> > 4f78252da887ee7e9d1875dd6e07d9baa936c04f
> > mm: swap: move nr_swap_pages counter decrement  from folio_alloc_swap() to swap_range_alloc()
> >
> 
> Yeah, you are right, that's a bug introduced by 4f78252da887, will you
> send a patch to fix that ? Or I can send one, just remove the
> atomic_long_dec(&nr_swap_pages) in get_swap_page_of_type then we are
> fine.

Thank you for double check. I will send a patch soon.

Regards,
Youngjun Park

