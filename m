Return-Path: <linux-kernel+bounces-738263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7F6B0B67E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90061896E89
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5920C21A43B;
	Sun, 20 Jul 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0Q7jfU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CD3C463;
	Sun, 20 Jul 2025 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022635; cv=none; b=U7PaDPee3raZ8Uo04RMnVOqdNtsA6yjEiqqGSpAUA6/O0L461C2XaeMt58SgenY1XtFwbuXHpFHulosc4M5x0IRP7TC/egCowfQoTygYRWUzJ1SeUsSmByZjEJn5mIbLK99y2LD4YislM8yCRnjsly68cimek74f6n4V58MlQLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022635; c=relaxed/simple;
	bh=GRwvPwTzq9k7gNxlwmOr+s5EEDkKo4rG+o/GEGXRVrk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CpoCDK9b9HO1EDJ5dDsSGx/CGg2UDQNPDWcyhYvqB1rmbqAKuyPyfvzAvzzmp+s/TDVUj4t9JsNNRb1gGT8XH/gMpGcCs1odTsx1+k0tl+DtJE1ch6UoWlgHGJNHgccRZSla5fDg5MFv2klw4YZGm68C6HL9khF+2BJrktu6uAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0Q7jfU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6EAC4CEE7;
	Sun, 20 Jul 2025 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753022634;
	bh=GRwvPwTzq9k7gNxlwmOr+s5EEDkKo4rG+o/GEGXRVrk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r0Q7jfU8ca8QB2dvPODbSyaSepTEhPOF1uXev/AAL7bcYHkZAdDCuv9Ln/4oeU2T1
	 SgbUprrkiU3V2TGTlNCiVkY+r8unm2b8q6KZzUDeSU3MDGjAoLHbbeWpUPWG7fvJKO
	 cfEHXDq/fsytIsYmdMJ45DZmojD/NKROtKKps0epWl7bs5Cy2ChmkZ3PW90+VOxDNw
	 H6frxkx3psAY79x2tG7SuCAm69WNqcPuNRaIHMXjNkWIvUPpCS2mSM0PP1zxLJwS5d
	 M3W1LQ+G5yflC637g1+jWQ5m6fP3I1/vREas/5o80t4FfIIjJdCXT9oi8qJKmC1EDV
	 UyTsctc7y0iCg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Jul 2025 16:43:49 +0200
Message-Id: <DBGYNQJJ0JI6.P280ZLVZUSO6@kernel.org>
Cc: <dakr@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
From: "Benno Lossin" <lossin@kernel.org>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250720094838.29530-1-work@onurozkan.dev>
In-Reply-To: <20250720094838.29530-1-work@onurozkan.dev>

On Sun Jul 20, 2025 at 11:48 AM CEST, Onur =C3=96zkan wrote:
> This patch series makes various functions in the
> `alloc` crate const fn.
>
> Each patch corresponds to a different module within
> the same `alloc` crate.
>
> Onur =C3=96zkan (3):
>   rust: make `allocator::aligned_size` a `const fn`
>   rust: make `ArrayLayout::new_unchecked` a `const fn`
>   rust: make `kvec::Vec` functions `const fn`
>
>  rust/kernel/alloc/allocator.rs |  2 +-
>  rust/kernel/alloc/kvec.rs      | 10 +++++-----
>  rust/kernel/alloc/layout.rs    |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

This looks sensible, any particular reason for why you need them const?

For the entire series:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

