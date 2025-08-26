Return-Path: <linux-kernel+bounces-787389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75791B3759A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81B567A1EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E713090F5;
	Tue, 26 Aug 2025 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6QWL+9O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771972633;
	Tue, 26 Aug 2025 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251498; cv=none; b=PH/nD9wsZq8Gdkp4evXhkl+/x4NesssR0yaJUYlDbRZOl99RL+3Id4O2p5g3tQkLExbHdgNL3SeHDBzFAvvJgDyMLlAAeurKSiesmBXZ2Gfz5+GVAlV3NRb2/QkdfbY+fVNYK+a0d0lju9PjeR+Glim2yYeKLE9bTDxdoEvLVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251498; c=relaxed/simple;
	bh=kn6ieDwDxZsDgSRi1qDw+jZs8ann+wvttrNfWt18VCY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Wmv5rAfZZP1RSZTI5AnG5++iVBTjpMiLkHsUibm2jEoD0eGHzc3J7vH8idCIwgi+7kMOoSWoFVG7Mv+NZvgEoUU/lIPdEjLsEf4dD43yQsOxh8h/dggFWa16Wd9FUUqMwKQVESpUsWb3WLQyWum7SwW4TEOU9T/mXbnusKu7Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6QWL+9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E396BC4CEF1;
	Tue, 26 Aug 2025 23:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756251498;
	bh=kn6ieDwDxZsDgSRi1qDw+jZs8ann+wvttrNfWt18VCY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=E6QWL+9ORdmTU28VciO8c6Xlxg9A2oRj98hu0YZ11ppE8hBl8vCjRXMtn61rGYr1v
	 MAd025GNlEZ7Tjhd0BLlW7UEf1vZzhPE8Rsg/UP+zN8NVtpw+bpkvnqK1rvFtO17OW
	 3JhSpJ2I0RCZtjh2xZFiW/9B/ropEwEGNuJ0amT65DewCcETzHVXyQIe/1APInhXtT
	 MLamOYSmkUezjsOJsCTB68qOqFORdSUmVPq60vwp9N3bl2HEcG/wlRpqi4FKUFDvAt
	 X3fYFyXyzMsw/VWe7OJzM39kqj74TVSwfOdOm2yh0oh/KYwmME9UQha7J9TSt6d44a
	 aKSYwScs8XCdQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 01:38:13 +0200
Message-Id: <DCCR71R83O68.11AA6B36TYQ3C@kernel.org>
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
 <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>
In-Reply-To: <DCCGKLKK0D08.1VOAVWOJIXIIO@kernel.org>

On Tue Aug 26, 2025 at 5:18 PM CEST, Danilo Krummrich wrote:
> On Tue Aug 26, 2025 at 4:36 PM CEST, Alexandre Courbot wrote:
>> Even if this is for internal use, I think a short comment explaining
>> what this is for, and why it needs to be pinned (pointed to by devres)
>
> That's not the reason this structure needs to be pinned. This is the reas=
on for
> Devres itself needs to be pinned.
>
> In fact, I think RawSGTable by itself does not need to be pinned.

Just to expand on this a bit:

Eventually it does need to be pinned, because DmaMappedSgt keeps a pointer =
of
the underlying struct sg_table. But, this happens in Owned:

	Ok(try_pin_init!(&this in Self {
	    // SAFETY:
	    // - `page_vec` is a `KVec` of valid `struct page *` obtained from `pa=
ges`.
	    // - The pages contained in `pages` remain valid for the entire lifeti=
me of the
	    //   `RawSGTable`.
	    sgt: unsafe { RawSGTable::new(&mut page_vec, size, max_segment, flags)=
 }?,
	    dma <- {
	        // SAFETY: `this` is a valid pointer to uninitialized memory.
	        let sgt =3D unsafe { &raw mut (*this.as_ptr()).sgt }.cast();
=09
	        // SAFETY: `sgt` is guaranteed to be non-null.
	        let sgt =3D unsafe { NonNull::new_unchecked(sgt) };
=09
	        // SAFETY:
	        // - It is guaranteed that the object returned by `DmaMappedSgt::n=
ew` won't out-live
	        //   `sgt`.
	        // - `sgt` is never DMA unmapped manually.
	        Devres::new(dev, unsafe { DmaMappedSgt::new(sgt, dev, dir) })
	    },
	    _pages: pages,
	}))

So, it's fine to move RawSGTable around, *until* we obtain the address for
DmaMappedSgt (within Owned, Devres<DmaMappedSgt> is dropped before the
RawSGTable). However, this is an implementation detail of Owned and has not=
hing
to do with RawSGTable by itself.

Hence, we could also nuke #[pin_data] for RawSGTable and implement it as:

	/// A transparent wrapper around a `struct sg_table`.
	///
	/// While we could also create the `struct sg_table` in the constructor of=
 [`Owned`], we can't tear
	/// down the `struct sg_table` in [`Owned::drop`]; the drop order in [`Own=
ed`] matters.
	#[repr(transparent)]
	struct RawSGTable(Opaque<bindings::sg_table>);

	impl RawSGTable {
	    /// # Safety
	    ///
	    /// - `pages` must be a slice of valid `struct page *`.
	    /// - The pages pointed to by `pages` must remain valid for the entire=
 lifetime of the returned
	    ///   [`RawSGTable`].
	    unsafe fn new(
	        pages: &mut [*mut bindings::page],
	        size: usize,
	        max_segment: u32,
	        flags: alloc::Flags,
	    ) -> Result<Self> {
	        // `sg_alloc_table_from_pages_segment()` expects at least one page=
, otherwise it
	        // produces a NPE.
	        if pages.is_empty() {
	            return Err(EINVAL);
	        }
=09
	        let sgt =3D Opaque::zeroed();
=09
	        // SAFETY:
	        // - `sgt.get()` is a valid pointer to uninitialized memory.
	        // - As by the check above, `pages` is not empty.
	        error::to_result(unsafe {
	            bindings::sg_alloc_table_from_pages_segment(
	                sgt.get(),
	                pages.as_mut_ptr(),
	                pages.len().try_into()?,
	                0,
	                size,
	                max_segment,
	                flags.as_raw(),
	            )
	        })?;
=09
	        Ok(Self(sgt))
	    }
=09
	    #[inline]
	    fn as_raw(&self) -> *mut bindings::sg_table {
	        self.0.get()
	    }
	}
=09
	impl Drop for RawSGTable {
	    #[inline]
	    fn drop(&mut self) {
	        // SAFETY: `sgt` is a valid and initialized `struct sg_table`.
	        unsafe { bindings::sg_free_table(self.0.get()) };
	    }
	}

