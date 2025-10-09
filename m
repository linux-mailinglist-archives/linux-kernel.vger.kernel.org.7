Return-Path: <linux-kernel+bounces-846678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F71EBC8B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AA53B4B08
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF52DAFBD;
	Thu,  9 Oct 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHiXdRUB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5917A30A;
	Thu,  9 Oct 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760008607; cv=none; b=gAEKdGoMNt2lkCNX+7N7ZRkFm/gCFCfUVzCm2o/5NGSF8XoDO/RsOXkg4SrTFe3DZxWBlSyqYhCCqFa73pMw32Gq9X/EvNEtbkIP9bTS89E4eoQHxS6geHUMN2Ugp/nGJotAtoFmTEAe9nHQoLRfYMFc/bBwfNjNZlbisMCgGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760008607; c=relaxed/simple;
	bh=NvnFH5fFMQlfkVMuPWti/OYzM0/+PyGHmbs5QNfgrNI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=RJ7qLCIDr//rv++7kA3gV55CMF+aAo8m6SpafGOftdKS1SBPHnnyd9/T+3POcHl9XJZnXLxCjFuewW2AI3tkmcZIqrdppvAv9oImRRaSw+9jaN9j2v4DXAwc07TRFq2V1IUfIjc/NkYJGfFnxyeNW/tvJG8atsMPkHJ3Q9n7cG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHiXdRUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B916C4CEE7;
	Thu,  9 Oct 2025 11:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760008606;
	bh=NvnFH5fFMQlfkVMuPWti/OYzM0/+PyGHmbs5QNfgrNI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=FHiXdRUB//Rz1OI/dzkHif7nW0zmpkYr0fQ8K87690DYj2qDidMcGlWTajyGVus5n
	 53NHp8MmzaP51UjX0UKF4GBs8O4vCb3IT1pp/9jYFmHfeiHHcEv14Vk9SCB4D00QqE
	 FHEhyFcvBOdhzjN5gOdLEyElZ9gZCcLCefEXhX2GpUPq/iceSKw/LWrkXsYhuF/bzp
	 OIXFpXITbZ/1bcr+ZOEXIdPE5w8hyRx9LMDWCxMaRi9L+QWvAY0swMHtuZ/r4tH+Bh
	 /REu+bue1A5QNeyg/MV2+MJCBdDqL6R4nhqLqLdT4GsKpXpYfZe/NEM/Z0b/Da14r5
	 1MXW8zJk7JOlg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 13:16:39 +0200
Message-Id: <DDDQZ8LM2OGP.VSEG03ZE0K04@kernel.org>
Subject: Re: [PATCH v6 4/5] rust: Move register and bitfield macros out of
 Nova
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <acourbot@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <joel@joelfernandes.org>, "Elle Rhumsaa" <elle@weathered-steel.dev>, "Yury
 Norov" <yury.norov@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Andrea Righi" <arighi@nvidia.com>,
 <nouveau@lists.freedesktop.org>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <20251003154748.1687160-5-joelagnelf@nvidia.com>
 <5a5bd549-f5b7-41ec-b493-bda427d1218f@de.bosch.com>
In-Reply-To: <5a5bd549-f5b7-41ec-b493-bda427d1218f@de.bosch.com>

On Thu Oct 9, 2025 at 8:59 AM CEST, Dirk Behme wrote:
> Assuming that register.rs is supposed to become the "generic" way to=20
> access hardware registers I started to have a look to it. Some weeks=20
> back testing interrupts I used some quite simple timer with 4 registers=
=20
> [1]. Now, thinking about converting it to register!() I have three=20
> understanding / usage questions:
>
> * At the moment register!() is for 32-bit registers, only? So it can't=20
> be used for my example having 8-bit and 16-bit registers as well?

Yes, currently the register!() macro always generates a 32-bit register typ=
e
(mainly because nova-core did not need anything else). However, this will o=
f
course be generalized (which should be pretty straight forward).

