Return-Path: <linux-kernel+bounces-726960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D4BB01369
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAAF1890BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319E1D5141;
	Fri, 11 Jul 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWynDrwZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA2AA92E;
	Fri, 11 Jul 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214726; cv=none; b=dSAUHUdFDfmSQj47zm1NpY/baxXMo730KdkppuEEhMzx2CLkyqUJ+ac9TtxTLRLdQzLTzX/8cGqq1suLY8e+4KKRBSx2atKe6iPkETf2ppoG8FISZ9AHeZdAX5Sp+AgbGpnfAUYdxptSPE//a7bKFK7FB6ygdsFqLglqGIExJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214726; c=relaxed/simple;
	bh=IhPBLsDyP0lJ1wB9QAcUuSmK9aEPSglH53xEhDaPnwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sX4v787hOCHLDiYVSdQAY89ofApnGmtwfn3KnJRBQ8CqVwVaQPlwfJklWDAhiog5jvi53Hs1GxiiLsxgwpZdsu3WznXWwUy1Q5lVP2o5N3lqgIObcPVrO+OPxX6qUuzNrHFau1POw9FvazLUl844W+ey/KJ/07hHu6ToNa6XEKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWynDrwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5055C4CEED;
	Fri, 11 Jul 2025 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752214726;
	bh=IhPBLsDyP0lJ1wB9QAcUuSmK9aEPSglH53xEhDaPnwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rWynDrwZCkV6WqQxyL1NAwNVuoxEPRKJgHsRaw39ob7pPObHtxNGbK6MM+HewkYtc
	 u/5jdX8Z3fzTxcYdj+IuegRzsOsbwnSrhHxK7TgutVfmugR29w1L1GxxoyLoIg5U3Z
	 Gx01h/MRTDvjDdb9Ibqm0D7f+tUADEf4OR8FQ3sOMgO8c6Uwvo+VdMYtJ8TPv4lMtD
	 rJ82cKfQTjGqfUzb57F7yFfeWaI+xK1SP8e71FSjfJCUoO9oyW4fMPHGf4QLH8W53l
	 ngIOmDCiW3J2qpM7rFbvZU5gFVax9QcgLEmFQp8z4QV8hTS2FTCPiDB4RXSTa90lJB
	 rxlScRKdS2qRw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: <rust-for-linux@vger.kernel.org>,  "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Frederic Weisbecker" <frederic@kernel.org>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "John Stultz" <jstultz@google.com>,  "Stephen Boyd" <sboyd@kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <lossin@kernel.org>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: time: Pass correct timer mode ID to
 hrtimer_start_range_ns
In-Reply-To: <20250710225129.670051-1-lyude@redhat.com> (Lyude Paul's message
	of "Thu, 10 Jul 2025 18:51:13 -0400")
References: <U1GgPfpPwSjzh5jPpFlN22bT2BSjlaH8vLHYY6hAt_vJ5w4irwIYRPV46r73Cs5Dx73Ikz5ku7_qPWrl8Tntfw==@protonmail.internalid>
	<20250710225129.670051-1-lyude@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 11 Jul 2025 08:18:37 +0200
Message-ID: <87jz4fi72a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> While rebasing rvkms I noticed that timers I was setting seemed to have
> pretty random timer values that amounted slightly over 2x the time value I
> set each time. After a lot of debugging, I finally managed to figure out
> why: it seems that since we moved to Instant and Delta, we mistakenly
> began passing the clocksource ID to hrtimer_start_range_ns, when we should
> be passing the timer mode instead. Presumably, this works fine for simple
> relative timers - but immediately breaks on other types of timers.
>
> So, fix this by passing the ID for the timer mode instead.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Fixes: fcc1dd8c8656 ("rust: time: Make HasHrTimer generic over HrTimerMode")

Wow, thanks! Miguel, can you take this through rust-fixes?


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



