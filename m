Return-Path: <linux-kernel+bounces-888122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A779AC39E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F5D24FE0B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0252DA760;
	Thu,  6 Nov 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0rBDgYb"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B6219A8A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422370; cv=none; b=L5nHuCoBn66ADI1iKS1SgsYyIWtw0ARjZrI4usRGrNbKU4oj9W9qFKLoOeFCHnYb/7Lz31ZCIHV7qRe7ifsVSFyig2KHcak+S/Mubk4jTz6UZ3OdBhGCM7gb5P3hpBCzG/ajN0np002ubLz1M3c1THizBL8A5B0tyfyf6YF7pnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422370; c=relaxed/simple;
	bh=Mn3T+olJWkjKyF/E67P6XmymSiLKVXQa4Mazn3xCs9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ao2UmskoFEu75Z7r7+qe1mB6mYtJ/bt0rqS+IhAu/XMEKuyekfeYrimPWGFbi0JLadKlns861q6sdZljSkSqoOK+dR87ZlxfTTllQFQIWzOalp7quK47LjujzUz1o9mXp1+2f/zpFziVmLAQ/tIChdxFzDK1BDGl/tqGbYeQTvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0rBDgYb; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47717c2737bso3816695e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762422366; x=1763027166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aix4Acw+nbEhYjch7yKV43Ctxsclquvbd1Fy7kEqFUQ=;
        b=T0rBDgYbJ07OO1ISAXCqToP8LW7Ai8kNq6H3H9yqpBq6JdKaZHYELMifWPbuwUIroQ
         Pb18vGiHDDOu//KFDu9/1W4Hj5BGtfYKLMYzFSztVDndA49hlLRHwcgds9Ge6OCjfsgZ
         BHuhdMYZlxEMeoBYC+Uzn6dXhNdL7XpwEkbrG5Dd0Wkis5X40puKbyNGKCin8r/iWxJv
         KnD9rljPoJiXFf0M+mybrIyVA+a1SK4JZ5xtTwZm7f2Rd9XiebE+oAiKYW1wsKrtB1Hy
         DMgZwpxKXjlW2C0Ot8LB5rKzfrg/1bnmS8f3t3Eg8h43kCb8pRneiN1NLQCVvjVglj6N
         QElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422366; x=1763027166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aix4Acw+nbEhYjch7yKV43Ctxsclquvbd1Fy7kEqFUQ=;
        b=DBLVWYD16AOg7pcHh9YGW62hYwpz5/fD2AoJ07ZPVRpjDiBld87kqLgGQHlZEdu9C5
         4mz51Zxzc0aNQBxjWPrql6vNVGGhCCPDXbMvL4JDPlGaxAC4lafVps6ul/9rVUarUIlv
         MtiAwpKrS85qaTXqVPwfX/rtqJYnl5USeeCBtaMIaMOO64mcsSouCWyRCJzEH9NpkqYc
         Gw79KmLFkj0zSiAa0lcvsVpXQ2hQG9+Hs3qo85oYK6SlmE8MNKEToBwrD/jcW3NuESXl
         wJtN+9ZsJnyWVcg4TBWD+EDqpCJPSkBMKxnlBRgDv48P9paA5esLZQxedVxXSMJ30gK+
         2kHw==
X-Forwarded-Encrypted: i=1; AJvYcCXjucpzUfqbcLoxGoDHnNeX6j+8tZ0M8iF9lHdk0vYwlL04XYHEZdIq1MVfHgImCmZiSIo26KI52ZmDgeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywds3OG5DCB4kV36v/FZETXNhT4NlomtzC9rWqEMOUz8G4eL10b
	PLkWRtXbw7mZNB1WKvLDnzkNvj6lSQu+PD+QSnifqWkFOkVcCLNCa1iuUkcWX3WW1irVWKxW47D
	3CTOdt6wFZhcK3iIqpA==
X-Google-Smtp-Source: AGHT+IFmVA1xNIGCcNf9IoDie9a1/s000xj/Ax1t3MBX/DSQkfsl3pc48TOjCIbKNxOmmZ+rjbpUE5JA4Ur+Ulc=
X-Received: from wmij16.prod.google.com ([2002:a05:600c:4110:b0:475:d804:bfd2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b90:b0:477:333a:f71f with SMTP id 5b1f17b1804b1-4775cdbe596mr51385095e9.17.1762422366207;
 Thu, 06 Nov 2025 01:46:06 -0800 (PST)
Date: Thu, 6 Nov 2025 09:46:05 +0000
In-Reply-To: <20251106-bounded_ints-v3-1-47104986a5c3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106-bounded_ints-v3-0-47104986a5c3@nvidia.com> <20251106-bounded_ints-v3-1-47104986a5c3@nvidia.com>
Message-ID: <aQxuXd0-EycU7p65@google.com>
Subject: Re: [PATCH v3 1/4] rust: add num module and Integer trait
From: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
	Jesung Yang <y.j3ms.n@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Nov 06, 2025 at 04:07:13PM +0900, Alexandre Courbot wrote:
> Introduce the `num` module, which will provide numerical extensions and
> utilities for the kernel.
> 
> For now, introduce the `Integer` trait, which is implemented for all
> primitive integer types to provides their core properties to generic
> code.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/lib.rs |  1 +
>  rust/kernel/num.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 3dd7bebe7888..235d0d8b1eff 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -109,6 +109,7 @@
>  pub mod mm;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
> +pub mod num;
>  pub mod of;
>  #[cfg(CONFIG_PM_OPP)]
>  pub mod opp;
> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
> new file mode 100644
> index 000000000000..3f85e50b8632
> --- /dev/null
> +++ b/rust/kernel/num.rs
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Additional numerical features for the kernel.
> +
> +use core::ops;
> +
> +/// Designates unsigned primitive types.
> +pub struct Unsigned(());
> +
> +/// Designates signed primitive types.
> +pub struct Signed(());

Since these types are not intended to be constructed, I would suggest
using enums so that they can't be constructed:

	pub enum Unsigned {}
	pub enum Signed {}

Alice

