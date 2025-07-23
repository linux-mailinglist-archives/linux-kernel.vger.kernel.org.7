Return-Path: <linux-kernel+bounces-742014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E61B0EBED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D86D1C22501
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0C274B32;
	Wed, 23 Jul 2025 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qylPVJnd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699D325291F
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255890; cv=none; b=JgwP03Rsty82SRKECXlyu4g2pjw79EBWJGxM0oQ/uScbPa/Pvog/gQmQNOIcAteyFPbiorATodRlK3msJng7s7eKVj8AeIssY6aACrz+PYeQl8ak2A5qCS6VqqhP5CzfTI12hQlI7hSvdhme7oIhanbHpu2MGWeYEiJ3rL0GF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255890; c=relaxed/simple;
	bh=MPGvewvNycI1DIvPEIiTbeqHEpcxVhIqLFJUB/m7jWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbL2cEj0P3DJomXG6wZBFoErRbhlmo6qhUQVFFm3redtQFsHLPtyzR1LPcxGn7uWuFMNiNpDhDuJBQV67H6YkdSMFAiqqqWQF7AfALdSfLVVc4/XLlTp2VcQlcUF6v5S+Qoc2JevgcOo5GHVAXScFHsj9dOLWeoKSxk6spalrRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qylPVJnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67BBC4CEE7;
	Wed, 23 Jul 2025 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753255889;
	bh=MPGvewvNycI1DIvPEIiTbeqHEpcxVhIqLFJUB/m7jWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qylPVJndUKKL8DwoPy3gYpl9fmvTooHAbAQ1daxBPDeDKDCk8SWUMFU1Ti/jVnKyl
	 mAc74zgzYpJ3AwTa63E7zdNXA6xzOXajAlcIXeaxxm3FkvCWW1Kmff5APHgxYHA+68
	 kN5yu//7bzB9iZ8GeUCBFaUoGt/gCR23jQa7ofrrOQUuc4UYCBl1Xszn9B3bbEskcT
	 1H3Q24WJFyTgc6R8GumQq8Pe726lZgf0noazkhGqNA5NfoWBAqNZeSIibXN8vjXnvn
	 6aZCpI3OSBpx5loAUugrwM/2SoyPhkTjbhB/dtPmousTLLeCm8Mu1pJP9q9fakK4H4
	 ICSGWIrApgkIw==
Date: Wed, 23 Jul 2025 00:31:28 -0700
From: Kees Cook <kees@kernel.org>
To: Xuanye Liu <liuqiye2025@163.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
Message-ID: <202507230031.52B5C2B53@keescook>
References: <20250723072350.1742071-1-liuqiye2025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723072350.1742071-1-liuqiye2025@163.com>

On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
> The check_mm() function verifies the correctness of rss counters in
> struct mm_struct. Currently, it only prints an alert when a bad
> rss-counter state is detected, but lacks sufficient context for
> debugging.
> 
> This patch adds a dump_stack() call to provide a stack trace when
> the rss-counter state is invalid. This helps developers identify
> where the corrupted mm_struct is being checked and trace the
> underlying cause of the inconsistency.

Why not just convert the pr_alert to a WARN?

-Kees

> 
> Signed-off-by: Xuanye Liu <liuqiye2025@163.com>
> ---
>  kernel/fork.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cfe2f1df5f27..d38f1c5270ea 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -584,9 +584,11 @@ static void check_mm(struct mm_struct *mm)
>  	for (i = 0; i < NR_MM_COUNTERS; i++) {
>  		long x = percpu_counter_sum(&mm->rss_stat[i]);
>  
> -		if (unlikely(x))
> +		if (unlikely(x)) {
>  			pr_alert("BUG: Bad rss-counter state mm:%p type:%s val:%ld\n",
>  				 mm, resident_page_types[i], x);
> +			dump_stack();
> +		}
>  	}
>  
>  	if (mm_pgtables_bytes(mm))
> -- 
> 2.43.0
> 

-- 
Kees Cook

