Return-Path: <linux-kernel+bounces-837843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA7BAD8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F167166D71
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F59306496;
	Tue, 30 Sep 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd+EPywA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7C0266B65;
	Tue, 30 Sep 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244937; cv=none; b=lcVFWn2y3Z7lqLgPnajz9cMM+PN4WUhHaGah4u/9LXD+Xu7b4p/whKCtJodlbcS5wLlGBmwOL6xTs36AS4PlOLMJS4hNzU8Uki87lKbocioJEicYTsmPMUJ2EViAV9I++WweXqN0dgxq/QKOzkt606BsErBeGJk3+1hUFfaSedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244937; c=relaxed/simple;
	bh=63UtVYxJqylHj4prM1HduUeXtYHOuEV3RnRnFK4ygP4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=SWd1jEu5yFDdsDWGEeebVOrj5dpNo+HRrXQ9fxMO9S0C1NLt7WrKjKq+m+1V7imYD/tcQBfaZyuzhHHEh3BBdhjK+I0sPejVf2EqMax7eZzAqG6pc8O0jeXeTYk/Cz6mDyBiho3ZjW98/ICkyD0pmTYbVaypm5XNe3D+1vnJbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd+EPywA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269FEC113D0;
	Tue, 30 Sep 2025 15:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759244937;
	bh=63UtVYxJqylHj4prM1HduUeXtYHOuEV3RnRnFK4ygP4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Zd+EPywA1Fzu+74r4CrY4oG41aO1BBHIc8jHBwkLmx3AJcZ6XGH882Lc16+WxrpWo
	 kcz44sRRI5sGVY+s6ukWK45G+xbS+xznFZqjPXqTCSTI7QVCx/FCmVb+Ncr0dOEX8a
	 kRtdy80NnE3B7+mwao6ZQ6+820HP9L5Blp/aS36uApG38JR5vlJOpk//PRg/h+Gyvi
	 i1zfq9AgsSlcdT5VCLXBlUSxFYdOlTKuqzou0h0mcxifCCIYhsjxciaGU6U4GWE0KR
	 R0iP1qPqJn+EMJuo3r5LOjs0CUAVOOP/ig4VthGFPaouwNbYA21Hw0QR+ekYmpUwwa
	 occ2O3CZp5r6w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Sep 2025 17:08:50 +0200
Message-Id: <DD68A3TZD9CV.2CL7R7K4UAICU@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
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
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 0/9] Introduce bitfield and move register macro to
 rust/kernel/
References: <20250930144537.3559207-1-joelagnelf@nvidia.com>
In-Reply-To: <20250930144537.3559207-1-joelagnelf@nvidia.com>

On Tue Sep 30, 2025 at 4:45 PM CEST, Joel Fernandes wrote:
>  MAINTAINERS                                   |   7 +
>  drivers/gpu/nova-core/falcon.rs               |   2 +-
>  drivers/gpu/nova-core/falcon/gsp.rs           |   4 +-
>  drivers/gpu/nova-core/falcon/sec2.rs          |   2 +-
>  drivers/gpu/nova-core/regs.rs                 |   6 +-
>  rust/kernel/bitfield.rs                       | 804 ++++++++++++++++++
>  rust/kernel/io.rs                             |   1 +
>  .../macros.rs =3D> rust/kernel/io/register.rs   | 317 +------
>  rust/kernel/lib.rs                            |   1 +
>  security/Kconfig.hardening                    |   9 +
>  10 files changed, 870 insertions(+), 283 deletions(-)
>  create mode 100644 rust/kernel/bitfield.rs
>  rename drivers/gpu/nova-core/regs/macros.rs =3D> rust/kernel/io/register=
.rs (72%)

I think we have at least three or four potential target trees for this:
driver-core (I/O), drm-rust (Nova), bitmap / Rust.

(I don't know which tree the bitmap stuff would go through, I did not find =
a
tree entry in the MAINTAINERS file.)

Unless someone thinks otherwise, I'd take it through the drm-rust tree once=
 the
series is ready. This should cause the least conflicts and as a bonus enabl=
e Tyr
to use it right away.

