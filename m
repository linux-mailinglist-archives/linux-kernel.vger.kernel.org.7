Return-Path: <linux-kernel+bounces-732035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54D2B06121
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ECA188ED2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16326F44C;
	Tue, 15 Jul 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGvRVUFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F923ABA8;
	Tue, 15 Jul 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589198; cv=none; b=nOaN7+sAqk611qbZk7+wdi5kbUbkjUDWgCpS9FPOCJt1mMN2yGkwfX294d1PDgSakpuQVOhVCFZZ+abjHlffTJTHWmJphOFgTo+3iN3w34yXA8+gbu98VYkAIYuFFMdVro2gC6bpwhcKIC1cCp2+QU/dwnmujFZINi6pWQYpnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589198; c=relaxed/simple;
	bh=A1G6u7RCG+QAHRPpoSe6S44CCjDAlNNJCDe8is+d4Tg=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Fi5XX1bHy1vBztP2emjlhLWZRnKzCs2k+QHYQpT5+spCr6v0ks3eM4xq2xRdZJGBzux8M9ZTfSPzTsWZJ6vOCyR8s/4MmA3ygWfvD1137y3x90et59le058594gIviBpKulUwqGRHgIlwnmUssSDiXeoBctptlEdGM/Q4mCwRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGvRVUFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEE5C4CEF4;
	Tue, 15 Jul 2025 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752589198;
	bh=A1G6u7RCG+QAHRPpoSe6S44CCjDAlNNJCDe8is+d4Tg=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=KGvRVUFhWS3WwzdO9digcswGdZZlyc8u3K0w2zPUB51CjHMwVWpcJKpFb0+Bzf1bN
	 kwYDhz6RWzXEQFS9I/qm1cEF9pz21delmnsEIxIbbPmmmYHDboR4iR7UOvt7ve1ofM
	 tSrHyBhudBaj8wh4JgW9xuP26kaecBfC/pQQpNVeOeBf+Us8r8LRcg8ZeMemcSDu8p
	 UvL53XP57G0DxA+U0odNj8vXcBFrNRziVLFt1pplxItIU650geyxK16ZmRbBXuL2us
	 MNkVZ875tf1GLAFnHLBdHzJRFA0jeDK5l5K9ebOAS5kLSRXpDmoEfEJAgzHarqhl86
	 7EMczK+KoGsRg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 16:19:53 +0200
Message-Id: <DBCP0OLEAHAW.JC4AQHMVQW81@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: alloc: take the allocator into account for
 FOREIGN_ALIGN
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox" <willy@infradead.org>, "Tamir Duberstein"
 <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com>
In-Reply-To: <20250715-align-min-allocator-v1-2-3e1b2a5516c0@google.com>

On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index bffe72f44cb33a265018e67d92d9f0abe82f8e22..fd3f1e0b9c3b3437fb50d8f1b=
28c92bc7cefd565 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -400,12 +400,19 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags)=
 -> Result<Self, E>
>  }
> =20
>  // SAFETY: The pointer returned by `into_foreign` comes from a well alig=
ned
> -// pointer to `T`.
> +// pointer to `T` allocated by `A`.
>  unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
>  where
>      A: Allocator,
>  {
> -    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +    const FOREIGN_ALIGN: usize =3D {
> +        let mut align =3D core::mem::align_of::<T>();
> +        if align < A::MIN_ALIGN {
> +            align =3D A::MIN_ALIGN;
> +        }
> +        align
> +    };

Pretty unfortunate that core::cmp::max() can't be used from const context. =
:(

What do you think about

	const FOREIGN_ALIGN: usize =3D
	    if core::mem::align_of::<T>() < A::MIN_ALIGN {
	        A::MIN_ALIGN
	    } else {
	        core::mem::align_of::<T>()
	    };

instead? I think that reads a bit better.

