Return-Path: <linux-kernel+bounces-872799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6AC12112
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE9E1A2051C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B1314A84;
	Mon, 27 Oct 2025 23:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DsgRW1CV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCBC246BB7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608144; cv=none; b=T0j3vMJfU1veVrYSYGOAA+Wrb/HiQNNuui0GcqOuVVQqayKUFTxioNkycm4w1MAy2naaJtouObeCKIqlqAaJG8vVzXxlnwUtLlxlPpbtw2H99jujPuGlhexrKSLrTC/DHDkj4IypIAdNB1bcxDu/HhW8nyJQF4yQzXjW8ed6jFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608144; c=relaxed/simple;
	bh=hwP/ISptcED0C3gyAgZ7TO//hrJsL4mtGE0vyK8MMKY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AB/ONqurFtDGz3LkV/tAIiYmyjpIGWfnyvd653nvCpwQCfSqzsa7Rw+tDf9FBj9hudnCJxgaD9Fcz9RO7rssTuCWKnmoHQvi9G7h2+7eOiKTLOL16mfaXbSFIkP0mBITkYbpPCyFuzYjiMxa40krsg0NPaGQ7OoBhWFleTXjzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DsgRW1CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB11C4CEF1;
	Mon, 27 Oct 2025 23:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761608144;
	bh=hwP/ISptcED0C3gyAgZ7TO//hrJsL4mtGE0vyK8MMKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DsgRW1CVuz7pf/7lDWSQnSrE5lGx71T5LIt5ghrJXhpQ0KVQ23X8tAhdxcLFSfPvN
	 7909z9taUvPExsiFMmji6rakj7APUszplZBRGGnGCRr5e3EuRfldu+w6U61snmkSD/
	 M4CgCrfH8raUQ+gz3eGYh6/lUUi+I9KknzqBEWt0=
Date: Mon, 27 Oct 2025 16:35:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: bajing <bajing@cmss.chinamobile.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix the problem that kunit cannot run
Message-Id: <20251027163543.bbf0f6bf9f81c3a61afa48a2@linux-foundation.org>
In-Reply-To: <20251027091231.1770-1-bajing@cmss.chinamobile.com>
References: <20251027091231.1770-1-bajing@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Oct 2025 17:12:30 +0800 bajing <bajing@cmss.chinamobile.com> wrote:

> When running ./tools/testing/kunit/kunit.py run,the error for mm/swap.h
> is as follows:
> ERROR:root:In file included from ../mm/shmem.c:43:
> ../mm/swap.h: In function ‘non_swapcache_batch’:
> ../mm/swap.h:66:19: error: implicit declaration of function ‘swp_offset’;
> did you mean ‘pud_offset’? [-Werror=implicit-function-declaration]
>    66 |  pgoff_t offset = swp_offset(entry);
>       |                   ^~~~~~~~~~
>       |                   pud_offset
> In file included from ../mm/shmem.c:68:
> ../include/linux/swapops.h: At top level:
> ../include/linux/swapops.h:107:23: error: conflicting types for ‘swp_offset’
>   107 | static inline pgoff_t swp_offset(swp_entry_t entry)
>       |                       ^~~~~~~~~~
> In file included from ../mm/shmem.c:43:
> ../mm/swap.h:66:19: note: previous implicit declaration of ‘swp_offset’ was here
>    66 |  pgoff_t offset = swp_offset(entry);
>       |                   ^~~~~~~~~~
> cc1: some warnings being treated as errors
> make[4]: *** [../scripts/Makefile.build:243: mm/shmem.o] Error 1
> make[3]: *** [../scripts/Makefile.build:480: mm] Error 2
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [/home/openeuler/kernel/Makefile:1924: .] Error 2
> make[1]: *** [/home/openeuler/kernel/Makefile:234: __sub-make] Error 2
> make: *** [Makefile:234: __sub-make] Error 2
> 
> ...
>
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -4,6 +4,7 @@
>  
>  #ifdef CONFIG_SWAP
>  #include <linux/blk_types.h> /* for bio_end_io_t */
> +#include <linux/swapops.h>
>  
>  /* linux/mm/page_io.c */
>  int sio_pool_init(void);

Thanks, but I suspect you're using an older kernel.  6.18-rc3 doesn't
look like the above and it already has


: #ifdef CONFIG_SWAP
: #include <linux/swapops.h> /* for swp_offset */
: #include <linux/blk_types.h> /* for bio_end_io_t */
:
: static inline unsigned int swp_cluster_offset(swp_entry_t entry)


