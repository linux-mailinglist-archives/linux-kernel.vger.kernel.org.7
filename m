Return-Path: <linux-kernel+bounces-729213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F67B0335E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E93171F09
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B31FECB4;
	Sun, 13 Jul 2025 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5ynAb0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D9211F;
	Sun, 13 Jul 2025 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752447896; cv=none; b=h466CnN7GDlxQ0eCYpgvyrFD2fTKwCQplqosNdWPMWK/W5ao1CW0jbtsJmzAZpssHbkkSApcq+pSo6fCj7m84teTgARrxJkT8Z3HSxorK1c7oEeiV0Vd4lhsytI1psXxpadAmKb9kvJMdukA1F16jgcB6EklktfIBtJAmgzqRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752447896; c=relaxed/simple;
	bh=Fqv0BupB3rYT98G+vYDHwAetAEXFNiBr8pDtjkgsfgw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Zw6JJlKfmfKFpqaZ+O4+w6K5blExWExygtIkHS842MOnhIMkdGq3oVVvZN/rfN4VhOJIKqfaEvXvmAXw8yyHeZapDHAyzljtAxb8zNLU9U79ol+tbVtym3eGmu06HMnlrMXHxqbBZkINzD2+dSPMeUmafeV1eWYy03J0AniapxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5ynAb0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE21C4CEE3;
	Sun, 13 Jul 2025 23:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752447896;
	bh=Fqv0BupB3rYT98G+vYDHwAetAEXFNiBr8pDtjkgsfgw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=O5ynAb0oin4/w5zsKmM014gRASkjBtzG6QKhMr1dmJnAAfbBLy7B8M/d5ZpbpmnGn
	 59MkeDCjpdjhFl7GnJqW8JhvltHesSwzO+Srj1uOQ1o37OTTsMKVlXoaWuUsZ6zqgG
	 jKy/EQBnoKyBoOmoMTMipN2x2swtlLo4gSpJqt8Vzl/ofg/9A2nyeuhom04L35lPPZ
	 JaxUefMWwr0O3SmsaOo5N+gbUvnc3TB1fW7DGgjzEAHl+tH4fGfZErjFE29oVSmISe
	 xVcqB+NMZDOQDK+VSmaJ3VILEv8JhEft9Z6Ks7yj/wcj4BHzxeDFoRmDEEbpZsx7jD
	 53bqSvTsIkF4A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 01:04:50 +0200
Message-Id: <DBBAXIVZPB1K.2I3V9B4WNNBPA@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Tamir Duberstein"
 <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rust: init: remove old workaround
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250709-init-remove-old-workaround-v2-0-a3b1be8fd490@gmail.com> <20250709-init-remove-old-workaround-v2-2-a3b1be8fd490@gmail.com> <CANiq72=6n0+uLJ-2_LGKW08r-uVKGbdkofoC09xHwfbwDsRzNQ@mail.gmail.com>
In-Reply-To: <CANiq72=6n0+uLJ-2_LGKW08r-uVKGbdkofoC09xHwfbwDsRzNQ@mail.gmail.com>

On Sun Jul 13, 2025 at 10:33 PM CEST, Miguel Ojeda wrote:
> On Thu, Jul 10, 2025 at 12:49=E2=80=AFAM Tamir Duberstein <tamird@gmail.c=
om> wrote:
>>
>> `Error::from_errno` is `pub` since commit 5ed147473458 ("rust: error:
>> make conversion functions public"), thus remove this workaround which is
>> no longer needed.
>>
>> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> This seems the same as this one applied a few weeks ago:
>
>     https://lore.kernel.org/rust-for-linux/20250526152914.2453949-2-ojeda=
@kernel.org/

Oh yeah you're right, thanks for the heads-up! (seems like I forgot the
patches after applying them so early in the cycle :)

---
Cheers,
Benno

