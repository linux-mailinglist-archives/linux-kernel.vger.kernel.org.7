Return-Path: <linux-kernel+bounces-579237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B33A740FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 23:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0943B1CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15631E1DEB;
	Thu, 27 Mar 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LpN8H0WO"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE2A1531C5;
	Thu, 27 Mar 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114670; cv=none; b=uWrn9riAJf1tq0szh++ESYVTu/KCu1vcuEzcpJLsUotTT7AoTUfGlz+TPrc+nJgKU1t84fibREvd/gV6RlAvqvfW3yif6hbOX3zHAxKd9LFrRRsO0F4TvZ6PjSjrM8RqEIbah5gAGWwkuIYoUCiz0OuR550bG2NtMcWGeNxoapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114670; c=relaxed/simple;
	bh=2aHeBIPKxpMZEgjX1iWdfj20zYYepW1kIT/PFNeYnOw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBdkDYfX97cHG1NF3y4VxHwXvMs9MvUGbA5uX7wbfnOmDGEpbTst8sXKHqWj443uqymYXlblflfk8h1X0uomk//gbHYMTH9L9oeJ7jEEHaSbs5fKeNfM0z/SsNsG3TVreV0RddWxaP2gollMKpPAlG+Dyi5AjgPiSBSDRd6Moe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LpN8H0WO; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1743114667; x=1743373867;
	bh=d7MxYS+vRUZFKyaaYKSIuKEGdkGBo63TfmEbiGnp33E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LpN8H0WORY3223K3dGw4KTfAsg1UXFcDcvCVsQyRDPsTRqU/GLsjA+1xxDZf1D/Tq
	 ANPEAEaiNc99Y9joglRccNv0QQS/GWtZCBW25ZwojYVCU2DH2FII+arXfC4K2jVO+6
	 GOEqGgVNqclTmy5GS7hEwugzGz2ekw2EOIV6hrIDSl04MOLB4wZPGRn7e2TnQMjVx3
	 6rM+rutQOUOJUA99BErhFawg9NvlQImRqnmk7PhE9EMw0l0jQrD8Z+Su+cRKqG8pv2
	 b1t9YNoAUsCQ9gaXnovQcDMvBxsy4FBzluYBzbuBOzMwTBt18GOstFMFPNpsOhuxk9
	 IcyXClQoRgq7Q==
Date: Thu, 27 Mar 2025 22:31:02 +0000
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, a.hindborg@kernel.org, ojeda@kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] rust: dma: add as_slice/write functions for CoherentAllocation
Message-ID: <D8REKSIL1W0E.6A40JD86RFPZ@proton.me>
In-Reply-To: <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com> <20250326201230.3193329-4-abdiel.janulgue@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8dc58c6ccf0f878f43e983ad024beb70b1ba0049
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 26, 2025 at 9:11 PM CET, Abdiel Janulgue wrote:
> +    /// Returns the data from the region starting from `offset` as a sli=
ce.
> +    /// `offset` and `count` are in units of `T`, not the number of byte=
s.
> +    ///
> +    /// Due to the safety requirements of slice, the caller should consi=
der that the region could
> +    /// be modified by the device at anytime. For ringbuffer type of r/w=
 access or use-cases where
> +    /// the pointer to the live data is needed, `start_ptr()` or `start_=
ptr_mut()` could be
> +    /// used instead.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that no hardware operations that involve t=
he buffer are currently
> +    ///   taking place while the returned slice is live.
> +    /// * Callers must ensure that this call does not race with a write =
to the same region while
> +    ///   while the returned slice is live.
> +    pub unsafe fn as_slice(&self, offset: usize, count: usize) -> Result=
<&[T]> {
> +        let end =3D offset.checked_add(count).ok_or(EOVERFLOW)?;
> +        if end >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`,
> +        // we've just checked that the range and index is within bounds.=
 The immutability of the
> +        // of data is also guaranteed by the safety requirements of the =
function.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { core::slice::from_raw_parts(self.cpu_addr.add(offset=
), count) })

I vaguely recall that there was some discussion on why this is OK (ie
the value behind the reference being modified by the device), but I
haven't followed it. Can you add the reasoning for why that is fine to
some comment here?

I also am not really fond of the phrase "hardware operations that
involve the buffer":
* what do you mean with "buffer"? `self`?
* what are "hardware operations"? (I no nothing about hardware, so that
  might be a knowledge gap on my part)
* what does "involve" mean?

---
Cheers,
Benno

> +    }


