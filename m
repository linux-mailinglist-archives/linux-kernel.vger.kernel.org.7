Return-Path: <linux-kernel+bounces-806377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24878B495B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB9F164C79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B433128B6;
	Mon,  8 Sep 2025 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyy4cZKc"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D951D5CE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349430; cv=none; b=jULEfzLlg3qycqnpdI3Dau75GMONrRnp6WYALBEqwNeAyHsj0eL+02ZRCRYIviRd6oeQvRs2qoouusowPQc7Ke9Qd8jzYkoyzkZdNbApE+C2MnOr1wGThIIN06ow6aUADVqVRXQwMPPWDV1Rdz2bPHjJVRo6DFSqec+2Q1VWYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349430; c=relaxed/simple;
	bh=GD1rockcPLLPoutAyUyCLTlyfHITwp2bLmYUsEhn5Rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/7pRgWoXvu/i/9E2tVlG5x5Z0vZIEvkygmnarSmofdeLFM9FordQn++JH0FfbMmcnp5L82mxXgME97YAicxTOH63lbJ2+H5SHCnmkQB5XoTDlbMoaB7o2LpE9uUoIdRg32RrnArRAiaqnYg+DrE5QdkFwydsyckX6vbcpDe3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyy4cZKc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32ba1f9c87cso311221a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757349428; x=1757954228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD1rockcPLLPoutAyUyCLTlyfHITwp2bLmYUsEhn5Rw=;
        b=Yyy4cZKc8crY90mGnCGCNfXPuTsDlQb8/rXT99TkpyadAPH8+oVvqGpEKA7uM5XHsM
         jMdsMqM4D489/sDYmBiDyIHpASB1bnIMBxxztk3loEW+skb9JZBwMm+y0BFJlAi6WKrA
         66s6+Ywqw7lFWwY4VP/zn7TOXsUlru9m4i7MqcVpvL8i0mDDhmzJ8rs/JqdPi4GTObHl
         ExLD6BxY5cNeYNULUCDFLbuo5qRaVWyhMzUB15I9acKSF2cqJs3n1/cQiYDXLQN29u+U
         xwS/Ma+WoA7La5REQb8WiDJUbjuZzwePyYkNUiMyxCqrABYDbxCj/INlX72xz/ujdVAs
         UCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349428; x=1757954228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GD1rockcPLLPoutAyUyCLTlyfHITwp2bLmYUsEhn5Rw=;
        b=LhiTeNHpF71eUAsUBniYaSL9HRy3aVWl/XKDlRBYvGzdsd0wlzDF91A7Q3rZiI4ks9
         ExVr+0BP1chXW0vUlCs3WYLLQ2FEYYb7kfFMEfHZLFtOX1ojCZ3sp9qqKufTLqZeAEoe
         0WZtT4fO9B7rGNjrLw97AR4vADJGXDoFN8Vc8hquCvjrAkyOSFXl5F5RkgNSLB5Mmrql
         bcxE8d2EquEd1VJMbvg/cYkkc2t6NtBH+esURZ9eu8FmTx7H9nLaeT8E6wK/sVMNV5nB
         YiqtmIxDiW1T6+dZad7PePQ8u+IQcD1VE0sxgbQLZKWRT1mOCXzkuJxfHuaLGEbKA9kS
         vedQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLMgvozEO+LaGo2tVgGnlF+DeDI7/CLMWySfnGB85GKdFIZl/NQ/zxNa5WXFsUIm+49AlyEafJlhRV2w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuzt8YBS5LcgQpsdkeEA/hnjDv25Rfyj7jUylY7a1z0HSBH37t
	WMuteoBlpa6dgpRNGNEQdZNIuQQ5TLJWEVCiz93PyjG4Dlb7DFU+pjdzomY+RZXo95V0EyGPgIR
	vXDZUvAhHsI868TREStmFAZYEoJR6upE=
X-Gm-Gg: ASbGncta19HpoR8T8dNhYJ173oEigd2r6EasPeLAAGE/qV6eHyHx2CTghLlHY26adK/
	/7i0Gq4+AX14PZmV3ZbJBJDj3D/FKzb75duVx10etOSyemTHgHu1Rf0x3pXaHwzm9qxMgAv9xJp
	fwOSUP2qQEtJ7ycWwIpT4dqP7+pAX4mx1eSQJrggEBdmtgdB9acBlms3IUtrmJceEU5iex6IvHk
	yBq0nVrk8rnGqazFK+FJo8RMcQKqdCU47YuebmwV4ZU/enNuIeFQgE7atuO2elediUlzs8zlYhv
	0fVz/HHa0R15VYsE6u75UzBcGQ==
X-Google-Smtp-Source: AGHT+IG2myJ7vzeUyIz9b/rwozFXjQ9JQF/2Y9pLORdR5ksocCK1zUif0LUhypbVeitvwClaHWMsNtcB6ahJXXZ/3H4=
X-Received: by 2002:a17:90b:1c89:b0:329:df65:de88 with SMTP id
 98e67ed59e1d1-32d43f9765bmr6140000a91.7.1757349428321; Mon, 08 Sep 2025
 09:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908125339.3313777-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250908125339.3313777-1-vitaly.wool@konsulko.se>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 18:36:56 +0200
X-Gm-Features: AS18NWBiOfnr_oE4JYJeMuf8U4qWLrtNvA_XHCFt0ZnpsbVAE9UetqtcLRqpwkM
Message-ID: <CANiq72mekzqaNak+KYxqzxOeKpmNDYPO2bvATw6FkOjHWO1w0w@mail.gmail.com>
Subject: Re: [PATCH v3] rust: rbtree: add immutable cursor
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 2:54=E2=80=AFPM Vitaly Wool <vitaly.wool@konsulko.se=
> wrote:
>
> Sometimes we may need to iterate over, or find an element in a read
> only (or read mostly) red-black tree, and in that case we don't need a
> mutable reference to the tree, which we'll however have to take to be
> able to use the current (mutable) cursor implementation.
>
> This patch adds a simple immutable cursor implementation to RBTree,
> which enables us to use an immutable tree reference. The existing
> (fully featured) cursor implementation is renamed to CursorMut,
> while retaining its functionality.
>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>

Could you apply the `&raw` operator suggestion from v2 so that we
don't have to migrate those later?

Thanks!

(For some reason I am not Cc'd)

Cheers,
Miguel

