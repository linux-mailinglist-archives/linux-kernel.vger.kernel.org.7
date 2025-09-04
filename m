Return-Path: <linux-kernel+bounces-800146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EF9B433F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6FB17E98F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B8829BD94;
	Thu,  4 Sep 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpLYW56T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B883C29B78E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970966; cv=none; b=cki2cMZx+WrRv3mkSd0lslAsz8vutbVrZBvgY0HMDMVpHpfbok6PRGlHK38ztjPwGNRCv0FCVKhdwkGW0UaCUoBk/N4r8bj9gnUueHnZnOhU4uEOeBeN2oNUVhXVhOne+1ydA29nccITwNaThK6BXUwU6uB+A322jtU/1SODrVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970966; c=relaxed/simple;
	bh=BY/OoUnvgSfJZsul+fsudIqn4N54F8eZC4uQXTXlMqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=onFOxbPbqaoehrkn1wmhdtr+hQ0LsNVg5krJxdWiLvammSzXg0nbP0UNduNiWxzKyvJWy6YC6IQb3vPNIOzrL5mFoZGp9ccBaGyptTZR1mhZxdSQDPmvHS/yX/YJCWpSTN52RfNgUdckXpBcEmaz+rYzGhB1Lt+MH1FdO0A2Un8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpLYW56T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE95C4CEF1;
	Thu,  4 Sep 2025 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970966;
	bh=BY/OoUnvgSfJZsul+fsudIqn4N54F8eZC4uQXTXlMqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpLYW56T1SlyqzHeRsk5RTAV3P7jkzy9LyidtUd6wWNooqDh7q2o9Sbm29+0TOCr7
	 4a2nVcvvjFnxoqk/kZR7Yd7KsPhuL7AuQiuGkaHE2tWjYdg8hNiDZGt+x22zSFX4Cn
	 hDevTJvBZ74DhIuCBxBA4kVLOTPu3DQiTPaeAkKt4pxsejpFntRhe+ADew1zonNc2G
	 4q2MTO6OkwNS2Jdr+W7X53iGmZqiUj/G9G2RVp3U9L7DQCFVH+/RkrR/bSrXATmdM6
	 DZVOH7Tds/5rZc89LCE/g4d0RPVzOOtaDATkrkowaKz25XSGnkxVf5lzQLli9RpbWO
	 5mpfUZYI1JIGA==
Date: Thu, 4 Sep 2025 10:29:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org,
	lorenzo.stoakes@oracle.com, kernel-team@android.com,
	android-mm@google.com, David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: centralize and fix max map count limit checking
Message-ID: <aLk_zbXxYxHs1Igk@kernel.org>
References: <20250903232437.1454293-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903232437.1454293-1-kaleshsingh@google.com>

On Wed, Sep 03, 2025 at 04:24:35PM -0700, Kalesh Singh wrote:
> The check against the max map count (sysctl_max_map_count) was
> open-coded in several places. This led to inconsistent enforcement
> and subtle bugs where the limit could be exceeded.
> 
> For example, some paths would check map_count > sysctl_max_map_count
> before allocating a new VMA and incrementing the count, allowing the
> process to reach sysctl_max_map_count + 1:
> 
>     int do_brk_flags(...)
>     {
>         if (mm->map_count > sysctl_max_map_count)
>             return -ENOMEM;
> 
>         /* We can get here with mm->map_count == sysctl_max_map_count */
> 
>         vma = vm_area_alloc(mm);
>         ...
>         mm->map_count++   /* We've now exceeded the threshold. */
>     }
> 
> To fix this and unify the logic, introduce a new function,
> exceeds_max_map_count(), to consolidate the check. All open-coded
> checks are replaced with calls to this new function, ensuring the
> limit is applied uniformly and correctly.
> 
> To improve encapsulation, sysctl_max_map_count is now static to
> mm/mmap.c. The new helper also adds a rate-limited warning to make
> debugging applications that exhaust their VMA limit easier.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  include/linux/mm.h | 11 ++++++++++-
>  mm/mmap.c          | 15 ++++++++++++++-
>  mm/mremap.c        |  7 ++++---
>  mm/nommu.c         |  2 +-
>  mm/util.c          |  1 -
>  mm/vma.c           |  6 +++---
>  6 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 1ae97a0b8ec7..d4e64e6a9814 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -192,7 +192,16 @@ static inline void __mm_zero_struct_page(struct page *page)
>  #define MAPCOUNT_ELF_CORE_MARGIN	(5)
>  #define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
>  
> -extern int sysctl_max_map_count;
> +/**
> + * exceeds_max_map_count - check if a VMA operation would exceed max_map_count
> + * @mm: The memory descriptor for the process.
> + * @new_vmas: The number of new VMAs the operation will create.
> + *
> + * Returns true if the operation would cause the number of VMAs to exceed
> + * the sysctl_max_map_count limit, false otherwise. A rate-limited warning
> + * is logged if the limit is exceeded.

kernel-doc will be unhappy because of missing Return: description. Please
s/Returns/Return:/

> + */
> +extern bool exceeds_max_map_count(struct mm_struct *mm, unsigned int new_vmas);

No need for 'extern' here. And the declaration should go to mm/internal.h

>  extern unsigned long sysctl_user_reserve_kbytes;
>  extern unsigned long sysctl_admin_reserve_kbytes;

-- 
Sincerely yours,
Mike.

