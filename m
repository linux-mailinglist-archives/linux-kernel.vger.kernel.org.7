Return-Path: <linux-kernel+bounces-800111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCC0B43385
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D3C7A6239
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBD29A310;
	Thu,  4 Sep 2025 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiHRXDVA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5824501B;
	Thu,  4 Sep 2025 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970177; cv=none; b=url+DUv7dzvxJbOrXPxNhfk6dX1WxQOKhF+infoNywCJi+M3Jvv9UDjr/Ju9AFXCTVVxF4MHwD7pncpzsR7iHrCkTfmdZQQK9htWmDQWZRwI+V+Jtt800Zd1XQjLzb8MVtBuEml1zr812HQOSnRstrjh6OFh8zrtX6kW3DNe62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970177; c=relaxed/simple;
	bh=LPZdm/buyXJ0xTVnIGoZtyA/LmkK+ghc/dp8KaZjL3M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mQUBI3+5jav5SQgCi2myaskShYST6UurO6sX4jd9q7r+d0UmIQHcGOdpDhtU5T1i3Mt9gw8ie4x1JwjHX0FbMJcawvvGCUC6MZswoGKvWtKSiBalyAW1O67+Uq63PYEtI20QpogCxXFKpXWgmN5HZDYHr1z6cnKXHqgWSsd6W0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiHRXDVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81238C4CEF0;
	Thu,  4 Sep 2025 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756970174;
	bh=LPZdm/buyXJ0xTVnIGoZtyA/LmkK+ghc/dp8KaZjL3M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=EiHRXDVA82k7Cr9OTXAw9dXNT8pgAZCIFSnn/1dEFk2jAhv0XD2r9Eta//PpL+mG9
	 iVNrUJtOTVmsw+zbCWLFuwl+SxclzDqY5c6ZWQFLChpztmT9tPVsedZK9g7OiLlG/p
	 5aD3YCHwH/tXG4+Jrw+zBKcAFCNdr86ssiSQyVxiPo7Z5sEKJS1xo8VJ68/54RIvZL
	 iiFdRYt9axVaOxxuVdqRE41iUjmNtAEIl/Q6B7fhOEnC7hQFJoPU3sjlnlX0ypimlq
	 /BcOCDuKX1qY535sifynGn+R+2ImolliCIOFrm4lhuEx4FGeQ3VvL8M9bZk/W0hsAf
	 5cGix/Fo052ig==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Sep 2025 09:16:08 +0200
Message-Id: <DCJTY0OQFG83.1AX49CQARXCEX@kernel.org>
Subject: Re: [PATCH 1/2] nova-core: Add a library for bitfields in Rust
 structs
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250824135954.2243774-1-joelagnelf@nvidia.com>
 <DCBGLCQVD1RF.6V5UT0NQ4GLB@nvidia.com>
 <444ebd64-7a90-46a6-b885-2c114aa59284@nvidia.com>
 <DCJOUO214EXC.32MFBN80VJW3K@nvidia.com>
In-Reply-To: <DCJOUO214EXC.32MFBN80VJW3K@nvidia.com>

On Thu Sep 4, 2025 at 5:16 AM CEST, Alexandre Courbot wrote:
> On Thu Sep 4, 2025 at 12:15 AM JST, Joel Fernandes wrote:
> <snip>
>>>> +use kernel::prelude::*;
>>>> +
>>>> +/// Macro for defining bitfield-packed structures in Rust.
>>>> +/// The size of the underlying storage type is specified with #[repr(=
TYPE)].
>>>> +///
>>>> +/// # Example (just for illustration)
>>>> +/// ```rust
>>>> +/// bitstruct! {
>>>> +///     #[repr(u64)]
>>>> +///     pub struct PageTableEntry {
>>>> +///         0:0       present     as bool,
>>>> +///         1:1       writable    as bool,
>>>> +///         11:9      available   as u8,
>>>> +///         51:12     pfn         as u64,
>>>> +///         62:52     available2  as u16,
>>>> +///         63:63     nx          as bool,
>>>=20
>>> A note on syntax: for nova-core, we may want to use the `H:L` notation,
>>> as this is what OpenRM uses, but in the larger kernel we might want to
>>> use inclusive ranges (`L..=3DH`) as it will look more natural in Rust
>>> code (and is the notation the `bits` module already uses).
>>
>> Perhaps future add-on enhancement to have both syntax? I'd like to initi=
ally
>> keep H:L and stabilize the code first, what do you think?
>
> Let's have the discussion with the other stakeholders (Daniel?). I think
> in Nova we want to keep the `H:L` syntax, as it matches what the OpenRM
> headers do (so Nova would have its own `register` macro that calls into
> the common one, tweaking things as it needs). But in the kernel crate we
> should use something intuitive for everyone.

I don't care too much about whether it's gonna be H:L or L:H [1], but I do =
care
about being consistent throughout the kernel. Let's not start the practice =
of
twisting kernel APIs to NV_* specific APIs that differ from what people are=
 used
to work with in the kernel.

[1] If it's gonna be H:L, I think we should also list things in reverse ord=
er,
    i.e.:

	pub struct PageTableEntry {
	    63:63     nx          as bool,
	    62:52     available2  as u16,
	    51:12     pfn         as u64,
	    11:9      available   as u8,
	    1:1       writable    as bool,
	    0:0       present     as bool,
	}

This is also what would be my preferred style for the kernel in general.

- Danilo

