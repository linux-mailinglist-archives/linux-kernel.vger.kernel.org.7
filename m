Return-Path: <linux-kernel+bounces-774546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BDB2B403
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458631B287AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87627CCC7;
	Mon, 18 Aug 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJrrm33d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F727AC4D;
	Mon, 18 Aug 2025 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555213; cv=none; b=Acqk/PvuKMwkQk4EoEN86qWrcWU0t9ryHddMexmaY7a7b2wBiVhLDx4aZ/ZLvfmPhkXSLqv1vaiuRShPgcwwfGr7+qAJA5Qe2N9RrgyZlrzsrztvto6xDpQVSM2EPYZGzn1r2jKFbzhAPj8SclvG771NsJVnEtlVm7wHamsMVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555213; c=relaxed/simple;
	bh=Ev5jEi6T62cCQdFjMyXbCs312mTkIIynSG606C1CjdM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=r0/S2vXnoum/2BSfcV7L/CnTAoBaGoFv0maJfwzPnDFj7LsuazCLgEd0H3Vu/m8pUoaiSQD6xruIQQF7BOgrpl91Er3VbSssNhhHjY4pegfXWgrkG8O50/4djcndtf1YIFsc/tZ4obOyBrQwJzUSfeUdBnYYw8RriTZbVJqTo1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJrrm33d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A785DC4CEEB;
	Mon, 18 Aug 2025 22:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755555212;
	bh=Ev5jEi6T62cCQdFjMyXbCs312mTkIIynSG606C1CjdM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=gJrrm33dcxgOpjDVyNL65qMwZnbcfX454fYJCIqGeLkOpElxWxdeweSwo2XSbZMAQ
	 2NXMXhts/9EwSDV9wjOWCD24++c7bYHSX6PZLZ47xo5fMctF/vHaB2FQRYEFLN+Lo7
	 iMiAhaDgzTUv+eS1Ses1GPQUQNmJp7UITFkKIFyxr6ffLM7S4SH4czcvSNup9x1UeQ
	 8LgzOnExv8F9qJb7UfdtNGSDVEitsbLeQ+km0+Thkp7jXt6x7352SsQ1GvHxdHue0j
	 SKiI4q88hxXkv0XVidJQImdYc/td3AQFlpwgiJ4rffHaP9JBRsnoEpG3JUlI3UvSj/
	 6Z+e1ixJ8i4Rg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:13:29 +0200
Message-Id: <DC5WDTAHIGV7.369CKJDU3KUXS@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pid_namespace: update AlwaysRefCounted imports
 from sync::aref
From: "Benno Lossin" <lossin@kernel.org>
To: "Shankari Anand" <shankari.ak0208@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250816122323.11657-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250816122323.11657-1-shankari.ak0208@gmail.com>

On Sat Aug 16, 2025 at 2:23 PM CEST, Shankari Anand wrote:
> Update call sites in `pid_namespace.rs` to import
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to `sync`.
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
>  rust/kernel/pid_namespace.rs | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

