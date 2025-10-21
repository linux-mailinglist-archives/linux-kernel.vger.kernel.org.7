Return-Path: <linux-kernel+bounces-863672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F1BF8CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02C819A588F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC427E05E;
	Tue, 21 Oct 2025 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgWZ5Lhs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A80274666
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079842; cv=none; b=lxmA3rW+Sr19LjHhFT5Jk9DK2j+Bz/Zw54k4sgQoySxw/V7ATVk7Zn6Jh2vuHz5PfMdjW8qxJKpMiwt/x9piO+nPUHNYnug1as2ICgXHSUyQr/3UPaEVcBRcrw2L6jbe/cheQzr8J+CpeXCZZL9KdrATGpdkxe4MerXYPVO7LPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079842; c=relaxed/simple;
	bh=QDBlraqyu6zx5+q7VDBK7bVORJuWi0jsUuXBsZlIkSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHZk58axS2jGoA734LnpQUYTDY3DtJzIPSdW4tJ+2hl/wjF8mIjhboPVdAgyERihH7+Q4KcslekQSpFQ+M3YPFZ74gG6gan706pYrDQi1mVsuDj5nuUDXUQhrOnaW6/he71rgYODzoPPcJC0cAz27Ua69LDOp8J7D1f5zCfTL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgWZ5Lhs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RobzOFu/jAbh3b+O43Kdqr0UVxO/89X1DeZoncRJBNk=;
	b=JgWZ5Lhsy4JBiN71kZW1JucImCDffOK7HUdXXQLPQWAYKANnBtpl+YU0mgK9SYZZj+i0s7
	tn+zzIfl7lKm73NKOpHFW8ALhBtlJM3wc9zYbD5v5wmXG4anPnTFwNiwmMnQNBIPVeHFeU
	7Sp1uwC4PVRvPlYl3atx/hER7qzr+6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-X6QbHDLjPpK3BgDIRs8trA-1; Tue, 21 Oct 2025 16:50:37 -0400
X-MC-Unique: X6QbHDLjPpK3BgDIRs8trA-1
X-Mimecast-MFC-AGG-ID: X6QbHDLjPpK3BgDIRs8trA_1761079837
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47106720618so37943625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079836; x=1761684636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RobzOFu/jAbh3b+O43Kdqr0UVxO/89X1DeZoncRJBNk=;
        b=gPfGf4sLuInByBIVlszBVpoXnzJsASKMHaR+8snxgigVOA7mNVPn2lLfGWDBBfSfRR
         8F0H1hLR0Mdyp1aR2d3k+4P7E3tstwMHSsuug9Y8cxtHWIjSDUMf6ODAyqMYVapYcpae
         Yba/ykuZ7vXEAEFMWfYrpA1u2SeCb7x5nLCy1cgzUvZbulCJyJSUGPd09uIL6DRfh4AI
         RwcWJ8Wl2w/tuZFW6ah3X1s6GNJg+DI734RhhoTgZL26A3M/R816BlRwBNUjBPh4UXSp
         ylpYlwQaA5Kqx/vnEFv45puGAs7IZB72CAtasjFGBnNU3/EIGpadp3LKMPaaGSjDwqSJ
         ROBg==
X-Gm-Message-State: AOJu0YwzUCho4uxHM87Zq8vyvbY8iXhjdHAWX5ap/5xIdDDpdZ9Tm4BX
	Gb7QQ3mnp+UGjYskDoX0vjlDjugieqUgmZHRPV4HNzdVmR5s2W5Z2a7CRk8EUn+lmHlxBnFk+b2
	cJH/hd7RVmys2IA9Ma32AF5xMTCCUU1Gi+KAjrYpG1vPYB/IW2+lqJ+ISqivhqc1QIQ==
X-Gm-Gg: ASbGncv51MBFgJQ71fHIkI2gQCxsMjuoiBP6Mt8p3/CLpaR/MLaQ6IX1J2EeNEZeKhY
	Rbrq1BkF2hiaKiZYKVGU1zh/oHmJNJ70HcFityhrWDDaRnBlAX9eqV4p3FxAQf3nhnMITEx38bg
	1iErOUtuToknJZrwZSURoQsUnT1VbhQLNPZr+f04kqvcXtMOI4R6U7Vru1BNQp6w86LznnLm1J0
	pQS5yExP8UFlwwJCXumdvnQNAWfYwmapp8rr8zjvBcaFHdFG35+5J3EkHAZ5KfY03sYzJ4f+GzH
	yB8Bw+puJgviNDSJsRJyLYFnVX6tst2lMj9lDRnGLkDh3/MgWkg58+MguHmMr0QT/TRz
X-Received: by 2002:a05:6000:491d:b0:427:55b:cf6 with SMTP id ffacd0b85a97d-427055b0cf8mr13376212f8f.7.1761079836343;
        Tue, 21 Oct 2025 13:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPVkTYV9/EGaYL3AjJzNlCZb2bqURn+LcfpURQ5SbHxLnhrS59J1HFohnHIpwTzwj6nrQ5w==
