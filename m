Return-Path: <linux-kernel+bounces-811498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C41B529FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5C7A03351
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5F26E708;
	Thu, 11 Sep 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="adqsBSUp"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F001F9A89
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575901; cv=none; b=rWUkYbqKobJn/g7fLD/BqsUZtAGbROFZ6hmbZ2LA1wMo1mdiqy9DNPs+kR6OJf+6qbnzkD5Pg4n0Nd3p5/GQINtequuxK9cFPtUEMU+GxmLmHilzNvtf/8d5ZayN1hdpNhoWT0TGS/6BfTHwBhSp39gQAv6h6Jbnugd7Lg0JmeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575901; c=relaxed/simple;
	bh=c+nVyHTw/l6GxLPdoRzM9y7sJkc0rvjpFG99z5bhefQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apUVKRY4AseU2WeeQ4PUtdyRGLAqM3kh04wnM7BcCZ5aA5jeOiclzddIYRKwIxb8x0KArbnNWICd2/kgtSywe3EWeiecyL8mJUL8ZL0K+Fd8zUbON3KS/0uWQGO+wXBjoIdc3grf+sCJMAF0gN8qNM5fyNbZhQ9tiSpBd2cEu3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=adqsBSUp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b045d56e181so58079566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757575897; x=1758180697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=degBKJVuyHnw33MrOSllu60lAvi3EP4JK10gQgtYi20=;
        b=adqsBSUpM2ab9unILSXWwdj7Eh+q20g8xTMckcFX6ao4Q4FS3Gul0BUg4AIAZXlZ3y
         l5Nmpu1bZBUqJ1EUGc1b3AEM7yH3QtBteXFH0aMmm4/dSXpOI5YhN8dnIQQsehbrcFrz
         TdDf1sj5y/qObrIAzem4u6gtreUyJCqBQ2sFsCYGnw2EYw70dTuoZfI2qxT2+WvqRbN+
         FTn5zPnKjfiRXIq5KvmEl0t4rj1WufU4McPI2n7l36aL274Y8Fgkv8mJNxSzZi6gZj1j
         VEWBw4XkKZXkHYT2JCVSEosNUbNNLbI98bRefbJoswTNdw7d5CSNoEC+Ptcv4fLQRAUk
         nRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575897; x=1758180697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=degBKJVuyHnw33MrOSllu60lAvi3EP4JK10gQgtYi20=;
        b=r8XUugRKommZuLMptV1ut5XWGfIGD1xb7b8JQhJRcXE+f731jnnLCFLE4kHlxVJzVU
         yJ8LGbBQ755bqen0vOkb44JISEhAlBN6fgJ5kdoeulxK8mHq41H7KPT7ulJVC/59vMMX
         rj+j65bDQ3sgws6MbxI8BrpizFoXgZlNHZm3VlzNJQvp915uo+CdeIKO49hVDjexR8+u
         qolFg3Jj5cfOKCo/G+Y2tbniLPZwcLt7RnNVcatgBmz5tF3R4KC3pC1NWXwXraENAfSq
         hGJroSwmtySUo0f3twjmUcpBv3V4PQVP18M8Jc03/zbySTyd4zrd6+fc6KpwhoBVDzZ8
         dgZg==
X-Forwarded-Encrypted: i=1; AJvYcCVrAox0lgOKhgiozvkFTOIAnT3KYcuSsolWbNYHGI+yQA2Y/RpnC6Zss5tS7lb7AHjvuoXUjhhzeno0OWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyGklxGvixWU0VPBJjr3cJXVFcMCD3fzweo2Y56L1ow1SEMmJ
	8CWoyfD44ZQ6LJ41Y5HEsfDCEYHY69Rsehudc32aw4t+oJUyuI7hz2oZBm4wFYNXUP8aP1AKqdM
	aCYti
X-Gm-Gg: ASbGncuvmU8tHSFkLlOqisLbzGnloSrDxqxb6C9cU+AUWei+bBrYx5EobDZrBHV/TTR
	hkxG+1rRr2TrvpO+Ser6ygd1Q7QLplSUfKwvoDk3wQYCaR368/crtfHt1Qbsi9Sa3mwn2qNZJp+
	V/E6siRvg7BRcNb4tg9F+2HjOvnm2Y3Km/oTQSJH+YdPa21q4t6sFbrHQ9prDEc+TtwvzwMcFQ3
	Fygkj+jZaK9Nsx26Fk8qC+SrYj2WIBMnEYOHjIdd2mIcYKnlsuc3D42pYymEotAohnKt2yiiKxW
	mVW5fzZE1iCoowWGY9ted1wx8jgwUJ/URcWr0LDABo3qpAsqhHPt/w4BFR6+aqPYCXzLCx3qV6M
	hz0N2kqVxb6tAXxdOPnipwrxTCBdowrpii1ATqU7RD9wZ
X-Google-Smtp-Source: AGHT+IHdIz45ITHlnfk3Z9/vpjn8WUwHHtdftIGSPN/xekCYOQYFtBTJQ0MkrZ7ISSCBXqS7+DLEbQ==
X-Received: by 2002:a17:906:507:b0:b04:b446:355 with SMTP id a640c23a62f3a-b04b446113bmr1484877266b.59.1757575897066;
        Thu, 11 Sep 2025 00:31:37 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33b4d63sm613614a12.23.2025.09.11.00.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:31:36 -0700 (PDT)
