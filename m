Return-Path: <linux-kernel+bounces-863690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DFBBF8D71
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE46C189731A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABA02848A2;
	Tue, 21 Oct 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsRRpi7z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D1366
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761080261; cv=none; b=X4CWSdAGjRuZ10ESBS8TMGq6TOO1KDJiMwI7YMWGUmlXtaUJl0dwiAocQUf3PNn3j3hspiW6H7IQr1ienv599Z5ablbtC8bZsQfGK7P2vtOz27avddKRQ2CyKAhmwO8cvsHSwc7CCZ7+6Wtv/INFV9muzfXoUBScG1QXjtnDGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761080261; c=relaxed/simple;
	bh=PiEF4dZTXzB/bahHoYvpvUwN2xzfC3fULfkA9PjR6I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhJB96irF5iHdM58XQSKmkjkUs/QJ06A/9yEjnOpqIqCkvMhWulfMt9TvNa/zlO74IezsRiMc7DWHvxEepmntpgEtQ4C0UVT+CA+I0HzCdV1fDEH5Btv9QMAZ71i1Yq8iNt8DO5RgwbfwAwcjXRHMqRmYa+qIYMURj2znfNp66s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QsRRpi7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761080258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bAJqRa8uA5UrlbIgGaXWwm0Ps33WDl0PlkuKaJzgdU=;
	b=QsRRpi7zPGdwEv+PDNTXHMSWklKabZAG5PipGNRpMRGgAbTM17/lhuAhDvMD3XXyCMlJnJ
	/tld72mMyCL2Wd0gcSAgvmNgVqqT26njOg+7I/FnuWMeheCz5rtJiDwla5hZj3sA/gtwGe
	hOUPEfREa7/cHvckrrli5FpXbPxt1kk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-Gmvc9_-uP9yk1Ief-c4R5g-1; Tue, 21 Oct 2025 16:57:36 -0400
X-MC-Unique: Gmvc9_-uP9yk1Ief-c4R5g-1
X-Mimecast-MFC-AGG-ID: Gmvc9_-uP9yk1Ief-c4R5g_1761080256
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471005f28d2so23447875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761080256; x=1761685056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bAJqRa8uA5UrlbIgGaXWwm0Ps33WDl0PlkuKaJzgdU=;
        b=dOtKBBeiSfxdGVpENwYDmip5SSbN8vzPAd6xlKmyztGqJMiKEKmr3O2ZmKdY2Cidv0
         q5oD6CWRNfjzPySC001D/VQscND58s9XGS3bHZIPoiMFMH53CX8uGd9v5LKZ//ZgQAq9
         V3Nxlgsxyg6JK8hcAhYzMPYABw9b0sGt1mMmIGW1kuX2savLRU3KplcRz8pWMkERj+xl
         U7HJ5GQVoXkZhNAh/phK3tDJLku6JCkotGhcuBGsU0O+7sFuXocDu8jKl/dhCvdo6dAi
         3My2KejXnbmjp22ON6g/bsmgsyA2vsZS1zDLX456GpKppHVvtQBNOLkdcr5nRHZPgA/J
         /tdA==
X-Gm-Message-State: AOJu0YzP5RwL6dT6oOhT9xW91XhISJIIK1KARRRQlsBPmRktSLWBSuQH
	2ZZW83685dAyPG/wR29e5zNvHUn7r89LBaN1C7Zl34oUKWrVks5bYzNHIKHZ+qvtgHFhwS6AFih
	Yg/ei/cXGqQVDdKmwlAe4pfle9AWjjN5qc5H4wXwvzYvGfQuE8IQd8S+XbyAJRJ2CeQ==
X-Gm-Gg: ASbGncua2n6/FaJhmg0EnPv/U5hje3/8oeXoXoH0zLnKPtJIMhKuWz+Rj/0owID/K1R
	noV9zDxuFU1gaTdzwbOT9r8+y66jpCn/vnOO4QAgD7jzbhle9tMfHrYXwxl9m74HfLb09+44Xsz
	DnZYoVIwmx+KicLT8Pvvs7/XLB5WiUUWePZJvHwbAe4+9q0iMHdynTFOBW2FVHiIpx8+f/xwJsB
	skPR8Kgip/jLQiHC7aG/eEXJmokYsENmdEBRWehQzY8WDVfjffX1pZJ8Ozn9wtko6DHA/STVwa+
	N1AudnYZ3TuCmzD7DNqgErK/7U9PMicdNy4GQ78ObeiktP8QdFgffLwbfBAq32vG2VGr
