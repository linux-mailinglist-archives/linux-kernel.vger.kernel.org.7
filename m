Return-Path: <linux-kernel+bounces-738297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE5B0B6E1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850911899EFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F01A0B0E;
	Sun, 20 Jul 2025 16:17:50 +0000 (UTC)
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540745948
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753028270; cv=none; b=prM0ShwkhzK9SibKfDNcyD1iGKr9puZV3Gt4qoH0YcOOrPzpPezz4NOEdZ+X7Z4LPhRvAkTBG/jvQrVx5wPZNAWEQznAHMBQSuXAH++f4Si4/WP+8wKC/HE00k0eOeFjqSqVu/IM7aYJwK5kkBc1NuAW/jmrGXJ7w0Qz51UrfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753028270; c=relaxed/simple;
	bh=pYy85xJpgwrv5V05MA2BT6ezIz9RyEoyJpQKilqzLBs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiTlkcMztwHrxWxRSY39MzODzv0+fvGh12Da2Rs4IWAzp7oC46+RKplBqJbBMJ/4QFTOHE7Ax0dG8JOFJk1z0BFXUCP/64QSyhYAHzA4ePTZMffq6GbAr3hv+Evz/008N9iGTWdxP+S696hHkuIHipL5cGrEUd0iOWHcaH7+wW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=antoniohickey.com; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antoniohickey.com
Date: Sun, 20 Jul 2025 16:17:40 +0000
To: tamird@gmail.com
From: Antonio Hickey <contact@antoniohickey.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, contact@antoniohickey.com, dakr@kernel.org, danielstonecote@gmail.com, gary@garyguo.net, linux-kernel@vger.kernel.org, lossin@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 1/2] rust: kernel: create `overflow_assert!` macro
Message-ID: <20250720161733.364025-1-contact@antoniohickey.com>
In-Reply-To: <CAJ-ks9m45p9FHCvbuOS0zJvZfHMcXOLvN+rfjQfyNTHzDovspA@mail.gmail.com>
References: <20250629024310.97937-1-contact@antoniohickey.com> <20250629024310.97937-2-contact@antoniohickey.com> <CAJ-ks9m45p9FHCvbuOS0zJvZfHMcXOLvN+rfjQfyNTHzDovspA@mail.gmail.com>
Feedback-ID: 144211621:user:proton
X-Pm-Message-ID: c33fc07c927ce71e25216eadeba531ebd346a7dc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tamir Duberstein wrote:
> On Sat, Jun 28, 2025 at 10:43=E2=80=AFPM Antonio Hickey
> <contact@antoniohickey.com> wrote:
> > +//! Overflow assertion.
> > +
> > +/// Verifies at runtime that an expression is within an expected bound=
.
>=20
> This is a strange comment, imo. The only thing special about this
> macro relative to a plain `assert` is that it disabled when
> CONFIG_RUST_OVERFLOW_CHECKS=3Dn.

Special yes, but it also documents the intent of the `assert`.
I did include a comment about the conditional behaviour with=20
CONFIG_RUST_OVERFLOW_CHECKS being enabled/disabled.=20

I'm open to rewording this doc comment to be better though.=20
I should also add information about the optional panic message=20
like the `static_assert` does as well, what about something like:

```
/// Overflow assertion.
///
/// Runtime assertion that an expression is within an expected bounds.
///
/// This macro is only enabled when `CONFIG_RUST_OVERFLOW_CHECKS` is true.
///
/// An optional panic message can be supplied after the expression.
/// Currently only a string literal without formatting is supported
/// due to constness limitations of the [`assert!`] macro.
```

Thanks

>=20
> > +///
> > +/// This macro is only active when `CONFIG_RUST_OVERFLOW_CHECKS` is en=
abled.


