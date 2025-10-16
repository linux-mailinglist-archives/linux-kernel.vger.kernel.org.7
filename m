Return-Path: <linux-kernel+bounces-855671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4FDBE1EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5595E4E193A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B22BDC34;
	Thu, 16 Oct 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/TXmvHl"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B73254B0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599919; cv=none; b=Izwgkc2+GG9G+bT2s0NIZGr640R0waWIU6UKtpSD/e51GD7MOj92wROo3pAhm1xgwSqA2dSpf9QBqi4QOBpn8VAgAp6Wttc40wpUN34kOa0hpHnnbkIK5aJSTeONtuV8cr/84ZlSKKsc6k4bp4AcHFIW3W0WirVKTj1FAtsxZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599919; c=relaxed/simple;
	bh=eXCiVbfhWWOPw55ze49wbU4Qf4wwaauDC1uUrWrXGSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO+LhZ9u8XVlgrWVD7H3Y61GltYglwWDQbfFDqJj7c6DTxNJMxEsEBUdQgOSoQ5jgfpamv0DLumDv7goS/GdBxXI0TKI3B96pqqrzJWeASIOJQRozp1V01m4xGLdcYWuSLRUjzoQasUmr93sknnluuk4NEmw5eBD/wwmgVw19qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/TXmvHl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b456d2dc440so57058366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760599916; x=1761204716; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/xCn9ZLnPU5SjhfsEFXQQU1A2rrcxC3wMAyKVdAXkk=;
        b=S/TXmvHl+cxelpVMl/eNhFFU6mUXhRPmkXtTslWz3nroW7BAWE97L64LSgWLgPhT7a
         yPDRmZzzweMKIsS08Gg7yTivlv9sm4AwG2J9uMsPMSoTKVMp3M+BhwFaJtqnLRXtdnIG
         uIW1MlAWiEp5CtXdKruTIsCGSN70i5E4ELH/9wNTtzekFhNR1kff3eB9iuWUy/EjLb4w
         Tchg22Gd9OxN8+K9kBuAaLxMeCRoLpbYxMy+f0jSLvBcECtbuGrG8/imsPB7wWqEn1eT
         +2KMy2ZfP5KPrYwZt0lJGkNDHFyZVICDBTkr6173CqPJZFaG0QczWCsOv/ybHOwdYMrP
         ZNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760599916; x=1761204716;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/xCn9ZLnPU5SjhfsEFXQQU1A2rrcxC3wMAyKVdAXkk=;
        b=upx4DriQSIqBdiS6iYNNQwtLc0SPvjukwW83HjJnO8i0J1CFQMnD0GMykysJrblwFX
         RAbXWnanI7cR6Tu0YAUkiHRoRuyEWm2izA+gcq2l/AQK6oQxcX7LPYh8MQWfutLtA/m7
         IZHp2Ss8vprFnHVdqpTT0pUZiJI+5v/DT9yJnBJTQ9NAYah6duo6btHdEcpPPKSyFYFt
         BM9Ewx+kIHgfDas2ns6W2ift8VFYOa/wCpglx64H0ECx2oJ1bU71QQMqEUIZ2lhVwL6g
         5XRM80dc3zCkXVdM1IiKudj+BRR6/8j2wz22m8jXt8KpdsELni+AdryF1Qt018rR2tw1
         SRuw==
X-Forwarded-Encrypted: i=1; AJvYcCVWbgZAGKZf1oLyIPrL7Wrk1MaxAzigXJ1yyeVPw9YpHRNPBIlqxojHh1SHPjgwPyR4Vc5kjW+G05QDymo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPEibFBcOYQZbJJL7Q2qmguQ+qW+BUVgE4Bt74N/ecvM8nEuk
	naWvN2jztQTujBS+Iikd+xZN9bTnl+VgA6m3Z442clzcpGfxfuMTcn2l
