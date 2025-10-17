Return-Path: <linux-kernel+bounces-857997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C914BE8803
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4779E4F0A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450462D94AF;
	Fri, 17 Oct 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VOv+wNfj"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4151332EAC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702575; cv=none; b=Z4CXlZKfETyVFhWrlrZzAua2bWzZ2ZUF4ueRtkbI27ND6iEjDu8ta3azAGsJuKDzkGFrFaDNhCZP/y6jek+7BBhFSpdwVLXGCYjsfx94mBpWuTdaRfODwWllld4iJSlzTraezBedss7zEW2zoQPHjxDS5HFw8+PdwqhxHbiTSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702575; c=relaxed/simple;
	bh=giDerTFT7zFIgeOoQMXXqNLTe9hhWXHGn7G/GN63yZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReWCR+2EFJQZNtnYV/Wqw+tZSSD/myD3vofUrReo3hHsGTI67nWohgH1o699KxMqWu4KhmSoR7zQRz0uqngu+d1UIO7/LNajKWK1dRgzbC0/JfK5HWqQybV1Dc7y5dC9jFKSVpVjfFgNZ9nA8tGHVer9PYXK36+CJbFJeujNdZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VOv+wNfj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so1594584f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760702571; x=1761307371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JPR8GH5hcgadFN4LhX9XG9fVjAZMNhtsFHX93XBRmk=;
        b=VOv+wNfjyCx9joUi6ndU7XAVK+zOCugw/zzq+MwElm9gTo3u+/pIuRmbsn6hB8MQ0p
         olE6NmKpiJQ56BSviDhd8KCNgUnzbNTwpGFvtYXunpwn28e6TtNYACQQzMTkJ+/KJgkR
         lFdAuVYjAu3TDQhLJntbtf2YT1GEZqDzPcENtcWtEctBko8z6n7arx82L8mw9G5B8Hlz
         GistNpKQrHwsq21G54PlZa26r4HJ8/4COzaz7+GhPoUUIL57kmmhsQs02EPXPhvpqnyO
         N8J5mDHiu1RrXHxRskp+Th1MziEVsa9TII+ABoawGeLKx8UsgNc7s3TinRj7ji1arlVP
         u7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760702571; x=1761307371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JPR8GH5hcgadFN4LhX9XG9fVjAZMNhtsFHX93XBRmk=;
        b=mg5CQbXeuMPVMlLVB8X/fG4NVvoel+LA7rON5P9uxh/m1QYTRgNLMfbickI+ZvNZmf
         Abq2OT/3G8jzsIhrlgfmxTtE7OaulRphE+P2j05uDik1W7tnilk2HTgvym7fHyBNSZhY
         5npXZVrAUxJ/bMZde+7zICm16x1Zy1IshzBoRFP9dnHJHvLzWgyrk+dF1WAocuqI5J/O
         6cE+wXKBuO9uNGYJZcvatgkyj3Q39OI/Z2JlQDURuze66oky/e9/OxpvkTR8NjfjebqY
         a6tY7hGEV9e0TE5qcwgmrrUT21BHfWACmEyszW6g1o2pTYh+rtd0In8CeMVNHoMGInzz
         Bjnw==
X-Forwarded-Encrypted: i=1; AJvYcCV5bhnpbd/+ImP0t461Wp8tyEM6CAB9WXvl0MRKrpdTdICojfvH88YBEb+w5F8OtqpM5xqcFaWLJoJjySU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Uf9qQsHP5yJzA27Q2tZTbDTYlGuvv2EWjltEOOSGwxW/rqXH
	Ay3tEDKirgarPTsCIhcjq+gzMx5ptmOA96H1BxxZLAJpZhDNKwASmIhqTUadIvQKgrw=
X-Gm-Gg: ASbGncvrDON4ZNoUnIzp7vkLHDeYSNKkNi5R/oPvnnBjeg5RjYi8Q5c1SWaP6eRD2Gd
	vYY/XlfWTpEC1CJrSlfIAZwqPL/UlnM6FJIV2Sbk/xgzT8h7Dyg0rg6GpnJVAiLfU0PeSVoVgL/
	k4Kr69d2sff1mAtYeEae3+eLwcfspv4OQ4dNGc2ruTsIsi4XyrdXTCaN5olkmFVteaIEPx9gm6U
	3AiLqtxpseQbjMp79tHvvIQALxJBuubReYOd9mqTYR6/W6i4+L1VnBqWQbC/lsuoVTnvrfUVqJv
	F92BBaYv7TmC1K3Yl/nS5YaXQ9GyQv7XS/OGF5CzBcVRp/xJWKaie3a/r63FL1ECej7Rj0tXGL7
	HRYNkAo3iqYlxRMR/8ZaFZeg3FJM6Sukp8P3CzJUATph7uF5nLBgAZfDpk8cNU07SdZIEjc1EpN
	5hznGis60TDtM=
