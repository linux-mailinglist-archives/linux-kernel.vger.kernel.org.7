Return-Path: <linux-kernel+bounces-798588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD364B4202E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9824C3BEC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2092FCBE5;
	Wed,  3 Sep 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d6Iy2Wmh"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6322172E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904305; cv=none; b=a14+0aYpflPEDntj2UCQ7VoqMhgVo9F5iVqIk8YJjx4WA84uh6vUW3MJPS36fL231mreWRp+sPtLoh+oGpi5biDUpF9gGjd5CznMFnw30tMXvUBexY5IxYSdv+NC9aBE/zzsyGkdhe8UMgfb3xR+czIQ5matsaG3Sqb9wlelnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904305; c=relaxed/simple;
	bh=QZ/zEMcGCNpoIy5Q9gouZGLszY6dfQmCsP+PYCE0BVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMDbG2bFqSVf7nbzXScUJarAdNyneLeuoKKql3/8jAbt+c+AqxlyiRxDhY7fTRuBslFlKH+U1P26Eo7dfgKIhiekeEk5jmuMKQLzzF827xIKTfnaPAGEKp+qGjcNe5NG2/07Z/O3rZqxbv5HQGZi6WJx7ZPd0W2Ks149CS5g5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d6Iy2Wmh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so5927225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756904300; x=1757509100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MC77pG8YTMZbdsVNvsxb7MX4BGndC3HL8xv81scZppk=;
        b=d6Iy2WmhNKtaCN/Qj4d6A1cxq1a9NnnbLZ1hf7s9ZrUSRDJ+xvy5V6V1hL99t6gfWp
         2Obd11VYgPCp35gQovatkKk2FIf+SwhSbHR6zGZH6Sq+ZBxgFKtX+9ZQRaSXFiIO76/0
         NaNTdWkOR/FOePrZgzmcRhOaudecW7Sn+XbTvTZA5SReHlA39+q3a8xqHTz1gfxwoZdQ
         4Vogr70AxDVp9b7sSITd1AvZS1vZexGeaxBcy04IeI3orqTdMEd4tdunWYR2jlYicM8r
         mPw+H5FB6xQeE78xGy8BqaVrjBK+14ImxjBkfJwb1iNaHJTnnSJmbpGq7U6y9xb71CWc
         r36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756904300; x=1757509100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC77pG8YTMZbdsVNvsxb7MX4BGndC3HL8xv81scZppk=;
        b=Smkf8MfB/RXvdSTO2lw0CXMtipk53rHebu7Aensy3B5rmCYCxhL1836iq37nril6QR
         1yQoq2laQBXWRV4HRTsGEY+gKU/X95BBYw1/AHqfXu3kgM7EhzRScGwKHxOz2nTUM3Yc
         MXSI5L/Afz7f/c/MB60zRpq3KMV6g4JY3KoL/1yenCcJsKtm/EgOXx1t3I5l3vj3+CPm
         5AVm9ZUUpEPDdO0JnrTXLwgsxFTjltqg/RRM3yl18/15T1GfLUN369mG3k1po2nbSvbx
         LWvVJOsaOVzBZUbE1zvv7VQb9f09eBHlAaJr1eimMI82RB/Hely7Jzwbb6hM/wSIieH6
         yIDg==
X-Forwarded-Encrypted: i=1; AJvYcCWuVSyhEMDnsdo2wAGUA55WsnVggbhYUB3keOyEgLcxOB7+XEJ4AU7iBOSGDfH0w83n//SyMwX3E5PPhMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8GN3h5jsLHabfJIcMJQoasOLc+C7Jac7DHsYJEu4blY/g3gh1
	2xw6rC4ogQ8uXtt6NTSZbCgEbImyp41OqMJuqg8868KWr5vNqZ0zMUBjRQxHrz/tW1M=
