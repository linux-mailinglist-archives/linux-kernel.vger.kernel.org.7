Return-Path: <linux-kernel+bounces-721677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C6CAFCC59
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B774A42CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91C2DD5F0;
	Tue,  8 Jul 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glm03Xc8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143001F949;
	Tue,  8 Jul 2025 13:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982136; cv=none; b=g6GCBbW7g8fboMsCiH96vcs+50i/EA7txFhctyKB+Zo0DPL7Ng3xHqD/7xW4H2PRTvjTVM1NdEqdxS2PY7lsYZDiTZAHrTK8n8qze/wgjnLVTfXBBlcma0dqJzNgkvzZKSjl7TGtkojNfZDK/yO2uX65WUjFDMmUjCLVk7B72IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982136; c=relaxed/simple;
	bh=4OB+fvC6xINHXBjWi2+D07sb7phDCGROqvwbPea3V1g=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=c9cBW0pccl+LBzVPLlE7Hu4ykvcEEH3xKEX6Pue5IwwidYczSwuvEtYLncs7KBRXN/cjgxANrJ/i4x+Um/2R9qsf6Lutm6kIYKa4+G9JuY/pl83VDrYwl1E5ZVc+KC9RupSYRnGboufA+TPUHp8rbN07UYGKWIgTKsfYMv78Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glm03Xc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7D5C4CEED;
	Tue,  8 Jul 2025 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751982135;
	bh=4OB+fvC6xINHXBjWi2+D07sb7phDCGROqvwbPea3V1g=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Glm03Xc8B+tbxdytL9QIk5GBHAPU/V/h0gPg4XQkFoNuz/fGRqVYbmU6VhTVO7y3z
	 75+Md/kxHCOFGCneWq8c1TUZb6NvSQOF4zdCMqOuRLzP6IXa7oZVyp9mYXktmbxvBh
	 WUMwX021u8efCucTDRwk2mRaciGcjg1jW3NIopYjee8CzxAu+PToPN7xeKc3MW27KC
	 2ShOKhmmVbIbTujg0E45T+OeInWqnISmqh+8G8LGUUD1CcHU205UGEHlGkGstFQoo2
	 j7dlTQH3UMQPeoYam7aAzsK3gsJ2WTZG5V3n8hgRl7/yxPyEtaWbVLUsMJMbFhtJfe
	 8Le1O6ajhhwLw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 15:42:11 +0200
Message-Id: <DB6PU07CUFZK.9JEG3423922O@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Asahi Lina" <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] rust: Add `OwnableRefCounted`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-4-49eadcdc0aa6@pm.me>
 <DB1LPFAX66WG.1QL5JDCWI7RN4@kernel.org> <aGuAR7JCrlmzQrx4@mango>
 <DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org> <aGzmoMWvy1v7ayyn@mango>
In-Reply-To: <aGzmoMWvy1v7ayyn@mango>

On Tue Jul 8, 2025 at 11:36 AM CEST, Oliver Mangold wrote:
> On 250707 1133, Benno Lossin wrote:
>> On Mon Jul 7, 2025 at 10:07 AM CEST, Oliver Mangold wrote:
>> > On 250702 1524, Benno Lossin wrote:
>> >> On Wed Jun 18, 2025 at 2:27 PM CEST, Oliver Mangold wrote:
>> >> > @@ -132,3 +134,124 @@ fn drop(&mut self) {
>> >> >          unsafe { T::release(self.ptr) };
>> >> >      }
>> >> >  }
>> >> > +
>> >> > +/// A trait for objects that can be wrapped in either one of the r=
eference types [`Owned`] and
>> >> > +/// [`ARef`].
>> >> > +///
>> >> > +/// # Safety
>> >> > +///
>> >> > +/// Implementers must ensure that:
>> >> > +///
>> >> > +/// - [`try_from_shared()`](OwnableRefCounted::into_shared) only r=
eturns an [`Owned<Self>`] if
>> >> > +///   exactly one [`ARef<Self>`] exists.
>> >>
>> >> This shouldn't be required?
>> >
>> > Ehm, why not? `Owned<T>` is supposed to be unique.
>>=20
>> It's not needed as a safety requirement for implementing the trait. If
>> the implementation only contains sound code, then `Owned::from_raw`
>> should already ensure that `Owned<Self>` is only created if there is
>> exactly one reference to it.
>
> Okay, got it now. I guess you are right, it is not strictly needed. If th=
e
> requirement should be removed, not sure, though. Isn't it error-prone if =
it
> explicitly stated here (again) that it is required?

You can move it to the normal docs of the trait, but it shouldn't be a
safety requirement.

