Return-Path: <linux-kernel+bounces-840493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E746BB48A4
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E927ABE32
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6F25A65A;
	Thu,  2 Oct 2025 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoDsFEmy"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE72BD03
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422597; cv=none; b=t1cNZCzGo91/4gdWz+ifrUpvoBCMxTLKWcmfvGyX1qpNJpHoCVT1uBJHl75ZoHHg2Z61fQZo0hqUHeD2BkTROWebnx15SfgUZjG05zzJqQ8rmXPf1zP2mITxgUNJIhDEwKHb6m5QW1Pb26L8kaBqMCj1hGVlBFj8psyOhZ+fbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422597; c=relaxed/simple;
	bh=x9hYAArqMeGicQwVO4aAGaQ5LFClBvY1j5G2TwlIfbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gjhian5zFSs2Tsk7IG+4uXeK9FJhV9FHpTQkRPV3Jr0e4pPR8GyBo3HT9Fem6yu6PzCJV13OtcF1yC+B3GZ79TrdHZ8srJ47Kou9MpY19E5zB651k+/KJjTr3eAMF0CFGMKPSqi/+5Xgq5E7pVMtNJiNJX9JnGIwjzRnP1nK2ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoDsFEmy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3304a57d842so1187152a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422595; x=1760027395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHoTuJJ8AfzEcY5pfjyL0sTJOZGpsUEORDoLpA2bUs0=;
        b=JoDsFEmy76soUYPgZMfOeBLyK7EGtYXmE2gt7jv2Z8HOmLW14HN/6rOZWn1xsSZgTz
         oPTnvXwn9E7eR3mt/02ED8M2unMBhOI+VLeftF6yd57aPzo+p68trZJo5D3odR2uK2jX
         5OSbcRDdgqxpKE1A9wKvQ8fYyJWOb+loocoZZwWTGTrrF6ciCqZAqMXagXOlEscrxXLN
         fasD+Qx9dWCEQBnVNU6Ij9d+z5xtu5/7PhdqgMcIGWoQx3en8hYDQ5oqJA7vAfEnbu+8
         tqtj3KSfBPVjJSkDGKZ2n1JvXgQlYVP4xBHGyPjwccfGmxzbJpOHJP+OgZwQIi6xc5ty
         bTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422595; x=1760027395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHoTuJJ8AfzEcY5pfjyL0sTJOZGpsUEORDoLpA2bUs0=;
        b=IsKD0iLQfJXeGeybDJ1s9joDzF+qQ/oCoNYLvPFQKXGjjFV88zECRMrDBMxZ8IIGIA
         ZO4Ml3sM+6SodqM/jB2bHEuT4ld+oz4EscdugHD1Zl5ry3ijC3ipUNk/wnc9x2OeqzTf
         /uh49kxuMcZDaKx4yjrveToVTpSsMyqQ5JAl8Sx3eXrCY+OPql+Fr0MjFyXT78xstQIm
         PTstAfaFtBfDXfSuOrq14IR10s1H8pEaZ4bxqQTTFZSGRLy+NRjosmMugfT3TtrDhTwU
         qG+5W0xoom7JWZidtoMslZOzxdtnUxNZJ+bYr4P/1PfNiQnIC6fceakuBuFWTH2GQlHG
         OJYg==
X-Forwarded-Encrypted: i=1; AJvYcCUW0uGx7U0XI+p7TFK05d13+WkqyiNsR3I0cu3u5LTHwp7WRBGgBC4nilsWPfAmvRC0NyPJ86Idv3cw92c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7fjX3n0O1p1OOv00xJmbXAINa7webqz1RgqSr41Na6qVmGDf4
	g94dbg+lZdc+9wZKa0Muk48vfTIFWapllgNoNzEJ5efCLCWipu3C+rZ9UhZXvD7A/BMwKjGUuMS
	QMwSGXpSA9HhQeINRa7jW7jkNFjC/9ebFgK6x
X-Gm-Gg: ASbGnctlf2w5wjCfaanU9Zd0R5G13hjZXFK3BrGcVWGLe1F/EUFtMFlxG2kOXSSlyTk
	ctUfktvyh++xfOyF7xEw5jmGZ4R4wRYY22RDP/7Lalb+5GgrPblXVf0ALQQ4iXRBW1iczWXOL42
	soMgDmJ0/+EzEZUVgJGx+acDAz/T+uIt3M1o5VwepYIwjdeawPbYNP9fIvT6n2JDJB9LQcTgmq5
	bUNjNyiF2RhLFTGK0nW1eoSnLiePSI=
X-Google-Smtp-Source: AGHT+IFIgPcmPFHu6ydpBX+LcaaxQKdA5pFtu25OpqJED5PdGVTKzE/gxfoWMu1ti1aeiIMjFcmrHAf2cSHroAMOU8M=
X-Received: by 2002:a17:90b:33c2:b0:32d:d8de:191e with SMTP id
 98e67ed59e1d1-339a6e94f50mr8973125a91.10.1759422594991; Thu, 02 Oct 2025
 09:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com> <20250817044724.3528968-2-fujita.tomonori@gmail.com>
In-Reply-To: <20250817044724.3528968-2-fujita.tomonori@gmail.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:34:52 -0400
X-Gm-Features: AS18NWDSkVWWR18PWpaY7lou_TtcqRCUWA1IUJF9HuLwoN19aCXIp24D9D5a4IY
Message-ID: <CALC8CXei5o5fWrMcBZXRYmFCQuWgimsch_FHp7oZwDNiz10LYQ@mail.gmail.com>
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

Thanks for taking over our C project and running all the C hackers
out, and making it uncompilable on old systems.
Thanks.
Really great thing this opensource, these days.
"this is a RUST project now"

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

