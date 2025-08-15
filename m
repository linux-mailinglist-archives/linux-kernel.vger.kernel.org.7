Return-Path: <linux-kernel+bounces-770442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BC0B27AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30047AC1C88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172461EDA3C;
	Fri, 15 Aug 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WK4xzy9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE7319870;
	Fri, 15 Aug 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245889; cv=none; b=cckv7RAar3zC7nn/SgZg2FdfJou1alDS5O7OoGtZQLEcndw2vW33saP1kDsHV+eAiRf3x91w8OMLkQp/jsFKD1GpTw3Qhlo3CHlQKsRFPh8xUtv1EhGc24/YtX7cTBdF6lax1+xmAu3am7HMg45XH6EGgisozDWKbTiQo5hxk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245889; c=relaxed/simple;
	bh=Ura4Cw5zeqUllg2vDXrmco2AzSUohzVcX49voQ6lDDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jpJxFpEDSci0SwLYi5pj+bir2fy9Hc3LLt5891earlOxXBBdxuF5ZRAqHIwmB9U8+6PTKeE83c9LeTCi8V+g/ak0s8Y3Uh5jUymF8w3tYNtWTgNvCLlp6fhFcvtXTiOXLplqab1vYZZozEl2BZxZo38D+d53dg1PsMzcOjQcu0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WK4xzy9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDE3C4CEEB;
	Fri, 15 Aug 2025 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755245889;
	bh=Ura4Cw5zeqUllg2vDXrmco2AzSUohzVcX49voQ6lDDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WK4xzy9CN91Jd7kk3Let4DXppBbqKSDG0cBdf/Qw3JxeirLo55aLLbXjHQ9jp4TGP
	 j+s5bgL4tR6uTxJYN62vjtH7/UP/Q5S5bctJQfvuDzxjlRKbuPSZD2trg+TfPQJ+sw
	 Rhv839rqEV8SZJ4YK0fy6bG3UgFpULZJAmWfaaDKEQIQ4JYDCUa/ol4J2mIGinDxxj
	 P5DZF1w0l2XIr0a1JM07fJl1VXmUikSHg50cCex2L9+O79PObX3rF+wv6aK/GWzXwB
	 8u8Wi+OEv6MnWI28sH3Lbagoy6wSvRb24Vjo9K10eBnx0RYHMecBMvZLZgCh7qO1gi
	 Yrkxn7OYcFa1Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Boqun Feng
 <boqun.feng@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v7 3/7] rust: hrtimer: Add HrTimer::raw_forward() and
 forward()
In-Reply-To: <20250813224240.3799325-4-lyude@redhat.com>
References: <20250813224240.3799325-1-lyude@redhat.com>
 <I2ZymgWZUaEQlwyQAxcRdAPmVxyNLPdICP3qyPnokcGV0ZU7yNJ4KVgQW9cpZk9TjBV9mugXqeEk1WlF3-8exQ==@protonmail.internalid>
 <20250813224240.3799325-4-lyude@redhat.com>
Date: Fri, 15 Aug 2025 10:17:27 +0200
Message-ID: <87qzxddmnc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> Within the hrtimer API there are quite a number of functions that can only
> be safely called from one of two contexts:
>
> * When we have exclusive access to the hrtimer and the timer is not active.
> * When we're within the hrtimer's callback context as it is being executed.
>
> This commit adds bindings for hrtimer_forward() for the first such context,
> along with HrTimer::raw_forward() for later use in implementing the
> hrtimer_forward() in the latter context.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




