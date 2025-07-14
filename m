Return-Path: <linux-kernel+bounces-729664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF76B039DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F423BA887
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A988B23DEB6;
	Mon, 14 Jul 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNhzUOQp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189E18D;
	Mon, 14 Jul 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482941; cv=none; b=bI0eWRLBxxz4OybYwY6qil5L9HxZOdONJtfO5v8r0vL51ugsoF2fT/sBRsyVXFcvk3orrTeaoHP4pVpwtAqAeVIe7uki/q5FAWVRi/xafQMK+JDGmuIUFj/Cx9d0e7uVVXaL7IApOT4QBFQhpkhIYrxbTn3T2sow1qggCVOf3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482941; c=relaxed/simple;
	bh=Z7PKqPXa5qmU1lyjB+OTmpDjY+Y6rO3Qon40Y4E9lKc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X6VkPKgbDk3CUIlZa/Vd5fGlZrxRBv111kY/HG5iUZElg/qLcaxRCTarB9a0mFsRdVy7VjiHSXOf9zT1azK6DDUyIOCQmaL2XJyD9Ly/T62ZmvB24MRgbWGC80NVgG3ZMc3Y1jEuX3T6UpBhkgLwbWg+OehnA4CDH4uudHjJtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNhzUOQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40504C4CEED;
	Mon, 14 Jul 2025 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752482940;
	bh=Z7PKqPXa5qmU1lyjB+OTmpDjY+Y6rO3Qon40Y4E9lKc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gNhzUOQpkCDLaS58yx9AC9kpSlVRNO5zw1Wyf+ywvfKteTAaihJhT6gBfKZJKdwAQ
	 4krsJJWx09cfvXgvDyj5y9dvQJvL7daGGv2HR6Vd0iagbsNvejQa2mLfSnd932B1OR
	 A9wiM9tpskVcdDnx7jIepxLztK4IjXkP7TqcJ5skS+uiOQcVNRUM/nfaSHoYeuflEB
	 j7RGv3W3PD2rXr8E2QE9MLTujYlblD6NpyALDfa0+kZHcKmb7Jowy+rLMcJXSNbCYz
	 qYoEUZUsSZ5DTUI7itqxawJUQWz0gFvgRwxPcptDjIQ4t4pR+jd/g6tDQz+XKxU1ks
	 8/EMbfT3oyuww==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 10:48:56 +0200
Message-Id: <DBBNCQQ5HF3N.3HXQWJR71RZ8S@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/2] rust: update ARef and AlwaysRefCounted call
 sites to import from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250713213614.188921-1-shankari.ak0208@gmail.com>
 <20250713213614.188921-2-shankari.ak0208@gmail.com>
In-Reply-To: <20250713213614.188921-2-shankari.ak0208@gmail.com>

On Sun Jul 13, 2025 at 11:36 PM CEST, Shankari Anand wrote:
> Update call sites to import ARef and AlwaysRefCounted directly=20
> from sync::aref instead of indirectly via types.
> Remove the re-export of their definitions in types.rs.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> v2 -> v3: solved the styling error triggered by the kernel bot.
> ---
>  drivers/block/rnull.rs               |  3 +--
>  drivers/gpu/drm/nova/driver.rs       |  4 +++-
>  drivers/gpu/drm/nova/gem.rs          |  2 +-
>  rust/kernel/auxiliary.rs             |  2 +-
>  rust/kernel/block/mq.rs              |  8 ++++----
>  rust/kernel/block/mq/operations.rs   |  2 +-
>  rust/kernel/block/mq/request.rs      |  3 ++-
>  rust/kernel/cred.rs                  |  6 +-----
>  rust/kernel/device.rs                | 10 +++-------
>  rust/kernel/devres.rs                |  3 +--
>  rust/kernel/dma.rs                   |  2 +-
>  rust/kernel/drm/device.rs            |  3 ++-
>  rust/kernel/drm/driver.rs            |  2 +-
>  rust/kernel/drm/gem/mod.rs           |  3 ++-
>  rust/kernel/fs/file.rs               |  3 ++-
>  rust/kernel/mm.rs                    |  3 ++-
>  rust/kernel/mm/mmput_async.rs        |  2 +-
>  rust/kernel/opp.rs                   | 13 +++++++------
>  rust/kernel/pci.rs                   |  5 +++--
>  rust/kernel/pid_namespace.rs         |  5 +----
>  rust/kernel/platform.rs              |  2 +-
>  rust/kernel/task.rs                  |  7 ++++---
>  rust/kernel/types.rs                 |  2 --
>  samples/rust/rust_dma.rs             |  2 +-
>  samples/rust/rust_driver_pci.rs      |  2 +-
>  samples/rust/rust_driver_platform.rs |  2 +-
>  samples/rust/rust_misc_device.rs     |  3 +--
>  27 files changed, 49 insertions(+), 55 deletions(-)

We probably want to split this by subsystem and not remove the
re-exports this cycle. @Miguel what do you think?

---
Cheers,
Benno


