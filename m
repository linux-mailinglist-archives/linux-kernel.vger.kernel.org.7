Return-Path: <linux-kernel+bounces-781780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612EB316AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE965A69B6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F152EA73A;
	Fri, 22 Aug 2025 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7Ua+gIW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A981C2324;
	Fri, 22 Aug 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863334; cv=none; b=GoY0UwvAITIdLPc3QsBFu99wY45fjwDy8ioSzEtCq77xk+hxuXkWceCyz3BrcZR2o+Cs+Kln/2BNFj5KpIYPaBYDpNRPHY8Mclrr+PUbxBUg+6XJzhO0vWbMTHoHZSkgERbjStPhSgvEBr84tTFTD6J/fcNlHTO36TNK6B4VG4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863334; c=relaxed/simple;
	bh=huT5Sxo3XY1JHlGV2/HneQ7NQ4xPHvMqzJhNPHE+uT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HobaRUjTUeP4Q6IZq+85r4eUhxLlqlutq+ECWRyUUpW29gZJudDI146ADwiV4ZIqfoEL9CXCPdG+SJB7iJwAKLLyPD1iWnd/jlv7Krwvt0zP9t6Ss8AxeaPKWkCYZgcSnHSQ8iA2hMx6YeeABh8s12C1IBq6AApeOZyw6KqnDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7Ua+gIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8B8C4CEF1;
	Fri, 22 Aug 2025 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755863332;
	bh=huT5Sxo3XY1JHlGV2/HneQ7NQ4xPHvMqzJhNPHE+uT8=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=E7Ua+gIW1IH9Psl+1lr0kfo5TVLWVDGjlaItM4iEuOSEyrfNe/xUxkjgL/cdnbIsd
	 kuIFIwHnpuuxkbuB8VKO6xlT3aAFENftFAnsR4IUrrGrjS85TP1jGpEQA6TXTRvgas
	 flvI+RnQY4bBS013+k3KiNNEa2I/ag5YznLO50+sjmVm8Llr/X/2kOuG9nEaJuGtil
	 +5rhybcRr2d6OmeGol3wldalZPcAEiOMcY/OGzub2oZefNT/Y58p4K9gVVuYQKqMMH
	 w9q3M93sZzWv1AiuC758sOVU9GICYBw7BJ7QdTupT3vT5tJuQGasLVIROIDv6zT47i
	 iGarlppASglig==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 13:48:47 +0200
Message-Id: <DC8XLP6C3E5I.10QJQVI4LORSF@kernel.org>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction
 for sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-4-dakr@kernel.org> <aKhYCf6wgSztcdXU@google.com>
In-Reply-To: <aKhYCf6wgSztcdXU@google.com>

On Fri Aug 22, 2025 at 1:44 PM CEST, Alice Ryhl wrote:
>> +#[pinned_drop]
>> +impl PinnedDrop for RawSGTable {
>> +    #[inline]
>> +    fn drop(self: Pin<&mut Self>) {
>> +        // SAFETY: `sgt` is a valid and initialized `struct sg_table`.
>> +        unsafe { bindings::sg_free_table(self.sgt.get()) };
>
> It's weird that this is called free when the sg_table isn't freed by
> this call.

It frees the entries contained in the sg_table.

>> +    }
>> +}
>> +
>> +/// The [`Owned`] type state of an [`SGTable`].
>> +///
>> +/// A [`SGTable<Owned>`] signifies that the [`SGTable`] owns all associ=
ated resources:
>> +///
>> +/// - The backing memory pages.
>> +/// - The `struct sg_table` allocation (`sgt`).
>> +/// - The DMA mapping, managed through a [`Devres`]-managed `DmaMapSgt`=
.
>> +///
>> +/// Users interact with this type through the [`SGTable`] handle and do=
 not need to manage
>> +/// [`Owned`] directly.
>> +#[pin_data]
>> +pub struct Owned<P> {
>> +    // Note: The drop order is relevant; we first have to unmap the `st=
ruct sg_table`, then free the
>> +    // `struct sg_table` and finally free the backing pages.
>> +    #[pin]
>> +    dma: Devres<DmaMapSgt>,
>> +    #[pin]
>> +    sgt: RawSGTable,
>> +    _pages: P,
>> +}
>> +
>> +// SAFETY: `Owned` can be send to any task if `P` can be send to any ta=
sk.
>> +unsafe impl<P: Send> Send for Owned<P> {}
>> +
>> +// SAFETY: `Owned` can be accessed concurrently if `P` can be accessed =
concurrently.
>> +unsafe impl<P: Sync> Sync for Owned<P> {}
>> +
>> +impl<P> Owned<P>
>> +where
>> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + 'st=
atic,
>> +{
>> +    fn new(
>> +        dev: &Device<Bound>,
>> +        mut pages: P,
>> +        dir: dma::DataDirection,
>> +        flags: alloc::Flags,
>> +    ) -> Result<impl PinInit<Self, Error> + '_> {
>> +        let page_iter =3D pages.page_iter();
>> +        let size =3D page_iter.size();
>
> Variable naming here is confusing. There's another variable called size
> in an inner scope, and then afterwards in RawSGTable you use *this* size
> variable again.

I can change the size in the assignment block of max_segment to max_size, o=
r do
you have other suggestions?

