Return-Path: <linux-kernel+bounces-818864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC32B59764
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6874F487971
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46CB307AD5;
	Tue, 16 Sep 2025 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7OhipGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11F307AD1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028855; cv=none; b=hSg8qZSb9J1SzmT321RaOp/8K6X74nXeePnrRHtgjdjYIFKzArOpN4MztK6ck3v3l1btUZQh8kaZElmmSJUm2bjFpx9RmkK276576+hkvmDjpp5DVWuY5Z8HfZBIH5S792ABfoF40W0Lk1ChewVSgbniuhn2NpAN4RnA52aa7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028855; c=relaxed/simple;
	bh=NkEqYgbQHqBRppulOAwQLkXQ/kR/tGJDaQ28SAU/ZbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RH1asTtDuLk6BOREDQyVNvoysqQLBK5YDdYapMkA5HEK7y7FQ1AqNb4cyk7CkbCVRo819qD6hcREawxL8t6GB9OgJvw+Xi3gHU1qtXtar2O/CF+EeXeL37tU56SitkgM2P/cvExDmtjq5SZ3pbcHCNha+AgM73+mLLcTv2LC4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7OhipGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E2EC4CEEB;
	Tue, 16 Sep 2025 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758028854;
	bh=NkEqYgbQHqBRppulOAwQLkXQ/kR/tGJDaQ28SAU/ZbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=H7OhipGoDJaVVg75Xy37xy/Gb3iNzhFXsIZqgKxxxy99QyXG14oqvwpdXzjYB6oOB
	 Pz0Ho367YOVHIksobf0Fxb4ZsK60vbtto3ZzcXGgUjpOegEmLGYTKfR6zvX5IjCkd9
	 +tC4O4jsuvaMlEQFuqv+ByjyZyCQFXOWFNhqDza+bRlT125FRjJ7uKyQn5HSMP5DAo
	 b/dhH2ac393YhcPbCsP+ya3oU1SARvXXSUcAJK7L8L68mer45+vP+YZbuNVoJ7X+TZ
	 9f4CvU+15dVkWB1BOrKADvt9Hkr7LyZIVSmneOlNsis/TIKe3K10+EKR11q58Ud2ek
	 e315dV4Chy44w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  Matthew Wilcox
 <willy@infradead.org>,  Pratyush Yadav <pratyush@kernel.org>,  Alexander
 Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,  Changyuan Lyu
 <changyuanl@google.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <bhe@redhat.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Chris Li <chrisl@kernel.org>,  Jason Miu <jasonmiu@google.com>,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
In-Reply-To: <20250910155546.GB922064@nvidia.com>
References: <20250910153443.95049-1-pratyush@kernel.org>
	<aMGc-ExhkqwAyY_C@casper.infradead.org>
	<mafs08qimjoez.fsf@yadavpratyush.com> <20250910155546.GB922064@nvidia.com>
Date: Tue, 16 Sep 2025 15:20:51 +0200
Message-ID: <mafs0zfauh6to.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025, Jason Gunthorpe wrote:

> On Wed, Sep 10, 2025 at 05:52:04PM +0200, Pratyush Yadav wrote:
>> On Wed, Sep 10 2025, Matthew Wilcox wrote:
>> 
>> > On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
>> >> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>> >> +
>> >> +/*
>> >> + * KHO uses page->private, which is an unsigned long, to store page metadata.
>> >> + * Use it to store both the magic and the order.
>> >> + */
>> >> +union kho_page_info {
>> >> +	unsigned long page_private;
>> >> +	struct {
>> >> +		unsigned int order;
>> >> +		unsigned int magic;
>> >> +	};
>> >
>> > KHO is only supported on 64-bit?
>> 
>> Yes. Currently only x86_64 and ARM64. It is mainly for hypervisor live
>> update so there isn't much reason to support it on 32-bit platforms.
>
> Presumably this will eventually change to use some special coding on the memdesc
> pointer?

Maybe. I didn't think that through yet.

>
>> >> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>> >>  struct folio *kho_restore_folio(phys_addr_t phys)
>> >>  {
>> >>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
>> >> -	unsigned long order;
>> >> +	union kho_page_info info;
>> >>  
>> >>  	if (!page)
>> >>  		return NULL;
>> >>  
>> >> -	order = page->private;
>> >> -	if (order > MAX_PAGE_ORDER)
>> >> +	info.page_private = page->private;
>> >> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>
> All the impossible checks shoudl be WARN_ON()

The mental model I have is that the place that introduced the
"impossible" situation should get the WARN(). So for an incorrect phys
address (leading to magic mismatch) or incorrect order (say preserved
big range using kho_preserve_phys() and restoring it using
kho_restore_folio()), the caller is responsible so it should do the
WARN(). Does that make sense?

>
>> >>  		return NULL;
>> >>  
>> >> -	kho_restore_page(page, order);
>> >> +	kho_restore_page(page, info.order);
>> >>  	return page_folio(page);
>> >
>> > This all looks very confused.  Before your patch as well as after it.
>> > I don't see anything in the current KHO code that requires the
>> > phys_addr_t to be order-aligned.
>> 
>> Right, good point. I can send that as a follow up patch. But I think
>> this patch stands on its own without that fix too.

Actually, on another look, this patch implicitly makes sure that
unaligned phys always fails. This is because deserialize_bitmap() only
sets the magic on the head page which is always aligned by the order.
For any unaligned phys, the magic will not match.

Still, would be a good idea to do a KHO_DEBUG check for alignment if
this implicit thing ever changes.

>
> Maybe it is worth adding some KHO_DEBUG kconfig to protect some of
> these extra checks?
>
> phys should be pfn_valid, phys should be aligned, the page should be
> in the right state, order should be valid, etc. All worth checking.

Makes sense. Do you suggest the magic and order checks to also be under
KHO_DEBUG, or should they always be done? I am of the opinion that it
makes sense to do them always, but I can also understand the argument
for disabling them in production for better performance.

-- 
Regards,
Pratyush Yadav

