Return-Path: <linux-kernel+bounces-881010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFD2C2732D
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 00:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA9A44E633F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3828732C930;
	Fri, 31 Oct 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkFMuYBt"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24162EDD76
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953775; cv=none; b=irB1W5EpWnDOYAFyIhYpTW9vwPTDqwP2GH3+VvJL+Lgo6qlihKOSSB5Abt48fCZcCBSuBZeac8fb7+BMBYiGIZGryyVLe7r1/iXP/6UXO3WqBYOHGtoZldmwrIhD0g5b7BUj/B2qW41bHTfuxAPjmosIN5RbwmGXpnCD803Qh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953775; c=relaxed/simple;
	bh=5tpVy1uLPjO9L4IvdDbxj0H5zRze4NtqyVZfxvjL6pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7FBNEVaZlGkrlFRPR2b9ri+viCp2KSOtzMjgGoMEB1z1j1gRWRT65yuQ1oEGPHowmM36pyfyULvtidySp5OAHPdrqjruWDHBZ5zCHZoy9M2LQaLoA17Ddx2HJNpfNv93mzFnI3QUWKwRvZ/xEYfS1MH2vma042mOIS6ZiVYZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkFMuYBt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso5059625a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761953772; x=1762558572; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Eq4jvviKUAzs1+1SoozEwcB6MMHVfZDN8rnqvceNns=;
        b=EkFMuYBt5mbk0dg5torxAZZYkFXftu4scvFem/ixbrVeowkwWNGo8zDtYA/0M+EqNh
         GrHYxZfgJvgTy/G+X2XWwsWf8H4xJAkcmzidxstHAB2Q/CqctEVuaY9YST0GODpJGWyl
         BXlEZ/P4odD4yGGAo87logE2ZpExFfeeVo/TTxXW00OK90wj/3gPiBr0gaE/FHd9+8pz
         IT2iWhXQHClWtCZXbvxpIHwEnyjLqT1wT+7v9nSCkREI1FZXtHUN75czDiBZD6cckGO/
         aVUZFFqMSQanNRoH35u7t0wbK6SHO5fRnAJb8/XwE8BfN+mUlmyHYPimnFMT9t/oHh1f
         NBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761953772; x=1762558572;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Eq4jvviKUAzs1+1SoozEwcB6MMHVfZDN8rnqvceNns=;
        b=dQBlSX4ski6n0mJixTm4VOI9hhcrNiZEhwqgehZjWEQ297JcpDfmlqGpO+HjNf3Zh1
         5M0WYyL93OYI/OZdHumfzbnGV5Ss/exDUDrecX4fzzyafP8Tg+8dQtYy7WTrDIwwIlXd
         wHB1KiSB0vPjSdDu3QC0hJ4WQi6PwKtCpPimMCf99liwRa0UzA/DE3K6m4lwfHabjAm/
         z3uIKHzBm8FOBoCJniACTJ3S17zThGB002p+An6eePG61m963dyGqA2O0td+2UxSarJe
         rMNuXx/0uRu60A2HAcVNe51VNT3wN5MGiThQOsn03KCfRzhp65SATcmCTa/Yh2iTgZtN
         BqLA==
X-Forwarded-Encrypted: i=1; AJvYcCVyEMuFCFvo+FNt7q/J4I/HHy5VLK6HhIX0vGL87k7xaHvccG5oSQTToyELcK5T9RF2MX2AocvKrz+ZdMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmDBi2ox7LJNWh76EaPTHYdC8vGX89EZ7eIqmu9QlGLITtrQy
	BzFOkP5bSPB/UbCoLm5VAIwy6JO1X6briuaWVlmEOqAdrdNbOM3rvCGt
