Return-Path: <linux-kernel+bounces-859590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE800BEE09B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF4754E1F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702B22FE15;
	Sun, 19 Oct 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R86NUg/G"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC81096F
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861999; cv=none; b=pdwhYhCXEHaBfiY226uZa6/LRGjv0prPqIDKf20oWpbl++6AbAju+4425LAa2Lo0KdtVYRdY5YK3+pGuDh9x9fm+CgSDQsmsr2/fnM9wr0DJOHp/5t7FIb5O3P3+rmpOHP9LlSDPstdv7/TG33C4CwrLe+IMUZ6UczZd+cCpi7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861999; c=relaxed/simple;
	bh=TiA0y5gktErT5lt5edVPgPFmEhKkiZW7SslzyMlEg58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSYj1vBiHpwjWKqDgb60c8gde9DZgRURru8qNXXKEAkCvGdrwk4q0I9zAfcWSSkHqU3uQ6r8G4koOox+2L05t6U/Wl8JfqvvnvWpeMUBCaJTCuL4nP3t3GwyyPxFSv6579OakKAw0syF6zTf2BspVBIUKfh4lesxBr9VXQ9+87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R86NUg/G; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b660019ac2aso291097566b.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760861996; x=1761466796; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzAnCEb80QifK9acVK1YEWu5S4rWy7O2ChI/IhFvLrQ=;
        b=R86NUg/GjvDWMzZiHmoebEbVk9BG3mqSsUBp7j0KtQ+1QJgcl1IU++SV5t1qljAYNr
         XbypAS2KcBpCqs6FvnHTSJYFUcYAhpYDTAKfmIrHjLfILlilP9tBZofWXRhdF+f3RgVa
         ObT2bAHC/NN/5yO49QG0Uvq0ze32NbG7VJY4RH8ARL8xRwo5iuxruKR8W37D2g7I2Jtt
         R/+EiF9lP1ivQHoTleNDfzRKoP+Tb/KPxjaBp8wEImWAqxasVLYx2MzHeQ82WgM2xgeQ
         B3BV3C1Cx2ZtVyDLhgOcn7k2BJU61lh5uCM8fvWG0Sk2WGpvqSEhVsXrEEgj+KLUExf/
         We5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760861996; x=1761466796;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzAnCEb80QifK9acVK1YEWu5S4rWy7O2ChI/IhFvLrQ=;
        b=BgezrU0LZqjPXbI4TvreBtCBDoVbpIP3vAX4Pzg6gQZMZy8GmQCeuOK3JdRU6C6Osh
         rl2ultPehqKoN/WTZShDAOHrXV98QwZ6HEIRrIGFZzSRhE2nGEYR1e7nmOH6ddNvS1YJ
         YMefNiZjH68inMV4QWdx0N6/gN1AQUOTl6XAjwJod/ZrFZBkTcQX1KJzpNcURELBBWb+
         KNPwKNCf0PCrBvSInoH4g8uI9i0jFFhmEwaCqEUHNe0g4V60QwAa1JeaxHkr1nnJ2pgn
         o5GhF5f0QIK11ReNdGIkZ+xsFclKOOp6fWBREe9XmtKwPjpyMMfQh74WSjThFlP6MIl6
         aPxA==
X-Gm-Message-State: AOJu0YxkXCFt0XgKEfHbgV29YBl+u3xB3b1xNb9ir8dfmOBHleKjqOta
	ahNJjL1mp5e5Ybg598DYmwXSQHgU9ClrBuYGVtnU/Xu0KxPi9gjZx+S1
X-Gm-Gg: ASbGncvrc1CTy57D+gQHKc08uRs/I6jL5iB0gNw0Z3Rrwlok/sp4JCr1vhpVe/JbG/z
	tHyLxVoIcMkWkG8rciv7HtF67ndYg5KuuJmdjDk+22Sr89bK0x5ZFwNTzBTan/D9gCX7n8rbr5M
	gmH1GQMc4dYUeGjv+xAU1K9ES3CyReSUHFkcyuu6ki6l42ko6M/jLtdDJOdsfEwbG4ZQBFC/V3v
	5W9ezzEFI3QJINQs25xpZNtSzQxfDy7/dijHCijcLd8q11RKtJRezVGP8Qxagnw3wIkbKY/56SA
	96cc5Zyqs65CfZeuKZAP/1U+AhPgqncTIZg/0Dr3HVR3Yom3cwQ/Pj0/dTeZrvfXd2d4Pf8lOVk
	QHDSyD3U5U4MCa5dcebQe+zGx2LKWRDnyTavn3rS1K/MgWIMRdepw+6Zc6i61fq322V4cdShIZz
	PQMhg=
