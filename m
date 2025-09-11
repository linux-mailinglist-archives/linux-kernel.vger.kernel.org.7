Return-Path: <linux-kernel+bounces-812864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E02CB53DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6563ABFAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447BC2D5947;
	Thu, 11 Sep 2025 21:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuOStxxE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB0A23A9AE;
	Thu, 11 Sep 2025 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626505; cv=none; b=PIH8U3aMrUiq1y4Cwfx8EVGoyLRP/bQXiUHHlpL3b3FOH48I3F6QxZ/z71BpjUgeCzS6/QV64gDgRiK7fqB5f0N479dpgDfQQlRH+35kK7qR4bpg++57/o5T75GDYyyGgz1+DTLPkdSbwTu9RX+z71fhClkSngqZ+Rclxv5rbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626505; c=relaxed/simple;
	bh=6S7cnRBahP7waeate5OLUBAKOBuFVtiU6l+V2btdO0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RMwDHONmoNvs6uLYbGvnyaHvKOKLV4E7Df6gEi57SdavDa6iMXfICEQTuvRafK7r1Yv8ZXbsdQ+X1AwdR78+fDyCveQ9GFM/6dfjo23K3r/aR0mYMBvEaP62mrf/pLDxV2DjsMlafef+jVvJoP+Z8fIgamaLAsoOR/alyKiZgVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuOStxxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55465C4CEF0;
	Thu, 11 Sep 2025 21:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757626505;
	bh=6S7cnRBahP7waeate5OLUBAKOBuFVtiU6l+V2btdO0k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SuOStxxENm9N6T+GP5yk+9QzOOPCfBvhxtpD2gh9vFq5h47Onplnaq3/aWiAVEAmq
	 14uB4I5c1tV81FdKQe4FfXao7DYDYm43WzvLxnj2omVR3nyxSym1r6OD3dpsMUGjtN
	 zMkZoNAVnwUpBHyEf3gIgcotQCwMVFdAzfc2DSHV2hd/iJwchv7JkffH64H94WvkGE
	 88p4Zoa4Z3mp2MXVzxb3rOkKamx5Y/XibfBH9En2fWeihIBAULL99+KixQWDB4ENrj
	 oDfeEkNeQBRosJT629ZcAA+7TOKxmpG0HoPCtfsB4gasEzYACwuVFrNKERpWAGwlej
	 wfO1cBA1MAfJQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 23:34:57 +0200
Message-Id: <DCQALE6Y0J50.2EW4N2X25ZTO5@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
From: "Benno Lossin" <lossin@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Fiona Behrens" <me@kloenk.dev>,
 "Christian Schrefl" <chrisi.schrefl@gmail.com>, "Alban Kurti"
 <kurti@invicto.ai>
X-Mailer: aerc 0.21.0
References: <20250905140534.3328297-1-lossin@kernel.org>
In-Reply-To: <20250905140534.3328297-1-lossin@kernel.org>

On Fri Sep 5, 2025 at 4:05 PM CEST, Benno Lossin wrote:
> Allow writing `_: { /* any number of statements */ }` in initializers to
> run arbitrary code during initialization.
>
>     try_init!(MyStruct {
>         _: {
>             if check_something() {
>                 return Err(MyError);
>             }
>         },
>         foo: Foo::new(val),
>         _: {
>             println!("successfully initialized `MyStruct`");
>         },
>     })
>
> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b8=
98336e2d54f80715f00ce00f21f74d2f
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to pin-init-next, thanks everyone!

---
Cheers,
Benno

