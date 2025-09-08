Return-Path: <linux-kernel+bounces-805914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6010B48F3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7107D169AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E731B30ACE7;
	Mon,  8 Sep 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4LvXJ0D"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F42E306B08
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337558; cv=none; b=D3OMSJ1JMpFeHOFH2bA8IpabTErzQlP7Bcc7Ffsq1kROcaXx0w3tIp9n6SnNVsWzTWE0nYImfJ5hbwFYLsSf0HGUDc424q0+aEkGVIVSfw5jCBtqenHMW0CFGVIvWzP7kAGCt1PP3FfrI4YLw9fSC/ouxOyo8hXEd86CXqioMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337558; c=relaxed/simple;
	bh=nWM82YYVgDfmnz3ZFulMlOndRktGXnF272wdon8Wdvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOjzq+V1Fk+h6vRThcyA2WGm6pFlJqTLP5ExBr4Mkeyig3QtpYa9fNqlU3YqSy7R5Hx0gbubK2uqfOE52HiOVfgMu+fqEQM3oz+9klpvLrkUdrwz62r86Ak8VRPb6J3fBdzEVtjWaeQeKcNXnrMXawoI6wgHo/MZOZ/aXRYBirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4LvXJ0D; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d19699240dso3240821f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757337555; x=1757942355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWM82YYVgDfmnz3ZFulMlOndRktGXnF272wdon8Wdvw=;
        b=a4LvXJ0Dn30n/WO4xD7J+kLySGxRnSCOXJzoEqx7BdOWmEq2Tbzqk1LtMfnp5H7ZBe
         mT0MSJPl3caqIDSafAC973IpPnS2ph/uP78qXBoNwsR36dkdyulLeSEEsj840wqJX3iP
         U+SoQYHg2m4W8lzRIg6pvEhMc1gzfHHsmdeDOm567nYNOoBcXBbnqFy7YnC78dXHlMnZ
         Cx8EZWFKDO2jsZkZ9ZNoLGd0zBDEHaTR2kiklJqsTHrsvyUGaEq0E/0vk3aF9WGcTuzJ
         +F7rXtUZvcWi4PWno0ZHnWxQek5pk6vhO2hnkIOKPGG4btBjr2+4g5TJqhjfRU3jQPdE
         fA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337555; x=1757942355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWM82YYVgDfmnz3ZFulMlOndRktGXnF272wdon8Wdvw=;
        b=mezvrIRhmLHdTHBuP+7ETOuAYOwTvSPQmWysTJ3ioMx/U105OumWF/rVy/x71jqTHZ
         MqrDZwwaxKjOXhsuowNYlr+dGWBWlNGJct5y6xKvr7eXQJko8HbWlsRapm7ZldKixrPt
         7ZBIfU+bJBG0xJoa6jWJlUDRAXwIgHjuKmmdS+V9nuQBi2CsOlUghf6e5spnZtXKG8OI
         1OArOAZWpY+N1vv2hwdZrPTRsoawtVOfmo6SWHqgxz7XZAL/zIHcHDjoqnXtJzvmdnrD
         MRMnPJxPBugIpK4HGlrOpR4z34d7LomWwhd3No4tJ5L+HT44sH8H4pH1ZcdwpEW0xk6t
         JkQQ==
X-Gm-Message-State: AOJu0Yz3I1wcS+Ozg8nXsAL9IOYgMzpbmDHUWI/1EgWW3hDw77o/Ct7C
	OtDni3pYGxqIeD4sqn2tPsOpDTqO1apBS4O7E0PrAiM3fgJcLkoz5DZW9+GfTAR6xieEMutoEK0
	gfSbJgP0vttNl4BU79wbU3HgxpimL8ZMu7Y48tdVyyAmIWfYUQyhO+uwB
X-Gm-Gg: ASbGncvBCUcFIsJt93qqQorksQPYcjmUpQnHFF7MgJvJPdVXnAO/i8mD2jwCwZ2dtEe
	h8S5XmiTrI5VMiLoz1OxgB3yU+bVDNzqGiJMWGnxN8LJUFokYpJS+ra1sTZQx6d+3tW+gmtYqYY
	/mbBqMVly+WTc1b95b9Zd8/9xMIBXNKUz1O/hLaUtriXIJ3m0VFXq6uB5XYh8xPwD7HVe7AF6QN
	f5Llb1k5CBVYDv9tVa9uIm9mQ/G724fQzGSqnD9U0EaAEMNpSJJrO2zoLzo9aInFO7zfhQiekTT
	qBt3a64Lt6A=
X-Google-Smtp-Source: AGHT+IFjSj9fcvGgclrt2uVXMQc5eZzeD36hnbx/1QwTeUfZ8T3zw8xE5Ei6zyAbQg85xb3R6cvvnoz9yGYt46etz/w=
X-Received: by 2002:a5d:5f47:0:b0:3cf:ef30:c819 with SMTP id
 ffacd0b85a97d-3e627b712cfmr5610348f8f.4.1757337554607; Mon, 08 Sep 2025
 06:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-distill-lint-1ae78bcf777c@spud>
In-Reply-To: <20250908-distill-lint-1ae78bcf777c@spud>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 8 Sep 2025 15:19:02 +0200
X-Gm-Features: AS18NWCUVBew4vUh8r_LLedLxLSYsoQ9pdJJZqEHSkY4P6yHIK6L_lJbY-hCLEI
Message-ID: <CAH5fLghqe8sxLD3vk6VLbA8UoMgEw1iNxgE8uETAeCnRz1D0DQ@mail.gmail.com>
Subject: Re: [PATCH v1] rust: cfi: only 64-bit arm and x86 support CFI_CLANG
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Kees Cook <kees@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Matthew Maurer <mmaurer@google.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:13=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The kernel uses the standard rustc targets for non-x86 targets, and out
> of those only 64-bit arm's target has kcfi support enabled. For x86, the
> custom 64-bit target enables kcfi.
>
> The HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC config option that allows
> CFI_CLANG to be used in combination with RUST does not check whether the
> rustc target supports kcfi. This breaks the build on riscv (and
> presumably 32-bit arm) when CFI_CLANG and RUST are enabled at the same
> time.
>
> Ordinarily, a rustc-option check would be used to detect target support
> but unfortunately rustc-option filters out the target for reasons given
> in commit 46e24a545cdb4 ("rust: kasan/kbuild: fix missing flags on first
> build"). As a result, if the host supports kcfi but the target does not,
> e.g. when building for riscv on x86_64, the build would remain broken.
>
> Instead, make HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC depend on the only
> two architectures where the target used supports it to fix the build.
>
> CC: stable@vger.kernel.org
> Fixes: ca627e636551e ("rust: cfi: add support for CFI_CLANG with Rust")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

