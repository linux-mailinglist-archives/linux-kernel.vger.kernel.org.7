Return-Path: <linux-kernel+bounces-732227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3942AB063AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B781AA7D89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8D253B7A;
	Tue, 15 Jul 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGaf+6DZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B292459E5;
	Tue, 15 Jul 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595220; cv=none; b=qkBVmz3cCF57ZLKJYdj8LYjz2ut0T9WtCghtQ3Tmx7h4D/Ao21GX8FsBzLI3WEePCDcayEPg/ZuBZNxYZTs/JSNonrxnJYm8U0h42TkhLEsfQxphrKgvwRReZk0OqDxIhQgfG+G6E9xrHwc3crPidEZGQ9QEKR27VWo2FzMQemA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595220; c=relaxed/simple;
	bh=NFRRAPbroRcvQO7QrkrwIOxWqkuN0ik8gVTjoc3MuBU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VCLFsSGh2kMy5CEa28F9IbWbxMr59Lp/N85z3gPGG2/AvaUa/StQ44TjW/Ssq+9wjLzfzHu9ponoaLFMi/WqdeNk3d62RLMX4t3F7mGzztiX/Dekjry+bJgLajXfKmzE2KkauI6DDco/tJ+B5ZooKOS+8YESDmk394Xgiusb/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGaf+6DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EDFC4CEF1;
	Tue, 15 Jul 2025 16:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595219;
	bh=NFRRAPbroRcvQO7QrkrwIOxWqkuN0ik8gVTjoc3MuBU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jGaf+6DZBhfFDtMRlzIuwww6S27E7wxGMCcofLroSTG1Ehn//IjQfvrM7iYnaRAQt
	 pzIXQhxzzIFeilFzRhmPpUDNRztCwE/0YnH5oY1xLvpRMrFr46+UiU5iUJvSSh+0v7
	 9sMk0zr40AFePOi9hTnsUflJEWKXEASkox+ivR16tJ16FrGu8vbbMuwx1iDmzuznVn
	 NWScGbnGI2DIY973GiIVaWPMaWXPx7wJJ6MOmEtXbS56c/IaoophlBlwjIhSUncALw
	 b5MQkdC8qGpK/mnrKNLHEZT/5SUGIN1v/eUcHrLKFbbUumh5rjJm9j8RLZ1vwoaN6C
	 pdqglOeP3JCNQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 18:00:14 +0200
Message-Id: <DBCR5IFQFMUU.23UNP95G4NKWA@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust: alloc: take the allocator into account for
 FOREIGN_ALIGN
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Matthew Wilcox" <willy@infradead.org>, "Tamir
 Duberstein" <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com>
In-Reply-To: <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com>

On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
> When converting a Box<T> into a void pointer, the allocator might
> guarantee a higher alignment than the type itself does, and in that case
> it is guaranteed that the void pointer has that higher alignment.
>
> This is quite useful when combined with the XArray, which you can only
> create using a ForeignOwnable whose FOREIGN_ALIGN is at least 4. This
> means that you can now always use a Box<T> with the XArray no matter the
> alignment of T.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Hey this is cool!

Reviewed-by: Benno Lossin <lossin@kernel.org>

One question below.

> ---
>  rust/kernel/alloc/kbox.rs | 15 +++++++++++----
>  rust/kernel/sync/arc.rs   |  6 +++---
>  2 files changed, 14 insertions(+), 7 deletions(-)

> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 63a66761d0c7d752e09ce7372bc230661b2f7c6d..74121cf935f364c16799b5c31=
cc88714dfd6b702 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -373,10 +373,10 @@ pub fn into_unique_or_drop(self) -> Option<Pin<Uniq=
ueArc<T>>> {
>      }
>  }
> =20
> -// SAFETY: The pointer returned by `into_foreign` comes from a well alig=
ned
> -// pointer to `ArcInner<T>`.
> +// SAFETY: The pointer returned by `into_foreign` was originally allocat=
ed as an
> +// `KBox<ArcInner<T>>`, so that type is what determines the alignment.
>  unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
> -    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<ArcInner<T>>();
> +    const FOREIGN_ALIGN: usize =3D <KBox<ArcInner<T>> as ForeignOwnable>=
::FOREIGN_ALIGN;

Do we at some point also want to give people the option to use vmalloc
for `Arc`?

---
Cheers,
Benno

> =20
>      type Borrowed<'a> =3D ArcBorrow<'a, T>;
>      type BorrowedMut<'a> =3D Self::Borrowed<'a>;


