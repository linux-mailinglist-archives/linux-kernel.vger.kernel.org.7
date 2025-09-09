Return-Path: <linux-kernel+bounces-807271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E0B4A259
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1892C4E6F5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAE2566D3;
	Tue,  9 Sep 2025 06:35:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F84B302CB5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757399704; cv=none; b=XWjATMlS78KtcT3Cu6jMfGopRR9d7W0HLQY5b68qsjjJcpV8g8/T0LTsF0wR2sc7UoYTm+CvniNi9kV5EAI4+5iEKRZ7J0Z07VQFXZ7UdnWFyv11SVKw6e1RJ08DEO47zn0d8Pv3KBPw8gxJSAVAxEuUpE8o+UzqhFxwlX4afog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757399704; c=relaxed/simple;
	bh=1uGPKXCMs/UaB1i6RlIm+4ehTkaCjAKIWweeP1WxFYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGqsydzaeLzp1whWOSewEYkHbWueS1NJT+I5ddvFYwYwYs/hy/zxmlzFq+86E8OZMZ2zkKf9I4a1grDqJukkDl9aVLrmQ5vkCBNAiFhTd/T/HRsXlhvI1Dt56//+pw/+m0nGDCct9qsxEWt0jCJk1qdPW7IJYMnCn5k8eVuF27c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 110D315A1;
	Mon,  8 Sep 2025 23:34:53 -0700 (PDT)
Received: from [10.163.72.34] (unknown [10.163.72.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B33733F66E;
	Mon,  8 Sep 2025 23:34:56 -0700 (PDT)
Message-ID: <ad5f03ab-c543-438e-9b57-1f7f62cf8207@arm.com>
Date: Tue, 9 Sep 2025 12:04:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/slub: Refactor note_cmpxchg_failure for better
 readability
To: Ye Liu <ye.liu@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>, Harry Yoo <harry.yoo@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250909013307.1093853-1-ye.liu@linux.dev>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250909013307.1093853-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/25 7:03 AM, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> Use IS_ENABLED() and standard if-else to make the code clearer.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
> 
> ---
> Changes in v3:
> - Add "---" in front of the change log.
> Changes in v2:
> - Insert newline after && as it's more than 80 columns.
> ---
>  mm/slub.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 30003763d224..5711d6d29a3f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3064,18 +3064,17 @@ static inline void note_cmpxchg_failure(const char *n,
>  
>  	pr_info("%s %s: cmpxchg redo ", n, s->name);
>  
> -#ifdef CONFIG_PREEMPTION
> -	if (tid_to_cpu(tid) != tid_to_cpu(actual_tid))
> +	if (IS_ENABLED(CONFIG_PREEMPTION) &&
> +	    tid_to_cpu(tid) != tid_to_cpu(actual_tid)) {
>  		pr_warn("due to cpu change %d -> %d\n",
>  			tid_to_cpu(tid), tid_to_cpu(actual_tid));
> -	else
> -#endif
> -	if (tid_to_event(tid) != tid_to_event(actual_tid))
> +	} else if (tid_to_event(tid) != tid_to_event(actual_tid)) {
>  		pr_warn("due to cpu running other code. Event %ld->%ld\n",
>  			tid_to_event(tid), tid_to_event(actual_tid));
> -	else
> +	} else {
>  		pr_warn("for unknown reason: actual=%lx was=%lx target=%lx\n",
>  			actual_tid, tid, next_tid(tid));
> +	}
>  #endif
>  	stat(s, CMPXCHG_DOUBLE_CPU_FAIL);
>  }

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

