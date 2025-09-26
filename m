Return-Path: <linux-kernel+bounces-834322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3ABA4704
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B799188FAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18421767C;
	Fri, 26 Sep 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+v2YQoh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBC2192FA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758900854; cv=none; b=niunXT/LXN8QgBL/XoSUVnOAj2AmOBiZQfXNcIrDtQAApymaFok0f9mHpWxA/oao8rgvZnH16T6VWyXFm4xL+blZb4lA+ckG8Ndk/RPfG5Q3QW698tWjBtj/VISBbGt5lKaDyDnAeJy2qXO1tG+keg5FvV09fY5emXJnikTW/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758900854; c=relaxed/simple;
	bh=amq4RZUuIaO1rbxYvaeVC1c+2M8VAlnoCSUSXeNoFNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ifhgD+Q9MXJCcCkGawqaRSww9Qu19AABQyhaSuAZS3Ni97w7ov8n223QXl7z4i95cQ533YmcsgsmdmBkQ6RYRI3DwjzqTUTaSOl+BQlR33j+IcUhfyciH08XaTqfBCq7Gd7twhQ1/iYsQhER1Mn4OZxlxv/V6m/EH21bBTLeMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T+v2YQoh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so22438745e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758900850; x=1759505650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMO5hgJCbwtV9PK2cFfsUx2fXWFzdBYn4BBsNRBK1CI=;
        b=T+v2YQohPTIzN4kEQWRq0cYV9ZDZqTYucZwR7q0W2eLRjx2HoE8UfIRsPIps5Yn5sO
         jmz0K+T4HY5B9ZfMzZgZzqHiCk036C1+OUubTygSUixPEoFAfaLRIaeFYM262GNS63HG
         O2FqAF3Oy97vDH/m97z5crpxM3DgvIQmaGRe39FbsRd09b0RHLoz8vxK3m4Udbu4KhUg
         CM2D+DcYqq1Kh9MBaZrMnYj4h1k9rkkR+ZWG4owWxE1+UGFrHaA2yXqAxwYhE3TAlqfK
         nPNkMY0UX+DY3PYtZxzwzY2rOdRzz27EC9+xPJ4qasTRqF4wE3akM2nNGj56ufv4Q4Va
         qHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758900850; x=1759505650;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMO5hgJCbwtV9PK2cFfsUx2fXWFzdBYn4BBsNRBK1CI=;
        b=dJLkWrCCHB+Q200gPhY5zHEW0JvYas2wYFg/xZ2YDyNn8oQwgbxXk+JeZwTEQMSdaT
         ZMd4kc2Jj5Ifa6gtRuQ92r/s+zIM5IIFH5zNag9hlL6s66HspdMefZIs9h4vwv7EeIy3
         ZhdQlQ26Pmx5DL3PXBbjMF6/gwAU3oHXNlEWcFoDF5TKX3JwnnOD/FmMn3/psmmB6/L1
         PseKW3TmX8LqG7N5eqsbuC+jOjxskriIUvgdrNWqS/xaYi9m9VeHUHmwZTtr7hbuLJbw
         exr1UBwE0nfTpryTdnLW9WcRCuqQzoRL8UizBvn6OKsO+xjvQdLH12T0sztyOHclsCqL
         1m/w==
X-Forwarded-Encrypted: i=1; AJvYcCVFarA/pK7ascrAfOdjyvkE/N2eoZgLqioqmrJJAW9KE7nyZODz2xPeMTKLYfL49Yxhd3bH4qTZNx355Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbP1UwZ0g1lU9wNJlorkYkwD/B+Kf/e07S+aCp5WypYnSDXSOf
	9moGR3FmssOwDE2OahLFKOtnJLJUTvT7UJPNBKou4qfZKhjnWVUXaKtrPmPQUz3Mn1w=
X-Gm-Gg: ASbGncvSsFtPufLuzupSEf5wZp+ok28NNJYXHsaFon/EkYWfKyaZrHwwnrOE63cd5Z3
	gGxRgzZtD4KVjbFbSF3gBn9SEorgRzpD1zCX1JdQjvytra4mqzPhBoKvItSKnQI5QVF9RkYzJhw
	fAJBa63w1CCL+tGhJDQzQDgfniJcyWC3zWBGzmzkoXFO3CVH5nU+dVqN0r90cjXCMhTofReaYH6
	HVDrskAR8hH8rMSlGvQVob+N7WjStltwM8Uvb/5EaqAHsPX+QGuIVoW0O5Or+VmC3XNZb7AF/e2
	Ry9xvXp1RZGo90pYMkY4Ju6Vw5LeIu3dcJvDgD8LgLdVkK4C+PzZTmGu3GLP+KKoIAsMZ+bEpLT
	5ucCUTscTPyXMmt5Jh3GAqmJ8solL
