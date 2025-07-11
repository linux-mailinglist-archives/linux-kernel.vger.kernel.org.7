Return-Path: <linux-kernel+bounces-727009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B1B013DE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC87AC3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65281DDA1B;
	Fri, 11 Jul 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUAb/EvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA82110E;
	Fri, 11 Jul 2025 06:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216554; cv=none; b=Lfs7ss4qzCDJacDhdhEGcLeqGhwi5pC8LWDoKs1kIVqTXhy0Y/JKpCs2kZKdrXZPf+D6JvNT5CKgd/QvaWjR3JmbSUWsPKZx+0gSYtxvkJNGu/pGvNmv4ErEXSVGIXf94OiTJpN4I6ZZYp5wfLNDDHk/y9wnHz/mWl+vZRKulbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216554; c=relaxed/simple;
	bh=laUJFAuvCxqKC4pikdP+ObtJ2n95s8pB5xklDm1IXEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nHo9aQc2xhkXeHJSp2mKQ8ZM8YHEcIh2J4+OJgeqIPmbGSu+U+Z3tJf81paHA1Z6dQWlZF1HvNXjUBn6NuS8qlMca0yQtK0Q0wSyCclzXYNPydyH9mF2e2HeUGP388+aFUqL707/Rp+g5BFULbGk7VmrF+Tbyuh9ZECnEYt17us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUAb/EvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF82C4CEED;
	Fri, 11 Jul 2025 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752216553;
	bh=laUJFAuvCxqKC4pikdP+ObtJ2n95s8pB5xklDm1IXEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rUAb/EvOLKSwN5WSl9Wa1es/g6L8F1sgse1yXo/CKy1Ws0Ay4jOsxPQbfOHYEV7BD
	 KLOwrP9bFKhkTWTHLN9T6LQwrfZbDj+MAcPlHwD0wxTCsIkucy4bG8u5mJJd+LKo6N
	 d071CUVmitGAXpfdN+OUo4qx+MTRvNDrvCSW5KkDDw38g4t5jzYf4QXQQNS3ysNIBR
	 72qZ2ObEFP/RZXgwmF9XDKpx3FnlPw/0R4HejBiSH061At9egBPWpcGjCcWDGt03LD
	 +UPfQa/sJFs2gfObGRN/u6SJoyUf5PRcx/JZ5x/RhdxchDt7SZUdAJX9Dc3Z8HW5gj
	 Z5c8pVp8oBJxw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <lyude@redhat.com>,  <rust-for-linux@vger.kernel.org>,
  <boqun.feng@gmail.com>,  <frederic@kernel.org>,  <tglx@linutronix.de>,
  <anna-maria@linutronix.de>,  <jstultz@google.com>,  <sboyd@kernel.org>,
  <ojeda@kernel.org>,  <alex.gaynor@gmail.com>,  <gary@garyguo.net>,
  <bjorn3_gh@protonmail.com>,  <lossin@kernel.org>,
  <aliceryhl@google.com>,  <tmgross@umich.edu>,  <dakr@kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: time: Pass correct timer mode ID to
 hrtimer_start_range_ns
In-Reply-To: <20250711.153729.1327324726276230605.fujita.tomonori@gmail.com>
	(FUJITA Tomonori's message of "Fri, 11 Jul 2025 15:37:29 +0900")
References: <U1GgPfpPwSjzh5jPpFlN22bT2BSjlaH8vLHYY6hAt_vJ5w4irwIYRPV46r73Cs5Dx73Ikz5ku7_qPWrl8Tntfw==@protonmail.internalid>
	<20250710225129.670051-1-lyude@redhat.com> <87jz4fi72a.fsf@kernel.org>
	<Jlcb2BYQGgrQ9n7-UEbh-tmbIbJdg2ju8RIXRLNH4cdkdqloip3e8e3jbQbdpNkFDxNZD_5Oqq_uNoNySv0hXg==@protonmail.internalid>
	<20250711.153729.1327324726276230605.fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 11 Jul 2025 08:49:01 +0200
Message-ID: <87ecuni5nm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Fri, 11 Jul 2025 08:18:37 +0200
> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>
>> "Lyude Paul" <lyude@redhat.com> writes:
>>
>>> While rebasing rvkms I noticed that timers I was setting seemed to have
>>> pretty random timer values that amounted slightly over 2x the time value I
>>> set each time. After a lot of debugging, I finally managed to figure out
>>> why: it seems that since we moved to Instant and Delta, we mistakenly
>>> began passing the clocksource ID to hrtimer_start_range_ns, when we should
>>> be passing the timer mode instead. Presumably, this works fine for simple
>>> relative timers - but immediately breaks on other types of timers.
>>>
>>> So, fix this by passing the ID for the timer mode instead.
>>>
>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>> Fixes: fcc1dd8c8656 ("rust: time: Make HasHrTimer generic over HrTimerMode")
>>
>> Wow, thanks! Miguel, can you take this through rust-fixes?
>
> I think that this patch fixes the commit in timekeeping-next.
>
> `fcc1dd8c8656` doesn't match to the commit in the current
> timekeeping-next (this patch might have been made against the tree
> before it was rebased).

Maybe Miguel can put the correct hash when he applies the patch.


Best regards,
Andreas Hindborg



