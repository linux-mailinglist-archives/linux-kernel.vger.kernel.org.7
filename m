Return-Path: <linux-kernel+bounces-737767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A2B0B054
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 15:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39DA7B5EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246828726B;
	Sat, 19 Jul 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdrJmJm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533441B394F;
	Sat, 19 Jul 2025 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752933126; cv=none; b=nCMsw1QQy+5bhNii9FyiJAwoW7c9l574NZBL/a+8BSb0Ai7aS2fOZgQXuSpTCmgZFhimm5q/OPlW5w1cdjF/G1YnUE4l3GqcXU3SaJ9Xv+HpiMaMTNz08gaNJr6RctpSngr+DWNS90VywRwyOrxhoTzgc0YvO1BqibbjbB7ijCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752933126; c=relaxed/simple;
	bh=Lpe/d4LJQNCz+MZxtwqRwKJ3NL/20iK0n3vUpy4+FE0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OOF6N+zW5vH4P4u9NVdYW8/vQuOvndGrnt76+k1gi2iIqetbS0jVyjit/yma+G5okaHz8pIjXu5ES8VXSsf68LKLroqVUaCXcTIWZ04rADHrWVimbAFWpwcohG49lWBJD6mtovcrlOHD4/FMBt7SHtVTTYMQATiDg40Ihuye+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdrJmJm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C9FC4CEE3;
	Sat, 19 Jul 2025 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752933125;
	bh=Lpe/d4LJQNCz+MZxtwqRwKJ3NL/20iK0n3vUpy4+FE0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CdrJmJm3b7aoH0GPhMkEiMhoHXmqKh9vc8iCv6Sol2zyOlgYUO0w3XMMUYJpkwSdL
	 IbVGhcgUmKdpd1MqddE26uk2soa18RHKylX1wh71O1BkzCSHe/DtsRm4OKHNTiUeVE
	 4L/XtKcAvvSGNiZ/GWWswmUzeotgBEDxz6pTlGc/BOHgbC4hJ6rPv/LmanhWxj9sLj
	 NgFs00SrcS/GLIDRknsqcEPkHIYu/onP1nGk7IHJmzXokQJE/c2V2+Cuf6ODEnvj6t
	 defXbxUK12rG6AfI5OGr4Bna9nl+kXElDca7j9otSdc83CL10CpUFEMdgXUkW3gWFR
	 VN3Us7sxcevmA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Jul 2025 15:51:59 +0200
Message-Id: <DBG2XI0UZ3B5.I9KLFJUYQUMC@kernel.org>
Subject: Re: [PATCH v15 2/3] rust: io: mem: add a generic iomem abstraction
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com> <20250717-topics-tyr-platform_iomem-v15-2-beca780b77e3@collabora.com>
In-Reply-To: <20250717-topics-tyr-platform_iomem-v15-2-beca780b77e3@collabora.com>

On Thu Jul 17, 2025 at 5:55 PM CEST, Daniel Almeida wrote:
> +    /// Maps an [`IoRequest`] where the size is known at compile time.
> +    ///
> +    /// This uses the [`ioremap()`] C API.
> +    ///
> +    /// [`ioremap()`]: https://docs.kernel.org/driver-api/device-io.html=
#getting-access-to-the-device
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example uses a [`platform::Device`] for illustrati=
on
> +    /// purposes.
> +    ///
> +    /// ```no_run
> +    /// use kernel::{bindings, c_str, platform, of, device::Core};
> +    /// struct SampleDriver;
> +    ///
> +    /// impl platform::Driver for SampleDriver {
> +    ///    # type IdInfo =3D ();
> +    ///    # const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D No=
ne;
> +    ///
> +    ///    fn probe(
> +    ///       pdev: &platform::Device<Core>,
> +    ///       info: Option<&Self::IdInfo>,
> +    ///    ) -> Result<Pin<KBox<Self>>> {
> +    ///       let offset =3D 0; // Some offset.
> +    ///
> +    ///       // If the size is known at compile time, use [`Self::iomap=
_sized`].
> +    ///       //
> +    ///       // No runtime checks will apply when reading and writing.
> +    ///       let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?=
;
> +    ///       let iomem =3D request.iomap_sized::<42>();
> +    ///       let iomem =3D KBox::pin_init(iomem, GFP_KERNEL)?;
> +    ///
> +    ///       let io =3D iomem.access(pdev.as_ref())?;
> +    ///
> +    ///       // Read and write a 32-bit value at `offset`.
> +    ///       let data =3D io.read32_relaxed(offset);
> +    ///
> +    ///       io.write32_relaxed(data, offset);
> +    ///
> +    ///       # Ok(KBox::new(SampleDriver, GFP_KERNEL)?.into())
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn iomap_sized<const SIZE: usize>(self) -> impl PinInit<Devres<I=
oMem<SIZE>>, Error> + 'a {
> +        IoMem::new(self)
> +    }

This doc-test and the one below break the build, since the used platform de=
vice
infrastructure is introduced with the next patch.

I can set them to `ignore` and we turn them into `no_run` with a subsequent
patch.

> +    /// Maps an [`IoRequest`] where the size is not known at compile tim=
e,
> +    ///
> +    /// This uses the [`ioremap()`] C API.
> +    ///
> +    /// [`ioremap()`]: https://docs.kernel.org/driver-api/device-io.html=
#getting-access-to-the-device
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example uses a [`platform::Device`] for illustrati=
on
> +    /// purposes.
> +    ///
> +    /// ```no_run
> +    /// use kernel::{bindings, c_str, platform, of, device::Core};
> +    /// struct SampleDriver;
> +    ///
> +    /// impl platform::Driver for SampleDriver {
> +    ///    # type IdInfo =3D ();
> +    ///    # const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D No=
ne;
> +    ///
> +    ///    fn probe(
> +    ///       pdev: &platform::Device<Core>,
> +    ///       info: Option<&Self::IdInfo>,
> +    ///    ) -> Result<Pin<KBox<Self>>> {
> +    ///       let offset =3D 0; // Some offset.
> +    ///
> +    ///       // Unlike [`Self::iomap_sized`], here the size of the memo=
ry region
> +    ///       // is not known at compile time, so only the `try_read*` a=
nd `try_write*`
> +    ///       // family of functions should be used, leading to runtime =
checks on every
> +    ///       // access.
> +    ///       let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?=
;
> +    ///       let iomem =3D request.iomap();
> +    ///       let iomem =3D KBox::pin_init(iomem, GFP_KERNEL)?;
> +    ///
> +    ///       let io =3D iomem.access(pdev.as_ref())?;
> +    ///
> +    ///       let data =3D io.try_read32_relaxed(offset)?;
> +    ///
> +    ///       io.try_write32_relaxed(data, offset)?;
> +    ///
> +    ///       # Ok(KBox::new(SampleDriver, GFP_KERNEL)?.into())
> +    ///     }
> +    /// }
> +    /// ```
> +    pub fn iomap(self) -> impl PinInit<Devres<IoMem<0>>, Error> + 'a {
> +        Self::iomap_sized::<0>(self)
> +    }
> +
> +    /// Same as [`Self::iomap`] but with exclusive access to the underly=
ing
> +    /// region.
> +    pub fn iomap_exclusive(self) -> impl PinInit<Devres<ExclusiveIoMem<0=
>>, Error> + 'a {
> +        Self::iomap_exclusive_sized::<0>(self)
> +    }
> +}

