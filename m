Return-Path: <linux-kernel+bounces-886469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F44C35B00
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007ED1A21B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40583164A0;
	Wed,  5 Nov 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeBik6wo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453ACBA3F;
	Wed,  5 Nov 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346767; cv=none; b=rBq2INd0FzAFYO/9Njllk8CLTbkI/AFsl8hYM2q9EfgfeYh7nzDWN7vuJtxzWOMXhFw8fj6pouW7XI87pFgxOqaFaicJ14r9Ta/yR5a6ZHxswB+OlB+bTtzjBk21vCvpELH89uoN6rFEJibze8lwyx/rhVSc5rGldYVGVU7woDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346767; c=relaxed/simple;
	bh=BvDEj56XAXsDodkx5Q02Yxf+Bi9/3xVLnsDizWqbYsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOB/hiPFjZMOeK0VaVyn0Qn8t5SMHo8o213JxP6NlsenRd41IbIQakkhwITdzHkaTyARficeMN+ves+r716BGaFBVcLCbFbj6uu5o9Fx/vy20ch3ygj2yM2gSFct9Ko/V6yghYI3BqNnLSvWr5Qn8MaCF3VAWo1rowiE7/7XL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeBik6wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8321C4CEFB;
	Wed,  5 Nov 2025 12:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762346766;
	bh=BvDEj56XAXsDodkx5Q02Yxf+Bi9/3xVLnsDizWqbYsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SeBik6woaFJ+bXX3qvAsU4XjVrK1txJelzrGr66pJraD9/0mmqMzYnnX7e0QliwMx
	 js6/DJ58gIhVGx5SupL3rZc2EiPCjFO4w0HdQFEoZioygXloAHZRRO+CqZGcoF76QG
	 NHcyBp8ne3cwzFVBDlF5a2+IChS9yB4t9hg/RXV33D2FS+J1nVGJENQX/J9HlKEjjZ
	 mT/mPhqKcHZQrfJa3VAE7Hrcbubizvq5m5jUt2TqBq/X7/bk+QNTVVrdXAUNeXrx28
	 N5F5TqMLWLFrOQhNenLYtcgmQ3c+qLOgyH+hszMeSgUl34WSYhYMSEacMIeKa0D9Qa
	 14dQ9+DPch2Eg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v13 11/17] rust: sync: lock: Add
 `Backend::BackendInContext`
In-Reply-To: <20251013155205.2004838-12-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-12-lyude@redhat.com>
Date: Wed, 05 Nov 2025 13:45:44 +0100
Message-ID: <87wm447imf.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> From: Boqun Feng <boqun.feng@gmail.com>
>
> `SpinLock`'s backend can be used for `SpinLockIrq`, if the interrupts are
> disabled. And it actually provides performance gains since interrupts are
> not needed to be disabled anymore. So add `Backend::BackendInContext` to
> describe the case where one backend can be used for another. Use it to
> implement the `lock_with()` so that `SpinLockIrq` can avoid disabling
> interrupts by using `SpinLock`'s backend.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

I am not convinced this makes sense. This saves us only a few
instructions. We already have a counter on C side, so we are not going
to update the interrupt control register if we don't need to.

I'd like to see a micro benchmark showcasing the gains that we get from
this complexity.


Best regards,
Andreas Hindborg



