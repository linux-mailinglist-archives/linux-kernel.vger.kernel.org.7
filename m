Return-Path: <linux-kernel+bounces-881033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2ABC2740D
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 01:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C383C3BBEFA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F947F4A;
	Sat,  1 Nov 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/GT2GTJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884461B7F4
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955732; cv=none; b=jD4SuvtFalixEr71D6zHJEkDS976b8LOuBcNWjI/vk+QC81ho3Io0J2w1oCvQ0SA0LzvCq0iplakvybss9+bNj2jv15ih5txog5V9Y8Z6l8AYtdRS9mX4LcE4UtsQsaVYDSDFEkDelQ0sYDCHKQZ6EQQyxAIMCxWGm2H6PZZ4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955732; c=relaxed/simple;
	bh=gMO6yCCzVGtoonPwgki9tGmJDQ++26GAnyf7kETHpJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jotOddAok5DS0/lHwBw/SBFTY8u4dCeIYWPO/pit680JOVIhpt7aHU8b4WKZ+kRYSNmkm/yyP5VG+CM+vAz57lr6IcOY9GFLzTt5Do4rjfDKVj4L7LzNifl6eD1f1gtG3u4DGSSWG2kA3zBHcBzAuuHNzMNOonYFA2bIwlCNVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/GT2GTJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4f323cf89bso647520666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761955729; x=1762560529; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqXAJAEFd904kI53cyI6EmfD14ywqnwjSyxvJFGdSTo=;
        b=I/GT2GTJnyFP+sonw2c+7qcr87l0Z1c/Fw1rVpmnONaDoh/5EdI9pmDlDAKOfZZV2f
         N96NHv94e+Rvn6PxBsfgIwDKrlRUpWGEB533sECvANRPgczyIvAckJavIoQsOf0W3sYg
         fmpocS0SqlV83PLyhKaJ5HKyrRMlIu9+1Ct2PdTQElKis32dJtN3VTainI8/FVCqKYt+
         FxMGObFPAI82o7pC2ouDkA5wO659s6YkrSNTMvbG4ilY07/lEvhH0e+ITcQjiSEqOLR2
         J4pruLDD95umSo9J9/zKPmzcrC+BCy4YdoQ1aRJbRywJgVQKMFWfz+in5qSFggVp66AD
         A9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955729; x=1762560529;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqXAJAEFd904kI53cyI6EmfD14ywqnwjSyxvJFGdSTo=;
        b=pZC9pyy7JSzFFNPxvnly9CKWj1bvJNe4sbGacO4cc8e9tvElswgOe8mQuW/j1BsekU
         Z7m1w+5LnWe9GNd2v2sEy7fLsZyBi/nNjX41i8UGRTxL/m03a1w8qFF8Msf61OBhKAfh
         2NIZJ8bcX0R8BtceiAgGG+k2+WM3fOvOsFAvz7KLD1rcZXEXj/f4RFze23CYNiXdCxoF
         rV5Hc+/qhso5MVxy3nmKvwhjGg98e7cTdmIKNQNKiqxzdJJK6F7252pm0wuKcVUuHnhG
         rfM0BBMeMCjFyhB6eAhh2LAzq3gYB+aEr+VGKBsQQvqprJB/4yT2VYXlF+8i+hwHOOY1
         YvWg==
X-Forwarded-Encrypted: i=1; AJvYcCXQP2fwK3t7OsFkzdo4zFvMD/MxRZCmt4IHdjzhOSijqj5FS7mN1AfdM6U99NHCDAvXtDXW1cYryiAms8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVGGoq2z3X+mrIZS8aAVDQ9QaelelGuX3daLN2NCzLPJy2zT7
	dg3WG5TnKMjrw5BY3kCLTE8aIyZOYGgyVxx5hlcRn9m6/QRFd0+ATcu7
X-Gm-Gg: ASbGncvq8+Pcib4ltPCnStVam+5xYrgSuKWo7vqqZGYNgja0WbT+FPHYxkIJ4383lvC
	eoT8DV7PXaDpUyn7DMnEdAonjrMiUh2R0CwG3uNrd+ZkkBuQCbiDaz/6F7AN7X0P/5DI2YozOGr
	FYAJ4I5GcVEPwnRL5o5nL6L/vXigKL+2S0ttU7f9VWXIjh+zD4aOAUS1zWeX6SJXyhwd2rhERYa
	13gV3cV48nlzNSoq7H3NLWMR3pX+tl2aRrR1H6kdJRmmxWvFsNcbPR53o0yQHmLogBogDvwRdEu
	OIh25/HUReSAiEYAZQ0wwURrtGhPOhGX+ysVGHPSLwlwqGRJIID+J5Anrw8kXwcy3zIH/1XsT9z
	X2g/BOwtQGnPf4G2Cxn+e3eec4GGcg3YT1S6Lf4pFrez4sYG06ldBIBCRX7bsLwwdX8SJ4MmrXu
	TQVikqUpfIEw==
