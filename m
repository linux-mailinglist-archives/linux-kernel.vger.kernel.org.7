Return-Path: <linux-kernel+bounces-774549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52702B2B40B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE39C5248B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43982275B05;
	Mon, 18 Aug 2025 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1NVH3wR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F71E0B9C;
	Mon, 18 Aug 2025 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555409; cv=none; b=pAA5b7Yp9Wd8ornSou/7biYd/zwIScduAHg8NoE3RPusGFlOozPnCgrM5NLjVj2W1z/u9aXUGB+SPdKSRkA+7tKzj7NDu2Y60gBtC/EfKvYvCFD6rJv0CsYBmcC1VeRhyQkjufr/pGWcm/2Fboye8Zqnfd96sN965FPl4WsxbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555409; c=relaxed/simple;
	bh=aar4KTOME9V0w9cBkGFvAg6tf9ZINGNl76ydQC+q7N0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q9cdWEqu2QoDeqkaYBZ1E/R4NrwyCecdFPI1X0OtQ9dyVmdn8p8dzKfSd00MYt6vkw8VvlR2Ue9e8ZgQOBqAimg+3pckgrkKtlSIkstSVAUGjjJyqpBcQhmdxKgxNnoWBZsNApYBQ/W1pDrtPZfFGdEVPhBpPLpwH0a53qGCnWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1NVH3wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17DBC4CEEB;
	Mon, 18 Aug 2025 22:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755555409;
	bh=aar4KTOME9V0w9cBkGFvAg6tf9ZINGNl76ydQC+q7N0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=u1NVH3wRnfmBGLq7UR8UtLFXQS8iTRrTCozoNq1NDOBDxZHzhRapoMmi27aERp/GE
	 y8C7id7HHYQKcuhnd3EvX7BwPUuxj2vBydVhu36Bo8nwSo3F9tXWYBeGn3wUc2Kr7q
	 qdDa9b2A7Cqcu+jvQJ1JrvRgy6XOhkFv2a5BcKXWiVzeD/g/pLFEMsXytWTIMKD/Uc
	 9+8sffcZWyfWNXlqo5jJ89k48FzUsB5MV1sGd99ScbHNLaS4hbwjERVMdgWRY3TaMy
	 G6i6YjrteokhLLS+RWQDNHl9qbzVX0IzXqhCjNLGvp0XgExZ5zyAsWW93gzRDPghhn
	 XLb+FLCQmsWyw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:16:45 +0200
Message-Id: <DC5WGBH8BEXQ.3I46BC22QXM8S@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: sync: Update ARef and AlwaysRefCounted imports
 from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250818191034.523381-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250818191034.523381-1-shankari.ak0208@gmail.com>

On Mon Aug 18, 2025 at 9:10 PM CEST, Shankari Anand wrote:
> Update the in-file reference of sync/aref.rs to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Fixes: 07dad44aa9a93 ("rust: kernel: move ARef and AlwaysRefCounted to sy=
nc::aref")
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> This follows the commit [1] which moves ARef and AlwaysRefCounted modules=
 to sync/aref.rs.
>
> Apologies, I had missed out on changing the in-file reference call for th=
e modules. This should fix that.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D07dad44aa9a93b16af19e8609a10b241c352b440
> ---
>  rust/kernel/sync/aref.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

