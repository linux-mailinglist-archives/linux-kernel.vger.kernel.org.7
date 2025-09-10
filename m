Return-Path: <linux-kernel+bounces-810499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C28B51B79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DACB3A6ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517173164D1;
	Wed, 10 Sep 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UFpqNeX/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8463277A9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517752; cv=none; b=IKnKJDu4Lx+6XQduY9sBjHS3iVAgesfXngziDDLmY1q+0OYfQeUFuAQX5vpXXJkhBH0lh+w/8NPhZjfUyYw7YYiRIJpMNwqx70t6QtXN6MRmBcYkXtTRaR8sGMg5Rkz+sQa42vpux8tbZucpXBbmAnD48LktrJxsoR3Pewd1BI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517752; c=relaxed/simple;
	bh=ADUvuqFKPB34dYMqxEN/4AMxhhHMgpwTOGiQSuTaaXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx7o/0gmk0uKqKiBqVRXNqYelrZ/Co8PC/LcxH3D8l7iBsxoJNV60COtGnaUgg4V0cZ/46gjQXcicVlXk/EIryrKkk6jYs5u/pCo67S5GbE6m7WMKVlJsOLa+EKjL6F+Y38D8eGch9DI15faI7rESALaFH3r+TWd/8hUuOEjGOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UFpqNeX/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07883a5feeso158418466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757517749; x=1758122549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q/qIKqTt/TeHwEAuPNWMb+Opu1b3bhXOvxk1BCU0qY=;
        b=UFpqNeX/ijFxd51PbhtfoRbfKoweMEoliucOgiwfID3iiEzy3l+fN/vD23eWRwt2d5
         IuHQRPz6yEO+dHNP1gxckR6FV9eXBwZCl3CZtuar36U69Ak5noa1Pw5Z48VlzpslvOJS
         CYpU1ZBeMTPMtmP9jbv+vxFoi0LrBY1tG8q/EFiL4oTYRWixz7h1wsIbocr2mryEf40z
         PBQ/wKWqikMs9SY0M4DpDsotH3hVFbxQjrsmeoqbHr5fOVEO57+GYXKEwXkjs7ETwUIh
         DjAYuP+ScFCk0e0S4mNNMPg9h/K9LoQB0Rw/Dxw5yBPgRZTPLZHoztj8XAsaeo+ZZuu2
         oQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757517749; x=1758122549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q/qIKqTt/TeHwEAuPNWMb+Opu1b3bhXOvxk1BCU0qY=;
        b=w/H3rsnnhQ+c4abDQx9svlvyiH5Af/op+66fSdQTsGq6zCbuhvZS8C+FBPdznrsocR
         ZfC15qHCAw/BxJQ2tsBjLeABarAZHeEcVWcpjtsIkmrr2h+IMjOKu4oynHrDFsazNbmu
         3KtGrzpw/gSDm585ux1v6Ofrv3lxWIICrAxb7KediOHIxAzR/fKlnyauliWB49PDwO7k
         Qe67vd9B5u0G0r1TTr/7dAps8OR9GE6m5rmZ7xhNpPPzCYfaRuDerDsm8DgHqO1Mx248
         VV1G+SnDiCYM37kFVOcjsPJZ38YvFw/KRRqeaOkqXNDz7qnbigRe/0x8NE1uPuS8/Ii3
         F0hA==
X-Forwarded-Encrypted: i=1; AJvYcCU4PbiXrXZDr3U8XaKl7zOR3mVC17vXFX+6/rndP8RTrL4S465P9SACGZg8nVc3UI0RTITXfoNHqRIYS/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ZZRMqQCqWpkzzy6CSEvHnuqk/nsgQ79ZNw5oo4RAl3dlMTI9
	OYELyQaPCWwCBybvSRIJQy6n95UaouAQYqSBmWaeuuAVVEehbgoOC0TS0SUOGzW7YCE=
