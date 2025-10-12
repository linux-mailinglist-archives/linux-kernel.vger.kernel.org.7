Return-Path: <linux-kernel+bounces-849340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 51397BCFE27
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 03:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D653F4E196D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB61C3BEB;
	Sun, 12 Oct 2025 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZXPqA6V"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5895FC2E0
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760233034; cv=none; b=jP/s/OAhEIfRUeQUhAo6Hnmiz9MKKAwgsfmSckxxrkImTFBjUKOQzfJzfH8aj5FAszD6v2ezRt7wVkoenwJCyBrstsujtAE4IL7b2/V9/vlOCK0VI2KId/BNx9c3to+JDzQ3C82VqYKckvJJiwa3C00aoOZ0csfVLKgPEGoKES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760233034; c=relaxed/simple;
	bh=Hxdken8SqePdyF6aKvTmxjWPOeq4wdw4IyGalEeV4ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN8hoGcw78qX8dZqmpYoTzT2rBphbaXwZtMH2ZYoyhUK0wxaHGBWB3qOLT2b/xKRGehenobTt2KnS9S6e2nAMZKGvcYxWPBp5DqH/ENywarpMB5QpfrQZz27DePFaEwZtvF2gX+EbHqQLs8hPhpC4X+q+1AlMC/jemgqlJEHoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZXPqA6V; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so5099467a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760233028; x=1760837828; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXcj9t6DXLhYpSPkJydjzqZ2KkeR944EkcDSqKa6hio=;
        b=BZXPqA6VPyqZY/8CR4g2vWzJW46xJyuJvDZaDbZZeEwH5mj/0AlCPDi6gwbLH13oWB
         3L8baJFrS4y3FyZhuQ3zDD7/0W0J/AuZtJtL4eZnPCS3J25ayvoxParW4QGML/MEfbJu
         pbc9E8EvjAHF5M7Ny4ThuoesmvT4oTAk9Vxv/z26sfe9bOBjc/pXfOVdTExPsaALgtpl
         gVdmCVJ4Wk0OcZcH9x7/GFvhiiJ8Zsa1EVcMQZbWwd31TPy/NpyrOK1MaO2skdiikTvC
         xhePztsKU7aR8ikkn+769qRQT0O7OacRE7e1K0wxM+FIqlIBrieSAS1R9AHUFMb9D3TZ
         me0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760233028; x=1760837828;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXcj9t6DXLhYpSPkJydjzqZ2KkeR944EkcDSqKa6hio=;
        b=iHTvq1YOil+M5U6T9K6Y2Zu61tGe03W3QRzHhIA90Nhvo53RD7k51efPlyTCoflZLs
         6XvVLH49whpZmcXA9haK6z3wT0/4IGDw3uj+Z87j3hRx0JjRs1wUorEf2ltJgBXPIQ8E
         HvfL1oKSCcz9xfMZ5NNM5FeCfrqxsLLQsIvxj5g8cdRq2DMvBAtuhsPxEe+l/ePkYK2Y
         vWgYzJcbMzl8cwGXgP9pshcjUFj6JZMc2+wmNzYQsJLbECe4NAE0iHS3IoaTR6T5CNCi
         2N+8uNWI3cniccZwMkosf5+HHIhkhn87nuXGemlRd6K2JLzJmnl6LWBlY21vrob3PYc1
         Ym+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMnKxm/8/xouG6p0I9oU/x4sUdUXkkoZq/CURaUKm7Tx7v7SY+EnA5OmgJX1HstDC3BJclYmrux3KKZuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEc8KvtiNu8OX+xdLMNsBRpSP4ETJBYPkY0q4GeGtukYXnKTFn
	yaMQ/oUe+KpV9OVNsMYL9D00UlrenRNGHTfpMA91VYRXwV3ePaX76FiSCQyGcw==
X-Gm-Gg: ASbGnctKzdvv3U8wYnRL0mNrFcNPrKP4uEjBJ0aJ8qbRz6mdTXguI7ArpqKHL1iwBcN
	k7JdHM/se3OVFqtvuvZYQqa7mwhlsjcJU4H5Hl+AgLrRkMHWGmVu2fiYGgyTaMgQNaT9dpyPKxF
	16B1yseBbTQCCfxU6n3XL/PRfmzgxIjWsYmaLk6rmuUI/+pavld1oaXjXgZOiSwKRDzaEHVqgyo
	iZyL64AQv++HATWpP5s1kutJN43N483cJQqsA+oN0z04ZUWlQy6wI81B+cXyVlQdmabCBoxV6ek
	fe3q/ipmOwAGScxJB2ds+92gdTW8i6YVlRUKMGdiXeMHpP7XySKgpQlTIV0Q77yYMQ6PXG02zTi
	wg9M9nMWp1+NpfOBOpnHOOGsODSYmriePMS+qx6EgciDJiTwywXw=
X-Google-Smtp-Source: AGHT+IF3q3QHUAa+bs+cyKa8Yi9+rXO316YWM6xGdNo1TNDBJUSk4D3Z0NkO1+nlSSwWJkr1ZFVyBA==
X-Received: by 2002:a17:907:d64a:b0:b46:6718:3f20 with SMTP id a640c23a62f3a-b50ac7ee0efmr1825374666b.48.1760233028321;
        Sat, 11 Oct 2025 18:37:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d952a273sm631363666b.83.2025.10.11.18.37.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Oct 2025 18:37:07 -0700 (PDT)
Date: Sun, 12 Oct 2025 01:37:07 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com, linmiaohe@huawei.com,
	tony.luck@intel.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, nao.horiguchi@gmail.com,
	farrah.chen@intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
Message-ID: <20251012013707.ukkczekcmhntrot2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <8ef5e3fd-2ee8-453a-b8ae-584e3d606aa4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef5e3fd-2ee8-453a-b8ae-584e3d606aa4@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Sep 29, 2025 at 09:34:12AM +0200, David Hildenbrand wrote:
>On 28.09.25 05:28, Qiuxu Zhuo wrote:
[...]
>
>Hm, I wonder if we should actually check in try_to_map_unused_to_zeropage()
>whether the page has the hwpoison flag set. Nothing wrong with scanning
>non-affected pages.
>
>In thp_underused() we should just skip the folio entirely I guess, so keep
>it simple.
>
>So what about something like this:
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 9c38a95e9f091..d4109fd7fa1f2 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -4121,6 +4121,9 @@ static bool thp_underused(struct folio *folio)
>        if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>                return false;
>+       folio_contain_hwpoisoned_page(folio)
>+               return false;
>+

One question.

When hardware detect error, it would immediately trigger memory_failure()? Or
it will wait until the memory is accessed?

>        for (i = 0; i < folio_nr_pages(folio); i++) {
>                kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
>                if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
>diff --git a/mm/migrate.c b/mm/migrate.c
>index 9e5ef39ce73af..393fc2ffc96e5 100644
>--- a/mm/migrate.c
>+++ b/mm/migrate.c
>@@ -305,8 +305,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
>        pte_t newpte;
>        void *addr;
>-       if (PageCompound(page))
>+       if (PageCompound(page) || PageHWPoison(page))
>                return false;
>+
>        VM_BUG_ON_PAGE(!PageAnon(page), page);
>        VM_BUG_ON_PAGE(!PageLocked(page), page);
>        VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>
>
>-- 
>Cheers
>
>David / dhildenb
>

-- 
Wei Yang
Help you, Help me

