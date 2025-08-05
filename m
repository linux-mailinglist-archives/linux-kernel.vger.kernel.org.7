Return-Path: <linux-kernel+bounces-756776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D14EB1B90A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D654A16B8E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42450294A0C;
	Tue,  5 Aug 2025 17:12:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D957B2741D1;
	Tue,  5 Aug 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413976; cv=none; b=GgWRxB9EqpBwVbKuXGG9dmP2/V6CFo7tpjph9Ga7HqMsFG7W4lnyTvSjctS0sDETJChtLmHp/enOxmJzLx2EyZAaLD8EdIXto5B8locNUcr21RSk6kcJ7y0YHgjcud2V+O3nGweBtEEj1ceaNA1ZM0rZUR9Kn20r3T4QEtN+3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413976; c=relaxed/simple;
	bh=xd/IsbccSqAfGaeXar40DZ+WaoktIlhUucfbuJOH8xo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZ7rVdzbGcJdL9hb2+ZHrzEdlvSlD7TEbvLWteFmBXI+IqRlEG5udN2f9jEDs72sDHrScaoRegBtSFZ5RZFySqJYXF9ln8vqPN4kwLvxcxgKGg+Q1qDO28NUQ4Lp1ITWmtsaE2MYA5m5Vmw2Pkhp9CbWIdOrtm8HDe+CkOBomfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45E1C4CEF7;
	Tue,  5 Aug 2025 17:12:52 +0000 (UTC)
From: Andreas Hindborg <a.hindborg@samsung.com>
To: Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org,
 russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com,
 wedsonaf@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com,
 lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rust: add firmware abstractions
In-Reply-To: <ZnCzLIly3DRK2eab@boqun-archlinux>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-3-dakr@redhat.com>
 <ZnCzLIly3DRK2eab@boqun-archlinux>
Date: Tue, 05 Aug 2025 19:12:44 +0200
Message-ID: <87pld98zg3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> On Mon, Jun 17, 2024 at 10:29:41PM +0200, Danilo Krummrich wrote:
>> Add an abstraction around the kernels firmware API to request firmware
>> images. The abstraction provides functions to access the firmware's size
>> and backing buffer.
>> 
>> The firmware is released once the abstraction instance is dropped.
>> 
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>

..

>> +/// # Examples
>> +///
>> +/// ```
>> +/// # use kernel::{c_str, device::Device, firmware::Firmware};
>> +///
>> +/// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
>> +/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
>> +///
>> +/// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev).unwrap();
>> +/// let blob = fw.data();
>> +/// ```
>> +pub struct Firmware(NonNull<bindings::firmware>);
>> +
>
> I feel like eventually we need a very simple smart pointer type for
> these case, for example:
>
>     /// A smart pointer owns the underlying data.
>     pub struct Owned<T: Ownable> {
>         ptr: NonNull<T>,
>     }
>
>     impl<T: Ownable> Owned<T> {
>         /// # Safety
> 	/// `ptr` needs to be a valid pointer, and it should be the
> 	/// unique owner to the object, in other words, no one can touch
> 	/// or free the underlying data.
>         pub unsafe to_owned(ptr: *mut T) -> Self {
> 	    // SAFETY: Per function safety requirement.
> 	    Self { ptr: unsafe { NonNull::new_unchecked(ptr) } }
> 	}
>
> 	/// other safe constructors are available if a initializer (impl
> 	/// Init) is provided
>     }
>
>     /// A Ownable type is a type that can be put into `Owned<T>`, and
>     /// when `Owned<T>` drops, `ptr_drop` will be called.
>     pub unsafe trait Ownable {
>         /// # Safety
> 	/// This could only be called in the `Owned::drop` function.
>         unsafe fn ptr_drop(ptr: *mut Self);
>     }
>
>     impl<T: Ownable> Drop for Owned<T> {
>         fn drop(&mut self) {
> 	    /// SAFETY: In Owned<T>::drop.
> 	    unsafe {
> 	        <T as Ownable>::ptr_drop(self.as_mut_ptr());
> 	    }
> 	}
>     }
>
> we can implement Deref and DerefMut easily on `Owned<T>`. And then we
> could define Firmware as
>
>     #[repr(transparent)]
>     pub struct Firmware(Opaque<bindings::firmware>);
>
> and
>
>     unsafe impl Ownable for Firmware {
>         unsafe fn ptr_drop(ptr: *mut Self) {
> 	    // SAFETY: Per function safety, this is called in
> 	    // Owned::drop(), so `ptr` is a unique pointer to object,
> 	    // it's safe to release the firmware.
>             unsafe { bindings::release_firmware(ptr.cast()); }
>         }
>     }
>
> and the request_*() will return a `Result<Owned<Self>>`. 
>
> Alice mentioned the need of this in page as well:
>
> 	https://lore.kernel.org/rust-for-linux/CAH5fLgjrt0Ohj1qBv=GrqZumBTMQ1jbsKakChmxmG2JYDJEM8w@mail.gmail.com		
>
> Just bring it up while we are (maybe not? ;-)) at it. Also I would like
> to hear whether this would work for Firmware in the longer-term ;-) But
> yes, I'm not that worried about merging it as it is if others are all
> OK.

Please see [1] for an attempt at this pattern.


Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/r/20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me



