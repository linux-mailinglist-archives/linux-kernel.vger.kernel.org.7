Return-Path: <linux-kernel+bounces-747605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF6B135DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9D18984CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC9224B04;
	Mon, 28 Jul 2025 07:51:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9806E221FB1;
	Mon, 28 Jul 2025 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689108; cv=none; b=Ty5DQxHzokyH2pBgGeLCkd3jkj/pAiiQen3faxJzAtnK47Fy975IHQ5NtDU6NPxQWeCGP+x61Y++yedBThkGu2SiZGFyZFgpLbGYa/EdwlRvzBO+DqCMih9X0QdEBtxCAsh9VM6nMXQSk3p4BjfCwvJ4KBW6tcL65aaAsABaGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689108; c=relaxed/simple;
	bh=PSzDE4EnANpUmLdbzSCZd+h/R7uE6ijqTpScKyAcGEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUq7N9gur4gQgSCNNwWzmR+F+EQqyfriU399d01B26a9ssUqypDT/84qHddeRw1nmBnpeaqsIHE8EG0lgE7Cizij240b7Lna5C0c/sxFLdE5jKhrW1rcX22XGv1fI6PtyLSzyC9FKL82/tSeMzf/6e5ypUocevyDW2md/7s8nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCD171596;
	Mon, 28 Jul 2025 00:51:36 -0700 (PDT)
Received: from [10.57.53.40] (unknown [10.57.53.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D869F3F673;
	Mon, 28 Jul 2025 00:51:40 -0700 (PDT)
Message-ID: <d0ffb55b-690a-4a65-98b5-b83adebfd88b@arm.com>
Date: Mon, 28 Jul 2025 08:51:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/19] gpu: nova-core: register: minor grammar and
 spelling fixes
To: Alexandre Courbot <acourbot@nvidia.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Beata Michalska <beata.michalska@arm.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Nouveau <nouveau-bounces@lists.freedesktop.org>
References: <20250718-nova-regs-v2-0-7b6a762aa1cd@nvidia.com>
 <20250718-nova-regs-v2-1-7b6a762aa1cd@nvidia.com>
 <B1AA6359-7854-4284-B533-F5CA3C18AF34@collabora.com>
 <DBNF8SZWLI79.1NRX9AMW5QW45@nvidia.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <DBNF8SZWLI79.1NRX9AMW5QW45@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/07/2025 05:59, Alexandre Courbot wrote:
> Hi Daniel, thanks for the review!
> 
> On Sat Jul 26, 2025 at 1:14 AM JST, Daniel Almeida wrote:
>> Hi Alex. Thank you and John for working on this in general. It will be useful
>> for the whole ecosystem! :) 
>>
>>> On 18 Jul 2025, at 04:26, Alexandre Courbot <acourbot@nvidia.com> wrote:
>>>
>>> From: John Hubbard <jhubbard@nvidia.com>
>>>
>>> There is only one top-level macro in this file at the moment, but the
>>> "macros.rs" file name allows for more. Change the wording so that it
>>> will remain valid even if additional macros are added to the file.
>>>
>>> Fix a couple of spelling errors and grammatical errors, and break up a
>>> run-on sentence, for clarity.
>>>
>>> Cc: Alexandre Courbot <acourbot@nvidia.com>
>>> Cc: Danilo Krummrich <dakr@kernel.org>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>> drivers/gpu/nova-core/regs/macros.rs | 14 +++++++-------
>>> 1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/regs/macros.rs b/drivers/gpu/nova-core/regs/macros.rs
>>> index cdf668073480ed703c89ffa8628f5c9de6494687..864d1e83bed2979f5661e038f4c9fd87d33f69a7 100644
>>> --- a/drivers/gpu/nova-core/regs/macros.rs
>>> +++ b/drivers/gpu/nova-core/regs/macros.rs
>>> @@ -1,17 +1,17 @@
>>> // SPDX-License-Identifier: GPL-2.0
>>>
>>> -//! Macro to define register layout and accessors.
>>> +//! `register!` macro to define register layout and accessors.
>>
>> I would have kept this line as-is. Users will most likely know the name of the
>> macro already. At this point, they will be looking for what it does, so
>> mentioning "register" here is a bit redundant IMHO.
>>
>>> //!
>>> //! A single register typically includes several fields, which are accessed through a combination
>>> //! of bit-shift and mask operations that introduce a class of potential mistakes, notably because
>>> //! not all possible field values are necessarily valid.
>>> //!
>>> -//! The macro in this module allow to define, using an intruitive and readable syntax, a dedicated
>>> -//! type for each register with its own field accessors that can return an error is a field's value
>>> -//! is invalid.
>>> +//! The `register!` macro in this module provides an intuitive and readable syntax for defining a
>>> +//! dedicated type for each register. Each such type comes with its own field accessors that can
>>> +//! return an error if a field's value is invalid.
>>>
>>> -/// Defines a dedicated type for a register with an absolute offset, alongside with getter and
>>> -/// setter methods for its fields and methods to read and write it from an `Io` region.
>>> +/// Defines a dedicated type for a register with an absolute offset, including getter and setter
>>> +/// methods for its fields and methods to read and write it from an `Io` region.
>>
>> +cc Steven Price,
>>
>> Sorry for hijacking this patch, but I think that we should be more flexible and
>> allow for non-literal offsets in the macro.
>>
>> In Tyr, for example, some of the offsets need to be computed at runtime, i.e.:
>>
>> +pub(crate) struct AsRegister(usize);
>> +
>> +impl AsRegister {
>> +    fn new(as_nr: usize, offset: usize) -> Result<Self> {
>> +        if as_nr >= 32 {
>> +            Err(EINVAL)
>> +        } else {
>> +            Ok(AsRegister(mmu_as(as_nr) + offset))
>> +        }
>> +    }
>>
>> Or:
>>
>> +pub(crate) struct Doorbell(usize);
>> +
>> +impl Doorbell {
>> +    pub(crate) fn new(doorbell_id: usize) -> Self {
>> +        Doorbell(0x80000 + (doorbell_id * 0x10000))
>> +    }
>>
>> I don't think this will work with the current macro, JFYI.
> 
> IIUC from the comments on the next patches, your need is covered with
> the relative and array registers definitions, is that correct?

My Rust is somewhat shaky, but I believe "non-contiguous register 
arrays" will do what we want. Although I'll admit it would be neater for 
the likes of the AS registers if there was a way to define a "block" of 
registers and then use an array of blocks. Something vaguely like this 
(excuse the poor Rust):

register_block!(MMU_AS_CONTROL @ 0x2400[16 ; 64], "MMU Address Space registers" {
	register!(TRANSTAB @ 0x0000, "Translation table base address" {
		31:0	base as u32;
	});
	register!(MEMATTR @ 0x0008, "Memory attributes" {
		7:0	attr0 as u8;
		7:0	attr1 as u8;
		// ...
	});
	// More registers
});

In particular that would allow a try_() call to access the 'block' 
followed by normal read()/write() calls for the members in the block.

My Rust is certainly not good enough for me to try prototyping this
yet though!

Thanks,
Steve


