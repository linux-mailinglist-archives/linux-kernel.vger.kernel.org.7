Return-Path: <linux-kernel+bounces-845416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CA3BC4C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9284319E200B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50960280334;
	Wed,  8 Oct 2025 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ+MRx7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D728468C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926623; cv=none; b=nE8n2epqPuscAb14CKwwT9L3s9uKgQnzIcE8FD31GmcsLCbgh7jO9RZ4w0qsCKkW+XQguTO9vHLRwVb6sjLxqKJT08fAnu57xofMEA+ZaEZgj47ArpsYXJq7QDDDhiMXhyuQB87D0TVT1gWyWU2xH4FoBRiYCpg+93jc+hsMwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926623; c=relaxed/simple;
	bh=99UtFVSraJXTbEQj4nZPs6lfnYTFkqMP7nINYiynHic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y72jLa6j5H4X7sPy2xrKzbz+bgNelsMgGRKjN8KT1zd+BiVWOldZDW8BfolokLT2SGwut+ReQM+xpmnFPNsq4MrwhEhBpa3qDK8IJRHinxa56Ydiy9TIjOKgFqI73X/hv8UXxV6m7z6yxeSseSkA0VWVOajSXS++0EJLwIwtLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ+MRx7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA6C116B1;
	Wed,  8 Oct 2025 12:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759926623;
	bh=99UtFVSraJXTbEQj4nZPs6lfnYTFkqMP7nINYiynHic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mJ+MRx7NyfUJIIbAlwWI8IHTlq14/GShbflZBSlEJrGfgI3C+JGoj8a5KU6O0oPGU
	 I1fOTUvmT0Jj++wu0ntmp+T06T+VsjnaOEEwNESZ1YzZ68hJnXuOa1itRLpHNqP/TL
	 L3D//epe0M7hB4M/h8K5QCf5TdXZ88f3O60/d1hJBHQgpYXIRr3pQ0t6uwi4c4ejXy
	 fEMjlnmLji1c6ReRa9kty3sIOQf0HmHDvP6luF7G+39MR2Mjh3855aZwTSWiCIWcqD
	 EAE8knbjOEPBn3Uy1l2qadno145TBcncp829MB/Dz9M18YswlSSPVkdEdXwLaxuRVM
	 OP/o2HLYQOv8A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev> (Sean Anderson's
	message of "Tue, 7 Oct 2025 10:20:01 -0400")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
	<mafs0ecreontu.fsf@kernel.org>
	<4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
Date: Wed, 08 Oct 2025 14:30:20 +0200
Message-ID: <mafs05xcpo9sz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 07 2025, Sean Anderson wrote:

> On 10/7/25 09:15, Pratyush Yadav wrote:
>> On Mon, Oct 06 2025, Sean Anderson wrote:
>> 
>>> The datasheet for n25q00a shows that the status register has the same
>>> layout as for n25q00, so use the same flags to enable locking support.
>>> These flags should have been added back in commit 150ccc181588 ("mtd:
>>> spi-nor: Enable locking for n25q128a11"), but they were removed by the
>>> maintainer...
>> 
>> This makes it sound like the maintainer did something wrong, which is
>> not true. Tudor had a good reason for removing them.
>
> I disagree. The maintainer used his position of authority to make the
> submitter second-guess their correct patch.

Sean, you are being very combative over such a small issue. You must
test your changes. This is one of the most basic principles in software
engineering. It was perfectly reasonable from Tudor to push back on
untested changes.

There is no abuse of "position of authority" here. When things break, we
get to do the work of putting the pieces back together. So of course, we
are reluctant to take things that increase this burden for us. Having
contributors test their changes is the simplest of things we ask for to
keep the quality bar.

Beyond that, I'd say that a little politeness goes a long way in life.
Especially towards the people maintaining the software for free that you
(or your employer) use. We are both wasting our energy on this debate.
Please stop. Take a step back and think from the other side's
perspective. And try to work _with_ people, not against them.

>
> These flashes have capacity of greater than the 8 MiB that can be
> protected using 3 BP bits. Micron (and ST before them?) addressed this
> by adding a fourth BP bit. This is consistent across every flash in this
> series, and is clearly documented in every datasheet. Defaulting to 3
> bits is buggy behavior: we should assume flashes behave per their
> datasheets until proven otherwise, especially for less-popular features

If I had a euro every time I found a bug in a datasheet, well, I would
have enough money to at least buy a nice dinner. My point is, datasheets
are not perfect. Only running on real hardware gets you the true
picture.

> that the original submitter may not have tested.
>
> The original patch was entirely correct, and the maintainer's
> justification for removing the second hunk is flawed.
>
>> Jungseung did not
>> have the flash at hand and Tudor didn't want to apply patches that
>> weren't tested. Both were in agreement for removing the n25q00a changes.
>> 
>> If you are going to mention that commit, then mention the full context,
>> and then also mention what has changed since that makes it possible to
>> add those changes back in. Having tested them on the real hardware for
>> example.
>> 
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>> Tested with a mt25qu01gbbb, which shares the same flash ID.
>> 
>> Ughh, is this another case of flash ID reuse? Do mt25qu and n25q00a
>> flashes behave exactly the same and only have two names? If not, then
>> how do you know if n25q00a will also work with these changes?
>
> I examined the datasheet for the n25q00a and determined that it has the
> same status register layout.

Can you share the links to the datasheets?

Also, test logs would be nice to have.

>
> In fact, every n25q and mt25q flash has the same status register layout,
> which (as noted above) is necessary to support capacities greater than 8
> MiB (and all flashes in this series have such capacity).

Do they behave the same? If not, do you know how they differ? If they
behave differently, we might need to have some code that detects which
one is running. Not necessarily as part of this patch though.

>
> --Sea
>
>>>
>>>  drivers/mtd/spi-nor/micron-st.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>>> index 187239ccd549..17c7d6322508 100644
>>> --- a/drivers/mtd/spi-nor/micron-st.c
>>> +++ b/drivers/mtd/spi-nor/micron-st.c
>>> @@ -486,6 +486,8 @@ static const struct flash_info st_nor_parts[] = {
>>>  		.id = SNOR_ID(0x20, 0xbb, 0x21),
>>>  		.name = "n25q00a",
>>>  		.size = SZ_128M,
>>> +		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP |
>>> +			 SPI_NOR_BP3_SR_BIT6,
>>>  		.no_sfdp_flags = SECT_4K | SPI_NOR_QUAD_READ,
>>>  		.mfr_flags = USE_FSR,
>>>  		.fixups = &n25q00_fixups,
>> 

-- 
Regards,
Pratyush Yadav