X-Received: by 2002:a05:600c:8b8c:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-471178a4af1mr109338325e9.13.1761080255572;
        Tue, 21 Oct 2025 13:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnSG23+FoLb+GmLuXvkTK9R1YegvexPcW+2uOk5jzx98hZ61iH9ju7jBpY4P6BKlTjZs87DA==
X-Received: by 2002:a05:600c:8b8c:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-471178a4af1mr109337965e9.13.1761080255096;
        Tue, 21 Oct 2025 13:57:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428e9b2sm9981535e9.5.2025.10.21.13.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:57:34 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:57:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 06/23] vmw_balloon: stop using the balloon_dev_info
 lock
Message-ID: <20251021165626-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-7-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021125929.377194-7-david@redhat.com>

On Tue, Oct 21, 2025 at 02:59:11PM +0200, David Hildenbrand wrote:
> Let's not piggy-back on the existing lock and use a separate lock for the
> huge page list.

which is fine but it is worth documenting that we are also
no longer disabling interrupts while taking this lock.


> This is a preparation for changing the locking used to protect
> balloon_dev_info.
> 
> While at it, talk about "page migration" instead of "page compaction".
> We'll change that in core code soon as well.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/misc/vmw_balloon.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 52b8c0f1eead7..53e9335b6718c 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -354,10 +354,15 @@ struct vmballoon {
>  	/**
>  	 * @huge_pages - list of the inflated 2MB pages.
>  	 *
> -	 * Protected by @b_dev_info.pages_lock .
> +	 * Protected by @huge_pages_lock.
>  	 */
>  	struct list_head huge_pages;
>  
> +	/**
> +	 * @huge_pages_lock: lock for the list of inflated 2MB pages.
> +	 */
> +	spinlock_t huge_pages_lock;
> +
>  	/**
>  	 * @vmci_doorbell.
>  	 *
> @@ -987,7 +992,6 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  					unsigned int *n_pages,
>  					enum vmballoon_page_size_type page_size)
>  {
> -	unsigned long flags;
>  	struct page *page;
>  
>  	if (page_size == VMW_BALLOON_4K_PAGE) {
> @@ -995,9 +999,9 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  	} else {
>  		/*
>  		 * Keep the huge pages in a local list which is not available
> -		 * for the balloon compaction mechanism.
> +		 * for the balloon page migration.
>  		 */
> -		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
> +		spin_lock(&b->huge_pages_lock);
>  
>  		list_for_each_entry(page, pages, lru) {
>  			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
> @@ -1006,7 +1010,7 @@ static void vmballoon_enqueue_page_list(struct vmballoon *b,
>  		list_splice_init(pages, &b->huge_pages);
>  		__count_vm_events(BALLOON_INFLATE, *n_pages *
>  				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
> -		spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
> +		spin_unlock(&b->huge_pages_lock);
>  	}
>  
>  	*n_pages = 0;
> @@ -1033,7 +1037,6 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  {
>  	struct page *page, *tmp;
>  	unsigned int i = 0;
> -	unsigned long flags;
>  
>  	/* In the case of 4k pages, use the compaction infrastructure */
>  	if (page_size == VMW_BALLOON_4K_PAGE) {
> @@ -1043,7 +1046,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  	}
>  
>  	/* 2MB pages */
> -	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
> +	spin_lock(&b->huge_pages_lock);
>  	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
>  		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
>  
> @@ -1054,7 +1057,7 @@ static void vmballoon_dequeue_page_list(struct vmballoon *b,
>  
>  	__count_vm_events(BALLOON_DEFLATE,
>  			  i * vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
> -	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
> +	spin_unlock(&b->huge_pages_lock);
>  	*n_pages = i;
>  }
>  
> @@ -1828,6 +1831,7 @@ static int __init vmballoon_init(void)
>  		balloon.b_dev_info.migratepage = vmballoon_migratepage;
>  
>  	INIT_LIST_HEAD(&balloon.huge_pages);
> +	spin_lock_init(&balloon.huge_pages_lock);
>  	spin_lock_init(&balloon.comm_lock);
>  	init_rwsem(&balloon.conf_sem);
>  	balloon.vmci_doorbell = VMCI_INVALID_HANDLE;
> -- 
> 2.51.0


