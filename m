Return-Path: <linux-kernel+bounces-758985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87591B1D699
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DC3727280
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876CB279327;
	Thu,  7 Aug 2025 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D/QFU8O9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222420126A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565907; cv=none; b=K4gtZ7c2UIrUWf12F9xKpJcDAXxQ+s5/T8vjDz9NRiR5oDYqb8DTmQYfIIGB7qwVMzuzQp99wSbhB4YO+mOtulT8uhTgKeWBSvsj/Pm95UUpD1zWd3t3VSQpz4XwGN+6o7n8zoa5EmDpOD5pxuSxa0Y9TVCdudUUQtvhnFIKnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565907; c=relaxed/simple;
	bh=UKhNmjieTN7N6HBHjor9grjq3VWJiPT3ZEWXHyHQlXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrqm1I7zNN9pvrrvZ6O991f7jBYPWrwAnz0U8SOK4z9QuLOv8n5uMbzA6hqZYhQw+qtsm1cgvqK1WmGN9Pg4KuADG7p+Y/VDVJI5+xdIZ7HxnQ0V6fM1UotRM5JAd1XS5bes5pndxV8WmCCQmHVl3AjqfHCcUNK8Dj8iMYqowQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D/QFU8O9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459e210bd2dso6800875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754565903; x=1755170703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zqfBgbGZxLexl9YPolWTb1p84K6htyylxIPfQDbb+oI=;
        b=D/QFU8O9fieJ7KQ4tnxGfimTIXvBZBR1LNPpf1GkKHKbxZnWTBSyaIwGgA9u9YyNv8
         MPOZ9h+PFfFq9L7/CZk4+p6SnEpsQcus8cKo1dPep1EZOS8G5W9qtbaH3UGKRtwBqsrK
         TRkL+Mzu9+4mkvFs6loZvVF/wCUB5jjxwTEYQvG/4dcFgaE591sMPLiAcmeI3E7b/4GQ
         izTTVWa/k/RQV5efDLAqJUA3fko+B4yDkBYH0nxmjQmQHnVW7Uw6PCUBQna+NheUg2JI
         uHrl4wiWigFxycr+rYR8yIDLMFRd21HBk904aKwgCBxFwkr30YhAMuQ/ceux8FOnI11D
         bkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754565903; x=1755170703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqfBgbGZxLexl9YPolWTb1p84K6htyylxIPfQDbb+oI=;
        b=mTNs//FYnjfIsGfg0aslGv4MLICaTSVaTSPjK7O6T/Ocl/3KGofTzKEhNBFOifd76O
         4jdFTd17DznHU2piyk1faHYAitLRGyXOfue++lOQKmqDCQLolp0OQWHe/KY1zcQJWQMO
         0gXmTfRspnjhm4GTESTpkjiZJR4zWZfsf1USNWrjg5bTZHo27YB50H0QBTFikEvUm5kF
         yWgke2cAtS9lzxEgSYdXcFqQmxmRTFfEcvXTDt4M7hUpVPZM3qgUMTgChjcsnhrqG9W5
         vYpTrEIDxET+G/KqZO7oQAlT8vBntprSQhbXZfeos9dZyh6atXZgz9XyhWZAg3Nwry7d
         nBdg==
X-Forwarded-Encrypted: i=1; AJvYcCULmSQvZYnjE77NO9ZQ/aDcXNqggr63qjF7SCscIKP1a+UCn3sXpcBUD6WxckQyHMMAMKn5dryw6pJoBWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzhQkGVQnWBufcYUPWRuBQSqz0PMAS3QA08ggBawadl6rJIAuD
	I6JVCjPQhvT0OTB6iD6h/aEe61B5smCEHJvzGKCTB59rPQb4cUUeCTtKHUUNfFcDoUwMe9bC4q+
	IHOcvwCQ=
