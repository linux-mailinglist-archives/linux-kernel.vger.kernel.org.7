Return-Path: <linux-kernel+bounces-838073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F5BAE5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FAC1945529
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC31FF7B3;
	Tue, 30 Sep 2025 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P02JtSFV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A4185B67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258370; cv=none; b=Bm+xfzrAI/YLSXhU6mR7vxnD/WT2LxScvDGJ22T802dx23Ff4Jimm7SbGIy/VljUd0xXLnwjMVz4bAkUQ0eu81LW5lOLoLKmQyXCtB5lt/Z3uU0MzHdk7twxQ8dAZ7iu7qbP9qBWxv/pyoYxrYpyPN9gs80Fbk0K/UXSuMDYRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258370; c=relaxed/simple;
	bh=ZXAW7fxKjK0x3VBP8lwXn9w+MQkSkDyIV56sRoK673w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLlqcWAxmnzewnddjebXo753EhlGqyKwvebYyWrQJhhJW1fojRQf57DBRQRlrTEGkqZNMyi6J/x1oWnKbiOWSVaZe2xnMzmPiR8a5uwCVmenOQQF/14X9YF1d6SCr+MNfvE4cJZa3jGHRMxbz3drvn75fssIZUDVz4uANWxgRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P02JtSFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759258367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mIFqockUuM1xJzVFN3EXIFLgZfOpoUB5lLQdmavPc6M=;
	b=P02JtSFVII8NLv9+ucASVTADVn3HXI8qyE1KRzZPSXRNxTxKW3ix+HaoBrEiH0B3w0rAsQ
	XXwEz+dUOI1x5EX34APuY4GO0Z9FenZ0Qxt78sjUGDCxUBFwBIcbg3m25fTooVZz0UvSOF
	tO2f4auDoJ6ZM/10F3SgflhMALgVMjg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-xduBd6Y4MNaijJCxiShYyA-1; Tue, 30 Sep 2025 14:52:46 -0400
X-MC-Unique: xduBd6Y4MNaijJCxiShYyA-1
X-Mimecast-MFC-AGG-ID: xduBd6Y4MNaijJCxiShYyA_1759258365
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-86b8db0e70dso3789736d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258365; x=1759863165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIFqockUuM1xJzVFN3EXIFLgZfOpoUB5lLQdmavPc6M=;
        b=s15ETG72otPXhOzeRqwhZEV9xycREBSvQ7ezFY9x2xD9+y2lPWsL9zNjlEEW/ur/9+
         D8pn+5sJ1XFezqWkeCMk67USFbSQANha4LrhS33LEi7zu2MXcJaCTGmqSeqRvskWVmFa
         oXbppmS7RgikfqBQK88djhYorWqcBOqF7M4U0XtcWSVA8kGYZl9WmP8V+itOt9S8XycW
         EKa6E0VZiZh4h23+xCexPtq6RxaMXr6aH6L9nDAYol+0BYj1BgRaIo/nB8j34etsdVqX
         nTFz7hnDSSwIIlxQwQ6q1eDT8sD1z509kJN0k6fjiwH4Q2mvX7qNDbRKLxuVCxoB2eSA
         QBFw==
X-Forwarded-Encrypted: i=1; AJvYcCWdox2QsWX/WpJ6B1dObg8Xy9Urx+flkVLL19jvEDuK6bEWAq+OC2aDx0eGnhyJ+Uba+rHM5jkrk9QTKP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Su0PiDmy/ztblCP49bJ/RWs1k8ZMtYgaY045Gy3UPSIjb4PZ
	khC0meUcoN5uWpYkays2lYS4SdI3hjDBwGYrKJPHMBIbYtX1F/zTIhUyfKY1mhutlyihia6T9gX
	1v2nk4ubnh30MIYpSddRLl2nS2tO8Uw3ykfsZkRWZCYvnOHXAR4RZ6Kmm0lRLfYfpvQ==
X-Gm-Gg: ASbGncsbQ+//elhOQZ/aUgUYGgXA4Y8OrXhlUrCnCbR79RCZ56RQQLaRTGpTtA0PNl2
	MpbyM95SIxIu0oykGOWCT/ztlGNq/mBk8hunImfyTl7nqyVCCySssjFxFomj0CiKrObnm59Evhg
	t83y+eNF/HkmzhoH6rCn5uvvqW2UWg5mYIphB8ot3M787mVdajjNnbC8pKlFmFDsKJ8SK6N/AKd
	USxC6qLpD/E3NzJycPpWBkJu4yIrP+KdMAUsDWdIQ0tEiav/Vt8CqJtXTnR4mBbYoPXx4f10soh
	r+XWIAXcw4+jC9S9fEMrG5SFOCAYIA6uBgUvzw==
