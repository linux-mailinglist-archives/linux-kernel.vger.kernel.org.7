Return-Path: <linux-kernel+bounces-773441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE0B2A028
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178AA17973C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96E3112DC;
	Mon, 18 Aug 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+PU41tA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956C261B9A;
	Mon, 18 Aug 2025 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515821; cv=none; b=ErBuTRdEBHYr016eaoOKjYPmP6yMuZ9Fdc3HvtzLDmZGSRjjsRsyLobxGY1pV1tzguMkiDDlL/tT0PmDiMpeZSdxsjMIuA/2Dpiz+a5JEc0CVth+pJaTBG8eQTXPGbkhXHyjvZtH/r8QygBVNT2JwS6+x2+z7ubEFh3RqVLUAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515821; c=relaxed/simple;
	bh=WkHAJns6tF1KkG/V9oBkm2Zgo3xCoxSvv1aflMsfp58=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BGzP2h9QtEyGuMpPNp320oSKz2hdevzdIMkZlBdrWcaQj+xMiOlv2nRVNYqm1UipRKCojVyVFaaaTgiRdnnwORkRS2mZ975hsqwsQgbpca35FCjx9EF1wxz+0sm0PgPqy3Z+W50mCexJ3ffeRK5k4rTWsFlf1t0Dso9ZKhaueCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+PU41tA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775FFC4CEED;
	Mon, 18 Aug 2025 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755515820;
	bh=WkHAJns6tF1KkG/V9oBkm2Zgo3xCoxSvv1aflMsfp58=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=m+PU41tA9jJENtv6T53vYovMPaf0OK4zfdnofMROtywcN2dGmCXkXDblz+Xg2mgVE
	 fDF8tagDzkDgImIeq2MkC9MjOfRqMYIjcFo9Cmc2c47AFEqqzb4LYQqKgZ6mjGpbI9
	 Ni11CoPWgPW0MKQl+cp6iwUiTOYIXzAIYA2v4Q8rd8h5ib2LrGCJ+BqeNRHfq6qqVV
	 hqUBQ34ObAiS6oMsmhAqTqDwvkmWu78wttIyZH2N8ylMC40fKSmH+28rTgwPl9RuTG
	 W+PGYkua2WYFGN/Sl563xaH9W3gr/Br/AzbCjlZeo4RV9B+5Yw0P0OJpjeLvigs3Ty
	 vZ+AJqRjaqF+A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Aug 2025 13:16:55 +0200
Message-Id: <DC5IF4AUVJP6.5B68OUOXQLCM@kernel.org>
Subject: Re: [PATCH 2/4] rust: scatterlist: Add type-state abstraction for
 sg_table
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>, <acourbot@nvidia.com>,
 <jgg@ziepe.ca>, <lyude@redhat.com>, <robin.murphy@arm.com>,
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250815171058.299270-1-dakr@kernel.org>
 <20250815171058.299270-3-dakr@kernel.org> <aKL338gQ7qPNKoBu@google.com>
In-Reply-To: <aKL338gQ7qPNKoBu@google.com>

