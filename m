Return-Path: <linux-kernel+bounces-711672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3758AEFDBF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 17:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902B816664B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89275277C87;
	Tue,  1 Jul 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XaRhQIJv"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C02741B6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382833; cv=none; b=bk6yX3mKPMPcSMi/Jt4VoEMwgQ7IDg3jjmNW5oxj7F3/e5iEWJb6UAMKeZdomVJJo7nHhQiCfJGSYuhS1cAZLP/UVH1su8BDwqgyp1mgDDeHLrH6e6UZle2hqnCt2g1Pt2hU6Q4ZVG9q7IPNg+0ErOnjU1L7T5D5vfyX+r6Io3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382833; c=relaxed/simple;
	bh=HPo7QCNoEEJ13sZJ01R85iXwqntONuCGXnepF4AYQyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wqi8UekTfIKSegNOD3d1/bprhOlmongKftrd32YHLFfBiSVma0/ao1TFtM0gv7O5BRZpbRxvSopfb5R93NWzFSxVh7cxF9DUr4Ehk++LILZh4IWfVAdTYFrkBgXXWWlO5iyPpj9oHQsX31fFWnq4is4EHBYlkuTCZ8Nw4I2iX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XaRhQIJv; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40b32b6af9eso2605377b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751382831; x=1751987631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvP17ZAflRavUKpY4Mp29tAsw2hWI3TIGZ5ksOhmyEs=;
        b=XaRhQIJvO7kaWWSiHGoIT0yK79R7EBXJWp378MPDqohdJTQTnEr4yAVpbGpoin4WE5
         6NFMbbmTqSdIuMoO+61VXjNYUHB54QxpxDN6YgRVK8QN2sVlKyQClYeHO92i/lSZ/hBM
         tRHAZ9xcYpzcqFF5WV0jgHJHgSwiXaNNg/R+M63CVyqiTFTQ9dfA/VHQba0GZQMgSNCc
         wwjgGWXzB6NcCJigAg5uP06b3azl7HJqctH+9rfPTTe9yNSVFl49+kje/mNxKo970qu8
         UdBHGVxgy2xInt9lAYZVJLw4wIORO+1z8d1SHbEh51hRMLgJGH1sirXwTdnEIdGomr6E
         WRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382831; x=1751987631;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvP17ZAflRavUKpY4Mp29tAsw2hWI3TIGZ5ksOhmyEs=;
        b=mMIH20ieZ8GzlLJr5SLz+95Exci0tL+SzLmW4BvLa0aWyf3UUDKfqwGs5N+F22Zk6z
         bc2LX1uG+0EVco/mK7ScR4X4T8s8KLiaTuYSRW6jXRvzg/saS/p0M77D2WdnTazpgRA2
         9eVj96M0cndhd3ax+AuZQNlE8/UM6vJEG45hFLGttFjeRhltDVeDDCIlVM6MelJAKagT
         RLveAB6Lg7O9RAGAyqFrhlIdDNST5d71GKE9xmAZ6QdVqxNdGTwR/+ZOVwZ0Vp6mlnQM
         9C0R+Z7zRMmpmyTrwIYyRrM5979kSi/qhC8F5NSVn85WNmWYvYAyXRsS8Ec1dF4PDuPr
         B4fw==
X-Forwarded-Encrypted: i=1; AJvYcCWkUCuUfatNM8ehukT3GNYgAvEHhp0Dw8+CsFOcp5eMKaUk1DyqPe4l21cXVzdcuShCZ4dJeWUP0wQnmEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye2LKu7vp0DJSnSyQ6Tum5qNIIdCR11ZA86ersZE5sNwCSi6OS
	uJdq7GtucLJov/sOZtS9KdUqiDbNteR7Oi7gFyNe4LtxLRftOLwHDcejmMG89vxExFs=
X-Gm-Gg: ASbGncuB16fBRQ4T/3VxkQklIE7gnf3gjtseI+aaM7agvl4QThLvTHNUIIrrpzuNps1
	YYHvjyPWEAMbusqALRNj7m6hQe749hWNlZwjaSMFyZpkQu08+MQcQnY7vJHzSuXFKc2YIJXb2Hi
	lNbL3c6ufpd5Gbu64hUH/tmAn1S2betatr9/4UaUWK7S2QlRDV/R+ojiD6+St/V3tR0z9jATOVB
	iKc/Euu9jZZGL0fQbW+p81cTEqZmNGek/IrHWNyBi0E1bnv57bXpllVMJlZ+373VFKPSJkYTZBb
	eOQwoDwWrsm79SG4ZWmHq5lZmujtQ0uuwDInpdW2a8VMERR7myKuzUNqOFBboo83cW7gOg==
