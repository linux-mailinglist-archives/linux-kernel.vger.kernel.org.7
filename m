Return-Path: <linux-kernel+bounces-748410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE0B140D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A284E1555
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EA1274FD9;
	Mon, 28 Jul 2025 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2hvpwks"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C474273D96;
	Mon, 28 Jul 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721967; cv=none; b=MI0vsSialemGiw6oC4xaVokpxA6JqghFAglL1gsNZ2nxU7pZ3h1c3H2sVgWO6ddvI7p6UzTPD6IdQv2sHIqdwW3un7Fn+1FLFhD9XAYOrtWdy3GbNBwMMdG/k3p63CWE8zYy4ye5+eDujel1BbeYb7VE8VCan/3Io81KEvOeQLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721967; c=relaxed/simple;
	bh=4uq4fCRih9TVY2hZXV4zIt0fgsKRUncQeoxuKcLnVG8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=royHWzGJS3b7+Ow0i6ZwOqCmdrNGRQtzrAHGWnHkKRLw0Lr3jD4QHghLbbs0187H5VIgdQbh7gXdbF7EzC5Lz0id3h1Ie11s3u86EXjW6b6NB3y6clhSXy0wzJb05xSjRoU+9EhKlinnYyD8Z/nLJ1bvkrhDnK7RplFJZ7TCXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2hvpwks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FDEC4CEE7;
	Mon, 28 Jul 2025 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721967;
	bh=4uq4fCRih9TVY2hZXV4zIt0fgsKRUncQeoxuKcLnVG8=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=g2hvpwksLMQsZ24HAD+tutEX4Ff14lVEpJ+qRq4TemhFpURKtnmmgXdkZjbGhHIvq
	 Jy/D6RaJv3kDwSYBx7f59VPw77lEQS4ZxEqJUSUIh+sRZ1Urh6DlKh/ueV2hHXiIM7
	 0GAv4NJmfQvmGwSoY/qf6jbl9mNq2g4jDLvjwR//ZKG+zQfVfuFVJVH4ZF+Y0wg51A
	 IMH2Kbq2wKo6nYni8j0zbJBj0QhxPYBqnlJKfMiL0EuScsz6Xmo9n1qmH6BmcEmUuj
	 0to3RZ1goe+xMHKzHo5W8ErWU96ArKvg0KPVzE0jQ6GBXZI8xHlPBGE7sugxIDs/OH
	 Y56uGoYYrZskA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Jul 2025 18:59:21 +0200
Message-Id: <DBNUJUSYG465.7YE1YER8B9K@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] Partially revert "rust: drm: gem: Implement
 AlwaysRefCounted for all gem objects automatically"
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi
 Lina" <lina+kernel@asahilina.net>, "Alyssa Rosenzweig"
 <alyssa@rosenzweig.io>, "open list" <linux-kernel@vger.kernel.org>
References: <20250724191523.561314-1-lyude@redhat.com>
 <DBKJYLF9E3TY.IM6UZFA0BW9I@kernel.org>
 <e7a4cb0cc55a2d19e6eb9bf5280c68c0dd04d61d.camel@redhat.com>
 <DBKN0VSJH3TX.2FYLW17KL0SWW@kernel.org>
 <E9028A26-2E47-4431-B4B4-C5B416EB36E2@collabora.com>
 <2d4f0bb1f23f89e4e5bedf6346a6c21f8b6bb29b.camel@redhat.com>
In-Reply-To: <2d4f0bb1f23f89e4e5bedf6346a6c21f8b6bb29b.camel@redhat.com>

On Fri Jul 25, 2025 at 9:41 PM CEST, Lyude Paul wrote:
> a-ha, ok. I made a mistake here with misremembering where the compilation
> issue I saw here really was.
>
> It's not that multiple gem object implementations are triggering it, it's=
 that
> it immediately breaks compilation if any other type tries to do a blanket
> implementation with AlwaysRefCounted like this.
>
> Here's a properly compiling example with rvkms:
>
> https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-slim
>
> This builds fine because IntoGEMObject is the only one with a blanket
> implementation of AlwaysRefCounted, and we implement AlwaysRefCounted usi=
ng a
> macro for refcounted Kms objects.
>
> But if we apply this patch which adds the second blanket impl:
>
> https://gitlab.freedesktop.org/lyudess/linux/-/commit/ec094d4fc209a7122b0=
0168e7293f365fe7fc16c
>
> Then compilation fails:
>
>    =E2=9E=9C  nouveau-gsp git:(rvkms-slim) =E2=9C=97 nice make -j20
>      DESCEND objtool
>      DESCEND bpf/resolve_btfids
>      CALL    scripts/checksyscalls.sh
>      INSTALL libsubcmd_headers
>      INSTALL libsubcmd_headers
>      RUSTC L rust/kernel.o
>    warning: unused import: `pin_init`
>      --> rust/kernel/drm/driver.rs:18:5
>       |
>    18 | use pin_init;
>       |     ^^^^^^^^
>       |
>       =3D note: `#[warn(unused_imports)]` on by default
>   =20
>    warning: unused import: `prelude::*`
>     --> rust/kernel/drm/kms/modes.rs:4:13
>      |
>    4 | use crate::{prelude::*, types::Opaque};
>      |             ^^^^^^^^^^
>   =20
>    error[E0119]: conflicting implementations of trait `types::AlwaysRefCo=
unted`
>       --> rust/kernel/drm/kms.rs:504:1
>        |
>    504 | unsafe impl<T: RcModeObject> AlwaysRefCounted for T {
>        | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ conflicting =
implementation
>        |
>       ::: rust/kernel/drm/gem/mod.rs:97:1
>        |
>    97  | unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
>        | ---------------------------------------------------- first imple=
mentation here
>   =20
>    warning: unused import: `Sealed`
>     --> rust/kernel/drm/kms/vblank.rs:7:44
>      |
>    7 | use super::{crtc::*, ModeObject, modes::*, Sealed};
>      |                                            ^^^^^^
>   =20
>    error: aborting due to 1 previous error; 3 warnings emitted
>   =20
>    For more information about this error, try `rustc --explain E0119`.
>    make[2]: *** [rust/Makefile:538: rust/kernel.o] Error 1
>    make[1]: *** [/home/lyudess/Projects/linux/worktrees/nouveau-gsp/Makef=
ile:1280: prepare] Error 2
>    make: *** [Makefile:248: __sub-make] Error 2
>
> This is definitely part of the reason I didn't notice this problem until =
later
> too. My understanding is that this is a result of rust's orphan rule, whi=
ch
> basically just disallows trait impls where it would be ambiguous which im=
pl
> applies to a specific type. Here, the issue is that there's nothing stopp=
ing a
> type from implementing both RcModeObject and IntoGEMObject.

Yeah, this is pretty annoying. I don't think it's related to the orphan rul=
e
though; see also the example in [1].

I think in this case we should just keep the generic
impl<T: IntoGEMObject> AlwaysRefCounted for T and not introduce the blanket=
 one
for T: RcModeObject.

In theory it doesn't matter which one to drop, but I'd rather avoid the rev=
ert
and I think there's no reason for both to have the less nice macro solution=
.

[1] https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D202=
4&gist=3D23593da0e5e0ca0d9d2aa654e0c9bde6

