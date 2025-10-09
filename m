Return-Path: <linux-kernel+bounces-847251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA4BCA5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020FB427347
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4D823B61A;
	Thu,  9 Oct 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNC7TuaN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F655635;
	Thu,  9 Oct 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030318; cv=none; b=r5VL89eafJCb/2f2a+4z7W1SBDnJ/B73WmxbG7wka2w/EA78ZRPiae9PpEYIgNoHqv38T5Dat73HJGkHLWl+Tc2pZlrDK1f0oc5mhAH80v2Lo0j/X9RX21+IkEc7TZzEPPOgrOUs1F3GUt1e2S2gjMCNFtnK9uiyr86TfcnJKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030318; c=relaxed/simple;
	bh=kFsIMObArLcyoFFIMA4L5RDZSvrQbbMBoX1+KItsqQU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sKjmxtvMiSAVEH88HRP7BvUehFwGEmN1RpRD3cFDoY6tIWY4R8IWb2XtoOh9PCWA9nDK8lIgpaD9RSUkKM5gYfOqgxaYoFtF51jcIPGZx8kjE7I8jcwE46g2x8KfY+GjOdw5U7b3dVJE+rKmGuyYWKYe2a1CPjsMpS7IX5aHf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNC7TuaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC0BC4CEE7;
	Thu,  9 Oct 2025 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760030317;
	bh=kFsIMObArLcyoFFIMA4L5RDZSvrQbbMBoX1+KItsqQU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uNC7TuaNBQ719jUSqL2ej2bN+y/WjYBNMvCjjaLce+TWEK2i7X7xetVsaFN0tggaQ
	 /kHdfDbiFPi9VIL+/2DAvZ7X+4lPJe87kjLeoLFqTj28gjko1F3HqQ6Jh+E4PRicjT
	 usCom3hlJ5aN2hHwmsMPsmFraTCddLbfEkJ9+M+jahqgMFdfAeSXOGqpBHomAUHlF9
	 1rQ3EI69b/izWALKWqMneqA7y56ccCEe28uZBvvhLs9V/1hFxWWRAxD9Cy/UuT6d0d
	 XrU2mJEWZmkvKyHd6mGkxDhM9vwlEf5055TosfKJjLXCdPmIreLB27+Qtgla5JEgtU
	 0RgEaTJJ2DG9g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 19:18:33 +0200
Message-Id: <DDDYOBOZTF7Q.124VJDF4C76B6@kernel.org>
Subject: Re: [PATCH RFC v2 3/3] gpu: nova-core: use BoundedInt
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feong@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Yury Norov" <yury.norov@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251009-bounded_ints-v2-0-ff3d7fee3ffd@nvidia.com>
 <20251009-bounded_ints-v2-3-ff3d7fee3ffd@nvidia.com>
 <aOflmmHe8O6Nx9Hp@yury>
In-Reply-To: <aOflmmHe8O6Nx9Hp@yury>

On Thu Oct 9, 2025 at 6:40 PM CEST, Yury Norov wrote:
> On Thu, Oct 09, 2025 at 09:37:10PM +0900, Alexandre Courbot wrote:
>> Use BoundedInt with the register!() macro and adapt the nova-core code
>> accordingly. This makes it impossible to trim values when setting a
>> register field, because either the value of the field has been inferred
>> at compile-time to fit within the bounds of the field, or the user has
>> been forced to check at runtime that it does indeed fit.
>
> In C23 we've got _BitInt(), which works like:
>
>         unsigned _BitInt(2) a =3D 5; // compile-time error
>
> Can you consider a similar name and syntax in rust?

Rust is a different language and has its own syntax, I think we should not =
try
to use C syntax instead.

>>          regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
>> -            .set_base((dma_start >> 40) as u16)
>> +            .try_set_base(dma_start >> 40)?
>>              .write(bar, &E::ID);
>
> Does it mean that something like the following syntax is possible?
>
>         regs::NV_PFALCON_FALCON_DMATRFBASE1::default()
>             .try_set_base1(base1 >> 40)?        // fail here

Note that try_set_base1() returns a Result [1], which is handled immediatel=
y by
the question mark operator [2]. I.e. if try_set_base1() returns an error it=
 is
propagated to the caller right away without executing any of the code below=
.

>             .try_set_base2(base2 >> 40)?        // skip
>             .write(bar, &E::ID) else { pr_err!(); return -EINVAL };
>
> This is my main concern: Rust is advertised a as runtime-safe language
> (at lease safer than C), but current design isn't safe against one of
> the most common errors: type overflow.

Where do you see a potential runtime overflows in the register!() code?

[1] https://rust.docs.kernel.org/kernel/error/type.Result.html
[2] https://doc.rust-lang.org/reference/expressions/operator-expr.html?high=
light=3Dquestion%20mark#the-question-mark-operator

