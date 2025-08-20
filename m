Return-Path: <linux-kernel+bounces-777792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868DB2DDD6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067C91C812D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FEF32039E;
	Wed, 20 Aug 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+3+ymXp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F732038D;
	Wed, 20 Aug 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696746; cv=none; b=q6H8yXWcPmidysS4NtxTuu2fhbU2Y5zv5Dco4RmpWyTwuV9Zd1WwSRoyikEI/lNM+o1PWbqIP+fSwQkagGeOYSYUFSv8yel+XFzGlXVvUpeRxVLbImc9xPK9m41OzEGfZjfyVyi1p+CnHu/KVu2PPvM1w9cquV/xYeAkpSv9dA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696746; c=relaxed/simple;
	bh=Khr+sh1I/ZX+wHTb1vmBfEArOF9CiW/g/noN8NNg++Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l7twPEAzwcchpJGEFgHO7musFXcCnm81HYFEn40ynhP8abcTsSL+u6DZP9YW2nZfuauWQ6ie5q22AsAkeIIvGcTmEZzljKrtzDf3ZxsUg46aICr154+mG/yQAomRK9Cjg3RgxTNn6tVzT81RzX1n968BoZANc7Iv93mvzCm9KUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+3+ymXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D681C4CEEB;
	Wed, 20 Aug 2025 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755696746;
	bh=Khr+sh1I/ZX+wHTb1vmBfEArOF9CiW/g/noN8NNg++Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=S+3+ymXpP6zsx3TQOzIrq+Y9zvNbh/jytkhuEnMjKH6CVcHk95oiNE8eRpEw2cDCU
	 +PJyFjSLs/jd1/hrERRCPsrXz/VNhmigYN+beJdO1gBEo5VxoWOAiIxDm8H/kRa33w
	 OsdoI4Qbfn4u08wgOln2N6f5lVQvBkL69/yF1SaqPPJplE055qGjncnyYrf0TUyzeV
	 lGW+HgiJZtoPg6Gx3RFYgTzqa4s64IQaS8bv2liRp4QZ5kl7oGm0TeTX7lGBG2HSON
	 v1x5cuhiLclZshZkrdlNWswl+VP06uOUpVBLoz4j20nFNmV2CcKpuUXeHN/r+2LRpW
	 HcoW7MAASryMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 15:32:21 +0200
Message-Id: <DC7AJW8TYXYC.2N4JTF6R1GH9I@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <nouveau@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: nova-core: Update ARef imports from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250820112846.9665-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250820112846.9665-1-shankari.ak0208@gmail.com>

On Wed Aug 20, 2025 at 1:28 PM CEST, Shankari Anand wrote:
> Update call sites in nova-core to import `ARef`
> from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

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
>  drivers/gpu/nova-core/falcon.rs | 2 +-
>  drivers/gpu/nova-core/fb.rs     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