X-Google-Smtp-Source: AGHT+IGeo7JSWe4sg6wC+JHBWfGr9CcvjUdGf1N82kHCNBejo0CZ5f4vzEILeKedV9H4Kp7q6LdOzQ==
X-Received: by 2002:a05:600c:8b62:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-46e39bdf9b4mr41759465e9.26.1758900850403;
        Fri, 26 Sep 2025 08:34:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33bed6basm76990795e9.16.2025.09.26.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:34:10 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:34:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Joshua Hahn <joshua.hahnjy@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Mason <chris.mason@fusionio.com>,
	Kiryl Shutsemau <kirill@shutemov.name>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Jackman <jackmanb@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify
 refresh_cpu_vm_stats change detection
Message-ID: <202509260132.awvdNKqF-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924204409.1706524-2-joshua.hahnjy@gmail.com>

Hi Joshua,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Joshua-Hahn/mm-page_alloc-vmstat-Simplify-refresh_cpu_vm_stats-change-detection/20250925-044532
base:   097a6c336d0080725c626fda118ecfec448acd0f
patch link:    https://lore.kernel.org/r/20250924204409.1706524-2-joshua.hahnjy%40gmail.com
patch subject: [PATCH v2 1/4] mm/page_alloc/vmstat: Simplify refresh_cpu_vm_stats change detection
config: mips-randconfig-r073-20250925 (https://download.01.org/0day-ci/archive/20250926/202509260132.awvdNKqF-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project cafc064fc7a96b3979a023ddae1da2b499d6c954)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202509260132.awvdNKqF-lkp@intel.com/

smatch warnings:
mm/page_alloc.c:2591 decay_pcp_high() error: uninitialized symbol 'todo'.

vim +/todo +2591 mm/page_alloc.c

06fb80866d37b0 Joshua Hahn    2025-09-24  2564  bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
51a755c56dc05a Ying Huang     2023-10-16  2565  {
51a755c56dc05a Ying Huang     2023-10-16  2566  	int high_min, to_drain, batch;
06fb80866d37b0 Joshua Hahn    2025-09-24  2567  	bool todo;

needs to be initialized to false.

51a755c56dc05a Ying Huang     2023-10-16  2568  
51a755c56dc05a Ying Huang     2023-10-16  2569  	high_min = READ_ONCE(pcp->high_min);
51a755c56dc05a Ying Huang     2023-10-16  2570  	batch = READ_ONCE(pcp->batch);
51a755c56dc05a Ying Huang     2023-10-16  2571  	/*
51a755c56dc05a Ying Huang     2023-10-16  2572  	 * Decrease pcp->high periodically to try to free possible
51a755c56dc05a Ying Huang     2023-10-16  2573  	 * idle PCP pages.  And, avoid to free too many pages to
51a755c56dc05a Ying Huang     2023-10-16  2574  	 * control latency.  This caps pcp->high decrement too.
51a755c56dc05a Ying Huang     2023-10-16  2575  	 */
51a755c56dc05a Ying Huang     2023-10-16  2576  	if (pcp->high > high_min) {
51a755c56dc05a Ying Huang     2023-10-16  2577  		pcp->high = max3(pcp->count - (batch << CONFIG_PCP_BATCH_SCALE_MAX),
51a755c56dc05a Ying Huang     2023-10-16  2578  				 pcp->high - (pcp->high >> 3), high_min);
51a755c56dc05a Ying Huang     2023-10-16  2579  		if (pcp->high > high_min)
06fb80866d37b0 Joshua Hahn    2025-09-24  2580  			todo = true;
51a755c56dc05a Ying Huang     2023-10-16  2581  	}
51a755c56dc05a Ying Huang     2023-10-16  2582  
51a755c56dc05a Ying Huang     2023-10-16  2583  	to_drain = pcp->count - pcp->high;
51a755c56dc05a Ying Huang     2023-10-16  2584  	if (to_drain > 0) {
51a755c56dc05a Ying Huang     2023-10-16  2585  		spin_lock(&pcp->lock);
51a755c56dc05a Ying Huang     2023-10-16  2586  		free_pcppages_bulk(zone, to_drain, pcp, 0);
51a755c56dc05a Ying Huang     2023-10-16  2587  		spin_unlock(&pcp->lock);
06fb80866d37b0 Joshua Hahn    2025-09-24  2588  		todo = true;
51a755c56dc05a Ying Huang     2023-10-16  2589  	}
51a755c56dc05a Ying Huang     2023-10-16  2590  
51a755c56dc05a Ying Huang     2023-10-16 @2591  	return todo;
51a755c56dc05a Ying Huang     2023-10-16  2592  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


