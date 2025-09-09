Return-Path: <linux-kernel+bounces-808166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F747B4FB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A92A4413FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509E32C305;
	Tue,  9 Sep 2025 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtqwxQJ3"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91463218B0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757421389; cv=none; b=TLmnMb3p5XWx1C/kfuRLIzCSMvAljPwCSP9f53+gqGRYzPWCwC2byntOzdKlzfSvRcr1D6aDtVQE77milsvxAb8qPQ8D/pAraJCzoizUuUFV9v9G0rOtjaan297IVln/fsinYQ73lSl8YRM3k0Df/Ha/vizlAuBz48/vQyQrP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757421389; c=relaxed/simple;
	bh=HZClZgg8P8mVprLk8hPWAv50PfnziNXSVcNkzhwfpd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7Hg4lWy+0Gz9iZQwomyLL/mwIP4R2CHgbqRa3fSE/9qyFF3qtsmPonrWMUZv2OAVAJW0p9BkAy2hzgfQsT8BMt+mO26jzod6jCbLbuNhlSSnkiihejQ9bVml/PzUvzULSCmMJj0MJdsf945Mwaea3bOFYv5450LG4Zzr8nuhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtqwxQJ3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so3174397f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 05:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757421386; x=1758026186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuHm918GfIeEf1Ir04QAGsz9mtLn5P/sYnaZ6DvVfQQ=;
        b=vtqwxQJ3ycVIavlqRgzPASpG/7rQD+s16nU+aZmUluMzr1j+MC0+Rll9xlgZXQBA/E
         wn3TjZIWM4FGd5u+kMM4jvvKm9xGOc03RXqWzu+HG9MknKqsQLNnNJ6M1nQihLOQkaHu
         +vxXqKmjIRRHpitc0kXF1kmRktK3GIwjdLd4ijdYXE+ZleCLfMUk7LOYAgszXt2m4GFN
         wI1HcxB5A3mWw99LwZu8C0UpgmiU5VwoegSgNE34gkHWjJByVUcFCPMQFbBmbhklEvro
         yF6m+wUVuYFZFcslFecLdM9o+YnzMWMlZB1P39tHZdp/EVKt7oHV98cgReG83rfatqKD
         6tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757421386; x=1758026186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IuHm918GfIeEf1Ir04QAGsz9mtLn5P/sYnaZ6DvVfQQ=;
        b=N0C2PgwvfOQd1wJXkPjs+nfzbWN9ogGrJpINoWZwp5SYbNYtZXonTf4zJ9VS8SrMDo
         6rzyvuPNbi1JpkOAqTUSzw0bKg9lpnuJx7XmnuVPbxxFMwbRIbGfYDGm0COeMSo69T3J
         SLQr+JlcsbtTIfQdiIpy8G2FEXoqRBGS1D0pxk0jmfTijXrkcf6HLJ6azkHI9oMQifIH
         HzUPXWUOkLaiIMSVYydwDkYjqpW9UYP3rlnWAIgxZURl8S/SrLG/0lq/aIWExFoouoDb
         8fOKxRufSPSYWxCCDjKh9OhkR0Jt3c7r+Jv0HvKP8YElZqIUJZSOMg3W1ZE+cuGiwpYG
         IwWA==
X-Forwarded-Encrypted: i=1; AJvYcCUS3U7RQEbg/OKjj4dqjuQdV7kJJtPnZN6yOGSB1CMMZoGZlrwo/AudzAAlKhu+XghO0CmvqkD9ApXBE84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhh//iDqae0Dgke6DbKndJDy0KXBJVSRZzuj4MJzaek9wzCcL9
	qP+8VSA30NU7GykEiLm0DLQErJD2X4BvgZ9VmvbtHkx12LBHiNMUNTfXiIpFhTI7uF3ddIjkuw0
	6mfrV35Tv3huN4l43CVhm96CKNfYLo4X4Ji3QAKPt
