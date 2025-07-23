Return-Path: <linux-kernel+bounces-741805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813ECB0E927
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A6C566493
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 03:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E5B2472B9;
	Wed, 23 Jul 2025 03:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EgUn2wyY"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549132472A1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753242041; cv=none; b=X1857QHDfsfROC7zMOoM1bdaqNPbTTp690xLtM0tLBV4PmT4iVBZehcCzvBoGrqoVsOcpyQxtlZPcMq6Yw1R8Ipo4cqf0n2ENqDa7cgIqH3ssTyc8zM/vCVPireu9WYdgBe2MfuP7RSn+0bkY3iiBBynACzOixXcA8rSrWpt72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753242041; c=relaxed/simple;
	bh=lRl7VPPpAA0W1NjXr1C8vfZsu5CFHxIatKy4IaAm40k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTp9wCV+1bTjEHIPSrtZC40g1vE0u5wuFWwZ8bGIP9r/D9CM3HmEtvt55CFVVKcHQYj6qvI0gc3lTOr5RCcBUv85XoG8lHYKuCBworkyQ0eNbaAkca0zlzkkqIjKmiUN1oeaWLzgI9Qn+cSdKNGgT7mMI5Z8xL8q+KxJrafdz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EgUn2wyY; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753242035; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Jf6FIqfTcFlhEp/DPUJUJMRfNEyNlTHHmVvqed14Bjg=;
	b=EgUn2wyYBixSK2Ip+8k4ajmjR1MDIpHatIPB7rFv1j2vK03MkJtDV8reXjvLs517Db699KuboZj7xixCQUpPAYGA7LY1XJH6JL0W02Hc4FlR/8pxUONb/PwkjVnq5ZTe7rMG7auHMTJ/sblbB+ty2Dq5447TvOL3S7QH1FEyxKU=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjZl3P._1753242034 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Jul 2025 11:40:35 +0800
Message-ID: <7387c4f3-d495-4f31-8222-27a782844473@linux.alibaba.com>
Date: Wed, 23 Jul 2025 11:40:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] khugepaged: Optimize
 __collapse_huge_page_copy_succeeded() by PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com
Cc: ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250722150559.96465-1-dev.jain@arm.com>
 <20250722150559.96465-3-dev.jain@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250722150559.96465-3-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/22 23:05, Dev Jain wrote:
> Use PTE batching to optimize __collapse_huge_page_copy_succeeded().
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
> Signed-off-by: Dev Jain <dev.jain@arm.com>

With David's comments addressed, LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

