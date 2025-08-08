Return-Path: <linux-kernel+bounces-759782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9A0B1E267
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB1E166746
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496B1FE44D;
	Fri,  8 Aug 2025 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsRghfGN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBD71BFE00;
	Fri,  8 Aug 2025 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754635356; cv=none; b=AMpIY/oEakdC8+1YdPhsb5G1pSN2bZcssnL8feBivzwuHqOlyGoEoQA1BqN2qK7FEKdppHyjyPsttLvypXogzqLD0vOxzuhkZaHZuy/Y3+TYCg+ZYB59uDxQB6aGrAMEMUONa7tIIEYhY0/c97UXyJe/gQgBDEk4HRXpvqmy6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754635356; c=relaxed/simple;
	bh=H7hYBiN3M4U2JIds5ChXzVezSzmt+hfsL/d8kQDqA5k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TsB9S8mz2mf3ObByI02CEGr6o4NkFByubSTXyyqFEfB3emhZoX8nWnikv/F11R8bvpLqQObKQqs45xSX6yJHwGHB/8u3CrlR3M3BZ8pkJTVsK4ByekUcIOrvM+YeVJcg9PLhYr8KYKxXSZhmiOva1ogAi7CoCl16g192cp9MWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsRghfGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E32AC4CEED;
	Fri,  8 Aug 2025 06:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754635355;
	bh=H7hYBiN3M4U2JIds5ChXzVezSzmt+hfsL/d8kQDqA5k=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=BsRghfGNgbvQk0AKQznHIhPDzgzWJ907e3HpNlu623Pj30Px+SsPySSa/fK7vWeDu
	 TIyp4hidTT0E2TbwpEKHyvTZkP2hTHOGzc/SCInRjfmHPWzYM5tEoifvW/x+/FeOkA
	 3p6JF/BRUYqeqJTbYmJd/Z3EvvrxHr5h4ctfA2ay9suHdJE/gL8fX9N6uDHwEao9wx
	 4Q8uMhAs6KMkRFAA9Y8e3BCc1+XpWBDAHxrOaJOfVssdXex53EcMWCchpceRhXdiKa
	 wg1XnFPgM+Pkg9ZiIWUC8vsNZnnqPviFVPAGOWZ4AB0afW1BpFJte8Y5/NJKQdTmJQ
	 BuqSSuyxyRvJw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 08:42:30 +0200
Message-Id: <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic
 operations for Delta
From: "Benno Lossin" <lossin@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun.feng@gmail.com>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250807190649.3078875-1-lyude@redhat.com>
 <20250807190649.3078875-2-lyude@redhat.com>
In-Reply-To: <20250807190649.3078875-2-lyude@redhat.com>

On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of the
> basic arithmetic operations for Delta types.
>
> Keep in mind there's one quirk here - the kernel has no support for
> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
> simply provide Delta::rem_nanos().

We could still provide the trait implementations on CONFIG_64BIT? WDYT?

> +impl ops::Div for Delta {
> +    type Output =3D Self;
> +
> +    #[inline]
> +    fn div(self, rhs: Self) -> Self::Output {
> +        #[cfg(CONFIG_64BIT)]
> +        {

This pattern seems to be rather common in this patchset & in general I
think I've also seen it elsewhere. We should think about adding a
`if_cfg!` macro:

    Self {
        nanos: if_cfg! {
            if CONFIG_64BIT {
                self.nanos / rhs.nanos
            } else {
                unsafe { ... }
            }
        },
    }

But we can do that later. I'll file a good-first-issue.

> +            Self {
> +                nanos: self.nanos / rhs.nanos,
> +            }
> +        }
> +
> +        #[cfg(not(CONFIG_64BIT))]
> +        {
> +            Self {
> +                // SAFETY: This function is always safe to call regardle=
ss of the input values
> +                nanos: unsafe { bindings::div64_s64(self.nanos, rhs.nano=
s) },
> +            }
> +        }
> +    }
> +}
> +
> +impl ops::DivAssign for Delta {
> +    #[inline]
> +    fn div_assign(&mut self, rhs: Self) {
> +        self.nanos =3D self.nanos / rhs.nanos
> +    }
> +}
> +
>  impl Delta {
>      /// A span of time equal to zero.
>      pub const ZERO: Self =3D Self { nanos: 0 };
> @@ -353,4 +436,30 @@ pub fn as_millis(self) -> i64 {
>              bindings::ktime_to_ms(self.as_nanos())
>          }
>      }
> +
> +    /// Return `self % dividend` where `dividend` is in nanoseconds.
> +    ///
> +    /// The kernel doesn't have any emulation for `s64 % s64` on 32 bit =
platforms, so this is

I would say `i64` instead of `s64`.

> +    /// limited to 32 bit dividends.
> +    #[inline]
> +    pub fn rem_nanos(self, ns: i32) -> Self {
> +        #[cfg(CONFIG_64BIT)]
> +        {
> +            Self {
> +                nanos: self.as_nanos() % i64::from(ns),
> +            }
> +        }
> +
> +        #[cfg(not(CONFIG_64BIT))]
> +        {
> +            let mut rem =3D 0;
> +
> +            // SAFETY: `rem` is in the stack, so we can always provide a=
 valid pointer to it.

I'd just say "`&mut rem` is a valid pointer.".

---
Cheers,
Benno

> +            unsafe { bindings::div_s64_rem(self.as_nanos(), ns, &mut rem=
) };
> +
> +            Self {
> +                nanos: i64::from(rem),
> +            }
> +        }
> +    }
>  }


