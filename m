Return-Path: <linux-kernel+bounces-766826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC0B24B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE77B3AC84D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8EE2ECD30;
	Wed, 13 Aug 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K45tBbhm"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FB1A2C06;
	Wed, 13 Aug 2025 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755094011; cv=none; b=GF19O3ITxJ6/avYhdKnyZL4u/6rS+JH+ACaQ1dFP1IOK1ml1QOyGOIvpwZEw1McIi4rAF7A8wOje1x2wbme8pfKSlQECT3Ljvxy0kPR/6peX3LareaGTx+RwxZchLXDkeQK4hcotRvPoBV6MJPU+wJA1NiyKds2KVpOOLkmj9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755094011; c=relaxed/simple;
	bh=TUhe462rpaRw+ttM19CVeBJRmw0ypfG6fuqRpsFUOwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN8zfBRfQBwA0EYuV+MlG8aTq1a9LOimuU5q2818Yb1frlvFutFnqCRi5cK/lgHq6vryYJFIP15z6rMCXdnV2yT4JKRz0fB0WtoxdWtOR3TKQ5WnpPncl+vQjjHJFp1Uddh3JUk6L/YKkCOqOQTozCm9wo4JKHgunE1U7pCe37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K45tBbhm; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3325cb38a78so57542201fa.3;
        Wed, 13 Aug 2025 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755094008; x=1755698808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC1R/DK6yBDoppBpO/ANc/qcnsSJV5b088uYsuMvfZQ=;
        b=K45tBbhmzgnDUcJHnuwf5A2p3BBWTQ6RyzU5lHaglMjT9C7sNJOvriTvA20bKBwXNu
         RrBptxaolsL9Qs3llRMSijUGSAsujt7vYcM1hdDyKRcuYFZg9tsiSb8luTo4YLYbbUlZ
         GNYyubOTB8ac8HmZHMUd9kcr6mcwVA62v0Hx6yYPIEZ8EuU/E9srP/Lv9dIcMbZMTI5E
         +/AFn0vknPCRbKtOm1mtCvToYZe63RnTSj7yPYBBVlA64y6f/jeVujmtxyEy8IZikiEX
         6+e4SO5C9TOQRTSzukq9ueAUt7KhccIMHFrGHsyc6mgZ+Mx+6q4mhjqh00NDO9JdS02q
         yrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755094008; x=1755698808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC1R/DK6yBDoppBpO/ANc/qcnsSJV5b088uYsuMvfZQ=;
        b=lr7r8WhF95wNdcnLuHVSCHm2Q7b4Bj7nr0lz+BXl5PcHCYSwF4O/1NdPcNHIF6BqlH
         ugR6cIP86GR4Wz1CMpcDdKDu9FGCtSvinLJJGRrQF1EHfe7V54gIs+7E2w4jqflFW8vw
         7MWNRUhrq1KKfJ39noTfCOzZcUpx7kNdv7+zloZtA+PC5JDk2TISuEgvFDUHxBTmqPUB
         4aiijyhD8WjUWiOK+nAUpxvF1Mr9UUMHIeMfeAbiFdgeudsxJ8hjwCKzPDLOgt7pc4oq
         fdOwIVZ8ie6OcF+OY1aSV/VV3O5kRVuMEMlQCqJVFyXPY+FqnI3rebeh5hvq7iDLA/lv
         AfTg==
X-Forwarded-Encrypted: i=1; AJvYcCWGnGWCz+ZmiVjipmClfScNIPiWzwuwi30xunneBL7wkh/1V/S38Dnz++1bTLmfz0D0vOy6bnFiMv4SZIu6kCM=@vger.kernel.org, AJvYcCWfcgpEF8e8kPhvwFwy35wWO8Pk/QWtUEmp6hC25EqCiVg+esGO4WXz1vJ7127clx5iFRQ6XoKfvK1jGYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wHVrJS4AgvT+awAcRxzprTwcbipyMHjVVCXqJ2Q8Mf+BXxRN
	tR7QtAL4WuycFWYGl8YEhXv6DHnkKj7s/wXpnQJVfzbI2htsEFbe+2m0UCpOjbJP4mWZJu3khLT
	fjoJDj0vYvRvqJjMP6NaZpF+/gSPa1z4=