X-Google-Smtp-Source: AGHT+IEwMGMxJ1HbzA7e85hEVqx/WAPxKz46lBfAPL00PToE30wxaTZd53z+QG8i0UJAYghIe/jUag==
X-Received: by 2002:a17:907:608d:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b70706271c3mr339730266b.47.1761955728728;
        Fri, 31 Oct 2025 17:08:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077976075sm308313966b.3.2025.10.31.17.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Oct 2025 17:08:48 -0700 (PDT)
Date: Sat, 1 Nov 2025 00:08:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, Wei Yang <richard.weiyang@gmail.com>,
	linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Message-ID: <20251101000847.3ht26lmiug6aznsh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251031162001.670503-1-ziy@nvidia.com>
 <20251031162001.670503-4-ziy@nvidia.com>
 <20251031233610.ftpqyeosb4cedwtp@master>
 <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 31, 2025 at 07:52:28PM -0400, Zi Yan wrote:
>On 31 Oct 2025, at 19:36, Wei Yang wrote:
>
>> On Fri, Oct 31, 2025 at 12:20:01PM -0400, Zi Yan wrote:
>> [...]
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0e24bb7e90d0..ad2fc52651a6 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>> 		ClearPageCompound(&folio->page);
>>> }
>>>
>>> -/*
>>> - * It splits an unmapped @folio to lower order smaller folios in two ways.
>>> +/**
>>> + * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
>>> + * two ways: uniform split or non-uniform split.
>>>  * @folio: the to-be-split folio
>>>  * @new_order: the smallest order of the after split folios (since buddy
>>>  *             allocator like split generates folios with orders from @folio's
>>> @@ -3589,22 +3590,22 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>  *    uniform_split is false.
>>>  *
>>>  * The high level flow for these two methods are:
>>> - * 1. uniform split: a single __split_folio_to_order() is called to split the
>>> - *    @folio into @new_order, then we traverse all the resulting folios one by
>>> - *    one in PFN ascending order and perform stats, unfreeze, adding to list,
>>> - *    and file mapping index operations.
>>> - * 2. non-uniform split: in general, folio_order - @new_order calls to
>>> - *    __split_folio_to_order() are made in a for loop to split the @folio
>>> - *    to one lower order at a time. The resulting small folios are processed
>>> - *    like what is done during the traversal in 1, except the one containing
>>> - *    @page, which is split in next for loop.
>>> + * 1. uniform split: @xas is split with no expectation of failure and a single
>>> + *    __split_folio_to_order() is called to split the @folio into @new_order
>>> + *    along with stats update.
>>> + * 2. non-uniform split: folio_order - @new_order calls to
>>> + *    __split_folio_to_order() are expected to be made in a for loop to split
>>> + *    the @folio to one lower order at a time. The folio containing @page is
>>
>> Hope it is not annoying.
>>
>> The parameter's name is @split_at, maybe we misuse it?
>>
>> s/containing @page/containing @split_at/
>>
>>> + *    split in each iteration. @xas is split into half in each iteration and
>>> + *    can fail. A failed @xas split leaves split folios as is without merging
>>> + *    them back.
>>>  *
>>>  * After splitting, the caller's folio reference will be transferred to the
>>>  * folio containing @page. The caller needs to unlock and/or free after-split
>>
>> The same above.
>>
>> And probably there is another one in above this comment(not shown here).
>
>Hi Andrew,
>
>Do you mind applying this fixup to address Wei's concerns?
>
>Thanks.
>
>From e1894a4e7ac95bdfe333cf5bee567f0ff90ddf5d Mon Sep 17 00:00:00 2001
>From: Zi Yan <ziy@nvidia.com>
>Date: Fri, 31 Oct 2025 19:50:55 -0400
>Subject: [PATCH] mm/huge_memory: kernel-doc fixup
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> mm/huge_memory.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index ad2fc52651a6..a30fee2001b5 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3586,7 +3586,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  *    uniform_split is true.
>  * 2. buddy allocator like (non-uniform) split: the given @folio is split into
>  *    half and one of the half (containing the given page) is split into half
>- *    until the given @page's order becomes @new_order. This is done when
>+ *    until the given @folio's order becomes @new_order. This is done when
>  *    uniform_split is false.
>  *
>  * The high level flow for these two methods are:
>@@ -3595,14 +3595,14 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  *    along with stats update.
>  * 2. non-uniform split: folio_order - @new_order calls to
>  *    __split_folio_to_order() are expected to be made in a for loop to split
>- *    the @folio to one lower order at a time. The folio containing @page is
>- *    split in each iteration. @xas is split into half in each iteration and
>+ *    the @folio to one lower order at a time. The folio containing @split_at
>+ *    is split in each iteration. @xas is split into half in each iteration and
>  *    can fail. A failed @xas split leaves split folios as is without merging
>  *    them back.
>  *
>  * After splitting, the caller's folio reference will be transferred to the
>- * folio containing @page. The caller needs to unlock and/or free after-split
>- * folios if necessary.
>+ * folio containing @split_at. The caller needs to unlock and/or free
>+ * after-split folios if necessary.
>  *
>  * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
>  * split but not to @new_order, the caller needs to check)
>-- 
>2.51.0
>
>

Thanks.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>
>
>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

