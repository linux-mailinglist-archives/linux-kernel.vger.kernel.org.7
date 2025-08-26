Return-Path: <linux-kernel+bounces-786897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E4B36D93
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704711895914
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4476248F56;
	Tue, 26 Aug 2025 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKHxkfAU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB481CD1F;
	Tue, 26 Aug 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221529; cv=none; b=IxNmYmfMBHgU7cRW7y4WdI3rxeupP0mtIHUCkNYzF5efl60DzmZyybm67EFlkTwW28+GZlBBiZAoLuIm4W4GjGphpsBHCUVy8bAH3BrSF6t10lz0QrM8bteLRgnk3B2GAGRZE08PqOjwPAXYKwmvbPQ8OtNVrA24EbY4Zf6D86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221529; c=relaxed/simple;
	bh=ED8pKdDXE217xxU3fmpfNjr6cCJ+skFHmQ/en4RjX/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=a5s8J+N3SZiAT4aWL6FAycnFHcUMEBA5LIet82O8n3KVJmmgQk51QJ4UZTKyKzHNUZ+ZajNRWCvHo2KPawTMVjh0UqYNSroJPsB3YDFTOKPVt+xVsRU/dm0vYxklydn6h0ZIL1smoWUqZpAGrrJCpneQawhS+U0yqEgr0dAkPOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKHxkfAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6785CC4CEF1;
	Tue, 26 Aug 2025 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756221528;
	bh=ED8pKdDXE217xxU3fmpfNjr6cCJ+skFHmQ/en4RjX/8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KKHxkfAU6pnL5cCCL8F13/K9/I3uvus2+zFBLIsKtRncCreaIV9cJTR6OdtCeLUkW
	 nrDT1Awf3qQQuqZAUg4pOKn4CihD0PljlCTW3MAbE+C7ZRIItbtvQ2i7t/r0AKJV3G
	 sv6cxSpVhjvt6I0klBlWhJV6TO74dAG85BjmViM+B0sPX6AWt5BxoeFrPiufsrCHvA
	 oJGz1aX8TN7NIp8sUlHUCPzkc/bCN88gW8spmijSdGmBXsGtWNE9DzLiZweFZ1O0nl
	 VkgAraEwpb9x9YXC1INjoKgDEZL7dqJ5cNhK30tEWvIZHl6U3d3tZ5s+kQFFH2EOXt
	 i8O+ng8XQszrQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 17:18:42 +0200
Message-Id: <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>
Subject: Re: [PATCH v3 3/5] rust: scatterlist: Add abstraction for sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-4-dakr@kernel.org>
 <DCCFOGR3BPVC.3OW6B74N372MB@nvidia.com>
In-Reply-To: <DCCFOGR3BPVC.3OW6B74N372MB@nvidia.com>

On Tue Aug 26, 2025 at 4:36 PM CEST, Alexandre Courbot wrote:
> On Mon Aug 25, 2025 at 10:24 PM JST, Danilo Krummrich wrote:
>> Add a safe Rust abstraction for the kernel's scatter-gather list
>> facilities (`struct scatterlist` and `struct sg_table`).
>>
>> This commit introduces `SGTable<T>`, a wrapper that uses a generic
>> parameter to provide compile-time guarantees about ownership and lifetim=
e.
>>
>> The abstraction provides two primary states:
>> - `SGTable<Owned<P>>`: Represents a table whose resources are fully
>>   managed by Rust. It takes ownership of a page provider `P`, allocates
>>   the underlying `struct sg_table`, maps it for DMA, and handles all
>>   cleanup automatically upon drop. The DMA mapping's lifetime is tied to
>>   the associated device using `Devres`, ensuring it is correctly unmappe=
d
>>   before the device is unbound.
>> - `SGTable<Borrowed>` (or just `SGTable`): A zero-cost representation of
>>   an externally managed `struct sg_table`. It is created from a raw
>>   pointer using `SGTable::as_ref()` and provides a lifetime-bound
>>   reference (`&'a SGTable`) for operations like iteration.
>>
>> The API exposes a safe iterator that yields `&SGEntry` references,
>> allowing drivers to easily access the DMA address and length of each
>> segment in the list.
>>
>> Co-developed-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> A few minor things below, but:
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Used successfully on nova-core:
>
> Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks for re-testing!

> I still see mentions of "type state" in the code (and the commit
> message), is this on purpose? I still think this is a misleading use of
> the term, but your call.

I think I changed everything in the commit message, but there are indeed tw=
o or
three mentions in the code still.

I'm happy to replace them with "generic parameter", but I do not agree that=
 the
term "type state" is misleading.

It may not be the classical typestate pattern, yet we are representing two
distinct states of a type.

> <snip>
>> +impl SGEntry {
>> +    /// Convert a raw `struct scatterlist *` to a `&'a SGEntry`.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the `struct scatterlist` pointed to by=
 `ptr` is valid for the
>> +    /// lifetime `'a`.
>
> Shouldn't the scatterlist also have valid a dma_address and dma_len?

I don't think this is safety relevant from the perspective of Rust.

Also note that if we want to provide this guarantee, we need the caller to
provide the &Device<Bound> in SGTable::iter() the SGTable has been created =
with.

For the Owned generic parameter this is easy, for the Borrowed one we have =
no
way to ensure that the &Device<Bound> matches the device the SGTable has be=
en
mapped for.

However, I don't think we have to provide this guarantee, since at this poi=
nt
all device resources (such as I/O memory) have been revoked from the driver
already. So, effectively, even if a driver would attempt to program invalid=
 DMA
addresses, the driver would be uncapable of doing so anyways.

> <snip>
>> +#[repr(transparent)]
>> +#[pin_data(PinnedDrop)]
>> +struct RawSGTable {
>
> Even if this is for internal use, I think a short comment explaining
> what this is for, and why it needs to be pinned (pointed to by devres)

That's not the reason this structure needs to be pinned. This is the reason=
 for
Devres itself needs to be pinned.

In fact, I think RawSGTable by itself does not need to be pinned.

> would be helpful to people looking at this code.


