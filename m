Return-Path: <linux-kernel+bounces-798744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8BB4225F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5FE3AA9CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB630DEB4;
	Wed,  3 Sep 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="bSEQb82j"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981130AACE;
	Wed,  3 Sep 2025 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756907259; cv=pass; b=k7AhYHfEqaWraHX+y2+z3ByOCjTsf7l71JqY6UeqSyEcWWE66XKwh+bs9WQhl1BoBeEXnGKU4yytDaCyxAwrS8kJoJNcJazc2wXtWfi7Rzs6PtLRKLyqraX1cLIfjwjTEufP6fDDebTlICzHtowloVIyVFobVR3nqM1P51Jvpwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756907259; c=relaxed/simple;
	bh=ITJTWecC+CSDvkSqKeo9BXVvz8TjMY6zMS2W+ttZqRI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D7IYEHFSlJ+OI3PPXlLkxdRaf1Gr+PI5vbg3tDASBgbsI55EVuG6J0KL77GARkP4RBFutMUJYxp+zNHx5HEkvACkjzmXOPNMMjh1oFszCXhHlY0jHtbCg3XTFvwhkwvpniwrriTXlXMfD/BP8BNsFJpjHVOln5dhDue9EcTYthU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=bSEQb82j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756907224; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Sy8gKNkmpG47Q0A9MAR77itWBHvUdOTff+X5kQJyDSv9IuAT5fcJeNwCfA+M+cNVQdazTDmwM7VT9Nu+vyRCNzBO8CO+5OoryPany4+tK8mldqPQhuyBcmZaf6zTUwteOAvKEBCtLFlKyocNHgM7gncsMQytGSQca4pZa7xgPmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756907224; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9aAPxOQn6Z5+vfXZjg3b8yBK4ErWjXJUixPFKFs14ZQ=; 
	b=lqzX3Zqrm/X9/Ki25VkBrjfdt3b1BVtrMzYjv+GS5S7ECXUSHuFfr3FFkiwYQrUXiI34jMXZAhz1jDnyNPXGSQjq98AxxXEDozpHshdxuCe7A+p7ULJtxPSIx5BFHLXZp2cgEuQCI9cVCj3wV8U0owYTPtBh7LtFlmQy7IS8HFI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756907224;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9aAPxOQn6Z5+vfXZjg3b8yBK4ErWjXJUixPFKFs14ZQ=;
	b=bSEQb82jBNgi9OFte2HnDy/HS3awc2pw6RvXLO2D+Cgo+tkdtrm4hc0GNyAyvzui
	1oDxRWWSMBHPjP9kSlJ/WOnl2RsXxyf7kY2Wcm+lK2BRCZITILw4nci/IckbTVr37la
	LhcZnUemsrA+zff/DjY91YTmUKEbZf+h65cQZlVs=
Received: by mx.zohomail.com with SMTPS id 1756907222551404.6800223646171;
	Wed, 3 Sep 2025 06:47:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 1/7] rust: add C wrappers for ww_mutex inline functions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903131313.4365-2-work@onurozkan.dev>
Date: Wed, 3 Sep 2025 10:46:45 -0300
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <142043A6-0F31-4684-A203-AFFC6F36F6AE@collabora.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
 <20250903131313.4365-2-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 3 Sep 2025, at 10:13, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Some of the kernel's `ww_mutex` functions are implemented as
> `static inline`, so they are inaccessible from Rust as bindgen
> can't generate code on them. This patch provides C function wrappers
> around these inline implementations, so bindgen can see them and =
generate
> the corresponding Rust code.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
> rust/helpers/helpers.c  |  1 +
> rust/helpers/ww_mutex.c | 39 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 40 insertions(+)
> create mode 100644 rust/helpers/ww_mutex.c
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..4c789c5537b1 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -50,4 +50,5 @@
> #include "vmalloc.c"
> #include "wait.c"
> #include "workqueue.c"
> +#include "ww_mutex.c"
> #include "xarray.c"
> diff --git a/rust/helpers/ww_mutex.c b/rust/helpers/ww_mutex.c
> new file mode 100644
> index 000000000000..61a487653394
> --- /dev/null
> +++ b/rust/helpers/ww_mutex.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/ww_mutex.h>
> +
> +void rust_helper_ww_mutex_init(struct ww_mutex *lock, struct ww_class =
*ww_class)
> +{
> + ww_mutex_init(lock, ww_class);
> +}
> +
> +void rust_helper_ww_acquire_init(struct ww_acquire_ctx *ctx, struct =
ww_class *ww_class)
> +{
> + ww_acquire_init(ctx, ww_class);
> +}
> +
> +void rust_helper_ww_acquire_done(struct ww_acquire_ctx *ctx)
> +{
> + ww_acquire_done(ctx);
> +}
> +
> +void rust_helper_ww_acquire_fini(struct ww_acquire_ctx *ctx)
> +{
> + ww_acquire_fini(ctx);
> +}
> +
> +void rust_helper_ww_mutex_lock_slow(struct ww_mutex *lock, struct =
ww_acquire_ctx *ctx)
> +{
> + ww_mutex_lock_slow(lock, ctx);
> +}
> +
> +int rust_helper_ww_mutex_lock_slow_interruptible(struct ww_mutex =
*lock, struct ww_acquire_ctx *ctx)
> +{
> + return ww_mutex_lock_slow_interruptible(lock, ctx);
> +}
> +
> +bool rust_helper_ww_mutex_is_locked(struct ww_mutex *lock)
> +{
> + return ww_mutex_is_locked(lock);
> +}
> +
> --
> 2.50.0
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


