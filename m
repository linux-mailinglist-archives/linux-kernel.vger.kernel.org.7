Return-Path: <linux-kernel+bounces-753748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9425EB1874C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA281C82D48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9028CF58;
	Fri,  1 Aug 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="hShYNIy5"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E2A188CC9;
	Fri,  1 Aug 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072583; cv=pass; b=KD4D5nkKX3gSWZkHwn+bNZtPDWn404L/OwjMpMFPeIah2um4bhJbLCJ0ZwjrJSSjsopyF7e/59wDKtwdXg2NBJOz33sIdyT3TgunnKOhygS576xpVA1JSAiDWsGb+73cC1Kr1D48uf/HyKWtoszRlFSh/QCKG6/5+2zcBtSfa/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072583; c=relaxed/simple;
	bh=N0u5f7kywmoobUvfvaV9GxGqtJRaOTPYcha1RtJqso4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gFSSi3ZO4GNScyE6sYOCsnDjWiy1B8R+LsHhoZkshsP50u3qK0IxSI5YG2f88S2hSErraO1I40Pk+lk6plfhTCEEJPHRgSbzOQy8+k2ddeq+82iLyencETBB/XwH342ozJq2L4E/+1mQSvbLlxA8FVk49pIFUxxObhyyRTHittU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=hShYNIy5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754072562; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SGI5SBFIreyJVvQFlLuxwq5c3Lw+RNKf5bISz1hplzyD3CEo0vAJQH8+D+usYXyyJUStMqBhwyGH9pXyDHWpQ4t3kEPaO87zyS74LJ495v7ZxvP0JT/ZhGZicQkglas5nQ1qCckH7r9Pp3gtofd1XS46kJOF8Vi7GhiF1ufECJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754072562; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rufzHIlOrILnFZqJtVdpasY2ZRGvC6jraxfocnHfUe8=; 
	b=B41sD11ihG6Y4LCm2taddBdV5AAvG4qawutrk0yI5J5IaiCvhSv5WWF/cO2Cdx6fT42s1jxS37G0MeHfoFT6J+xhNeqkkOlJdLMqHOcX3ERa4w8+bWs/5+dvJ5ac/AMFJss8HhnNUuS0H8uBsUD3TjNuTMEVgmITpMHir1uVgPI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754072562;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rufzHIlOrILnFZqJtVdpasY2ZRGvC6jraxfocnHfUe8=;
	b=hShYNIy5HDP28xS7IXS1sxaR+DCCg0fGHEyo/p4v0NJvRGuwXMtVPkIEti8l9ukU
	wTHCxsQHlfWQTQrm8xYLtzPj7KA9PDS2DoWXwjuWvFZVW/kSd3ZqpoZm0fc6zuhJfKs
	T9mIxYIXByrI/nhAPWyZV2de3jNctoT4n6kRpdlw=
Received: by mx.zohomail.com with SMTPS id 1754072559074845.5866054817981;
	Fri, 1 Aug 2025 11:22:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] rust: prelude: re-export
 `core::mem::{align,size}_of{,_val}`
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250801161752.443431-1-ojeda@kernel.org>
Date: Fri, 1 Aug 2025 15:22:24 -0300
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D95B1A1-E994-4E9F-AB31-3DC5E2E9CD0F@collabora.com>
References: <20250801161752.443431-1-ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 1 Aug 2025, at 13:17, Miguel Ojeda <ojeda@kernel.org> wrote:
>=20
> Rust 1.80.0 added:
>=20
>    align_of
>    align_of_val
>    size_of
>    size_of_val
>=20
> from `core::mem` to the prelude [1].
>=20
> For similar reasons, and to minimize potential confusion when code may
> work in later versions but not in our current minimum, add it to our
> prelude too.
>=20
> Link: https://github.com/rust-lang/rust/pull/123168 [1]
> Link: =
https://lore.kernel.org/rust-for-linux/CANiq72kOLYR2A95o0ji2mDmEqOKh9e9_60=
zZKmgF=3DvZmsW6DRg@mail.gmail.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> rust/kernel/prelude.rs | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 25fe97aafd02..198d09a31449 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -12,7 +12,10 @@
> //! ```
>=20
> #[doc(no_inline)]
> -pub use core::pin::Pin;
> +pub use core::{
> +    mem::{align_of, align_of_val, size_of, size_of_val},
> +    pin::Pin,
> +};
>=20
> pub use ::ffi::{
>     c_char, c_int, c_long, c_longlong, c_schar, c_short, c_uchar, =
c_uint, c_ulong, c_ulonglong,
>=20
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> --=20
> 2.50.1
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


