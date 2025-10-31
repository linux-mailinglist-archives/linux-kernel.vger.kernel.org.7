Return-Path: <linux-kernel+bounces-879429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBCC23156
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06F6425481
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590D30DECF;
	Fri, 31 Oct 2025 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUKSpV+A"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E851C262FED
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879356; cv=none; b=M5HOM3tFPygTEBI3uG9Vu5d2IMZ2Ca+DwfauJ7wsju692VTXfzfQh08NFpY7QsO5Q0tk33/pHsxZZpjKuTB3z1ZHgEdzUCR37XQlPVvOziTC9pr6GlGkEiUfzCnErUC0hQlHQoJv5NNGc8/wkHDyIuDmluYNG9JiiMjxXf51/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879356; c=relaxed/simple;
	bh=35IxH3AVqIfszjuIBMqHIXPBco12DNO3hgOgY8U+IZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXK0GjmNAlRIRx7VPofQmaX2I7zxqbd3ECU7wJhq8KoHrQ5EhhUMZ1A5IxX+Ok9Ymv+NICdLtxAo/0oT1w74nO1Vaec1qdK2rMlIgYnfcw4f4VaRLMdwHlsZUbHb3w1Lunyb+I2COyon6cuYOmPrADpgarp86NpyW4jqBQ23xds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUKSpV+A; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6d6984a5baso337739466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761879353; x=1762484153; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbb+HtAkz5E08qbbx7069G9TclCwWAydoNERXltG7Jo=;
        b=SUKSpV+An5JSUBKscu1wjho+soc8GgEgqx6fvdHdzodN5+9H9hUeqyt3WIZOKE2u/v
         fKjmkMROf3QduSKuo/t3i1I4EAij19g3XkdJw3c/hBQPyOGHSecwutAv4KD9ba7Mv2cS
         7x9BwI3mP1gEUTXPod50HuwSlcheiGh9RSAlWowCIFTkbk2Oza/sg/0VDuLVfSDnZfUt
         5m/qWZ5GSfkT8jR62GAfyITZ9/t19429B3YTzZS30Pdx9492WKOIhDi9YNhmomccnxH8
         cgORH0ya+pKllOSDnyf+7uuDLyQdA506b/OdWf6kVHUnOQ9S5/LhKA9SaBaYlp4npdn9
         lDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879353; x=1762484153;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dbb+HtAkz5E08qbbx7069G9TclCwWAydoNERXltG7Jo=;
        b=EL3Ur6hcQA9JmuYOECbvQYuT81caNWkNB8Kp7BUcBu6wlNnyJ0vfolbFH4lnYQ2FC0
         PnV1iEdhcfKzIJdHpryBkXN5m05EwRKietz/y67eTsKkK2OO7rOhqKttmmXAFQjxTyMI
         OGReym7ZYjG5PzLvm0b+64zs2O543dKxBMP+9Pd/Db8gN0sy0h8asavOWy5Thm+7R/Px
         vPuRSu0tnM1M3erAhDIwjp5Wp6ISKlDrOuhnLuIptDdRQFOGb447JzAcM3Itq9THPy22
         PWanMmY1ZS5BqiseJ7tRSV2yoHl6UDPFwxbMStCogFp4H69SrTzbXAPHBeYsNsHXeVnE
         FHkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn9ZYKQSWE2fWae2F6jbJo7dYbFaDfNY7lYUBOaAoRwkHHaSgkIptrNP2Mb41UFEwptWuGgz9jukxv+DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmzXOFKey/eYbLPdfnSgoYXeQjHcGzCSiKK8vLUrAnsUttdgDV
	gJD/9D2VB/E8cAHBkWLm7hUfEt27Qnn6tIpmWTEzyHQRTNKvOf5fk+yC
