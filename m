Return-Path: <linux-kernel+bounces-813707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965DB549C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10DC1BC6DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB752E03FF;
	Fri, 12 Sep 2025 10:27:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A66B1E520A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672867; cv=none; b=YK1qOSeer4E5U5MZRbsXIMz2Q9dxkHKfrvZgFo8oeX3R5grm5geI4T5WIFoVTXibprlKcE59PaHrSTCnV66BSACNmEeFZj1nom1GWqMtxJuFkCT7JcT7yKdmEjJekrwNKJysg/gdLsXo0E70TtCNcHtDnFlSWuyUivr5Z7SlrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672867; c=relaxed/simple;
	bh=v85OF6cVpKyrUb8zAVGFyRkRESpXLJbfBA+H4agDFcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVJi/YKCkE5JuWpD4Z+YidxdsFWzmBvPlqn4IlLH+bADre63ntH2t27KVkgE2P0U8O+Xj40r95ydIGhfIBEIxmK1Sl9rUDM/ac8kIOd+EmRK0qDL/CcuYQEuzhh0+mjLOnk31pUuSbKFUbl+4s2SnVy4gkQJW1uAtpBnvce46YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5713416A3;
	Fri, 12 Sep 2025 03:27:37 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380603F66E;
	Fri, 12 Sep 2025 03:27:45 -0700 (PDT)
Date: Fri, 12 Sep 2025 11:27:43 +0100
From: Leo Yan <leo.yan@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>
Subject: Re: [PATCH] coresight: trbe: Use scope-based resource management in
 arm_trbe_alloc_buffer()
Message-ID: <20250912102743.GG12516@e132581.arm.com>
References: <3663eb06-6a98-461b-8fcb-6891165d107f@web.de>
 <3f2137d5-5bfc-44e7-9269-3069e44eda31@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2137d5-5bfc-44e7-9269-3069e44eda31@arm.com>

On Fri, Sep 12, 2025 at 09:55:57AM +0530, Anshuman Khandual wrote:

[...]

> Seems like a good idea though. But please keep the local variable
> declaration in the current place which is bit cleaner and reduces
> code churn as well.

Though include/linux/cleanup.h suggests to "always define and assign
variables in one statement" to avoid potential interdependency problem
with lock, this is not concerned in arm_trbe_alloc_buffer().

So I bias to Anshuman's suggestion of declaring variables at the top
of the function, as this is the style widely used in the kernel.

> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 7a226316c48f..7babba1a9afb 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -733,8 +733,8 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>                                    struct perf_event *event, void **pages,
>                                    int nr_pages, bool snapshot)
>  {
> -       struct trbe_buf *buf;
> -       struct page **pglist;
> +       struct trbe_buf *buf __free(kfree);

    struct trbe_buf *buf __free(kfree) = NULL;

> +       struct page **pglist __free(kfree);

    struct page **pglist __free(kfree) = NULL;

>         int i;
> 
>         /*
> @@ -751,27 +751,22 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>                 return NULL;
> 
>         pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> -       if (!pglist) {
> -               kfree(buf);
> +       if (!pglist)
>                 return NULL;
> -       }
> 
>         for (i = 0; i < nr_pages; i++)
>                 pglist[i] = virt_to_page(pages[i]);
> 
>         buf->trbe_base = (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
> -       if (!buf->trbe_base) {
> -               kfree(pglist);
> -               kfree(buf);
> +       if (!buf->trbe_base)
>                 return NULL;
> -       }
> +
>         buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
>         buf->trbe_write = buf->trbe_base;
>         buf->snapshot = snapshot;
>         buf->nr_pages = nr_pages;
>         buf->pages = pages;
> -       kfree(pglist);
> -       return buf;
> +       return_ptr(buf);
>  }
> 
>  static void arm_trbe_free_buffer(void *config)

