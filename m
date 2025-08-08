Return-Path: <linux-kernel+bounces-759780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5D1B1E25E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B1716CA67
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB84221FB1;
	Fri,  8 Aug 2025 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYxJdjbS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD721BFE00;
	Fri,  8 Aug 2025 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634852; cv=none; b=TOCP7VsH3Gwq/0HsQRfjnDSlhcggY5px0H4rXl0QucDgyfW7zdJQim0QR6meCxSsps1REw97WLoIiKlxaXp7gJw7Vv92J90bCXmf2LFfeNKNJfQjqtFcnAzJdw0+Aj6w5P9/w1UoELbnVQ+D5x+u7xN1e2aVQKeK3rmJdQtfcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634852; c=relaxed/simple;
	bh=ATW9vNCxb1rnbDaObyRWJtyhRtkMXi1VhaLZGXxZbkU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sOJB69MzyIcgunapVIaBffm2qE+8SnyqolwZKxf05f50Hqs9TDBotm99bpfXEn7kQj12W+i4s9rz+AEl+df4qbNSRW3QRowhl9DeBPANYYSXSEmVqKZ4koMuhPLcXJFu1gSfdmfDnHZOS2bxDhhgg5w5KYpd7eU0RWNNKBE0C04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYxJdjbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF82C4CEED;
	Fri,  8 Aug 2025 06:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754634851;
	bh=ATW9vNCxb1rnbDaObyRWJtyhRtkMXi1VhaLZGXxZbkU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uYxJdjbSzjXZbIGa9xc1EVu09rIR0BfbDTJUmGNShgCzxdSD7aYyxOvQVgTGrxOJX
	 TcvhaWGfp8ZwDw1Q0W2/Mw23VtFEd45OyFWMX48Jag5wILkYJrUXYo11qZE8z4WDmj
	 EHjDOeXSgXzw0/HTTT1THCKfKlB9obnaQjXfMHCNiDSZPWXJwhXTuC5ZyEgxUtsb6Y
	 VFU7JQSwJyderNXcPl5FFbckZ8lPrhPujLKx+2CupfanVB50OItxsIsUd+4vJKDGV1
	 zBNiVX5U0Aky+PYzml3nLBV/PtnUjI7icF9ARbUo3qZ5mfy2fpalnV8Kt1oVThS7tw
	 YVBzJnqBTXDtQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 08:34:06 +0200
Message-Id: <DBWU54JHWVNO.Y3EEXGS9TSSM@kernel.org>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for
 Instant
From: "Benno Lossin" <lossin@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250807190649.3078875-1-lyude@redhat.com>
In-Reply-To: <20250807190649.3078875-1-lyude@redhat.com>

On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
> In order to maintain the invariants of Instant, we use saturating
> addition/subtraction that is clamped to the valid value range for a
> non-negative Ktime.

You're not using saturating operations in the patch?

---
Cheers,
Benno

> Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> ---
> V2:
> * Change behavior in ops::{Add,Sub}<Delta> so that we panic on overflows
>   under the same conditions that arithmetic operations in rust would pani=
c
>   by default.
> ---
>  rust/kernel/time.rs | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)

