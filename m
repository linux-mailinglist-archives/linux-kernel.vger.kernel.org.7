Return-Path: <linux-kernel+bounces-732230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EDDB063B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0861AA7498
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE88245038;
	Tue, 15 Jul 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzCmk5Mn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939F1EA7D2;
	Tue, 15 Jul 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595310; cv=none; b=JhC65P3dS8H9FhGbm0vS3BGEn2zJ5V82ESgiBp9XHFfHRFdz4e4t994modw3fOhDPQq737hgBhsefBLsKdWFIqWmlV58nwQ4ZKBLV4vxmnCO9uWdj8jzLFXuUQuI4LMMMm1Pv6jdjxOolDE+gvlRsz2nYkoMUKO0cIHG3efliWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595310; c=relaxed/simple;
	bh=DdqdkgiI5juyrgRHxtfAw0lfeAZe216KfAyarFrwOc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=u2uUFPJs623sXMLyjTpfzEa3V6fQlJdMRrk1pMjrrl2spYuuOuc1SpKs90oOewp3WQ6bLSqGYSSTvqQc5ocC68DiP6TpQbb3q91zzPX1+oN0CItfAm48XrrVP8uQPRxlFOaLNl7STgZrDsh+7Cda0eF//R/7GFFEMaxaDu+O1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzCmk5Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C570BC4CEE3;
	Tue, 15 Jul 2025 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752595309;
	bh=DdqdkgiI5juyrgRHxtfAw0lfeAZe216KfAyarFrwOc0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=XzCmk5MnGIZ36EIsWFAYiW1J+lxwjGT0Oqt/W07MSBWmYxII9Qja8BCjuWncMg72t
	 EvoMQFMWgZ+IlGN1jdFKE1JrU8kdHDz9tZunqOT4eVCq26bMiiLHQOKeNt2vsny+8A
	 zyY1JRdhNAlx/4Gyk5yRI70JUSOman3CCJXJYs+7nHBClOwgw1Dib4SrfcKuows8iT
	 xa/mjLfqY04mA7aCw+WfjaALm8TrmVZOsqNFES8lxzGrFQ1ijWjKlFaSKbYRAbqqEw
	 +MwpOF99HDtU1lDdR6+Lq6KYrn1f4ezUtuKMS7TFFplPx/DyeBKvzfbRlkOrtf9U1m
	 Uf/JceIi/JzPA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 18:01:44 +0200
Message-Id: <DBCR6O0P8QSZ.30WTN1G293YC4@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: alloc: specify the minimum alignment of each
 allocator
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Matthew Wilcox" <willy@infradead.org>, "Tamir
 Duberstein" <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com>
In-Reply-To: <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com>

On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
> The kernel's allocators sometimes provide a higher alignment than the
> end-user requested, so add a new constant on the Allocator trait to let
> the allocator specify what its minimum guaranteed alignment is.
>
> This allows the ForeignOwnable trait to provide a more accurate value of
> FOREIGN_ALIGN when using a pointer type such as Box, which will be
> useful with certain collections such as XArray that store its own data
> in the low bits of pointers.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

With the wording changed according to Danilo's suggestion:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc.rs           | 8 ++++++++
>  rust/kernel/alloc/allocator.rs | 8 ++++++++
>  2 files changed, 16 insertions(+)

