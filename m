Return-Path: <linux-kernel+bounces-853880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 906E5BDCCCA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601FE4F56AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9503126C6;
	Wed, 15 Oct 2025 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XEpNLvCL"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E121A447
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760511268; cv=none; b=MBgGL6ZfX8ijxG7wOXsaWs+4Q2d9SpWnxKBlnSAZnWGBkuWQjKu/F5Nd5Udq2n+tu+cfEmcRy9pmSiUPidnU6PCHZ8J+XjIa0ftzIRrNt+hMXLIpUbY6qwdRF23m+x+P4OzvAII+1hiaHQ8YgKU1UMcpk3kqNwBP7FkTuDZStF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760511268; c=relaxed/simple;
	bh=H+bLSTNjM7MDRes65cB2r4IVsyR1inlkVQaTCTnMzSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGb+1k/wHDx6yWPY+E0E+YCLeTS3BHE0NAjn/aX4PVe+NWXCeJs4PSc68PuEz6VeRgcr98CntMKQSPUeY3DF+bNwM03+jckE6Artya/hFpWfXSrXZ/R1YZucDs0Q79Bg4dDLqpd15RmYd9AVmA9aaBWL3+kHhzMzUIKuWQqjQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XEpNLvCL; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <07ab102d-0034-43a5-9dad-e170e89ce60f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760511264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1G6utL5DCeqFuLtZqRhRDoOQLJbNPGUsAg7wYRENEs=;
	b=XEpNLvCLMvnVw+8R8y6htHgy5a76vZslYhcIgsbZaDrUPjBlqX4MN1Ym9q+/inQxF7bhT5
	/B/hSRF1Zch2wo0r8M9596xBjoJyDpRamB8NbdQRReSNcARcwHcV8rowAmr9cjjCLZyp7Q
	4rQ6A/htpGwShw8GTYnscLIEurFOUE8=
Date: Wed, 15 Oct 2025 14:54:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/khugepaged: fix comment for default scan sleep
 duration
Content-Language: en-US
To: wang lian <lianux.mm@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Rik van Riel <riel@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251015064333.31274-1-lianux.mm@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251015064333.31274-1-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/15 14:43, wang lian wrote:
> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
> 
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.
> 
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> ---

Thanks!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>   mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e947b96e1443..449f983b8891 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -67,7 +67,7 @@ enum scan_result {
>   static struct task_struct *khugepaged_thread __read_mostly;
>   static DEFINE_MUTEX(khugepaged_mutex);
>   
> -/* default scan 8*512 pte (or vmas) every 30 second */
> +/* default scan 8*512 pte (or vmas) every 10 second */
>   static unsigned int khugepaged_pages_to_scan __read_mostly;
>   static unsigned int khugepaged_pages_collapsed;
>   static unsigned int khugepaged_full_scans;


