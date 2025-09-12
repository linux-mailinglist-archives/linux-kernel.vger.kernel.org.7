Return-Path: <linux-kernel+bounces-813182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74414B541B1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D415A64FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDA1267387;
	Fri, 12 Sep 2025 04:26:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFF879CD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757651166; cv=none; b=p6szosLzHcQrf867AeFIhtdBRyPwm9mlc+dnTRvg0sgoR5dJ39PA02WpghiPuSowpQykebTmpNogISeCIuNR7Iy8zXu/5VoM0IbgXVFgCge3LFPwTY2hH99DfoUZIUU3aIrlnhWGYWI9A078GhaB0lrz1CAERci0fECgG/61k3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757651166; c=relaxed/simple;
	bh=99WkT4+R1bTF3Z7QLWN181x9VlAwXAQUL75rZQAK5Gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6e/NZXdmnlEtnnYzwQx5yQXAUzqPRK4PEifo/maLegj5RMkhHDHQfoXutU7dGbA4YOKRQmtsvqB8gwxGamFYF+YnpyEoQ7BJxe+IMgMCy+eierE47omL5XPUw/b2nqX/YROazPfLj923EVt3RoUqq0nhvpUzo5AIqbxx1XrUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F129416A3;
	Thu, 11 Sep 2025 21:25:54 -0700 (PDT)
Received: from [10.163.41.251] (unknown [10.163.41.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6393F66E;
	Thu, 11 Sep 2025 21:26:00 -0700 (PDT)
Message-ID: <3f2137d5-5bfc-44e7-9269-3069e44eda31@arm.com>
Date: Fri, 12 Sep 2025 09:55:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: trbe: Use scope-based resource management in
 arm_trbe_alloc_buffer()
To: Markus Elfring <Markus.Elfring@web.de>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Leo Yan <leo.yan@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>
References: <3663eb06-6a98-461b-8fcb-6891165d107f@web.de>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3663eb06-6a98-461b-8fcb-6891165d107f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/25 5:58 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 9 Sep 2025 14:20:06 +0200
> 
> Scope-based resource management became supported for some
> programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:

			^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

SHA ID here just needs first 12 digits not the entire string.
> Introduce __cleanup() based infrastructure").
> 
> * Thus use the attribute “__free(kfree)”.
> 
> * Reduce the scopes for the local variables “buf” and “pglist”.

What is that required ?
> 
> * Omit four kfree() calls accordingly.

Right.

The commit message should be re-written with little more
context from arm_trbe_alloc_buffer(), after describing
the new scope-based resource management.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 21 ++++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8f9bbef71f23..1b0d58bf8613 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -733,8 +733,6 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>  				   struct perf_event *event, void **pages,
>  				   int nr_pages, bool snapshot)
>  {
> -	struct trbe_buf *buf;
> -	struct page **pglist;
>  	int i;
>  
>  	/*
> @@ -746,32 +744,29 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
>  	if (nr_pages < 2)
>  		return NULL;
>  
> -	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
> +	struct trbe_buf *buf __free(kfree) = kzalloc_node(sizeof(*buf),
> +							  GFP_KERNEL,
> +							  trbe_alloc_node(event));
>  	if (!buf)
>  		return NULL;
>  
> -	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> -	if (!pglist) {
> -		kfree(buf);
> +	struct page **pglist __free(kfree) = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
> +	if (!pglist)
>  		return NULL;
> -	}
>  
>  	for (i = 0; i < nr_pages; i++)
>  		pglist[i] = virt_to_page(pages[i]);
>  
>  	buf->trbe_base = (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
> -	if (!buf->trbe_base) {
> -		kfree(pglist);
> -		kfree(buf);
> +	if (!buf->trbe_base)
>  		return NULL;
> -	}
> +
>  	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
>  	buf->trbe_write = buf->trbe_base;
>  	buf->snapshot = snapshot;
>  	buf->nr_pages = nr_pages;
>  	buf->pages = pages;
> -	kfree(pglist);
> -	return buf;
> +	return_ptr(buf);
>  }
>  
>  static void arm_trbe_free_buffer(void *config)

Seems like a good idea though. But please keep the local variable
declaration in the current place which is bit cleaner and reduces
code churn as well.

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 7a226316c48f..7babba1a9afb 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -733,8 +733,8 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
                                   struct perf_event *event, void **pages,
                                   int nr_pages, bool snapshot)
 {
-       struct trbe_buf *buf;
-       struct page **pglist;
+       struct trbe_buf *buf __free(kfree);
+       struct page **pglist __free(kfree);
        int i;

        /*
@@ -751,27 +751,22 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
                return NULL;

        pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
-       if (!pglist) {
-               kfree(buf);
+       if (!pglist)
                return NULL;
-       }

        for (i = 0; i < nr_pages; i++)
                pglist[i] = virt_to_page(pages[i]);

        buf->trbe_base = (unsigned long)vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
-       if (!buf->trbe_base) {
-               kfree(pglist);
-               kfree(buf);
+       if (!buf->trbe_base)
                return NULL;
-       }
+
        buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
        buf->trbe_write = buf->trbe_base;
        buf->snapshot = snapshot;
        buf->nr_pages = nr_pages;
        buf->pages = pages;
-       kfree(pglist);
-       return buf;
+       return_ptr(buf);
 }

 static void arm_trbe_free_buffer(void *config)

