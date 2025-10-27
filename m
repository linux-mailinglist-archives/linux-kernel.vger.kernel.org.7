Return-Path: <linux-kernel+bounces-871282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DA9C0CCC3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A07188BC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7622F99A8;
	Mon, 27 Oct 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTmPnrk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2A2F547D;
	Mon, 27 Oct 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559009; cv=none; b=Hv6ubjZPTOV0ITEUZ2HYRpotHgLa0cgSQISgQMx7PrkHwPWbgwWDyXxT3iA1nCmphrb28v4QeBtGSDrmNGTwMOxZ84oR+HQU0HwlWhAAQvytVzQTHJv7w7Lsfla22EeDSBSbycXkyESGRuM08sR6WSUgpabknSbRS5xzAAlxqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559009; c=relaxed/simple;
	bh=Lxu5cscL1HwCBzlPnIr1BaQwvaRrU0uoXTu5LjXze2o=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=dvoQX1ICegdPbYNp9whFNCI+UwsR01rcHbJo/P4/F9/BB4g48RD6gcuke6RCp6MrmPttvNab0qKiPjWw+LF1VDjlspmwBnGHsxV2VqACuFmZYcDXDhaYWsTFl6KMrr5elg4y8WUS9im8QhBZU+xJ8YLLhSmEhlkjvi5D07LoydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTmPnrk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE62C4CEFF;
	Mon, 27 Oct 2025 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761559008;
	bh=Lxu5cscL1HwCBzlPnIr1BaQwvaRrU0uoXTu5LjXze2o=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=BTmPnrk79MH8XqKW5zleIBNMoiZ+DkrLxXgRoVKSk8GlvqP+QgS6PiCze6RdRBesb
	 kXJZfDFiMQA4aL0u+6nB99Ro7nPXzm/fC+IFPzu8ELy8bBu9384TzYVCuLqP7o7ZIa
	 EHm9srXvTGeIFfvlXaHyl14MK3KB86liYqmsclni6sL+QnKKyWxWfy9KccKAyMXZ0d
	 4VpkCvtqtDWbtiKhX22Uu72chUrLISHb7dRMfBmNA9uDJj36tyXdgR3EpwGxkzOxb6
	 BHPjvgXER+dkfuQaoJYMz57olyW2cj4Tp4pBXUxEbaEk3hc8sUmfADuM4U1M1b3mrw
	 VeJ/Bsejy9Ilg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 10:56:41 +0100
Message-Id: <DDT0JTP91GO3.1EHF6L8MX4I3T@kernel.org>
To: "Beata Michalska" <beata.michalska@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 4/5] rust: Move register and bitfield macros out of
 Nova
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Yury Norov" <yury.norov@gmail.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Andrea Righi"
 <arighi@nvidia.com>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <20251003154748.1687160-5-joelagnelf@nvidia.com> <aPklNydcTdOeXtdU@arm.com>
 <ACAA327A-AE2B-4D21-B8C5-C66BB5E09B7C@nvidia.com>
 <aPozw8TGp85YdmNU@arm.com>
 <47d6ab72-1526-457d-990a-928088ba7022@nvidia.com>
 <aP82DHvLC7zAEojN@arm.com>
In-Reply-To: <aP82DHvLC7zAEojN@arm.com>

On Mon Oct 27, 2025 at 10:06 AM CET, Beata Michalska wrote:
> It's more theoretical at this point, but there are drivers that do rely o=
n
> information from either DT or ACPI tables for the base address and size o=
f the
> MMIO region: anything that uses devm_platform_ioremap_resource() or
> devm_platform_ioremap_resource_byname() I guess.

Don't get confused, those are two different things: The size of the MMIO re=
gion
(or a PCI BAR) and the const SIZE generic in Io<SIZE> are two different thi=
ngs.

The former is the actual size of an MMIO region, whereas the latter is the
minimum size requested by a driver for proper operation.

For instance, let's assume your driver requests ten contiguous 32-bit regis=
ters
starting at offset zero of an MMIO region.

In this case you can call req.iomap_sized<0x28>(), because you know that yo=
ur
driver is not able to properly work without an MMIO region with at least a =
width
of 0x28 bytes.

The actual size of the MMIO region returned by req.iomap_sized<0x28>() may
indeed be smaller or larger than that, depending on what is defined in the =
DT,
ACPI or PCI BAR.

If smaller than the const SIZE generic, the call to req.iomap_sized<0x28>()=
 will
fail, otherwise it will be successful. The actual size of the MMIO region i=
s not
influenced by the const SIZE generic.