X-Google-Smtp-Source: AGHT+IGe2bSS2UoD1lk0Xxfgzd8YXhfUNUOT8b22z2p6gAASSaXv1SkNEJLCq1pmMcg1S7iCxcQ1kQ==
X-Received: by 2002:a17:906:c145:b0:b57:78fa:db48 with SMTP id a640c23a62f3a-b6474f185a3mr1028142366b.51.1760861995556;
        Sun, 19 Oct 2025 01:19:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb499dasm457209766b.73.2025.10.19.01.19.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Oct 2025 01:19:55 -0700 (PDT)
Date: Sun, 19 Oct 2025 08:19:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Mika =?iso-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v7 11/16] mm/migrate_device: add THP splitting during migration
Message-ID: <20251019081954.luz3mp5ghdhii3vr@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251001065707.920170-1-balbirs@nvidia.com>
 <20251001065707.920170-12-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001065707.920170-12-balbirs@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 01, 2025 at 04:57:02PM +1000, Balbir Singh wrote:
[...]
> static int __folio_split(struct folio *folio, unsigned int new_order,
> 		struct page *split_at, struct page *lock_at,
>-		struct list_head *list, bool uniform_split)
>+		struct list_head *list, bool uniform_split, bool unmapped)
> {
> 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
> 	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>@@ -3765,13 +3757,15 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 		 * is taken to serialise against parallel split or collapse
> 		 * operations.
> 		 */
>-		anon_vma = folio_get_anon_vma(folio);
>-		if (!anon_vma) {
>-			ret = -EBUSY;
>-			goto out;
>+		if (!unmapped) {
>+			anon_vma = folio_get_anon_vma(folio);
>+			if (!anon_vma) {
>+				ret = -EBUSY;
>+				goto out;
>+			}
>+			anon_vma_lock_write(anon_vma);
> 		}
> 		mapping = NULL;
>-		anon_vma_lock_write(anon_vma);
> 	} else {
> 		unsigned int min_order;
> 		gfp_t gfp;
>@@ -3838,7 +3832,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 		goto out_unlock;
> 	}
> 
>-	unmap_folio(folio);
>+	if (!unmapped)
>+		unmap_folio(folio);
> 
> 	/* block interrupt reentry in xa_lock and spinlock */
> 	local_irq_disable();
>@@ -3925,10 +3920,13 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 
> 			next = folio_next(new_folio);
> 
>+			zone_device_private_split_cb(folio, new_folio);
>+
> 			expected_refs = folio_expected_ref_count(new_folio) + 1;
> 			folio_ref_unfreeze(new_folio, expected_refs);
> 
>-			lru_add_split_folio(folio, new_folio, lruvec, list);
>+			if (!unmapped)
>+				lru_add_split_folio(folio, new_folio, lruvec, list);
> 
> 			/*
> 			 * Anonymous folio with swap cache.
>@@ -3959,6 +3957,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 			__filemap_remove_folio(new_folio, NULL);
> 			folio_put_refs(new_folio, nr_pages);
> 		}
>+
>+		zone_device_private_split_cb(folio, NULL);
> 		/*
> 		 * Unfreeze @folio only after all page cache entries, which
> 		 * used to point to it, have been updated with new folios.
>@@ -3982,6 +3982,9 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
> 
> 	local_irq_enable();
> 
>+	if (unmapped)
>+		return ret;

As the comment of __folio_split() and __split_huge_page_to_list_to_order()
mentioned:

  * The large folio must be locked
  * After splitting, the after-split folio containing @lock_at remains locked

But here we seems to change the prerequisites.

Hmm.. I am not sure this is correct.

>+
> 	if (nr_shmem_dropped)
> 		shmem_uncharge(mapping->host, nr_shmem_dropped);
> 

-- 
Wei Yang
Help you, Help me

