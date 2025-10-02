Return-Path: <linux-kernel+bounces-840495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F85BB48B6
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EF142449D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B42264602;
	Thu,  2 Oct 2025 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYlJG3L/"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4C1E3DCF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422686; cv=none; b=ghgDE5pv8yTDrRm5bVzKf49RSGCK6oBFAdpkFag9uZSfAkcePlgJfXUi2MM4ujw57wTgnFqzgb9fYH8GQKn5DcoSO4MB57SHyIp1nWeMT669sQAFKsuDJHn9ULy8DMdoMbpEP7YRcdRIt2B12UZSJgvbGhWXioPK8pEU/x3qRms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422686; c=relaxed/simple;
	bh=8vOEb57v4DeDgKuQVBnG41w5FOouthhDLWBteN3W0uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6ko7S/RGEmxzRh6BURPrRX16SsZJPJtDDtcAAsxg8whAigOrUutgHVf9U2RbnHAuWRuU4Tt6DowCuf7I70+WWuC6gGiZa/um7U3NW7ATlogV2VEOwhfo5m5h11+FCdjol3lVxeB6/zrk6Ms6sSEgp6y200P77cBE/2zKsNmDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYlJG3L/; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so791948a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422684; x=1760027484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNacPF8Btbu5WhlG5yDeVxMJj9MDP6Ps9hs4rcuLvfU=;
        b=FYlJG3L/F6HFKKDMR6FFsyPWlPlKvC9ndFSLCHiZrneCSrMnSwiyTxMsKsnT0KrCbT
         ZQ03xrUiHgK7qPK+6Fmq+b2+tS/KiD08A+T78qBJrQJIHbyfkLoTy4S9cFz2lJM5ARh8
         4u+M1ZvXUmNDsZDM7bG40ulf7dFQj0LnotOoBEgZuMCWB/8/ypgBrSOkT98A+41r4nGu
         21jRfoskZQ7gKxzauvggO8xlmzSaI49bWQ5aKIFM9fo22EpapVx7OOYpCRvoqLjCuA4C
         c5Unc0TKZnKlZJ60B2Wcp6agsBeZtqvRjcSoheBJ7MowWf96HCvr/HyCkyhNjVXUdNqx
         KGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422684; x=1760027484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNacPF8Btbu5WhlG5yDeVxMJj9MDP6Ps9hs4rcuLvfU=;
        b=Xuk4qkA4d+W0q+z/ixnvOFfESb1Un82GO+niHQwIt4yktwqfd5xRF6cXgE1Ky6djl/
         17unUTiE1Zl5sX2uibw6aGoMOK7czHQ9gdkB0iIATO+EzladSp8TUTc5YB5D0b0NAEIc
         7SWmyqnv+rYxxQEMhBuL6u9uAALGuTxR3kyS16K4crke4iyoeXX/yRvTWnkI33BGMJKT
         j4Tl9kamr+yRZsx5ofBnPZY17Vi4nTnv0XkGFxXHfIlbGX5L3Ik+lSGztU6/gIEJhnk6
         1VOszPsdV0cMVE++hsyHqVDRg0TJK6r7qd1oIOpSG46nM6fPbMAi3zLO8RptJEQiSDq2
         m91Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkR+4nxUwGP17RquCisEF5/GONi5iU2L7KTwwnHHZ85OVZ07+0mom0IhbePUD3GYKoK850ja/A07TiGXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNkWemw792EEw8LHMsJ3ExmsT3KpKpWP4Cq2oDcOsVMOx8S+7o
	976GdIh7I/+PxS0ABRbvuOHTFZU7B9ZdJfhfkGTJ2OLmtGviKR86AkhsjbbPGhTZ4OaD5BTcY1s
	py89QUZc14XMQRILU7AYNL2zcVc6m7D0=
