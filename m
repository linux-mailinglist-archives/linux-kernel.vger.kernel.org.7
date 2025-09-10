Return-Path: <linux-kernel+bounces-810299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0722B51874
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 218A54E35F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF318FC97;
	Wed, 10 Sep 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY4YChQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BB212578;
	Wed, 10 Sep 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512541; cv=none; b=hzFjSMTDyMxvkIuE+04TVT091xthzF/uEnXgV82IUBX3WS9SyZqSs6jUlqXEABQ2H4bCzBH6CWiokX+C58sQi7YaRMbqdfyzlh9KzjmnBk9mISkBWe+dOJQVyH8MSZjqOlOMqvcao0qhREbB1q2ewzPxlOw6PtplXJMHuG/xv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512541; c=relaxed/simple;
	bh=fKZmUByRNoyK1ZNxUgffbXWrOzT/AvuMSgWXfv0ZoUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cyc2Ot9r39B7oTgxIngsgTGdcusfv1LCkUHftROVyH2pDAL3XjlHR9+Mm7FGM4fti21hg1IiksWT6rUf4yBEMa29d8Un9mtLG0RR/yxPbsSc5vSVaKsLvuRFCPdPqrbgE4v4BdWYtDjBZfPG934lntAb6r8XO8W1CkdJPaQRFyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY4YChQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E133C4CEEB;
	Wed, 10 Sep 2025 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757512540;
	bh=fKZmUByRNoyK1ZNxUgffbXWrOzT/AvuMSgWXfv0ZoUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HY4YChQVdIEFogtYJb0dbVWQn4gC17+yUa/FSQuTBNmjLPmU7Sul0bAW21dr9RMNU
	 GDm6+zT9kWK3ZOxObzx+vQYbmU8l4nTYxWd+vJMwcAB/Elko4lt1Xk75SlexPz6X18
	 /Qo/s4UkYZWz2Yfv3Bq76iCwFi6k5F8q6gspQg74AkxRJm5s1NPc11Gv3e5XqG90QF
	 O7o/EkW8YDHxftaxVASkCq7OM4CdwiJZDMqqTEp475m4iHzzcmK6XjLXV15sFMCPPp
	 8dBRi3JW3Nrm73nKTJ4RuDinkL9F9I5SpR9VxMcxh63m+9M4q1VcLOh/IGlyzQPSqq
	 xa4jyaY7GcNHg==
Message-ID: <9e8796e3-c423-418d-98fc-f573ccad672e@kernel.org>
Date: Wed, 10 Sep 2025 15:55:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
 Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com> <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/25 2:19 PM, Benno Lossin wrote:
> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
>> On Wed, Sep 10, 2025 at 12:36 PM Benno Lossin <lossin@kernel.org> wrote:
>>>
>>> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
>>>> On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>>>>> Assigning a field a value in an initializer macro can be marked with the
>>>>> `#[bind]` attribute. Doing so creates a `let` binding with the same
>>>>> name. This `let` binding has the type `Pin<&mut T>` if the field is
>>>>> structurally pinned or `&mut T` otherwise (where `T` is the type of the
>>>>> field).
>>>>>
>>>>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>>>>
>>>> Is there a reason we can't apply this to all fields and avoid the
>>>> attribute?
>>>
>>> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
>>> might be surprising too, but I'm also happy with no attribute.
>>>
>>> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
>>
>> IMO the ideal is if it works without an attribute. Perhaps trying that
>> in the kernel is a reasonable experiment to find out whether that's
>> reasonable to do for the general language feature?
> 
> @Boqun what is your opinion on this?
> 
> I'm open to take v2 or v1, whatever you guys prefer.

Same for me, feel free to add

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

to either of them.

This version is also

Tested-by: Danilo Krummrich <dakr@kernel.org>