>> >> > +/// - [`into_shared()`](OwnableRefCounted::into_shared) set the re=
ference count to the value which
>> >> > +///   the returned [`ARef<Self>`] expects for an object with a sin=
gle reference in existence. This
>> >> > +///   implies that if [`into_shared()`](OwnableRefCounted::into_sh=
ared) is left on the default
>> >> > +///   implementation, which just rewraps the underlying object, th=
e reference count needs not to be
>> >> > +///   modified when converting an [`Owned<Self>`] to an [`ARef<Sel=
f>`].
>> >>
>> >> This also seems pretty weird...
>> >>
>> >> I feel like `OwnableRefCounted` is essentially just a compatibility
>> >> condition between `Ownable` and `RefCounted`. It ensures that the
>> >> ownership declared in `Ownable` corresponds to exactly one refcount
>> >> declared in `RefCounted`.
>> >>
>> >> That being said, I think a `RefCounted` *always* canonically is
>> >> `Ownable` by the following impl:
>> >>
>> >>     unsafe impl<T: RefCounted> Ownable for T {
>> >>         unsafe fn release(this: NonNull<Self>) {
>> >>             T::dec_ref(this)
>> >>         }
>> >>     }
>> >>
>> >> So I don't think that we need this trait at all?
>> >
>> > No. For an `ARef<T>` to be converted to an `Owned<T>` it requires a
>> > `try_from_shared()` implementation. It is not even a given that the
>> > function can implemented, if all the kernel exposes are some kind of
>> > `inc_ref()` and `dec_ref()`.
>>=20
>> I don't understand this paragraph.
>
> What I mean is, to convert from an `ARef` to an `Owned`, it is necessary =
to
> check that there is only one reference. The API of the underlying object
> might not provide that.
>
> About the above documentation, it is a bit convoluted, because I had the
> case of `mq::Request` in mind, where the refcount needs to be changed
> during conversion.

So I think I got a bit confused with my initial question. We do need
this trait in order to enable the `ARef -> Owned` conversion. But the
other way is going to be fine if we choose to add the blanket impl
above.

Now the question is do we want `T: RefCounted` to imply `T: Ownable`? I
think the answer is yes, but it sadly conflicts with `AlwaysRefCounted`,
since if `T: AlwaysRefCounted` it must not implement `Ownable`.

So to me it seems this point has become moot.

>> > Also there are more complicated cases like with `Mq::Request`, where t=
he
>> > existence of an `Owned<T>` cannot be represented by the same refcount =
value
>> > as the existence of exactly one `ARef<T>`.
>>=20
>> Ah right, I forgot about this. What was the refcount characteristics of
>> this again?
>>=20
>> *  1 =3D in flight, owned by C
>> *  2 =3D in flight, owned by Rust
>> * >2 =3D in flight, owned by Rust + additional references used by Rust
>>        code
>>=20
>> Correct? Maybe @Andreas can check.
>>=20
>> >> > +///
>> >> > +/// # Examples
>> >>
>> >> If we're having an example here, then we should also have on on `Owne=
d`.
>> >
>> > Yes, maybe. I mostly felt the need to create one for `OwnableRefCounte=
d`
>> > because it is a more complex idea than `Ownable`.
>> >
>> > If I remember correctly, I didn't create one for `Owned`, as it should
>> > probably more or less the same as for `ARef` and the one there has eve=
n
>> > more problems of the kind you are pointing out. So maybe it would be b=
est
>> > to wait until someone fixes that and have the fixed version copied ove=
r to
>> > `Owned` in the process?
>>=20
>> Wait which problems on `ARef` do you mean? I disagree that `Owned` and
>> `ARef` have the same example. `Owned` should expose operations that
>> `ARef` can't otherwise there would be no value in using `Owned`.
>
> I mean it uses a `struct Empty {}`, which doesn't do any refcounting and
> the safety requirements of `ARef::from_raw()` are also not fulfilled.

Right.

> The point of `Owned` is not that it provides more operations than `ARef`
> but rather that it provides less. The reference cannot be cloned. Actuall=
y
> it is not supposed to provide much features at all, except for freeing th=
e
> underlying object when it is dropped.

Both our statements are true at the same time: `Owned<T>` itself has
less operations available compared to `ARef`, but `Owned<Specific>` has
potentially more operations than `ARef<Speceific>`. So eg in the
`Request` case, one can only call `end_ok` if you have an `Owned` one.

> It is supposed to just be a safe wrapper around a `*T`, marking that the
> reference is Owned/Unique. Safe functions defined elsewhere can then take=
 a
> `Owned<T>` or `&mut Owned<T>` which provides the assurance of
> ownership/uniqueness.

Well it should also have compatibility with `RefCounted` if it
implements `OwnableRefCounted`.

>> >> > +///
>> >> > +/// A minimal example implementation of [`OwnableRefCounted`], [`O=
wnable`] and its usage with
>> >> > +/// [`ARef`] and [`Owned`] looks like this:
>> >> > +///
>> >> > +/// ```
>> >> > +/// # #![expect(clippy::disallowed_names)]
>> >> > +/// use core::cell::Cell;
>> >> > +/// use core::ptr::NonNull;
>> >> > +/// use kernel::alloc::{flags, kbox::KBox, AllocError};
>> >> > +/// use kernel::types::{
>> >> > +///     ARef, RefCounted, Owned, Ownable, OwnableRefCounted,
>> >> > +/// };
>> >> > +///
>> >> > +/// struct Foo {
>> >> > +///     refcount: Cell<usize>,
>> >> > +/// }
>> >> > +///
>> >> > +/// impl Foo {
>> >> > +///     fn new() -> Result<Owned<Self>, AllocError> {
>> >> > +///         // Use a `KBox` to handle the actual allocation.
>> >> > +///         let result =3D KBox::new(
>> >> > +///             Foo {
>> >> > +///                 refcount: Cell::new(1),
>> >> > +///             },
>> >> > +///             flags::GFP_KERNEL,
>> >> > +///         )?;
>> >> > +///         let result =3D NonNull::new(KBox::into_raw(result))
>> >> > +///             .expect("Raw pointer to newly allocation KBox is n=
ull, this should never happen.");
>> >>
>> >> I'm not really convinced that an example using `KBox` is a good one..=
.
>> >> Maybe we should just have a local invisible `bindings` module that
>> >> exposes a `-> *mut foo`. (internally it can just create a KBox`)
>> >
>> > The example would become quite a bit more complicated then, no?
>>=20
>> Just hide those parts behind `#` lines in the example.
>
> I don't know about this method. Can you give an example on how that works=
?

See the second code block in [1].

[1]: https://doc.rust-lang.org/rustdoc/write-documentation/what-to-include.=
html#examples

---
Cheers,
Benno

