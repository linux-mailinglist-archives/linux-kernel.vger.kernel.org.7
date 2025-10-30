Return-Path: <linux-kernel+bounces-879162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 731CFC226A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C48C4EF506
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA944329E58;
	Thu, 30 Oct 2025 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj21ihIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBE130AD05;
	Thu, 30 Oct 2025 21:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761859673; cv=none; b=JxQ6F4LwxpWEg3an/uaJdimEd3FzDxRbPnlUksJP2p+jIFh+s4zq7mdiMrJ7fwYlQrJGxHGNdUjuCHwl8tTFu25XlzgxyX0HNCX6H22y2qlKkZmQLb6JPvEf7Pp0Wij8dQPIz7PPZdBsa25uO39/6VKSywIbVblEOS6XZkd3Voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761859673; c=relaxed/simple;
	bh=SVxofZBodQMq2edTAlTFELOdmGnbu0QYSQXYY2Xxvj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=BYTUrEY14kS8ElBj/qYaCxWLx+D7I+3qUO0zdcbJe5gxgokJ4q3WbxqBdpZOxmJFLQqcoLZrl1tcJNu73Q4V0JfzqkT6dfjCOO8B52IJU4Jn8+cd1KkoFV5FZ77ZwA5J9GybWq8f8bCcsxvn/le5QDizRT8O6jjIt3a5nsX4Ng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gj21ihIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99C9C4CEF1;
	Thu, 30 Oct 2025 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761859672;
	bh=SVxofZBodQMq2edTAlTFELOdmGnbu0QYSQXYY2Xxvj4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=gj21ihIpi0Frx5U2DXHXyw0i1BL8GIMyFNGu7SLPiUEQ6giI8X/bCxKhW1d9XjijV
	 us2VQd/o1fhWhogEQdaPAxl0q7Y3G3TkaRGx9H0GwbAlWQ+UFBXxkmbQMfBxdyG66m
	 vQJsQBcqwLjQACSBzNWK3dDxEZ1SNeU9PeaEb6d0udOzREGhhUdHEoN7Shi1sp53LF
	 Ob0Aw/hQxa9GZSfrnpnUSUZIbEv3Q7jIyFFqwrt33vyapJaSJqiU8jE54EvTS0GHUQ
	 hgKKXTrJH5Rt+tY6g2bkpT+boKLByo1R+pokToyeQ7RfbDPwI38X86n48Nu9Hz+Kqv
	 w/Fb3sbEMq61Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Oct 2025 22:27:46 +0100
Message-Id: <DDVZ4L08QMIR.GFMG544BYQEO@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH RFC 3/4] rust: drm: Add DRM buddy allocator bindings
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, "David Airlie" <airlied@gmail.com>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-4-joelagnelf@nvidia.com>
In-Reply-To: <20251030190613.1224287-4-joelagnelf@nvidia.com>

On Thu Oct 30, 2025 at 8:06 PM CET, Joel Fernandes wrote:
> +    ///
> +    /// Returns an [`AllocatedBlocks`] structure that owns the allocated=
 blocks and automatically
> +    /// frees them when dropped. Allocation of `list_head` uses the `gfp=
` flags passed.
> +    pub fn alloc_blocks(
> +        &self,
> +        start: usize,
> +        end: usize,
> +        size: usize,
> +        min_block_size: usize,
> +        flags: BuddyFlags,
> +        gfp: Flags,
> +    ) -> Result<AllocatedBlocks<'_>> {
> +        // Allocate list_head on the heap.
> +        let mut list_head =3D KBox::new(bindings::list_head::default(), =
gfp)?;
> +
> +        // SAFETY: list_head is valid and heap-allocated.
> +        unsafe {
> +            bindings::INIT_LIST_HEAD(&mut *list_head as *mut _);
> +        }

Not a full review, but a quick drive-by comment:

bindings::list_head has to be pinned in memory it should be

	let list_head =3D KBox::pin_init(Opaque::ffi_init(|slot: *mut bindings::li=
st_head| {
	    // SAFETY: `slot` is a valid pointer to uninitialized memory.
	    unsafe { bindings::INIT_LIST_HEAD(slot) };
	}), gfp)?;

if you're doing it by hand, but as mentioned in a previous patch, I think i=
t
would be nice to have a transparent wrapper type, CListHead, for this.

