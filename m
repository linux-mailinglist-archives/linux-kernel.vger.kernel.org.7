Return-Path: <linux-kernel+bounces-820699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D80B7E2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59EF622940
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C02F5A08;
	Wed, 17 Sep 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="PlfVMZFt"
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019D1C07C4;
	Wed, 17 Sep 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112957; cv=none; b=qljM2BpCYvNhb1baiJAgtufzZiMeGujRbRSIWgE5EHUUq1RDZnBh4JtD/1nCToXhEaAwDVxFoPTd3hpTmq+W9gDJrUHjIdHPJdcydV5tP+jkFQpFSSMg/CwGOkpTbhqLtz0UXmxhdDL47bNmWQbplKRaKkdnz2l8OseU3XyBiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112957; c=relaxed/simple;
	bh=0GXRm/644bc+q9sgMtkhxpnuEEVIBWmnK11cTPL87+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJuKsTgjOn8JArJnUrmJ6hQiVrjZHAswCkclWPPmVuVX9QH/ZexjBiQXxvuZ3jQYBft34Es2xVPb1v6mHPlKcVTl2AwQDJi70W1zOC/4m1fGHTre1YuVH0y6ORCNV0ikAZtrInUF6CeeUSpJH31YbNIX6UzqkkVie9ckgrL/SW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=PlfVMZFt; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:ba5:0:640:b177:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id 996AF81EB3;
	Wed, 17 Sep 2025 15:42:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id RgQGaq9L6eA0-Bv8chcnP;
	Wed, 17 Sep 2025 15:42:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758112950;
	bh=++k9euwPFCcGpu5VkV/7p9z7fd4LB9g64LucXo0nQcM=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=PlfVMZFtquje8vDHiiZgGiLXOOiJDwnKYsEgs6tqW8Rd193a8qzz2BqoTrxe+r84A
	 Eo2K8pBvzjV+qLT54ILBtK2+8QlJgOJDalmz3O0NXOM+jZOnr9vAAV56l0a4MZw4e2
	 WbYzxdIuLZK0kd24/67f5Llm0uVSxhZzYoVn11c8=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 17 Sep 2025 15:42:27 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: djfkvcing117@gmail.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, gregkh
 <gregkh@linuxfoundation.org>, lossin@kernel.org, gary@garyguo.net
Subject: Re: [PATCH] rust/fs: use intra-doc link for `EBADF` in `BadFdError`
 docs
Message-ID: <20250917154227.7ecb47dc@nimda.home>
In-Reply-To: <20250917033838.8171-1-djfkvcing117@gmail.com>
References: <20250917033838.8171-1-djfkvcing117@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 11:38:33 +0800
djfkvcing117@gmail.com wrote:

> From: Tong Li <djfkvcing117@gmail.com>
>=20
> In rust/kernel/fs/file.rs, replace plain-text `EBADF` in the doc
> comment for BadFdError with an intra-doc link [`EBADF`].
>=20
> This improves the generated documentation (so the `EBADF` constant is
> linked), and helps tools such as rust-analyzer to resolve such
> references from the docs.
>=20
> Suggested-by: Onur =C3=96zkan <work@onurozkan.dev>
> Link: https://github.com/Rust-for-Linux/linux/issues/1186
> Signed-off-by: Tong Li <djfkvcing117@gmail.com>
> ---
>  rust/kernel/fs/file.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 67a3654f0fd3..f3153f4c8560 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -448,9 +448,9 @@ fn drop(&mut self) {
>      }
>  }
> =20
> -/// Represents the `EBADF` error code.
> +/// Represents the [`EBADF`] error code.
>  ///
> -/// Used for methods that can only fail with `EBADF`.
> +/// Used for methods that can only fail with [`EBADF`].
>  #[derive(Copy, Clone, Eq, PartialEq)]
>  pub struct BadFdError;
> =20

Hi Tong,

The description doesn't follow the style guidelines (lines are too
long). Please run `./scripts/checkpatch.pl $path_to_patch_file` to
verify before submitting patches.

Also, make sure to version your patches with each revision (e.g., `git
format-patch $commit -vN`). There are already several patches with the
same titles on the mailing list.

Thanks,
Onur

