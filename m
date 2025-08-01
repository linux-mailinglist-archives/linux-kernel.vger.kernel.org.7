Return-Path: <linux-kernel+bounces-753688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0DB18665
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDAE170378
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FBB1D63E6;
	Fri,  1 Aug 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2Y0WSYG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35E078F4F;
	Fri,  1 Aug 2025 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068553; cv=none; b=jz2XwcZy0NTlI5z6y9+EZndUw7l1f/eTjFhM0FAZj71CPiv3dyWUcFp8GjiZJ40TMq393hls2OQJ7y01iPIqx3VQlo9djF30pqDHK/mTl+SI/h7IDQx91uTwr9kHUkyN3PBnihTyiyY03tdTILFepkN/aVj3pB0ZYDsJLwyQBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068553; c=relaxed/simple;
	bh=nelnHZ4XghqoyKBiCkcP1EfH78iEZSZS5aFwfrsjXBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=tPJ92Iyx2+pTp3PWKOLtTO6dJo73y1aQrzQFXuk+Anb2dYiw9CLKCJEqbRyjRaqt4YPV+AjTbw6aCESDmzyDwprewLf8pVbn+7+5b05FQqUwjLwwBLs585OBnRKq3eG8ejHwTtuMEYj5oRkhH1ifJdXn+fDNOCcKTGhdjRcB5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2Y0WSYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF98C4CEE7;
	Fri,  1 Aug 2025 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068553;
	bh=nelnHZ4XghqoyKBiCkcP1EfH78iEZSZS5aFwfrsjXBQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=c2Y0WSYG1k9X2hd10j7Lfm5ejhIp8hQ+BsppUZEWD8Bbm7p1gIZNaIrbUl9WnhpmV
	 CQwwjgA7UO8/45F1p1FiNSGMrBxkGL8vt8AYVYme26HvIx5F1j/4ZBOIyd+ra1uSy4
	 GmSNAhXmG5iM9beRvSddm9VZ7XuDn78NorHFx/noKYgTiRs7C/j3IWoj8/+gn1QlxD
	 7+NANU415f2ctLQ2hQFFVK88jX1auv1KqLNaWnO7ikXTudYuC5aMUDC6CK3VBtbsbV
	 HW1x0HYdVrxs2nSGNlC5cxMdOCSTCyh3AkcINGqCAefmyZlgpm23crvQFsOu64Xo9u
	 FYX0k+kv6Sw1Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 Aug 2025 19:15:48 +0200
Message-Id: <DBR9EMTZ8VTR.5G3CLY5N2IFV@kernel.org>
Subject: Re: [PATCH v5 2/2] rust: transmute: add `as_bytes_mut` method to
 `AsBytes` trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>
Cc: "Christian S. Lima" <christiansantoslima21@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250801-as_bytes-v5-0-975f87d5dc85@nvidia.com>
 <20250801-as_bytes-v5-2-975f87d5dc85@nvidia.com>
In-Reply-To: <20250801-as_bytes-v5-2-975f87d5dc85@nvidia.com>

On Fri Aug 1, 2025 at 3:24 PM CEST, Alexandre Courbot wrote:
> Types that implement both `AsBytes` and `FromBytes` can be safely
> modified as a slice of bytes. Add a `as_bytes_mut` method for that
> purpose.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/transmute.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

