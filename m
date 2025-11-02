Return-Path: <linux-kernel+bounces-881919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB64AC293A9
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A3D188C574
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65C92DCF78;
	Sun,  2 Nov 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1R1ubK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7121A459;
	Sun,  2 Nov 2025 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762104425; cv=none; b=W/VWtQh4mVEZMN5dAfGhBXSZoZaUG1bXZKZ2dV8uw+5UyC3X84b8Y6npgIEJxbl3RaA1OTe+1Gxryr+HJH5s0IpP9c3j1WGD89Q77a5NQUkFKWQE4Bnz6pikflpHvy1TKJkojtPx0FtatTLLSZixoYzYyYloWiIEYIAumAJQg2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762104425; c=relaxed/simple;
	bh=zRweTz2jNpwtT0qcUeNHesBfTvTcIjBj1ikd2sZG76w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=XW9VRfmSrF1jq91BPBlIqJhgFhVr0KDmTf4HcXMzpfyWUyEPAKkQhyCqfaXMVHi3pjz6Dm1zntFZ/ixMcwPWu/lNL1mawd3AJ0sypmFUGx2DBRCAtL/MSmBxsSnw3KTx6MvUHrQuxXXeVPBxWOn3wRovTbsIdvzWB/ZygiSYBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1R1ubK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B8C4CEF7;
	Sun,  2 Nov 2025 17:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762104424;
	bh=zRweTz2jNpwtT0qcUeNHesBfTvTcIjBj1ikd2sZG76w=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=C1R1ubK+DLdO+eQXmN6/rims+2JgJMgcahlKBQAZMM1uOsXexTMoXNcX+RvE144+H
	 gxdnUJkxsnvOdKB+Ymfb6Bx0LDjEC4Bc7bcbqGhDEXSJiTh442EFAIh7sEI+ovX9so
	 XxZYFvgSOJO6umqswLOLh1U5iTXSmvk/JNiuxfgivP1ZTYC7K2bLqNMEd9vNRt4yHa
	 u30hZFP6zzCssl60nAC0jXvZCA9QDksnw3YEtIOB/+hLG1WrOG6M0flwRtQi7yW1oh
	 FPUtxdSj/EGiHAynkmLQGmpl0FVEzMnMWuF/sAdr9ErPRC4tqlEZn7pU2U4mhMEHzn
	 lywtcos/ydm2Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 02 Nov 2025 18:26:58 +0100
Message-Id: <DDYDVUFTJFVY.3U00QWH6LOF5D@kernel.org>
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
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
In-Reply-To: <20251030160315.451841-2-zhiw@nvidia.com>

Hi Zhi,

Additional to my other comments, some thoughts about naming.

On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
> +/// Trait implemented by each Rust driver that integrates with the fwctl=
 subsystem.
> +///
> +/// Each implementation corresponds to a specific device type and provid=
es
> +/// the vtable used by the core `fwctl` layer to manage per-FD user cont=
exts
> +/// and handle RPC requests.
> +pub trait FwCtlOps: Sized {

Up to Jason, but I usually recommend to take the Rust module name into acco=
unt,
i.e a user of the API can refer to this as fwctl::FwCtlOps.

Hence, I suggest to name this Ops or even Operations, such that users can r=
efer
to this as fwctl::Ops or fwctl::Operations.

It would also be more consistent with existing code, e.g. pci::Device,
platform::Device, etc., but also the fwctl::Registration from this patch. :=
)

> +    /// Driver UCtx type.
> +    type UCtx;

I think we can affort to be a bit more verbose here, maybe just spell it ou=
t as
UserContext.

> +    /// fwctl device type, matching the C enum `fwctl_device_type`.
> +    const DEVICE_TYPE: u32;

I think it would make sense to have a new (Rust enum) type (fwctl::DeviceTy=
pe)
for this, rather than using a raw u32, see [1] for reference.

[1] https://lore.kernel.org/all/20250828133323.53311-2-dakr@kernel.org/

> +/// Represents a per-FD user context (`struct fwctl_uctx`).
> +///
> +/// Each driver embeds `struct fwctl_uctx` as the first field of its own
> +/// context type and uses this wrapper to access driver-specific data.
> +#[repr(C)]
> +#[pin_data]
> +pub struct FwCtlUCtx<T> {

What about UserContext<T>? A driver would refer to this as fwctl::UserConte=
xt.

