Return-Path: <linux-kernel+bounces-859847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7855BEEBE4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D1189902A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72572EC0A1;
	Sun, 19 Oct 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPmmZYxS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68EA21ABD7
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760902974; cv=none; b=jWVlvaAUD1Z2nTNFxNGBCPUs87f4/6eGTXePZOBXsfQJpyYiniqvi9X6Cqcb5HMXXOhlJTiRSdvCzcriGTOF9mubdj+Nwr7vauSnkMOyc30vJ90FY3h01BB6741AyCGpd9nlQHiRmGN85Y5GYis963yzC2SPOoYWlIz0Fnvr+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760902974; c=relaxed/simple;
	bh=JNX8fAvoW1lb8BmNOFmuJuXah+Wz1jHvbOkzj/xKGqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRtPC1AUhsFxGMlX+qZ2qLXPkUk7NkYzm8qTKNknDzMX3Nk2eGLKSCBmFWQtZBzxrCk747rqcA4TNHl4fENjS0/+oAmT8CSXxdDnm1GJp1iRwvAztmcaVTN0StQRYa9soT+kWZpJE3lW8HFdu/B8Lqhh5KOA42ZjMuQPN8Hl7yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPmmZYxS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-280fc0e9f50so6850895ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760902971; x=1761507771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqNBOqOH483MS8SL737JXQnsKORCT0z1++jLxbruyag=;
        b=XPmmZYxSxYsxthaE2IXgPTMa7htjsLmr1fCPlr325yXrtH929kIkCzWQnhigru4vET
         YZGVBCe33MWZvpER5+CdlN4jU9BWVGA5n3tIAJMC9WFxBtldy12UfYasHdSkHlBW/QA9
         cfVWdXSoMF9/OLURzzCWUmv1WshQA9zViWkV+i5vAl/UdIBqdhd5NO5Ns2MGzL2A+y9n
         3l0tGGwUQslGVUnROuGMFmdAletSqgIus6r7e/4dR+ZSyJOjAk6yHpaPtjp55HisgNgJ
         j9hAqu8r3iFUaTgWXp7p42AaRqNOPwyRuFfTe+biiI70Lc/HiY1iTgBuPOS4vsUHXXfu
         qjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760902971; x=1761507771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqNBOqOH483MS8SL737JXQnsKORCT0z1++jLxbruyag=;
        b=CURoO3AVyOxHRIyz1AQIhkVOJuTHQGcbF/Ayh7yFPO0tjTxpnpInIpejReBCXxs08k
         oUvlJB2grYODDQ05N+gZa1P5pO87TDVKx6Lnk6BwZH33DxiCLIbgSc45c4NZGPs1mmJs
         wc7y+bLsvfLQZKY0CGMHurRUZ3Z2WPtoz5NYMndh6AiFRVqut/wxERPxq6RO7uMSkZSb
         oLdSkNKmpExxiphRZXjKhd645XKJipF4n1/Zoq6KA3DM4edy5fe+pBv2WvcZSCjh+Hla
         GqJdBNQ/R9fVV//rJjI6a/cVX1E+QrVQzahh6OFEYx+5AeRP98lqq+eK0ycAEJOQprR8
         h74A==
X-Forwarded-Encrypted: i=1; AJvYcCW26BWcNUndosEJy7HsRQO+zA5rGVXkI1qqNfpQOrAICgJWva0ulTNzlWpGqLqH/MZIQrNo8Dnr7ObH9JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTchLBdFMBmKf5xHxj0+ncDAnh85Ch3aSDZaP6mp2CXoPp+8m1
	iTLaniOU6yODmkCXIvUBopEPPZ4xeZ9WRgxiv4t6G4iMnAPfX0qS6Wr9Uo1k7maErHnYQmNXhYU
	FvRFHFxwA32e+3b6AjQapLZrt42cjPEo=
X-Gm-Gg: ASbGncucbUFj/+cZ+EgD5lOYFWOXRzkJyqJXpO21mDA+RJt3iBm4ZQ3hCVL9jHoh38e
	+0YIyURM1myQweL9Q+2/esMYMvWnKAggfc7rPzeCnfu0MI4tXbq5bikvlz/cqOGXgrDC21GEw4o
	760r48cOA/77K6Fm5o1C4GwMSRAW+YhKhq03aaZZ97tHZlcTuR5Q6He9vN0h7l68QTUdPQummax
	S4NYuRrLGQzudBZ/79lKe/HhFZxURMy0ojpFOWmJZObKccEmkhBsQ28N8fBUr54XvA1ViDgvmDi
	jhuQxN62TNt9qcbCiikmvz03r83V+kfXlTjuwyTNdLbXu2PkMXOdrhFpU4BMk0t4pasM4zQVfZ5
	A25/4IV1TfpRrZA==
X-Google-Smtp-Source: AGHT+IEE791LDmD0uUicQaiHB1HajSqjSkV/deOR3kpO21CqJ5IhdKFr58FA/7AR/uuGkG6Uz6DIWA3taxKjoxNzmS0=
X-Received: by 2002:a17:903:3d0f:b0:274:944f:9d84 with SMTP id
 d9443c01a7336-290ccaccc47mr69902025ad.11.1760902970962; Sun, 19 Oct 2025
 12:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012213230.1139674-1-ojeda@kernel.org>
In-Reply-To: <20251012213230.1139674-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 21:42:38 +0200
X-Gm-Features: AS18NWB2z7Xk1h_mxd3wp5IozHJr98VqS3xSe5xmRLBQ1GuRbRwLAOkc00U5WGs
Message-ID: <CANiq72=a2WMxQ0kKXp0_J8tnrJWb7pibWxZ2novB4SMV7gxcRQ@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: clean Clippy `mem-replace-with-default` warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 11:32=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Starting with Rust 1.87.0, Clippy reports:
>
>       CLIPPY     drivers/android/binder/rust_binder_main.o
>     error: replacing a value of type `T` with `T::default()` is better ex=
pressed using `core::mem::take`
>        --> drivers/android/binder/node.rs:690:32
>         |
>     690 |             _unused_capacity =3D mem::replace(&mut inner.freeze=
_list, KVVec::new());
>         |                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^ help: consider using: `core::mem::take(&mut inner.freeze=
_list)`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#mem_replace_with_default
>         =3D note: `-D clippy::mem-replace-with-default` implied by `-D wa=
rnings`
>         =3D help: to override `-D warnings` add `#[allow(clippy::mem_repl=
ace_with_default)]`
>
> Thus clean it up as suggested.
>
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

For completeness: this is a duplicate (from myself!) of

    https://lore.kernel.org/all/20250924130510.752115-1-ojeda@kernel.org/

which Greg already applied as commit 7e69a24b6b35 ("rust_binder: clean
`clippy::mem_replace_with_default` warning"), in -next for a few days.

It would be nice to get it to Linus soon, so that Clippy builds are clean.

Thanks!

Cheers,
Miguel

