Return-Path: <linux-kernel+bounces-733999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C37FB07BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97AB1AA49B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA92F5C24;
	Wed, 16 Jul 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD5NF8ou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4217ADF8;
	Wed, 16 Jul 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685861; cv=none; b=Vw4RXFUcnKJhgkPp5RJ2UTccQ71SLbtYbghV5oaKSf7nGZhajBgL+cdXapGdqhwn2WoFIqv0AYq0hLoZrxgkJZgHamhvRkzfmTv5O223sji5KMl2wF2vtQIsOdq87pVWIig9B/1oy3tNpP0ntDfgrlmmzSBrvA1in8ZFrpfrvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685861; c=relaxed/simple;
	bh=Sxd2WnxBlqamILtjNgFWFb0gQYdI8FSiVC+BeS+gfFw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=B8HA3Svtc0h4GZPh4eAqUwYMDGVuhTE/ckFSU/5isByI9LcZXGXEUjbDvu0dGm5fiwdoWY4q6kQVRq5BoKLYbLT2P/ShIVpFlXDMDAK0zuHLPT78OgfGMyM5CGcFcqEZ+ln6UCc41NucDOJPoVJPLJ8Iv2n4VhxaFh8GVZT8OGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD5NF8ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EFFC4CEE7;
	Wed, 16 Jul 2025 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752685860;
	bh=Sxd2WnxBlqamILtjNgFWFb0gQYdI8FSiVC+BeS+gfFw=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=tD5NF8ou7zRaAuSwrDfWxDNBfKlPqWzHksGNWpcYKesNF4I2Deh0qN3Jvgb/hFeP3
	 Ehti99JOjtFzqEkMCW22yBK4ibc2im8U1UaJVh0AADRcNqLLHTA6aweH5o60oh/xHo
	 f+PIyD5HvSCAdkI/NAQJ8ctW7g0kTg0TGZF6Wne+vGH2PvHmgdGsHy27R4+WtsnJGY
	 IA2TtCSucVP377mAnzbsA5EF4UqY3YmAWPgr0PNO0hOTI1RVwxil66UQRP3HlsDT6J
	 TYl3cf0gIMzkHsbT/4yfJFCOMUFINVR9iC5/MN3hJJvqK2/2kaKAdVXwhLrM+h2xTD
	 QuRJpJaHWXemA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 19:10:55 +0200
Message-Id: <DBDNA6P0SNQR.36OEHQWYU2PDL@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v13 1/3] rust: io: add resource abstraction
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Fiona Behrens" <me@kloenk.dev>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com> <20250711-topics-tyr-platform_iomem-v13-1-06328b514db3@collabora.com> <aHYLWc_KkMHj_jF-@google.com> <D9C5D4EC-FA24-47DB-BE89-609713F093FF@collabora.com>
In-Reply-To: <D9C5D4EC-FA24-47DB-BE89-609713F093FF@collabora.com>

On Wed Jul 16, 2025 at 6:52 PM CEST, Daniel Almeida wrote:
> I guess the easiest solution is to drop 'static in order to account for t=
he
> above, and change the signature to return Option<&CStr> instead.

I think you have to do both, this...

> We can also change Region to own the name, and pass name by value here:

...and this.

Otherwise you'd need to ensure that the Resource you create the Region from
out-lives the Region, which I think we can't.

>     pub fn request_region(
>         &self,
>         start: ResourceSize,
>         size: ResourceSize,
>         name: &'static CStr <------
>
>
> Thoughts?
>
> =E2=80=94 Daniel