Having a brief look at the TMU datasheet it looks like you should be able t=
o
treat TSTR and TCR as 32-bit registers without any issues for testing the
register!() macro today. I.e. you can just define it as:

	register!(TSTR @ 0x04, "Timer Start Register" {
	    2:2    str2 as bool, "Specifies whether TCNT2 is operated or stopped."=
;
	    1:1    str1 as bool, "Specifies whether TCNT1 is operated or stopped."=
;
	    0:0    str0 as bool, "Specifies whether TCNT0 is operated or stopped."=
;
	});

Same for TCR.

> * In my example I used io.try_write*() and io.try_read*() for the=20
> register access. What is the relationship between these and the=20
> register!() accessors (e.g. from the examples BOOT_0::read(&bar);)? Will=
=20
> both stay? When to use which?

The try_*() variants should only be used of the offset of the register is n=
ot
known at compile time.

If it is known at compile time (such as in your case) you should use the
infallible variants that perform a range check at compile time.

For this to work you need to specify the minimum MMIO range your driver exp=
ects,
i.e. instead of

	let iomem =3D Arc::pin_init(request.iomap()?, GFP_KERNEL)?;

you call

	let iomem =3D Arc::pin_init(request.iomap_sized::<TMU_MMIO_SIZE>()?, GFP_K=
ERNEL)?;

where TMU_MMIO_SIZE is the minimum MMIO region size your driver is able to
operate on. In your case this would be 0x12, given that TCR has a width of
16-bit. However, if you treat it as 32-bit register it would be 0x14.

Even without the register!() macro this would be a huge improvement. For
instance, your IRQ handler from [1] can do

	let tcr =3D io.read16_relaxed(TCR);
	if tcr & (0x1 << 8) !=3D 0 {
	    io.write16_relaxed(tcr & !(0x1 << 8), TCR);
	}

instead of

	let tcr =3D io.try_read16_relaxed(TCR).unwrap_or(0);
	if tcr & (0x1 << 8) !=3D 0 {
	    io.try_write16_relaxed(tcr & !(0x1 << 8), TCR).unwrap_or(());
	}

And with the register macro it becomes

	let tcr =3D TCR::read(io);
	if tcr.underflow() {
		tcr.set_underflow(false);
		tcr.write(io);
	}

Note that you can also extend the generated TCR type accordingly, for insta=
nce:

	impl TCR {
	    fn handle_underflow<const SIZE: usize, T>(io: &T)
	    where
	        T: Deref<Target =3D Io<SIZE>>,
	    {
	        let this =3D Self::read(io);
	        if this.underflow() {
	            this.set_underflow(false);
	            this.write(io);
	        }
	    }
	}

and then from your IRQ handler you can just call

	TCR::handle_underflow();

> Note: Due to the file move obviously not the full content of the "new"=20
> file register.rs is shown in this patch. Therefore, let me try it this=20
> way, citing from register.rs:
>
> -- cut --
> ...
> /// This defines a `BOOT_0` type which can be read or written from=20
> offset `0x100` of an `Io`
> /// region
> ....
> /// ```ignore
> /// // Read from the register's defined offset (0x100).
> /// let boot0 =3D BOOT_0::read(&bar);
> -- cut --
>
> * What is "&bar" in this example? Is it the `Io` region the explanation=
=20
> talks about?

Yes, it's the I/O backend (a pci::Bar in this case). However, we should pro=
bably
use a more generic name in the examples.

> [1]=20
> https://lore.kernel.org/rust-for-linux/dd34e5f4-5027-4096-9f32-129c8a067d=
0a@de.bosch.com/
>
> The registers:
>
> const TSTR: usize =3D  0x4; //  8 Bit register
> const TCOR: usize =3D  0x8; // 32 Bit register
> const TCNT: usize =3D  0xC; // 32 Bit register
> const TCR:  usize =3D 0x10; // 16 Bit register