X-Google-Smtp-Source: AGHT+IFJyOyZ9nfKb3i1H1MJC801oKnQyWDHcHeJnLO22Qd4qWC9o3hGGlNb7DDyU/ra7yb+3+Gg3w==
X-Received: by 2002:a05:6808:1692:b0:406:39b4:2232 with SMTP id 5614622812f47-40b33c48e52mr11763271b6e.3.1751382830670;
        Tue, 01 Jul 2025 08:13:50 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8ebc:82eb:65f7:565e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b441e2ef4sm1795136b6e.26.2025.07.01.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:13:50 -0700 (PDT)
Date: Tue, 1 Jul 2025 18:13:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, lizhe.67@bytedance.com,
	alex.williamson@redhat.com, jgg@ziepe.ca, david@redhat.com,
	peterx@redhat.com
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lizhe.67@bytedance.com
Subject: Re: [PATCH 3/4] vfio/type1: introduce a new member has_rsvd for
 struct vfio_dma
Message-ID: <c209cfd6-05b1-4491-91ce-c672414d718c@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630072518.31846-4-lizhe.67@bytedance.com>

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/lizhe-67-bytedance-com/vfio-type1-optimize-vfio_pin_pages_remote-for-large-folios/20250630-152849
base:   https://github.com/awilliam/linux-vfio.git next
patch link:    https://lore.kernel.org/r/20250630072518.31846-4-lizhe.67%40bytedance.com
patch subject: [PATCH 3/4] vfio/type1: introduce a new member has_rsvd for struct vfio_dma
config: x86_64-randconfig-161-20250701 (https://download.01.org/0day-ci/archive/20250701/202507012121.wkDLcDXn-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202507012121.wkDLcDXn-lkp@intel.com/

New smatch warnings:
drivers/vfio/vfio_iommu_type1.c:788 vfio_pin_pages_remote() error: uninitialized symbol 'rsvd'.

Old smatch warnings:
drivers/vfio/vfio_iommu_type1.c:2376 vfio_iommu_type1_attach_group() warn: '&group->next' not removed from list

vim +/rsvd +788 drivers/vfio/vfio_iommu_type1.c

8f0d5bb95f763c Kirti Wankhede  2016-11-17  684  static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
0635559233434a Alex Williamson 2025-02-18  685  				  unsigned long npage, unsigned long *pfn_base,
4b6c33b3229678 Daniel Jordan   2021-02-19  686  				  unsigned long limit, struct vfio_batch *batch)
73fa0d10d077d9 Alex Williamson 2012-07-31  687  {
4d83de6da265cd Daniel Jordan   2021-02-19  688  	unsigned long pfn;
4d83de6da265cd Daniel Jordan   2021-02-19  689  	struct mm_struct *mm = current->mm;
6c38c055cc4c0a Alex Williamson 2016-12-30  690  	long ret, pinned = 0, lock_acct = 0;
89c29def6b0101 Alex Williamson 2018-06-02  691  	bool rsvd;
a54eb55045ae9b Kirti Wankhede  2016-11-17  692  	dma_addr_t iova = vaddr - dma->vaddr + dma->iova;
166fd7d94afdac Alex Williamson 2013-06-21  693  
6c38c055cc4c0a Alex Williamson 2016-12-30  694  	/* This code path is only user initiated */
4d83de6da265cd Daniel Jordan   2021-02-19  695  	if (!mm)
166fd7d94afdac Alex Williamson 2013-06-21  696  		return -ENODEV;
73fa0d10d077d9 Alex Williamson 2012-07-31  697  
4d83de6da265cd Daniel Jordan   2021-02-19  698  	if (batch->size) {
4d83de6da265cd Daniel Jordan   2021-02-19  699  		/* Leftover pages in batch from an earlier call. */
4d83de6da265cd Daniel Jordan   2021-02-19  700  		*pfn_base = page_to_pfn(batch->pages[batch->offset]);
4d83de6da265cd Daniel Jordan   2021-02-19  701  		pfn = *pfn_base;
89c29def6b0101 Alex Williamson 2018-06-02  702  		rsvd = is_invalid_reserved_pfn(*pfn_base);
4d83de6da265cd Daniel Jordan   2021-02-19  703  	} else {
4d83de6da265cd Daniel Jordan   2021-02-19  704  		*pfn_base = 0;
5c6c2b21ecc9ad Alex Williamson 2013-06-21  705  	}
5c6c2b21ecc9ad Alex Williamson 2013-06-21  706  
eb996eec783c1e Alex Williamson 2025-02-18  707  	if (unlikely(disable_hugepages))
eb996eec783c1e Alex Williamson 2025-02-18  708  		npage = 1;
eb996eec783c1e Alex Williamson 2025-02-18  709  
4d83de6da265cd Daniel Jordan   2021-02-19  710  	while (npage) {
4d83de6da265cd Daniel Jordan   2021-02-19  711  		if (!batch->size) {
4d83de6da265cd Daniel Jordan   2021-02-19  712  			/* Empty batch, so refill it. */
eb996eec783c1e Alex Williamson 2025-02-18  713  			ret = vaddr_get_pfns(mm, vaddr, npage, dma->prot,
eb996eec783c1e Alex Williamson 2025-02-18  714  					     &pfn, batch);
be16c1fd99f41a Daniel Jordan   2021-02-19  715  			if (ret < 0)
4d83de6da265cd Daniel Jordan   2021-02-19  716  				goto unpin_out;
166fd7d94afdac Alex Williamson 2013-06-21  717  
4d83de6da265cd Daniel Jordan   2021-02-19  718  			if (!*pfn_base) {
4d83de6da265cd Daniel Jordan   2021-02-19  719  				*pfn_base = pfn;
4d83de6da265cd Daniel Jordan   2021-02-19  720  				rsvd = is_invalid_reserved_pfn(*pfn_base);
4d83de6da265cd Daniel Jordan   2021-02-19  721  			}

If "*pfn_base" is true then "rsvd" is uninitialized.

eb996eec783c1e Alex Williamson 2025-02-18  722  
eb996eec783c1e Alex Williamson 2025-02-18  723  			/* Handle pfnmap */
eb996eec783c1e Alex Williamson 2025-02-18  724  			if (!batch->size) {
eb996eec783c1e Alex Williamson 2025-02-18  725  				if (pfn != *pfn_base + pinned || !rsvd)
eb996eec783c1e Alex Williamson 2025-02-18  726  					goto out;

goto out;

eb996eec783c1e Alex Williamson 2025-02-18  727  
eb996eec783c1e Alex Williamson 2025-02-18  728  				pinned += ret;
eb996eec783c1e Alex Williamson 2025-02-18  729  				npage -= ret;
eb996eec783c1e Alex Williamson 2025-02-18  730  				vaddr += (PAGE_SIZE * ret);
eb996eec783c1e Alex Williamson 2025-02-18  731  				iova += (PAGE_SIZE * ret);
eb996eec783c1e Alex Williamson 2025-02-18  732  				continue;
eb996eec783c1e Alex Williamson 2025-02-18  733  			}
166fd7d94afdac Alex Williamson 2013-06-21  734  		}
166fd7d94afdac Alex Williamson 2013-06-21  735  
4d83de6da265cd Daniel Jordan   2021-02-19  736  		/*
eb996eec783c1e Alex Williamson 2025-02-18  737  		 * pfn is preset for the first iteration of this inner loop
eb996eec783c1e Alex Williamson 2025-02-18  738  		 * due to the fact that vaddr_get_pfns() needs to provide the
eb996eec783c1e Alex Williamson 2025-02-18  739  		 * initial pfn for pfnmaps.  Therefore to reduce redundancy,
eb996eec783c1e Alex Williamson 2025-02-18  740  		 * the next pfn is fetched at the end of the loop.
eb996eec783c1e Alex Williamson 2025-02-18  741  		 * A PageReserved() page could still qualify as page backed
eb996eec783c1e Alex Williamson 2025-02-18  742  		 * and rsvd here, and therefore continues to use the batch.
4d83de6da265cd Daniel Jordan   2021-02-19  743  		 */
4d83de6da265cd Daniel Jordan   2021-02-19  744  		while (true) {
6a2d9b72168041 Li Zhe          2025-06-30  745  			long nr_pages, acct_pages = 0;
6a2d9b72168041 Li Zhe          2025-06-30  746  
4d83de6da265cd Daniel Jordan   2021-02-19  747  			if (pfn != *pfn_base + pinned ||
4d83de6da265cd Daniel Jordan   2021-02-19  748  			    rsvd != is_invalid_reserved_pfn(pfn))
4d83de6da265cd Daniel Jordan   2021-02-19  749  				goto out;
4d83de6da265cd Daniel Jordan   2021-02-19  750  
6a2d9b72168041 Li Zhe          2025-06-30  751  			nr_pages = contig_pages(dma, batch, iova);
6a2d9b72168041 Li Zhe          2025-06-30  752  			if (!rsvd) {
6a2d9b72168041 Li Zhe          2025-06-30  753  				acct_pages = nr_pages;
6a2d9b72168041 Li Zhe          2025-06-30  754  				acct_pages -= vpfn_pages(dma, iova, nr_pages);
6a2d9b72168041 Li Zhe          2025-06-30  755  			}
6a2d9b72168041 Li Zhe          2025-06-30  756  
4d83de6da265cd Daniel Jordan   2021-02-19  757  			/*
4d83de6da265cd Daniel Jordan   2021-02-19  758  			 * Reserved pages aren't counted against the user,
4d83de6da265cd Daniel Jordan   2021-02-19  759  			 * externally pinned pages are already counted against
4d83de6da265cd Daniel Jordan   2021-02-19  760  			 * the user.
4d83de6da265cd Daniel Jordan   2021-02-19  761  			 */
6a2d9b72168041 Li Zhe          2025-06-30  762  			if (acct_pages) {
48d8476b41eed6 Alex Williamson 2018-05-11  763  				if (!dma->lock_cap &&
6a2d9b72168041 Li Zhe          2025-06-30  764  						mm->locked_vm + lock_acct + acct_pages > limit) {
6c38c055cc4c0a Alex Williamson 2016-12-30  765  					pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
6c38c055cc4c0a Alex Williamson 2016-12-30  766  						__func__, limit << PAGE_SHIFT);
0cfef2b7410b64 Alex Williamson 2017-04-13  767  					ret = -ENOMEM;
0cfef2b7410b64 Alex Williamson 2017-04-13  768  					goto unpin_out;
166fd7d94afdac Alex Williamson 2013-06-21  769  				}
6a2d9b72168041 Li Zhe          2025-06-30  770  				lock_acct += acct_pages;
a54eb55045ae9b Kirti Wankhede  2016-11-17  771  			}
4d83de6da265cd Daniel Jordan   2021-02-19  772  
6a2d9b72168041 Li Zhe          2025-06-30  773  			pinned += nr_pages;
6a2d9b72168041 Li Zhe          2025-06-30  774  			npage -= nr_pages;
6a2d9b72168041 Li Zhe          2025-06-30  775  			vaddr += PAGE_SIZE * nr_pages;
6a2d9b72168041 Li Zhe          2025-06-30  776  			iova += PAGE_SIZE * nr_pages;
6a2d9b72168041 Li Zhe          2025-06-30  777  			batch->offset += nr_pages;
6a2d9b72168041 Li Zhe          2025-06-30  778  			batch->size -= nr_pages;
4d83de6da265cd Daniel Jordan   2021-02-19  779  
4d83de6da265cd Daniel Jordan   2021-02-19  780  			if (!batch->size)
4d83de6da265cd Daniel Jordan   2021-02-19  781  				break;
4d83de6da265cd Daniel Jordan   2021-02-19  782  
4d83de6da265cd Daniel Jordan   2021-02-19  783  			pfn = page_to_pfn(batch->pages[batch->offset]);
4d83de6da265cd Daniel Jordan   2021-02-19  784  		}
a54eb55045ae9b Kirti Wankhede  2016-11-17  785  	}
166fd7d94afdac Alex Williamson 2013-06-21  786  
6c38c055cc4c0a Alex Williamson 2016-12-30  787  out:
20448310d6b71d Li Zhe          2025-06-30 @788  	dma->has_rsvd |= rsvd;
                                                                         ^^^^

