Return-Path: <linux-kernel+bounces-781738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94147B31615
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6CA22205
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1462E2F03;
	Fri, 22 Aug 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIfvdYlb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C3253355;
	Fri, 22 Aug 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860730; cv=none; b=VfXfWImvs/Zu9F9XzGCf9NU4nJl02COF/LOryfrGBcvqxuBd51U1S5pgsB2Ta3JfzFUqRogFZYmVslywZ2uW/2aXWjGajLYEPzyb+CRjEB2glLpZyKf5a012l5z6odyziacd+qoBaPtAvtZvKsN6BWaP+c+6ThyA/koxnNUzz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860730; c=relaxed/simple;
	bh=WJf6g5RzafPQV91L2VIgFZn7ZVuqRfgK1tvm7SBza24=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=dk25QM7H7IA4odEpAXZoCcqekwd/XJS43kuYFWvesi2blXXCDN69ycAQRuUgnSt1HXbKiXojkovlrIbOGKT4Yt0o6aaoYYCFu42/Qsnqq+69wGCNI2C/oRKk09cZS9JXDUAwbkLpRX6tsq5exdG3hIkgxI6pIhACyQjI49k9Nug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIfvdYlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE74DC4CEED;
	Fri, 22 Aug 2025 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755860729;
	bh=WJf6g5RzafPQV91L2VIgFZn7ZVuqRfgK1tvm7SBza24=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=GIfvdYlbRH5IIFq4bXFlt6CRdt01QKOGW3IwCR8DvTJ8Gy1V6y3W8SwFRHPCm7/bu
	 XvY3Ttkh6vYbxe6aNuvh34/KpCA1QMKEsYr/fiO5u04KF0hoeYcZ69JCyC7JzPESJO
	 SA3fG0IlQytBFERdE3qkky6Wrb7BCT24vUBsLIPn2cTD6tLVZHXebQ8Ht7/C8ydCxl
	 dk1Qp4MFSRFBeBBjBcpDJVsqsoRXoY+17Kvh3wTvYZVECYXsZsWhKxWRiXb7vSCuUm
	 xMQWvzbrpwdxtc5fqFDJVZRo4W1hhI9xLLp6wR+1K2LLlm4K0SNCB8dEnritsbedY5
	 dJxOiy/FxxcMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 13:05:25 +0200
Message-Id: <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Andrew Ballance" <andrewjballance@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <maple-tree@lists.infradead.org>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com>
 <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org> <aKRx8xsY8CpzbeEm@google.com>
 <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
 <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>
In-Reply-To: <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>

On Fri Aug 22, 2025 at 3:40 AM CEST, Miguel Ojeda wrote:
> So, as a rule of thumb, probably we don't want to show `unwrap()`s in
> examples if the code could have been written "properly" instead

I think we never want to use unwrap(). Even in cases where we relly want to
panic the kernel (because we reached a point where otherwise it is impossib=
le
to prevent undefined behavior) we should make the panic() explicit.

I see it fairly often in reviews that an unwrap() sneaked its way into the =
code
for things that can easily be handled gracefully, such as simple range chec=
ks,
etc.

We should probably check if we can get a clippy warning in place for this.

> , but
> `unwrap_err()`s (i.e. error ones) within an `assert!` are likely fine
> if the example would be better with it.

I agree, for obvious reasons unwrap_err() is much less of a concern.

Yet, it might be read as a pointer in the wrong direction, i.e. read as "un=
wraps
are OK".

If we want to check for a specific error type (or cause) in doc-tests I thi=
nk we
should just use is_err_and() instead.

For instance, instead of

	assert_eq!(
	    tree.insert(100, the_answer, GFP_KERNEL).unwrap_err().cause,
	    InsertErrorKind::Occupied,
	);

we could also write

	assert!(tree
	    .insert(100, the_answer, GFP_KERNEL)
	    .is_err_and(|e| e.cause =3D=3D InsertErrorKind::Occupied));

which is exactly the pattern also shown in the example of is_err_and() [1] =
and
entirely avoid any unwrap() calls.

[1] https://doc.rust-lang.org/std/result/enum.Result.html#method.is_err_and

