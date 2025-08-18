Return-Path: <linux-kernel+bounces-774548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B867B2B409
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C39A1B26B82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF927B338;
	Mon, 18 Aug 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMP5Xn+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133B1D514E;
	Mon, 18 Aug 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555323; cv=none; b=KZruSogYKmdl0N58QqVT7+as9YS8Bp2xHW8H8JRcoSF3lkXMtMlD8t5Erpv0NqPotmmKfNmh/RffCq8Cql4D4xNSzD7VlxIAuJR6ktwa128xRmoz8pgKh7G6Amy+fwA/ey91Z886UXGU6wbxCWe0kjumwdj6uYIIcahCOJ2mY8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555323; c=relaxed/simple;
	bh=m7nfTiRXDVEsRchyXDUYATm84UUhvFuIKRwTi+rWaiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dwQwbd65d+pmXU3N4RE6gKGw23drpJvW2tyIe+EI7MuYa/2i+J5RdzTXycq+bMlmweFPa82Sfs57nouFpYacmEtk3qhLbxAGH/vRfpiPZ3RnnxmiqYE+3Hc1RYzI3LHpT8OQ4u6LJ2o5+isnfzOEsu7dobHJglt5vLZl5NQshEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMP5Xn+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C229C4CEF1;
	Mon, 18 Aug 2025 22:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755555323;
	bh=m7nfTiRXDVEsRchyXDUYATm84UUhvFuIKRwTi+rWaiI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RMP5Xn+lAChlnu0iPt8UI9HjBAdqJ8SN6KUiQN4kOJWEKOCCu0QkmwYrESERGYLl0
	 Vrr2p56THxB1WwO+kzC4CfLkndb4onB9B1OyU1IuQpE+zqt4GNZ7lvSdcaHWkr0iDb
	 oZA+rJ+Ylsi9qfwy2IpkP9zvM4613LVl9n5pC/WMMByjwdp+8cwSxLhFO9B2l5891/
	 4p+kDFXDLt/6dLIPjju1drdLC7u+wWuYMupqbRAj6iUj0BkrATj8kkgc1oHsy5SDsW
	 UUZIoZMKIy+EXfYSXgY+I6UIXP3kH8K1T6t9InpdMq+yR81A9CEkUdyMQT2+SnM26w
	 hevaP9vU+AV1w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:15:18 +0200
Message-Id: <DC5WF7NYTZZN.RQDKGE8FGMCW@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: update ARef and AlwaysRefCounted imports
 from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20250815161706.1324860-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250815161706.1324860-1-shankari.ak0208@gmail.com>

On Fri Aug 15, 2025 at 6:17 PM CEST, Shankari Anand wrote:
> Update call sites in drm to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here: (commit 07dad44aa9a93)
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  rust/kernel/drm/device.rs  | 3 ++-
>  rust/kernel/drm/driver.rs  | 2 +-
>  rust/kernel/drm/gem/mod.rs | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

