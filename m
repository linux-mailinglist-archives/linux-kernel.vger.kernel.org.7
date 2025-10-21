Return-Path: <linux-kernel+bounces-863680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A5ABF8D24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58F1F505D36
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A724414;
	Tue, 21 Oct 2025 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbOumFyp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6427FD72
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079965; cv=none; b=MIXFdGDK+mZHJFy1/+KIixwYpVbkJNft4A772fcc4EeymjKP/PF18O5LCrYNpwBASBQy/ifBTP0d7t1EDuVcc5ZjQK/Yx4SBg7K/oYC4zBvtIwiG87R8rjvseV6C5oSxjWOmBp02QrI1u1X1CWgf4wq0lklTbM43tnmhhfHePp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079965; c=relaxed/simple;
	bh=zEARkqomtgeMl53hWrQxX1yqshfIy6HEB2OtbNbSCsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAtYu9xkZ77ynqw/PE35t4kWti/xTj0xGXaFahPUnibgQulTaG+FrddS/OavBE2ZvHJhNwxP1KC3wdoL6yzOahlCnQyk29FZrqkDsmjpcyvdasDxXKak4DSMR0lK55aACfcsOUHUFrcqgO+HcncLepHHyTf/bK64aTwsNBgxwb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbOumFyp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=70t8xOtesG4UTGBU4t4Siqy1bvWmQnoR0HwnhGPw72o=;
	b=fbOumFyplyNGsYR67Z1hfdM9MU0Ejd2PVCmfd056C+OzGYF2tY6xpasG5aqKuCw+FJ0NXY
	oDysBiJ0xh+Dsp5+sAsRzhMO+K3jwmSA4VSkJTioh8kT2eOxfWAPxr++FjVCJ3WgyuPjWS
	C64pMuyu1XKpNSfxQQOZ9FK3yCwT5jo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-X5IXeGjONceRu6slyjzFAA-1; Tue, 21 Oct 2025 16:52:41 -0400
X-MC-Unique: X5IXeGjONceRu6slyjzFAA-1
X-Mimecast-MFC-AGG-ID: X5IXeGjONceRu6slyjzFAA_1761079960
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475c422fd70so1623815e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079960; x=1761684760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70t8xOtesG4UTGBU4t4Siqy1bvWmQnoR0HwnhGPw72o=;
        b=iLglM02s3RIPddErFdgr8PozDdmij9llxAETrFkxFUdiOCFIRm0jhpIp4dvrQch4Gn
         1K4Aq1kCUKGQ06exCloEN2x3myHlAT2NFURD4hbNh6kAqp7g7JexjFGF1nYha83BkE3y
         kAC+mVW1hvJTrmKEWQMbBfNLOBQU/YNomIHh+7lHntTGEgJjUaPv1plWIbdJir8AeLo7
         CIjGycg99U9xs1PfNkYPGTqhVoUcd/0CfpGQrsC8naChOluT356KRrXn2+7JRy1Wyuxh
         JIvaSBpO1es5Gautwn46qap8mghbFz0ktV6SEYYAC68R4lmCR8xmzMcnjcbMDX9ejrXC
         oe4A==
X-Gm-Message-State: AOJu0YwsBBSsnH7Awhj0TcbPCoNBVxt5nTIoKp8oEDSlZNxApyTeeBNC
	pR+zp44jlvpym70nErhLqU0vf5FHcyVkUXOOzu4Tq4Jr20k8ePuSfyNKKb+oYfMy9EBLt6vc3nU
	daFeieDAcPIjy1xW3Ws4Uz7aGpfS00xxUxS8xqPUNwxWhkHBLRCmEUzYUVH+5R3oyHw==
X-Gm-Gg: ASbGncuOQ0zNep1SAjlA2H4rtohb1e0C+2jS/rEOpqGH/PKWyN5GL/BQE5AMZ+UbkIE
	kwIhEmqs3Qx30WT4iDhu1U3DNljS/5XT5OYHjgE2G0fi4haZe+3CQ5noLXo9H/NAKGdL2FyM3Wh
	pHHVkGaLPwn4BuWe5KQKH4umlpXJpz8TPvkrB0K3CLfPoplHyXsT99RWV10FyliG4Q8JoxruDfT
	ELYKzeqvY5yPRi4TeIwdcYXTfpN3uAa5orjr4gHbiSeKiClXh9btWuOXJDys1LuMSb8CI9/4U2+
	LBYzITf4EBZxR9M8FB9r/xSLzPl3iuYo2zWu8GjBGFEnEObp0czva5QdrhbiDZom/Are
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-471179123admr133169005e9.21.1761079960047;
        Tue, 21 Oct 2025 13:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzW0J+zMAHmrBKy98NPR2F9AVZqblG/q03JHaUVQ2fhOgcretSouuM7HYbCnzUNTNzgIF2SQ==
X-Received: by 2002:a05:600c:4ec9:b0:46e:2562:e7b8 with SMTP id 5b1f17b1804b1-471179123admr133168635e9.21.1761079959412;
        Tue, 21 Oct 2025 13:52:39 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce678sm22293933f8f.51.2025.10.21.13.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:52:38 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:52:33 -0400
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
Subject: Re: [PATCH v1 07/23] mm/balloon_compaction: use a device-independent
 balloon (list) lock
Message-ID: <20251021165040-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-8-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021125929.377194-8-david@redhat.com>