X-Gm-Gg: ASbGnct7Nug2ktkmxYU3i4ckHZQsCTZj6L4/uLxhh49+FHAh8DPzvkMrMRY0+r3l8XM
	2R/t8hV+X89uolWebF/dFGIyIe9G82bdVyUdvKjJ0oiSO5V+7bBRfQhf2r1QMP6WhWn09PpCoPm
	s7QP744K3dptMAUXpkB4iZlZcG2MqyYKCFNXKRuY9FHQUPzlxWolG4Gj8aw+HcASKuoGRkhHMBN
	Gj3QIlJOHsqj1aff3kvZ1eg7v02kQpaxTwGFZARi+Rf2l2vW3dHW2R+DxvPFGMgZcigmOWoWBTF
	8EkYRWlQloN4lcu1ySBb7Ht1APrN//QUAwdUNXxrRmXQ39I6XpMzY+1AxAUIIIyaASReTlJcNpY
	0My0utsHi9iWO0sZVprS5k0JN2FCjqRG7vlz5l6TOJEprZw==
X-Google-Smtp-Source: AGHT+IFke9/I6vAWg281k3PGpP+cXL76PFDyxOcVdfRR48mIHmjOc48urydXdscm5wsfvX8iadHkkg==
X-Received: by 2002:a5d:64c2:0:b0:3b7:8ed8:1c80 with SMTP id ffacd0b85a97d-3b8f97bc3e6mr2526097f8f.3.1754565902572;
        Thu, 07 Aug 2025 04:25:02 -0700 (PDT)
Received: from localhost (109-81-80-221.rct.o2.cz. [109.81.80.221])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3abf33sm26573824f8f.7.2025.08.07.04.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:25:02 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:25:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aJSNDcMxE5BVl6or@tiehlicka>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-7-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-7-urezki@gmail.com>

On Thu 07-08-25 09:58:08, Uladzislau Rezki wrote:
> __vmalloc_area_node() may call free_vmap_area() or vfree() on
> error paths, both of which can sleep. This becomes problematic
> if the function is invoked from an atomic context, such as when
> GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.
> 
> To fix this, unify error paths and defer the cleanup of partly
> initialized vm_struct objects to a workqueue. This ensures that
> freeing happens in a process context and avoids invalid sleeps
> in atomic regions.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

LGTM
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/vmalloc.h |  6 +++++-
>  mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index fdc9aeb74a44..b1425fae8cbf 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -50,7 +50,11 @@ struct iov_iter;		/* in uio.h */
>  #endif
>  
>  struct vm_struct {
> -	struct vm_struct	*next;
> +	union {
> +		struct vm_struct *next;	  /* Early registration of vm_areas. */
> +		struct llist_node llnode; /* Asynchronous freeing on error paths. */
> +	};
> +
>  	void			*addr;
>  	unsigned long		size;
>  	unsigned long		flags;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7f48a54ec108..2424f80d524a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3680,6 +3680,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	return nr_allocated;
>  }
>  
> +static LLIST_HEAD(pending_vm_area_cleanup);
> +static void cleanup_vm_area_work(struct work_struct *work)
> +{
> +	struct vm_struct *area, *tmp;
> +	struct llist_node *head;
> +
> +	head = llist_del_all(&pending_vm_area_cleanup);
> +	if (!head)
> +		return;
> +
> +	llist_for_each_entry_safe(area, tmp, head, llnode) {
> +		if (!area->pages)
> +			free_vm_area(area);
> +		else
> +			vfree(area->addr);
> +	}
> +}
> +
> +/*
> + * Helper for __vmalloc_area_node() to defer cleanup
> + * of partially initialized vm_struct in error paths.
> + */
> +static DECLARE_WORK(cleanup_vm_area, cleanup_vm_area_work);
> +static void defer_vm_area_cleanup(struct vm_struct *area)
> +{
> +	if (llist_add(&area->llnode, &pending_vm_area_cleanup))
> +		schedule_work(&cleanup_vm_area);
> +}
> +
>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				 pgprot_t prot, unsigned int page_shift,
>  				 int node)
> @@ -3711,8 +3740,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
> -		free_vm_area(area);
> -		return NULL;
> +		goto fail;
>  	}
>  
>  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> @@ -3789,7 +3817,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	return area->addr;
>  
>  fail:
> -	vfree(area->addr);
> +	defer_vm_area_cleanup(area);
>  	return NULL;
>  }
>  
> -- 
> 2.39.5

-- 
Michal Hocko
SUSE Labs

