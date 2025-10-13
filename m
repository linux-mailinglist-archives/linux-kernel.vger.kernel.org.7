Return-Path: <linux-kernel+bounces-850209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5ADBD23EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9033C3F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3582FD1DA;
	Mon, 13 Oct 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSSTSHrY"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288192FD1CE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347176; cv=none; b=uHaX4jN1q4dItOEYK4RGJ0QN7wgLbbjph6xBqoJHaetq66gFIvcFEDrIt3jgDNiyisTG776mqmCu4trg9fQKKy0goM9wf9wZuDn7vNxb/Koi044SRwkqVRZpovsI1xNvaKa7rvv1Yk8tkE2w5jubDLXpgFBe2Jqmnlk+bGL+YKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347176; c=relaxed/simple;
	bh=7e11H1Sl1fNF6/Pen2WxGe/Xr1qM6aJthuzJAA0/Mog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JRfhQPdqXGpwrWJkYAUaVn91Hg5BPwLX0sDso85EgL99zB3oHZvED2T//G3Nchty4W//O8Yt92CMXwhpbTJopcdqS2VwJ2+V+tlkEgZaytnzSJbRss3xsbKdv7Sg3WqUTQDoiG4ft9fg6zWeokwP99Pi4JTeob8dciqt5UTGUWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSSTSHrY; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so26048085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760347173; x=1760951973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q8mp6Sl5lpIMsBMcZe0Dwu/oRU1yIEVK7dE0nvjB0QA=;
        b=YSSTSHrY3NH96/uSeY/MlaR/nwwhMmGarHJY3Ud8u6STJkkEN7tJ+Zk5EK3BHfeKQ6
         RPy8McdCnU4jLi4HI8XVD3mqY0aJtlUB0TDKRUbm9tp6kQQG3+poAYe83c6ZDwc6/KtL
         zlRRU9qrPof16XFru+DmWM2xp7cgm2sRyREbSsF+eDjeeiiildFkdleGT45Z4ME5A+qw
         QgIumFCdMXsznSL9cn+QzvZlTwrWG4/OdoKLcYG0uaUPFWR8D6QWf+PJxXaJabWJp6Z1
         yNUjs9Er60uo2acZDRVbL98qgzKw4uY8wgTmd8PVjA9DxzH2lH8+wTlG2NLBFr2GqneV
         GEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760347173; x=1760951973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8mp6Sl5lpIMsBMcZe0Dwu/oRU1yIEVK7dE0nvjB0QA=;
        b=iDUR8ok0DXnC5xlUGjCpxZNFFHazaCGVL8r7Vnwf16k/5sXzxToSX2qohaIZ8qvbHx
         ihRViA1cDcon1kjjNqFxPJUcxRSQXTt+UEPtoT/ByyIlFlcc2yb3+zBZqpBlm88buIVC
         cywmYYTYYxEapB3BHwoxwrneZYOll//Mk+6ENwQ5zQr7hebhwRSBEKaybczfppYRNxIM
         gxuur8jgVqKo6T7oOys+pSwy5uWP92NzOOqb/JAisEHUJpTgaGNV6MdVFl6Npy/wMGFp
         6SIdc1Yo13i/ZOF4JUHI0B1CYFGbAKEt2sdbw8G2f0GviCPzlIGAsdGg5OqzdTxgUcNw
         Yf6w==
X-Forwarded-Encrypted: i=1; AJvYcCVP8pioD9q3NVGT2lvlUK28dfek0/lRX2D1IhzriaKaopyvq3AjuyVeFn4jtbidpJOXuv+21+zoanI/M0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWUKQFEQWqXTGH1W576EnldQMPkwEatwj/bFqvwpoiYsiqSvH
	4CgNKxfi2B+kd5X9bgToZ40KhPPJyPW5Tvyj+XR+3QC54sRWLSJT5u1/jj9QVKgwf5RpioxemXv
	Y7CMiwJogUWiH5D8eSQ==
X-Google-Smtp-Source: AGHT+IGyE1/ItkqoGr313xqMor1adj+/d0l73A5B2xL0EAcjYPfGXqLNzPt25q8he9xrFaEgiN5RRjL9JA9wkiQ=
X-Received: from wmcn14.prod.google.com ([2002:a05:600c:c0ce:b0:46e:2897:9c17])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83ce:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-46fa9b16597mr144514005e9.37.1760347173573;
 Mon, 13 Oct 2025 02:19:33 -0700 (PDT)
Date: Mon, 13 Oct 2025 09:19:32 +0000
In-Reply-To: <20251012213230.1139674-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251012213230.1139674-1-ojeda@kernel.org>
Message-ID: <aOzEJAdNHatrW_Gz@google.com>
Subject: Re: [PATCH] rust_binder: clean Clippy `mem-replace-with-default` warning
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Sun, Oct 12, 2025 at 11:32:30PM +0200, Miguel Ojeda wrote:
> Starting with Rust 1.87.0, Clippy reports:
> 
>       CLIPPY     drivers/android/binder/rust_binder_main.o
>     error: replacing a value of type `T` with `T::default()` is better expressed using `core::mem::take`
>        --> drivers/android/binder/node.rs:690:32
>         |
>     690 |             _unused_capacity = mem::replace(&mut inner.freeze_list, KVVec::new());
>         |                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: consider using: `core::mem::take(&mut inner.freeze_list)`
>         |
>         = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#mem_replace_with_default
>         = note: `-D clippy::mem-replace-with-default` implied by `-D warnings`
>         = help: to override `-D warnings` add `#[allow(clippy::mem_replace_with_default)]`
> 
> Thus clean it up as suggested.
> 
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thanks. I guess I never got around to making use of commit 47d8101924b5
("rust: vec: impl Default for Vec with any allocator").

Reviewed-by: Alice Ryhl <aliceryhl@google.com>


