Return-Path: <linux-kernel+bounces-786360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D059EB358D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33AB1895D24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3192318143;
	Tue, 26 Aug 2025 09:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBALH3cG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A03F31812A;
	Tue, 26 Aug 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200386; cv=none; b=q8mTFt4ljlgzA923agzvNtfSj4XLb2yyN7yB7zRF26w3pIzgYCl6DQx7LdGlocVAo2cpyZgTqXwNT5OyIoqpreufh0PXFTDyb9QUiXQNo02AsP4dH1TdBKU1nEx43bfutFwBntjfNmIV7tu8NofNfzRMz9X98po4FOriiAmEDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200386; c=relaxed/simple;
	bh=uh61s/bC5B+781PVWTw+9HkaMp/uDrruQl7xQ6rplEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G/4UIApPKfYF2zSXkJx6Cexzx4hZYuGRCtv/OFj5tTApGQBn5NjF+zgsaslsfVt9gh96unpQ7l3zqy8wzOG0Z91Glr3lx1kw6zwUdAG8Q78e6ERLx/V6ZGPnyppZoQkc1wiCUMPSoEt0ga2zt3ve2qVqbXs/ZHa7ONkmPoJI6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBALH3cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369E7C4CEF1;
	Tue, 26 Aug 2025 09:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200385;
	bh=uh61s/bC5B+781PVWTw+9HkaMp/uDrruQl7xQ6rplEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PBALH3cGlR37gWje6scfrkwLdTqzzawobBgxZXS3K9bT1qpO3mLHG0V5L9qdFx1pI
	 4wHHhmhPRuPxk0ifUEtfhNZfvb+jpETN/wpX+FUj3uKWGOpO8eLvTYSpNNHnmIJAik
	 bw8vc2vnIipOdixJ1KvX8EAaga5XuqQ388PmGOqVpmXD4AuxKthFPBOWXZJCgaKsuT
	 z5pZ+b3z7X9Il9CZYPxu4CeYKmGLhnG8a7L8C0l86r5NvGnzfjfvj2urVj80a7lxEB
	 rhqsLCvWEE6LApIY2f64xz0mBiArjIcV8VQhZOptx8D5vcaPegXjrYG9EYd2u8E7+J
	 nRPdym/vSPvTg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 1/2] rust: time: Implement Add<Delta>/Sub<Delta> for
 Instant
In-Reply-To: <20250820203704.731588-2-lyude@redhat.com>
References: <20250820203704.731588-1-lyude@redhat.com>
 <ZYA3f7DHAJS34iXndClpGH9fcraS3BVuXJmnvcPrq6bBb97Gm7t5fkAVI4_2J35_90bxswSKle6d_MW77pUUKQ==@protonmail.internalid>
 <20250820203704.731588-2-lyude@redhat.com>
Date: Tue, 26 Aug 2025 11:25:54 +0200
Message-ID: <878qj6wi1p.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> In order to copy the behavior rust currently follows for basic arithmetic
> operations and panic if the result of an addition or subtraction results in
> a value that would violate the invariants of Instant, but only if the
> kernel has overflow checking for rust enabled.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