X-Gm-Gg: ASbGncuwleIMxP92Z907i7Qwr6jbvY3Znn3Zak8IdByEnwT91bWnT4OkvxMhQ5rvnGy
	NW9dSnMefRV6rHk8n5YngrM3TeGmQQPKvPmndjXXcvgAZ5z7dxF3UowpSNk0UhIMB3d9c9K/bMK
	c6eBKW8L88mX8ckjnyRAWO4P5mtAsOrpnFKaJMh7r8kDb6+NKa+XpOMtu7k3X4SL5RSfqnkF2VE
	j0WtniEqHJA1KN0RymDucPZ0nVCQxUS2BOp1UAEgbRMnDoQGneOKH+FAP5SMM543dZet3XACSzS
	YnUDaNp8P0L9Je3TL41CuTf0oDQt9gD63Rj6G+6XwmQup+J5B/0AvUDwdZ98vFfy7+z+cOveB6R
	kWSKFIK5ca3oyX0kibyklNLSXHweCnGGJUBC5vuiJ9GA/NMpVn+Rlwsw=
X-Google-Smtp-Source: AGHT+IGu1RPgfzvjjZxcEkpx1Cu0aX34wfa0rbwgT6cXKfY+5y9LXUr0ynjlTUCJ2SRrzExxIqoXFA==
X-Received: by 2002:a17:907:6088:b0:b04:48c5:352 with SMTP id a640c23a62f3a-b04b13ca12dmr1500001166b.5.1757517748203;
        Wed, 10 Sep 2025 08:22:28 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b078e361902sm110599966b.67.2025.09.10.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:22:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 17:22:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: rientjes@google.com, shakeel.butt@linux.dev, akpm@linux-foundation.org,
	tglx@linutronix.de, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, surenb@google.com, lenb@kernel.org,
	rafael@kernel.org, pavel@kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH v9 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aMGXsenuvA682-Dc@tiehlicka>
References: <20250910143726.19905-1-zhongjinji@honor.com>
 <20250910143726.19905-3-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910143726.19905-3-zhongjinji@honor.com>

On Wed 10-09-25 22:37:26, zhongjinji wrote:
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
> 
> The test is based on arm64.
> 
> Without the patch:
> |--99.57%-- oom_reaper
> |    |--0.28%-- [hit in function]
> |    |--73.58%-- unmap_page_range
> |    |    |--8.67%-- [hit in function]
> |    |    |--41.59%-- __pte_offset_map_lock
> |    |    |--29.47%-- folio_remove_rmap_ptes
> |    |    |--16.11%-- tlb_flush_mmu
> |    |    |--1.66%-- folio_mark_accessed
> |    |    |--0.74%-- free_swap_and_cache_nr
> |    |    |--0.69%-- __tlb_remove_folio_pages
> |    |--19.94%-- tlb_finish_mmu
> |    |--3.21%-- folio_remove_rmap_ptes
> |    |--1.16%-- __tlb_remove_folio_pages
> |    |--1.16%-- folio_mark_accessed
> |    |--0.36%-- __pte_offset_map_lock
> 
> With the patch:
> |--99.53%-- oom_reaper
> |    |--55.77%-- unmap_page_range
> |    |    |--20.49%-- [hit in function]
> |    |    |--58.30%-- folio_remove_rmap_ptes
> |    |    |--11.48%-- tlb_flush_mmu
> |    |    |--3.33%-- folio_mark_accessed
> |    |    |--2.65%-- __tlb_remove_folio_pages
> |    |    |--1.37%-- _raw_spin_lock
> |    |    |--0.68%-- __mod_lruvec_page_state
> |    |    |--0.51%-- __pte_offset_map_lock
> |    |--32.21%-- tlb_finish_mmu
> |    |--6.93%-- folio_remove_rmap_ptes
> |    |--1.90%-- __tlb_remove_folio_pages
> |    |--1.55%-- folio_mark_accessed
> |    |--0.69%-- __pte_offset_map_lock

I do not object to the patch but this profile is not telling much really
as already pointed out in prior versions as we do not know the base
those percentages are from. It would be really much more helpful to
measure the elapse time for the oom_repaer and exit_mmap to see those
gains.
 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/oom_kill.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 88356b66cc35..28fb36be332b 100644
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

-- 
Michal Hocko
SUSE Labs

