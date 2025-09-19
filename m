Return-Path: <linux-kernel+bounces-823941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 176E2B87C68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBB580D68
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CE238C07;
	Fri, 19 Sep 2025 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CtAtlHtg"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE009478
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251689; cv=none; b=ir4b2GZzLyD5g9sLCf74GXOCLzcidA6Fn5SwK3Lsh9E8JSq3w6YvJ3xGqqw6aqXgqt2X4sE9TGnbMPo1GuIe4QUFUmcOKhpCOjUZ6qnFWxZkp1OuE6pLZL1ALR1Am3xVPnaFBsNazfHoTSYvvS8rvdXzPXLRCak/rh4rjHfwCgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251689; c=relaxed/simple;
	bh=pJAohj3VMYcJskPFPtsFk8xZyx+fXM3CTkBctgOp/BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxdlIg6O1ZtkU+5nXLAFgIcgyBL/DqjSSa3W95AfhKU9JLhKZy4Pv1jPH5Tic0R7OA1g8SEOBfBKyS76PWQa0YCv7hvnuPf/Sq08RJmMCLX6Iyp2FPCefXBpfmPQoZVK+cc/ug7pC/ui37JWBi0VLf15yTBcnoxLcTW1+eNe35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CtAtlHtg; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758251678; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VNF2HnpXEMFwsdgXnhG3INUAuZBTmmdmXHxWPTY6uCI=;
	b=CtAtlHtgEjNXuO/x6pKqqfUVhetdQ6xaw+K1O3Om77xml9ASPup2OVEj2YUaNSIKl1CeFfNo+zA8aWvxHbWTeX5y/1fylM8m04jvPI4r03SuWTZ2cat0mEg6Dg22PPJOlpgcZiKQHXuS24+BduZi4kPeuLgycCT0+kW9wglsNEQ=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoIItER_1758251677 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 11:14:38 +0800
Message-ID: <4cfefb25-567f-4137-9fba-fb3db041016c@linux.alibaba.com>
Date: Fri, 19 Sep 2025 11:14:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/15 21:52, Kiryl Shutsemau wrote:
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

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

