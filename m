Return-Path: <linux-kernel+bounces-786265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F7B3577B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BD22077C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4CD283FF8;
	Tue, 26 Aug 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJqd/1g/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA628371;
	Tue, 26 Aug 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197935; cv=none; b=J8y9yLFw7Kgi8+e6fbysvpu2Qu6dFj95rMZYqevXEUx03i79t6/uNsPpk5CsAutcxZ0zs1aJrEiFBud2xhTLxXZWghyMpRixgACs+5oCQfC1QUoWmrfooeP/cByZSkClAiPh82JmuTsKIUlWGV97C9dNJfQ2zTE+WyjZrkKaa4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197935; c=relaxed/simple;
	bh=R61IV7cr8iemY0WmVZFNaI72L7yRCaCDEndX4PJJX4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JY2mNo/XyADDBFO1R8u1pEsdRUYXHQmvlRi6o/BfMvB4d16lO+L5/U8QhOUsqUQdU0rwKqn9AOEkwvg7om+dTe1t27XBQffemZU3RecIAh1TYBpfaDkpNNqn0Usrh/bQVK+SLZLRwKLsBCoe12IBkS75ywqrZZie4plAhqv/weM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJqd/1g/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8A3C4CEF1;
	Tue, 26 Aug 2025 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756197934;
	bh=R61IV7cr8iemY0WmVZFNaI72L7yRCaCDEndX4PJJX4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XJqd/1g//QkT8Kcrss0aQKr7e7WhueGPxMYqpq0m28+qpECgW5dWUVv38P6MkTpdU
	 TTUwQSTuerXMp/OROCW3oAydI72idALLn6VwINczBc/wsWUXNClqQ5BrOUXlnZsI+i
	 YdOiBDQzmQlNUqNiZ1zKxkbrLnmKVTQfNzGK/e1bNmuKV2Vu4pfSv3e4Xv1qnGTrBq
	 5Sa8T4zkLeiKuf0pSYKb3mos8GFJ9+nBp5cJGDEHEqGbk1AX9A4dHPMvfcSASc0iG/
	 +k6B0NXY2LYJzzk9u7HwzdkMMloFQs1a/PACdIl20/+qRVlH6z4d9hjYBu8YQSbsWj
	 8NGLvAORyo9xw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/7] rust: time: Add Instant::from_ktime()
In-Reply-To: <20250821193259.964504-7-lyude@redhat.com>
References: <20250821193259.964504-1-lyude@redhat.com>
 <M47gPhUazwIKesVp75-tAKbSWHdW3SXDqgWhliRKQWUcAvrD6fM_qhNIsWuQx5YH4h4KBwZ1-RK2ZsKwBHyATA==@protonmail.internalid>
 <20250821193259.964504-7-lyude@redhat.com>
Date: Tue, 26 Aug 2025 10:45:18 +0200
Message-ID: <87ecsywjxd.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> For implementing Rust bindings which can return a point in time.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