X-Gm-Gg: ASbGnctgV8eegzffP143lNYBSxa+aXJKVHkvtLuoc5LjOBz2Bc9AOcDFfG18HsQcaDu
	8psuLpWHBv2wcDTGhuP5+ohowrwfps6LgKG+WKlmhcQX1IJqmAYcVI8LPKZsEY3h0l3wh0LPPXY
	s9QIv7VP0R6xA3nJ70CuvfUfSUSmXLs0JTTA0mF0K4GPTISsRKjCZiDZ32/JWQsDhgsAfz0JBpD
	Eoll3/cU+7tu89blYM9tAIHLOHe+T4x6kewCHGxvltfvWf/v1ndVjEFNYGQ4ftpfNcCK2RwrHC3
	Mv05eXrQqBLvGNRLZZ4L6Q==
X-Google-Smtp-Source: AGHT+IFCyHgVIRKsYxoy4Zt4SH9/2M4SuYouE+tZGOXEXB1baIe867sUA7Ohl/hWq8EQ34aVe92g3Fbem3U74J+8gY4=
X-Received: by 2002:a05:6000:22c3:b0:3d6:7ae1:af00 with SMTP id
 ffacd0b85a97d-3e641873f43mr9653157f8f.20.1757421385614; Tue, 09 Sep 2025
 05:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123258.29304-1-work@onurozkan.dev>
In-Reply-To: <20250909123258.29304-1-work@onurozkan.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 9 Sep 2025 14:36:13 +0200
X-Gm-Features: AS18NWCi_38LYtkaR8jEU9nhKwV1_eL_w_MepK-Pt_PgDQ9LoNWOyuUyjrutq2Y
Message-ID: <CAH5fLghVt6MKfiDkmd-5DMAKA=yXQzMu3GNHAqB+HRGhyJ0tqA@mail.gmail.com>
Subject: Re: [PATCH v1] rust: refactor `to_result` to return the original value
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel@sedlak.dev, dirk.behme@de.bosch.com, felipe_life@live.com, 
	tamird@gmail.com, dakr@kernel.org, tmgross@umich.edu, a.hindborg@kernel.org, 
	lossin@kernel.org, bjorn3_gh@protonmail.com, gary@garyguo.net, 
	boqun.feng@gmail.com, alex.gaynor@gmail.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:33=E2=80=AFPM Onur =C3=96zkan <work@onurozkan.dev>=
 wrote:
