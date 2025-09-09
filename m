Return-Path: <linux-kernel+bounces-808209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5077B4FBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605C33A34E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F7C33CEAD;
	Tue,  9 Sep 2025 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iJsD0k5r"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76713322DC3;
	Tue,  9 Sep 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422439; cv=pass; b=C2OCKYAgLLTbjpMjow/j7pG360uIjgaTq2csGjL/QpMy0QVsGSupsGVjG2ersm6RKmhXmY7xsaEsHjI7ldqFh563ZxEVLPMtxbUidXW8K79bu2426wkRaqSPb3txN60xnyags9pBBLIB86lpUXR6EOIlm7vcNE7ANm7KGBMWusU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422439; c=relaxed/simple;
	bh=a6jQOiCAOPe6rlNBJ8j4Uf38xgjOlq+AlrhTpp+kCnw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=digCE3fDmwvIfZMToMKVkmpYievrjTkVZD4j4C1HCyH92824+guCp/0D2Ok8nVZEuYCuzBnKmg5y5E7TaHeSAt3CKv1wS+AdTLjuk39zyNc0qQ8gvuRmW0FJ3/tixB3shT/3nMuMwNPzTabkvAKERK4Mpi2ih0If4+9t4qhOCWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iJsD0k5r; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757422409; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XgzqVwkENw5PHT9eDtRT97h7oOu7pmtD3K31rKt5TRXiRYowBlZu6e8GVT7BdDVyzK8flmb5l+nCBf0athYpk54mWTEAyXWv3UAps2agavI3ISZyhuEYj1UjYn/fPIQsQ9c6XxVfcos4FhC0JcjS17n5bhbLIjsjtl1JJDIwcu8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757422409; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kV/Uuxmi6nUmkUWJolvNWX/gm/y+1/+6jAnxNEhfUv4=; 
	b=mINoTafy39zUJwnwlE3GQ7qEtm3wEw2ML+UGhHhYfbwudNR16jMqA/KQNxyINfX8PUv64n5vmVWT2HGNqkt/5r6k/sDfJXt/ivY4qlnKwk93Lpk0XO4Agz3+EyfDyZvz5LkLKdiBQi6F3AdNs8UpSYn1g3ue1SI7dw2XB4zKviE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757422409;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=kV/Uuxmi6nUmkUWJolvNWX/gm/y+1/+6jAnxNEhfUv4=;
	b=iJsD0k5rFYRdiUP7uUh1YbRtulFdgeyvzJimjxianZYMaxlvTDw/JmrfFHCFxTnC
	1qXHcpl7izDoz9HIf4IoTXuu9jGhrzq+GoNt4T7RfNvPrfAmSFkvxEhLhf1ZU61vWT7
	g5y2/Ai98weZusIZatKyARO+bhnINm/9KW+XB9gI=
Received: by mx.zohomail.com with SMTPS id 1757422407175139.5274334997598;
	Tue, 9 Sep 2025 05:53:27 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v1] rust: refactor `to_result` to return the original
 value
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLghVt6MKfiDkmd-5DMAKA=yXQzMu3GNHAqB+HRGhyJ0tqA@mail.gmail.com>
Date: Tue, 9 Sep 2025 09:53:09 -0300
Cc: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 daniel@sedlak.dev,
 dirk.behme@de.bosch.com,
 felipe_life@live.com,
 tamird@gmail.com,
 dakr@kernel.org,
 tmgross@umich.edu,
 a.hindborg@kernel.org,
 lossin@kernel.org,
 bjorn3_gh@protonmail.com,
 gary@garyguo.net,
 boqun.feng@gmail.com,
 alex.gaynor@gmail.com,
 ojeda@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C424F7A6-524C-4A37-8513-B3BA2178A709@collabora.com>
References: <20250909123258.29304-1-work@onurozkan.dev>
 <CAH5fLghVt6MKfiDkmd-5DMAKA=yXQzMu3GNHAqB+HRGhyJ0tqA@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 9 Sep 2025, at 09:36, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Tue, Sep 9, 2025 at 2:33=E2=80=AFPM Onur =C3=96zkan =
