Return-Path: <linux-kernel+bounces-670280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C547ACABDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 11:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CB63BAD94
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EEF8BE5;
	Mon,  2 Jun 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifctOPf5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34991E0E0B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Jun 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857680; cv=none; b=RzvR3R+IoCpTLfAXw9OX6RUIZMgxlJtAf/J+99MQVbbunPf0eREJIuV140XB/RBhZ6RorlRoTQmOcYoPntqPASi++FfKbldB2B0a11L4JheETbjjDP/aQZn6s/wb5I0p5kyZcBkM5T94ckG/t3oeeCAXPGLYae5lUbkBOvQRTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857680; c=relaxed/simple;
	bh=7H8b+aQ2gBAHnGRYB2rLF/I8QqnMFJYdB9XEBhQ78JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vc+nxlGyJFuy3ecsryH3kobhBuLdyxGmP9FrL4G1haEzy6HXwqXDrvc6s17d7pnJLDI5oxaCwMzlLRofpU6Am6KXwthyfI481WFpVTrWdk8UG7x1cTcAo/vl5URzWT3UqGF5b/mJMrg3qkvrtAMBN8Hjk32gPhRNd6aGK5wAGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifctOPf5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748857677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2tmI4i9XNMMwk5r/a8fCoF59y2TFTZbkN1PcZ1/pQX8=;
	b=ifctOPf5WvhF43XKyxtQFBYFPsF5UgHXMGGeLRxlYwS2UPpWfVKOAbMIphAaEvQCwMXAS0
	g1TrLt/xqzOgQkf56VSVwB8eYm+c42rFV1VFbZvyWxIey3Ls93UoNY5qJem2mmN8KDaHY4
	Viy3xbzkluZ1dxZrLShdcppnHB0hcUo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-_gDF8PkSNleURV-M8eUYfA-1; Mon, 02 Jun 2025 05:47:54 -0400
X-MC-Unique: _gDF8PkSNleURV-M8eUYfA-1
X-Mimecast-MFC-AGG-ID: _gDF8PkSNleURV-M8eUYfA_1748857673
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-450d290d542so21771055e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jun 2025 02:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857673; x=1749462473;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2tmI4i9XNMMwk5r/a8fCoF59y2TFTZbkN1PcZ1/pQX8=;
        b=fk0f92TgB3CJcb/0dgMi3iai8huY59cl6mmhs2rU+xGSU4HmnktSrQs7c/8bQKpN1W
         3aY3FDS4v5vh23/s+7pmLCWFwfjGfzV17g5mOf8CtivG1NjZ+J2isZtiRyvwCzOPO4/l
         mCty++YDCck57OcBK931ICPTaAO7oXOK6TL1L1AxV7bkKgs3dBTPsRFGplMa0LectvQ9
         U6k1PK6Xnsxhwtdn6Z8pnAffJaXRyAf4ukX0DJ4u3N/lZEtYpN19PV6bbf8yVb9yq7Lf
         NWTNiwwcJSatyz7btotOp3nIPYERsiT+g+A7IyqlJ5HshlcTzD8jPwZIJKQP9+coUE9Y
         ODjg==
X-Forwarded-Encrypted: i=1; AJvYcCVXor7vMS1U8PrwOxOYYgFno3/OTzbuPplMyctLYmHz/rD8aREiGy6EdHVxB99reWWwSEAOBBfkNY43ZNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VOFmxLJ4zg9tO6Deza7JMeoudqac1JRrDxRMxW3hwrxjmSDD
	nFd3Vp+fi8j5Z4jTqy2dqTuHR+PNnmtWwl73E1li5okGxu96eE532a7aGabPLBcTQuduYmwZMTl
	GYMBNuB1s/Dg+4OVq4VoQd7SAqTcYgPPea1VSaFBXktCzXAW1JO/1HBnL7pjcLAYSBQ==
X-Gm-Gg: ASbGncuI76Psne7SWEqLqjiGiWfyzjNjEZEjB780itul1Utn4bWUKY9a2UeLJp0Sz7F
	h622RBwTIAnRhOaMW+Q7Wh0nRgA1WJU6X78txQknVeQyHrSYFDHaz730kVDNC1AMIWsdGbybfUX
	9YNCVYIPhT99/qqDMK3EfjzGiG2lYlV+vYV0EzMg0cUOtOK1IfuUOEinMtFKzUChqgjARdqArGP
	6jwA4vXp/tcFA0byKAspAPzrJD82KD3yCghrgSAclNQAnD7I6PRPbx8qxEWEzn6PesmGYNoMlOR
	IdaUQ4TSmjFvbcHyIjQwD0Li80pvUVCKOJBaXu190e0Qqws5LhDrXNujY3vVa5O2rBX7hlPG2lV
	LyH82ENBc2XO/TxVH3bNKtG0AgMewogDBGkAajeo=
