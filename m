Return-Path: <linux-kernel+bounces-742697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D608BB0F579
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCCB13B71CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F32EF9BD;
	Wed, 23 Jul 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMrIkLjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3820E023;
	Wed, 23 Jul 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281369; cv=none; b=OfyK2k8edxUa5CN37izSBu0pRP0zGAStu5yfKs8fnaZXW9CuQDygUdGH3xsIC0Ifuv5SNTyHTIwz/pCx894hyg52VjH49aPqbDV+gbOw+nckty78/kXO+oImNwsMsf8fBjJYBwhVoEp09qMMFGFuHa5IGQMCwebZ3ORkpZP65vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281369; c=relaxed/simple;
	bh=TfLI4hpAb/IcCHboE4yM4dKFzRS2cirqHqAIlnDgTGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u80j9vKcnIsOrLEUGkDHC9xZzH65my2X/jxRrx4cnu8FriMx9C0IYDIZPxZ9vzE56C9fY13jFlotwCyAiuUrwDfoI4vU2m37uB7o3lLA4BcjYCCr+KB5phmgfKss2NAps6PimHTD4iquHj6/8TGkGAJ8ZcPixC/a3tR6hfD2hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMrIkLjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A890DC4CEEF;
	Wed, 23 Jul 2025 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281368;
	bh=TfLI4hpAb/IcCHboE4yM4dKFzRS2cirqHqAIlnDgTGg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=FMrIkLjb1A20xcuUaefBE7BMQemq/dKlgpIi8I4hjl1vGcHzsd8ZcMIDIwKKazkzk
	 p0jlBDlD8lje1j5VxLHIzHqwOJ7DhXc0szQTpnSyZAsOmXkOrOHPiJD7vmhN0mnxP1
	 jvH3h0VGfnhMygM/LVgOX+alciq+9nM/jeNzm1wvbWuQghuDy4xlCuYJOFi/bBkLRB
	 M05hSN/zy8lTB78R8zLyYREH8pyzMu2s5PPF/Cnkkr7z0QEoPHuy/OuOeQFMGoLspD
	 E0LcWEK7OaMrFgdviTPXxntdKfIBBfTwCTHUy1DUuPe6tXaDigz9C2NIFXVfJeCLfi
	 x/Hrw3zLgv5eQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 16:36:05 +0200
Message-Id: <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
In-Reply-To: <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>

On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
>  impl LockClassKey {
> +    /// Initializes a statically allocated lock class key.
> +    ///
> +    /// This is usually used indirectly through the [`static_lock_class!=
`] macro.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The destructor must never run on the returned `LockClassKey`.

I don't know how lockdep works, but Boqun mentioned in the other thread
that it uses the address of static keys. But AFAIK there is no mechanism
to differentiate them, so does lockdep just check the address and if it
is in a static segment it uses different behavior?

Because from the safety requirements on this function, I could just do
this:

    // SAFETY: we leak the box below, so the destructor never runs.
    let class =3D KBox::new(unsafe { LockClassKey::new_static() });
    let class =3D Pin::static_ref(KBox::leak(class));
    let lock =3D SpinLock::new(42, c_str!("test"), class);
    let _ =3D lock.lock();

Because if lockdep then expects this to be initialized, we need to
change the requirement to only be used from statics.

---
Cheers,
Benno

> +    #[doc(hidden)]
> +    pub const unsafe fn new_static() -> Self {
> +        LockClassKey {
> +            inner: Opaque::uninit(),
> +        }
> +    }

