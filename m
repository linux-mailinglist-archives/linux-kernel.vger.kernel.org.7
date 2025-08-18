Return-Path: <linux-kernel+bounces-774531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F26B2B3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CF7620D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A91227A925;
	Mon, 18 Aug 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIsZmG9f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8291CAA85;
	Mon, 18 Aug 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755554450; cv=none; b=FYBcwvEHrMwczxYW9rslOo+GDkBq2hc+85vZkAtM/OgpplmIO4Jt3ZQv+B68yYDJucKWOePQNtWOmOi3nN4QKK62AhUQU36NvUWH1FIRgn1/eGJwv1RhI6dzLh75QBcY2gY5GaUDVMAJMTDhTApkhIuClQ/LGkYL7oMU3+CqFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755554450; c=relaxed/simple;
	bh=7xdRSu3yuYWbOst77dbEL+lRIYNYXotOyq5T3LRic/Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HDGioSeSfzhfPAIgLMczRUJIETngEh3lLKZ5rShA7w1CF7tGot8Y5cusO6qZcEhqv6CBil+Zv/28gD/zz4jb6VUX0dwHJurCC4n1vYCPXd4eglA+6XrIFE9WEFBMc5oh0fM2WTEZOv9NtxWjIhw4SAsQNU+ZLlT12ZDR8bqeT00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIsZmG9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA89CC4CEEB;
	Mon, 18 Aug 2025 22:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755554450;
	bh=7xdRSu3yuYWbOst77dbEL+lRIYNYXotOyq5T3LRic/Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aIsZmG9fAN2JECx9Ca0EZHLsviLPjxkHaChQMXolg3KUkQqdsDVE9iNe9iCco1Hy9
	 44DKtbIAMM1hOQHRj1ZTWEb8iOX299ovtv3gzEtR2PFAgiNmIZB5RF6J3OLMr+BP1o
	 68f37s13kj5dK1V2eNfAQxP26+90sW09OXWqpGDvtAnJ9Fn9TwGWkaqgDUVKOAXbGm
	 z7DKW5lbVcol572FlPbCeQd8bXq03bXRfsj8HC6zZ6hKiiemqg7iBI2A5kpDYFbjiw
	 Scv2Fgda/xRajRIe5XQxs+i3GI4qV1qEbNiPUh1ZdFFDZ4lLrozLqW7u7WkVJdXoY5
	 Pj5gtZi5SgS+A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:00:45 +0200
Message-Id: <DC5W42NRS92U.3DYP6CWWHWJSE@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to
 sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250816114409.10107-1-shankari.ak0208@gmail.com>

On Sat Aug 16, 2025 at 1:44 PM CEST, Shankari Anand wrote:
> Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::aref`
> instead of `types`.
>
> This is part of the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to the `sync` module for better modularity.
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
>  rust/kernel/cred.rs | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