X-Received: by 2002:a05:600c:8509:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-450d64bde2fmr98059975e9.7.1748857672679;
        Mon, 02 Jun 2025 02:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX5eP0sfwAIgPaqNbJ2YAmr7pr68u8u6MKoOVdPFmeSCEzM4/VEozGJjKu6VBo4Odi6F7MXA==
X-Received: by 2002:a05:600c:8509:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-450d64bde2fmr98059685e9.7.1748857672149;
        Mon, 02 Jun 2025 02:47:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb051bsm114640885e9.18.2025.06.02.02.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 02:47:51 -0700 (PDT)
Message-ID: <de0f2cb8-aed6-436f-b55e-d3f7b3fe6d81@redhat.com>
Date: Mon, 2 Jun 2025 11:47:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] fbdev/deferred-io: Support contiguous kernel
 memory framebuffers
To: mhklinux@outlook.com, simona@ffwll.ch, deller@gmx.de,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, akpm@linux-foundation.org
Cc: weh@microsoft.com, tzimmermann@suse.de, hch@lst.de,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-mm@kvack.org
References: <20250523161522.409504-1-mhklinux@outlook.com>
 <20250523161522.409504-4-mhklinux@outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250523161522.409504-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.05.25 18:15, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current defio code works only for framebuffer memory that is allocated
