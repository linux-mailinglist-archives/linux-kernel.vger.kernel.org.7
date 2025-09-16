Return-Path: <linux-kernel+bounces-819048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC19DB59AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A78B4A0B03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA8E33A034;
	Tue, 16 Sep 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="oHEQdfJg"
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DE932A822;
	Tue, 16 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033628; cv=none; b=eXrbpJ9SQR37m93tJqMhd9ffCmWFhT7mQJX499C5a+RdhmmLeKHgx/vCXb1+w33gC2HoqEFJWYR7DByewj79RxMDdY/xLVnf9B0cDpUJiX7B4/709sig8mwHN9jLs1fcLWfFvShcbzjPh/IBt4Z7Nv3mQmEut2WDGzLJIc3tITw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033628; c=relaxed/simple;
	bh=6DRl2reBeCpb8t2mrsH3ks+AVgIL/2jGRm/rHwaMTe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaGpHv+7PilpPcIF+tEoU4v6YTnAJB/q8LLp+eMlHkGsxuF81Vv4qNupe2DtLTwDPPc8aJDDSCOdxDXViZift2clvx9tKMs3cq3UuRj80B03WOsHxAqp5vTJ8+bu19tfKb8kOMzR6kUfrml/rm0Q2b9gd+wGc2VXP4q/GoVl/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=oHEQdfJg; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3928:0:640:8b00:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id AE38F817CC;
	Tue, 16 Sep 2025 17:40:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id BeRfCx8Mc4Y0-iZ18mXua;
	Tue, 16 Sep 2025 17:40:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758033616;
	bh=GZgz4zFDz9516Y98vd4TS+6TMO0slfCF0WmLDac2DMg=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=oHEQdfJgujP5DSqh5iX88OtLeAGqWMNaVO4NlzYiTVinTnrMzpTZ0Jrexh51HM6im
	 euEoATBxZI9uxnrBqRoSoFKw856NFc+CbwKazyoTNNJ/JC8+I3rLRUgRBVp/tvvK1I
	 dyun0PMjaCxMr17/x1UaidFMZ4eFEsKyz6nNqNNU=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Tue, 16 Sep 2025 17:40:11 +0300
From: Onur <work@onurozkan.dev>
To: Tong <djfkvcing117@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 ojeda@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 alex.gaynor@gmail.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org
Subject: Re: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError`
 docs
Message-ID: <20250916174011.10c791cb@nimda>
In-Reply-To: <CAMfjjQ18NYsQh7CVzRs=+sYwve4T5y-vf=zMNLyxQvgYE4+mMA@mail.gmail.com>
References: <CAMfjjQ18NYsQh7CVzRs=+sYwve4T5y-vf=zMNLyxQvgYE4+mMA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Tong,

On Tue, 16 Sep 2025 22:25:41 +0800
Tong <djfkvcing117@gmail.com> wrote:

> rust/fs: use intra-doc link for `EBADF` in `BadFdError` docs
>=20
> This patch changes the documentation for `BadFdError` in the `fs`
> module so that the error variant `EBADF` is referenced via an
> intra-doc link (i.e., [`EBADF`]) rather than plain text. This
> improves the generated documentation (so the `EBADF` constant is
> linked), and helps tools like rust-analyzer to resolve the reference
> from the docs.
>=20
> Testing:
> - regenerated documentation, confirmed the link to `EBADF` shows up
> correctly,
> - ran doctests to ensure no broken links in docs,
> - built affected code with rustfmt / clippy to verify formatting and
> lint cleanliness.
>=20
> Suggested-by: https://github.com/onur-ozkan
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: Your Name <your.email@example.com>

This is wrong.

>=20
> ---
>=20
> From 676dd0d1d9276d5dd2a83469ac392732c0a1f34a Mon Sep 17 00:00:00 2001
> From: Webb321 <140618222+Webb321@users.noreply.github.com>
> Date: Tue, 16 Sep 2025 22:15:25 +0800
> Subject: [PATCH] rust/fs: use intra-doc link for `EBADF` in
> `BadFdError` docs
>=20
> In `rust/kernel/fs/file.rs`, replace plain text `EBADF` references in
> the doc comment of `BadFdError` with intra-doc links [`EBADF`].
>=20
> Testing:
> - regenerated documentation, confirmed the link to `EBADF` shows up
> correctly,
> - ran doctests to ensure no broken links in docs,
> - built affected code with rustfmt / clippy to verify formatting and
> lint cleanliness.
>=20
> Suggested-by: https://github.com/onur-ozkan

Should be: Suggested-by: Onur =C3=96zkan <work@onurozkan.dev>

> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: djfkvcing117@gmail.com
> ---
>  rust/kernel/fs/file.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>  diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
>  index 35fd5db35c4652..761a9074d65205 100644
>  --- a/rust/kernel/fs/file.rs
>  +++ b/rust/kernel/fs/file.rs
>  @@ -447,7 +447,7 @@ impl Drop for FileDescriptorReservation { } }
>   -/// Represents the `EBADF` error code.
>   +/// Represents the [`EBADF`] error code.
>   ///
>   /// Used for methods that can only fail with `EBADF`.

You missed fixing the second `EBADF` here.

>   #[derive(Copy, Clone, Eq, PartialEq)]


Thanks,
Onur

