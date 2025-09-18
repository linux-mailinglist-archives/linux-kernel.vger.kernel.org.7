Return-Path: <linux-kernel+bounces-785889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15BB35234
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B8B1A84C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FEC2D0C76;
	Tue, 26 Aug 2025 03:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvH4P9Lp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA01F5842;
	Tue, 26 Aug 2025 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178506; cv=none; b=kKGNApeCu6WXhhNXve2P98MK4jlPpex2g5lY0uuq0ZaTkU2lwfji0+EyutwEsLfPXDXT9NOIsEpzMpll9bUZQdg2zUXbQjSqlKX8ITQRYXMoFvT8Nf++myueHdsxuQsjdKHErbE7RB0OujcXHDbjNHSWj+/t3r7NPewhZSN/AW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178506; c=relaxed/simple;
	bh=d34m/47r/gW2GjojamdCWHSBbGXyInVrT1/39iuDcD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8FdAQK8mu8R9BItm9Dfbt2gI+0Fo7YkeZb+oZ1DGpfVH0azbFWa8n8RqgB7KGI8TgOb5J5T7YrpPR6o8hvAx6T76Srqe+4RISLRu0Z+k44EF03Kl1uacMuk9qyIsemWNzZnzBubrtAQQDyuxc2LqkQsXF4XYmRG1pZMP2/FSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvH4P9Lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F63C4CEF1;
	Tue, 26 Aug 2025 03:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756178505;
	bh=d34m/47r/gW2GjojamdCWHSBbGXyInVrT1/39iuDcD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VvH4P9LpSYd94n3iE4sPzDcQ5/ChVR4EK/bjjtdwrzaHWi4J0OWSOLZ12n6IUPVf+
	 j8XYw4knhalBrX8elCacnZubPpMrQuQibfMquhN8s9qD3WftFlra71MTDUK70xTVwC
	 5Ka7mG816aYss450yQ8M07tCgQQYm6uQ+saukJ5VeJvbFA2Dk8MBbbjL2Rt53RLbmv
	 zgbrdBq63J3F18MVDABo5G37nCokCCk0+1W8jSjyPsdP7IzTbwYNJ0ihl8JEAxLzDu
	 yIeETEe/GPxsp27ox1QzWXtSMUG8qdE99/wMh4nOxR6d400H7JnQPn73nLYANehgWm
	 4S9fVIJz0rh6g==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for DAMOS_PAGEOUT
Date: Mon, 25 Aug 2025 20:21:43 -0700
Message-Id: <20250826032144.49491-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7de69c95-bbf7-4dd0-91e9-640da8b8cd5c@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 26 Aug 2025 11:16:56 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> 
> 在 2025/8/25 23:12, SeongJae Park 写道:
> > On Fri, 22 Aug 2025 17:34:11 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
[...]
> > ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
> >  From hackermail Thu Jan  1 00:00:00 1970
> > From: SeongJae Park <sj@kernel.org>
> > To: Andrew Morton <akpm@linux-foundation.org>
> > Cc: SeongJae Park <sj@kernel.org>
> > Cc: damon@lists.linux.dev
> > Cc: kernel-team@meta.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Date: Mon, 25 Aug 2025 07:41:33 -0700
> > Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
> >           return value
> >
> > Otherwise, __udidi3 linking problem happens on certain configs.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >   mm/damon/paddr.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index 5fad2f9a99a0..09c87583af6c 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> > @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
> >   	return false;
> >   }
> >   
> > +/* convert physical address to core-layer address */
> > +static unsigned long damon_pa_core_addr(phys_addr_t pa,
> > +		unsigned long addr_unit)
> > +{
> > +#ifdef __i386__
> 
> Can we use the following condition instead?
> 
> #if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)

To my understanding, this issue happens only on i386, not every 32bit
architectures.  So I think i386 specific condition is better.


Thanks,
SJ

[...]

