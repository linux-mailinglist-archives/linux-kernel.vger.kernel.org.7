Return-Path: <linux-kernel+bounces-744693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8002B10FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D601B3A7757
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D562D839F;
	Thu, 24 Jul 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwtCcsFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1E2F29;
	Thu, 24 Jul 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375600; cv=none; b=YEm9YP5uCdFZ5Dvr5NXk0E+4cYtHR+/imOV9KVPKEsjOBMyl4h1xagfsOFRIIeQDdSFtRu2x06hVoNX7IqTXJIlXARY6s/8nrKuEmAVJ4f0DyKitPiMnP9DB40/fBn1Ai2l+cGGNBfMCGnYTZ+hytwhBqTdzyNwJ7qmf1UDKcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375600; c=relaxed/simple;
	bh=K+AqzGtIgWKIryvlBVWOeLjTn5QGBwo090CF+oQ5Bis=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Fss9rvIV21ViRqkockfnrcOu/kLFwaV8jupF+3vL+L4id6zy6nUFyggPnbLsf5uaDcGYJfV9OOnAGxL3H6aM+8/24wKNZwuSZDAgb2Z4rdxJqMSvg+Hu2Sm3ryn3kG6YajyiYRFdxYrDHUaaMS1AF7Z2vihaPUwHrenjfTbZL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwtCcsFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41371C4CEED;
	Thu, 24 Jul 2025 16:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375599;
	bh=K+AqzGtIgWKIryvlBVWOeLjTn5QGBwo090CF+oQ5Bis=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=lwtCcsFfgKVktepqt9A5avf3QWtNg3LJcjjeoVUgp2HK6qqpBQ7FlcyYE7BdDhoUV
	 fWd+AIFa9uPBowc+YWVEj4SMzcN09q8Bc+TcPejQ/RXMpO7xvQTU6z9sR9dHDFsoOL
	 eGRjAJJq3+67tTnePxnWUXcj5WTBxJ+rOpQ74e96LO17wAqwAHARqeuSd9EAPtYPdB
	 mzCHa/PAcpQnotT/iOcVv+41M4+xqBKvGKmy4D0tQgB5ixBg1Iyl0U/7FVEokt/iHm
	 Q6Dew07gM5PD7sIc1otHDgo9qfQP2Nyl9cfYfmDsqzJmscoW/2J20AyfT8XRJUwn6b
	 b4v0urc6a4kcA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Jul 2025 18:46:35 +0200
Message-Id: <DBKFRWMPHM1I.2V12KE06FKNCO@kernel.org>
Subject: Re: [PATCH v2 2/3] device: rust: expand documentation for Device
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250722150110.23565-1-dakr@kernel.org>
 <20250722150110.23565-3-dakr@kernel.org> <aIHa31DiaRvNK1Kb@google.com>
In-Reply-To: <aIHa31DiaRvNK1Kb@google.com>

On Thu Jul 24, 2025 at 9:03 AM CEST, Alice Ryhl wrote:
> On Tue, Jul 22, 2025 at 05:00:00PM +0200, Danilo Krummrich wrote:
>> The documentation for the generic Device type is outdated and deserves
>> much more detail.
>>=20
>> Hence, expand the documentation and cover topics such as device types,
>> device contexts, as well as information on how to use the generic device
>> infrastructure to implement bus and class specific device types.
>>=20
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> A few nits below, but in general looks good.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> -/// This structure represents the Rust abstraction for a C `struct devi=
ce`. This implementation
>> -/// abstracts the usage of an already existing C `struct device` within=
 Rust code that we get
>> -/// passed from the C side.
>> +/// This structure represents the Rust abstraction for a C `struct devi=
ce`. A [`Device`] can either
>> +/// exist as temporary reference (see also [`Device::from_raw`]), which=
 is only valid within a
>> +/// certain scope or as [`ARef<Device>`], owning a dedicated reference =
count.
>
> Doesn't there need to be a comma between "scope" and "or"?
>
> It's possible that I'm confusing the danish and english comma rules, but
> I got confused when reading this.

No, I think you're right.

>> +/// # Implementing Class Devices
>> +///
>> +/// Class device implementations require less infrastructure and depend=
 slightly more on the
>> +/// specific subsystem.
>> +///
>> +/// An example implementation for a class device could look like this.
>> +///
>> +/// ```ignore
>> +/// #[repr(C)]
>> +/// #[pin_data]
>> +/// pub struct Device<T: class::Driver> {
>> +///     dev: Opaque<bindings::class_device_type>,
>> +///     #[pin]
>> +///     data: T::Data,
>
> Should the `dev` field not also be pinned?

I think we should just remove any pin stuff from the example, that's an
implementation detail.

--

In case you're curious, the reason it's there is because that's how drm::De=
vice
is defined. However, drm::Device doesn't need the pin stuff either, but I f=
orgot
to remove it. See drm::Device::new():

    /// Create a new `drm::Device` for a `drm::Driver`.
    pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) ->=
 Result<ARef<Self>> {
        // SAFETY:
        // - `VTABLE`, as a `const` is pinned to the read-only section of t=
he compilation,
        // - `dev` is valid by its type invarants,
        let raw_drm: *mut Self =3D unsafe {
            bindings::__drm_dev_alloc(
                dev.as_raw(),
                &Self::VTABLE,
                mem::size_of::<Self>(),
                mem::offset_of!(Self, dev),
            )
        }
        .cast();
        let raw_drm =3D NonNull::new(from_err_ptr(raw_drm)?).ok_or(ENOMEM)?=
;

        // SAFETY: `raw_drm` is a valid pointer to `Self`.
        let raw_data =3D unsafe { ptr::addr_of_mut!((*raw_drm.as_ptr()).dat=
a) };

        // SAFETY:
        // - `raw_data` is a valid pointer to uninitialized memory.
        // - `raw_data` will not move until it is dropped.
        unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
            // SAFETY: `__drm_dev_alloc()` was successful, hence `raw_drm` =
must be valid and the
            // refcount must be non-zero.
            unsafe { bindings::drm_dev_put(ptr::addr_of_mut!((*raw_drm.as_p=
tr()).dev).cast()) };
        })?;

        // SAFETY: The reference count is one, and now we take ownership of=
 that reference as a
        // `drm::Device`.
        Ok(unsafe { ARef::from_raw(raw_drm) })
    }

While we use data.__pinned_init(), I don't think the drm::Device needs any =
of
the pin macros.

- Danilo

