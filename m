Return-Path: <linux-kernel+bounces-766571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6758B24872
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930967AB79A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1B2F6595;
	Wed, 13 Aug 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htH82tcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D02D212547;
	Wed, 13 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084467; cv=none; b=agGlk+MNQ5roAncGcwaQBeXq05TM4+O8/AOx5PhqsVhTAcMtE+uvfHJtJT/gkuXBBZB1P5wF6yl1dWoDS7uEnmTmJYCtxPQhFdTjBnqym3sRcdLeKPwpNQvTnoRg2vxV5CFf+wD+JaYgnghxpA6JSMqmsR8QgNVKn7L4SI7j2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084467; c=relaxed/simple;
	bh=XrthAiSgr49jJTP0zQ0uTw9mgSLL8sLCGv5chSB5+ZM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=JAUcwr7zdlRgwK4n7mUtAHgeykA+qa3zrh6bPkbKHPpSe8l0tsVrZDg4GNS4UOU7/cpjXlFYD01+fcXZdNgxA8/hC7jNHL9lowavN2uz63Hez7vWT+hcY4Jh1upl33dRdaQ0KvhWKNj8vJlG9Udg8Ie2mSB2Z13lISKujVN8Kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htH82tcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF80C4CEEB;
	Wed, 13 Aug 2025 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755084466;
	bh=XrthAiSgr49jJTP0zQ0uTw9mgSLL8sLCGv5chSB5+ZM=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=htH82tcYss9etSB3hcwcE3Pnxc7gM5muO3+UUbUPrHPIl1I9gtn3qhR+7QU70kk9I
	 nmtCVfXwWwwQfbvVHhUCsDTYdl0+D4Pgm7aQdFNgb1xO3OmNnL5USLTluRwTQhDqn6
	 2jiEZrswNva/EEfNeb8jR2p7ajWj+27waoFe+CAqU8igwwB/xmilKL+IC8G3yufmVR
	 GxyFtXyaYqpnoJdu/iuJdTeOeuzXAVJm8cpRr82qBcGOLc2XYcH+SiiCqQWKt3/m8p
	 k7iK0N3q7sVz8q6Ka4L/kVlECrDlCngP2Nvn7jtWkE9opje/hkV1+BGbWmv8tiO13U
	 jS4o25hgXPaKQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 13:27:41 +0200
Message-Id: <DC19IMWVL93E.S1AO2KPXB3HU@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 1/4] rust: iov: add iov_iter abstractions for
 ITER_SOURCE
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Arnd Bergmann" <arnd@arndb.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Matthew Maurer" <mmaurer@google.com>,
 "Lee Jones" <lee@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20250813-iov-iter-v4-0-c4f1932b05ef@google.com>
 <20250813-iov-iter-v4-1-c4f1932b05ef@google.com>
In-Reply-To: <20250813-iov-iter-v4-1-c4f1932b05ef@google.com>

On Wed Aug 13, 2025 at 10:27 AM CEST, Alice Ryhl wrote:
> +    /// Read data from this IO vector and append it to a vector.
> +    ///
> +    /// Returns the number of bytes that have been copied.
> +    #[inline]
> +    pub fn copy_from_iter_vec<A: Allocator>(
> +        &mut self,
> +        out: &mut Vec<u8, A>,
> +        flags: Flags,
> +    ) -> Result<usize> {
> +        out.reserve(self.len(), flags)?;
> +        let len =3D self.copy_from_iter_raw(out.spare_capacity_mut()).le=
n();
> +        // SAFETY: `Self::copy_from_iter_raw` guarantees that the first =
`len` bytes of the spare
> +        // capacity have been initialized.

Technically, this covers the safety requirements from inc_len(). However, d=
o we
want to provide a list of justifications if the unsafe functions has a list=
 of
requirements, such that they are easier to match?

> +        unsafe { out.inc_len(len) };
> +        Ok(len)
> +    }

Either way,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

