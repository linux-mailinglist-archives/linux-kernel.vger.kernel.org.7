Return-Path: <linux-kernel+bounces-769877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B033B274B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5587A170F79
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D272145B3F;
	Fri, 15 Aug 2025 01:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uhfhNylk"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5214E7DA93
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221355; cv=none; b=IiLtVd7DTSLR2KX5TVGe0MoL1JsZ3eaS2nD9bVNKu114vBZ3xDqPwVfia0/ap4R3xsRq6I1Ccgm1qf4RxVeirXlYi1Xx5PrCptWIkdoUIqWbzdnOz+rD3BxQBxkTsOvdrZmIg3dfXlbZtkrcIIRyk9Kdf+xa44PTNRuZ1wQLL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221355; c=relaxed/simple;
	bh=VdU0DsQNCYCK5/6Ghalft+f2idfI7BryPUFTXfE2FAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UV8JsEAqP45mNuvXdj56sasC+D4kgWpwYdE//XsZ9y0xjSfOkmkIkUXTdYgpPOPDXtk6yiQzYoKRZYV1X6Qw5uvrtnpDV3duOP1OKUSzYSCL0qPxCNdfzDxVcOXUh/xfvK6w1qfwK5Pmd1REHyB8XOos9bXwIHK+ElWL5JZwCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uhfhNylk; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755221345; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=EvOx8YJGoL8XjrEaDdqtn6ehN7T5qVmlpqM2R57SM4Y=;
	b=uhfhNylk+lfH9dSWPp/ZGEazWtDrYDhM+XJUoFl8V3FQ5iGubGqTjz9bh9HigER2JmZSfukGpZ4G06E4Qt0fFcZGkBTmyQRpyr72Heg+BYuNW8w3nseum6qlVx137pK1lLJZB3x356limqXJkJH+EkUiK0Ymb6oWzhGjAU8Qsco=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wlmcoul_1755221341 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 09:29:03 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Bharata B Rao <bharata@amd.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,
  <Jonathan.Cameron@huawei.com>,  <dave.hansen@intel.com>,
  <gourry@gourry.net>,  <hannes@cmpxchg.org>,
  <mgorman@techsingularity.net>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <raghavendra.kt@amd.com>,  <riel@surriel.com>,
  <rientjes@google.com>,  <sj@kernel.org>,  <weixugc@google.com>,
  <willy@infradead.org>,  <ziy@nvidia.com>,  <dave@stgolabs.net>,
  <nifan.cxl@gmail.com>,  <xuezhengchu@huawei.com>,  <yiannis@zptcorp.com>,
  <akpm@linux-foundation.org>,  <david@redhat.com>,  <byungchul@sk.com>,
  <kinseyho@google.com>,  <joshua.hahnjy@gmail.com>,  <yuanchu@google.com>,
  <balbirs@nvidia.com>
Subject: Re: [RFC PATCH v1 1/7] mm: migrate: Allow misplaced migration
 without VMA too
In-Reply-To: <20250814134826.154003-2-bharata@amd.com> (Bharata B. Rao's
	message of "Thu, 14 Aug 2025 19:18:20 +0530")
References: <20250814134826.154003-1-bharata@amd.com>
	<20250814134826.154003-2-bharata@amd.com>
Date: Fri, 15 Aug 2025 09:29:00 +0800
Message-ID: <87ectde5k3.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bharata B Rao <bharata@amd.com> writes:

> We want isolation of misplaced folios to work in contexts
> where VMA isn't available. In order to prepare for that
> allow migrate_misplaced_folio_prepare() to be called with
> a NULL VMA.
>
> Signed-off-by: Bharata B Rao <bharata@amd.com>
> ---
>  mm/migrate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 425401b2d4e1..7e356c0b1b5a 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2619,7 +2619,8 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>  
>  /*
>   * Prepare for calling migrate_misplaced_folio() by isolating the folio if
> - * permitted. Must be called with the PTL still held.
> + * permitted. Must be called with the PTL still held if called with a non-NULL
> + * vma.

The locking rule is changed.  IMO, it deserves more explanation in patch description.

>   */
>  int migrate_misplaced_folio_prepare(struct folio *folio,
>  		struct vm_area_struct *vma, int node)
> @@ -2636,7 +2637,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>  		 * See folio_maybe_mapped_shared() on possible imprecision
>  		 * when we cannot easily detect if a folio is shared.
>  		 */
> -		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
> +		if (vma && (vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
>  			return -EACCES;
>  
>  		/*

---
Best Regards,
Huang, Ying

