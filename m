Return-Path: <linux-kernel+bounces-800043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9303B432BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A9A580824
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD25279359;
	Thu,  4 Sep 2025 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fsRsu9ZO"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FA5279789
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756968253; cv=none; b=oaJ5LjdcnTDbzKH2tH/zg0q/B9w5abmnq303t4FVXpstSljtQZnyt6PSvg7Ld+UItXNDAlcNABolq8K07RKZvTa0VOTJGxgqydr2OUuI6zM4LhBXVLGWqDJzKJK6Q4/fUgM6BA07b9TUwdpXkHETtmCy7YAtgrTQrL1rUkblUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756968253; c=relaxed/simple;
	bh=no5g6kh/q3N7QBcAPXgyHHSN09IGNwlSQtOlsYahDcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuCyLe/ioH7FP//qAvAVvDEB2f09hl1oIlFDrYy+VFZK0Q+bF7pblXg7+T4w1hsd9bi41WOoLdATOuw790eJe+OhxcnJsLcPi8a4/dAvihLlwwjRLPYJijRAqRqPZkfBvfgQUUgxtKj3Au93EXKUvhpGupXzsBwZMCyc+PaelNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fsRsu9ZO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso788565b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756968251; x=1757573051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHqCMfo2LMLyGJcWsRGUvqsDIGVMcCFXVZ3lBJ2U6h0=;
        b=fsRsu9ZO7feauLO3ngbKvxQG04LNdEU+HpHU3nyEstelgGytOh8R4faLkh2lkPFAcv
         nTmvd3wU17YyEmKY050HavrQtZs4azuvuaNe/tnUwuR8LMK+DdZ6oKRQfpO2b3fqVSCq
         PcqHIJvjlKQBdbcut6F7HqogH8ZakxhTt5ZZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756968251; x=1757573051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHqCMfo2LMLyGJcWsRGUvqsDIGVMcCFXVZ3lBJ2U6h0=;
        b=MjCHhIxulGIureGK3e04THATwQhkKhmg35CHUikbtVF3jtPiiq6ZebzwFBfU4Ux9ru
         I+mJEutVVb07nR+5czoXRhEEmLdihd2bpRQ3jFjHxHj7BF+xW4iOdC7dIwm++0ZNLFiS
         i2FRgdaWpDApsrp/T/yJkwi0s3THZ3+X0k7alp6l3sgGkDJ41IhJM/GHjnAV/IXxn7d1
         sQQ+U3a8+NVa7Z1cxmpLvpYvr9yXCNTYafpDNvFOTAwe0mKlAmj3n/JArFmEuC/oSFH3
         mma0+CRUj27tN19T3NrDSD5hTb6xPhi7kYIfMwH9EnIEuv9QWHg598PR/uOOEzVZ+g5V
         RtFg==
X-Forwarded-Encrypted: i=1; AJvYcCU8BZZWsZsXEusXuq/3FFjohZWnBOrli3YZusXb1OnHfThsZkhAl+zqXr3nbR5LVWLyp9qG8tPNqMSA7O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzOs1ZWn7g2P8NkXNx5u829UnNdknR8UbQXHl6Ti4o3gSp/DfE
	P6EYB9ZTzse4sy35NJ9xYYX+HZ4GwFgJGmLvk1ZJvhQiB9/VkKRebtGrNCnhb3sR/A==
X-Gm-Gg: ASbGnctKsqNC0KN/hSKLbCnhLYj4oONq4XvLSMFAPxoojRXoFvLoCq4qYCz4IfWbQi+
	u92c0bqDH8PMk8ZHtXIauOhg56KXv6Oq7EIdqQ/9r7cpnip5D5is2Zrfw2S1WxZ/k3WufsX0M7w
	lLD/OK3T17XCQ9Va4Iye3ID4lHOoeE9Yqa9Kw1CJcWNHZrazCukH+Z7x67lYRVBKpsCQ4ywuJqS
	GSg1h4j8sDUIxcZuO3HY7Fe/VPliRADS7EcPMYeaLbU5wgZge7zPlJY/hlK+M8VAO2e7xWopBrY
	a51sAVE+VzjfIqCxgw0Z1LtvO4uqo2N7G1JfCNS0aDAadRai7JfoNFNnfgoGzqHW1kzbbq7BnD8
	nQ05UxEub4b2IL4CRr+rE56h1+mWjVFvq7Blv
X-Google-Smtp-Source: AGHT+IH+YV2qOYaN4nAmRg/9LL/OyAH/fMjV4M0D/ewSy12gz6JAK3OGJf1jiWaSOYJGAgUKWxuE0A==
X-Received: by 2002:a05:6a00:b4e:b0:772:6f95:f326 with SMTP id d2e1a72fcca58-7726f95f5d9mr10062470b3a.10.1756968250799;
        Wed, 03 Sep 2025 23:44:10 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:d677:a82d:7e38:6189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772818bd5e1sm3767728b3a.86.2025.09.03.23.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:44:10 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:44:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	SeongJae Park <sj@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] mm: show_mem: show number of zspages in
 show_free_areas
Message-ID: <paef7bzotb4runl4sjlcfesano36cc2bflb7uqe5mil3chnpgn@axng3yfe33w6>
References: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-show_mem_zspages-v2-1-545daaa8b410@igalia.com>

On (25/09/02 09:49), Thadeu Lima de Souza Cascardo wrote:
> When OOM is triggered, it will show where the pages might be for each zone.
> When using zram or zswap, it might look like lots of pages are missing.
> After this patch, zspages are shown as below.
> 
> [   48.792859] Node 0 DMA free:2812kB boost:0kB min:60kB low:72kB high:84kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:11160kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   48.792962] lowmem_reserve[]: 0 956 956 956 956
> [   48.792988] Node 0 DMA32 free:3512kB boost:0kB min:3912kB low:4888kB high:5864kB reserved_highatomic:0KB free_highatomic:0KB active_anon:0kB inactive_anon:28kB active_file:8kB inactive_file:16kB unevictable:0kB writepending:0kB zspages:916780kB present:1032064kB managed:978944kB mlocked:0kB bounce:0kB free_pcp:500kB local_pcp:248kB free_cma:0kB
> [   48.793118] lowmem_reserve[]: 0 0 0 0 0
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> v2:
> - fix build when CONFIG_ZSMALLOC is not enabled
> ---
>  mm/show_mem.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/show_mem.c b/mm/show_mem.c
> index 41999e94a56d623726ea92f3f38785e8b218afe5..c563d9adfa87765a8736e91c1f68d824b03eaea8 100644
> --- a/mm/show_mem.c
> +++ b/mm/show_mem.c
> @@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>  			" inactive_file:%lukB"
>  			" unevictable:%lukB"
>  			" writepending:%lukB"
> +			" zspages:%lukB"
>  			" present:%lukB"
>  			" managed:%lukB"
>  			" mlocked:%lukB"

A little "preliminary optimization" idea: do we want to specifically
refer to it as "zspages" or do we want a more generic term, just in
case if zsmalloc goes away, or if there is (are) another allocator(s)
for compressed swaps?