X-Received: by 2002:a05:6214:d8d:b0:78e:8752:826e with SMTP id 6a1803df08f44-87372974cffmr13467646d6.7.1759258365451;
        Tue, 30 Sep 2025 11:52:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgx2UMaIQ4cNuoiBjSCdSRF49bjJYFxrd6Ahvl6VR/9Pmg8B4boKNrNZqb1or1xhMLXMpJWA==
X-Received: by 2002:a05:6214:d8d:b0:78e:8752:826e with SMTP id 6a1803df08f44-87372974cffmr13467316d6.7.1759258364914;
        Tue, 30 Sep 2025 11:52:44 -0700 (PDT)
Received: from x1.local ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8745fa88b8fsm1153106d6.19.2025.09.30.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 11:52:44 -0700 (PDT)
Date: Tue, 30 Sep 2025 14:52:42 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v3 4/4] mm: Apply vm_uffd_ops API to core mm
Message-ID: <aNwm-uAt98KA9Euh@x1.local>
References: <20250926211650.525109-1-peterx@redhat.com>
 <20250926211650.525109-5-peterx@redhat.com>
 <0a60d99b-fa3b-482b-8171-ac63dcdf3168@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a60d99b-fa3b-482b-8171-ac63dcdf3168@redhat.com>

On Tue, Sep 30, 2025 at 11:23:19AM +0200, David Hildenbrand wrote:
> On 26.09.25 23:16, Peter Xu wrote:
> > Move userfaultfd core to use new vm_uffd_ops API. After this change file
> > systems that implement vm_operations_struct can start using new API for
> > userfaultfd operations.
> > 
> > When at it, moving vma_can_userfault() into mm/userfaultfd.c instead,
> > because it's getting too big.  It's only used in slow paths so it shouldn't
> > be an issue.  Move the pte marker check before wp_async, which might be
> > more intuitive because wp_async depends on pte markers.  That shouldn't
> > cause any functional change though because only one check would take effect
> > depending on whether pte marker was selected in config.
> > 
> > This will also remove quite some hard-coded checks for either shmem or
> > hugetlbfs.  Now all the old checks should still work but with vm_uffd_ops.
> > 
> > Note that anonymous memory will still need to be processed separately
> > because it doesn't have vm_ops at all.
> > 
> > Reviewed-by: James Houghton <jthoughton@google.com>
> > Acked-by: Mike Rapoport <rppt@kernel.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> [...]
> 
> > +++ b/mm/userfaultfd.c
> > @@ -20,6 +20,43 @@
> >   #include "internal.h"
> >   #include "swap.h"
> > +bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
> > +		       bool wp_async)
> > +{
> > +	unsigned long supported;
> > +
> > +	if (vma->vm_flags & VM_DROPPABLE)
> > +		return false;
> > +
> > +	vm_flags &= __VM_UFFD_FLAGS;
> > +
> > +#ifndef CONFIG_PTE_MARKER_UFFD_WP
> 
> While at it, you can turn that into an
> !IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP) to avoid the ifdef.
> 
> > +	/*
> > +	 * If user requested uffd-wp but not enabled pte markers for
> > +	 * uffd-wp, then any file system (like shmem or hugetlbfs) are not
> > +	 * supported but only anonymous.
> > +	 */
> > +	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
> > +		return false;
> > +#endif
> > +	/*
> > +	 * If wp async enabled, and WP is the only mode enabled, allow any
> > +	 * memory type.
> > +	 */
> > +	if (wp_async && (vm_flags == VM_UFFD_WP))
> > +		return true;
> 
> 
> > +
> > +	if (vma_is_anonymous(vma))
> > +		/* Anonymous has no page cache, MINOR not supported */
> > +		supported = VM_UFFD_MISSING | VM_UFFD_WP;
> > +	else if (vma_get_uffd_ops(vma))
> > +		supported = vma_get_uffd_ops(vma)->uffd_features;
> > +	else
> > +		return false;
> 
> To avoid the hidde return here, I think you can just do
> 
> 	supported = 0;
> 
> 
> Or even cleaner, just do
> 
> unsigned long supported = 0
> ...
> if (vma_is_anonymous(vma))
> 	supported = ...
> else if (vma_get_uffd_ops(vma))
> 	supported = ...
> return ...
> 
> > +
> > +	return !(vm_flags & (~supported));
> 
> I think this can just be:
> 
> 	return !(vm_flags & ~supported);

Sure thing, I'll apply everything you mentioned above.

Thanks,

-- 
Peter Xu


