Return-Path: <linux-kernel+bounces-797983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A88B41804
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E622164D17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73562E717C;
	Wed,  3 Sep 2025 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpRxcYB7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644862DC344
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886924; cv=none; b=uyzxR7f4fJqbcTwDgIUSD9kkfsIcUAN3ee5//TvLE53l/v9a+Eef99q/nJ2+KkeFnawa3Kjh0XwTGZFS4FvDehufVwv1Q7exsgrP0Ip36BxaoeFWjPTYCxI/z18r7GaGViiwaYTHR3jCMA0jqgyF0x4vJsUfCJEAr7N/Cc7t+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886924; c=relaxed/simple;
	bh=OdWGQUzFh4GW+ik/V0sX5hmXTmNxo0EdN1k8s/myvD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOd7CqcQMdiUR/XHmN6vk1WbrTIWfmTyuhb3/W/Hlb7UhWkxC+zdFmpVAkJdbrshdOHyxbEUTXLPogdj04Y8G9A+YSHD2scniiIpRo+nj2zvBPxmF0TJlhxyZHyb7elmKlYIAAQkUqWhVSmdJL4TOimqwUCSVYtEDWE9IY0v+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpRxcYB7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b8b8d45b3so28397845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756886921; x=1757491721; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUJC3Krq7zEXPK+epzbi9xFTpRQGWoixqKJ3ll3WSso=;
        b=VpRxcYB79TfXN0SPJMvlkfygmviuTpSAkf2dvFogU7ykFDJIYPtqZzWk5qIzAMGIGL
         CQXkNRYjcpor1/DLK2ujjsVneo5oSNhMpRbK/o6fcUxgUYxfX5PO0UID6FQC8Esgwx/b
         sSLNplDHYKG1U1TRC/H6uWGZO06HJx4di9uNXBpM3V2hf38u7v2j5q9yDKijpPi3YhZ7
         KZkYoGhOJLf7dmjfV7Lk0QthjorVjMpipyP6Q2rZFzmvIXJeDLVhA1jWiCof+s5y3+GS
         fA9vFgtuet5ha1BbU/uaQOGH1LBq1YyzVJEGg2VmaSN7qRwSnTyBbZjtZaQZK+cezqdi
         6bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756886921; x=1757491721;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aUJC3Krq7zEXPK+epzbi9xFTpRQGWoixqKJ3ll3WSso=;
        b=fFiCHSn3erSpvSVZG7Bhwxpzh01F95OBFMRme5nAEAC9DWhCAs2bfsSbzoq0NJ1KM0
         5gNgVoDG71YhtlNQargxVLCWeE6jCCmTAkZZofw+G0wCUcayDAJUHWxwn09u2yxnENir
         EgAulgjvjJAoubSoxKihpjSaalfc9Ib0xmAu+oiEGyos4uNVcKBYepAGN3FT5meuFkP8
         tBx/FHMKzJsVgZX/9plPAK0tjoP35NG+PrnKHznt9MhQz1ok3AU2WP4v0REWozJbkGpO
         bIjSvQJ2e3HMZHMu/xbhIppFfrU6hG5nw7VAJCklksT7n005zMERIBRgScuU5Wez+pRd
         CP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUZKFog6Y7AguOlJ2n2u2eoeUaKWeRV4gEJxovzzOf27EtktBtLyub85HDF6+VYV0Ob16RkhA1aypZ8s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwA5u3K9K4W9+wq7GN0jAlB/TOPbRHVj6xh2ByckxUs+HM/H5V
	Qt5NbVpnlyOYVX+EPeeSZ6Av3CyRjClIHK83V9Jrso//LeuNJbJwtghs