X-Gm-Gg: ASbGncvz1WUs6pM5DnAvFyyQMV6qKh55j5Z0azljz6BbM++ZeHGo5S2JaKuNr1Zbco9
	LNHPpesZspxGROrIdV2bl0yIpzy8IWNteH6KQ0vqCuLOugBbL7OWcHl6XpXIlsvD5jJKeY+F4pt
	2T9xPKWuM4aO+4XOdhNqbDL8iRAsjZ6WVZiAU+34oHATNq+95NazNjnLEfXZheapJLFRk6xMqjT
	xOIJ4FiurIZuPfJkG2QBEG7krFZgl/MPREwIFhKm/VuNXeRGNKRToO+OEQ1A7+mmFbBV05BBA7p
	nGBjRhseqQA7jpzEjiFHBdUc4BEJyn38yksSfTAb9qKAnIVmejPGIcrTpwhYjocjqFoXbmNR2VO
	z9E0G/mFzh58kdc3UqO5JXPRloVPhF8a4NZ3LRzEMgDkdSA==
X-Google-Smtp-Source: AGHT+IGA/EYr9siPLdAQFtA01/sYfVZcSrreq7W5+wyFJ0oMa4bqky4nIByyFn+cR542vJGQDzatNQ==
X-Received: by 2002:a05:600c:1394:b0:45a:236a:23ba with SMTP id 5b1f17b1804b1-45b85575801mr117379825e9.22.1756904299566;
        Wed, 03 Sep 2025 05:58:19 -0700 (PDT)
Received: from localhost (109-81-86-254.rct.o2.cz. [109.81.86.254])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b7e7f14bbsm245164425e9.8.2025.09.03.05.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:58:19 -0700 (PDT)
Date: Wed, 3 Sep 2025 14:58:18 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v7 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aLg7ajpko2j1qV4h@tiehlicka>
References: <20250903092729.10611-1-zhongjinji@honor.com>
 <20250903092729.10611-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903092729.10611-3-zhongjinji@honor.com>

On Wed 03-09-25 17:27:29, zhongjinji wrote:
> Although the oom_reaper is delayed and it gives the oom victim chance to
> clean up its address space this might take a while especially for
> processes with a large address space footprint. In those cases
> oom_reaper might start racing with the dying task and compete for shared
> resources - e.g. page table lock contention has been observed.
> 
> Reduce those races by reaping the oom victim from the other end of the
> address space.
> 
> It is also a significant improvement for process_mrelease(). When a process
> is killed, process_mrelease is used to reap the killed process and often
> runs concurrently with the dying task. The test data shows that after
> applying the patch, lock contention is greatly reduced during the procedure
> of reaping the killed process.

Thank you this is much better!

> Without the patch:
> |--99.74%-- oom_reaper
> |  |--76.67%-- unmap_page_range
> |  |  |--33.70%-- __pte_offset_map_lock
> |  |  |  |--98.46%-- _raw_spin_lock
> |  |  |--27.61%-- free_swap_and_cache_nr
> |  |  |--16.40%-- folio_remove_rmap_ptes
> |  |  |--12.25%-- tlb_flush_mmu
> |  |--12.61%-- tlb_finish_mmu
> 
> With the patch:
> |--98.84%-- oom_reaper
> |  |--53.45%-- unmap_page_range
> |  |  |--24.29%-- [hit in function]
> |  |  |--48.06%-- folio_remove_rmap_ptes
> |  |  |--17.99%-- tlb_flush_mmu
> |  |  |--1.72%-- __pte_offset_map_lock
> |  |--30.43%-- tlb_finish_mmu

Just curious. Do I read this correctly that the overall speedup is
mostly eaten by contention over tlb_finish_mmu?

> Signed-off-by: zhongjinji <zhongjinji@honor.com>

Anyway, the change on its own makes sense to me
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for working on the changelog improvements.

> ---
>  mm/oom_kill.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3caaafc896d4..540b1e5e0e46 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -516,7 +516,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
>  	bool ret = true;
> -	VMA_ITERATOR(vmi, mm, 0);
> +	MA_STATE(mas, &mm->mm_mt, ULONG_MAX, ULONG_MAX);
>  
>  	/*
>  	 * Tell all users of get_user/copy_from_user etc... that the content
> @@ -526,7 +526,13 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  	 */
>  	set_bit(MMF_UNSTABLE, &mm->flags);
>  
> -	for_each_vma(vmi, vma) {
> +	/*
> +	 * It might start racing with the dying task and compete for shared
> +	 * resources - e.g. page table lock contention has been observed.
> +	 * Reduce those races by reaping the oom victim from the other end
> +	 * of the address space.
> +	 */
> +	mas_for_each_rev(&mas, vma, 0) {
>  		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
>  			continue;
>  
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs

