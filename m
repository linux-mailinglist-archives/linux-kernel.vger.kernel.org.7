Return-Path: <linux-kernel+bounces-787233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC2B37349
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59CC1BC0985
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4758D30CDA5;
	Tue, 26 Aug 2025 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR71Wcf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9030CD90;
	Tue, 26 Aug 2025 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237110; cv=none; b=RmYo0TLr6zle+I4QPaD24xcGJa7tWXz6axoWQ41kyeTnP+N49mZrsHffmcNninKDMAvrpC9Y5A7lM5DzaC64Ikl9tlZWWip+bvvCsGxG5rmZrJML2YWgxWOiItjXkJkhfEbjnaPksbucPu9r65Ku+ImKKT6OZE8EcKiXlCwdS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237110; c=relaxed/simple;
	bh=JkRiOtOD7nGfvS/xJ8iPjBNLupvw+//rIPPlnv3yBhI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SdZsjCKJlNJGMrREKBDG9j40c97CpYuHW+sDuft/+vrJHEsY7hgPQAozK3DVIyoD/dnLpR1LXrdS3qRhvf6O9EKwGqqNJ1Z0BLSR6DTp4mqIW2ojwVot7VBT1+5Buxv5xD1Pq24B7VOMTMrYzBSQ2OWxhmLbyaxVjcRTqZxX1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR71Wcf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED26C4CEF4;
	Tue, 26 Aug 2025 19:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756237110;
	bh=JkRiOtOD7nGfvS/xJ8iPjBNLupvw+//rIPPlnv3yBhI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hR71Wcf/qyjAkX7u5xmk53i1oIq+P8FdYMnnENZYj6GVEYLe5jzgF/1FeLLyVll9Q
	 L4Gyi/VIzwuI6FRU5JEy6AoGZooxIPgD4mmtDkZ3EXDkjTyybJ/9STiZJCYI+Mw3dQ
	 f/syNHRRmzJsOwm3jLHeRYp9m5uprAG3Sby+xchkVWpAx/sTHTZYcwM4hb7NpiH9LO
	 ZBnxfza6cM2NjBoe4FV7GoRx690xbsdugI9dSVCbDS8N0hVIeJPUjFHuXII5998iKq
	 rMQ90SEomTkrWT8Mf+eLHLlRKt3NIMfFgpXRaqVnYpZbKu80hmZjUw1Nm8/OyfRFel
	 aatNUzbLLBEJw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 21:38:25 +0200
Message-Id: <DCCM3G61QPMD.2R4QDAG1U7NCQ@kernel.org>
Subject: Re: [PATCH v10 3/7] rust: debugfs: Add support for writable files
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Matthew Maurer" <mmaurer@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-3-86e20f3cf3bb@google.com>
In-Reply-To: <20250819-debugfs-rust-v10-3-86e20f3cf3bb@google.com>

On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
> +    /// Creates a read-write file in this directory.
> +    ///
> +    /// Reading the file uses the [`Render`] implementation.
> +    /// Writing to the file uses the [`UpdateFromSlice`] implementation.
> +    pub fn read_write_file<
> +        'a,
> +        T: Render + UpdateFromSlice + Send + Sync + 'static,
> +        E: 'a,
> +        TI: PinInit<T, E> + 'a,

Same comments as in the previous patch, I think using a where clause is a b=
it
cleaner, even though with this formatting it'd be fine too, but this is not
guaranteed.

> +    >(
> +        &'a self,
> +        name: &'a CStr,
> +        data: TI,

impl PinInit<T, E> + 'a

> +    ) -> impl PinInit<File<T>, E> + 'a {
> +        let file_ops =3D &<T as ReadWriteFile<_>>::FILE_OPS;
> +        self.create_file(name, data, file_ops)
> +    }

> +fn update<T: UpdateFromSlice + Sync>(data: &T, buf: *const c_char, count=
: usize) -> isize {
> +    let mut reader =3D UserSlice::new(UserPtr::from_ptr(buf as *mut c_vo=
id), count).reader();

This naming is pretty close to what I was about to propose for the UpdateFr=
omSlice
trait. :)

Given that I proposed debugfs::Writer instead of debugfs::Render, I think w=
e
should just rename debugfs::UpdateFromSlice to debugfs::Reader.

> +
> +    if let Err(e) =3D data.update_from_slice(&mut reader) {
> +        return e.to_errno() as isize;
> +    }
> +
> +    count as isize
> +}

<snip>

> +/// # Safety
> +///
> +/// `inode` must be a valid pointer to an `inode` struct.
> +/// `file` must be a valid pointer to a `file` struct.
> +unsafe extern "C" fn write_only_open(
> +    inode: *mut bindings::inode,
> +    file: *mut bindings::file,
> +) -> c_int {
> +    // SAFETY: The caller ensures that `inode` and `file` are valid poin=
ters.
> +    unsafe {
> +        (*file).private_data =3D (*inode).i_private;
> +    }

NIT: If you move the semicolon at the end of the unsafe block it goes into =
a
single line.

> +    0
> +}