X-Gm-Gg: ASbGnctMweKIqcPmANMxbWoSQ5D5J6WRkSANShR5oVtJvZkn3VryfKMq8f6VIzhl0/E
	qeSLT3bF403+xkjwoJHMny/2K2W8mejrQ4j7lBx3JaX/NNFiRJ/J9DCgCkNRZvpkpLPLo13AXKp
	qYYtQkU+/IaKKdM4Pk93lHxCfFhJyOuPWiAsj11un7dapHHpQhrvJewgGi1PZHKsEWaSXGXKGBM
	vk6twes2pH1ZhmdYYdcSZ09cE+ccEq2lKWrCfWbLkn/K4s5aYjF
X-Google-Smtp-Source: AGHT+IGlYVXCrZspPz79gXKuhsIHFH9IVC5K+raTW03wdtr4jWtw7isq+6fZau0gAWPODEszswwvfFB6ygab/7W9Pfo=
X-Received: by 2002:a05:651c:1503:b0:332:1de5:c4f7 with SMTP id
 38308e7fff4ca-333e9426d4amr8531731fa.6.1755094007760; Wed, 13 Aug 2025
 07:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
 <20250710-cstr-core-v14-3-ca7e0ca82c82@gmail.com> <DC0A9UKTPH05.2O2V0B2KHMIW8@kernel.org>
In-Reply-To: <DC0A9UKTPH05.2O2V0B2KHMIW8@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 13 Aug 2025 10:06:11 -0400
X-Gm-Features: Ac12FXw-kWPtM3xN5Aaz38o05b4WDpB1DVGRJgZzy_fHeBatARY6MtIVInkMea8
Message-ID: <CAJ-ks9n4V-PEDhkTv6SXj_Oh6LB4LdsNi8Nnv_6JbT7dhvnh2w@mail.gmail.com>
Subject: Re: [PATCH v14 3/3] rust: replace `CStr` with `core::ffi::CStr`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Christian Brauner <brauner@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 3:50=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Thu Jul 10, 2025 at 4:53 PM CEST, Tamir Duberstein wrote:
> > `kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
> > add `CStr` type") in November 2022 as an upstreaming of earlier work
> > that was done in May 2021[0]. That earlier work, having predated the
> > inclusion of `CStr` in `core`, largely duplicated the implementation of
> > `std::ffi::CStr`.
> >
> > `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
> > September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr=
`
> > to reduce our custom code footprint, and retain needed custom
> > functionality through an extension trait.
> >
> > Add `CStr` to `ffi` and the kernel prelude.
> >
> > Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f=
8e43f1d8d5c0860d98a23f [0]
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>

Thanks!


> > ---
> >  rust/ffi.rs                     |   2 +
> >  rust/kernel/device.rs           |   1 +
> >  rust/kernel/error.rs            |   2 +
> >  rust/kernel/firmware.rs         |   9 +-
> >  rust/kernel/prelude.rs          |   4 +-
> >  rust/kernel/seq_file.rs         |   2 +-
> >  rust/kernel/str.rs              | 395 +++++++++-----------------------=
--------
> >  rust/kernel/sync/condvar.rs     |   2 +-
> >  rust/kernel/sync/lock.rs        |   2 +-
> >  rust/kernel/sync/lock/global.rs |   2 +-
> >  10 files changed, 106 insertions(+), 315 deletions(-)
>
> > +/// Extensions to [`CStr`].
> > +pub trait CStrExt {
>
> Should we make this trait sealed?

We can -- but is it harmful for someone to implement? I think probably not.

>
> ---
> Cheers,
> Benno
>
> >      /// Wraps a raw C string pointer.
> >      ///
> >      /// # Safety