X-Received: by 2002:a05:6000:491d:b0:427:55b:cf6 with SMTP id ffacd0b85a97d-427055b0cf8mr13376200f8f.7.1761079835780;
        Tue, 21 Oct 2025 13:50:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427c3bfsm11772045e9.3.2025.10.21.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:50:35 -0700 (PDT)
Date: Tue, 21 Oct 2025 16:50:31 -0400
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
Subject: Re: [PATCH v1 04/23] mm/balloon_compaction: centralize basic page
 migration handling
Message-ID: <20251021164916-mutt-send-email-mst@kernel.org>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-5-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021125929.377194-5-david@redhat.com>

On Tue, Oct 21, 2025 at 02:59:09PM +0200, David Hildenbrand wrote:
> Let's update the balloon page references, the balloon page list, the
> BALLOON_MIGRATE counter and the isolated-pages counter in
> balloon_page_migrate(), after letting the balloon->migratepage()
> callback deal with the actual inflation+deflation.
> 
> Note that we now perform the balloon list modifications outside of any
> implementation-specific locks: which is fine, there is nothing special
> about these page actions that the lock would be protecting.
> 
> The old page is already no longer in the list (isolated) and the new page
> is not yet in the list.
> 
> Let's use -ENOENT to communicate the special "inflation of new page
> failed after already deflating the old page" to balloon_page_migrate() so
> it can handle it accordingly.
> 
> While at it, rename balloon->b_dev_info to make it mach the other

match