X-Gm-Gg: ASbGncud4OrXIJkE6x6M94tUCInlDoScK4VKPgDX+yo2NB/9mvYicF1sB5oduWlWPT1
	5knCxMZtQGRohqEZiYyeCEZoBeQB2JZ3HSVbLpmYYqZfCzyCmtK6rMFp+Z1/50ThEj+xux78xMn
	PHV62HFKPS9ITBu/MHAR1B417UAZ2cBM4COzaqKiyNZEuUy300RNfYWw1qpPjTtIaYzS2U19M/z
	sxpavUr7mBYwFjMEjdXpbJz/sBfeBSchrGXT4DUPE/xhWLdQqsKBWxrxsTyca8JJWXMIvVEpLxt
	8uYbDFNne8V7jqTxPSHpQ/VZjLKXRkDoUm25v72ufF8oak/uhsh1bII+bgq2kZ8D9iHf5DaWWcb
	/xh8AUohD/nLa3/iwYEuiwZlm/uFJr9M44wcv5Lbatu4AydZDGkVG0j2azt0iUOCT3sJPpDRrds
	Y=
X-Google-Smtp-Source: AGHT+IFaVEZlf1vH3SzuCruGg4BO7/3SvDRPUOGQR9RtSR34EJQMmXJ0JlLsI6L2lpx3vT3NXuIEKA==
X-Received: by 2002:a17:907:3f13:b0:b0e:d477:4972 with SMTP id a640c23a62f3a-b707019d264mr198901366b.25.1761879353147;
        Thu, 30 Oct 2025 19:55:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cd2d48sm48761266b.60.2025.10.30.19.55.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:55:52 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:55:51 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Message-ID: <20251031025551.bmt4wh6e6tmhcr4i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-4-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030014020.475659-4-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 29, 2025 at 09:40:20PM -0400, Zi Yan wrote:
>try_folio_split_to_order(), folio_split, __folio_split(), and
>__split_unmapped_folio() do not have correct kernel-doc comment format.
>Fix them.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Acked-by: David Hildenbrand <david@redhat.com>

Generally looks good, while some nit below.

>---
> include/linux/huge_mm.h | 10 ++++++----
> mm/huge_memory.c        | 27 +++++++++++++++------------
> 2 files changed, 21 insertions(+), 16 deletions(-)
>
>diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>index 34f8d8453bf3..cbb2243f8e56 100644
>--- a/include/linux/huge_mm.h
>+++ b/include/linux/huge_mm.h
>@@ -386,9 +386,9 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
> 	return split_huge_page_to_list_to_order(page, NULL, new_order);
> }
> 
>-/*
>- * try_folio_split_to_order - try to split a @folio at @page to @new_order using
>- * non uniform split.
>+/**
>+ * try_folio_split_to_order() - try to split a @folio at @page to @new_order
>+ * using non uniform split.

This looks try_folio_split_to_order() only perform non uniform split, while the
following comment mentions it will try uniform split if non uniform split is
not supported. 

Do you think this is a little confusing?

>  * @folio: folio to be split
>  * @page: split to @new_order at the given page
>  * @new_order: the target split order
>@@ -398,7 +398,7 @@ static inline int split_huge_page_to_order(struct page *page, unsigned int new_o
>  * folios are put back to LRU list. Use min_order_for_split() to get the lower
>  * bound of @new_order.
>  *
>- * Return: 0: split is successful, otherwise split failed.
>+ * Return: 0 - split is successful, otherwise split failed.
>  */
> static inline int try_folio_split_to_order(struct folio *folio,
> 		struct page *page, unsigned int new_order)
>@@ -486,6 +486,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
> /**
>  * folio_test_pmd_mappable - Can we map this folio with a PMD?
>  * @folio: The folio to test
>+ *
>+ * Return: true - @folio can be mapped, false - @folio cannot be mapped.
>  */
> static inline bool folio_test_pmd_mappable(struct folio *folio)
> {
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 0e24bb7e90d0..381a49c5ac3f 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
> 		ClearPageCompound(&folio->page);
> }
> 
>-/*
>- * It splits an unmapped @folio to lower order smaller folios in two ways.
>+/**
>+ * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
>+ * two ways: uniform split or non-uniform split.
>  * @folio: the to-be-split folio
>  * @new_order: the smallest order of the after split folios (since buddy
>  *             allocator like split generates folios with orders from @folio's

In the comment of __split_unmapped_folio(), we have some description about the
split behavior, e.g. update stat, unfreeze.

Is this out-dated?

-- 
Wei Yang
Help you, Help me