X-Gm-Gg: ASbGncvZFj6ZT3/iwwRWcrm+p26OPJDaWRyiApXyYWrHauoJaff5s7hkGgzrqfuXv4D
	3vjUeqCR1W6QZWpJq/rp0CmWtyukvLB5dALcNbvIBIADa3MZKV49xG6o8ONFPVzmVeXQ7cDLxFM
	4jNqn4CDu/YgpePeHwD0Hc1aXhP4mu1BCgaqeyc+mBavNqoPOs5kmvhIXAFuZhHbGCrzHz2R1c5
	OYSZqSnNMJMAdZILM7uhA0Owal9ywg=
X-Google-Smtp-Source: AGHT+IFnwnujcKRfK6SHtM+CXGmRj6y07MeK5a3YjdSerJUGN6mjdRxCw90XvSKFtGaY+E6xs5ra+2dbd8UIevjGgJ4=
X-Received: by 2002:a17:90b:4d06:b0:30a:4874:5397 with SMTP id
 98e67ed59e1d1-339a6ea3208mr9156539a91.9.1759422684485; Thu, 02 Oct 2025
 09:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com> <20250817044724.3528968-2-fujita.tomonori@gmail.com>
In-Reply-To: <20250817044724.3528968-2-fujita.tomonori@gmail.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:36:21 -0400
X-Gm-Features: AS18NWCOZJHPj9tkWYtN2k_ZmTorz1-zLbhHclnL_v_aOBMm4r-sY983njbIS20
Message-ID: <CALC8CXdU4PkSK3yy_tGi-ygRhFQG9UT2jLTmbv6q-RtESUPVjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: Add cpu_relax() helper
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	aliceryhl@google.com, anna-maria@linutronix.de, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@kernel.org, frederic@kernel.org, gary@garyguo.net, 
	jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org, 
	tglx@linutronix.de, tmgross@umich.edu, acourbot@nvidia.com, 
	daniel.almeida@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PaX/Grsecurity did everything you are attempting to do, 20 years ago,
and applied to all running programs on the system, and the kernel.
Ofcourse it went proprietary and you cowards didn't even sue.
(And yes you could have, and could still do it)
Pieces of fucking shit.

On Sun, Aug 17, 2025 at 12:49=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add cpu_relax() helper in preparation for supporting
> read_poll_timeout().
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/helpers.c   |  1 +
>  rust/helpers/processor.c |  8 ++++++++
>  rust/kernel/lib.rs       |  1 +
>  rust/kernel/processor.rs | 14 ++++++++++++++
>  4 files changed, 24 insertions(+)
>  create mode 100644 rust/helpers/processor.c
>  create mode 100644 rust/kernel/processor.rs
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..04598665e7c8 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -34,6 +34,7 @@
>  #include "pid_namespace.c"
>  #include "platform.c"
>  #include "poll.c"
> +#include "processor.c"
>  #include "property.c"
>  #include "rbtree.c"
>  #include "rcu.c"
> diff --git a/rust/helpers/processor.c b/rust/helpers/processor.c
> new file mode 100644
> index 000000000000..d41355e14d6e
> --- /dev/null
> +++ b/rust/helpers/processor.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/processor.h>
> +
> +void rust_helper_cpu_relax(void)
> +{
> +       cpu_relax();
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..c098c47c1817 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -110,6 +110,7 @@
>  pub mod platform;
>  pub mod prelude;
>  pub mod print;
> +pub mod processor;
>  pub mod rbtree;
>  pub mod regulator;
>  pub mod revocable;
> diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
> new file mode 100644
> index 000000000000..85b49b3614dd
> --- /dev/null
> +++ b/rust/kernel/processor.rs
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Processor related primitives.
> +//!
> +//! C header: [`include/linux/processor.h`](srctree/include/linux/proces=
sor.h)
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin process=
or.
> +///
> +/// It also happens to serve as a compiler barrier.
> +#[inline]
> +pub fn cpu_relax() {
> +    // SAFETY: Always safe to call.
> +    unsafe { bindings::cpu_relax() }
> +}
> --
> 2.43.0
>
>