48d8476b41eed6 Alex Williamson 2018-05-11  789  	ret = vfio_lock_acct(dma, lock_acct, false);
0cfef2b7410b64 Alex Williamson 2017-04-13  790  
0cfef2b7410b64 Alex Williamson 2017-04-13  791  unpin_out:
be16c1fd99f41a Daniel Jordan   2021-02-19  792  	if (ret < 0) {
4d83de6da265cd Daniel Jordan   2021-02-19  793  		if (pinned && !rsvd) {
0cfef2b7410b64 Alex Williamson 2017-04-13  794  			for (pfn = *pfn_base ; pinned ; pfn++, pinned--)
0cfef2b7410b64 Alex Williamson 2017-04-13  795  				put_pfn(pfn, dma->prot);
89c29def6b0101 Alex Williamson 2018-06-02  796  		}
4d83de6da265cd Daniel Jordan   2021-02-19  797  		vfio_batch_unpin(batch, dma);
0cfef2b7410b64 Alex Williamson 2017-04-13  798  
0cfef2b7410b64 Alex Williamson 2017-04-13  799  		return ret;
0cfef2b7410b64 Alex Williamson 2017-04-13  800  	}
166fd7d94afdac Alex Williamson 2013-06-21  801  
6c38c055cc4c0a Alex Williamson 2016-12-30  802  	return pinned;
73fa0d10d077d9 Alex Williamson 2012-07-31  803  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