> functions. Also, drop the comment above balloon_page_migrate(), which
> seems unnecessary.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/powerpc/platforms/pseries/cmm.c | 16 ---------
>  drivers/misc/vmw_balloon.c           | 49 +++++-----------------------
>  drivers/virtio/virtio_balloon.c      | 12 -------
>  mm/balloon_compaction.c              | 37 ++++++++++++++++++---
>  4 files changed, 41 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
> index 67c7309c36147..07b21d2bc8a78 100644
> --- a/arch/powerpc/platforms/pseries/cmm.c
> +++ b/arch/powerpc/platforms/pseries/cmm.c
> @@ -501,8 +501,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>  			   struct page *newpage, struct page *page,
>  			   enum migrate_mode mode)
>  {
> -	unsigned long flags;
> -
>  	/*
>  	 * loan/"inflate" the newpage first.
>  	 *
> @@ -517,9 +515,6 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>  		return -EBUSY;
>  	}
>  
> -	/* balloon page list reference */
> -	get_page(newpage);
> -
>  	/*
>  	 * When we migrate a page to a different zone, we have to fixup the
>  	 * count of both involved zones as we adjusted the managed page count
> @@ -530,22 +525,11 @@ static int cmm_migratepage(struct balloon_dev_info *b_dev_info,
>  		adjust_managed_page_count(newpage, -1);
>  	}
>  
> -	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> -	balloon_page_insert(b_dev_info, newpage);
> -	__count_vm_event(BALLOON_MIGRATE);
> -	b_dev_info->isolated_pages--;
> -	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> -
>  	/*
>  	 * activate/"deflate" the old page. We ignore any errors just like the
>  	 * other callers.
>  	 */
>  	plpar_page_set_active(page);
> -
> -	balloon_page_finalize(page);
> -	/* balloon page list reference */
> -	put_page(page);
> -
>  	return 0;
>  }
>  #else /* CONFIG_BALLOON_COMPACTION */
> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> index 07e60a4b846aa..52b8c0f1eead7 100644
> --- a/drivers/misc/vmw_balloon.c
> +++ b/drivers/misc/vmw_balloon.c
> @@ -1724,18 +1724,17 @@ static inline void vmballoon_debugfs_exit(struct vmballoon *b)
>   * @page: a ballooned page that should be migrated.
>   * @mode: migration mode, ignored.
>   *
> - * This function is really open-coded, but that is according to the interface
> - * that balloon_compaction provides.
> - *
>   * Return: zero on success, -EAGAIN when migration cannot be performed
> - *	   momentarily, and -EBUSY if migration failed and should be retried
> - *	   with that specific page.
> + *	   momentarily, -EBUSY if migration failed and should be retried
> + *	   with that specific page, and -ENOENT when deflating @page
> + *	   succeeded but inflating @newpage failed, effectively deflating
> + *	   the balloon.
>   */
>  static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>  				 struct page *newpage, struct page *page,
>  				 enum migrate_mode mode)
>  {
> -	unsigned long status, flags;
> +	unsigned long status;
>  	struct vmballoon *b;
>  	int ret = 0;
>  
> @@ -1773,14 +1772,6 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>  		goto out_unlock;
>  	}
>  
> -	/*
> -	 * The page is isolated, so it is safe to delete it without holding
> -	 * @pages_lock . We keep holding @comm_lock since we will need it in a
> -	 * second.
> -	 */
> -	balloon_page_finalize(page);
> -	put_page(page);
> -
>  	/* Inflate */
>  	vmballoon_add_page(b, 0, newpage);
>  	status = vmballoon_lock_op(b, 1, VMW_BALLOON_4K_PAGE,
> @@ -1799,36 +1790,12 @@ static int vmballoon_migratepage(struct balloon_dev_info *b_dev_info,
>  		 * change.
>  		 */
>  		atomic64_dec(&b->size);
> -	} else {
>  		/*
> -		 * Success. Take a reference for the page, and we will add it to
> -		 * the list after acquiring the lock.
> +		 * Tell the core that we're deflating the old page and don't
> +		 * need the new page.
>  		 */
> -		get_page(newpage);
> -	}
> -
> -	/* Update the balloon list under the @pages_lock */
> -	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
> -
> -	/*
> -	 * On inflation success, we already took a reference for the @newpage.
> -	 * If we succeed just insert it to the list and update the statistics
> -	 * under the lock.
> -	 */
> -	if (status == VMW_BALLOON_SUCCESS) {
> -		balloon_page_insert(&b->b_dev_info, newpage);
> -		__count_vm_event(BALLOON_MIGRATE);
> -	} else {
> -		__count_vm_event(BALLOON_DEFLATE);
> +		ret = -ENOENT;
>  	}
> -
> -	/*
> -	 * We deflated successfully, so regardless to the inflation success, we
> -	 * need to reduce the number of isolated_pages.
> -	 */
> -	b->b_dev_info.isolated_pages--;
> -	spin_unlock_irqrestore(&b->b_dev_info.pages_lock, flags);
> -
>  out_unlock:
>  	up_read(&b->conf_sem);
>  	return ret;
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 1b93d8c643612..8969271581bca 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -827,7 +827,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  {
>  	struct virtio_balloon *vb = container_of(vb_dev_info,
>  			struct virtio_balloon, vb_dev_info);
> -	unsigned long flags;
>  
>  	/*
>  	 * In order to avoid lock contention while migrating pages concurrently
> @@ -840,8 +839,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	if (!mutex_trylock(&vb->balloon_lock))
>  		return -EAGAIN;
>  
> -	get_page(newpage); /* balloon reference */
> -
>  	/*
>  	  * When we migrate a page to a different zone and adjusted the
>  	  * managed page count when inflating, we have to fixup the count of
> @@ -854,11 +851,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	}
>  
>  	/* balloon's page migration 1st step  -- inflate "newpage" */
> -	spin_lock_irqsave(&vb_dev_info->pages_lock, flags);
> -	balloon_page_insert(vb_dev_info, newpage);
> -	vb_dev_info->isolated_pages--;
> -	__count_vm_event(BALLOON_MIGRATE);
> -	spin_unlock_irqrestore(&vb_dev_info->pages_lock, flags);
>  	vb->num_pfns = VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	set_page_pfns(vb, vb->pfns, newpage);
>  	tell_host(vb, vb->inflate_vq);
> @@ -869,10 +861,6 @@ static int virtballoon_migratepage(struct balloon_dev_info *vb_dev_info,
>  	tell_host(vb, vb->deflate_vq);
>  
>  	mutex_unlock(&vb->balloon_lock);
> -
> -	balloon_page_finalize(page);
> -	put_page(page); /* balloon reference */
> -
>  	return 0;
>  }
>  #endif /* CONFIG_BALLOON_COMPACTION */
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 03c5dbabb1565..5444c61bb9e76 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -232,20 +232,49 @@ static void balloon_page_putback(struct page *page)
>  	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
>  }
>  
> -/* move_to_new_page() counterpart for a ballooned page */
>  static int balloon_page_migrate(struct page *newpage, struct page *page,
>  		enum migrate_mode mode)
>  {
> -	struct balloon_dev_info *balloon = balloon_page_device(page);
> +	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
> +	unsigned long flags;
> +	int rc;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
>  
>  	/* Isolated balloon pages cannot get deflated. */
> -	if (WARN_ON_ONCE(!balloon))
> +	if (WARN_ON_ONCE(!b_dev_info))
>  		return -EAGAIN;
>  
> -	return balloon->migratepage(balloon, newpage, page, mode);
> +	rc = b_dev_info->migratepage(b_dev_info, newpage, page, mode);
> +	switch (rc) {
> +	case 0:
> +		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +
> +		/* Insert the new page into the balloon list. */
> +		get_page(newpage);
> +
> +		balloon_page_insert(b_dev_info, newpage);
> +		__count_vm_event(BALLOON_MIGRATE);
> +		break;
> +	case -ENOENT:
> +		spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +
> +		/* Old page was deflated but new page not inflated. */
> +		__count_vm_event(BALLOON_DEFLATE);
> +		break;
> +	default:
> +		return rc;
> +	}
> +
> +	b_dev_info->isolated_pages--;
> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +
> +	/* Free the now-deflated page we isolated in balloon_page_isolate(). */
> +	balloon_page_finalize(page);
> +	put_page(page);
> +
> +	return 0;
>  }
>  
>  const struct movable_operations balloon_mops = {
> -- 
> 2.51.0