X-Gm-Gg: ASbGncu7gfdhxK/odVgFahsAfLLuCuF1SYFadz2OoyZzIAmwNdyrWgZR2p1eoFSa/lo
	DWyJzP3Rdfiior1GAe0L1n01tTtX7vvWmnRwZtK/JxNKbOJvBEVdEJNHqBDzaA6tBEEW8Nx9E1z
	Bm3PfCni+pGE5OeMfLe7xyO68GonbrBcFtcmJEL9ZbxyenoLtjCZ/8vSyyYBobsKb4nMGKoeggX
	ZRaSJI3rXWJaTFTKHd2eoBznkXGCqAXiEPzeaTxw4v1XjVGas9JHJ74y3gGViVSWJXiRHurEonT
	sCxmoMeqtxD81ZH7yNctm2C/dNqWUcM1chMfIK2m2BiBCLaEsMphLkInKuWm4kqtLTLOE1YOcH1
	e6A18o6LJj/L9vW2xbqybcP2kjnkzlmkjhL5zELmEVDiXcGW/Kf0CXnYWlPCwiFgYsttwpzwqxe
	hoM5HShAQa8w==
X-Google-Smtp-Source: AGHT+IE9oiA7ZS+LrMufBrhbfjlMC2OP7kCQdowNH5Jt1ngMTD0p89JzaMQE80nXkCPgIOmTZL/sqg==
X-Received: by 2002:a05:6402:510c:b0:63c:334c:fbc8 with SMTP id 4fb4d7f45d1cf-6407701851bmr4563108a12.17.1761953771822;
        Fri, 31 Oct 2025 16:36:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6409012a6a2sm1126819a12.23.2025.10.31.16.36.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Oct 2025 16:36:10 -0700 (PDT)
Date: Fri, 31 Oct 2025 23:36:10 +0000
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
Subject: Re: [PATCH v5 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Message-ID: <20251031233610.ftpqyeosb4cedwtp@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251031162001.670503-1-ziy@nvidia.com>
 <20251031162001.670503-4-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031162001.670503-4-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 31, 2025 at 12:20:01PM -0400, Zi Yan wrote:
[...]
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index 0e24bb7e90d0..ad2fc52651a6 100644
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
>@@ -3589,22 +3590,22 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  *    uniform_split is false.
>  *
>  * The high level flow for these two methods are:
>- * 1. uniform split: a single __split_folio_to_order() is called to split the
>- *    @folio into @new_order, then we traverse all the resulting folios one by
>- *    one in PFN ascending order and perform stats, unfreeze, adding to list,
>- *    and file mapping index operations.
>- * 2. non-uniform split: in general, folio_order - @new_order calls to
>- *    __split_folio_to_order() are made in a for loop to split the @folio
>- *    to one lower order at a time. The resulting small folios are processed
>- *    like what is done during the traversal in 1, except the one containing
>- *    @page, which is split in next for loop.
>+ * 1. uniform split: @xas is split with no expectation of failure and a single
>+ *    __split_folio_to_order() is called to split the @folio into @new_order
>+ *    along with stats update.
>+ * 2. non-uniform split: folio_order - @new_order calls to
>+ *    __split_folio_to_order() are expected to be made in a for loop to split
>+ *    the @folio to one lower order at a time. The folio containing @page is

Hope it is not annoying.

The parameter's name is @split_at, maybe we misuse it?

s/containing @page/containing @split_at/

>+ *    split in each iteration. @xas is split into half in each iteration and
>+ *    can fail. A failed @xas split leaves split folios as is without merging
>+ *    them back.
>  *
>  * After splitting, the caller's folio reference will be transferred to the
>  * folio containing @page. The caller needs to unlock and/or free after-split

The same above.

And probably there is another one in above this comment(not shown here).

>  * folios if necessary.
>  *
>- * For !uniform_split, when -ENOMEM is returned, the original folio might be
>- * split. The caller needs to check the input folio.
>+ * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
>+ * split but not to @new_order, the caller needs to check)
>  */
> static int __split_unmapped_folio(struct folio *folio, int new_order,
> 		struct page *split_at, struct xa_state *xas,

-- 
Wei Yang
Help you, Help me

