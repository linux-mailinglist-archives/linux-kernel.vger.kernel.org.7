Return-Path: <linux-kernel+bounces-783416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0623AB32D57
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 05:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE37C18825EC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 03:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BFC190472;
	Sun, 24 Aug 2025 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DW9XDB63"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020312BD03
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 03:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756004871; cv=none; b=peLYk75deKOamtSP3lBhs+1PqYL/QOUNB+acqWwlr2Bfb1QptDMs/B6mpnQiN/U2zqGrsT+K3aTok1yYoxAF+Rscpydo6N59X9t+Q10jKhj5+G3wWaQ3hlpMA35aUDfqLmY6D/b1w9lEXanQXDl3o2Sx5YB5bHvD7K4jg8W5Bpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756004871; c=relaxed/simple;
	bh=clNEzDPVUx/gWE1f/vWBAsZWiH00PzySyedByx2bu1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8SPdr2JXmLhqQvrKgdfI1kVqQaY4D5dsyRxypVKpGrohm6CmB5MvfczH3i8RLsuomXko3+L9NGzVzEcMLceuTEt5Cieefde6q+NyHEvflXBWFgzRvYDEp68O64Pb7O0nIB5CL3OBzxzYcvJQooSy2QPU9z0PIZLAVV38c+F2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DW9XDB63; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756004866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miYmcZ7PQT39UWbb5PapaKAE5Ak3MX6JFaE0vARmqPw=;
	b=DW9XDB63wzlPDIQjIRX/YrhjYAZOIxyO+V8SsB+dPS+CvnnXgkP78dGW3QWIrWa3yQHhva
	15/yJUG6BGluOckPCzxGxsIjbhidgt2ps5Mpyc46ii4ko5i9ciLlRNOsSZtfk663nteE+X
	IcBhNMCzA4iHt6uUJ9vSvuD8i4Dj4W8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-tR_AURjPN1Wuh7rvfLaEWA-1; Sat,
 23 Aug 2025 23:07:42 -0400
X-MC-Unique: tR_AURjPN1Wuh7rvfLaEWA-1
X-Mimecast-MFC-AGG-ID: tR_AURjPN1Wuh7rvfLaEWA_1756004861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74DD4180045C;
	Sun, 24 Aug 2025 03:07:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAFBE180047F;
	Sun, 24 Aug 2025 03:07:38 +0000 (UTC)
Date: Sun, 24 Aug 2025 11:07:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu: fix race on alloc failed warning limit
Message-ID: <aKqB9sGmgJwsTXGg@MiWiFi-R3L-srv>
References: <ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab22061a-a62f-4429-945b-744e5cc4ba35@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/22/25 at 03:55pm, Vlad Dumitrescu wrote:
> The 'allocation failed, ...' warning messages can cause unlimited log
> spam, contrary to the implementation's intent.
> 
> The warn_limit variable is accessed without synchronization. If more
> than <warn_limit> threads enter the warning path at the same time, the
> variable will get decremented past 0. Once it becomes negative, the
> non-zero check will always return true leading to unlimited log spam.
> 
> Use atomic operations to access warn_limit and change the check to test
> for positive (> 0) as it can still become negative.
> 
> While the change cited in Fixes is only adjacent, the warning limit
> implementation was correct before it. Only non-atomic allocations were
> considered for warnings, and those happened to hold pcpu_alloc_mutex
> while accessing warn_limit.
> 
> Fixes: f7d77dfc91f7 ("mm/percpu.c: print error message too if atomic alloc failed")
> Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> ---
>  mm/percpu.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index a56f35dcc417..c1a4089eb4c3 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1734,7 +1734,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  	bool is_atomic;
>  	bool do_warn;
>  	struct obj_cgroup *objcg = NULL;
> -	static int warn_limit = 10;
> +	static atomic_t warn_limit = ATOMIC_INIT(10);
>  	struct pcpu_chunk *chunk, *next;
>  	const char *err;
>  	int slot, off, cpu, ret;
> @@ -1904,13 +1904,17 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  fail:
>  	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
>  
> -	if (do_warn && warn_limit) {
> -		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
> -			size, align, is_atomic, err);
> -		if (!is_atomic)
> -			dump_stack();
> -		if (!--warn_limit)
> -			pr_info("limit reached, disable warning\n");
> +	if (do_warn && atomic_read(&warn_limit) > 0) {
> +		int remaining = atomic_dec_return(&warn_limit);
> +
> +		if (remaining >= 0) {
> +			pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
> +				size, align, is_atomic, err);
> +			if (!is_atomic)
> +				dump_stack();
> +			if (remaining == 0)
> +				pr_info("limit reached, disable warning\n");
> +		}

A good catch, and the new code logic makes code more robust, thanks for
the fix.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  	}
>  
>  	if (is_atomic) {
> -- 
> 2.49.0
> 