X-Gm-Gg: ASbGnct7my2s/AjrGWwKD25d/yHH5e/2nDmSYrS2/oEVPoPe3vtosSFaeovmsv3sdkU
	v7erJ6cXx0NN6EWAVf8O2C2t4/hDq5ruSXY473t5nrsa3+T89YDeZUzwClsjk3mipxrNdkylDxo
	aBzr30LN3rycIbPtirfE8ALDs9hLbPMF6FpKeNfydmGbWTWkkRQ5deP5ZnkHiVr54F1USO7kaKO
	A9lX8yg6W++j/wos9T+7MsKBtvhbTBpsylbUnF+El9x2cHZX35v7VBq6GaccE97P4d7zyj1cPaf
	WTTRje6OXTnq73sqx1KTBUgmz6kqd7WlD93Z0eRYfeGA8KjBp9geTGIL04f2mRq0KDRBy2t1b4V
	p0yK50mufgosliqQzHbOdQNC8pQGjB+igoO7E
X-Google-Smtp-Source: AGHT+IEAoZKHZM3kQNHID82SoPVu7/HP6eUC0AqiI51jOtxQMatQKooo7/Z73SID7xfpnH1QOreivw==
X-Received: by 2002:a05:600c:c4ab:b0:45b:47e1:ef6a with SMTP id 5b1f17b1804b1-45b855bec54mr128326785e9.37.1756886920536;
        Wed, 03 Sep 2025 01:08:40 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb61377a7sm13188495e9.13.2025.09.03.01.08.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Sep 2025 01:08:40 -0700 (PDT)
Date: Wed, 3 Sep 2025 08:08:39 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org,
	willy@infradead.org, hughd@google.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
	baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
Message-ID: <20250903080839.wuivg2u7smyuxo5e@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250903054635.19949-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903054635.19949-1-dev.jain@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>Currently khugepaged does not collapse a region which does not have a
>single writable page. This is wasteful since non-writable VMAs mapped by
>the application won't benefit from THP collapse. Therefore, remove this
>restriction and allow khugepaged to collapse a VMA with arbitrary
>protections.
>
>Along with this, currently MADV_COLLAPSE does not perform a collapse on a
>non-writable VMA, and this restriction is nowhere to be found on the
>manpage - the restriction itself sounds wrong to me since the user knows
>the protection of the memory it has mapped, so collapsing read-only
>memory via madvise() should be a choice of the user which shouldn't
>be overriden by the kernel.
>
>On an arm64 machine, an average of 5% improvement is seen on some mmtests
>benchmarks, particularly hackbench, with a maximum improvement of 12%.
>
>Signed-off-by: Dev Jain <dev.jain@arm.com>
>---
[...]
> mm/khugepaged.c | 9 ++-------
> 1 file changed, 2 insertions(+), 7 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 4ec324a4c1fe..a0f1df2a7ae6 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> 			writable = true;
> 	}
> 
>-	if (unlikely(!writable)) {
>-		result = SCAN_PAGE_RO;
>-	} else if (unlikely(cc->is_khugepaged && !referenced)) {

Would this cause more memory usage in system?

For example, one application would fork itself many times. It executable area
is read only, so all of them share one copy in memory.

Now we may collapse the range and create one copy for each process.

Ok, we have max_ptes_shared, while if some ptes are none, could it still do
collapse?

Maybe this is not realistic, just curious.

>+	if (unlikely(cc->is_khugepaged && !referenced)) {
> 		result = SCAN_LACK_REFERENCED_PAGE;
> 	} else {
> 		result = SCAN_SUCCEED;
>@@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> 		     mmu_notifier_test_young(vma->vm_mm, _address)))
> 			referenced++;
> 	}
>-	if (!writable) {
>-		result = SCAN_PAGE_RO;
>-	} else if (cc->is_khugepaged &&
>+	if (cc->is_khugepaged &&
> 		   (!referenced ||
> 		    (unmapped && referenced < HPAGE_PMD_NR / 2))) {
> 		result = SCAN_LACK_REFERENCED_PAGE;
>@@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> 		case SCAN_PMD_NULL:
> 		case SCAN_PTE_NON_PRESENT:
> 		case SCAN_PTE_UFFD_WP:
>-		case SCAN_PAGE_RO:
> 		case SCAN_LACK_REFERENCED_PAGE:
> 		case SCAN_PAGE_NULL:
> 		case SCAN_PAGE_COUNT:
>-- 
>2.30.2
>

-- 
Wei Yang
Help you, Help me

