Return-Path: <linux-kernel+bounces-787055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE3B370D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D65E4E15F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79AB2DAFB9;
	Tue, 26 Aug 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXN0ec99"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A1C85C4A;
	Tue, 26 Aug 2025 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227736; cv=none; b=RNFBcYCLinawZrg+FQnmHksmORHxLPuAXyAqBfBmlLSuCnttsbq6qvI19QwIM1OD+/v1JCyVgKBHK3e7MTtA9p111j2ai3dOne8LZ4L0lOg/px5zyT2qfJOdWDOfz/v25+3lVzpk8nyaflfdK/t5bY22d0tOf6MkAzQ4oYN+iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227736; c=relaxed/simple;
	bh=uWeuDAsfN/tp/nC929ZRBzcYdfCHEc7ZuZPZ1yV5eY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hQjZ2vawh1ZvNYiw2T8vdpKhw3pMQZHSDFYVUroqlNTN/akIuEVspdp6vV+BweS05HjMJYkUX5eaotf9gs2LORx2nCfqKUGHsODxrv89SkFPhdzsMyxn1qmmxFp8Mf8BTlI1mMTVCwRfy1m+pmVdFomvrzOJYHsJ1bwA7pubKjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXN0ec99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC6C4CEF1;
	Tue, 26 Aug 2025 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756227736;
	bh=uWeuDAsfN/tp/nC929ZRBzcYdfCHEc7ZuZPZ1yV5eY0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bXN0ec99osLJTD0La+KFz2H/LAu9VqjB86wvXoLkYi0oO78srlCdGJ6THvwBpcJiS
	 uS2N3Pg4ZD3rCoXJ2Uom4gS3jKW4OTBJEqDbUBZ6EQ2gLqTfR6Lk4lc5Czj5SkRY6H
	 TBsdFEmRkgBzRCLJIeTfftdemdx0kTf7PRKYE+rcPBVthqLxEJ9lCUtJvR5xz50l27
	 Vq+C6NqeLh9H0odHmOsELFteGd2s0ITr+U5E3MRXF/ZP5bPBj9qBrUW2L9EqMvSIg7
	 XloGwx945bV5uJMzXcBpJ1lHueC31w9felQ42/P3evBksWBxx7lbsXm4NKdVIh0K1j
	 zmoMRkLm0UjEA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 19:02:10 +0200
Message-Id: <DCCIRTHGQFNX.1M8GXO4TYA7DF@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed" <yosry.ahmed@linux.dev>, "Nhat
 Pham" <nphamcs@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4 2/2] rust: zpool: add abstraction for zpool drivers
From: "Benno Lossin" <lossin@kernel.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250823130522.867263-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250823130522.867263-1-vitaly.wool@konsulko.se>

On Sat Aug 23, 2025 at 3:05 PM CEST, Vitaly Wool wrote:
> +pub trait ZpoolDriver {
> +    /// Opaque Rust representation of `struct zpool`.
> +    type Pool: ForeignOwnable;

I think this is the same question that Danilo asked a few versions ago,
but why do we need this? Why can't we just use `Self` instead?

> +
> +    /// Create a pool.
> +    fn create(name: &'static CStr, gfp: Flags) -> Result<Self::Pool>;
> +
> +    /// Destroy the pool.
> +    fn destroy(pool: Self::Pool);

This should just be done via the normal `Drop` trait?

---
Cheers,
Benno

> +
> +    /// Allocate an object of size `size` bytes from `pool`, with the al=
location flags `gfp` and
> +    /// preferred NUMA node `nid`. If the allocation is successful, an o=
paque handle is returned.
> +    fn malloc(
> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
> +        size: usize,
> +        gfp: Flags,
> +        nid: NumaNode,
> +    ) -> Result<usize>;

