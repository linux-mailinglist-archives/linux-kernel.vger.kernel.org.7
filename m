Return-Path: <linux-kernel+bounces-821425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D90B81370
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CF61C279F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228FC2FC01E;
	Wed, 17 Sep 2025 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="HeYxWK60"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92D229B18;
	Wed, 17 Sep 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758130914; cv=none; b=Tgy6VE9omXe5QdRNWkUBLE/iFCq1Z9OFQ4wEaQyNKWTq545rUke7VVoReBiKb7tbczESkb0zKALZt+oYR1kZMVBqoh7XJ5PqgFK3tnmmEsYXkIqWIiCiL27IaI+B3KuZyiX+bEgTdRAsRXgMI/QZqfoj5eRRe8FrUqdbmweqous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758130914; c=relaxed/simple;
	bh=vIqfQzX/DDStB/C412AZQpeeutgfVCWBdc9gK5Elb0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGBvb5z0aLPdeZo9rjm8ICbci5OCZxuf/sfZF5Dt473Aox/zcx1fanyXshp0TBHa+tfy8Au7PlFhFobJlV4wFjX8/H/8qMJ9BJW0YE5n260VwrwdZSICDdGA1Erp99DdAtYjKhq31+cwah4mP6Bo0dIbUOrbyDK/JgrdosfYI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=HeYxWK60; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c22:d15:0:640:4031:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id BECA380718;
	Wed, 17 Sep 2025 20:41:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bfVhOBEL1W20-fCQhJYIk;
	Wed, 17 Sep 2025 20:41:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1758130903;
	bh=28EP7Oi8xQcqOY/2fxNQgg7mmEgV2RO5dAkZcmLSGbs=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=HeYxWK60ukf6zL5lGd9ArUwj+hmEnktcnuX/z/zJRmYkVuDZOH4HTKM4pgFV2O5E/
	 ovBlvVivQSM+2ktKsv8PMHDfz9FI3RIn58PMuvkUtOuVYu7AVQwmt0RlmxLdlyxpfj
	 Q/aR9gzjSJUxv2bKa0bKgarNJIwb5oWcb36I6WdQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Wed, 17 Sep 2025 20:41:35 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: djfkvcing117@gmail.com
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, gregkh
 <gregkh@linuxfoundation.org>, lossin@kernel.org, gary@garyguo.net
Subject: Re: [PATCH v4] rust/fs: use intra-doc link for `EBADF` in
 `BadFdError` docs
Message-ID: <20250917204135.7a796dd3@nimda.home>
In-Reply-To: <20250917165106.22262-1-djfkvcing117@gmail.com>
References: <20250917165106.22262-1-djfkvcing117@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Sep 2025 00:50:59 +0800
djfkvcing117@gmail.com wrote:

> From: Tong Li <djfkvcing117@gmail.com>
>=20
> In rust/kernel/fs/file.rs, replace `EBADF` with [`EBADF`].
>=20
> This helps rust-analyzer to resolve such references.
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

Reviewed-by: Onur =C3=96zkan <work@onurozkan.dev>