Date: Thu, 11 Sep 2025 09:31:35 +0200
From: Michal Hocko <mhocko@suse.com>
To: zhongjinji <zhongjinji@honor.com>
Cc: akpm@linux-foundation.org, feng.han@honor.com, lenb@kernel.org,
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org, liulu.liu@honor.com,
	lorenzo.stoakes@oracle.com, pavel@kernel.org, rafael@kernel.org,
	rientjes@google.com, shakeel.butt@linux.dev, surenb@google.com,
	tglx@linutronix.de
Subject: Re: [PATCH v9 2/2] mm/oom_kill: The OOM reaper traverses the VMA
 maple tree in reverse order
Message-ID: <aMJ619kjFm00c4OP@tiehlicka>
References: <aMGXsenuvA682-Dc@tiehlicka>
 <20250911040609.6126-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911040609.6126-1-zhongjinji@honor.com>

On Thu 11-09-25 12:06:09, zhongjinji wrote:
> > On Wed 10-09-25 22:37:26, zhongjinji wrote:
> > > Although the oom_reaper is delayed and it gives the oom victim chance to
> > > clean up its address space this might take a while especially for
> > > processes with a large address space footprint. In those cases
> > > oom_reaper might start racing with the dying task and compete for shared
> > > resources - e.g. page table lock contention has been observed.
> > > 
> > > Reduce those races by reaping the oom victim from the other end of the
> > > address space.
> > > 
> > > It is also a significant improvement for process_mrelease(). When a process
> > > is killed, process_mrelease is used to reap the killed process and often
> > > runs concurrently with the dying task. The test data shows that after
> > > applying the patch, lock contention is greatly reduced during the procedure
> > > of reaping the killed process.
> > > 
> > > The test is based on arm64.
> > > 
> > > Without the patch:
> > > |--99.57%-- oom_reaper
> > > |    |--0.28%-- [hit in function]
> > > |    |--73.58%-- unmap_page_range
> > > |    |    |--8.67%-- [hit in function]
> > > |    |    |--41.59%-- __pte_offset_map_lock
> > > |    |    |--29.47%-- folio_remove_rmap_ptes
> > > |    |    |--16.11%-- tlb_flush_mmu
> > > |    |    |--1.66%-- folio_mark_accessed
> > > |    |    |--0.74%-- free_swap_and_cache_nr
> > > |    |    |--0.69%-- __tlb_remove_folio_pages
> > > |    |--19.94%-- tlb_finish_mmu
> > > |    |--3.21%-- folio_remove_rmap_ptes
> > > |    |--1.16%-- __tlb_remove_folio_pages
> > > |    |--1.16%-- folio_mark_accessed
> > > |    |--0.36%-- __pte_offset_map_lock
> > > 
> > > With the patch:
> > > |--99.53%-- oom_reaper
> > > |    |--55.77%-- unmap_page_range
> > > |    |    |--20.49%-- [hit in function]
> > > |    |    |--58.30%-- folio_remove_rmap_ptes
> > > |    |    |--11.48%-- tlb_flush_mmu
> > > |    |    |--3.33%-- folio_mark_accessed
> > > |    |    |--2.65%-- __tlb_remove_folio_pages
> > > |    |    |--1.37%-- _raw_spin_lock
> > > |    |    |--0.68%-- __mod_lruvec_page_state
> > > |    |    |--0.51%-- __pte_offset_map_lock
> > > |    |--32.21%-- tlb_finish_mmu
> > > |    |--6.93%-- folio_remove_rmap_ptes
> > > |    |--1.90%-- __tlb_remove_folio_pages
> > > |    |--1.55%-- folio_mark_accessed
> > > |    |--0.69%-- __pte_offset_map_lock
> > 
> > I do not object to the patch but this profile is not telling much really
> > as already pointed out in prior versions as we do not know the base
> > those percentages are from. It would be really much more helpful to
> > measure the elapse time for the oom_repaer and exit_mmap to see those
> > gains.
> 
> I got it. I will reference the perf report like this [1] in the changelog.
> link : https://lore.kernel.org/all/20250908121503.20960-1-zhongjinji@honor.com/ [1]

Yes, this is much more informative. I do not think we need the full
report in the changelog though. I would just add your summary
Summary of measurements (ms):
+---------------------------------------------------------------+
| Category                      | Applying patch | Without patch|
+-------------------------------+---------------+--------------+
| Total running time            |    132.6      |    167.1      |
|   (exit_mmap + reaper work)   |  72.4 + 60.2  |  90.7 + 76.4  |
+-------------------------------+---------------+--------------+
| Time waiting for pte spinlock |     1.0       |    33.1      |
|   (exit_mmap + reaper work)   |   0.4 + 0.6   |  10.0 + 23.1 |
+-------------------------------+---------------+--------------+
| folio_remove_rmap_ptes time   |    42.0       |    41.3      |
|   (exit_mmap + reaper work)   |  18.4 + 23.6  |  22.4 + 18.9 |
+---------------------------------------------------------------+

and referenced the full report by the link.

Thanks!

-- 
Michal Hocko
SUSE Labs

