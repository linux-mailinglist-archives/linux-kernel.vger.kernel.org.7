Return-Path: <linux-kernel+bounces-840488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B8BB4886
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67BCF19E20B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890425A34B;
	Thu,  2 Oct 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy9lqgwx"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2341258CFF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422439; cv=none; b=eoC3dvCrorGoTE8FVQ08P1mh4BU3yOhDZE90lS+Deus+eGDlxtj4/CUUFV/RzOK8zJxmHJh0gME5nQg4oYa2rqyqUX3viupsj387msf90A2z+QF62UD7d64rhI7eDttRG3HhHY3wY70hW18lbIvqWCA3lb0xOM/PX/pn4LCruW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422439; c=relaxed/simple;
	bh=iuJt6EyzOnQPx52runwUNX2B5hRMmSyqHvZmOc6lYgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2hoA3rtIdkyByTwX4ZBSb6CiM+nNANHKCWW7bLC9PRn2naGrNZoiPZz+yQTiJC+K2E3KxNvDU+8CLo1B99uPBQ7MIZggPBhDvhq/lzUydCUqHLCDwt9PjG0s+L8p8CTOvNLA69qAYOUsgNothsuuytrxb1mzafIRAB140QSZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy9lqgwx; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3322e63602eso1856280a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759422437; x=1760027237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8RadXROYJdNyTk+CKzOBLVdQC3zF2j6wRZecigO2a8=;
        b=Yy9lqgwx7WMzOiHIt+EFd6sj/YTleZ9XgJOXSSBddVjzmULnmh+1f6NVwGgA0wrMml
         +gMvG/3lBOV8ei0rUlUErM6+O9Vh07Fz4gKiImEPywvdZo0ezrqQYE7j73aMFJp+qyZd
         kbxkvVt9LwYsCfmKxtbnDxRlmZEweafK7/Q+H5GRei37oAUy4abNdW237l5oT5U37npI
         A/gRRNYy442LfVtY2pJ3PcWQy1aePMh3R3WebXJPK736AHCmqTZ09HfpRFYmhD+MO+ox
         SYzPkV0LN88UC5HOTNCqCitz+SrvRHI+p3ORcMjU0mo9uJ1mfdtEnju2/kIOq/Im9CYr
         ky0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422437; x=1760027237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8RadXROYJdNyTk+CKzOBLVdQC3zF2j6wRZecigO2a8=;
        b=VU4+m/bn9IVAJcwIK2oQYwmEH+qMWBDc7q9ueW8RzzXZ/zq9BmW3I5oAmziOV4uc9N
         GQ/7YTxZ6mMYiLTZNXt5RnE2stjioDDsly8S2eI/YM405iEGDAdK0dGJS1OBkzgQsuHh
         zes+SSheIusNiryoRUtLyNmganL0szOr7a6UqXJt5EQnPfvurDF6lySj+MWZ/3XUCQH3
         4mOGQ4ft3YOpEZYeHoOzTgMFjwHxTCww08MVBKJaMKALLrFF6JCA03FvcdKYmkICgCQq
         l86j9Yu35SN7JaBc6UglO5vQkyxqOQiQn5Ro+eA5o/NOhw5jCeHjqq8xcx4ik4H+n91O
         mMZw==
X-Forwarded-Encrypted: i=1; AJvYcCXBV75b0SP5M9VqEOfLeIUO2iqKw4IPBB+JbQ2Q4hgwfQ6OiPWvwVq8oj/1+UpdICMXtwpemrSczYAh9Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqHSUYyRe4qQP0DaM6zIn+gcS/eF9X+KwQG1knpDk1ETt96cK
	Aia84i8MMwhyp8HnmQjBKtadBi1izGIyJnO6pcvw+FJj5mzL3n/ZPa8IRz8eyBDxFlIGTWa7NyP
	jNoHCYlQaqx1JjZUq0KwZ/Siu9GC2HrM=