<work@onurozkan.dev> wrote:
>>=20
>> Current `to_result` helper takes a `c_int` and returns `Ok(())` on
>> success and this has some issues like:
>>=20
>>    - Callers lose the original return value and often have to store
>>        it in a temporary variable before calling `to_result`.
>>=20
>>    - It only supports `c_int`, which makes callers to unnecessarily
>>        cast when working with other types (e.g. `u16` in phy
>>        abstractions). We even have some places that ignore to use
>>        `to_result` helper because the input doesn't fit in `c_int`
>>        (see [0]).
>>=20
>> [0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
>>=20
>> This patch changes `to_result` to be generic and also return the
>> original value on success.
>>=20
>> So that the code that previously looked like:
>>=20
>>    let ret =3D unsafe { bindings::some_ffi_call() };
>>    to_result(ret).map(|()| SomeType::new(ret))
>>=20
>> can now be written more directly as:
>>=20
>>    to_result(unsafe { bindings::some_ffi_call() })
>>        .map(|ret| SomeType::new(ret))
>>=20
>> Similarly, code such as:
>>=20
>>    let res: isize =3D $some_ffi_call();
>>    if res < 0 {
>>        return Err(Error::from_errno(res as i32));
>>    }
>>=20
>> can now be used with `to_result` as:
>>=20
>>    to_result($some_ffi_call())?;
>>=20
>> Existing call sites that only care about success/failure are updated
>> to append `.map(|_| ())` to preserve their previous semantics. They
>> can also use the equivalent pattern:
>>=20
>>    to_result($something)?;
>>    Ok(())
>>=20
>> This patch only fixes the callers that broke after the changes on =
`to_result`.

What exactly broke for regulator.rs <http://regulator.rs/>? It works =
just fine.

>> I haven't included all the improvements made possible by the new =
design since
>> that could conflict with other ongoing patches [1]. Once this patch =
is approved
>> and applied, I am planning to follow up with creating a "good first =
issue" on [2]
>> for those additional changes.
>>=20
>> [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
>> [2]: https://github.com/Rust-for-Linux/linux
>>=20
>> Link: =
https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x/near/5=
36374456
>> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
>> ---
>> rust/kernel/auxiliary.rs        |  1 +
>> rust/kernel/block/mq/tag_set.rs |  2 +-
>> rust/kernel/cpufreq.rs          |  3 ++-
>> rust/kernel/devres.rs           |  1 +
>> rust/kernel/dma.rs              |  3 +++
>> rust/kernel/error.rs            | 17 ++++++++++++-----
>> rust/kernel/miscdevice.rs       |  2 +-
>> rust/kernel/mm/virt.rs          |  1 +
>> rust/kernel/pci.rs              |  3 ++-
>> rust/kernel/platform.rs         |  2 +-
>> rust/kernel/regulator.rs        |  5 +++--
>> 11 files changed, 28 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
>> index 4749fb6bffef..479c0ad2a572 100644
>> --- a/rust/kernel/auxiliary.rs
>> +++ b/rust/kernel/auxiliary.rs
>> @@ -43,6 +43,7 @@ unsafe fn register(
>>         to_result(unsafe {
>>             bindings::__auxiliary_driver_register(adrv.get(), =
module.0, name.as_char_ptr())
>>         })
>> +        .map(|_| ())
>>     }
>>=20
>>     unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
>> diff --git a/rust/kernel/block/mq/tag_set.rs =
b/rust/kernel/block/mq/tag_set.rs
>> index c3cf56d52bee..0e7883163000 100644
>> --- a/rust/kernel/block/mq/tag_set.rs
>> +++ b/rust/kernel/block/mq/tag_set.rs
>> @@ -65,7 +65,7 @@ pub fn new(
>>                 // SAFETY: we do not move out of `tag_set`.
>>                 let tag_set: &mut Opaque<_> =3D unsafe { =
Pin::get_unchecked_mut(tag_set) };
>>                 // SAFETY: `tag_set` is a reference to an initialized =
`blk_mq_tag_set`.
>> -                error::to_result( unsafe { =
bindings::blk_mq_alloc_tag_set(tag_set.get())})
>> +                error::to_result( unsafe { =
bindings::blk_mq_alloc_tag_set(tag_set.get())}).map(|_| ())
>>             }),
>>             _p: PhantomData,
>>         })
>> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
>> index be2dffbdb546..c3fa20ce229a 100644
>> --- a/rust/kernel/cpufreq.rs
>> +++ b/rust/kernel/cpufreq.rs
>> @@ -157,6 +157,7 @@ pub fn as_raw(&self) -> *mut =
bindings::cpufreq_policy_data {
>>     pub fn generic_verify(&self) -> Result {
>>         // SAFETY: By the type invariant, the pointer stored in =
`self` is valid.
>>         to_result(unsafe { =
bindings::cpufreq_generic_frequency_table_verify(self.as_raw()) })
>> +            .map(|_| ())
>>     }
>> }
>>=20
>> @@ -519,7 +520,7 @@ pub fn set_suspend_freq(&mut self, freq: Hertz) =
-> &mut Self {
>>     #[inline]
>>     pub fn generic_suspend(&mut self) -> Result {
>>         // SAFETY: By the type invariant, the pointer stored in =
`self` is valid.
>> -        to_result(unsafe { =
bindings::cpufreq_generic_suspend(self.as_mut_ref()) })
>> +        to_result(unsafe { =
bindings::cpufreq_generic_suspend(self.as_mut_ref()) }).map(|_| ())
>>     }
>>=20
>>     /// Provides a wrapper to the generic get routine.
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index d04e3fcebafb..214cd9a0ebe0 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -328,6 +328,7 @@ fn register_foreign<P>(dev: &Device<Bound>, data: =
P) -> Result
>>         // `ForeignOwnable` is released eventually.
>>         bindings::devm_add_action_or_reset(dev.as_raw(), =
Some(callback::<P>), ptr.cast())
>>     })
>> +    .map(|_| ())
>> }
>>=20
>> /// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data` once =
`dev` is unbound.
>> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
>> index 68fe67624424..f614453ddb7d 100644
>> --- a/rust/kernel/dma.rs
>> +++ b/rust/kernel/dma.rs
>> @@ -34,6 +34,7 @@ unsafe fn dma_set_mask(&self, mask: DmaMask) -> =
Result {
>>         // - The safety requirement of this function guarantees that =
there are no concurrent calls
>>         //   to DMA allocation and mapping primitives using this =
mask.
>>         to_result(unsafe { =
bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })
>> +            .map(|_| ())
>>     }
>>=20
>>     /// Set up the device's DMA coherent addressing capabilities.
>> @@ -51,6 +52,7 @@ unsafe fn dma_set_coherent_mask(&self, mask: =
DmaMask) -> Result {
>>         // - The safety requirement of this function guarantees that =
there are no concurrent calls
>>         //   to DMA allocation and mapping primitives using this =
mask.
>>         to_result(unsafe { =
bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask.value()) })
>> +            .map(|_| ())
>>     }
>>=20
>>     /// Set up the device's DMA addressing capabilities.
>> @@ -72,6 +74,7 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: =
DmaMask) -> Result {
>>         to_result(unsafe {
>>             =
bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), =
mask.value())
>>         })
>> +        .map(|_| ())
>>     }
>> }
>>=20
>> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
>> index db14da976722..f76afa4b7ec1 100644
>> --- a/rust/kernel/error.rs
>> +++ b/rust/kernel/error.rs
>> @@ -378,12 +378,19 @@ fn from(e: core::convert::Infallible) -> Error =
{
>> pub type Result<T =3D (), E =3D Error> =3D core::result::Result<T, =
E>;
>>=20
>> /// Converts an integer as returned by a C kernel function to an =
error if it's negative, and
>> -/// `Ok(())` otherwise.
>> -pub fn to_result(err: crate::ffi::c_int) -> Result {
>> -    if err < 0 {
>> -        Err(Error::from_errno(err))
>> +/// returns the original value otherwise.
>> +pub fn to_result<T>(code: T) -> Result<T>
>> +where
>> +    T: Copy + TryInto<i32>,
>> +{
>> +    // Try casting into `i32`.
>> +    let casted: crate::ffi::c_int =3D code.try_into().unwrap_or(0);
>> +
>> +    if casted < 0 {
>> +        Err(Error::from_errno(casted))
>>     } else {
>> -        Ok(())
>> +        // Return the original input value.
>> +        Ok(code)
>>     }
>> }
>>=20
>> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
>> index 6373fe183b27..22b72ae84c03 100644
>> --- a/rust/kernel/miscdevice.rs
>> +++ b/rust/kernel/miscdevice.rs
>> @@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl =
PinInit<Self, Error> {
>>                 // the destructor of this type deallocates the =
memory.
>>                 // INVARIANT: If this returns `Ok(())`, then the =
`slot` will contain a registered
>>                 // misc device.
>> -                to_result(unsafe { bindings::misc_register(slot) })
>> +                to_result(unsafe { bindings::misc_register(slot) =
}).map(|_| ())
>>             }),
>>             _t: PhantomData,
>>         })
>> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
>> index a1bfa4e19293..5494f96e91b0 100644
>> --- a/rust/kernel/mm/virt.rs
>> +++ b/rust/kernel/mm/virt.rs
>> @@ -195,6 +195,7 @@ pub fn vm_insert_page(&self, address: usize, =
page: &Page) -> Result {
>>         // SAFETY: By the type invariant of `Self` caller has read =
access and has verified that
>>         // `VM_MIXEDMAP` is set. By invariant on `Page` the page has =
order 0.
>>         to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), =
address, page.as_ptr()) })
>> +            .map(|_| ())
>>     }
>> }
>>=20
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 887ee611b553..6e917752cb89 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -48,6 +48,7 @@ unsafe fn register(
>>         to_result(unsafe {
>>             bindings::__pci_register_driver(pdrv.get(), module.0, =
name.as_char_ptr())
>>         })
>> +        .map(|_| ())
>>     }
>>=20
>>     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
>> @@ -437,7 +438,7 @@ impl Device<device::Core> {
>>     /// Enable memory resources for this device.
>>     pub fn enable_device_mem(&self) -> Result {
>>         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a =
valid `struct pci_dev`.
>> -        to_result(unsafe { =
bindings::pci_enable_device_mem(self.as_raw()) })
>> +        to_result(unsafe { =
bindings::pci_enable_device_mem(self.as_raw()) }).map(|_| ())
>>     }
>>=20
>>     /// Enable bus-mastering for this device.
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index 8f028c76f9fa..5a5561c7326e 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -54,7 +54,7 @@ unsafe fn register(
>>         }
>>=20
>>         // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
>> -        to_result(unsafe { =
bindings::__platform_driver_register(pdrv.get(), module.0) })
>> +        to_result(unsafe { =
bindings::__platform_driver_register(pdrv.get(), module.0) }).map(|_| =
())
>>     }
>>=20
>>     unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
>> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
>> index 65f3a125348f..e17ae6e9a990 100644
>> --- a/rust/kernel/regulator.rs
>> +++ b/rust/kernel/regulator.rs
>> @@ -261,6 +261,7 @@ pub fn set_voltage(&self, min_voltage: Voltage, =
max_voltage: Voltage) -> Result
>>                 max_voltage.as_microvolts(),
>>             )
>>         })
>> +        .map(|_| ())
>>     }
>>=20
>>     /// Gets the current voltage of the regulator.
>> @@ -291,12 +292,12 @@ fn get_internal(dev: &Device, name: &CStr) -> =
Result<Regulator<T>> {
>>=20
>>     fn enable_internal(&mut self) -> Result {
>>         // SAFETY: Safe as per the type invariants of `Regulator`.
>> -        to_result(unsafe { =
bindings::regulator_enable(self.inner.as_ptr()) })
>> +        to_result(unsafe { =
bindings::regulator_enable(self.inner.as_ptr()) }).map(|_| ())
>>     }
>>=20
>>     fn disable_internal(&mut self) -> Result {
>>         // SAFETY: Safe as per the type invariants of `Regulator`.
>> -        to_result(unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) })
>> +        to_result(unsafe { =
bindings::regulator_disable(self.inner.as_ptr()) }).map(|_| ())
>=20
> IMO all of the new map calls in this patch should use the
>=20
> to_result(...)?
> Ok(())
>=20
> syntax.
>=20
> Alice

FYI: A similar patch was already applied by Mark to regulator.rs, but =
now I see
the same code being submitted a) under a different patch, with its own =
version
(v1) and b) together as a single patch touching a lot of code at once.

I am a bit confused. Can you make sure that all code touching =
regulator.rs is
based on the regulator tree?=20

=E2=80=94 Daniel



