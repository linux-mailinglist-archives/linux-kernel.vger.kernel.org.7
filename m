Return-Path: <linux-kernel+bounces-869298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C63C078F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30D9735898C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7276345CA6;
	Fri, 24 Oct 2025 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn5eoBEp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE73324B2C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327557; cv=none; b=eEBD7woteUPDelw4VXL0GSjEYubxFy3k62chIWQUnxUxoc8pzWQ4MjmVEaHp2eEBDdJHQD1WnLvM2HYfiCnvwnJHZ6hEIM+nuh4Pk2DIqs4Toyj/JGrlxBFZEcMalXTofzERo7+s3ByFe9LK2tv5vOGnNMkgrOnOmi8UyiWn32Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327557; c=relaxed/simple;
	bh=joAJvp2loFKjm/U5Cbq5rKJ7q2/HATCZly6nzVlN9hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXlfRaJTZi2WCDgmdJDUBSbtb5yW3KE44bqxAScWoFXROEL1uoONvtiqx8kuHpkxYBvHUsiK6lUvTYMFflvNXbUxy/UeSQq7iSO61ekL/gvDnMQvE+iqsnVL4/QbQP1dWnekMXc+jvtv3jcLmlvVBvHG3r6Kqh2fWfnQF606mTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nn5eoBEp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-269640c2d4bso3648725ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761327555; x=1761932355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joAJvp2loFKjm/U5Cbq5rKJ7q2/HATCZly6nzVlN9hg=;
        b=Nn5eoBEpJA498aevo0t7Lflp6E0Gwtb4fKPYu2mJeLcyG/iJLGIqorI1v+XYEdiWs3
         xDZ/gBF4enfryK/eYi6MZlhrdaBXnpq7WMwqIZMCNueMOrJpfTIQfFejUUILV8iBp+Xz
         Uo4OlfpgR74Iwm/MgGN0vlPap0Fy+eNOMQ/ldq00BDaO+zMi/KXZUu4IwPeai573lL9Y
         Jp8Dxu0AVtvKnKcCF8+2Uv/ngftCqQtxy5kUiucZj0h0RDQGwzYhhCpsQfThMifq+gZO
         /Ir7nD6+dFTslbh+ruZdrjySYSWvgs89/nmIBaLI37OZntOkK+crajGcmHBAQwWiiQBI
         hZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761327555; x=1761932355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joAJvp2loFKjm/U5Cbq5rKJ7q2/HATCZly6nzVlN9hg=;
        b=DrplsRexkpY6kMl9gWpgaaz3Xc0nB+HV35XqN87Hlob/ROWTk4mc9IZO93W3xXfvOi
         8RlbZiiyUkFigVz0uV+s6lma89dPPogag1Zkx+2YW/YfqqHWfAyhqgoYAoFvp3+c5Ay+
         H65cRRj+7znm8tWE9Tf436SzpCv8gHg3QRFbXR4+WIUwUGYPJ08RJ+6/RfDePn7W7USk
         CaNUsPwmQzIb+OCD9qoC85tCVf3yiQKK1Ur6veJFZSemgjC6icBzZfx9RqGEZdrl+1dO
         fid3+GQmOZgcq0FDJchJpSwoRyOobhBkLIOK7p8yE5Ep+mPy6JpbUoaQm8QAzWSI8IpM
         XxTA==
X-Forwarded-Encrypted: i=1; AJvYcCWmkF4H7OGSMfFMrqkXWFtF1gmx0zwExBoPrmmnrtSgOF+cyhIfoyzLfmhmYpti4QVIlgLVphggZeOljMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/y8LM2qnnqnYELmV1dHvXDJKJtrZPrjMxGr+nyG6DrHGqAjW
	6o+NoeD1linfZIN1lxout5/7a1d9CdOyfXMf0W34aNhjM77wyoGuccJntqlVoxPPBBCzjEooItP
	VROhFhWDkNMdTYqbUDu/Gk6iq79UL4dc=
X-Gm-Gg: ASbGncs/XBKs4BJfJx3D+Ox2A2jMX91qItsL8JNfy2mZuBB8sCW1r+lNNgKXcBcP85z
	fdF4t+yaRMnMN5qVE06N8DUPAzNMvWtFgMOYxpgg3sPlo8mMCBHjo8sJKIKp3D+NOBnVxhyGibV
	rLDAWQ2r1gEWm4VkyR9EXov9efn+Wi8ROFoUJi6bglmFjN4SU2LXI8GNd5vHzPyz+lbzXWiMVof
	cRUFZcHCqvLyZzKMOc2MYmVtIqMt4luHp6CCgQcZRMuG1iqgTWSxktDi1TMLCmw5m2tbHwqEvZf
	P3r7ojXQCsS62cjFzLNDSBhoYKys3XMlao/+8Ukb9+v915rSf9gEXrX8fMmNGExvtCAwKHbpSy9
	2Exu5CrIPD6ppyg==
X-Google-Smtp-Source: AGHT+IFEt2hbUYHBszY99Yu4l5V0rr2K5r0yGPuNwplUsRLx+Ng9+gZWVZnNUa9MZwfrnud0uDi1EDTiWXhh+43792E=
X-Received: by 2002:a17:902:ec82:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-290cb757692mr210666995ad.6.1761327555182; Fri, 24 Oct 2025
 10:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024154754.99768-1-yury.norov@gmail.com>
In-Reply-To: <20251024154754.99768-1-yury.norov@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Oct 2025 19:39:01 +0200
X-Gm-Features: AWmQ_blXSYlIZPVN-NCsjwHVckUMrPSTltu8AaeFN_4CJTIcrnQs847DTDcGsTA
Message-ID: <CANiq72mDTjNNgEvMEvNWWg++1aUzry+TW2sizhhK5mTyOfEZTA@mail.gmail.com>
Subject: Re: [PATCH v2] uaccess: decouple INLINE_COPY_FROM_USER and CONFIG_RUST
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 5:48=E2=80=AFPM Yury Norov (NVIDIA)
<yury.norov@gmail.com> wrote:
>
> - * rust code always uses the extern definition.

Hmm... my copy has "rust" capitalized -- manual edit?

> +unsigned long rust_helper__copy_from_user(void *to, const void __user *f=
rom, unsigned long n)

Looks fine -- the signatures could ideally be formatted like the ones
above ideally (`clang-format` can do it for you), but no big deal.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

