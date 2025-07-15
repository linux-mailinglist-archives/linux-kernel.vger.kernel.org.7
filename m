Return-Path: <linux-kernel+bounces-731457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8181B054A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DACC179D17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2D9274B4B;
	Tue, 15 Jul 2025 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKADQuv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45F6223DEC;
	Tue, 15 Jul 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567638; cv=none; b=E8fP1xaDOErCew5At5tZHTeQs5OhxJy2yPwEbBqKr7Agwg05d4CR84duz7lwV4LxrwH2k7VYqRNzOrRLM1HBkfLyWjhH15rUBxgprzCe3neXF3LZYe9Awo2nvmrV/VLDrBFEyQF79IS+zXB8Wsv7z/MKQW/jESXH53QwO5IfjhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567638; c=relaxed/simple;
	bh=4C99WCRl95vysW9X4cgEpN2c7Ll8EXlm5bMiuDtyk1o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=JHtYXWoAUE4LvDwfls6+P7BNrXLqliOf4kUKLpaqLH1phisCLq0t382u3Px7GYwArQ6HNwpzONzz0b2vze4d9b40P673I1d+qWp/VqFi6wluE55U7y/53tD+gGyUkZgqje+XaQ57VCPN2g2VAYERgmvGoquZCIOZRP8aZ0+QbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKADQuv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF238C4CEE3;
	Tue, 15 Jul 2025 08:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752567638;
	bh=4C99WCRl95vysW9X4cgEpN2c7Ll8EXlm5bMiuDtyk1o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CKADQuv7niD3JynUeVzcG9sVX6AzmJPJ8v8dU0krU3JcwoHv4otROIkZnwpiCV4VM
	 hYZtBjjPE++9s6ywmUO7KG7R4qHWGLt0dRIYRSGww/uOJa+hWQ2B5YIwsDe3MMwSij
	 3gzQPht6xetnX1fI+714K/VlhdzNl612jh2FPeWloehJedsl5bwiFKVu/3ONMwTrPY
	 0SD4YZ5W0BQ7hvaWWyeYKJFgf0xzB1UrDd4LUvr/n/6ogAFbSmnwP4hBlyyKyOjq3d
	 frePcYqTBkb6CkF5mQczYHt03Cl3v+66tLtnkUhCocxEcMeGo3tGNGCXL11JMIWz85
	 Nalf2voi6R3TQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 10:20:34 +0200
Message-Id: <DBCHDKA3SV70.1N60UYLTM58OB@kernel.org>
Subject: Re: [PATCH v13 2/3] rust: io: mem: add a generic iomem abstraction
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com> <20250711-topics-tyr-platform_iomem-v13-2-06328b514db3@collabora.com> <aHYNeEjQXz3CxfEM@google.com>
In-Reply-To: <aHYNeEjQXz3CxfEM@google.com>

On Tue Jul 15, 2025 at 10:12 AM CEST, Alice Ryhl wrote:
>> +        {
>> +            // SAFETY:
>> +            // - `res_start` and `size` are read from a presumably vali=
d `struct resource`.
>> +            // - `size` is known not to be zero at this point.
>> +            unsafe { bindings::ioremap_np(res_start, size.try_into()?) =
}
>> +        } else {
>> +            // SAFETY:
>> +            // - `res_start` and `size` are read from a presumably vali=
d `struct resource`.
>> +            // - `size` is known not to be zero at this point.
>> +            unsafe { bindings::ioremap(res_start, size.try_into()?) }
>
> I thought a bit more about this, and I think it's fine for these sizes to
> be converted with try_into()?.

Fine for me too, but we should add a comment with a TODO to get this straig=
ht
in the future.

