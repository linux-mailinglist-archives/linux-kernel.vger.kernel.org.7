Return-Path: <linux-kernel+bounces-756317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0B2B1B29E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C02189CAF3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CB25228C;
	Tue,  5 Aug 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcXOefw5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57F199252;
	Tue,  5 Aug 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754393490; cv=none; b=uokMqPSrTgTS8YbcXn7xN3I1p2pdQxJo/mrorqA7tC+u8TK3UmC24CyfGH6n0EZzcz2Rsn2irT7KHQwXKoyadJprmc+8KcZekm6w1ThsPM99G01ZW+wcfvA5GUE6LoQWOJcPTD9s9iMGK1WD+GGVjYImSiymGMCx1JUyFVDlTUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754393490; c=relaxed/simple;
	bh=vcEdqIGDti60wtwS8tB1w3lsuctZKyPsi2kttMPEE+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAY/IPxoExomjtWT3zhOIbWlzpB/h3FJtijs99wK32tvUTo85of/RvNKLy5LqNe1gnFvSmeFG9y00PAj3yvxt1n5/iykHgEXu1kZasehG3PnGI+AqdtOvqqKY3lSmIqw+zFXKJK9ftFJViW9okh0xFLQFdhvmIOODphYUFQQinI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcXOefw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55F1C4CEF4;
	Tue,  5 Aug 2025 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754393490;
	bh=vcEdqIGDti60wtwS8tB1w3lsuctZKyPsi2kttMPEE+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lcXOefw5+1osb9agbetY2MO4OhJIvLTmy7UCqupsGbfhBmtAkMNj0hCwpjCQnFJrV
	 hSj1mM2OaIuLeiFsLi4q7vEpL+rXDrBt3sTBXOisG2akOza4LcHZAolX1cykhrgxrd
	 L2tw4K6XwCFMB9UVB56B2fQEFRaulKyUbYP9kWh9U/lcW1Boep0amIiMt3kQOF0aoS
	 QgUfFdIQBc1Si+HC+ZxfGg2dFtPzY5SMAimFW/h6rXiIaIwkBxgVXau1mqq95EhVYe
	 tRjzeuwhT8A+tr4oi/sET2L1vXn/jrASUALvA+UVXpRGRnpou+VmxH8kYCbTc4kHoz
	 JmY6r/cHNr6mQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Matthew Maurer <mmaurer@google.com>,
 Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Alice
 Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>
Subject: Re: [PATCH v3 2/4] rust: iov: add iov_iter abstractions for ITER_DEST
In-Reply-To: <20250722-iov-iter-v3-2-3efc9c2c2893@google.com>
References: <20250722-iov-iter-v3-0-3efc9c2c2893@google.com>
 <hpbmPd1Q-NkvYKLgqaQjVLXCh6FOGHnM7qKDqY2kMnrK27N9UT2w1xvS6x4c7aO9_lQNI_G83Jh_usDUF-BPEQ==@protonmail.internalid>
 <20250722-iov-iter-v3-2-3efc9c2c2893@google.com>
Date: Tue, 05 Aug 2025 13:31:16 +0200
Message-ID: <87y0ry80or.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> This adds abstractions for the iov_iter type in the case where
> data_source is ITER_DEST. This will make Rust implementations of
> fops->read_iter possible.
>
> This series only has support for using existing IO vectors created by C
> code. Additional abstractions will be needed to support the creation of
> IO vectors in Rust code.
>
> These abstractions make the assumption that `struct iov_iter` does not
> have internal self-references, which implies that it is valid to move it
> between different local variables.
>
> This patch adds an IovIterDest struct that is very similar to the
> IovIterSource from the previous patch. However, as the methods on the
> two structs have very little overlap (just getting the length and
> advance/revert), I do not think it is worth it to try and deduplicate
> this logic.

Is it not like 50% duplication? `as_raw`, `len`, `is_empty`, `advance`,
`revert`. It looks like it makes sense to me, but =F0=9F=A4=B7 We can alway=
s do it
later.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



