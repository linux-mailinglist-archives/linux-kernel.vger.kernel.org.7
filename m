Return-Path: <linux-kernel+bounces-832393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C2B9F3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BF919C5AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDC02FD7D6;
	Thu, 25 Sep 2025 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgSmC1iM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896002EA483
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803231; cv=none; b=RDblSCxDlH5ArhrYTmpQIxn00d1vk+wM4is7D0ZlXBk6RqB8HQ1p+mBt2azFytGfHw1pcsb1ve2UXS8fUTCoMlx/ofYscRpIEqwcMla4LSX9lNgOZIcrIok4nbJUpjw7sC5b2Zu8N/LwKl7TY2bG8ukBOQ/IzDmpbdfTJr9maQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803231; c=relaxed/simple;
	bh=TGWxGUpcHpB3h2qtjo8FUCjA58tEH0rqxhAVZjG2Njs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CZ3XBfyMnqt+oOyXRy0NvaVVHVjrlmyNlonYcDrDjNS/d6aWMCEm3iBbcddz8AFqRbCuNK0BJXTerwE8dPlGuHXB1N1WLILRH0qb90pva/6KdZEJ7ztBHeu/laoYtmhI5kVgqPmNjaNGdGDGbZB+zkzXL1+/SmUI9lnffcM4SLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgSmC1iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC7EC4CEF0;
	Thu, 25 Sep 2025 12:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803231;
	bh=TGWxGUpcHpB3h2qtjo8FUCjA58tEH0rqxhAVZjG2Njs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LgSmC1iMmZkyqek98Zpj5gcQK7t8yjVTTPof1tyA11bQLdEY78iNcCpjGdTONyJLF
	 /KPFfdm5h1o3qH5DVQhdcINnsIx1iovkZHJH5syKKIxx2UmSAZB/k5N47BfWnabakg
	 QxcN32NUMwElacrAn4TvYui9oc4//gAXhQl3il/eIzh1gxx0qVXsRu1JKJjGeVhvM4
	 KGSMrULRtssQDuHOcuzL7s7jWWOru4Si0qZvOWhJSuWY4z2o6XeBc8euWU3aGhlD1G
	 pvk95ACwwE7iwDQgNblwJ1vpBg1fGXSi493citgCfqgFLfupa0mLqMoDOnzGTsA6MS
	 Aadu/bJnhvQwA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jason Miu <jasonmiu@google.com>,  Alexander Graf <graf@amazon.com>,
  Andrew Morton <akpm@linux-foundation.org>,  Baoquan He <bhe@redhat.com>,
  Changyuan Lyu <changyuanl@google.com>,  David Matlack
 <dmatlack@google.com>,  David Rientjes <rientjes@google.com>,  Jason
 Gunthorpe <jgg@nvidia.com>,  Joel Granados <joel.granados@kernel.org>,
  Marcos Paulo de Souza <mpdesouza@suse.com>,  Mario Limonciello
 <mario.limonciello@amd.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Petr Mladek <pmladek@suse.com>,  "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>,  Steven Chen <chenste@linux.microsoft.com>,
  Yan Zhao <yan.y.zhao@intel.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [RFC v1 0/4] Make KHO Stateless
In-Reply-To: <aNUJIsElr5L5uxNv@kernel.org> (Mike Rapoport's message of "Thu,
	25 Sep 2025 12:19:30 +0300")
References: <20250917025019.1585041-1-jasonmiu@google.com>
	<aNUJIsElr5L5uxNv@kernel.org>
Date: Thu, 25 Sep 2025 14:27:06 +0200
Message-ID: <mafs05xd6d8f9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25 2025, Mike Rapoport wrote:

> Hi Jason,
>
> On Tue, Sep 16, 2025 at 07:50:15PM -0700, Jason Miu wrote:
>> This series transitions KHO from an xarray-based metadata tracking
>> system with serialization to using page table like data structures
>> that can be passed directly to the next kernel.
>> 
>> The key motivations for this change are to:
>> - Eliminate the need for data serialization before kexec.
>> - Remove the former KHO state machine by deprecating the finalize
>>   and abort states.
>> - Pass preservation metadata more directly to the next kernel via the FDT.
>
> If we pass the preservation metadata directly between the kernels, it means
> that any change to that data structure will break compatibility between the
> new and old kernels. With serialization this is less severe because a more
> recent kernel can relatively easy have backward compatible deserialization.
>
> I'm all for removing KHO state machine, but that does not necessarily mean
> we must remove the serialization of memory persistence metadata?

I think the tables should be treated as the final serialized data
structure, and should get all the same properties that other KHO
serialization formats have like stable binary format, versioning, etc.

It just so happens that the table format lends itself very well to being
serialized on-the-go. When a page is marked as preserved during normal
operation, it is very simple to just allocate all the intermediate
levels and mark the page as reserved. There is no further processing
needed to "serialize" it -- like we need to do with the bitmaps today.

So I don't really see why we should introduce an intermediate processing
step when it is easy to just directly build the serialized data
structure during normal operation.

>
> For example, we can do the serialization at kernel_kexec() time and if we
> want to avoid memory allocations there we might preallocate pages for
> khoser_mem_chunk's as amount of bitmaps grow.
>
> It also would be interesting to see how much time is saved if we remove the
> serialization.

-- 
Regards,
Pratyush Yadav

