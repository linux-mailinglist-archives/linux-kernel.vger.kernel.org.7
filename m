Return-Path: <linux-kernel+bounces-741821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF9B0E953
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1BC3B2EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9142C2080C0;
	Wed, 23 Jul 2025 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="apCoGFlO"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5321917F4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242465; cv=none; b=NKbIGQqXfMCahYsgrWVjsKcw96OakT8yK+AfAl9Pk7pA1sJH8IYnwzI8fhs0BS0Btd9bSEPtosRCywxcMh3UV3Eu8HWhxmZitrQ+R8BGKDQgReJeQWDMwhFEmfahr2fCZ3KPW5TJ51KT+wZCBn5OyibkaPJBa4hO0iPS5fn+Ojw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242465; c=relaxed/simple;
	bh=tUaa89GUjD4KpvDfp79pICZVbgfzRMEjxj2y7nAttyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mex4Oq3LmSRbaqYP9hXZdBAQPrpur7JUXDWFsxlpsvgiEAaBAn77n96qfaz21ieRvTAOy+yKHN5felENbS/iDphE/e8ZtViZqor6LPFXG1FhsoWiJ8c6k6p8OlBTF75k/jGsFnaAW0JOgV9sUa3QoKoSzZC3QjvcmGjImYDeNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=apCoGFlO; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753242452; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=N/DvoaUV4XUMGi7Qal/jmR/yKHgA90VGC0dhsQsvKMk=;
	b=apCoGFlOJCxQVE7WaV9aMqAjMUDm+k+lo/v1enrPKFnKEk9BvcyvM5/S964ybR1rvhTh99tRLPF8+YWbH8xZ1wRZsrDOpHvKdgPxtIs0Xw+FN/KkYuMsfzx7d+14R6316PwaSyPlXIJYPbn/yp0+vWi/QxKAPfljsyw4pMr859w=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjZl5p9_1753242451 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 11:47:32 +0800
Message-ID: <65476b79-e493-4f09-ab6b-3748ab679429@linux.alibaba.com>
Date: Wed, 23 Jul 2025 11:47:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] khugepaged: Optimize collapse_pte_mapped_thp() by
 PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com
Cc: ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250722150559.96465-1-dev.jain@arm.com>
 <20250722150559.96465-4-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250722150559.96465-4-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/22 23:05, Dev Jain wrote:
> Use PTE batching to optimize collapse_pte_mapped_thp().
> 
> On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
> Then, calling ptep_clear() for every pte will cause a TLB flush for every
> contpte block. Instead, clear_ptes() does a contpte_try_unfold_partial()
> which will flush the TLB only for the (if any) starting and ending contpte
> block, if they partially overlap with the range khugepaged is looking at.
> 
> For all arches, there should be a benefit due to batching atomic operations
> on mapcounts due to folio_remove_rmap_ptes() and saving some calls.
> 
> Note that we do not need to make a change to the check
> "if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
> to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
> pages of the folio will be equal to the corresponding pages of our
> batch mapping consecutive pages.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>

With David's comments addressed, LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

