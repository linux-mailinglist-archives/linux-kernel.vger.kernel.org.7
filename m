Return-Path: <linux-kernel+bounces-823392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE74FB864CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FBB1CC26FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A8E3176FF;
	Thu, 18 Sep 2025 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQtfbQBs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B214226861;
	Thu, 18 Sep 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217384; cv=none; b=f/cFhVKm+w72J/2ZJPNswfcGOr16ql/0YCTGasfvNfYYEnj/GW9ofM4AEEL/06NS5p4zaq4cx3i0OIB8issNvf9OvaTjRdtE4NuavWkmJgy/4umCtjmOCAWP++CtkhvVepFJDfsANFXe/FHrSJneKxP+UxbGBmhVakndVfyfY5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217384; c=relaxed/simple;
	bh=aqt/STK2MY4NAA1pNa8ksM315kMkdAYPPKarct8YglQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cPoOyCHSI+C/tjfYFfcevIuMPivvNwwWt2zOC/uN6s3bhSpZ0OKv0u0rXCRoL5PA1mM6wjFupbX6U9JCeU+mHBUQ98/ERcDPQITJd2EcWfCnowBvdG906fIzGW20stwZk3un3RZhwMd0iP77Tfrns32CTIHjJVChPNnmHEhlmxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQtfbQBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90051C4CEE7;
	Thu, 18 Sep 2025 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217384;
	bh=aqt/STK2MY4NAA1pNa8ksM315kMkdAYPPKarct8YglQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=JQtfbQBsX7ZiKtFj3kGNXIk1dhsxkTnQTeg+6yucD1JPLkrrUdThs7Ltc30UT5405
	 +x0vCyTADa14o7iKqasb8bvcJeR2sPH27oH/o2MA+nW7jeeQUa43MTNAJo3Xvb25oJ
	 PAe3diaqeVDONigTDw8M5oNAvLo0jfVfhFlxVHOh08XzabDYFtL0lWVEXDqbDrb6SJ
	 PCwnAL6VSotWCYYsvDyRdyfhAMrqwM1QQrReMl3GKZ22poOo/8HsIflyx/8anUp/mx
	 rA3CHIYspGL390UFHApbLlzeVjxaxJ+2GgO7IBVPK8OGnfHrnrzXf6e+gkgYrpIQuG
	 vlCGfumKKKchw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 18 Sep 2025 19:42:54 +0200
Message-Id: <DCW41J94TGVG.1OBWEMPAP3EBK@kernel.org>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, "Todd Kjos"
 <tkjos@android.com>, "Martijn Coenen" <maco@android.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Christian Brauner" <brauner@kernel.org>, "Carlos
 Llamas" <cmllamas@google.com>, "Suren Baghdasaryan" <surenb@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Wedson Almeida Filho"
 <wedsonaf@gmail.com>, "Matt Gilbride" <mattgilbride@google.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>
In-Reply-To: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>

(Far from a full review, but two minor drive-by comments.)

On Thu Sep 18, 2025 at 12:19 PM CEST, Alice Ryhl wrote:
> +    /// Register a vma with this page range. Returns the size of the reg=
ion.
> +    pub(crate) fn register_with_vma(&self, vma: &virt::VmaNew) -> Result=
<usize> {
> +        let num_bytes =3D usize::min(vma.end() - vma.start(), bindings::=
SZ_4M as usize);
> +        let num_pages =3D num_bytes >> PAGE_SHIFT;
> +
> +        if !ptr::eq::<Mm>(&*self.mm, &**vma.mm()) {
> +            pr_debug!("Failed to register with vma: invalid vma->vm_mm")=
;
> +            return Err(EINVAL);
> +        }
> +        if num_pages =3D=3D 0 {
> +            pr_debug!("Failed to register with vma: size zero");
> +            return Err(EINVAL);
> +        }
> +
> +        let layout =3D Layout::array::<PageInfo>(num_pages).map_err(|_| =
ENOMEM)?;
> +        let pages =3D KVmalloc::alloc(layout, GFP_KERNEL)?.cast::<PageIn=
fo>();
> +
> +        // SAFETY: This just initializes the pages array.
> +        unsafe {
> +            let self_ptr =3D self as *const ShrinkablePageRange;
> +            for i in 0..num_pages {
> +                let info =3D pages.as_ptr().add(i);
> +                ptr::addr_of_mut!((*info).range).write(self_ptr);
> +                ptr::addr_of_mut!((*info).page).write(None);
> +                let lru =3D ptr::addr_of_mut!((*info).lru);
> +                ptr::addr_of_mut!((*lru).next).write(lru);
> +                ptr::addr_of_mut!((*lru).prev).write(lru);

I think we should prefer &raw in new code.

> +            }
> +        }
> +
> +        let mut inner =3D self.lock.lock();
> +        if inner.size > 0 {
> +            pr_debug!("Failed to register with vma: already registered")=
;
> +            drop(inner);
> +            // SAFETY: The `pages` array was allocated with the same lay=
out.
> +            unsafe { KVmalloc::free(pages.cast(), layout) };

NIT: If you use KVBox instead, even though you convert to a raw pointer lat=
er,
you can probably safe one unsafe.

> +            return Err(EBUSY);
> +        }
> +
> +        inner.pages =3D pages.as_ptr();
> +        inner.size =3D num_pages;
> +        inner.vma_addr =3D vma.start();
> +
> +        Ok(num_pages)
> +    }