<snip>

> +impl<T: UpdateFromSlice + Sync> WriteFile<T> for T {
> +    const FILE_OPS: FileOps<T> =3D {
> +        let operations =3D bindings::file_operations {
> +            open: Some(write_only_open),
> +            write: Some(write_only_write::<T>),
> +            llseek: Some(bindings::noop_llseek),
> +            // SAFETY: `file_operations` supports zeroes in all fields.
> +            ..unsafe { core::mem::zeroed() }
> +        };
> +        // SAFETY:
> +        // * `write_only_open` populates the file private data with the =
inode private data
> +        // * `write_only_write`'s only requirement is that the private d=
ata of the file point to
> +        //   a `T` and be legal to convert to a shared reference, which =
`write_only_open`
> +        //   satisfies.
> +        unsafe { FileOps::new(operations, 0o200) }

I think it'd be nice to have an abstraction for file modes, but this can be=
 done
separately.

> +    };
> +}
> diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.r=
s
> index 2939e18e3dda39571cd7255505e5f605f0e3d154..d64638898faaa1a6a9898c374=
b8c1114993376c9 100644
> --- a/rust/kernel/debugfs/traits.rs
> +++ b/rust/kernel/debugfs/traits.rs
> @@ -3,8 +3,15 @@
> =20
>  //! Traits for rendering or updating values exported to DebugFS.
> =20
> +use crate::prelude::*;
>  use crate::sync::Mutex;
> +use crate::uaccess::UserSliceReader;
>  use core::fmt::{self, Debug, Formatter};
> +use core::str::FromStr;
> +use core::sync::atomic::{
> +    AtomicI16, AtomicI32, AtomicI64, AtomicI8, AtomicIsize, AtomicU16, A=
tomicU32, AtomicU64,
> +    AtomicU8, AtomicUsize, Ordering,
> +};
> =20
>  /// A trait for types that can be rendered into a string.
>  ///
> @@ -26,3 +33,65 @@ fn render(&self, f: &mut Formatter<'_>) -> fmt::Result=
 {
>          writeln!(f, "{self:?}")
>      }
>  }
> +
> +/// A trait for types that can be updated from a user slice.
> +///
> +/// This works similarly to `FromStr`, but operates on a `UserSliceReade=
r` rather than a &str.
> +///
> +/// It is automatically implemented for all atomic integers, or any type=
 that implements `FromStr`
> +/// wrapped in a `Mutex`.
> +pub trait UpdateFromSlice {

As mentioned above, I think we should name this Reader and the Render thing
Writer.

> +    /// Updates the value from the given user slice.
> +    fn update_from_slice(&self, reader: &mut UserSliceReader) -> Result<=
()>;

read_from_slice()?

> +}
> +
> +impl<T: FromStr> UpdateFromSlice for Mutex<T> {
> +    fn update_from_slice(&self, reader: &mut UserSliceReader) -> Result<=
()> {
> +        let mut buf =3D [0u8; 128];
> +        if reader.len() > buf.len() {
> +            return Err(EINVAL);
> +        }
> +        let n =3D reader.len();
> +        reader.read_slice(&mut buf[..n])?;
> +
> +        let s =3D core::str::from_utf8(&buf[..n]).map_err(|_| EINVAL)?;
> +        let val =3D s.trim().parse::<T>().map_err(|_| EINVAL)?;
> +        *self.lock() =3D val;
> +        Ok(())
> +    }
> +}
> +
> +macro_rules! impl_update_from_slice_for_atomic {
> +    ($(($atomic_type:ty, $int_type:ty)),*) =3D> {
> +        $(
> +            impl UpdateFromSlice for $atomic_type {
> +                fn update_from_slice(&self, reader: &mut UserSliceReader=
) -> Result<()> {
> +                    let mut buf =3D [0u8; 21]; // Enough for a 64-bit nu=
mber.
> +                    if reader.len() > buf.len() {
> +                        return Err(EINVAL);
> +                    }
> +                    let n =3D reader.len();
> +                    reader.read_slice(&mut buf[..n])?;
> +
> +                    let s =3D core::str::from_utf8(&buf[..n]).map_err(|_=
| EINVAL)?;
> +                    let val =3D s.trim().parse::<$int_type>().map_err(|_=
| EINVAL)?;
> +                    self.store(val, Ordering::Relaxed);
> +                    Ok(())
> +                }
> +            }
> +        )*
> +    };
> +}
> +
> +impl_update_from_slice_for_atomic!(
> +    (AtomicI16, i16),
> +    (AtomicI32, i32),
> +    (AtomicI64, i64),
> +    (AtomicI8, i8),
> +    (AtomicIsize, isize),
> +    (AtomicU16, u16),
> +    (AtomicU32, u32),
> +    (AtomicU64, u64),
> +    (AtomicU8, u8),
> +    (AtomicUsize, usize)
> +);
>
> --=20
> 2.51.0.rc1.167.g924127e9c0-goog


