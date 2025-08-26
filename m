Return-Path: <linux-kernel+bounces-787173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D6B37273
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D053668FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0212F4A1F;
	Tue, 26 Aug 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOMpzUWK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677721FE47B;
	Tue, 26 Aug 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233948; cv=none; b=iolLuMym1g/QKAczCwU0ZE3i4311O/z//Z2nqLrHWXaleMnX/vO5KV+cxbUpG4QDFE9ChARzgnTOHv6DaiZhatAiba2o93kTZto/c5paD+Vd4wTCNhJziQ3auYbGfCQKBO3y5OSAmF+z2uUibzSV1VcGcZ28NS0yloGF+n+qZfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233948; c=relaxed/simple;
	bh=XDFiBhjhLCDbW1y3W6Yfcx3QJxjwOMqbOOsClbuFiQ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ItEKzchoJ4meRyB6IhP09nZTHCVr92ctAw6YL9LgA9+9XqE4Ew7N+htENxB0B1PE869lEgXdWFiV9sWCnVYBEvSOaR8LPTwhQRjSegRD8dnSF0JJPbHiXdpNWB4mcF0FZNANtvUMFYBgPbzMXYzME5zadMEY8UE8k5e3817xJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOMpzUWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA268C4CEF1;
	Tue, 26 Aug 2025 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756233946;
	bh=XDFiBhjhLCDbW1y3W6Yfcx3QJxjwOMqbOOsClbuFiQ0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=XOMpzUWKjz2Fd88DJBgYJpWsA4i797ALFOd/71MUfT1ALiD1R2ivsHe1SgXHbfAzw
	 yOK1yb46R6u8Yr0ebl5AH5SpUAh9H4xL9wFSLmI8pnHIu40/Qb7foh218StGrTkENI
	 Ol3sTnboYAQGq8oF4lYiH6/neZ+t7uSir/6m6wNjL7+F21YCAcas0Sp8Jbe7SLweI2
	 9O9gjthXU/IQ3cGTqw0bJu8NApROlQT8vRN2y/rDuiz+8/mc7MAOr+Yzfjt1OFkYX+
	 bpOtDCR2I3KLyHjWtFfQIF562YURIVgUmkPowLrOro73oy3UUNWx1znr4kerUYo/F9
	 DI5mjZBpeXD5Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 20:45:41 +0200
Message-Id: <DCCKZ2VUONAR.R50ZFLTWE4T@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v10 2/7] rust: debugfs: Add support for read-only files
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
References: <20250819-debugfs-rust-v10-0-86e20f3cf3bb@google.com>
 <20250819-debugfs-rust-v10-2-86e20f3cf3bb@google.com>
In-Reply-To: <20250819-debugfs-rust-v10-2-86e20f3cf3bb@google.com>

