Return-Path: <linux-kernel+bounces-796219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6729DB3FD77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE1C16FA99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F33B2F6563;
	Tue,  2 Sep 2025 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYavVE/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECF2F548B;
	Tue,  2 Sep 2025 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811499; cv=none; b=acbnqLU1wYQsWjEZughEMnKFxEiLJUCHiNesmfFAMsbW20ukA+6FGW8uCnG9vUXPiYhorS7h/lxNMjeCWfsS+WD0P4K5KEWK19x3Stu+sIT4pZBuJg/TTgl0mrFZpDQJRhC9o4rADacAybSsxpGzEsa8XSTR/W9j7kfbg+EV2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811499; c=relaxed/simple;
	bh=A6KhCJ395Or5FmdWt/mYNJIsJqCm7U8UgQjPe9weUwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mIqjA1NvXDlApzYY7+MoGZXpzwBAe+FmXUSR/AiYjaXoSWlZwB18ZRkWqUuGFLje6d79jEaNSKm7Xfxm2T1c9llkifGqbtYA6gsKNUa+kTxpLmef2DFN4ZU/+2iMNI9xq3UITnivPN6FM7TAyo5z/BnSO2afF6DQE6FVmI218Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYavVE/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E85C4CEED;
	Tue,  2 Sep 2025 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756811499;
	bh=A6KhCJ395Or5FmdWt/mYNJIsJqCm7U8UgQjPe9weUwo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=rYavVE/PST1Yvw0ov1oKe28tkI5gMp3dyFBqNCSnxWZi5nky6cEnugdhye3a3lUa0
	 ZYN6rdZCfC0BpAdxFfa4Fa6zUTjTCpl8e3aEld22fJgs2dKhvkig+zgs2vs7qr2K4I
	 1I5jH/xlmbrVw0j8gTxHP2s3b0sLbDjqZXdlDfGYJWpxhCJTAQbjyXdyAXRVCYZhlj
	 3sZdLoUM03ZtCovFl5mjRBqQGyQh6a8CTDA2A6/nPbM/1RlyDkHOXeKtPpp99RzOM7
	 q3vdbWqdKYEKjillL4WzP8L6t4W03McQDWXIhArIgNaneTFt1Lft6OX5mxFztfWLPg
	 eqnM/pHDWvhRA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 13:11:34 +0200
Message-Id: <DCI9P6V88RHN.BX0BQWFDA8DO@kernel.org>
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
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
 <20250902-maple-tree-v3-1-fb5c8958fb1e@google.com>
 <DCI6XGR65KH9.27TWYVKNZNGHV@kernel.org> <aLa4rNojDIeShIrw@google.com>
In-Reply-To: <aLa4rNojDIeShIrw@google.com>

On Tue Sep 2, 2025 at 11:28 AM CEST, Alice Ryhl wrote:
> On Tue, Sep 02, 2025 at 11:01:19AM +0200, Danilo Krummrich wrote:
>> On Tue Sep 2, 2025 at 10:35 AM CEST, Alice Ryhl wrote:
>> > The maple tree will be used in the Tyr driver to allocate and keep tra=
ck
>> > of GPU allocations created internally (i.e. not by userspace). It will
>> > likely also be used in the Nova driver eventually.
>> >
>> > This adds the simplest methods for additional and removal that do not
>> > require any special care with respect to concurrency.
>> >
>> > This implementation is based on the RFC by Andrew but with significant
>> > changes to simplify the implementation.
>> >
>> > Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
>> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
>> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>>=20
>> One nit below, otherwise:
>>=20
>> 	Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>
> Thanks!
>
>> > +    pub fn insert_range<R>(&self, range: R, value: T, gfp: Flags) -> =
Result<(), InsertError<T>>
>> > +    where
>> > +        R: RangeBounds<usize>,
>> > +    {
>> > +        let Some((first, last)) =3D to_maple_range(range) else {
>> > +            return Err(InsertError {
>> > +                value,
>> > +                cause: InsertErrorKind::InvalidRequest,
>> > +            });
>> > +        };
>> > +
>> > +        let ptr =3D T::into_foreign(value);
>> > +
>> > +        // SAFETY: The tree is valid, and we are passing a pointer to=
 an owned instance of `T`.
>> > +        let res =3D to_result(unsafe {
>> > +            bindings::mtree_insert_range(self.tree.get(), first, last=
, ptr, gfp.as_raw())
>> > +        });
>> > +
>> > +        if let Err(err) =3D res {
>> > +            // SAFETY: As `mtree_insert_range` failed, it is safe to =
take back ownership.
>> > +            let value =3D unsafe { T::from_foreign(ptr) };
>> > +
>> > +            let cause =3D if err =3D=3D ENOMEM {
>> > +                InsertErrorKind::AllocError(kernel::alloc::AllocError=
)
>> > +            } else if err =3D=3D EEXIST {
>> > +                InsertErrorKind::Occupied
>> > +            } else {
>> > +                InsertErrorKind::InvalidRequest
>> > +            };
>> > +            Err(InsertError { value, cause })
>> > +        } else {
>> > +            Ok(())
>> > +        }
>> > +    }
>>=20
>> 	// SAFETY: The tree is valid, and we are passing a pointer to an owned =
instance of `T`.
>> 	to_result(unsafe {
>> 	    bindings::mtree_insert_range(self.tree.get(), first, last, ptr, gfp=
.as_raw())
>> 	}).map_err(|err| {
>> 	    // SAFETY: As `mtree_insert_range` failed, it is safe to take back =
ownership.
>> 	    let value =3D unsafe { T::from_foreign(ptr) };
>> =09
>> 	    let cause =3D if err =3D=3D ENOMEM {
>> 	        InsertErrorKind::AllocError(kernel::alloc::AllocError)
>> 	    } else if err =3D=3D EEXIST {
>> 	        InsertErrorKind::Occupied
>> 	    } else {
>> 	        InsertErrorKind::InvalidRequest
>> 	    };
>> 	    Err(InsertError { value, cause })
>> 	})
>>=20
>> I think that's a bit cleaner than the above (not compile tested).
>
> I don't love it. How about a match instead of if/else?

I think if you don't like map_err(), the if/else is fine to keep as is.

Personally, I prefer map_err() over any "manual matching" in this case; it =
gets
us rid of `ref`, making to_result().map_err() a single statement returning
exactly what we expect. It makes it more self-contained.

