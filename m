Return-Path: <linux-kernel+bounces-874565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CC8C16971
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126861C23482
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29434C824;
	Tue, 28 Oct 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQwbS4T1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ECE1AC44D;
	Tue, 28 Oct 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679241; cv=none; b=SIxudvqPKo+s25CfR+L64wT87LxHmagzTQQl5ixEw7N8CHJ2kAumu1mT8jVYSToM5yEAUMa6llIgoIKT2KW1l2tu8o1n2XOqVvS3b3H3XpCO272k7qz2ke22K2offQ8AbFidjb9GfvFTCkuwjk2zqXLhbvf+w+pGT9aFpA+T9Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679241; c=relaxed/simple;
	bh=gx6ddniI8SptQkGgjPPkhfyiZoEU9G1bnY2WRdoSRB0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=QtLQNdk38giKw83IgQDQmVYI9CLyd+P79gFfRX/1ep4fqExC+xBPwA86X4F81/Jito718v5E85QtFsSIeNcUwD1M8OhqMqedSbcVBolG7o6WSiDyuXcSaRjCs3DIIXStNw1unTTy89IoSlrD9rWeNV/xxPPNK3ASi5VMdNY48hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQwbS4T1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF1C4CEE7;
	Tue, 28 Oct 2025 19:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761679241;
	bh=gx6ddniI8SptQkGgjPPkhfyiZoEU9G1bnY2WRdoSRB0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=OQwbS4T1ACD2CHGWbxg3Ead3xm308aV7GlZtbM+so5z1VmVaL/waRLFvWwHRZfi09
	 MFNt0aFo+HFixdLiLP8ZAX8//QQ+MpHj8nPyP9QLIk81a9dt4dgKEWvxUMg7SAW8Qi
	 QvrtKCCAp8nMMhr5rDCdGJEir6xHlF6kaKUAX0KAgkFZI+eufjDz34N++NlfeVcNfC
	 MxSjH41XcgVeFFcynHuzVDhyKLtBDKBN8QD4MYAkGWQ9FYCLZCMZVTFKX/jlEyfeYz
	 WbsKllkHZ9CUd9NrvYU97lhi2h5L0AFl62OG2inwwSdcUSu4UByjAV4Wf167iBqDFP
	 HkNFoZPsA0IrA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Oct 2025 20:20:35 +0100
Message-Id: <DDU7649EY2RW.NX9QCDBO09BE@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 4/5] rust: id_pool: do not immediately acquire new
 ids
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Martijn Coenen"
 <maco@android.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Christian
 Brauner" <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>, "Burak Emir" <bqe@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Yury Norov" <yury.norov@gmail.com>
References: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
 <20251028-binder-bitmap-v3-4-32822d4b3207@google.com>
 <aQEOhS8VVrAgae3C@yury>
In-Reply-To: <aQEOhS8VVrAgae3C@yury>

On Tue Oct 28, 2025 at 7:42 PM CET, Yury Norov wrote:
> I'm not sure about this change, but it looks like a lock wrapping
> acquire_next_id().

It leverages the borrow concept of Rust [1].

The Rust compiler ensures that a mutable reference is exclusive, so there c=
an't
be two independent mutable borrows at a time.

This means that if an object A has a mutable reference of another object B,=
 the
compiler prevents a third object C to have a (mutable) reference of B as we=
ll.

So what this ensures is that object A has exclusive access to object B with=
in
the same task -- no concurrency involved.

The way this is connected with concurrency and locks is that if an object i=
s
shared between tasks, you would need a lock to obtain a mutable reference, =
i.e.
the lock provides the precondition for exclusive access.

So, (mutable) references are about ownership, not synchronization.

I sketched up a simplified and runnable example of the idea behind Alice' c=
ode
in [2] to play with, in case you are interested -- I think that clarifies i=
t
best. :)

[1] https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D202=
4&gist=3D5e67f1ea36b7e4561bcf5b41137284ec
[2] https://doc.rust-lang.org/book/ch04-02-references-and-borrowing.html

