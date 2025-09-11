Return-Path: <linux-kernel+bounces-812843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7CCB53D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB1B5A2A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047727F006;
	Thu, 11 Sep 2025 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVMkc7X+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712824A063
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624580; cv=none; b=GT0pOMkik0mjDwx9/kkVIfcph3cBzK82BhUQlv+fC9T5NidWj7qKfKhRX5KbdfJDfVeiSj+/VZUhqYkuf8wPtJskv/vgIqj7uMVkbHA4T5JkVUpoy/CtJFNvbIs83g8/nVhrly47y+TAPG8AdLpBZKyHPDh4wE53tEoAwvzGIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624580; c=relaxed/simple;
	bh=0nwZEdUtSEBzNMr7ezTplzEQ6D9rLJfG2FtFpNcQRVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1cNSIWtjVZ9FXXy0LZhIaHHY/Twv97SNldbqlxs/mGxwLQjORtr9Fv+n1aAygxg3QjONF/OLN0GdwekSKhfG0lJJbfKiIxMlI8ZeDB+TKYoWfRVk28VFfKLniIquDTYnZBWMiaQmR9qKmz81JntIykp5TU8o3+VcWsjlk6PeGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVMkc7X+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757624577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=neeodcNKdgRiJMDUF/tFhYUISt5/83xHMzNtxB2Jo68=;
	b=EVMkc7X+VZYZzFtAwyMz3TTsx+nJptMAcZnqK46mMSPGZ/ATTo8t9E1Q4Jd706GXxIEPAr
	64G8DEv6Bbd+HGiAhOzZw4YBlN4BZgli9+U13ilZ8gi1pverNUy4fffgyFycMeF7utLMQJ
	RMOfIANYtjpWUR+6oU/+MqDx/e/jhQM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-6c0q89lvOxCWVNYbagifoQ-1; Thu,
 11 Sep 2025 17:02:54 -0400
X-MC-Unique: 6c0q89lvOxCWVNYbagifoQ-1
X-Mimecast-MFC-AGG-ID: 6c0q89lvOxCWVNYbagifoQ_1757624573
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F40D619107DD;
	Thu, 11 Sep 2025 21:02:52 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.64.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FD6419560BD;
	Thu, 11 Sep 2025 21:02:50 +0000 (UTC)
Date: Thu, 11 Sep 2025 17:02:47 -0400
From: Phil Auld <pauld@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 06/33] sched/isolation: Save boot defined domain flags
Message-ID: <20250911210247.GB7235@pauld.westford.csb>
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-7-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829154814.47015-7-frederic@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 29, 2025 at 05:47:47PM +0200 Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
> 
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
> 
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Phil Auld <pauld@redhat.com>


> ---
>  include/linux/sched/isolation.h | 1 +
>  kernel/sched/isolation.c        | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index f98ba0d71c52..9262378760b1 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,6 +7,7 @@
>  #include <linux/tick.h>
>  
>  enum hk_type {
> +	HK_TYPE_DOMAIN_BOOT,
>  	HK_TYPE_DOMAIN,
>  	HK_TYPE_MANAGED_IRQ,
>  	HK_TYPE_KERNEL_NOISE,
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 2a6fc6fc46fb..fb414e28706d 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -11,6 +11,7 @@
>  #include "sched.h"
>  
>  enum hk_flags {
> +	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
>  	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>  	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
>  	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> @@ -204,7 +205,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  
>  		if (!strncmp(str, "domain,", 7)) {
>  			str += 7;
> -			flags |= HK_FLAG_DOMAIN;
> +			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>  			continue;
>  		}
>  
> @@ -234,7 +235,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  
>  	/* Default behaviour for isolcpus without flags */
>  	if (!flags)
> -		flags |= HK_FLAG_DOMAIN;
> +		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>  
>  	return housekeeping_setup(str, flags);
>  }
> -- 
> 2.51.0
> 
> 

-- 


