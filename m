Return-Path: <linux-kernel+bounces-759909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4C1B1E460
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CBB18C1698
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D523266565;
	Fri,  8 Aug 2025 08:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW+F9GPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DC4A11;
	Fri,  8 Aug 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641629; cv=none; b=FanS2BeBu4QYZeQCm6SHdnZ9KN6WKo82wQIiDQpHYCt6530CGzcFiJiz1Cmep+xJtcVexbWq9YbkyWr9/Alh5moLr+fOJt+gA2AGGjEeOeOq/QOBh3DcXKFJu1dB2GTAxPB2VaT3VKeAzNK49PAeMr/KcIVUIbO/tn5zKgId1Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641629; c=relaxed/simple;
	bh=R61IV7cr8iemY0WmVZFNaI72L7yRCaCDEndX4PJJX4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lbvKOZeXiX0rcdOUChJC4tD+s2wB29aqxoq6+0qyoIU85yU8WU/MBeyFTxu6tKehcUBkzspczYp7QAT5yN0GXK5diDgULKYLwx/xQ8o/QmNp5FdQIX2gYE4Vu9QqhP8zn20uu0Yns0WnHZG5bZEeIz3tLZ/oaJIuQDJHnpYZs74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW+F9GPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5B6C4CEED;
	Fri,  8 Aug 2025 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754641628;
	bh=R61IV7cr8iemY0WmVZFNaI72L7yRCaCDEndX4PJJX4o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bW+F9GPsCwvzvnk5yzzAKBc8HUDaa7PtC1gHHOAe/Xl8E5laCX99cluS7WdK/+SdA
	 cKP5HgglIZO9PRfS2pM+uvJJo26z72lZDu0G9Gqzyu4FbV6SVJEUr8qep6rjGXmXdP
	 RWgsie4oow2hzwIWpvevV2d5geWR05iybXzYB2guDTmPXAfq75UQPFHD+zVN+G8bpf
	 +w2D2NQo2yGz6+Z57ncv9NNxKAmVQJYyru093crEmckfttxLV3y+D6nQHH6rtCPeRI
	 bZ7+/CpVbeKT/kJvmv2QQ+m1e5Q022JCe6dTIW4dOWyjz7pUTVkgt3+LErcn6+/l9y
	 Zpqh3JdsKeIGA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Subject: Re: [PATCH v6 6/7] rust: time: Add Instant::from_nanos()
In-Reply-To: <20250724185236.556482-7-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <LY2kmMXxEF1D0iSiWPZ3CYRDUHMmMhqr8W0WbZKqvobIYNcU3cntVHAVGbX6mozRNJXB3KF4Sp8ByD3SytwcnA==@protonmail.internalid>
 <20250724185236.556482-7-lyude@redhat.com>
Date: Fri, 08 Aug 2025 10:19:02 +0200
Message-ID: <875xey6xah.fsf@kernel.org>
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




