Return-Path: <linux-kernel+bounces-819075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE61B59AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4D41BC0A60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE1434A327;
	Tue, 16 Sep 2025 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3jMv2cp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2B30BF58
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034330; cv=none; b=GX6iGEl9AH6mNXYjd2MTWz6Np6I0hGk7xhr4mLMLiVtkb2G/NNlwc5IArrWCEBXM0qJGD8/Vqx1dTsSf41xdK+qaqdUJlmrt5B8Fbanb3JHIu8bknmWRqzbh4Y8xnYT5uVBzM1GF39kqoUNYbCPx3mP5Tanvm/VhnUSmJV4pZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034330; c=relaxed/simple;
	bh=i8NtzmKVeK0CBqBApTYTm3iAf9ez5i62j0SbReGfb7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y/PGBhHBHBrf6iUA2dt1C+HnYJ9B55p4wPb66JoNdabeMdKpgZXAnEN0jn08yNQ4+sUGA3RLSmD61Mh9wAO9L2nxt0PUbgWgHTs3fwA24FVprpMJrZ2J4A+jKCdAiVDDLnadsqdB73hCR/8ciuXgJokXS1G19/fiR8TZ4sevxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3jMv2cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED19CC4CEEB;
	Tue, 16 Sep 2025 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758034330;
	bh=i8NtzmKVeK0CBqBApTYTm3iAf9ez5i62j0SbReGfb7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=t3jMv2cpq05jLr5mya8gnqY0LdWfZKH172NqGWZsUQV450OQ7MSecKK/BvQvPsF61
	 +wRfIMDMNu5N52JqAVHgKcJg+2qotenh8Q40u6DpJOiuUnYo86PyubV2WqMSegeBGj
	 /7EIp+/ORtdmETQpkePK3TluVJdEAbAnGdEnNUEoujU0XWKotd4E5E3BzaT5jVeLRq
	 q6m3409DAFi74aePUAzsstLsPnsK+X1OW8V6f3ZUuR0xqUr7IONdQTxe9jWgDC7QYY
	 i4xftMwQ9c57QB47kUCFlPqzeB9DyhXXjJvbEhIrpy8e9Z0pEWN0Zw4oGK9g15NxcR
	 PlII1l1WkPEiA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pratyush Yadav
 <me@yadavpratyush.com>,  Matthew Wilcox <willy@infradead.org>,  Alexander
 Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu
 <changyuanl@google.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Chris Li <chrisl@kernel.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <20250916132759.GC1086830@nvidia.com>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMGc-ExhkqwAyY_C@casper.infradead.org>
	<mafs08qimjoez.fsf@yadavpratyush.com> <20250910155546.GB922064@nvidia.com>
	<mafs0zfauh6to.fsf@kernel.org> <20250916132759.GC1086830@nvidia.com>
Date: Tue, 16 Sep 2025 16:52:06 +0200
Message-ID: <mafs0ldmeh2ll.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 16 2025, Jason Gunthorpe wrote:

> On Tue, Sep 16, 2025 at 03:20:51PM +0200, Pratyush Yadav wrote:
>> >> >> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>> >> >>  struct folio *kho_restore_folio(phys_addr_t phys)
>> >> >>  {
>> >> >>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>> >> >> -	unsigned long order;
>> >> >> +	union kho_page_info info;
>> >> >>  
>> >> >>  	if (!page)
>> >> >>  		return NULL;
>> >> >>  
>> >> >> -	order = page->private;
>> >> >> -	if (order > MAX_PAGE_ORDER)
>> >> >> +	info.page_private = page->private;
>> >> >> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>> >
>> > All the impossible checks shoudl be WARN_ON()
>> 
>> The mental model I have is that the place that introduced the
>> "impossible" situation should get the WARN(). So for an incorrect phys
>> address (leading to magic mismatch) or incorrect order (say preserved
>> big range using kho_preserve_phys() and restoring it using
>> kho_restore_folio()), the caller is responsible so it should do the
>> WARN(). Does that make sense?
>
> Callers should not pass illegal phys here, WARN at this point is
> appropriate, and maybe under a debug #ifdef or something like that.
>
> This is to make it clear that "test and fail" is not an acceptable way
> to use this API.

Okay, makes sense. Will add.

>
>> Actually, on another look, this patch implicitly makes sure that
>> unaligned phys always fails. This is because deserialize_bitmap() only
>> sets the magic on the head page which is always aligned by the order.
>> For any unaligned phys, the magic will not match.
>
> Makes sense, maybe a comment?

Will do.

>
>> Makes sense. Do you suggest the magic and order checks to also be under
>> KHO_DEBUG, or should they always be done? I am of the opinion that it
>> makes sense to do them always, but I can also understand the argument
>> for disabling them in production for better performance.
>
> I'm ambivalent :)
>
> For now I'd do it always and leave some debug optimization to a future
> project.

Sounds good. Will add them as always for now.

-- 
Regards,
Pratyush Yadav

