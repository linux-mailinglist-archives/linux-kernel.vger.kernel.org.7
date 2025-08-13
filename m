Return-Path: <linux-kernel+bounces-766939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E9B24CF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2087D18941AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C82F6591;
	Wed, 13 Aug 2025 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/xm8xJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA935977;
	Wed, 13 Aug 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097665; cv=none; b=lRp73g/z8Vn8oXkJhU/NDwyux5F4opqeCs5BFV/GZd66yo25MllvIycSk81q5o97HZfITjXz5w13ocr4b+Thz6ruB0DCVh35E4ZV+qGNwUqCurG3CyrmoB3askApAcZquvuqvLe2/P63tnVmvVwY9yyyvxiCZQWuXjJE7symQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097665; c=relaxed/simple;
	bh=4gygrHPcm56qsPqtSIULPZO9eKZFnIsDVyMn5VmpQwo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=nSobGemFjSuWwW/ZtGgkvwiVE9L/ZPrjQ4qwX61p0DnD7AvJ0JCrm9Se3JwAT/stHqCzde58RkR0sIi6/qBZ/HdCvnXaJ9HwQeyoj2/dm5HO1Oqke+mea1qlZk6HZ4iEIdK+HwRC08nwyVygd7LJdm/lMZQt9ZZKsL2usPC5oRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/xm8xJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34F0C4CEEB;
	Wed, 13 Aug 2025 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755097665;
	bh=4gygrHPcm56qsPqtSIULPZO9eKZFnIsDVyMn5VmpQwo=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=K/xm8xJpakKu7oVtPtkeei94hI5k4tH85a16o5ygnjcVL3bUw5VeOh6SlW1x+QSMF
	 25YwJSlXoJ8P0qgeAMy9MJIlUKakzxd9nSx3rQTIXJByUV/FOUjJpsaG70o+xvIUu/
	 iyRY69HkDVsSbPHTiiuWDXc4zVd8LM9HbDcbcISotNmygJAJT31g0+vmrekV9ZhWwO
	 U43+M4ncy46NZmid+0H737mlzFXgY7v8wVQ9aHHKTHw1ZjtujyDWHUaFH9TQJkHs/i
	 InjE4h0Lu9pkQJ3c3tLOeIUp/fyfkjQxw6wZvyxmYc+wGlMdSTxlWbXqC2VToLrQux
	 iGkt7rXEG1SkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 17:07:41 +0200
Message-Id: <DC1E72OCYMMU.1C1EWX0YPDEOT@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] rust: devres: fix leaking call to devm_add_action()
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20250812130928.11075-1-dakr@kernel.org>
 <aJw7sx0p0Ec-oLkz@google.com>
In-Reply-To: <aJw7sx0p0Ec-oLkz@google.com>

On Wed Aug 13, 2025 at 9:16 AM CEST, Alice Ryhl wrote:
> On Tue, Aug 12, 2025 at 03:09:06PM +0200, Danilo Krummrich wrote:
>> When the data argument of Devres::new() is Err(), we leak the preceding
>> call to devm_add_action().
>>=20
>> In order to fix this, call devm_add_action() in a unit type initializer =
in
>> try_pin_init!() after the initializers of all other fields.
>>=20
>> Fixes: f5d3ef25d238 ("rust: devres: get rid of Devres' inner Arc")
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> This looks ok:
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> But can't we do it like this instead?
> 1. Allocate devm job.
> 2. Initialize inner field.
> 3. Use allocation from (1.) to devm_add_action() infallibly.

Theoretically, we could with a few additions to the C API. But I don't thin=
k
it's worth and I don't think we should do it in the context of this patch.

> This way, there's no risk that the inner value may get dropped, which
> could be an expensive operation.

If we actually fail to allocate a devres node on the C side, I'm not that
concerned about having to drop data.

However, there's also another reason why I think there's no need to conside=
r it
now: I still have the rework on my list to get devres callbacks in place su=
ch
that we can first revoke the Revocable objects of all corresponding Devres
objects, call synchronize_rcu() once, and then drop the contained data in-p=
lace.

In this context I also plan to directly embedd a struct devres_node in the =
Rust
Devres type, such that the *only* allocation that remains is the final one =
when
the user of Devres allocates for the final impl PinInit, that directly or
indirectly contains the Devres.

Once we have that, adding the devres node will also always be infallible.

