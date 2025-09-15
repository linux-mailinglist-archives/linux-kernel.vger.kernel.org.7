Return-Path: <linux-kernel+bounces-816061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FC3B56EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46B33B8105
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAF2652A4;
	Mon, 15 Sep 2025 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="k0haYbzR"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AD2627EC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757907385; cv=none; b=MJ1Ef7qMyevaFubh6tl+Bd3dcdiN2NmFG94o3y3VbREU5ZZx2fOnAWXilu0jET9DHhPzrrBVAw1zgiR/FAVUxny+VVAST4wa0s7Jxxg5VY7zPBMN6FjyxKSEqlKxcNiJyEfrXBoMCETo5BxWRXnc15QrrsX2roEDxAG6IWa1ghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757907385; c=relaxed/simple;
	bh=YbH6kjZJpOqPzrs7+Dvb+JeajuKzFh/6OSslPqMKEzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm6rFlHEhhpC0x0v1hWZo3C+mTzWIBZEyxzDN/6r4be5dLR5o8AHCn1ELyLBvjNXxEWkzd7mhl5sN1LJCgXC9iHNIV5nfSL73V8JTiVFZSj07dzpM08eF/7E7cAyfesY2fBrIpylkHIokmfZ9OdcZgrzfxB5Gtgz/8pZJz4aT0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=k0haYbzR; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757907374; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2b6sC4/5fn9cn7zC7Lhch8bDm46TCCw/xd6ul129aIg=;
	b=k0haYbzR4oQN00/MbDH/8+KsfR/E9N1haXdek6Gr62vtpCtq3onF4h/kyT2FuAEBx63TtBdC+rBen1U5vxuw1RtXVLQQ95HCZGcPOGnOO6e6YmB1jyJMx8LTl3v+/FjEipSkK72aCIAXYrU05GV6wSpYL82iK0NsJBS9KImmuiU=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnxDIio_1757907373 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 15 Sep 2025 11:36:13 +0800
Message-ID: <fef6da33-2035-480d-9351-bd2ef066b3ba@linux.alibaba.com>
Date: Mon, 15 Sep 2025 11:36:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/13 00:58, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> MADV_COLLAPSE on a file mapping behaves inconsistently depending on if
> PMD page table is installed or not.
> 
> Consider following example:
> 
> 	p = mmap(NULL, 2UL << 20, PROT_READ | PROT_WRITE,
> 		 MAP_SHARED, fd, 0);
> 	err = madvise(p, 2UL << 20, MADV_COLLAPSE);
> 
> fd is a populated tmpfs file.
> 
> The result depends on the address that the kernel returns on mmap().
> If it is located in an existing PMD table, the madvise() will succeed.
> However, if the table does not exist, it will fail with -EINVAL.
> 
> This occurs because find_pmd_or_thp_or_none() returns SCAN_PMD_NULL when
> a page table is missing, which causes collapse_pte_mapped_thp() to fail.
> 
> SCAN_PMD_NULL and SCAN_PMD_NONE should be treated the same in
> collapse_pte_mapped_thp(): install the PMD leaf entry and allocate page
> tables as needed.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---

Make sense to me. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

