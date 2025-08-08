Return-Path: <linux-kernel+bounces-760005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72EFB1E587
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F3D1891B40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39026CE39;
	Fri,  8 Aug 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XggvVwx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA42AE74;
	Fri,  8 Aug 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644825; cv=none; b=aFU33RnMOxTYcNF9L4OPpK2dY79R/rMczY1WZmc+zzV+K36510EEEioanMI/WgztBeAjHFYGaEoWBtYIHWtkBmcJXXgbCLb1IscRFr16+9XQjqPlXzoN0ugj5nNTgeAfFH8cWuDJuip72jBnoOa7ml1mCaA2Z6NaaWOCssDG+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644825; c=relaxed/simple;
	bh=fsH3FY1TtWsBU5vVB/xf2+33DwdvvhKLsQWiUFmFlD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SD5HdqVo4YdF6xtvDL8AOjoU2e21DKYFQAfM22J8JlqpMieZu/LezqB9jRNpTtobYIMx+UgFtMgsLLYt7kcrWqPtdrVxzhNY2rJI+xbfn7/HtWcxB0m+RZJSFNrMym4f6bKMH7m+QX+Or1jlEMI0XzYjYcjuX65UXdZuDc1lNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XggvVwx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3698C4CEED;
	Fri,  8 Aug 2025 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754644825;
	bh=fsH3FY1TtWsBU5vVB/xf2+33DwdvvhKLsQWiUFmFlD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XggvVwx0HFTHHRLUCwn1jf7y2BBnrJsdDkocP8tRa2Kc2dGx5T1mMWAQUWbdt/CRs
	 kFMZmY59jfoD/UHAOwTDqXa5N1Qc35qw4TkWxpZs+ydDqfEYzk3bqbO0sRnipNj1Qn
	 DTbCGHas61DiX9HtQo41jWfXus2XbdezYbbIz0aRRPG1I8WLdzyRD4P+rsk9DflsGl
	 5sg4SKkLhfR3KbYAdcz43hAJvIx+m0wXS+YI31PpquxQzKDJm3e3UONLCSIGJIlTw3
	 JGvvTmLYS0PpvavbzqpVcDdMRFKO1+bNX748bEcZGuu4I95m1AaaIMXWYsKbQukT+F
	 7mAOXqRAZSW9Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic
 operations for Delta
In-Reply-To: <20250807190649.3078875-2-lyude@redhat.com>
References: <20250807190649.3078875-1-lyude@redhat.com>
 <9coN5hyUhlBbyIBIsxHQ2OWeyfwo-w6q_maEF1vLGbkamYSNucOtkYbzEOoJzgo8N7OlS53uWByHZ3IFn0JeFw==@protonmail.internalid>
 <20250807190649.3078875-2-lyude@redhat.com>
Date: Fri, 08 Aug 2025 11:19:44 +0200
Message-ID: <87v7my5fwv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of the
> basic arithmetic operations for Delta types.
>
> Keep in mind there's one quirk here - the kernel has no support for
> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
> simply provide Delta::rem_nanos().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
>

I think you missed Alice point regarding units [1]. delta x delta does
not return delta. Division does not make sense either.

Best regards,
Andreas Hindborg


[1] https://lore.kernel.org/r/aIXVzIwBDvY1ZVjL@google.com