> with vmalloc(). The code assumes that the underlying page refcount can
> be used by the mm subsystem to manage each framebuffer page's lifecycle,
> including freeing the page if the refcount goes to 0. This approach is
> consistent with vmalloc'ed memory, but not with contiguous kernel memory
> allocated via alloc_pages() or similar. The latter such memory pages
> usually have a refcount of 0 when allocated, and would be incorrectly
> freed page-by-page if used with defio. That free'ing corrupts the memory
> free lists and Linux eventually panics. Simply bumping the refcount after
> allocation doesn’t work because when the framebuffer memory is freed,
> __free_pages() complains about non-zero refcounts.
> 
> Commit 37b4837959cb ("video: deferred io with physically contiguous
> memory") from the year 2008 purported to add support for contiguous
> kernel memory framebuffers. The motivating device, sh_mobile_lcdcfb, uses
> dma_alloc_coherent() to allocate framebuffer memory, which is likely to
> use alloc_pages(). It's unclear to me how this commit actually worked at
> the time, unless dma_alloc_coherent() was pulling from a CMA pool instead
> of alloc_pages(). Or perhaps alloc_pages() worked differently or on the
> arm32 architecture on which sh_mobile_lcdcfb is used.
> 
> In any case, for x86 and arm64 today, commit 37b4837959cb9 is not
> sufficient to support contiguous kernel memory framebuffers. The problem
> can be seen with the hyperv_fb driver, which may allocate the framebuffer
> memory using vmalloc() or alloc_pages(), depending on the configuration
> of the Hyper-V guest VM (Gen 1 vs. Gen 2) and the size of the framebuffer.
> 
> Fix this limitation by adding defio support for contiguous kernel memory
> framebuffers. A driver with a framebuffer allocated from contiguous
> kernel memory must set the FBINFO_KMEMFB flag to indicate such.
> 
> Tested with the hyperv_fb driver in both configurations -- with a vmalloc()
> framebuffer and with an alloc_pages() framebuffer on x86. Also verified a
> vmalloc() framebuffer on arm64. Hardware is not available to me to verify
> that the older arm32 devices still work correctly, but the path for
> vmalloc() framebuffers is essentially unchanged.
> 
> Even with these changes, defio does not support framebuffers in MMIO
> space, as defio code depends on framebuffer memory pages having
> corresponding 'struct page's.
> 
> Fixes: 3a6fb6c4255c ("video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v3:
> * Moved definition of FBINFO_KMEMFB flag to a separate patch
>    preceeding this one in the patch set [Helge Deller]
> Changes in v2:
> * Tweaked code comments regarding framebuffers allocated with
>    dma_alloc_coherent() [Christoph Hellwig]
> 
>   drivers/video/fbdev/core/fb_defio.c | 128 +++++++++++++++++++++++-----
>   1 file changed, 108 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
> index 4fc93f253e06..f8ae91a1c4df 100644
> --- a/drivers/video/fbdev/core/fb_defio.c
> +++ b/drivers/video/fbdev/core/fb_defio.c
> @@ -8,11 +8,40 @@
>    * for more details.
>    */
>   
> +/*
> + * Deferred I/O ("defio") allows framebuffers that are mmap()'ed to user space
> + * to batch user space writes into periodic updates to the underlying
> + * framebuffer hardware or other implementation (such as with a virtualized
> + * framebuffer in a VM). At each batch interval, a callback is invoked in the
> + * framebuffer's kernel driver, and the callback is supplied with a list of
> + * pages that have been modified in the preceding interval. The callback can
> + * use this information to update the framebuffer hardware as necessary. The
> + * batching can improve performance and reduce the overhead of updating the
> + * hardware.
> + *
> + * Defio is supported on framebuffers allocated using vmalloc() and allocated
> + * as contiguous kernel memory using alloc_pages() or kmalloc(). These
> + * memory allocations all have corresponding "struct page"s. Framebuffers
> + * allocated using dma_alloc_coherent() should not be used with defio.
> + * Such allocations should be treated as a black box owned by the DMA
> + * layer, and should not be deconstructed into individual pages as defio
> + * does. Framebuffers in MMIO space are *not* supported because MMIO space
> + * does not have corrresponding "struct page"s.
> + *
> + * For framebuffers allocated using vmalloc(), struct fb_info must have
> + * "screen_buffer" set to the vmalloc address of the framebuffer. For
> + * framebuffers allocated from contiguous kernel memory, FBINFO_KMEMFB must
> + * be set, and "fix.smem_start" must be set to the physical address of the
> + * frame buffer. In both cases, "fix.smem_len" must be set to the framebuffer
> + * size in bytes.
> + */
> +
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/errno.h>
>   #include <linux/string.h>
>   #include <linux/mm.h>
> +#include <linux/pfn_t.h>
>   #include <linux/vmalloc.h>
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
> @@ -37,7 +66,7 @@ static struct page *fb_deferred_io_get_page(struct fb_info *info, unsigned long
>   	else if (info->fix.smem_start)
>   		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
>   
> -	if (page)
> +	if (page && !(info->flags & FBINFO_KMEMFB))
>   		get_page(page);
>   
>   	return page;
> @@ -137,6 +166,15 @@ static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
>   
>   	BUG_ON(!info->fbdefio->mapping);
>   
> +	if (info->flags & FBINFO_KMEMFB)
> +		/*
> +		 * In this path, the VMA is marked VM_PFNMAP, so mm assumes
> +		 * there is no struct page associated with the page. The
> +		 * PFN must be directly inserted and the created PTE will be
> +		 * marked "special".
> +		 */
> +		return vmf_insert_pfn(vmf->vma, vmf->address, page_to_pfn(page));
> +
>   	vmf->page = page;
>   	return 0;
>   }
> @@ -163,13 +201,14 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
>   
>   /*
>    * Adds a page to the dirty list. Call this from struct
> - * vm_operations_struct.page_mkwrite.
> + * vm_operations_struct.page_mkwrite or .pfn_mkwrite.
>    */
> -static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long offset,
> +static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, struct vm_fault *vmf,
>   					    struct page *page)
>   {
>   	struct fb_deferred_io *fbdefio = info->fbdefio;
>   	struct fb_deferred_io_pageref *pageref;
> +	unsigned long offset = vmf->pgoff << PAGE_SHIFT;
>   	vm_fault_t ret;
>   
>   	/* protect against the workqueue changing the page list */
> @@ -182,20 +221,34 @@ static vm_fault_t fb_deferred_io_track_page(struct fb_info *info, unsigned long
>   	}
>   
>   	/*
> -	 * We want the page to remain locked from ->page_mkwrite until
> -	 * the PTE is marked dirty to avoid mapping_wrprotect_range()
> -	 * being called before the PTE is updated, which would leave
> -	 * the page ignored by defio.
> -	 * Do this by locking the page here and informing the caller
> -	 * about it with VM_FAULT_LOCKED.
> +	 * The PTE must be marked writable before the defio deferred work runs
> +	 * again and potentially marks the PTE write-protected. If the order
> +	 * should be switched, the PTE would become writable without defio
> +	 * tracking the page, leaving the page forever ignored by defio.
> +	 *
> +	 * For vmalloc() framebuffers, the associated struct page is locked
> +	 * before releasing the defio lock. mm will later mark the PTE writaable
> +	 * and release the struct page lock. The struct page lock prevents
> +	 * the page from being prematurely being marked write-protected.
> +	 *
> +	 * For FBINFO_KMEMFB framebuffers, mm assumes there is no struct page,
> +	 * so the PTE must be marked writable while the defio lock is held.
>   	 */
> -	lock_page(pageref->page);
> +	if (info->flags & FBINFO_KMEMFB) {
> +		unsigned long pfn = page_to_pfn(pageref->page);
> +
> +		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address,
> +					       __pfn_to_pfn_t(pfn, PFN_SPECIAL));

Will the VMA have VM_PFNMAP or VM_MIXEDMAP set? PFN_SPECIAL is a 
horrible hack.

In another thread, you mention that you use PFN_SPECIAL to bypass the 
check in vm_mixed_ok(), so VM_MIXEDMAP is likely not set?

It's all a mess ...

-- 
Cheers,

David / dhildenb


