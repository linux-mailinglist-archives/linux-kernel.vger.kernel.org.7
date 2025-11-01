Return-Path: <linux-kernel+bounces-881329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F477C2805F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DFB3A9CF7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C71DED7B;
	Sat,  1 Nov 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFxKWV2i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F734D3A0;
	Sat,  1 Nov 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762005124; cv=none; b=C7DO8ZOA8bvGP4Ix8UsGxwtHwdk2G3lpRMVurvBA0QVBjOUkaO4JIEYhsj73YTYjmvXF3/vXvU+Za/jZbzPrvLcy689qjLvFdDScYLCbhoBJheCFVE1dh7JawRm2YKaZnX6VlZUJRs/G92igQ12rFZ67b7EMEkG7XxyU1W8ABts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762005124; c=relaxed/simple;
	bh=9BNrKXwUlGNzP5HzLWvXn1mQ3hf2YRbRxhSn/CZG7yE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=gY4O7KrJZ7Oo58OtjEzHnIXXr8AeLORsggL05A1sGxQrvTenbR9jgTyiOmeXHDFewbkP0JxdtGEeVF5NTXIyfaEq7ri4p40UflLv5A2JEG5ryL4jwlGaI9AwcqXMLetxNiLQVRwcwMwVOrdzsGz0OKlXlbfyZ4KwfFZxGChI0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFxKWV2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101FAC4CEF1;
	Sat,  1 Nov 2025 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762005124;
	bh=9BNrKXwUlGNzP5HzLWvXn1mQ3hf2YRbRxhSn/CZG7yE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=UFxKWV2iyBFluHp7ml5o3kHVnOGCBgild1Zk3er1uzvuNpk8fLnXf0UimJQUAhhoY
	 5vkm6AwGkQmXzaFBgGhJryontG2UibvB//hMG46lW+0d7sp+R3nMw6ewUxNs3LcC/9
	 nJNkfJSxWXL/94SXEfJ7ZcPAsaG7TZ+iLVloINmsRlzDMbWYrPYkVCtPKseZuUPBu4
	 jcQx8jNee+LWgCDLMHXFW1zZlWsrB8ZFdkztQDm9Nj1gmA9ME/cUmf7zvDW7WdLRgN
	 f9bHsz0F5h0XSmfErYNrkHNDkCeBoCDsXTchUQoDStS8omAXSLYaKQST/YTQCW4bPn
	 kbiHJE7D4SwYQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 14:52:00 +0100
Message-Id: <DDXEOPKO5RV5.37NXWB7O9AA6K@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH RESEND] rust: transmute: add `from_bytes_prefix` family
 of methods
References: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>
In-Reply-To: <20251101-b4-frombytes-prefix-v1-1-0d9c1fd63b34@nvidia.com>

On Sat Nov 1, 2025 at 2:41 PM CET, Alexandre Courbot wrote:
> The `from_bytes*` family of functions expect a slice of the exact same
> size as the requested type. This can be sometimes cumbersome for callers
> that deal with dynamic stream of data that needs to be manually cut
> before each invocation of `from_bytes`.
>
> To simplify such callers, introduce a new `from_bytes*_prefix` family of
> methods, which split the input slice at the index required for the
> equivalent `from_bytes` method to succeed, and return its result
> alongside with the remainder of the slice.
>
> This design is inspired by zerocopy's `try_*_from_prefix` family of
> methods.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

One nit below:

> +    /// Converts the beginning of `bytes` to a reference to `Self`.
> +    ///
> +    /// This method is similar to [`Self::from_bytes`], with the differe=
nce that `bytes` does not
> +    /// need to be the same size of `Self` - the appropriate portion is =
cut from the beginning of
> +    /// `bytes`, and the remainder returned alongside the result.

Maybe "alongside `&Self`"? "alongside the result" sounds a bit like the met=
hod
would return `Result<&Self>, &[u8]`.

