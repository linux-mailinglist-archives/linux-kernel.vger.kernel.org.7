Return-Path: <linux-kernel+bounces-786082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B5B354C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7306815EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219ED2F60D6;
	Tue, 26 Aug 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzpMLnWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0A2D46A1;
	Tue, 26 Aug 2025 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191051; cv=none; b=Hi2pDD7XQNAAZCHo7S4fZKmNO1yEkciD8lEKte+GDWJ7yz+yc/UY1gNhNQe/wiI+HEPWTGd2DPbt0UHjr/7mhYwJiEm7/sDhbj2lPjGthoP/rEI9XyPmbNsZsqgC1r8+fr3BaoCeQK4JBY0fH4UXwL3Ty9da4qcU+hsypofFxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191051; c=relaxed/simple;
	bh=1xqeDYgOtN+fbXijQEv4PbpP6hYNVxHLpg1R+RFdHeI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cGFgH5hAtqA4MXzCx7qfMyNwMrUNQL3JQ3MvyTFyMVWCohpKUeuEWzS3W3v3JIZXmUGopMGmY4NtGHZQ2PMWK9bYdOJYkCziHMyuID4oIBnQGgAVZOc6PVnMBBxAYK1xz/yGP4eG7VmgjKycYmu4K3BkCdXdzmugqDjkEDPKs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzpMLnWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9575CC113D0;
	Tue, 26 Aug 2025 06:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756191050;
	bh=1xqeDYgOtN+fbXijQEv4PbpP6hYNVxHLpg1R+RFdHeI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nzpMLnWbauEU7SotKMMyLUpd3pb8yLKUsQQ6QzFGIhe0slqdK5StmXwcvMGahXpMH
	 T3z4uv/lxeTVe7IugmiuLHN9yO9N245LfmyppLRxbFb+iBSbc2DPZcjY2IqLHspHhx
	 Z7f7F4afPGlSIB+5CX9FIVoQhkUyOdQGzaH8nZFch0ep23IG5E/W4dCThTOUhxE2Qh
	 q2aWse04Appmzg4evMjmXe2uKEE0plfKASV86Sswdld5526BZFIspskidlbGCiPNRQ
	 XI44B5kgo+JlbHm8kdjcPSRWODCKfh3yDCDy1mc0xQsK7PWNu5dAN5Dr5pGkOTIrVv
	 W66NR3+ZeCxqA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 08:50:44 +0200
Message-Id: <DCC5RO5OQV3D.1I9HSU3SFE46Y@kernel.org>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/8] rust: transmute: add `from_bytes_copy` method to
 `FromBytes` trait
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>
X-Mailer: aerc 0.20.1
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <20250826-nova_firmware-v2-1-93566252fe3a@nvidia.com>
In-Reply-To: <20250826-nova_firmware-v2-1-93566252fe3a@nvidia.com>

On Tue Aug 26, 2025 at 6:07 AM CEST, Alexandre Courbot wrote:
> `FromBytes::from_bytes` comes with a few practical limitations:
>
> - It requires the bytes slice to have the same alignment as the returned
>   type, which might not be guaranteed in the case of a byte stream,
> - It returns a reference, requiring the returned type to implement
>   `Clone` if one wants to keep the value for longer than the lifetime of
>   the slice.

I think that any `Sized` type that can implement `FromBytes` also can
implement `Copy`, so I don't feel like the last point is a strong one.
But the unaligned byte stream is motivation enough :)

> To overcome these when needed, add a `from_bytes_copy` with a default
> implementation in the trait. `from_bytes_copy` returns an owned value
> that is populated using an unaligned read, removing the lifetime
> constraint and making it usable even on non-aligned byte slices.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/transmute.rs | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

