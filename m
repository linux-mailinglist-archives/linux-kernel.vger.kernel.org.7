Return-Path: <linux-kernel+bounces-795923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989ACB3F979
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5ADC2C2203
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0672EA735;
	Tue,  2 Sep 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baUJTPlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB42EA726;
	Tue,  2 Sep 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803685; cv=none; b=ncTALpXQR2Zl4/KlgrbcQpJTcLRNsjyqeD7QqceByMKhhKTJTPuvuN0p9qbNg3Dprc4xYsZWiHu+A5fhmmvVeEfzkOi/wh8s8qNOkem+C3C8lCKck6EsqZKCOMLq45aIHmfScv6WpQQdzbET4YTj0VrS4WqZtZlrmzClGxmrqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803685; c=relaxed/simple;
	bh=p07YiMczpEjLy1P1T4iapwfegPf/bwOQIeOyzaKjibE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=nxRo0amrYLADxSGDEzcWmlBByklhghQPQwpwKkwce6RHSfaxEpsgdFfX+PxOf4fLInAFSRPND/7hzyWw3Z0C9PDQUY2qpj+Iw70d8zh3SlQE8uroIOLGJTMJP/umWvEYb1vzsShx5XqL49tfPsTDFCjPv1qnAhEuZKjKV9fcVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baUJTPlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471E8C4CEED;
	Tue,  2 Sep 2025 09:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756803684;
	bh=p07YiMczpEjLy1P1T4iapwfegPf/bwOQIeOyzaKjibE=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=baUJTPlIeMsuFcGtJgDaavsbxf3j0VGDSNtAa3sWQjclASyVXrz3MWb//IGV0Lm3b
	 On1aKdbjZHd+SbeT4WbkWRlVOfo7S/V8TZXiVMKOgZTgJ+WC9ij5WbbYEkcZqSfhwx
	 +APBQvKOZFLrZrgpzfA74IUtMW3q0p7quiIX+FdGh4fpJcaYAGkGEDvu3FpnfZh6f8
	 g8+0C5v06W0ytqofAZ/F2Zho4InBsDqM+m8Yy9jOKvztDwpJK7qGiXWGWhGWF0mzUR
	 y4G4ZdMRKw4c05yhGeFgJYRJowgkT3aJ1jU9XqjXojuLoVh/CaTG3fLBjn2aKU1SEW
	 xXaYjF/4DaIxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 11:01:19 +0200
Message-Id: <DCI6XGR65KH9.27TWYVKNZNGHV@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/3] rust: maple_tree: add MapleTree
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Andrew Ballance"
 <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
 <20250902-maple-tree-v3-1-fb5c8958fb1e@google.com>
In-Reply-To: <20250902-maple-tree-v3-1-fb5c8958fb1e@google.com>

On Tue Sep 2, 2025 at 10:35 AM CEST, Alice Ryhl wrote:
> The maple tree will be used in the Tyr driver to allocate and keep track
> of GPU allocations created internally (i.e. not by userspace). It will
> likely also be used in the Nova driver eventually.
>
> This adds the simplest methods for additional and removal that do not
> require any special care with respect to concurrency.
>
> This implementation is based on the RFC by Andrew but with significant
> changes to simplify the implementation.
>
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

One nit below, otherwise:

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> +    pub fn insert_range<R>(&self, range: R, value: T, gfp: Flags) -> Res=
ult<(), InsertError<T>>
> +    where
> +        R: RangeBounds<usize>,
> +    {
> +        let Some((first, last)) =3D to_maple_range(range) else {
> +            return Err(InsertError {
> +                value,
> +                cause: InsertErrorKind::InvalidRequest,
> +            });
> +        };
> +
> +        let ptr =3D T::into_foreign(value);
> +
> +        // SAFETY: The tree is valid, and we are passing a pointer to an=
 owned instance of `T`.
> +        let res =3D to_result(unsafe {
> +            bindings::mtree_insert_range(self.tree.get(), first, last, p=
tr, gfp.as_raw())
> +        });
> +
> +        if let Err(err) =3D res {
> +            // SAFETY: As `mtree_insert_range` failed, it is safe to tak=
e back ownership.
> +            let value =3D unsafe { T::from_foreign(ptr) };
> +
> +            let cause =3D if err =3D=3D ENOMEM {
> +                InsertErrorKind::AllocError(kernel::alloc::AllocError)
> +            } else if err =3D=3D EEXIST {
> +                InsertErrorKind::Occupied
> +            } else {
> +                InsertErrorKind::InvalidRequest
> +            };
> +            Err(InsertError { value, cause })
> +        } else {
> +            Ok(())
> +        }
> +    }

	// SAFETY: The tree is valid, and we are passing a pointer to an owned ins=
tance of `T`.
	to_result(unsafe {
	    bindings::mtree_insert_range(self.tree.get(), first, last, ptr, gfp.as=
_raw())
	}).map_err(|err| {
	    // SAFETY: As `mtree_insert_range` failed, it is safe to take back own=
ership.
	    let value =3D unsafe { T::from_foreign(ptr) };
=09
	    let cause =3D if err =3D=3D ENOMEM {
	        InsertErrorKind::AllocError(kernel::alloc::AllocError)
	    } else if err =3D=3D EEXIST {
	        InsertErrorKind::Occupied
	    } else {
	        InsertErrorKind::InvalidRequest
	    };
	    Err(InsertError { value, cause })
	})

I think that's a bit cleaner than the above (not compile tested).