X-Gm-Gg: ASbGnctozEFlrVmYkynbu9V/fq2dbzJi5PDdg1+zEpNtWtdeimo4UwSAeWxlvViPxvv
	xN0XW27j6zp4EXF6CMzxfPwCkwypcccZXOrqv13C6y/YkYZpEIC7juPsxKSGy5virsasWq8zFNP
	xV/m4j+AdrWUclIw3FEiyBdQaQAE1zRPYHkMiJ/2A2t29+PsN18sOa4W9Zoli1dYugZD6JnXJdl
	/nd7smWiEVtOWsJutRnHftkmNvvua0S1n5N0XfSUIcmr8/Czy76sBjAkgMxaE3l7zZ0Efu/WXUC
	A5rQlEZThGe+WVBA5kn0ysk9E6PnzEsKHbEwNUd/K3SvHIX8pqo9osmnkqIt6AvhVG6v4PnlKRD
	UjOshj4ds5sS1m8vYjHgOkCPC7W2VYpsC7DOewYtQXc10UWm399xHPze/xYOvOy6whXqFBZZk4A
	abZtK2EuHiZA==
X-Google-Smtp-Source: AGHT+IGUvAIwpaxHWzzdwac13S1QOSDuohR/UN6k77FdmvL5uVxRJPPLfJW0okmo/Fz60mD03IKWVA==
X-Received: by 2002:a17:907:9617:b0:b3f:f207:b754 with SMTP id a640c23a62f3a-b50abaaf85emr3444754566b.30.1760599915853;
        Thu, 16 Oct 2025 00:31:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb5132sm439674966b.54.2025.10.16.00.31.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 00:31:55 -0700 (PDT)
Date: Thu, 16 Oct 2025 07:31:54 +0000
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
	Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <20251016073154.6vfydmo6lnvgyuzz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016033452.125479-2-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 15, 2025 at 11:34:50PM -0400, Zi Yan wrote:
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
>Rename try_folio_split() to try_folio_split_to_order() to reflect the added
>new_order parameter. Remove its unused list parameter.
>
>Fixes: e220917fa507 ("mm: split a folio in minimum folio order chunks")
>[The test poisons LBS folios, which cannot be split to order-0 folios, and
>also tries to poison all memory. The non split LBS folios take more memory
>than the test anticipated, leading to OOM. The patch fixed the kernel
>warning and the test needs some change to avoid OOM.]
>Reported-by: syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com
>Closes: https://lore.kernel.org/all/68d2c943.a70a0220.1b52b.02b3.GAE@google.com/
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

Do we want to cc stable?

>---
> include/linux/huge_mm.h | 55 +++++++++++++++++------------------------
> mm/huge_memory.c        |  9 +------
> mm/truncate.c           |  6 +++--
> 3 files changed, 28 insertions(+), 42 deletions(-)
>
>diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>index c4a811958cda..3d9587f40c0b 100644
>--- a/include/linux/huge_mm.h
>+++ b/include/linux/huge_mm.h
>@@ -383,45 +383,30 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
> }
> 
> /*
>- * try_folio_split - try to split a @folio at @page using non uniform split.
>+ * try_folio_split_to_order - try to split a @folio at @page to @new_order using
>+ * non uniform split.
>  * @folio: folio to be split
>- * @page: split to order-0 at the given page
>- * @list: store the after-split folios
>+ * @page: split to @order at the given page

split to @new_order?

>+ * @new_order: the target split order
>  *
>- * Try to split a @folio at @page using non uniform split to order-0, if
>- * non uniform split is not supported, fall back to uniform split.
>+ * Try to split a @folio at @page using non uniform split to @new_order, if
>+ * non uniform split is not supported, fall back to uniform split. After-split
>+ * folios are put back to LRU list. Use min_order_for_split() to get the lower
>+ * bound of @new_order.

We removed min_order_for_split() here right?

>  *
>  * Return: 0: split is successful, otherwise split failed.
>  */
>-static inline int try_folio_split(struct folio *folio, struct page *page,
>-		struct list_head *list)
>+static inline int try_folio_split_to_order(struct folio *folio,
>+		struct page *page, unsigned int new_order)
> {
>-	int ret = min_order_for_split(folio);
>-
>-	if (ret < 0)
>-		return ret;
>-
>-	if (!non_uniform_split_supported(folio, 0, false))
>-		return split_huge_page_to_list_to_order(&folio->page, list,
>-				ret);
>-	return folio_split(folio, ret, page, list);
>+	if (!non_uniform_split_supported(folio, new_order, /* warns= */ false))
>+		return split_huge_page_to_list_to_order(&folio->page, NULL,
>+				new_order);
>+	return folio_split(folio, new_order, page, NULL);
> }

-- 
Wei Yang
Help you, Help me

