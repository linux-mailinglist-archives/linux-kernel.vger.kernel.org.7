Return-Path: <linux-kernel+bounces-840491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2980BB4898
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C1A161A67
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C225A626;
	Thu,  2 Oct 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTcdz2TY"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832117A586
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422526; cv=none; b=nREfgn5OSIHIxlOgYJ5zxzqBMDbxUJIg/JyMI4gbnf+vNMQdoOttwjwzJgNeMxEyjUzQwpBol7GD1fxLEP59HnQ5U65g83PnCQvz9h8xgdYitRrlYcK6PYini6OgujUSimg395dS4jUI6oLQA8X2fXm7md7N4GyqMsF88Fti9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422526; c=relaxed/simple;
	bh=R8brt8J1w6b7fpJJwWJpx3xH07Ssy3dMR3KPOrqUGH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7QeqkUgSgd/9rQ8RSlsZQy8iNcq8DKb9Xc9b/PbkiYyXm+kPA48ljFj4rGhocnXVGh4P7WlNeyd8nNQF5x4HWfSoruBqLAOgUF1o6Of/1T721orxfr7z06ggY7vPP+JjFfq9/sxLyAXhAdENnfao5rDjKkjRl+Y3J/dSVGKdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTcdz2TY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27eed7bdfeeso15974885ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422525; x=1760027325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxSop6KXcn5q36631eBJkfHEbmYYsB16EmXb2Rt0ZSE=;
        b=BTcdz2TY6g8+8cILTOVM5JuDMnnEReP747RYGuUkjPRSvL/OsTUT6Ah3cyLHuoiYs3
         MInQZQ7MndPOvzkXMN/RznLK7Oy1S8rvVJRtN7ARpdkqUXmI/OPPVZ2uF6DIJ3ePPB49
         t44znBpn6kBohxx0cv4v80AqfgY6PXQBel/XeArzwuVZ3bIQGvxUgkUHFGo6hEFt8f9Y
         JUXQZtC1H27y0FQfIkjlYRd0YBQd1+D3GFFWyvRdE9ttMi3B5n8OlbQl6hzrk1ah60Of
         kn/KU7vXWv8h9e4K+fjWuE2HRQt2+NX9JWbSsjrsGN46oJvSpncnBb4PQc7TdJYkafAj
         2viw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422525; x=1760027325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxSop6KXcn5q36631eBJkfHEbmYYsB16EmXb2Rt0ZSE=;
        b=poFw2HXIGsARLFhp1QK//+WsMcApw8nCJuUF07Kf9/N79Of9znxMYW1ZdnXeAPDsKs
         2fy/YhVzM4WupKZAZa+ybmxPd2ytyXd/mWqHhqaSo+ioW9PAQ1ZrBlePwdFgEp8e9rwD
         +tOeX34IwZSTFFaOsmZ48F4wdxNA7zNtdT0C/y93oAD+2SoD9QqJA9pFcrm3jWTjcVBZ
         3bZWBNG/R5oXOOdlXr8PSHySUc7MvT+rL1PiLdeeJoetSG9hS6vfKsSN14FjPuGC2vpz
         Cp42XZS3i6zK+Q84++sq6pcQVSM2eXXf0L8m8FQuizwMlABAeB81BSCPAUcbqL7pCbhp
         ni3g==
X-Forwarded-Encrypted: i=1; AJvYcCUe3ttaw8VlvikaDJbeEecYukUm8dZN0g448fkSttMxVXfHC/aDFvT7NFnZpHx+GKCH41RYWkkXxQiZ0UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPq2WbSxFyqcp+U/Qr7YCGcwLYkkO4GCsu7lyEsuywOwUuFu0
	PWQohXR0TvyBhfIllX2SCWyF//+FfwxJ9i83nrSVbd8fbK2E91pvpagWGY+Dm9KGxZDER1YQl1+
	aaewdm6nd6IqI6CUhBXy49LLSFldDkMg=
X-Gm-Gg: ASbGncvav4EK0fk2RAQ5Jb3qWBOSOibc3XGHzu5zeBqheOB6Ona2EQPlBgX+9UHBz9T
	o/5Xqmpdep+5n5UFs7hlgsWSrJfX6tfwQujgcqT8TsZIgz1zQFEpIu5DjQWIyK25YToypqdmJ/6
	u3xAaiF6cRR0fgJWmB1JzXuAa8+fFnN8GYCMNXNRVuOK5knoDwaYJBUHKbVQ0JVsmEBynMocv7C
	FfnKL4mIScMXXqDGJ4xKBGpBQVkbn8=
X-Google-Smtp-Source: AGHT+IEmPMz4MLeunlpA38mU4kLoqknyfp/Q09klwrTBeEpB/unLHj9ddxZqIRY+Py1NDvcwWGvbRMgB8y8oMzl3cDA=
X-Received: by 2002:a17:902:d590:b0:271:6af4:17c with SMTP id
 d9443c01a7336-28e8d00a326mr43453605ad.1.1759422524812; Thu, 02 Oct 2025
 09:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com> <20250817044724.3528968-2-fujita.tomonori@gmail.com>
In-Reply-To: <20250817044724.3528968-2-fujita.tomonori@gmail.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:33:42 -0400
X-Gm-Features: AS18NWCdtiHNZfbMjKUBT6WZOxX3jgc5-4hLDduk8LQ8Vlx3lQMnbQJCO-b1Q3Y
Message-ID: <CALC8CXfKPBc=axfyre8UTwO1uV=-P-u_atR5FVYG0UXszE41Xg@mail.gmail.com>
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

Imagine a Japanese typewriter. Couldn't be done.

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

