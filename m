Return-Path: <linux-kernel+bounces-849337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E1BCFE10
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AED018966FB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 00:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A116D4EF;
	Sun, 12 Oct 2025 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuGbCC7L"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120572A1C7
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760229714; cv=none; b=hgDg9aZtM2qLnb8ojhROR83xjZMw9jzprTQI8WIHjzxQT4fltsfVagonzfRjSjmap88giywKHiPt1XM+ll5FZiCsVgrCvZLR1PwgltFtNCuNUEU8aL55Whtc1ky4Krk/M6fT60N7HY5n5oU/FFK4nEzMXr2rrzdJfm90WvPJWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760229714; c=relaxed/simple;
	bh=aZnv9BVlTL8LmT7lpNUNVSVlA/I7ZSaPKJXfly6ijs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk75VCQpomx7SN/pGA6W7ZfViOPj9xZlpdKnrGBSC+aEJqwkO95WRvA/9FWsuJ88WcuuK99F2fKxxjRhgXboG7oPyzJMOPDno/j6u/+M6OSCwawCVPyoCdE6cfy7ltoD4wy+G3r8VbIZrEFLP35ZSLGYJ/ccL0MFNP2dzvb1nTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuGbCC7L; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b48d8deaef9so570307466b.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760229711; x=1760834511; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbPiPr4v+tNnfGsd/T5+fk/qepklVVg1akCeQzWqFsk=;
        b=RuGbCC7LxLS0Zas78Q4xA/cMdV8/l0feiE1udtflQATL9cIyHbYBtIuJcrAByFW0zh
         pE5jGVixcQHv2yTSyqJ+1pw/eT8/KosZFti9NMmrahukxAThm6d3EiPmos1sbGzT+OzJ
         x4Aak4Kjc2xVEmZ9rpHwqzG+ZPxX+44RvLVTtd8/4NqDWU1v/uIiAdqjZPS3HSYPc/O9
         rzZM34KG3XOF5IDK0CPqTeHquwgoGqtgM30M9EGaORRr58/ysxFDuNx1+2lE5pfAe+vz
         aS+MI4hcDmmpVeeJV/YDiYntrQGr2o42ZgBFArAsUlxTg9hDTKwROv1qLSYR5o55X7mG
         rMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760229711; x=1760834511;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbPiPr4v+tNnfGsd/T5+fk/qepklVVg1akCeQzWqFsk=;
        b=eKrYjU3+RiobgLfaCrivZexZl7XTLjss63J3MWtQfoK+4kllMyPmzk5WxsQohCu3Z5
         sXe6VSiPa7NcikVlY6N+hkHvdu17evQQLUs+m9DGeaiFLrN/55CTZtGpMtMm73vsY1H4
         QLAYi6zkyTXPfZzCKgtgEPXfmehxs3WhAvp2mVakyVSp4mhKt/qCfY5sEl2udUBP4h3q
         dzsdSlagOwHglZZDF51H92w+2Zj0Cgsil/3uTclPRYGFTzVkVQhzTHmtNaulA8A/0N3/
         mnmn4ktpgPyZ6a1DjwDsKu6JjGyefrZQTP8/ejn3BMqVU+hJg5m5jGz5HUPU3fk2SZ6M
         CN1w==
X-Forwarded-Encrypted: i=1; AJvYcCU7eALt7iiFdRgYxwOvhhGZqDcjmudRh76ENmhse/3+OEFuhwiBXm1rfFrB0wusoO1UXA/CAlAfjcC2yGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx1b986VXc4JzZi4BXLj1hp8EoVs3FswKseXcqyckBbsS51BYr
	4dhoWdyxLdNO+KbnPPtrne1PKqo+HrQM1FcuVHqrqJZVls312Z8qkzr8
X-Gm-Gg: ASbGncsi8LiILmDDdSsJDNEZ35ZV3VzPrl+wsraYqbS9l7ZZ/wE6glkLMISuj2ranQj
	n6HcUiXv7nz/eTdhjoYnW++LpqUjEZw2Q5ai54Tm6lV2clPt2Kvl/Ad+yN+wzfPAfDMIie0r0tD
	e7pF4kCiKf+GJeCc5LDvTBF3zqzUb1WWzVYjd+7Ut1T5k0ZM/NCTEW6lBPGM/LB6CxgZ7v+o+XH
	Mjgr9u8Sv9PgrmUWSv6m2c8GTghu/wRA6mK7wVBPu72cOWyx3Ke2VcgjxFjEEWr44bm2fBGMaNA
	fZcmgy5x4d1zSAGXiQ0HzL4weHMwhtn9apDzFP1gk+Nsc+l/bL7vq9qTJMqasRTxtqOuOhH6gXO
	07DmZqabjbdBrqnHTAUtDacwOPVEjIhhYIAtKfYJg
X-Google-Smtp-Source: AGHT+IF2dF7uUP71zJe0AxIJHcNbD6vVscz6n/gJk2c5+tQVcfEKjcPR39Xn8LvDwnX+VoFZq//T9A==
X-Received: by 2002:a17:907:948d:b0:b3f:294c:2467 with SMTP id a640c23a62f3a-b50aa79397dmr1784338766b.10.1760229711049;
        Sat, 11 Oct 2025 17:41:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65d6994sm605672666b.28.2025.10.11.17.41.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Oct 2025 17:41:50 -0700 (PDT)
Date: Sun, 12 Oct 2025 00:41:50 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 1/2] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <20251012004150.sujjmfkleibhvlxl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010173906.3128789-2-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 10, 2025 at 01:39:05PM -0400, Zi Yan wrote:
>Page cache folios from a file system that support large block size (LBS)
>can have minimal folio order greater than 0, thus a high order folio might
>not be able to be split down to order-0. Commit e220917fa507 ("mm: split a
>folio in minimum folio order chunks") bumps the target order of
>split_huge_page*() to the minimum allowed order when splitting a LBS folio.
>This causes confusion for some split_huge_page*() callers like memory
>failure handling code, since they expect after-split folios all have
>order-0 when split succeeds but in really get min_order_for_split() order
>folios.
>
>Fix it by failing a split if the folio cannot be split to the target order.
>
>Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
>[The test poisons LBS folios, which cannot be split to order-0 folios, and
>also tries to poison all memory. The non split LBS folios take more memory
>than the test anticipated, leading to OOM. The patch fixed the kernel
>warning and the test needs some change to avoid OOM.]
>Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> include/linux/huge_mm.h | 28 +++++-----------------------
> mm/huge_memory.c        |  9 +--------
> mm/truncate.c           |  6 ++++--
> 3 files changed, 10 insertions(+), 33 deletions(-)
>
>diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>index 8eec7a2a977b..9950cda1526a 100644
>--- a/include/linux/huge_mm.h
>+++ b/include/linux/huge_mm.h
>@@ -394,34 +394,16 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
>  * Return: 0: split is successful, otherwise split failed.
>  */

It is better to update the document of try_folio_split()

> static inline int try_folio_split(struct folio *folio, struct page *page,
>-		struct list_head *list)
>+		struct list_head *list, unsigned int order)
> {
>-	int ret = min_order_for_split(folio);
>-
>-	if (ret < 0)
>-		return ret;
>-
>-	if (!non_uniform_split_supported(folio, 0, false))
>+	if (!non_uniform_split_supported(folio, order, false))
> 		return split_huge_page_to_list_to_order(&folio->page, list,
>-				ret);
>-	return folio_split(folio, ret, page, list);
>+				order);
>+	return folio_split(folio, order, page, list);
> }

-- 
Wei Yang
Help you, Help me

