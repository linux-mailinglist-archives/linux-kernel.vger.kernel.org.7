Return-Path: <linux-kernel+bounces-800033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4BFB432A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0632D581FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6A27A11A;
	Thu,  4 Sep 2025 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="W4tJs8i/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F227780E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967974; cv=none; b=MJnhbOhIbOcuTFXXj+ACNEFikM5DfjX3HejI2+JFDJD/hrN++tY5/SvdjT/QH5tshffUtA+IO9ZZmbBf82KYEtYvL9CP8hrLZXHXFc0aZoVGtDDLy2k4rdD1SwFlpmTbWc9LvX2mYVAJtN59Wjeh3C38tT8njrHjlL7yE1IzDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967974; c=relaxed/simple;
	bh=y4t/Jdo4yzbv6zs4gAbiyWG4+Gfwh/khzh9ymXobAnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik8gLj+ESvjsNmimBKE+5z+T9ksXgfAvRLrdfhksEA+SJVtgBD9+oPQG4EU2cUSbONdk0WaW9PzXcCdgF5pG9GU3cZIvdgtjhQf9Y/0PosDft26VMuxjxmnPEQcTDMVeZroXJkZKNaYPrpPkQ56kwmNZPo2D0quUbEQfhaao4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=W4tJs8i/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b88bff3ebso4660645e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1756967969; x=1757572769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xeSKYt59tE+FwuwJ50nVCu801bgC84aFDUoKejqvgzE=;
        b=W4tJs8i/GpXk+ks8eLUO1kZTWSXufkfeMlVWZn0aT7JK2b6/2tslgENr3ApAE7dfBr
         DVRrtnqXqkZQJTgptNTk3cC1rWkqA0lt1HDqKzqN/Z5m4sAM1sW5yGYSLttCPJvPpoHE
         SUYjztDLnTjYglfn7JTfAPgz0es6SJkrgBLQCipwU708pNdc0v3KwjWpATKHClRKdoaD
         Mn4oKCHVI49J8KzoIrXPNuY9662XONa2LgsNTy2poeEAeGcbl4DcL1SqBnKRKnayqF/s
         xkegurYd79w006+zLgVepfd/WxUqqc83CIQmXZDFAP7DekhwtHRcoAr1Tqjiv9dHwVvc
         wNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967969; x=1757572769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeSKYt59tE+FwuwJ50nVCu801bgC84aFDUoKejqvgzE=;
        b=w/w8ZTdaS3B8suoPGfSXu7bkqZL5wG9TgLkVs9IGhLwoWDM2G7otkYPBnMAwNu0qNG
         3gtjTQRM/aufCasxtFgVI5O4fgNZaiPQrpSbBAZB3S/hWY8i56wpGemziA8Ugo7AB0TX
         JWOVp/7JC2XFidPTgHbj1TuVUfrpv/WGxavpV6+Ya7Y+FBKcvjjWKiojVLBS6M4SR237
         t6UDbOT3FgcP0gdfsU3adFVS0uNgUABbgj+DXXXEwVsu87bnt4mVtirepNKwm2uawshe
         F3J4UmY3kS9mbLnSV972VUA0YMZeHcZ5x72PDBrm7biAuD2Cjio9X6OEMSMr2LAjmIRj
         XBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1qsja+OzaaQbLb9lNPPqXGXjAq1wpIVNIWibX3Ojg0OCch9PDtgRdQNpXYXYL0x5VxBOuPhlK7hZyxkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQLsPnkNpl8SHqx3/YzyFZB5PyO0f30O1UGSfUeRLkHRaKgS/v
	vzWivFN9MqPnCfxXbB4894Lp83hKYscta1GZbz0sBIzO3kcOwRE4TECDLimlOtPND5U=
X-Gm-Gg: ASbGnctrNGvohyTDAOi2eTrTZqrnayGIwwX1S5mKsPtQTOtJ86sKy1HEvoB41vFg8zE
	Z8xyOA6IlYynGCKioRHtlrGn6E6nuO8dPwQuFHUxwcNN2yycYYEMre2rv5EuyHv3x+4bFc3GBNx
	MoObpmos8rc4rthHVOwpGus1K9eJObMTd6fyjIYHi2ZEaLk6K4bv335GcSJzxWKkKMwWM/Y0Xe3
	n6vtr4+QMC91wPE/A0WibNeI/srm2NnTBnAJNd7Chlgm7HaysTGpEB4H6zo5AuLC0VKIEopYTwQ
	6thMKMU0HAi77AvIVReAWrYxY0LbA6PJ8HEascZzh8jhFxc9vhHqObCMQ/OO2o4xppDgkGH68Gz
	ffopRdbZMIQCU7FcZ/oIcnxPgfpDzpFZ3keHslTg3+fFJ2cfHEmkhv5Yhq84KBucC
X-Google-Smtp-Source: AGHT+IFiegQ522bjOvcDiJvdCYWpwG2rkOTJd+XipLaBdBULaP3mS7skd+Ceh64ohm1QHJsIGG2LZQ==
X-Received: by 2002:a05:600c:3ba8:b0:445:1984:247d with SMTP id 5b1f17b1804b1-45b8552853amr151642065e9.7.1756967968915;
        Wed, 03 Sep 2025 23:39:28 -0700 (PDT)
Received: from localhost (93-46-179-206.ip108.fastwebnet.it. [93.46.179.206])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dd2df4c8dsm1068485e9.15.2025.09.03.23.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:39:28 -0700 (PDT)
Date: Thu, 4 Sep 2025 07:39:27 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	SeongJae Park <sj@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v2] mm: show_mem: show number of zspages in
 show_free_areas
Message-ID: <20250904063927.GC2144@cmpxchg.org>
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

On Tue, Sep 02, 2025 at 09:49:21AM -0300, Thadeu Lima de Souza Cascardo wrote:
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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -310,6 +310,7 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>  			" inactive_file:%lukB"
>  			" unevictable:%lukB"
>  			" writepending:%lukB"
> +			" zspages:%lukB"
>  			" present:%lukB"
>  			" managed:%lukB"
>  			" mlocked:%lukB"
> @@ -332,6 +333,11 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
>  			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
>  			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
>  			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
> +#if IS_ENABLED(CONFIG_ZSMALLOC)
> +			K(zone_page_state(zone, NR_ZSPAGES)),
> +#else
> +			0UL,
> +#endif
>  			K(zone->present_pages),
>  			K(zone_managed_pages(zone)),
>  			K(zone_page_state(zone, NR_MLOCK)),

Longer-term, it might make sense to simply iterate enum zone_stat_item
and enum node_stat_item and print them all.

