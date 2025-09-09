Return-Path: <linux-kernel+bounces-808577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887D4B501C0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0576717B16A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC92273803;
	Tue,  9 Sep 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="fuU63Asy"
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610F10E3;
	Tue,  9 Sep 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432741; cv=none; b=UvQ2XsVibGQWFuLRUGHLItJTTUYDgB3iSiKxquiulTescB+Jv1CSkjjRWrc0aZXO1tVSx4zD48izTRZSPJTNP1KMPpkToYUfvHbPeBTwSkidwIt2cEpHlOX7CvQ2jkeiuGF3ynuhW/ckT/Yi3VJBBC1Rs/X85ftxHgtAphIJqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432741; c=relaxed/simple;
	bh=0yz6aghSeYaaRKdDcRzSd6f06S1jGRsDA2q9Dz/HqU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URzjsjczV8dwomxywESdqXhfiiYPkZznjtujLdVUP6tHP3cqJgDXPstIRz2NCoRkSh9k03LHVCXnWwmL94IEbIgOT1sMniRJ1IcNFAN5bsGTbzCVU/C/Dcepa8+6LJp/hxgCXdZpm5NnXeh+PSAP/9YUly3m9KHq4JC/Og2+Ir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=fuU63Asy; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:290e:0:640:f317:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id E9F59809BE;
	Tue, 09 Sep 2025 18:45:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OjLILl4LuKo0-8eHHkWSo;
	Tue, 09 Sep 2025 18:45:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757432728;
	bh=dIRrBjelZrgFNCTCF1oaGTQ+9cRVwzvwxL9eis2Nb8E=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=fuU63Asya9b0JbIYNjWzZzCcVMoi+Tx7cRLs4YuTE/BS5B35N6B56Ysrr7iT/TguE
	 E2CH4qM5gHSya4oemztI7rw+OXVrG2LtmoM2te+0Tio2HcL4j809YmaSusc+AA27z9
	 QkLj7iC1iv7ZrtQwVv1nD8Cv4IUY/8qe64AJOMJo=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 9 Sep 2025 18:45:24 +0300
From: Onur <work@onurozkan.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com,
 tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu,
 a.hindborg@kernel.org, lossin@kernel.org, bjorn3_gh@protonmail.com,
 gary@garyguo.net, boqun.feng@gmail.com, alex.gaynor@gmail.com,
 ojeda@kernel.org
Subject: Re: [PATCH v1] rust: refactor `to_result` to return the original
 value
Message-ID: <20250909184524.1482d602@nimda.home>
In-Reply-To: <CAH5fLghVt6MKfiDkmd-5DMAKA=yXQzMu3GNHAqB+HRGhyJ0tqA@mail.gmail.com>
References: <20250909123258.29304-1-work@onurozkan.dev>
	<CAH5fLghVt6MKfiDkmd-5DMAKA=yXQzMu3GNHAqB+HRGhyJ0tqA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 14:36:13 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Tue, Sep 9, 2025 at 2:33=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