On Wed Aug 20, 2025 at 12:53 AM CEST, Matthew Maurer wrote:
> +    /// Creates a DebugFS file which will own the data produced by the i=
nitializer provided in
> +    /// `data`.
> +    fn create_file<'a, T: Sync + 'static, E: 'a, TI: PinInit<T, E> + 'a>=
(
> +        &'a self,
> +        name: &'a CStr,
> +        data: TI,

Can you please use `impl PinInit<T, E> + 'a` directly? It's a bit more in l=
ine
with how we usually write this and I also think it makes things quite a bit=
 more
obvious compared to hiding it behind the `TI` generic.

Also, can you please use a where clause when the trait and lifetime bounds =
are
getting a bit lengthy? I think for this method this is already justified.

Obviously, this applies to the whole patch (and likely subsequent ones).

> +        file_ops: &'static FileOps<T>,
> +    ) -> impl PinInit<File<T>, E> + 'a {
> +        let scope =3D Scope::<T>::new(data, move |data| {
> +            #[cfg(CONFIG_DEBUG_FS)]
> +            if let Some(parent) =3D &self.0 {
> +                // SAFETY: Because data derives from a scope, and our en=
try will be dropped before
> +                // the data is dropped, it is guaranteed to outlive the =
entry we return.
> +                unsafe { Entry::dynamic_file(name, parent.clone(), data,=
 file_ops) }
> +            } else {
> +                Entry::empty()
> +            }
> +        });
> +        try_pin_init! {
> +            File {
> +                scope <- scope
> +            } ? E
> +        }
> +    }
> +
>      /// Create a new directory in DebugFS at the root.
>      ///
>      /// # Examples
> @@ -79,4 +110,113 @@ pub fn new(name: &CStr) -> Self {
>      pub fn subdir(&self, name: &CStr) -> Self {
>          Dir::create(name, Some(self))
>      }
> +
> +    /// Creates a read-only file in this directory.
> +    ///
> +    /// The file's contents are produced by invoking [`Render::render`] =
on the value initialized by
> +    /// `data`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::c_str;
> +    /// # use kernel::debugfs::Dir;
> +    /// # use kernel::prelude::*;
> +    /// # let dir =3D Dir::new(c_str!("my_debugfs_dir"));
> +    /// let file =3D KBox::pin_init(dir.read_only_file(c_str!("foo"), 20=
0), GFP_KERNEL)?;
> +    /// // "my_debugfs_dir/foo" now contains the number 200.
> +    /// // The file is removed when `file` is dropped.
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn read_only_file<'a, T: Render + Send + Sync + 'static, E: 'a, =
TI: PinInit<T, E> + 'a>(
> +        &'a self,
> +        name: &'a CStr,
> +        data: TI,
> +    ) -> impl PinInit<File<T>, E> + 'a {
> +        let file_ops =3D &<T as ReadFile<_>>::FILE_OPS;
> +        self.create_file(name, data, file_ops)
> +    }
> +}
> +
> +#[pin_data]
> +/// Handle to a DebugFS scope, which allows a variety of DebugFS files/d=
irectories to hang off a
> +/// single structure.
> +pub struct Scope<T> {

I think this doesn't need the Scope indirection just yet, but fine for me t=
o add
it right away.

However, please make sure to expand the documentation a bit. You probably
don't want to mention where this is exactly going just yet, since technical=
ly
those patches should work out standalone in case the more sophisticated sco=
pe
stuff doesn't land.

But, I think you can still describe a bit more in detail that a debugfs::Sc=
ope
handles the lifetime of some private data T for a debugfs::Entry.

Subsequently I would mention that this is used for file entries only.

> +    // This order is load-bearing for drops - `_entry` must be dropped b=
efore `data`.
> +    #[cfg(CONFIG_DEBUG_FS)]
> +    _entry: Entry,
> +    #[pin]
> +    data: T,
> +    // Even if `T` is `Unpin`, we still can't allow it to be moved.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +#[pin_data]
> +/// Handle to a DebugFS file, owning its backing data.
> +///
> +/// When dropped, the DebugFS file will be removed and the attached data=
 will be dropped.
> +pub struct File<T> {
> +    #[pin]
> +    scope: Scope<T>,
> +}
> +
> +#[cfg(not(CONFIG_DEBUG_FS))]
> +impl<T> Scope<T> {
> +    fn new<E, TI: PinInit<T, E>, F: for<'a> FnOnce(&'a T)>(
> +        data: TI,
> +        init: F,
> +    ) -> impl PinInit<Self, E> {
> +        try_pin_init! {
> +            Self {
> +                data <- data,
> +                _pin: PhantomPinned
> +            } ? E
> +        }
> +        .pin_chain(|scope| {
> +            init(&scope.data);
> +            Ok(())
> +        })
> +    }
> +}
> +
> +#[cfg(CONFIG_DEBUG_FS)]
> +impl<T> Scope<T> {
> +    fn entry_mut(self: Pin<&mut Self>) -> &mut Entry {
> +        // SAFETY: _entry is not structurally pinned

Please end with a period.

> +        unsafe { &mut Pin::into_inner_unchecked(self)._entry }
> +    }

Missing empty line.

> +    fn new<'b, E: 'b, TI: PinInit<T, E> + 'b, F: for<'a> FnOnce(&'a T) -=
> Entry + 'b>(
> +        data: TI,
> +        init: F,
> +    ) -> impl PinInit<Self, E> + 'b
> +    where
> +        T: 'b,
> +    {
> +        try_pin_init! {
> +            Self {
> +                _entry: Entry::empty(),
> +                data <- data,
> +                _pin: PhantomPinned
> +            } ? E
> +        }
> +        .pin_chain(|scope| {
> +            *scope.entry_mut() =3D init(&scope.data);
> +            Ok(())
> +        })
> +    }
> +}

<snip>

