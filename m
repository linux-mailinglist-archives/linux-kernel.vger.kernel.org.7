Return-Path: <linux-kernel+bounces-774534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36914B2B3E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E601B284DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5027AC32;
	Mon, 18 Aug 2025 22:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzmCKb1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7996274FC4;
	Mon, 18 Aug 2025 22:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554597; cv=none; b=L2AuDnmoy3Tx+OERhb3bTqzv/JLuQnFscAGk3uhd+edeg9FrpsPtdOpNHiBse3hMYmFeZn7o7v3vpQfSxvN6+ENf7vdp8bbKOkiX38ORlTrUR5MGX2NvM6uIB0a2reWLjACprfgWO8LO3p8lreoqFxr7euoYFs9dN78/q5tKREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554597; c=relaxed/simple;
	bh=bpFsBQg0HvRwChPPpzOaW+uJaM85Vaih3GQRNpQxzAk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=kLU0Rebj/IRJCWzN8ntVOOXu9xKm0bNmgRpFoc/g69DNaJtHnVhoXMnGV2eFwgMtDJDi5zit/Jx8lacPnztKtOyuDRmODd1CXk9Z3rsZydR4VVVYGw43D9fhKKTb/F8ZW3aWNTn9Du4Dog6JB3vuPSN2w1fXLAmyThdsbYO0jD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzmCKb1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B741BC4CEEB;
	Mon, 18 Aug 2025 22:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755554596;
	bh=bpFsBQg0HvRwChPPpzOaW+uJaM85Vaih3GQRNpQxzAk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jzmCKb1FFK99d6TwjtOvr+jYMLqRpt/Ux4UocPkhECX78zDNhQF9t8M3BGHndB8Af
	 IK8Bo0p/6UhzsBxljY2p5Rvr5jvgq9IpmQYhDVYwdLnpaRi6y/m9aZDmUzX8d0fU7i
	 0WzAA8HQzFLER73Lsyh/ofYuKF7XnE6b7PrbbYfkNjHieEtqSMqokSI2jA8FWYt8dr
	 iA3X/GiSXy5hMJVUVaad0ZSvBPsBI4p9A2KHQ8btyxJHwObIncJWJqH4Ovbeeer/ed
	 JO+VNDprT+nmwiGNABCxkRudo7DDW3phgnr6MuwIi8Gs3/F/c87fRaFqWMyQliALJT
	 IwJPPcPd59Ytw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:03:11 +0200
Message-Id: <DC5W5XTPD0AG.2AQCA1X5FZBE8@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: miscdevice: update ARef import to sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Arnd Bergmann"
 <arnd@arndb.de>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250818132806.134248-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818132806.134248-1-shankari.ak0208@gmail.com>

On Mon Aug 18, 2025 at 3:28 PM CEST, Shankari Anand wrote:
> Update the import of `ARef` in misc_device sample to use
> `sync::aref` instead of `types`.
>
> This is part of the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to the `sync` module for better modularity
> and type organization.
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
>  samples/rust/rust_misc_device.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