On Mon Aug 18, 2025 at 11:52 AM CEST, Alice Ryhl wrote:
> On Fri, Aug 15, 2025 at 07:10:03PM +0200, Danilo Krummrich wrote:
>> +/// A single entry in a scatter-gather list.
>> +///
>> +/// An `SGEntry` represents a single, physically contiguous segment of =
memory that has been mapped
>> +/// for DMA.
>> +///
>> +/// Instances of this struct are obtained by iterating over an [`SGTabl=
e`]. Drivers do not create
>> +/// or own [`SGEntry`] objects directly.
>> +#[repr(transparent)]
>> +pub struct SGEntry(Opaque<bindings::scatterlist>);
>
> Send/Sync?

I think SGEntry doesn't need it, but both would be valid.

For the other types, I simply forgot to impl Sync.

>> +    /// Returns the DMA address of this SG entry.
>> +    ///
>> +    /// This is the address that the device should use to access the me=
mory segment.
>> +    pub fn dma_address(&self) -> bindings::dma_addr_t {
>
> We might want a typedef on the Rust side for dma_addr_t, like we already
> have for the phys_addr_t/resource_size_t.

Yes, the idea was to add that with a subsequent patch, dma.rs already leaks
bindings::dma_addr_t and I didn't want to mix up this series with this clea=
nup.

>> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct scat=
terlist`.
>> +        unsafe { bindings::sg_dma_address(self.as_raw()) }
>> +    }
>> +
>> +    /// Returns the length of this SG entry in bytes.
>> +    pub fn dma_len(&self) -> u32 {
>
> Is u32 really the right length type?

The C type uses unsigned int unfortunately, and SG entries larger than u32
probably don't make sense.

Formally, bus addresses and hence this size, can exceed size_t. However, it
obviously makes no sense for this to happen, so size_t would be a reasonabl=
e
choice. ressource_size_t would be resonable too.

>> +/// # Invariants
>> +///
>> +/// `sgt` is a valid pointer to a `struct sg_table` for the entire life=
time of an [`DmaMapSgt`].
>
> I think we probably want an invariant for why it's safe to call
> dma_unmap_sgtable in Drop.

I assume you're suggesting that the invariant should say that the SG table =
is
always mapped? And that we should add a safety requirement to DmaMapSgt::ne=
w()
that the caller must guarantee that the SG table is never unmapped other th=
an by
dropping DmaMapSgt?

If so, that sounds reasonable.

>> +struct DmaMapSgt {
>> +    sgt: NonNull<bindings::sg_table>,
>> +    dev: ARef<Device>,
>> +    dir: dma::DataDirection,
>> +}

<snip>

>> +impl RawSGTable {
>> +    fn new(
>> +        mut pages: KVec<*mut bindings::page>,
>> +        size: usize,
>> +        max_segment: u32,
>> +        flags: alloc::Flags,
>> +    ) -> impl PinInit<Self, Error> {
>> +        try_pin_init!(Self {
>> +            sgt <- Opaque::try_ffi_init(|slot: *mut bindings::sg_table|=
 {
>> +                // `sg_alloc_table_from_pages_segment()` expects at lea=
st one page, otherwise it
>> +                // produces a NPE.
>> +                if pages.is_empty() {
>> +                    return Err(EINVAL);
>> +                }
>> +
>> +                // SAFETY:
>> +                // - `slot` is a valid pointer to uninitialized memory.
>> +                // - As by the check above, `pages` is not empty.
>> +                error::to_result(unsafe {
>> +                    bindings::sg_alloc_table_from_pages_segment(
>> +                        slot,
>> +                        pages.as_mut_ptr(),
>> +                        pages.len().try_into()?,
>
> The `pages` vector is dropped immediately after this call to
> sg_alloc_table_from_pages_segment. Is that ok?

Yes, it's only needed during sg_alloc_table_from_pages_segment().

> If it's ok, then I would change `pages` to `&[*mut page]` so that the
> caller can manage the allocation of the array.

We can immediately drop it after sg_alloc_table_from_pages_segmen(), so why=
 do
we want the caller to take care of the lifetime?

>> +impl<P> Owned<P>
>> +where
>> +    for<'a> P: page::AsPageIter<Iter<'a> =3D VmallocPageIter<'a>> + 'st=
atic,
>
> If you specifically require the iterator type to be VmallocPageIter,
> then I would hard-code that in the trait instead of specifying it here.

I do not follow, hard-code in which trait?

> But I think you just want `P: AsPageIter`.

Yeah, I thought for now it's probably good enough to require VmallocPageIte=
r and
revisit once we get more implementors of AsPageIter, but I think we can als=
o do
it right away.

I think we'd need a trait PageIterator, which implements page_count(), sinc=
e we
technically can't rely on Iterator::size_hint(). Though, in this case I thi=
nk we
can also just make AsPageIter::Iter: ExactSizeIterator?

>> +{
>> +    fn new(
>> +        dev: &Device<Bound>,
>> +        mut pages: P,
>> +        dir: dma::DataDirection,
>> +        flags: alloc::Flags,
>> +    ) -> Result<impl PinInit<Self, Error> + use<'_, P>> {
>
> We would probably want to move the logic into the initializer so that we
> don't have the double Result here.

That'd be nice, but I think it's not possible.

We can't borrow from pages in the initializer closure while at the same tim=
e
store pages with another initializer, can we?

Either way, it's not that big a deal I think, since this constructor is not
exposed to the outside world. Which is also why it didn't bother me too muc=
h.

>> +        let page_iter =3D pages.page_iter();
>> +        let size =3D page_iter.size();
>> +
>> +        let mut page_vec: KVec<*mut bindings::page> =3D
>> +            KVec::with_capacity(page_iter.page_count(), flags)?;
>> +
>> +        for page in page_iter {
>> +            page_vec.push(page.as_ptr(), flags)?;
>> +        }
>> +
>> +        // `dma_max_mapping_size` returns `size_t`, but `sg_alloc_table=
_from_pages_segment()` takes
>> +        // an `unsigned int`.
>> +        let max_segment =3D {
>> +            // SAFETY: `dev.as_raw()` is a valid pointer to a `struct d=
evice`.
>> +            let size =3D unsafe { bindings::dma_max_mapping_size(dev.as=
_raw()) };
>> +            if size =3D=3D 0 {
>> +                u32::MAX
>> +            } else {
>> +                size.min(u32::MAX as usize) as u32
>
> u32::try_from(size).unwrap_or(u32::MAX)
>
>> +            }
>> +        };
>> +
>> +        Ok(try_pin_init!(&this in Self {
>> +            sgt <- RawSGTable::new(page_vec, size, max_segment, flags),
>> +            dma <- {
>> +                // SAFETY: `this` is a valid pointer to uninitialized m=
emory.
>> +                let sgt =3D unsafe { &raw mut (*this.as_ptr()).sgt }.ca=
st();
>> +
>> +                // SAFETY: `sgt` is guaranteed to be non-null.
>> +                let sgt =3D unsafe { NonNull::new_unchecked(sgt) };
>> +
>> +                // SAFETY: It is guaranteed that the object returned by=
 `DmaMapSgt::new` won't
>> +                // out-live `sgt`.
>> +                Devres::new(dev, unsafe { DmaMapSgt::new(sgt, dev, dir)=
 })
>> +            },
>> +            _pages: pages,
>> +        }))
>> +    }
>> +}

