Return-Path: <linux-kernel+bounces-885444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A135C32E58
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0DB9348D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CFD2C11D4;
	Tue,  4 Nov 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHvpeYQM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9426A1AC;
	Tue,  4 Nov 2025 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287723; cv=none; b=DHpwZCjX5eyc7aKKd/synujrqtiAINOxA1OvGbySy3XqowYlS4/rYe+LRDDUHWw/loDWdm3bO/KzmKv8agmFEo/Vfdeajyykt9+5/maasPTTYb4NxFy0DLu9XMfjDeo1/FS0Qyiea9NSvcWGRmYVlXt/hqdmc4qlf59WGmTLHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287723; c=relaxed/simple;
	bh=RvBDaup8WpSALz42fvH5hCxQIBOpv+Q/H5aOOBTmmN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=ErSRVA/bqd4VbWw5TbfVeKXPBNucoEVWPSwPCDq6mh+RgqrNDK4Jzg4/0L/H3lrPBOdHr7WG09zYpGCJQBP2vg2ZltHW5fCfip+LT5qZYIJ4CMeHXbggXFMHaKbnY//Daej3jhgjTY8+JESQfhL+gtkjoMM4ZnFB4bWbdQUOySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHvpeYQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D47CC4CEF7;
	Tue,  4 Nov 2025 20:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762287722;
	bh=RvBDaup8WpSALz42fvH5hCxQIBOpv+Q/H5aOOBTmmN0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=XHvpeYQMvHCyL1EF0nPWxsOStmqYk384hVQ25l5zcWWp0z7O5RvzLl6xo7Lh20mch
	 YKstnnFu2AbWQEp29ii5RObFIAQCtW8DsJGbETOAb5ayElVwf6Ub54IZ+fm6qM0dk1
	 btEG/Sibb3lI6M8xRQ5nGpe8KVGkTIYba7QDpgZFpAqunBlj/ZhXy842HzhbtlZzdB
	 zIFMS9uzbT0EBroqveGuZ9iTBIQ6x08JlSRLQi3WCxn/CTlc0xVW9TalMRWjt7omW9
	 KfGvIOHH36R7IN4fZoHYr9PfkQaFjZtBxGUEqYDDEZebuCCqBNra7nVags0KOkQEkN
	 gjjT2ZYaYI3/A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Nov 2025 21:21:58 +0100
Message-Id: <DE06UXBAGY09.1D2TPYL4KNU56@kernel.org>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Jesung Yang" <y.j3ms.n@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Yury Norov" <yury.norov@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com>
 <aQgQv6F0Ao4DH6U0@yury> <DDZ3QBBUM27H.MJS1S3WHWJO0@nvidia.com>
 <aQkEVqbhoVMUc-Km@yury> <DDZKZFCK27HZ.DY3QVXKFU3BI@nvidia.com>
 <aQpUSw49QptgxjFz@yury>
In-Reply-To: <aQpUSw49QptgxjFz@yury>

On Tue Nov 4, 2025 at 8:30 PM CET, Yury Norov wrote:
> You switched name to BitInt, but still think about it as an object,

Note that in Rust even "real" primitives have a strong object character, th=
ey
have lots of methods, trait implementation and associated constants [1].

You can even implement your own custom traits for a primitive type in Rust.

[1] https://rust.docs.kernel.org/core/primitive.u32.html

> and that brought all the confusion in my mind. Maybe switch back to
> BoundedInt then to avoid this confusion? If you find it lengthy,
> probably LimInt or simply Lint will be better for you.

In another thread Alex proposed Bounded, because it follows the naming sche=
me of
other existing numeric types in Rust, e.g. NonZero [2].

[2] https://rust.docs.kernel.org/core/num/struct.NonZero.html

> Looking at how good rust macros work to implement bitfields, I thought
> that they will be able to mimic native types just as well.

I assume you mean primitive types. If so, I think there isn't too much we c=
an't
do (e.g. literal syntax would be nice) with BitInt (or Bounded) that primit=
ives
can do. Especially when we consider the strong object character of "real" R=
ust
primitives.

> With that in mind, I think that bounded integers are a bit out of
> scope of basic bit operations, and probably I'm not a right person
> to maintain them neither in Rust, nor in C.

I think it's fair to consider this kind of type as core Rust infrastructure=
.

Maybe a RUST [NUMERICS] entry would make sense? You could be a reviewer. :)

