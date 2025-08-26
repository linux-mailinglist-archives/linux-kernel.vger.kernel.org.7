Return-Path: <linux-kernel+bounces-786779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340A7B3691F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0086F2A401E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591F350D45;
	Tue, 26 Aug 2025 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD8/csbP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05634AAE3;
	Tue, 26 Aug 2025 14:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217570; cv=none; b=P/uruOtDUnWjo/Brbn/7bWxHCgyFD6jRi/nklQ+xDR/8qxa1a/c2hoxYnI8skGbHj0hPRtQIDOcLhXo9SAvR1Tm3Pb4Qtb5keqsCwD9xIyE0aophC+Htr918NmNqyyoKB40zVE2fH1nHTEWlcyv8ZjVh5XmYbdHLNGgDq2Kjt1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217570; c=relaxed/simple;
	bh=jw97/hruOqeHK3ikO2O17mWtCmkipydodlOLbqzTH1I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=JbSyAoNJjKCtwdPIJt3bNqZZZjtnndU834t6KDZ0wgbETumzgj5l4WjD2FLletofnl/mGqFbKyFMBS0kFXvr14GmAUrrEQeA9L/nZAiL2eQ46BEcOo24bv5WnkebGvOboNnwhRH5FJU14SPkZxfzKqCRxXpCmyqYMoopOXWwNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD8/csbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94422C4CEF1;
	Tue, 26 Aug 2025 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756217570;
	bh=jw97/hruOqeHK3ikO2O17mWtCmkipydodlOLbqzTH1I=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=pD8/csbPMg9dNLwG0laIQLjxT2Gy0uN3gkBUg2ZgMGyne2Wu/fFs+4WyJyFK6s7sq
	 3JybzRU1grdQ24NyHnZzvLNhGET/ZBynS4xs7ghcw7bC4/PD14oKvFNwpiJXWa53nh
	 fxzRsxBcZnnFfzmhPn6GFAcFsVZgntoVsoHzuqsQwt9O7jwHMP8Y6XM2kKz9QClPtW
	 gAe2S4BUHQGBPZMXP9+FCCaRi19MAdPAtxw0MHXSSfQSjnSgXNvzNtsM2RHZP+SvfH
	 hi3YJzGWeCjmO6HuE3jSt63JHHVwEvcIUTIGIzh6Xs4OIA+zpyxvpAbSW6Ybez9nTJ
	 v5XrhRQR7yHyA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 16:12:44 +0200
Message-Id: <DCCF63BESWQ9.9LC8MZK7NG1Y@kernel.org>
Cc: <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>, <ojeda@kernel.org>,
 <aliceryhl@google.com>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <frederic@kernel.org>,
 <gary@garyguo.net>, <jstultz@google.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <sboyd@kernel.org>, <tglx@linutronix.de>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <daniel.almeida@collabora.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout_atomic function
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <20250821035710.3692455-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250821035710.3692455-3-fujita.tomonori@gmail.com>

On Thu Aug 21, 2025 at 5:57 AM CEST, FUJITA Tomonori wrote:
> +pub fn read_poll_timeout_atomic<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    delay_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let mut left_ns =3D timeout_delta.as_nanos();
> +    let delay_ns =3D delay_delta.as_nanos();
> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check ag=
ain.
> +            return Ok(val);
> +        }
> +
> +        if left_ns < 0 {
> +            // Unlike the C version, we immediately return.
> +            // We have just called `op()` so we don't need to call it ag=
ain.
> +            return Err(ETIMEDOUT);
> +        }
> +
> +        if !delay_delta.is_zero() {
> +            udelay(delay_delta);
> +            left_ns -=3D delay_ns;
> +        }
> +
> +        cpu_relax();
> +        left_ns -=3D 1;

How do we know that each iteration costs 1ns? To make it even more obvious,=
 we
don't control the implementation of cond(). Shouldn't we use ktime for this=
?

