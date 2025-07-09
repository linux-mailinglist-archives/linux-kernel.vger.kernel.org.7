Return-Path: <linux-kernel+bounces-722688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE25AFDDB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8693BFCB9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB21DED53;
	Wed,  9 Jul 2025 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JSV1q3SO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E9198851;
	Wed,  9 Jul 2025 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029654; cv=none; b=W/YHStcQsrCk/kdpok6+TCz+0SMqsjKr/0G8VH6oJoYBCvORd2gIS+hxwNt2EcUYT8yPAW7Gx2u0+wTzii36mKH2UOxWhVhv5AeBdHBRlHgqlikhR5LuMKQky4GHRkfs6RSilZFAW/ksvqFjM4yVwkSZwdbyCChZRqDnQkjgW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029654; c=relaxed/simple;
	bh=ufxoFfgAqXtjt7qZqYoRDR6akfPIzd5kq+OOk/XGK5Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HczczOuXrfqeKaloGLFXl6iR9KLlZONWnlEvGfKIdgFbDjAZM9HDsdvQY5Sb7TzHeMhh4aLxqTzTcC89f1U0ti+lWJCd9rK9D7l0ihdr58Q1b4Zh3O7cxaRKkKPlPuWCwjfWDKDigmsNJt3MGVdwUIErOa0t1Pw8p8qZOpM6C9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JSV1q3SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEFDC4CEF0;
	Wed,  9 Jul 2025 02:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752029654;
	bh=ufxoFfgAqXtjt7qZqYoRDR6akfPIzd5kq+OOk/XGK5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSV1q3SOvgMO6tkUf8E2sjHfpQCXnrKJHIQYn4lWnr2gWWoy3BnhlG10Do+FVKohg
	 xBsImfMHPjn6lQhXC//6fWNh8GyjkM+IjveX3ndJhpbNHmanLPp6PGlUSq3HE7WiVi
	 D2T0UnkWkE2JqfdVJ8bSaJ6soMoXIbtTWxY4fXsM=
Date: Tue, 8 Jul 2025 19:54:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Phillip Lougher
 <phillip@squashfs.org.uk>, Chanho Min <chanho.min@lge.com>,
 <oe-kbuild-all@lists.linux.dev>, <kernel-janitors@vger.kernel.org>, Linux
 Memory Management List <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] squashfs: Fix incorrect argument to sizeof in
 kmalloc_array call
Message-Id: <20250708195413.e990d63665144c28b0caa672@linux-foundation.org>
In-Reply-To: <aG3AVf8fbqHzk+OD@rli9-mobl>
References: <20250708142604.1891156-1-colin.i.king@gmail.com>
	<aG3AVf8fbqHzk+OD@rli9-mobl>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 09:05:25 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Colin,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on next-20250708]
> [cannot apply to linus/master v6.16-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Colin-Ian-King/squashfs-Fix-incorrect-argument-to-sizeof-in-kmalloc_array-call/20250708-223017
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20250708142604.1891156-1-colin.i.king%40gmail.com
> patch subject: [PATCH] squashfs: Fix incorrect argument to sizeof in kmalloc_array call
> :::::: branch date: 10 hours ago
> :::::: commit date: 10 hours ago
> config: mips-randconfig-r071-20250709 (attached as .config)
> compiler: mips64-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (attached as reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507090822.QI1bMiUV-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/percpu.h:5,
>                     from include/linux/percpu_counter.h:14,
>                     from include/linux/mm_types.h:21,
>                     from include/linux/mmzone.h:22,
>                     from include/linux/gfp.h:7,
>                     from include/linux/xarray.h:16,
>                     from include/linux/list_lru.h:14,
>                     from include/linux/fs.h:14,
>                     from include/linux/highmem.h:5,
>                     from include/linux/bvec.h:10,
>                     from include/linux/blk_types.h:10,
>                     from include/linux/blkdev.h:9,
>                     from fs/squashfs/block.c:16:
>    fs/squashfs/block.c: In function 'squashfs_bio_read_cached':
> >> fs/squashfs/block.c:92:12: error: 'folio' undeclared (first use in this function)
>        sizeof(*folio), GFP_KERNEL | __GFP_ZERO);
>                ^~~~~

I made it

	struct folio **cache_folios = kmalloc_array(page_count,
			sizeof(*cache_folios), GFP_KERNEL | __GFP_ZERO);


