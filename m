Return-Path: <linux-kernel+bounces-747905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF3B13A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2387A174CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95070251793;
	Mon, 28 Jul 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/MfShGk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5A77111;
	Mon, 28 Jul 2025 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703533; cv=none; b=ryfzuMff2h/GlG7wuWHdZThgS6MMQ8ZDikrdSvTrppMakqIXleJkRjTVZYD9eACMT3/Anu3SYR71SIZ1w4Pr4KasJmXwwG6XqYH1r+kXS6ZdmfFJhG6LXv1QDH3GlfrYnWEomkuz7elEp5gC333XzAwWytYPdjiQ0VWPVNy3/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703533; c=relaxed/simple;
	bh=y5EA5t0+m7pAfOk/7curMHBYuu3le3VLD2NQ96Z2RYs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=fbjgokEs+LtTcswxlRNDEkGfvbytrRJvQ4JzMGPjo9F14isPRJSoZb3ETFLysaknwhSGrQAXuS/DmN7pFjACXcmj7e/iAdzbInnj1By0stPXSPtQDHieOlLxN98AG9pzi+Ut3Ay4pHua0GqQBlbkynEm5pS5AukkgG80CNWm+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/MfShGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5882DC4CEE7;
	Mon, 28 Jul 2025 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753703533;
	bh=y5EA5t0+m7pAfOk/7curMHBYuu3le3VLD2NQ96Z2RYs=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=P/MfShGka+mtLOvxdyWbJu1ISKnFOjol18r7iE1Gt4gb6CFkoqL+c3IzJGKAMLBci
	 2e9JfkW42YRiEpGWG7s0YcrDz8Cwe3+Vvhas0xQzek7bx5FFF/obr8xSR4Z8o/IW0z
	 OX738bXooQHzT8vrVutBX4N2ayv6iiSqWCDXc7+qf+N1eKumj2O3ebrKQi1OOOPRNc
	 CNDT8WRqtPc+pehKL5zzCgrg1F1zgbt2S+PD1M5EzP60HTJs2RZoR0wpVqKNwziRby
	 B5odFtZrG0Zl+olijbxTxDsMit4xYMrAXn5FkKwrbO3tbfRFlISZWWvvcxNqLJiMbC
	 fClkRXN45RkKA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 13:52:08 +0200
Message-Id: <DBNO0N1TDAGI.2OEWH6Y60JNYZ@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Andrew Ballance"
 <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
In-Reply-To: <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>

On Sat Jul 26, 2025 at 3:23 PM CEST, Alice Ryhl wrote:
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c..c7ef504a9c78065b3d5752b4f=
5337fb6277182d1 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -206,6 +206,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
>          unsafe { T::try_from_foreign(ret) }
>      }
> =20
> +    /// Lock the internal spinlock.
> +    #[inline]
> +    pub fn lock(&self) -> MapleLock<'_, T> {
> +        // SAFETY: It's safe to lock the spinlock in a maple tree.
> +        unsafe { bindings::spin_lock(self.ma_lock()) };
> +
> +        // INVARIANT: We just took the spinlock.
> +        MapleLock(self)
> +    }
> +
> +    #[inline]
> +    fn ma_lock(&self) -> *mut bindings::spinlock_t {
> +        // SAFETY: This pointer offset operation stays in-bounds.
> +        let lock =3D unsafe { &raw mut (*self.tree.get()).__bindgen_anon=
_1.ma_lock };
> +        lock.cast()
> +    }
> +
>      /// Free all `T` instances in this tree.
>      ///
>      /// # Safety
> @@ -248,6 +265,83 @@ fn drop(mut self: Pin<&mut Self>) {
>      }
>  }
> =20
> +/// A reference to a [`MapleTree`] that owns the inner lock.
> +///
> +/// # Invariants
> +///
> +/// This guard owns the inner spinlock.
> +pub struct MapleLock<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
> +
> +impl<'tree, T: ForeignOwnable> Drop for MapleLock<'tree, T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we hold this spinlock.
> +        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
> +    }
> +}

I think in the future we also want to give users access to the mas_*() func=
tion
familiy.

I assume, MaState would represent a struct ma_state, but also carry a Maple=
Lock
guard. And then the mas_*() functions would be methods of MaState?

In case we want to allow to release and re-acquire the lock for the same
MaState, we could probably use type states.

I wonder if this (at least partially) makes sense to have from the get-go, =
since
it could already be used to implement things like MapleTree::free_all_entri=
es()
based on it.

