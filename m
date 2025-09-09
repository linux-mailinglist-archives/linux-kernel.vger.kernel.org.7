Return-Path: <linux-kernel+bounces-807346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C60B4A341
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5438B4E6A6C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087282DFA2B;
	Tue,  9 Sep 2025 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuqXD3p+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B1A2376EB;
	Tue,  9 Sep 2025 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402149; cv=none; b=vFiGvxpul7WBOXlggG1EfFZuTRpFPv/ZPezNbOtXeVhGiNxxiJcz1J2MM7feQ43L55MxHCIf0tZXjqdCG60bl3wuiog0KSsyEjkfSdp7+mT++HP0Y5C1hwSt+gb4zAMkiDH0nFnCB2SXNcQKB4H1Z11OGJZv9LtGx8ViyF+mELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402149; c=relaxed/simple;
	bh=RFv8WE0t+fG24zP0bACAOxveoc/FFPUxvEbHvaCGNIk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=UlKAz5vH8Om8GfbPx5CjFJoTuZk4jy89q1RL6szzUsfn5hR+rYdhufDePrA8jrQKQR51nly9+xNaOGUITB/kOBQVa4LD+zx2ScMNgFySeMldtpy38gdz4CI4tIdMZAs/rrnxQNPgWn3pZiDI+Ra9MAnl1BwAtK1eyKpOx7NDw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuqXD3p+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E38C4CEF4;
	Tue,  9 Sep 2025 07:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757402146;
	bh=RFv8WE0t+fG24zP0bACAOxveoc/FFPUxvEbHvaCGNIk=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=VuqXD3p+q6gIcKkFajQtIWTrHqoYQYOW4CytBZ/r/FLA2wFYg5q0KfSz671kYpzLW
	 vSxkam4n6PuHvHDqXAvktvXSi+GJEPYs5YDxCIv8JH66YassbFnqrKhDMgMSpUEhh4
	 +aEA7Ew+herAQR8kb0sQrzZMxaI2bv6bHujZB+HcGe116WL1ap+AQdUJoz5/fDa31B
	 09JbTPSSrPHtcH5LITWJpH0UrySNo9WGpjFr1KyaForgpAHKbxRP4ZlD+zympQMCbu
	 kZeGZJBdLw2JSle/LzWI72e+EnZiMyo86pQNL5qZfwJosnUEwqyv/R4Lsrk792AV3A
	 077kVF26v5sAw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 09:15:42 +0200
Message-Id: <DCO32EPVU4ID.3J103NTRH5IQY@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Cc: "Liam Girdwood" <lgirdwood@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com> <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
In-Reply-To: <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>

On Tue Sep 9, 2025 at 1:10 AM CEST, Daniel Almeida wrote:
> +/// Enables a regulator whose lifetime is tied to the lifetime of `dev` =
through
> +/// [`devres`].
> +///
> +/// This calls `regulator_disable()` and `regulator_put()` automatically=
 on
> +/// driver detach.
> +///
> +/// This API is identical to `devm_regulator_get_enable()`, and should b=
e
> +/// preferred if the caller only cares about the regulator being on.

Preferred over what? :)

I'd link to the alternative Regulator API.

> +///
> +/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.h=
tml
> +pub fn devm_enable(dev: &Device<Bound>, name: &CStr) -> Result {
> +    // SAFETY: `dev` is a valid and bound device, while `name` is a vali=
d C
> +    // string.
> +    to_result(unsafe { bindings::devm_regulator_get_enable(dev.as_raw(),=
 name.as_ptr()) })
> +}
> +
> +/// Same as [`devm_enable`], but calls `devm_regulator_get_enable_option=
al`
> +/// instead.
> +///
> +/// This enables a regulator whose lifetime is tied to the lifetime of `=
dev`
> +/// through [`devres`], but does not print a message nor provides a dumm=
y if the
> +/// regulator is not found.
> +///
> +/// This calls `regulator_disable()` and `regulator_put()` automatically=
 on
> +/// driver detach.
> +///
> +/// [`devres`]: https://docs.kernel.org/driver-api/driver-model/devres.h=
tml
> +pub fn devm_enable_optional(dev: &Device<Bound>, name: &CStr) -> Result =
{
> +    // SAFETY: `dev` is a valid and bound device, while `name` is a vali=
d C
> +    // string.
> +    to_result(unsafe { bindings::devm_regulator_get_enable_optional(dev.=
as_raw(), name.as_ptr()) })
> +}
> +
>  /// A `struct regulator` abstraction.
>  ///
>  /// # Examples
> @@ -146,6 +179,29 @@ pub struct Error<State: RegulatorState> {
>  /// }
>  /// ```
>  ///
> +/// If a driver only cares about the regulator being on for as long it i=
s bound

s/on/enabled/

> +/// to a device, then it should use [`devm_enable`] or [`devm_enable_opt=
ional`].
> +/// This should be the default use-case unless they need more fine-grain=
ed
> +/// control over the regulator's state.

"unless more fine-grained control over the regulator's state is required"

With those nits addressed and the unnecessary helpers removed,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

