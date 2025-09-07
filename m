Return-Path: <linux-kernel+bounces-804636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB0B47ACC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4FE3B02D9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D726059F;
	Sun,  7 Sep 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyR2Vgy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12FF23C4E1;
	Sun,  7 Sep 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244044; cv=none; b=CvJb6/Khqv4d20mLbnxB4l9/Xd2ylZLsdLTHofYjbVaDKtJ+HYqLZ90SRozGmgiO+QSceLS72MyqQOUdVPR90RwbgNWD8LTMF3PBS0Xil7AhkgkslK0tiEdFeWGRw8o5Wpnt37/2F0bqCleut8e1lzjEm5QKeUx+gD+HmM0DUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244044; c=relaxed/simple;
	bh=W+tZ1hHLzeFPjFSuytJSHu3noWSm4+BSVcgpYeNBgZA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=R1PCv1T6kTN7TFK3LEXxNLb0IcenIM5BsGhd6TTR7BOFivqb7M/zO9pB4wxy9F+iGfZNgzHshpdEiis0+6ckoH91zTD5j51bnJ87bS7AYHpyDkIs7gg52slKm0VSfatQQxTcqbu9ZNAYZlvI7czbj0FbvMMt9uzf69HNtZWD/Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyR2Vgy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EA6C4CEF0;
	Sun,  7 Sep 2025 11:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757244044;
	bh=W+tZ1hHLzeFPjFSuytJSHu3noWSm4+BSVcgpYeNBgZA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=CyR2Vgy04n2nbW9wpSWKcV/i+vMXKEaxJ3c+SDwmfsRL4j3sXaErtqsapHs/SM+WS
	 J9htMLDuR8s1am7b/NGCikkS3MRopo+VpkJn8D0JN86I6kbeKJsiF9EcgA2rQpd5td
	 ogwuaieksaPl00w6AaJPo981y5mY1+daCYliFyv6dtbqGoXbvjm1Y8zcGw7iGmAC0a
	 LyUjMF+HOLWyG6ZSA5ML8Yw78Bdk7rxrmxeKpvHQUsJQ05G9zsXz0o62FRZGemM9Cj
	 G8NFfw9NEgxiVtVsKfXlmHUNOD77zGWhKdsYh0ytwtJ0ud45BIFV4xGdww1+qlCFGh
	 1m2zLUdz4RSqQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 13:20:39 +0200
Message-Id: <DCMJ0VFOV9L1.33BPI08N4H7WZ@kernel.org>
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>, "Alban Kurti"
 <kurti@invicto.ai>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
References: <20250905140534.3328297-1-lossin@kernel.org>
 <aL1lHyhzWX0xGrmo@google.com>
In-Reply-To: <aL1lHyhzWX0xGrmo@google.com>

On Sun Sep 7, 2025 at 12:57 PM CEST, Alice Ryhl wrote:
> On Fri, Sep 05, 2025 at 04:05:31PM +0200, Benno Lossin wrote:
>> Allow writing `_: { /* any number of statements */ }` in initializers to
>> run arbitrary code during initialization.
>>=20
>>     try_init!(MyStruct {
>>         _: {
>>             if check_something() {
>>                 return Err(MyError);
>>             }
>>         },
>>         foo: Foo::new(val),
>>         _: {
>>             println!("successfully initialized `MyStruct`");
>>         },
>>     })
>>=20
>> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b=
898336e2d54f80715f00ce00f21f74d2f
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>
> Nice! Would it be possible to include a user so I can see it work in
> practice? E.g., for the irq feature?

Devres needs this too, but the corresponding devres stuff was a fix and is =
in
the current -rc only, so that's not a candidate.

The IRQ stuff is in driver-core-next going to Linus for v6.18, hence, using=
 it
there, this patch would have to go through the driver-core tree as well.

For me it is fine either way.