X-Gm-Gg: ASbGnctKYyx2/OtYNwbA9b6jPVHZt2W52vMZWXFn7DSDrYUE1QY++I0n8BvOfe76BvV
	Pg1M7GFWPTliM426o1+4jybhSNmT7pIFTkGbqHrFeJAGfvmIl0rgzqz1NLxlijfLYRt37DGuyrZ
	wn9P1INBXgJozXHdm+kQqxcO1nhCuls+t9kLevgAkc7jkG9xcsJdu/JsRxka41RYsix/vOtFXYX
	TrK9B35ZxIgkisCVkqmcVAXIL5Owhs=
X-Google-Smtp-Source: AGHT+IHnbGm5Znd26plBMzHCxavhzC+W+Pclp1lJoR5jx/BAEqaPwsCkhD/kJRBDuIKf0pn2ZwtJFZk6U48IQMgBgUg=
X-Received: by 2002:a17:90b:4d06:b0:32e:5cba:ae26 with SMTP id
 98e67ed59e1d1-339a6f3010emr9625217a91.23.1759422436999; Thu, 02 Oct 2025
 09:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
 <20250817044724.3528968-2-fujita.tomonori@gmail.com> <843AC662-BBC0-4879-A5F8-68C41C660A59@collabora.com>
In-Reply-To: <843AC662-BBC0-4879-A5F8-68C41C660A59@collabora.com>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:32:14 -0400
X-Gm-Features: AS18NWDYFOiKF88Rmf8zP8unWiy4cYHxisabLssLedCg1irPDib5_TnI5arBTzU
Message-ID: <CALC8CXcD38T5-Ec-V8C7ShyOxDt+XjrgysDxO+B2vOvh2fGRaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: Add cpu_relax() helper
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	ojeda@kernel.org, aliceryhl@google.com, anna-maria@linutronix.de, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, acourbot@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Futa Daniel?
Comon.

On Tue, Aug 19, 2025 at 2:35=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 17 Aug 2025, at 01:47, FUJITA Tomonori <fujita.tomonori@gmail.com> w=
rote:
> >
> > Add cpu_relax() helper in preparation for supporting
> > read_poll_timeout().
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> > ---
> > rust/helpers/helpers.c   |  1 +
> > rust/helpers/processor.c |  8 ++++++++
> > rust/kernel/lib.rs       |  1 +
> > rust/kernel/processor.rs | 14 ++++++++++++++
> > 4 files changed, 24 insertions(+)
> > create mode 100644 rust/helpers/processor.c
> > create mode 100644 rust/kernel/processor.rs
> >
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 7cf7fe95e41d..04598665e7c8 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -34,6 +34,7 @@
> > #include "pid_namespace.c"
> > #include "platform.c"
> > #include "poll.c"
> > +#include "processor.c"
> > #include "property.c"
> > #include "rbtree.c"
> > #include "rcu.c"
> > diff --git a/rust/helpers/processor.c b/rust/helpers/processor.c
> > new file mode 100644
> > index 000000000000..d41355e14d6e
> > --- /dev/null
> > +++ b/rust/helpers/processor.c
> > @@ -0,0 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/processor.h>
> > +
> > +void rust_helper_cpu_relax(void)
> > +{
> > + cpu_relax();
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index ed53169e795c..c098c47c1817 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -110,6 +110,7 @@
> > pub mod platform;
> > pub mod prelude;
> > pub mod print;
> > +pub mod processor;
> > pub mod rbtree;
> > pub mod regulator;
> > pub mod revocable;
> > diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
> > new file mode 100644
> > index 000000000000..85b49b3614dd
> > --- /dev/null
> > +++ b/rust/kernel/processor.rs
> > @@ -0,0 +1,14 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Processor related primitives.
> > +//!
> > +//! C header: [`include/linux/processor.h`](srctree/include/linux/proc=
essor.h)
> > +
> > +/// Lower CPU power consumption or yield to a hyperthreaded twin proce=
ssor.
> > +///
> > +/// It also happens to serve as a compiler barrier.
> > +#[inline]
> > +pub fn cpu_relax() {
> > +    // SAFETY: Always safe to call.
> > +    unsafe { bindings::cpu_relax() }
> > +}
> > --
> > 2.43.0
> >
> >
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

