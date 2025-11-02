Return-Path: <linux-kernel+bounces-881962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7960AC29518
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33D5188DF4D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B31A9F87;
	Sun,  2 Nov 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA89bNGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B1322A;
	Sun,  2 Nov 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762108397; cv=none; b=Z3Lgzf7F6G3bHwjrwH4txJrxFt371fScqQTCQn5m4Xa2M+5n+shmabcB5Yp2v5DZcegEXxR1mLITF0sVJ4KkCUVvQAqBhjylK1HftrB6zqoUJmtUmAEfx1fPG1044y3r+H4UeG9nF7ri9vt4/fp9IUB3S6Qke3oTaiZ3Ql+rxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762108397; c=relaxed/simple;
	bh=IpKqz0qzKjLklmzfJcV0mhsV3DqQL5aAEwvbVr4a4Gg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=F20hLGeNqJoPLjzaj/7Xck0T2Na+nn/+8DHEU3IHIja96S2/Z/UcmUF/ErcyuGqRaiVNXk7HSWogkI2RJHczEK3oA97+rkrnHzAVNCom62kKpo/PhdRowVDIuGzFMouzHeSVuC6EfYh1ArG5zvOHTisSQi4wzwZ0ibHdJcL+ABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA89bNGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C490C4CEF7;
	Sun,  2 Nov 2025 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762108397;
	bh=IpKqz0qzKjLklmzfJcV0mhsV3DqQL5aAEwvbVr4a4Gg=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=pA89bNGjSPGe6V9305nxlysAdhy6gtdZi5AkGclGlsXJPQFMsRHLt9jqUyz8C9elX
	 YzURNxnMHd2hJsnSGgOo5LC5pjFGG11VqMmqRG48CwpjnidTuCjf4Oi+yM5d4cIBBY
	 s1IGlx3n30opzuCDMajkG29yduEQ5iarmnbeW9CmuLamnVRIHkUKWKLy2wm49Ey5Jq
	 1X6CdQ6CNvLq6JwQOPwcI/pH8Pe7Pj3l+vw4VFAg4iTo9y2cGmJXQ/yq5x8xn6p5zY
	 SsWXVaaWlBJbbd9TiY9SVC6KFgEZlQzU4jab0ZImK28IpVKPykJpmoNPYG0/2jrHUi
	 UjSyjhTtwh71A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 19:33:10 +0100
Message-Id: <DDYFAJCBT3UR.10Y0XJDLPKYZ6@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
In-Reply-To: <20251030160315.451841-2-zhiw@nvidia.com>

On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
> +/// Static vtable mapping Rust trait methods to C callbacks.
> +pub struct FwCtlVTable<T: FwCtlOps>(PhantomData<T>);
> +
> +impl<T: FwCtlOps> FwCtlVTable<T> {
> +    /// Static instance of `fwctl_ops` used by the C core to call into R=
ust.
> +    pub const VTABLE: bindings::fwctl_ops =3D bindings::fwctl_ops {
> +        device_type: T::DEVICE_TYPE,
> +        uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>(),

The fwctl code uses this size to allocate memory for both, struct fwctl_uct=
x and
the driver's private data at the end of the allocation.

This means that it is not enough to just consider the size of T::UCtx, you =
also
have to consider its required alignment, and, if required, allocate more me=
mory.

> +        open_uctx: Some(Self::open_uctx_callback),
> +        close_uctx: Some(Self::close_uctx_callback),
> +        info: Some(Self::info_callback),
> +        fw_rpc: Some(Self::fw_rpc_callback),
> +    };
> +
> +    /// Called when a new user context is opened by userspace.
> +    unsafe extern "C" fn open_uctx_callback(uctx: *mut bindings::fwctl_u=
ctx) -> ffi::c_int {
> +        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to be a v=
alid pointer.
> +        let ctx =3D unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };

Considering the above, this is incorrect for two reasons.

  (1) FwCtlUCtx::uctx might not be aligned correctly.

  (2) FwCtlUCtx::uctx is not initialized, hence creating a reference might =
be
      undefined behavior.

I think the correct way to fix (2) is to only provide an abstraction of str=
uct
fwctl_uctx as argument to T::open_uctx() and let T::open_uctx() return an
initializer for FwCtlUCtx::uctx, i.e. impl PinInit<T::UCtx, Error>.

All other callbacks should be correct as they are once the alignment is
considered.

> +        match T::open_uctx(ctx) {
> +            Ok(()) =3D> 0,
> +            Err(e) =3D> e.to_errno(),
> +        }
> +    }