>
> Current `to_result` helper takes a `c_int` and returns `Ok(())` on
> success and this has some issues like:
>
>     - Callers lose the original return value and often have to store
>         it in a temporary variable before calling `to_result`.
>
>     - It only supports `c_int`, which makes callers to unnecessarily
>         cast when working with other types (e.g. `u16` in phy
>         abstractions). We even have some places that ignore to use
>         `to_result` helper because the input doesn't fit in `c_int`
>         (see [0]).
>
> [0]: https://lore.kernel.org/all/20250822080252.773d6f54@nimda.home/
>
> This patch changes `to_result` to be generic and also return the
> original value on success.
>
> So that the code that previously looked like:
>
>     let ret =3D unsafe { bindings::some_ffi_call() };
>     to_result(ret).map(|()| SomeType::new(ret))
>
> can now be written more directly as:
>
>     to_result(unsafe { bindings::some_ffi_call() })
>         .map(|ret| SomeType::new(ret))
>
> Similarly, code such as:
>
>     let res: isize =3D $some_ffi_call();
>     if res < 0 {
>         return Err(Error::from_errno(res as i32));
>     }
>
> can now be used with `to_result` as:
>
>     to_result($some_ffi_call())?;
>
> Existing call sites that only care about success/failure are updated
> to append `.map(|_| ())` to preserve their previous semantics. They
> can also use the equivalent pattern:
>
>     to_result($something)?;
>     Ok(())
>
> This patch only fixes the callers that broke after the changes on `to_res=
ult`.
> I haven't included all the improvements made possible by the new design s=
ince
> that could conflict with other ongoing patches [1]. Once this patch is ap=
proved
> and applied, I am planning to follow up with creating a "good first issue=
" on [2]
> for those additional changes.
>
> [1]: https://lore.kernel.org/rust-for-linux/?q=3Dto_result
> [2]: https://github.com/Rust-for-Linux/linux
>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089/topic/x=
/near/536374456
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/auxiliary.rs        |  1 +
>  rust/kernel/block/mq/tag_set.rs |  2 +-
>  rust/kernel/cpufreq.rs          |  3 ++-
>  rust/kernel/devres.rs           |  1 +
>  rust/kernel/dma.rs              |  3 +++
>  rust/kernel/error.rs            | 17 ++++++++++++-----
>  rust/kernel/miscdevice.rs       |  2 +-
>  rust/kernel/mm/virt.rs          |  1 +
>  rust/kernel/pci.rs              |  3 ++-
>  rust/kernel/platform.rs         |  2 +-
>  rust/kernel/regulator.rs        |  5 +++--
>  11 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 4749fb6bffef..479c0ad2a572 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -43,6 +43,7 @@ unsafe fn register(
>          to_result(unsafe {
>              bindings::__auxiliary_driver_register(adrv.get(), module.0, =
name.as_char_ptr())
>          })
> +        .map(|_| ())
>      }
>
>      unsafe fn unregister(adrv: &Opaque<Self::RegType>) {
> diff --git a/rust/kernel/block/mq/tag_set.rs b/rust/kernel/block/mq/tag_s=
et.rs
> index c3cf56d52bee..0e7883163000 100644
> --- a/rust/kernel/block/mq/tag_set.rs
> +++ b/rust/kernel/block/mq/tag_set.rs
> @@ -65,7 +65,7 @@ pub fn new(
>                  // SAFETY: we do not move out of `tag_set`.
>                  let tag_set: &mut Opaque<_> =3D unsafe { Pin::get_unchec=
ked_mut(tag_set) };
>                  // SAFETY: `tag_set` is a reference to an initialized `b=
lk_mq_tag_set`.
> -                error::to_result( unsafe { bindings::blk_mq_alloc_tag_se=
t(tag_set.get())})
> +                error::to_result( unsafe { bindings::blk_mq_alloc_tag_se=
t(tag_set.get())}).map(|_| ())
>              }),
>              _p: PhantomData,
>          })
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index be2dffbdb546..c3fa20ce229a 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -157,6 +157,7 @@ pub fn as_raw(&self) -> *mut bindings::cpufreq_policy=
_data {
>      pub fn generic_verify(&self) -> Result {
>          // SAFETY: By the type invariant, the pointer stored in `self` i=
s valid.
>          to_result(unsafe { bindings::cpufreq_generic_frequency_table_ver=
ify(self.as_raw()) })
> +            .map(|_| ())
>      }
>  }
>
> @@ -519,7 +520,7 @@ pub fn set_suspend_freq(&mut self, freq: Hertz) -> &m=
ut Self {
>      #[inline]
>      pub fn generic_suspend(&mut self) -> Result {
>          // SAFETY: By the type invariant, the pointer stored in `self` i=
s valid.
> -        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut=
_ref()) })
> +        to_result(unsafe { bindings::cpufreq_generic_suspend(self.as_mut=
_ref()) }).map(|_| ())
>      }
>
>      /// Provides a wrapper to the generic get routine.
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index d04e3fcebafb..214cd9a0ebe0 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -328,6 +328,7 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) =
-> Result
>          // `ForeignOwnable` is released eventually.
>          bindings::devm_add_action_or_reset(dev.as_raw(), Some(callback::=
<P>), ptr.cast())
>      })
> +    .map(|_| ())
>  }
>
>  /// Encapsulate `data` in a [`KBox`] and [`Drop::drop`] `data` once `dev=
` is unbound.
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 68fe67624424..f614453ddb7d 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -34,6 +34,7 @@ unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result =
{
>          // - The safety requirement of this function guarantees that the=
re are no concurrent calls
>          //   to DMA allocation and mapping primitives using this mask.
>          to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw()=
, mask.value()) })
> +            .map(|_| ())
>      }
>
>      /// Set up the device's DMA coherent addressing capabilities.
> @@ -51,6 +52,7 @@ unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -=
> Result {
>          // - The safety requirement of this function guarantees that the=
re are no concurrent calls
>          //   to DMA allocation and mapping primitives using this mask.
>          to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref()=
.as_raw(), mask.value()) })
> +            .map(|_| ())
>      }
>
>      /// Set up the device's DMA addressing capabilities.
> @@ -72,6 +74,7 @@ unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMas=
k) -> Result {
>          to_result(unsafe {
>              bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), =
mask.value())
>          })
> +        .map(|_| ())
>      }
>  }
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index db14da976722..f76afa4b7ec1 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -378,12 +378,19 @@ fn from(e: core::convert::Infallible) -> Error {
>  pub type Result<T =3D (), E =3D Error> =3D core::result::Result<T, E>;
>
>  /// Converts an integer as returned by a C kernel function to an error i=
f it's negative, and
> -/// `Ok(())` otherwise.
> -pub fn to_result(err: crate::ffi::c_int) -> Result {
> -    if err < 0 {
> -        Err(Error::from_errno(err))
> +/// returns the original value otherwise.
> +pub fn to_result<T>(code: T) -> Result<T>
> +where
> +    T: Copy + TryInto<i32>,
> +{
> +    // Try casting into `i32`.
> +    let casted: crate::ffi::c_int =3D code.try_into().unwrap_or(0);
> +
> +    if casted < 0 {
> +        Err(Error::from_errno(casted))
>      } else {
> -        Ok(())
> +        // Return the original input value.
> +        Ok(code)
>      }
>  }
>
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 6373fe183b27..22b72ae84c03 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -79,7 +79,7 @@ pub fn register(opts: MiscDeviceOptions) -> impl PinIni=
t<Self, Error> {
>                  // the destructor of this type deallocates the memory.
>                  // INVARIANT: If this returns `Ok(())`, then the `slot` =
will contain a registered
>                  // misc device.
> -                to_result(unsafe { bindings::misc_register(slot) })
> +                to_result(unsafe { bindings::misc_register(slot) }).map(=
|_| ())
>              }),
>              _t: PhantomData,
>          })
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index a1bfa4e19293..5494f96e91b0 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -195,6 +195,7 @@ pub fn vm_insert_page(&self, address: usize, page: &P=
age) -> Result {
>          // SAFETY: By the type invariant of `Self` caller has read acces=
s and has verified that
>          // `VM_MIXEDMAP` is set. By invariant on `Page` the page has ord=
er 0.
>          to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), addre=
ss, page.as_ptr()) })
> +            .map(|_| ())
>      }
>  }
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 887ee611b553..6e917752cb89 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -48,6 +48,7 @@ unsafe fn register(
>          to_result(unsafe {
>              bindings::__pci_register_driver(pdrv.get(), module.0, name.a=
s_char_ptr())
>          })
> +        .map(|_| ())
>      }
>
>      unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
> @@ -437,7 +438,7 @@ impl Device<device::Core> {
>      /// Enable memory resources for this device.
>      pub fn enable_device_mem(&self) -> Result {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> -        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })
> +        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) }).map(|_| ())
>      }
>
>      /// Enable bus-mastering for this device.
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 8f028c76f9fa..5a5561c7326e 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -54,7 +54,7 @@ unsafe fn register(
>          }
>
>          // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> -        to_result(unsafe { bindings::__platform_driver_register(pdrv.get=
(), module.0) })
> +        to_result(unsafe { bindings::__platform_driver_register(pdrv.get=
(), module.0) }).map(|_| ())
>      }
>
>      unsafe fn unregister(pdrv: &Opaque<Self::RegType>) {
> diff --git a/rust/kernel/regulator.rs b/rust/kernel/regulator.rs
> index 65f3a125348f..e17ae6e9a990 100644
> --- a/rust/kernel/regulator.rs
> +++ b/rust/kernel/regulator.rs
> @@ -261,6 +261,7 @@ pub fn set_voltage(&self, min_voltage: Voltage, max_v=
oltage: Voltage) -> Result
>                  max_voltage.as_microvolts(),
>              )
>          })
> +        .map(|_| ())
>      }
>
>      /// Gets the current voltage of the regulator.
> @@ -291,12 +292,12 @@ fn get_internal(dev: &Device, name: &CStr) -> Resul=
t<Regulator<T>> {
>
>      fn enable_internal(&mut self) -> Result {
>          // SAFETY: Safe as per the type invariants of `Regulator`.
> -        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr(=
)) })
> +        to_result(unsafe { bindings::regulator_enable(self.inner.as_ptr(=
)) }).map(|_| ())
>      }
>
>      fn disable_internal(&mut self) -> Result {
>          // SAFETY: Safe as per the type invariants of `Regulator`.
> -        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr=
()) })
> +        to_result(unsafe { bindings::regulator_disable(self.inner.as_ptr=
()) }).map(|_| ())

IMO all of the new map calls in this patch should use the

to_result(...)?
Ok(())

syntax.

Alice

