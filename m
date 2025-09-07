Return-Path: <linux-kernel+bounces-804752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0EB47C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322523B9AA4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B19284B4C;
	Sun,  7 Sep 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvcQCEIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18E199935;
	Sun,  7 Sep 2025 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757265453; cv=none; b=EeINNkp6MFZd4wcfWecEMxLVXOK6QbQldy8Xk/U7G127rA8lvg1fb47Ph+xtEEevZHq7rkjEFzE3sdTW149JsfZa00MX3au4DvEJdg4AtNGreqqazfBv1U4sXCW/utQl9IpJnDQCyQIJ13vwskD/iZZsIJXSvW6Jv/pIJu70Um8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757265453; c=relaxed/simple;
	bh=oLlWLQqL2NNjUFOximcNDI+64aI6fOXdL6hqqNDCVls=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kVw3thJOCOnKq20/NHzY9fnFRvJ8tp60zP7z943mtYauYfrPWygJIcmIn93P/udmJtWYsw65pGp9THoZ+UY2OQs9aZ+NnMwIhj+8Xo706EXqFY1VsTpGSQlbtDrjDlcm5Xd/1+/VQAVc9SsgYOJ0TKDQAj3WpO2II1DPzj/1lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvcQCEIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E99EC4CEF0;
	Sun,  7 Sep 2025 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757265453;
	bh=oLlWLQqL2NNjUFOximcNDI+64aI6fOXdL6hqqNDCVls=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DvcQCEIswbUW2x3bTY69yRDiqJWXwIGbAmVy6KnHWZfBzPA9V+2gKvgq7bCNEtw0o
	 wZ6xzglrmiaCr77GbULJObmrHJXvA5nIb/aRD5mun4qfeElW76ephBN697ybtZ19lI
	 qY+qTGeO3cWYOsiuGH644sbTy+lHVwlN4N86W5D9CrBVNunpVXJTALzobLMN77ZBXH
	 itOe6W5x3pttHFpOVrp+LOS8cIuPvekRBotFA1qf34NfNKjhHNu9Aa/ghk4xQd3+NB
	 1rl0lCw/HR7bkfqSqRgZ96FJeUDMmQnUHa+Bds3sQ4ILqaRZHI5hzviVQ1aKTOIlmi
	 u+NE2F9JXiNsg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Sep 2025 19:17:28 +0200
Message-Id: <DCMQM2OEGCWN.ERJD4G3M1JQ8@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Fiona Behrens" <me@kloenk.dev>, "Christian Schrefl"
 <chrisi.schrefl@gmail.com>, "Alban Kurti" <kurti@invicto.ai>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
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

Tested-by: Danilo Krummrich <dakr@kernel.org>