> >
> > Current `to_result` helper takes a `c_int` and returns `Ok(())` on
> > success and this has some issues like:
> >
> >     - Callers lose the original return value and often have to store
> >         it in a temporary variable before calling `to_result`.
> >
> >     - It only supports `c_int`, which makes callers to unnecessarily
> >         cast when working with other types (e.g. `u16` in phy
> >         abstractions). We even have some places that ignore to use
> >         `to_result` helper because the input doesn't fit in `c_int`
> >         (see [0]).
> >
> > [0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
> >
> > This patch changes `to_result` to be generic and also return the
> > original value on success.
> >
> > So that the code that previously looked like:
> >
> >     let ret =3D unsafe { bindings::some_ffi_call() };
> >     to_result(ret).map(|()| SomeType::new(ret))
> >
> > can now be written more directly as:
> >
> >     to_result(unsafe { bindings::some_ffi_call() })
> >         .map(|ret| SomeType::new(ret))
> >
> > Similarly, code such as:
> >
> >     let res: isize =3D $some_ffi_call();
> >     if res < 0 {
> >         return Err(Error::from_errno(res as i32));
> >     }
> >
> > can now be used with `to_result` as:
> >
> >     to_result($some_ffi_call())?;
> >
> > Existing call sites that only care about success/failure are updated
> > to append `.map(|_| ())` to preserve their previous semantics. They
> > can also use the equivalent pattern:
> >
> >     to_result($something)?;
> >     Ok(())
> >
> > This patch only fixes the callers that broke after the changes on
> > `to_result`. I haven't included all the improvements made possible
> > by the new design since that could conflict with other ongoing
> > patches [1]. Once this patch is approved and applied, I am planning
> > to follow up with creating a "good first issue" on [2] for those
> > additional changes.
> >
> > [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> > [2]: https://github.com/Rust-for-Linux/linux
> >
> > Link:
> > https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/nea=
r/536374456
> > Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev> ---
> >  rust/kernel/auxiliary.rs        |  1 +
> >  rust/kernel/block/mq/tag_set.rs |  2 +-
> >  rust/kernel/cpufreq.rs          |  3 ++-
> >  rust/kernel/devres.rs           |  1 +
> >  rust/kernel/dma.rs              |  3 +++
> >  rust/kernel/error.rs            | 17 ++++++++++++-----
> >  rust/kernel/miscdevice.rs       |  2 +-
> >  rust/kernel/mm/virt.rs          |  1 +
> >  rust/kernel/pci.rs              |  3 ++-
> >  rust/kernel/platform.rs         |  2 +-
> >  rust/kernel/regulator.rs        |  5 +++--
> >  11 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> > index 4749fb6bffef..479c0ad2a572 100644
> > --- a/rust/kernel/auxiliary.rs
> > +++ b/rust/kernel/auxiliary.rs
> > @@ -43,6 +43,7 @@ unsafe fn register(
> >          to_result(unsafe {
> >              bindings::__auxiliary_driver_register(adrv.get(),
> > module.0, name.as_char_ptr()) })
> > +        .map(|_| ())
> >      }
> >
> >      unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
> > diff --git a/rust/kernel/block/mq/tag_set.rs
> > b/rust/kernel/block/mq/tag_set.rs index c3cf56d52bee..0e7883163000
> > 100644 --- a/rust/kernel/block/mq/tag_set.rs
> > +++ b/rust/kernel/block/mq/tag_set.rs
> > @@ -65,7 +65,7 @@ pub fn new(
> >                  // SAFETY: we do not move out of `tag_set`.
> >                  let tag_set: &mut Opaque<_> =3D unsafe {
> > Pin::get_unchecked_mut(tag_set) }; // SAFETY: `tag_set` is a
> > reference to an initialized `blk_mq_tag_set`.
> > -                error::to_result( unsafe {
> > bindings::blk_mq_alloc_tag_set(tag_set.get())})
> > +                error::to_result( unsafe {
> > bindings::blk_mq_alloc_tag_set(tag_set.get())}).map(|_| ()) }),
> >              _p: PhantomData,
> >          })
> > diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> > index be2dffbdb546..c3fa20ce229a 100644
> > --- a/rust/kernel/cpufreq.rs
> > +++ b/rust/kernel/cpufreq.rs
> > @@ -157,6 +157,7 @@ pub fn as_raw(&self) -> *mut
> > bindings::cpufreq_policy_data { pub fn generic_verify(&self) ->
> > Result { // SAFETY: By the type invariant, the pointer stored in
> > `self` is valid. to_result(unsafe {
> > bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
> > +            .map(|_| ())
> >      }
> >  }
> >
> > @@ -519,7 +520,7 @@ pub fn set_suspend_freq(&mut self, freq: Hertz)
> > -> &mut Self { #[inline]
> >      pub fn generic_suspend(&mut self) -> Result {
> >          // SAFETY: By the type invariant, the pointer stored in
> > `self` is valid.
> > -        to_result(unsafe {
> > bindings::cpufreq_generic_suspend(self.as_mut_ref()) })
> > +        to_result(unsafe {
> > bindings::cpufreq_generic_suspend(self.as_mut_ref()) }).map(|_| ())
> > }
> >
> >      /// Provides a wrapper to the generic get routine.
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index d04e3fcebafb..214cd9a0ebe0 100644
> > --- a/rust/kernel/devres.rs
> > +++ b/rust/kernel/devres.rs
> > @@ -328,6 +328,7 @@ fn register_foreign<P>(dev: &Device<Bound>,
> > data: P) -> Result // `ForeignOwnable` is released eventually.
> >          bindings::devm_add_action_or_reset(dev.as_raw(),
> > Some(callback::<P>), ptr.cast()) })
> > +    .map(|_| ())
> >  }
> >
> >  /// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data`
> > once `dev` is unbound. diff --git a/rust/kernel/dma.rs
> > b/rust/kernel/dma.rs index 68fe67624424..f614453ddb7d 100644
> > --- a/rust/kernel/dma.rs
> > +++ b/rust/kernel/dma.rs
> > @@ -34,6 +34,7 @@ unsafe fn dma_set_mask(&self, mask: DmaMask) ->
> > Result { // - The safety requirement of this function guarantees
> > that there are no concurrent calls //   to DMA allocation and
> > mapping primitives using this mask. to_result(unsafe {
> > bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })
> > +            .map(|_| ())
> >      }
> >
> >      /// Set up the device's DMA coherent addressing capabilities.
> > @@ -51,6 +52,7 @@ unsafe fn dma_set_coherent_mask(&self, mask:
> > DmaMask) -> Result { // - The safety requirement of this function
> > guarantees that there are no concurrent calls //   to DMA
> > allocation and mapping primitives using this mask. to_result(unsafe
> > { bindings::dma_set_coherent_mask(self.as_ref().as_raw(),
> > mask.value()) })
> > +            .map(|_| ())
> >      }
> >
> >      /// Set up the device's DMA addressing capabilities.
> > @@ -72,6 +74,7 @@ unsafe fn dma_set_mask_and_coherent(&self, mask:
> > DmaMask) -> Result { to_result(unsafe {
> >              bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(),
> > mask.value()) })
> > +        .map(|_| ())
> >      }
> >  }
> >
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index db14da976722..f76afa4b7ec1 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -378,12 +378,19 @@ fn from(e: core::convert::Infallible) ->
> > Error { pub type Result<T =3D (), E =3D Error> =3D
> > core::result::Result<T, E>;
> >
> >  /// Converts an integer as returned by a C kernel function to an
> > error if it's negative, and -/// `Ok(())` otherwise.
> > -pub fn to_result(err: crate::ffi::c_int) -> Result {
> > -    if err < 0 {
> > -        Err(Error::from_errno(err))
> > +/// returns the original value otherwise.
> > +pub fn to_result<T>(code: T) -> Result<T>
> > +where
> > +    T: Copy + TryInto<i32>,
> > +{
> > +    // Try casting into `i32`.
> > +    let casted: crate::ffi::c_int =3D code.try_into().unwrap_or(0);
> > +
> > +    if casted < 0 {
> > +        Err(Error::from_errno(casted))
> >      } else {
> > -        Ok(())
> > +        // Return the original input value.
> > +        Ok(code)
> >      }
> >  }
> >
> > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > index 6373fe183b27..22b72ae84c03 100644
> > --- a/rust/kernel/miscdevice.rs
> > +++ b/rust/kernel/miscdevice.rs
> > @@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl
> > PinInit<Self, Error> { // the destructor of this type deallocates
> > the memory. // INVARIANT: If this returns `Ok(())`, then the `slot`
> > will contain a registered // misc device.
> > -                to_result(unsafe { bindings::misc_register(slot) })
> > +                to_result(unsafe { bindings::misc_register(slot)
> > }).map(|_| ()) }),
> >              _t: PhantomData,
> >          })
> > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > index a1bfa4e19293..5494f96e91b0 100644
> > --- a/rust/kernel/mm/virt.rs
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -195,6 +195,7 @@ pub fn vm_insert_page(&self, address: usize,
> > page: &Page) -> Result { // SAFETY: By the type invariant of `Self`
> > caller has read access and has verified that // `VM_MIXEDMAP` is
> > set. By invariant on `Page` the page has order 0. to_result(unsafe
> > { bindings::vm_insert_page(self.as_ptr(), address, page.as_ptr()) })
> > +            .map(|_| ())
> >      }
> >  }
> >
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 887ee611b553..6e917752cb89 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -48,6 +48,7 @@ unsafe fn register(
> >          to_result(unsafe {
> >              bindings::__pci_register_driver(pdrv.get(), module.0,
> > name.as_char_ptr()) })
> > +        .map(|_| ())
> >      }
> >
> >      unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
> > @@ -437,7 +438,7 @@ impl Device<device::Core> {
> >      /// Enable memory resources for this device.
> >      pub fn enable_device_mem(&self) -> Result {
> >          // SAFETY: `self.as_raw` is guaranteed to be a pointer to
> > a valid `struct pci_dev`.
> > -        to_result(unsafe {
> > bindings::pci_enable_device_mem(self.as_raw()) })
> > +        to_result(unsafe {
> > bindings::pci_enable_device_mem(self.as_raw()) }).map(|_| ()) }
> >
> >      /// Enable bus-mastering for this device.
> > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > index 8f028c76f9fa..5a5561c7326e 100644
> > --- a/rust/kernel/platform.rs
> > +++ b/rust/kernel/platform.rs
> > @@ -54,7 +54,7 @@ unsafe fn register(
> >          }
> >
> >          // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > -        to_result(unsafe {
> > bindings::__platform_driver_register(pdrv.get(), module.0) })
> > +        to_result(unsafe {
> > bindings::__platform_driver_register(pdrv.get(), module.0)
> > }).map(|_| ()) }
> >
> >      unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
> > diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
> > index 65f3a125348f..e17ae6e9a990 100644
> > --- a/rust/kernel/regulator.rs
> > +++ b/rust/kernel/regulator.rs
> > @@ -261,6 +261,7 @@ pub fn set_voltage(&self, min_voltage: Voltage,
> > max_voltage: Voltage) -> Result max_voltage.as_microvolts(),
> >              )
> >          })
> > +        .map(|_| ())
> >      }
> >
> >      /// Gets the current voltage of the regulator.
> > @@ -291,12 +292,12 @@ fn get_internal(dev: &Device, name: &CStr) ->
> > Result<Regulator<T>> {
> >
> >      fn enable_internal(&mut self) -> Result {
> >          // SAFETY: Safe as per the type invariants of `Regulator`.
> > -        to_result(unsafe {
> > bindings::regulator_enable(self.inner.as_ptr()) })
> > +        to_result(unsafe {
> > bindings::regulator_enable(self.inner.as_ptr()) }).map(|_| ()) }
> >
> >      fn disable_internal(&mut self) -> Result {
> >          // SAFETY: Safe as per the type invariants of `Regulator`.
> > -        to_result(unsafe {
> > bindings::regulator_disable(self.inner.as_ptr()) })
> > +        to_result(unsafe {
> > bindings::regulator_disable(self.inner.as_ptr()) }).map(|_| ())
>=20
> IMO all of the new map calls in this patch should use the
>=20
> to_result(...)?
> Ok(())
>=20
> syntax.
>=20
> Alice


Agreed, will do it in v2.

-Onur

