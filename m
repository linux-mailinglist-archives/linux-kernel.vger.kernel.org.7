Return-Path: <linux-kernel+bounces-858187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3A9BE93CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7FCA4FC43D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3C432E12C;
	Fri, 17 Oct 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fArdjF6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97452F690B;
	Fri, 17 Oct 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711874; cv=none; b=H92h4Do3C5DJT7GB7TtaKQiRklr/h2Azq21LMubsw8sMuZq3gEEVfUNKKea+I4fB6I8T2XCMOmHo8X347M9rLPOp/sm16CAr/SDEZyEV8wddegD8HuzgVLPWfcwjhLtnuFQxK6zdqzSyrTdvkpILYLjJ5MzBxn18FsYmMnFZQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711874; c=relaxed/simple;
	bh=0qxIre/WeVkJIS/N7KH8ntjpRQspUV9n4A2lexaUEjY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ii/5raN+3TJB+IDRugFrXt+5/3drwUS73obHSfo069uuaXVV4PbZAp2xfsEZi3hvuY/nvSzvJMxQZAvv0Yj8VO3S2/f8dOwk1RqFcG7ep35VSqEUaQPhjdqUkXNiEnGKVsWgfue3qCSkPbh8RJ1DIf8Aq3Hm+z7MD1tvxDUFers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fArdjF6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A7C4CEE7;
	Fri, 17 Oct 2025 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760711873;
	bh=0qxIre/WeVkJIS/N7KH8ntjpRQspUV9n4A2lexaUEjY=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=fArdjF6voxuD1qN7Z6qV70VWmdpHspckKKeBE4gKMAD6qS8USNgMttR1w/e3b7C2z
	 +XNBdIH94icY+JtPk+cf81q7rBNxw6pu5fpegYfj8P2pD95dwlkBl341C1Cm/lLiVg
	 o6fiTezZJpCTYv3c0sfELavflu19ieD6+t+ko2dMqhGdwgL3etJizuxTbSgj2/zti6
	 yNJ9isOAxXyh+OpOXFJCa5JjuF4H3ZswyJ0WGFL3xpbXxuYwEY7V5gP5rakrNVejnC
	 22lW/Z+wT9ESbGyWFFkzw2YU4jUGMbSf6o87NPYgYX19lXVcbY9thU4G0wYO61ALnd
	 QM5iSQavPcPXg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 16:37:48 +0200
Message-Id: <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
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
In-Reply-To: <aPI9tNoh0I3KGDjl@google.com>

On Fri Oct 17, 2025 at 2:59 PM CEST, Alice Ryhl wrote:
> On Sat, Oct 04, 2025 at 12:26:40AM +0200, Danilo Krummrich wrote:
>> Introduce support for read-only, write-only, and read-write binary files
>> in Rust debugfs. This adds:
>>=20
>> - BinaryWriter and BinaryReader traits for writing to and reading from
>>   user slices in binary form.
>> - New Dir methods: read_binary_file(), write_binary_file(),
>>   `read_write_binary_file`.
>> - Corresponding FileOps implementations: BinaryReadFile,
>>   BinaryWriteFile, BinaryReadWriteFile.
>>=20
>> This allows kernel modules to expose arbitrary binary data through
>> debugfs, with proper support for offsets and partial reads/writes.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
>> +extern "C" fn blob_write<T: BinaryReader>(
>> +    file: *mut bindings::file,
>> +    buf: *const c_char,
>> +    count: usize,
>> +    ppos: *mut bindings::loff_t,
>> +) -> isize {
>> +    // SAFETY:
>> +    // - `file` is a valid pointer to a `struct file`.
>> +    // - The type invariant of `FileOps` guarantees that `private_data`=
 points to a valid `T`.
>> +    let this =3D unsafe { &*((*file).private_data.cast::<T>()) };
>> +
>> +    // SAFETY: `ppos` is a valid `loff_t` pointer.
>> +    let pos =3D unsafe { &mut *ppos };
>> +
>> +    let mut reader =3D UserSlice::new(UserPtr::from_ptr(buf.cast_mut().=
cast()), count).reader();
>> +
>> +    let ret =3D || -> Result<isize> {
>> +        let offset =3D (*pos).try_into()?;
>
> So offsets larger than the buffer result in Ok(0) unless the offset
> doesn't fit in an usize, in which case it's an error instead? I think we
> should treat offsets that are too large in the same manner no matter
> how large they are.

The offset being larger than thhe buffer is fine, userspace has to try to r=
ead
until the kernel indicates that there are no more bytes left to read by
returning zero.

But if the offset is larger than a usize there isn't a chance this can ever=
 be
successful in the first place, hence I'd consider this an error.

>> +        let read =3D this.read_from_slice(&mut reader, offset)?;
>> +        *pos +=3D bindings::loff_t::try_from(read)?;
>
> This addition could overflow and panic the kernel.

I don't see a real scenario where this could overflow when read_from_slice(=
) was
successful, but I (also) think this should be checked_add() instead.

>> +        Ok(read.try_into()?)
>> +    }();
>> +
>> +    match ret {
>> +        Ok(n) =3D> n,
>> +        Err(e) =3D> e.to_errno() as isize,
>> +    }
>> +}
>> +
>> +pub(crate) trait BinaryWriteFile<T> {
>> +    const FILE_OPS: FileOps<T>;
>> +}
>
> Hmm ... this is inconsistent with how we do vtables in other parts of
> `kernel`. Normally a struct is used instead of a trait (see e.g.
> miscdevice or block). But the inconsistency is already present.

The reason I went with a trait is because that's consistent within the file=
.

Otherwise, I don't mind one or the other. If we always want to use a struct=
, I'm
fine with that. :)

