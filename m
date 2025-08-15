Return-Path: <linux-kernel+bounces-771379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F1B28634
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDC66225F2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82878293C42;
	Fri, 15 Aug 2025 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1Wf/ZXE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC432206A7;
	Fri, 15 Aug 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285138; cv=none; b=fgElNJVGUvC2kwW17mxuHLciurujJjQ/fFFe56R7u+9qL6+cDoIOC9N+eQRfBTYiNyQukpiTFUErRdQtU8yloXQ+O9DNNCrSNaba1jY4+0xRSm6ZxXZJZs3q84iFggP7jELARlVWrzZeRaTDQHtqNZh/ZscrdMJJ00E6S8VJy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285138; c=relaxed/simple;
	bh=sgy3dyxSlAQCYlsjTTTaZzqp/r732Zhi3hClnc2d2XE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=fxCn5EacuDEsLpJGBfbJnXnfDbqNVm0KjAxlrscq8RD5UrKoNKNy2EP5ka6291bEUGWAmwJCa10q0lgonyZLQr9Y/C3tYsKJTZ5HO1OBtIGrxj42IY6KJVauGUs5Zw1+5EEHzFuIQ0cKJNkkkR16GC1rt07sx/ntTBl54HtO0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1Wf/ZXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D19C4CEEB;
	Fri, 15 Aug 2025 19:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755285137;
	bh=sgy3dyxSlAQCYlsjTTTaZzqp/r732Zhi3hClnc2d2XE=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=J1Wf/ZXE40wrscHg3EpaIQ8FJkb+AASxnoDGlfqVtggrISCz/2BfEnDuXz/xyB0rh
	 kWLqUhsR+UJnQ7Ss3blz44+txjRXf6UyRWci/7GWp57DFtS1SFGL72CtSpA+I3U52k
	 iq3nhg/LDH/YXdRGwHizWq9eeAtayasNM9ke4nFtjKT3F0/eV43KqsII0XdFMM4+P/
	 EPf8s71I0cVF51NBPJFjkFTjxdUStTXF8BaSNuHpmFKEg3wC9JfchE+OPzkajvReLt
	 DB9nL1FIT/bAq3lDojypd+tbuPoqsIRjXMU6IYFhOY4mV52OEVQTX5ULiXUiDpOV2j
	 OBzN56y9X0HWQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 15 Aug 2025 21:12:12 +0200
Message-Id: <DC38NDRET9NB.31UDI8FHB7WAY@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/2] Take ARCH_KMALLOC_MINALIGN into account for
 build-time XArray check
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Matthew Wilcox" <willy@infradead.org>, "Tamir
 Duberstein" <tamird@gmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>
References: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
In-Reply-To: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>

On Mon Aug 11, 2025 at 2:31 PM CEST, Alice Ryhl wrote:
> Alice Ryhl (2):
>       rust: alloc: specify the minimum alignment of each allocator

    [ Add helper for ARCH_KMALLOC_MINALIGN; remove cast to usize. - Danilo =
]

>       rust: alloc: take the allocator into account for FOREIGN_ALIGN

Applied to alloc-next, thanks!

--

@Andrew: Just a heads-up, this has a minor conflict with your tree, which
should also show up in linux-next soon.

diff --cc rust/kernel/alloc.rs
index b39c279236f5,907301334d8c..000000000000
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@@ -164,7 -137,15 +164,15 @@@ impl NumaNode
  /// - Implementers must ensure that all trait functions abide by the guar=
antees documented in the
  ///   `# Guarantees` sections.
  pub unsafe trait Allocator {
+     /// The minimum alignment satisfied by all allocations from this allo=
cator.
+     ///
+     /// # Guarantees
+     ///
+     /// Any pointer allocated by this allocator is guaranteed to be align=
ed to `MIN_ALIGN` even if
+     /// the requested layout has a smaller alignment.
+     const MIN_ALIGN: usize;
+
 -    /// Allocate memory based on `layout` and `flags`.
 +    /// Allocate memory based on `layout`, `flags` and `nid`.
      ///
      /// On success, returns a buffer represented as `NonNull<[u8]>` that =
satisfies the layout
      /// constraints (i.e. minimum size and alignment as specified by `lay=
out`).


