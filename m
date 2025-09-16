Return-Path: <linux-kernel+bounces-818796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A0CB59690
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C702D16BF98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D86B1D7E41;
	Tue, 16 Sep 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG3T6Zf8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8562B2DA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026938; cv=none; b=n+hOMJ+3H0ImT5lCE+aCUOnwEvN2OVjei7QKHcLCNBjTDZQPL0x8UaSklCHZv4+cOriVNuHpzWgeOu0V79NjxmWjUrGinfcjC+20K+OpK34Qd1Q0awHzCOULfLNTPMM4BiRcauVS/8KJNAlfx5KiyA4Ti78V9suwUKZsM1mLii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026938; c=relaxed/simple;
	bh=4YrNCsR+tG6pZaieZYZjT9mkupyBVaPEFfVB53YgEk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JCbsadGR5/8qrKGg/Iuy/nD2Sh6ljk8IanbFLRZOm4UVR5g1fYU81aKB25X/+U6xo4K5T8TB0P7k6AbU+GunlwN50kGKk08PBlGInH88ZCVrpEX2maXsuB5irkTBHZOmd6B8FEVSyzyRfXuxB5zcBG8mRmnBjuUJs/O7kX1dBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG3T6Zf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E8FC4CEFB;
	Tue, 16 Sep 2025 12:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026938;
	bh=4YrNCsR+tG6pZaieZYZjT9mkupyBVaPEFfVB53YgEk8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=vG3T6Zf8eW6m6XVKvRviu1cHQLljMJq5lwAFbzIkX5FUvGZ4IpWXPGB+bfYW8Opw+
	 x+2weGhsEjE6UQyH4e+9ijZMK7z7o79BmY6/6ylGHainjNYeL2+p+ufqOaN9Elhptk
	 a5vP7PNrFKMzSQYZDyzuYtHHJ1sSxIw3JmmEo78UwhABYMMSaUJZKTZ9pX4nEOTLf5
	 gB/PKSYEaJen/ooKrHcipAnXazTz3u27GESDjb8ZV/ByfIFKApWEsXPM0FirrZaNO5
	 dLT0zncbTLr1XqK/ibIDwWC3ARmDV3C6/TR03oFFTVLlRb4KKj5S1yyISWRJELS4pe
	 vbrsWgY0cJB5A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <me@yadavpratyush.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Alexander Graf <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,
  Changyuan Lyu <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,
  Jason Gunthorpe <jgg@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc allocations
In-Reply-To: <aMgey9qEC_XUejXm@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
	<20250908103528.2179934-2-rppt@kernel.org> <mafs0ldmon784.fsf@kernel.org>
	<mafs0ldmnlmq0.fsf@yadavpratyush.com> <aMgey9qEC_XUejXm@kernel.org>
Date: Tue, 16 Sep 2025 14:48:55 +0200
Message-ID: <mafs0bjnaimvc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 15 2025, Mike Rapoport wrote:

> On Tue, Sep 09, 2025 at 04:33:27PM +0200, Pratyush Yadav wrote:
>> Hi Mike,
>> 
>> Couple more thoughts.
>> 
>> On Mon, Sep 08 2025, Pratyush Yadav wrote:
>> > On Mon, Sep 08 2025, Mike Rapoport wrote:
>> >> +
>> >> +	while (chunk) {
>> >> +		struct page *page;
>> >> +
>> >> +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
>> >> +			phys_addr_t phys = chunk->phys[i];
>> >> +
>> >> +			for (int j = 0; j < (1 << order); j++) {
>> >> +				page = phys_to_page(phys);
>> >> +				kho_restore_page(page, 0);
>> >> +				pages[idx++] = page;
>> >
>> > This can buffer-overflow if the previous kernel was buggy and added too
>> > many pages. Perhaps keep check for this?
>> 
>> Thinking about this a bit more, I think this should check that we found
>> _exactly_ chunk->hdr.total_pages pages, and should error out otherwise.
>> If too few are found, pages array will contain bogus data, if too many,
>> buffer overflow.
>
> Sure, I can add the checks, but it feels superfluous to me.

See my reasoning in the other reply:
https://lore.kernel.org/linux-mm/mafs0frcmin3t.fsf@kernel.org/

>  
>> Also, I am not a fan of using kho_restore_page() directly. I think the
>> vmalloc preservation is a layer above core KHO, and it should use the
>> public KHO APIs. It really doesn't need to poke into internal APIs. If
>> any of the public APIs are insufficient, we should add new ones.
>> 
>> I don't suppose I'd insist on it, but something to consider since you
>> are likely going to do another revision anyway.
>
> I think vmalloc is as basic as folio. At some point we probably converge to 
> kho_preserve(void *) that will choose the right internal handler. like
> folio, vmalloc, kmalloc etc.

Sure, but do you need to use the internal APIs? Because doing this way
would miss some improvements for the public APIs. See my patch for
adding more sanity checking to kho_restore_folio() for example:
https://lore.kernel.org/linux-mm/20250910153443.95049-1-pratyush@kernel.org/

vmalloc preservation would miss this improvement since it uses the
internal API, even though it will clearly benefit from it.

-- 
Regards,
Pratyush Yadav