> +/// # Invariant
> +///
> +/// `FileOps<T>` will always contain an `operations` which is safe to us=
e for a file backed
> +/// off an inode which has a pointer to a `T` in its private data that i=
s safe to convert
> +/// into a reference.
> +pub(super) struct FileOps<T> {
> +    #[cfg(CONFIG_DEBUG_FS)]
> +    operations: bindings::file_operations,
> +    #[cfg(CONFIG_DEBUG_FS)]
> +    mode: u16,
> +    _phantom: PhantomData<T>,
> +}
> +
> +impl<T> FileOps<T> {
> +    /// # Safety

Missing empty line.

> +    /// The caller asserts that the provided `operations` is safe to use=
 for a file whose
> +    /// inode has a pointer to `T` in its private data that is safe to c=
onvert into a reference.
> +    const unsafe fn new(operations: bindings::file_operations, mode: u16=
) -> Self {
> +        Self {
> +            #[cfg(CONFIG_DEBUG_FS)]
> +            operations,
> +            #[cfg(CONFIG_DEBUG_FS)]
> +            mode,
> +            _phantom: PhantomData,
> +        }
> +    }

Same here...

> +    #[cfg(CONFIG_DEBUG_FS)]
> +    pub(crate) const fn mode(&self) -> u16 {
> +        self.mode
> +    }
> +}
> +
> +#[cfg(CONFIG_DEBUG_FS)]
> +impl<T> Deref for FileOps<T> {
> +    type Target =3D bindings::file_operations;

...and here.

> +    fn deref(&self) -> &Self::Target {
> +        &self.operations
> +    }
> +}
> +
> +struct RenderAdapter<T>(T);
> +
> +impl<'a, T: Render> Display for RenderAdapter<&'a T> {
> +    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
> +        self.0.render(f)
> +    }
> +}
> +
> +/// Implements `open` for `file_operations` via `single_open` to fill ou=
t a `seq_file`.
> +///
> +/// # Safety
> +///
> +/// * `inode`'s private pointer must point to a value of type `T` which =
will outlive the `inode`
> +///   and will not have any unique references alias it during the call.
> +/// * `file` must point to a live, not-yet-initialized file object.
> +unsafe extern "C" fn render_open<T: Render + Sync>(
> +    inode: *mut bindings::inode,
> +    file: *mut bindings::file,
> +) -> c_int {
> +    // SAFETY: The caller ensures that `inode` is a valid pointer.
> +    let data =3D unsafe { (*inode).i_private };
> +    // SAFETY:
> +    // * `file` is acceptable by caller precondition.
> +    // * `print_act` will be called on a `seq_file` with private data se=
t to the third argument,
> +    //   so we meet its safety requirements.
> +    // * The `data` pointer passed in the third argument is a valid `T` =
pointer that outlives
> +    //   this call by caller preconditions.
> +    unsafe { bindings::single_open(file, Some(render_act::<T>), data) }
> +}
> +
> +/// Prints private data stashed in a seq_file to that seq file.
> +///
> +/// # Safety
> +///
> +/// `seq` must point to a live `seq_file` whose private data is a live p=
ointer to a `T` which may

We usually say "valid".

> +/// not have any unique references alias it during the call.
> +unsafe extern "C" fn render_act<T: Render + Sync>(
> +    seq: *mut bindings::seq_file,
> +    _: *mut c_void,
> +) -> c_int {
> +    // SAFETY: By caller precondition, this pointer is live, points to a=
 value of type `T`, and
> +    // there are not and will not be any unique references until we are =
done.
> +    let data =3D unsafe { &*((*seq).private.cast::<T>()) };
> +    // SAFETY: By caller precondition, `seq_file` points to a live `seq_=
file`, so we can lift
> +    // it.
> +    let seq_file =3D unsafe { SeqFile::from_raw(seq) };
> +    seq_print!(seq_file, "{}", RenderAdapter(data));
> +    0
> +}
> +
> +// Work around lack of generic const items.
> +pub(crate) trait ReadFile<T> {
> +    const FILE_OPS: FileOps<T>;
> +}
> +
> +impl<T: Render + Sync> ReadFile<T> for T {
> +    const FILE_OPS: FileOps<T> =3D {
> +        let operations =3D bindings::file_operations {
> +            read: Some(bindings::seq_read),
> +            llseek: Some(bindings::seq_lseek),
> +            release: Some(bindings::single_release),
> +            open: Some(render_open::<Self>),
> +            // SAFETY: `file_operations` supports zeroes in all fields.
> +            ..unsafe { core::mem::zeroed() }
> +        };
> +        // SAFETY: `operations` is all stock `seq_file` implementations =
except for `render_open`.
> +        // `open`'s only requirement beyond what is provided to all open=
 functions is that the
> +        // inode's data pointer must point to a `T` that will outlive it=
, which matches the
> +        // `FileOps` requirements.
> +        unsafe { FileOps::new(operations, 0o400) }
> +    };
> +}
> diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.r=
s
> new file mode 100644
> index 0000000000000000000000000000000000000000..2939e18e3dda39571cd725550=
5e5f605f0e3d154
> --- /dev/null
> +++ b/rust/kernel/debugfs/traits.rs
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2025 Google LLC.
> +
> +//! Traits for rendering or updating values exported to DebugFS.
> +
> +use crate::sync::Mutex;
> +use core::fmt::{self, Debug, Formatter};
> +
> +/// A trait for types that can be rendered into a string.
> +///
> +/// This works very similarly to `Debug`, and is automatically implement=
ed if `Debug` is
> +/// implemented for a type. It is also implemented for any renderable ty=
pe inside a `Mutex`.

I think the blanket impls make sense, but we should probably add a note tha=
t the
contents derived via #[derive(Debug)] are not guaranteed to be stable [1].

[1] https://doc.rust-lang.org/std/fmt/trait.Debug.html#stability

> +pub trait Render {

Should we really call this Render? Maybe it'd be better to call it
debugfs::Writer?

Yes, I know it's called in read(), but that's what the kernel does, it writ=
es
on read(). :)

> +    /// Formats the value using the given formatter.
> +    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result;
> +}
> +
> +impl<T: Render> Render for Mutex<T> {
> +    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result {
> +        self.lock().render(f)
> +    }
> +}
> +
> +impl<T: Debug> Render for T {
> +    fn render(&self, f: &mut Formatter<'_>) -> fmt::Result {
> +        writeln!(f, "{self:?}")
> +    }
> +}