On Tue, Oct 21, 2025 at 02:59:12PM +0200, David Hildenbrand wrote:
> In order to remove the dependency on the page lock for balloon
> pages, we need a lock that is independent of the page.
> 
> It's crucial that we can handle the scenario where balloon deflation
> (clearing page->private) can race with page isolation (using
> page->private to obtain the balloon_dev_info where the lock currently
> resides).
> 
> The current lock in balloon_dev_info is therefore not suitable.
> 
> Fortunately, we never really have more than a single balloon device
> per VM, so we can just keep it simple and use a static lock to protect
> all balloon devices.
> 
> Based on this change we will remove the dependency on the page lock
> next.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/balloon_compaction.h |  6 ++---
>  mm/balloon_compaction.c            | 36 +++++++++++++++++-------------
>  2 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 3109d3c43d306..e2d9eb40e1fbb 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -21,10 +21,10 @@
>   *   i. Setting the PG_movable_ops flag and page->private with the following
>   *	lock order
>   *	    +-page_lock(page);
> - *	      +--spin_lock_irq(&b_dev_info->pages_lock);
> + *	      +--spin_lock_irq(&balloon_pages_lock);
>   *
>   *  ii. isolation or dequeueing procedure must remove the page from balloon
> - *      device page list under b_dev_info->pages_lock.
> + *      device page list under &balloon_pages_lock

Using &balloon_pages_lock with an & is kinda weird here.


>   *
>   * The functions provided by this interface are placed to help on coping with
>   * the aforementioned balloon page corner case, as well as to ensure the simple
> @@ -52,7 +52,6 @@
>   */
>  struct balloon_dev_info {
>  	unsigned long isolated_pages;	/* # of isolated pages for migration */
> -	spinlock_t pages_lock;		/* Protection to pages list */
>  	struct list_head pages;		/* Pages enqueued & handled to Host */
>  	int (*migratepage)(struct balloon_dev_info *, struct page *newpage,
>  			struct page *page, enum migrate_mode mode);
> @@ -71,7 +70,6 @@ extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  {
>  	balloon->isolated_pages = 0;
> -	spin_lock_init(&balloon->pages_lock);
>  	INIT_LIST_HEAD(&balloon->pages);
>  	balloon->migratepage = NULL;
>  	balloon->adjust_managed_page_count = false;
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index fd9ec47cf4670..97e838795354d 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -11,6 +11,12 @@
>  #include <linux/export.h>
>  #include <linux/balloon_compaction.h>
>  
> +/*
> + * Lock protecting the balloon_dev_info of all devices. We don't really
> + * expect more than one device.
> + */
> +static DEFINE_SPINLOCK(balloon_pages_lock);
> +
>  static void balloon_page_enqueue_one(struct balloon_dev_info *b_dev_info,
>  				     struct page *page)
>  {
> @@ -47,13 +53,13 @@ size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
>  	unsigned long flags;
>  	size_t n_pages = 0;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_for_each_entry_safe(page, tmp, pages, lru) {
>  		list_del(&page->lru);
>  		balloon_page_enqueue_one(b_dev_info, page);
>  		n_pages++;
>  	}
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  	return n_pages;
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
> @@ -83,7 +89,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  	unsigned long flags;
>  	size_t n_pages = 0;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_for_each_entry_safe(page, tmp, &b_dev_info->pages, lru) {
>  		if (n_pages == n_req_pages)
>  			break;
> @@ -106,7 +112,7 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  		dec_node_page_state(page, NR_BALLOON_PAGES);
>  		n_pages++;
>  	}
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  
>  	return n_pages;
>  }
> @@ -149,9 +155,9 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	balloon_page_enqueue_one(b_dev_info, page);
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  
> @@ -191,11 +197,11 @@ struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info)
>  		 * BUG() here, otherwise the balloon driver may get stuck in
>  		 * an infinite loop while attempting to release all its pages.
>  		 */
> -		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +		spin_lock_irqsave(&balloon_pages_lock, flags);
>  		if (unlikely(list_empty(&b_dev_info->pages) &&
>  			     !b_dev_info->isolated_pages))
>  			BUG();
> -		spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +		spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  		return NULL;
>  	}
>  	return list_first_entry(&pages, struct page, lru);
> @@ -213,10 +219,10 @@ static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  	if (!b_dev_info)
>  		return false;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_del(&page->lru);
>  	b_dev_info->isolated_pages++;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  
>  	return true;
>  }
> @@ -230,10 +236,10 @@ static void balloon_page_putback(struct page *page)
>  	if (WARN_ON_ONCE(!b_dev_info))
>  		return;
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	spin_lock_irqsave(&balloon_pages_lock, flags);
>  	list_add(&page->lru, &b_dev_info->pages);
>  	b_dev_info->isolated_pages--;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  }
>  
>  static int balloon_page_migrate(struct page *newpage, struct page *page,
> @@ -253,7 +259,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  	rc = b_dev_info->migratepage(b_dev_info, newpage, page, mode);
>  	switch (rc) {
>  	case 0:
> -		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +		spin_lock_irqsave(&balloon_pages_lock, flags);
>  
>  		/* Insert the new page into the balloon list. */
>  		get_page(newpage);
> @@ -272,7 +278,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  		}
>  		break;
>  	case -ENOENT:
> -		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +		spin_lock_irqsave(&balloon_pages_lock, flags);
>  
>  		/* Old page was deflated but new page not inflated. */
>  		__count_vm_event(BALLOON_DEFLATE);
> @@ -285,7 +291,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
>  	}
>  
>  	b_dev_info->isolated_pages--;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +	spin_unlock_irqrestore(&balloon_pages_lock, flags);
>  
>  	/* Free the now-deflated page we isolated in balloon_page_isolate(). */
>  	balloon_page_finalize(page);
> -- 
> 2.51.0


