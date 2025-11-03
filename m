Return-Path: <linux-kernel+bounces-882673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE506C2B189
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64EE33A258C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97C2FD7BC;
	Mon,  3 Nov 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n559Mzy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320652E228D;
	Mon,  3 Nov 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166200; cv=none; b=IFXnPbXvN3g7uLDiNpC0eG0hrZHL8Tv1CUsvKOGlsEkzQlsE3Vcm06hRtyaUEc9R1Xk9Wo+HPPAiR4v7dLf3SBhv94q4FyKWQ75a0nPvUYt+rkbA0OMPxLLaSjN3nSXNpiYGL1nSOOUR15hgO6HnXZDVeGITdjIwFh7xSPz1PJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166200; c=relaxed/simple;
	bh=rVLRo8WBnpEqjQT2B9aooIzf1/z2eLawBKmGN6AWqiw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fHcQk1Giy/IoD7XD+XLpu1tETIeeMFy5kGCN6b4NdYeN13CLRc1u77fXrxLt2La7srHH3DLDn5DQ86Gk4FrnWHFGp+n9XNBA0cW9uguTreIcY0l7JthxCQMpZN/6RGgyWkQyl2xAsc0z4JNlimAitp8bHiD4EcBoeIBe6N1UKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n559Mzy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D9DC4CEE7;
	Mon,  3 Nov 2025 10:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762166198;
	bh=rVLRo8WBnpEqjQT2B9aooIzf1/z2eLawBKmGN6AWqiw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=n559Mzy2mFt/Wt0E63CHnqwfHjDFOjVx3kA/UH1Uv25q+15mFhQlsyiLW94FaajmE
	 QRV1j2rBDH306pc6JZz9a7/2OOGQjZZbNinnWsOi1HQBeBJcWADp4gvS/inxQDrjUF
	 93bwUVB5KHIy/Y80lqM+C/S/KI49z0ossa000dAmdf52BVfXZwr4IlIWFBm7ppuPP5
	 Cs8y7+65co3cQeaOs4bq2vbTpww2TgTiGCe17glGsFjm21ISebtnn4b/YmDJ9jbBc9
	 FnCrHf2oGESYaH2+FahF4riPrsr4kde8/zn4v4jB3B/hUhgf8qkl7Zfd3VTJ/qaEab
	 4JI8uYPLXKXeg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 11:36:32 +0100
Message-Id: <DDYZS5131FR7.282DNJW2DUOAH@kernel.org>
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Cc: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <zhiwang@kernel.org>,
 <alwilliamson@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <jgg@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
 <DDYFAJCBT3UR.10Y0XJDLPKYZ6@kernel.org>
 <20251103115432.5b593934.zhiw@nvidia.com>
In-Reply-To: <20251103115432.5b593934.zhiw@nvidia.com>

On Mon Nov 3, 2025 at 10:55 AM CET, Zhi Wang wrote:
> On Sun, 02 Nov 2025 19:33:10 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
>> > +/// Static vtable mapping Rust trait methods to C callbacks.
>> > +pub struct FwCtlVTable<T: FwCtlOps>(PhantomData<T>);
>> > +
>> > +impl<T: FwCtlOps> FwCtlVTable<T> {
>> > +    /// Static instance of `fwctl_ops` used by the C core to call
>> > into Rust.
>> > +    pub const VTABLE: bindings::fwctl_ops =3D bindings::fwctl_ops {
>> > +        device_type: T::DEVICE_TYPE,
>> > +        uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>(),
>>=20
>> The fwctl code uses this size to allocate memory for both, struct
>> fwctl_uctx and the driver's private data at the end of the allocation.
>>=20
>> This means that it is not enough to just consider the size of
>> T::UCtx, you also have to consider its required alignment, and, if
>> required, allocate more memory.
>>=20
>
> FwCtlUCtx is defined as below:
>
> +#[repr(C)]
> +#[pin_data]
> +pub struct FwCtlUCtx<T> {
> +    /// The core fwctl user context shared with the C implementation.
> +    #[pin]
> +    pub fwctl_uctx: bindings::fwctl_uctx,
> +    /// Driver-specific data associated with this user context.
> +    pub uctx: T,
> +}
>
> I assume it should be equal to C structure as below and with #[repr(C)],
> the handling of layout and the alignment should be as the same as C
> structure.
>
> struct FwCtlUCtx {
> 	struct fwctl_uctx base;
> 	struct my_driver_data data;
> };
>
> uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>() should be:

That's indeed correct then, I think I read uctx_size as the size of T::UCtx
only. (I've recently come across subsystems that do exacly that and hence r=
un
into the problem in [2].)

Anyways, I suggest to not give out a FwCtlUCtx<T> to the driver at all, sin=
ce in
open() we can't (for the discussed reasons) and in the other callbacks it
doesn't seem very useful either.

Instead, I think we should have the following callback arguments:

	impl fwctl::Operations for MyDriverContext {
	    fn open(
	        fdev: &fwctl::Device,
	        parent: &Device<Bound>
	    ) -> impl PinInit<Self, Error>;

	    fn close(
	        this: Pin<&mut Self>,
	        fdev: &fwctl::Device,
	        parent: &Device<Bound>
	    ) -> impl PinInit<Self, Error>;
	}

with

	#[repr(transparent)]
	struct Device(Opaque<bindings::fwctl_device);

Note this also gets us rid of the Self::UCtx type alias, which seems
unnecessary.

You could still keep a FwCtlUCtx<T> type internally since it might make the
implementation easier.

[2] https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D202=
4&gist=3D806c1a9a53a174ef39acff8ae5bb0e68

