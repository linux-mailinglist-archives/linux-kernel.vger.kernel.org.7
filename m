Return-Path: <linux-kernel+bounces-859664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784C0BEE3AE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DF93E64FB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E22E3397;
	Sun, 19 Oct 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdx0AWem"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B521FF4A;
	Sun, 19 Oct 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760873051; cv=none; b=sYA3YhYAL8S+F+MZDGEq+rucedNw+87oEhsYTsNEpuaA9sAjMcxf0npM9tz1s0ZgA5sZYO8C5bss01c60yfCnKNtK+EOgNbjLANGWc9zvzVjLuL3LbpdPgQiDsy0L2udVybRTamu7x+/M2EbuxVihU4lgaI2DfDjjkEPZPIaTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760873051; c=relaxed/simple;
	bh=gpg5SApAUvzrLE+5XOhwMqL/7s9fD4bdgWD1G8CdSLA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=A/6UpNqrd4q9XWFWxt45F0S5jNL3EXy556R9fJS21KX78juFGv4SKh2e5TpmLoyikFuvXcOsnAWTWm1nMtCrEREXjDRjKXOR0Sq3S17P9UOxq3te/dVsMFHO2jLbt6pL+5fRTYN7dBpcCzGa6Pzafd/mgX5w69i4A4RCUjuRKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdx0AWem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D8C4CEE7;
	Sun, 19 Oct 2025 11:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760873050;
	bh=gpg5SApAUvzrLE+5XOhwMqL/7s9fD4bdgWD1G8CdSLA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=cdx0AWemInEAHQL2bTknBPO5QO0C9rgiZlOQi9rypS+ZR9Nx5o+8u9gG1R/+YU3kl
	 Is5sUg7/NkUmDgRqkGZS6vAfTWfAJDln66QQGVPL2EbNh8Zf4G+euI2ppw+Mf0qyRU
	 +7jP2CPw2qyzC4cYWMn4CF3SIhJo1sTWXHUfkDCAZ+mHdlVlxpOQCC1JEg+lA4Meru
	 pK9vnBoAgN78CJ08XcYVgQcABPxbaAGRNz2+dP89Y3L9JN53pg0ia1z31wyDj4jBHN
	 Ovq6L6FM5yod4CVoNZtviD10ZN8Nwch9ZKXceFWFefgg9dxR5oOQxdNkoeR7OLlUFO
	 bmvOP7N0GzzUg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Oct 2025 13:24:05 +0200
Message-Id: <DDM9EDPP7XQN.2SW537AZ7DAZ9@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org> <aPS0aTUUwDsXmHFN@google.com>
In-Reply-To: <aPS0aTUUwDsXmHFN@google.com>

On Sun Oct 19, 2025 at 11:50 AM CEST, Alice Ryhl wrote:
> On Fri, Oct 17, 2025 at 04:37:48PM +0200, Danilo Krummrich wrote:
>> On Fri Oct 17, 2025 at 2:59 PM CEST, Alice Ryhl wrote:
>> > On Sat, Oct 04, 2025 at 12:26:40AM +0200, Danilo Krummrich wrote:
>> >> Introduce support for read-only, write-only, and read-write binary fi=
les
>> >> in Rust debugfs. This adds:
>> >>=20
>> >> - BinaryWriter and BinaryReader traits for writing to and reading fro=
m
>> >>   user slices in binary form.
>> >> - New Dir methods: read_binary_file(), write_binary_file(),
>> >>   `read_write_binary_file`.
>> >> - Corresponding FileOps implementations: BinaryReadFile,
>> >>   BinaryWriteFile, BinaryReadWriteFile.
>> >>=20
>> >> This allows kernel modules to expose arbitrary binary data through
>> >> debugfs, with proper support for offsets and partial reads/writes.
>> >>=20
>> >> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> >
>> >> +extern "C" fn blob_write<T: BinaryReader>(
>> >> +    file: *mut bindings::file,
>> >> +    buf: *const c_char,
>> >> +    count: usize,
>> >> +    ppos: *mut bindings::loff_t,
>> >> +) -> isize {
>> >> +    // SAFETY:
>> >> +    // - `file` is a valid pointer to a `struct file`.
>> >> +    // - The type invariant of `FileOps` guarantees that `private_da=
ta` points to a valid `T`.
>> >> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
>> >> +
>> >> +    // SAFETY: `ppos` is a valid `loff_t` pointer.
>> >> +    let pos =3D unsafe { &mut *ppos };
>> >> +
>> >> +    let mut reader =3D UserSlice::new(UserPtr::from_ptr(buf.cast_mut=
().cast()), count).reader();
>> >> +
>> >> +    let ret =3D || -> Result<isize> {
>> >> +        let offset =3D (*pos).try_into()?;
>> >
>> > So offsets larger than the buffer result in Ok(0) unless the offset
>> > doesn't fit in an usize, in which case it's an error instead? I think =
we
>> > should treat offsets that are too large in the same manner no matter
>> > how large they are.
>>=20
>> The offset being larger than thhe buffer is fine, userspace has to try t=
o read
>> until the kernel indicates that there are no more bytes left to read by
>> returning zero.
>>=20
>> But if the offset is larger than a usize there isn't a chance this can e=
ver be
>> successful in the first place, hence I'd consider this an error.
>
> I don't really agree with this. Obviously we have to return Ok(0) if the
> position is equal to the buffer size. But for positions strictly larger
> than the buffer size I think it's reasonable to choose between Ok(0) or
> an error. But please, let's be consistent about whether we return Ok(0)
> or errors for positions larger than the buffer size.

There's not really a choice, it has to be Ok(0), otherwise we break userspa=
ce.

However, you do have a point with how the offset conversion to usize should=
 be
handled. We shouldn't try to convert it to usize in the first place, but ra=
ther
pass it through as it is and make it a common offset-larger-buffer case.

We probably also want a type alias for bindings::loff_t.