X-Google-Smtp-Source: AGHT+IE06r98UHWFT2Xk7ldaGKsG7wzyanlhTrg8kwfuMMKG0UEDDaMDa+nIp24NV8a0FkDRNf9r/w==
X-Received: by 2002:a5d:64c3:0:b0:426:dbef:9abf with SMTP id ffacd0b85a97d-42704d8e0b2mr2471395f8f.23.1760702571075;
        Fri, 17 Oct 2025 05:02:51 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4270665ef67sm4048567f8f.28.2025.10.17.05.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:02:50 -0700 (PDT)
Date: Fri, 17 Oct 2025 14:02:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mm: vmscan: simplify the logic for activating
 dirty file folios
Message-ID: <aPIwafJOKUh3N4zX@tiehlicka>
References: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
 <ba5c49955fd93c6850bcc19abf0e02e1573768aa.1760687075.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5c49955fd93c6850bcc19abf0e02e1573768aa.1760687075.git.baolin.wang@linux.alibaba.com>

On Fri 17-10-25 15:53:07, Baolin Wang wrote:
> After commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no longer
> attempt to write back filesystem folios through reclaim.
> 
> However, in the shrink_folio_list() function, there still remains some
> logic related to writeback control of dirty file folios. The original
> logic was that, for direct reclaim, or when folio_test_reclaim() is false,
> or the PGDAT_DIRTY flag is not set, the dirty file folios would be directly
> activated to avoid being scanned again; otherwise, it will try to writeback
> the dirty file folios. However, since we can no longer perform writeback on
> dirty folios, the dirty file folios will still be activated.
> 
> Additionally, under the original logic, if we continue to try writeback dirty
> file folios, we will also check the references flag, sc->may_writepage, and
> may_enter_fs(), which may result in dirty file folios being left in the inactive
> list. This is unreasonable. Even if these dirty folios are scanned again, we
> still cannot clean them.
> 
> Therefore, the checks on these dirty file folios appear to be redundant and can
> be removed. Dirty file folios should be directly moved to the active list to
> avoid being scanned again. Since we set the PG_reclaim flag for the dirty folios,
> once the writeback is completed, they will be moved back to the tail of the
> inactive list to be retried for quick reclaim.

Is there any actual problem you are trying to address or is this a code
clean up? How have you evaluated this change? 

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/mmzone.h |  4 ----
>  mm/vmscan.c            | 25 +++----------------------
>  2 files changed, 3 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 7fb7331c5725..4398e027f450 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1060,10 +1060,6 @@ struct zone {
>  } ____cacheline_internodealigned_in_smp;
>  
>  enum pgdat_flags {
> -	PGDAT_DIRTY,			/* reclaim scanning has recently found
> -					 * many dirty file pages at the tail
> -					 * of the LRU.
> -					 */
>  	PGDAT_WRITEBACK,		/* reclaim scanning has recently found
>  					 * many pages under writeback
>  					 */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 65f299e4b8f0..c922bad2b8fd 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1387,21 +1387,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  
>  		mapping = folio_mapping(folio);
>  		if (folio_test_dirty(folio)) {
> -			/*
> -			 * Only kswapd can writeback filesystem folios
> -			 * to avoid risk of stack overflow. But avoid
> -			 * injecting inefficient single-folio I/O into
> -			 * flusher writeback as much as possible: only
> -			 * write folios when we've encountered many
> -			 * dirty folios, and when we've already scanned
> -			 * the rest of the LRU for clean folios and see
> -			 * the same dirty folios again (with the reclaim
> -			 * flag set).
> -			 */
> -			if (folio_is_file_lru(folio) &&
> -			    (!current_is_kswapd() ||
> -			     !folio_test_reclaim(folio) ||
> -			     !test_bit(PGDAT_DIRTY, &pgdat->flags))) {
> +			if (folio_is_file_lru(folio)) {
>  				/*
>  				 * Immediately reclaim when written back.
>  				 * Similar in principle to folio_deactivate()
> @@ -1410,7 +1396,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  				 */
>  				node_stat_mod_folio(folio, NR_VMSCAN_IMMEDIATE,
>  						nr_pages);
> -				folio_set_reclaim(folio);
> +				if (!folio_test_reclaim(folio))
> +					folio_set_reclaim(folio);
>  
>  				goto activate_locked;
>  			}
> @@ -6105,11 +6092,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
>  			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  
> -		/* Allow kswapd to start writing pages during reclaim.*/
> -		if (sc->nr.unqueued_dirty &&
> -			sc->nr.unqueued_dirty == sc->nr.file_taken)
> -			set_bit(PGDAT_DIRTY, &pgdat->flags);
> -
>  		/*
>  		 * If kswapd scans pages marked for immediate
>  		 * reclaim and under writeback (nr_immediate), it
> @@ -6850,7 +6832,6 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
>  
>  	clear_bit(LRUVEC_NODE_CONGESTED, &lruvec->flags);
>  	clear_bit(LRUVEC_CGROUP_CONGESTED, &lruvec->flags);
> -	clear_bit(PGDAT_DIRTY, &pgdat->flags);
>  	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  }
>  
> -- 
> 2.43.7
> 

-- 
Michal Hocko
SUSE Labs

