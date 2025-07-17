Return-Path: <linux-kernel+bounces-735911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217ABB09525
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D9E5A182A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B93212B0A;
	Thu, 17 Jul 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWz40BNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7881799F;
	Thu, 17 Jul 2025 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781532; cv=none; b=nUS10SFQY5KN0sQxT0rtNYQBSi/fczrWHzBNjq6FuYivqPKtwQkGMM6wNfuCBqys5csjWsYT+1avW1rn3riJJ2xhe7uLEz1BJ4/IVvuoT40nHuMu2dvVjN2cXvOYxeM2FZ3NfiU3E/96uf1x0sWhEM7J98ukYZHvpAC5iteTo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781532; c=relaxed/simple;
	bh=N2BisUfdTV1268goLzXHdBIJr+OPvUfSeFednAFAYYY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eIPnEOg16k0impGe290NF0c0+Sgljo//xFZ/zDgSvXgYjWBw8zu7Bo2r0VntB7EBvWOg1D3/sjQmDx/ti6kamlV7N66yMHDmmhVvxZbDcB2Mtco8PmzFQlM3221kFedy9uFhlPpGcgF1eaTi/uqEgMD3/MjhNvSniMywd+Rdskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWz40BNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB38C4CEE3;
	Thu, 17 Jul 2025 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752781531;
	bh=N2BisUfdTV1268goLzXHdBIJr+OPvUfSeFednAFAYYY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=sWz40BNVuRx9LM1hNdjBIPpZL1908nl08MOxa5pbgC2FdijtwLIo7xV/Pr0A1z949
	 L79Oz+I2I5b3OvMjQ/hLXdl0Hrw6Uy+zVW0smISUYeJ/tsCsu7xtYvFjt3HMNVH3v8
	 f3iw61NLBhJElpMqTzm+Nyb78W3qLDQUHH52OIbKwVj6D1RnP5DDVlbR21U3sTPCRY
	 EyfZoP9F998sGyZ4YMwgpNivXCZToKQ1EL4PFnjSWiR26nJY81n09ESSD9NrFMaQf8
	 YZhd3m01k6r8wqrvUKOO6hFg4N5CHHiwDSAF+5UQYmZXDsrjEUAybJBvKEOmCOY4dL
	 pR5sTZNPLMBWg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 21:45:26 +0200
Message-Id: <DBEL719XP5CO.FKBDQ4QRZST0@kernel.org>
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
> +impl<const SIZE: usize> IoMem<SIZE> {
> +    fn ioremap(resource: &Resource) -> Result<Self> {
> +        // Note: It looks like there aren't any 32-bit architectures tha=
t define
> +        // ioremap_np. This means that sometimes this conversion will fa=
il. If
> +        // we performed a lossy cast, i.e., using `as`, then `bindings::=
ioremap`
> +        // would return NULL anyway.

Why would ioremap() return NULL if you perform a lossy cast?

Anyways, I find it a bit difficult to decode the actual problem from the ab=
ove
description.

I feel it would be better to just explain that some ioremap() implementatio=
ns
use types that depend on the CPU word width rather than the bus address wid=
th.

If you agree, no need to resend though, we can change it when applying the
series.

> +        // TODO: Properly address this in the C code to avoid this `try_=
into`.
> +        let size =3D resource.size().try_into()?;
> +        if size =3D=3D 0 {
> +            return Err(EINVAL);
> +        }

