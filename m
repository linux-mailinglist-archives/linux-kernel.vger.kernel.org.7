Return-Path: <linux-kernel+bounces-849338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52168BCFE1A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 03:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9E3B4E1FE5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3446015CD7E;
	Sun, 12 Oct 2025 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUK2BSZW"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0662249E5
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760232222; cv=none; b=XGHG5dEhT5XlGPJkZS+kdaRemDQLBscoCcH4YN5ELYDb53SGqvjuzO1tYWGRmbr68UrfNZ2Kn6BKtqZZQSTZrUJUqjJgmrYgp0yJLEUGUn3uC0nop7TFUTyekNENpvCz2VRroZIEQ/7W0m2fk854mL6a2D8+6RaVqhdiHJm+jTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760232222; c=relaxed/simple;
	bh=MD94H4RcdYRMTqwGsiu6utu1+4vXMCNygaD4pQnT7O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxUx1Vccm6IMed71TQe3pLBWYIxEAbJ75h98LYlDD1KQ57y6DnXtjKb1ci8yBIsEKuJvQQtbYeVNsUqw4CgPUDRRolYz0dTr37UEty+7+O1lZuBdHYnVG6rXCFt7BebeU0jbkdaPas101pnP4m991ncfyF0pq3GNOy/2YnLB/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUK2BSZW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b472842981fso399023466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760232219; x=1760837019; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9pUt0AntXuvLlR5iztP7t7IKQSEW9xSg2klSL9Fwb0=;
        b=PUK2BSZWINzTPy3ZCELi8i/bZzlta0jb73nLjwc/Vqxmaje0Cv2/syoNdeGxGFLx7O
         AI2uveFOK+Q94s3IUQ8tlbaXMdc1kT/HVc+tvR0yHigSDEF2eRdtfWJZTmR73zkJrSw2
         a9dcdeCbnHMY+xUFrj+gsiaWwLIJ8dBiSrcBUBvph/eZaM/zIFU2cZZva3tnhJjkvZ4q
         qaBqR6pzIQEW70AZ+Hc0K0o8s0JgQYCC9q/P2p5YKrbJtMrj+/7zBD1554x5HgPFDZ03
         /LKpWQRJrRfBizW4gFQut+iA5vBWg9ByQJdqXmfOBtj7N5Z5H4tjxl7JPlux9LtUwspv
         UZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760232219; x=1760837019;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9pUt0AntXuvLlR5iztP7t7IKQSEW9xSg2klSL9Fwb0=;
        b=E1Mdme32BUyLZJDrasDdwu327cE2cNvt0gRu8z8hd5TtfoawJsfbn/Z8z0pRAd2l3R
         XlbIqUKq21mE2lRg8pyyUx6rFrRy7h5DRkUDn+49GvJMJZnSFcrIVo9TcQ1ck2tdgpFg
         YHhZ69W6dAtFBE7XydU+IliRNg2CtMADwLEiCQBQ/fk992Bj6NAH/Ti16s23pXZ7sz5y
         VGoHxK5+edYtQwMS2Bfr83QZBs178ItUicF1H8iGj/K9OSGjDNqAD3pVPbKeSOKgjnii
         8qcXTBpVEUQJX9CcUtclcSHKkaEQ/NwMUu7zms9d2ZxKHv6pA4ilU1HSt38OL3g918CB
         pu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEbSvKii1oeT+0xLu4Ft3t5SM+7qXGwTppwkfhIaBvyEcvfAygRDRecztn3/eIn+CbSwz47emtiHVMfkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSh2d8Jb3z4tP3B2ptR0QR61dGUMd72ht/Rni/Lkv9LSSg53W
	r5jMC0rqwkkgbjOO92PozGD7h4oeuwSyFMyznkyx3iv2nIhhfVqjwsnN
X-Gm-Gg: ASbGnctC2mq9Y+0zYkpZSyxK2hF9Hy5ep7D7uZ37JLF981RxdfJInKv2F0X3gjdamgj
	Nd+o5dChZkuSOKCgY1xgOtSRDQxAdBvfXhJsD1zb89Uu4eZXVRPOBS5/GXYEy8SCQYoyJTwEwwn
	3XSp7IEv9BNpWQ/gLGgJyMm7HyRi+IiE4/OtR5NX/2H7Ckv6BmOBnzL7uvSSNMOXJj0RmqOA5bX
	f5O8nDa4PPj121wSl0VJyN0W1fILytQ5tBy/0fSeyMVqDR1prZxA2yqnoxzKS30Q66Ly+G8yM03
	Esg9p9ekAWJn5nMQqoNkbAjtdRjqHi5zPBJ2MWplAMPT8kGVC3A+Sj0wFf0L9qqUIseOqTelF7P
	MsEnU96xS9NjQzS9qK7PHfpeeybXJ53PbY7us4oxg3XfNiWoUlKc=
X-Google-Smtp-Source: AGHT+IF71vBBTgT683rCNca8U2cQqwxYPV3YtliFuu+HnIfiaWNkbjXN5AsySJ/bIvljzSu4EpvYpA==
X-Received: by 2002:a17:907:d01:b0:b07:c5b1:b129 with SMTP id a640c23a62f3a-b50aa69e3d1mr1631820166b.1.1760232219099;
        Sat, 11 Oct 2025 18:23:39 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12ce1sm602637966b.57.2025.10.11.18.23.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Oct 2025 18:23:38 -0700 (PDT)
Date: Sun, 12 Oct 2025 01:23:38 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	linmiaohe@huawei.com, tony.luck@intel.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, nao.horiguchi@gmail.com, farrah.chen@intel.com,
	jiaqiyan@google.com, lance.yang@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: prevent poison consumption when splitting THP
Message-ID: <20251012012338.p5z2oyyymjxa4wni@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <20251011075520.320862-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011075520.320862-1-qiuxu.zhuo@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sat, Oct 11, 2025 at 03:55:19PM +0800, Qiuxu Zhuo wrote:
[...]
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 9c38a95e9f09..2bf5178cca96 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -4121,6 +4121,9 @@ static bool thp_underused(struct folio *folio)
> 	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
> 		return false;
> 
>+	if (folio_contain_hwpoisoned_page(folio))
>+		return false;
>+
> 	for (i = 0; i < folio_nr_pages(folio); i++) {
> 		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
> 		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
>diff --git a/mm/migrate.c b/mm/migrate.c
>index 9e5ef39ce73a..393fc2ffc96e 100644
>--- a/mm/migrate.c
>+++ b/mm/migrate.c
>@@ -305,8 +305,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
> 	pte_t newpte;
> 	void *addr;
> 
>-	if (PageCompound(page))
>+	if (PageCompound(page) || PageHWPoison(page))
> 		return false;
>+
> 	VM_BUG_ON_PAGE(!PageAnon(page), page);
> 	VM_BUG_ON_PAGE(!PageLocked(page), page);
> 	VM_BUG_ON_PAGE(pte_present(ptep_get(pvmw->pte)), page);
>

The code change LGTM.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
>-- 
>2.43.0
>

-- 
Wei Yang
Help you, Help me

