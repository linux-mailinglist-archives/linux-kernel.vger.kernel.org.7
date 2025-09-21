Return-Path: <linux-kernel+bounces-826123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7988B8D976
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 563584E0ED4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B048258CE5;
	Sun, 21 Sep 2025 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uXr0itZS"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49814248891
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758451603; cv=none; b=VbcEhxQcKfuEKFqDAFDEHEQpA73gaVkRVrBjIZqg9ouwdfS3ZVdLbwXStG0kodGFyDcs9ZOO0dfCPED5yRpUcQeA173a3Z1gZyG0VfUwe8CARMa9SpKJXlvzBZf0U98hYX2A1PXvIbt6Lp8rZeyagP5kSphTpFOwZV6MWoPbQnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758451603; c=relaxed/simple;
	bh=ejJ3R06kUm72MB2imXL8f46b/ReyDQSXYyYGUPqSntI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mko9Ng1hJZSzNpEt1zMzaKSFJGiP0l9fk13GM4SHCuU2DghQRDPr8OOan+VNb/FSxbVT7GEZqi6aqGsgC9cgbRcRrMqw/rpuKRxMlbLzBvOTQ8eXGFGxknqSfmNriqqo1UR9laPJ0D6YJeAMryCENCyQlzLA28bkxuU4tM26i5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uXr0itZS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ef166e625aso1610253f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758451600; x=1759056400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fut8Mzrft7AcgsVh5x5LQBkL7Q9ZuGUoyrZTtc74kos=;
        b=uXr0itZS0ezyg4QsvvPh7UpRFexCxkRw1Ehq0InBgj3hHDx60GQNkGI7KwdLUPmmZn
         TgNpL1F1uVL5VqT1UdKTKQ1I5X5kNtXPE3jwGttIoCVPPzlKeDGeAW8zy0l3hvXIEzrZ
         wPCPV8Qbp27BKF0Gi35bojMEyqa1um+kbNO2tGfi+/ZAzJTNkzRaHz5F0LpPWl0NPv90
         CdVDUXbneQ4o8v9P5H6/Oiv0OG/e+39BrJkFjxFDkGG6eZwiRBWkhgzq8M+sBGmlHG+H
         AKdOW8QmDeQXiwCCnX1yy/mhv0NNFDLIy5CMEwOrUCYUJIjsS7xFFszpVo1oYDDtOYMT
         TF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758451600; x=1759056400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fut8Mzrft7AcgsVh5x5LQBkL7Q9ZuGUoyrZTtc74kos=;
        b=eZ+CxuE9a9ecg7Z0u37tvwX5J/rMicErMg9sC7rEGdNur4M4xI+N/yHRYUzoA7riQj
         8xz/pDF/PRxgEx34JvXQIOyP/MFlVPdV6JjKx6K6cXf2HJkHW6kjaCuKg/EgC1AAONNd
         FNfSMYxUKkdwSof5AsW6P+e327PaRQyhdohE6sab8VRzCH67tOFGex6WDmHpbKJZUqzi
         pdqf8c/ZMKWXizudNrMvwYTzs8xELJR8Nq4UGuSwO0CUMqhxdq/Z+xO9rYb+G8QfWCta
         STqeyF96l+N8bNVcvhTkH83+ASLUJI21ztjxmPTdVE2hnuyWvjeDX40NSHn4Prmj6t9h
         dMJg==
X-Gm-Message-State: AOJu0YwY9PyrupgGAC18wDjXIoDQ0bkKBOFCaVyz/UWHGWuJlc2Q3TNH
	zlVibXLko6q8Myb+9KlpknXRo7rAk/1xIhcsoR+59h6UDbOs76Lzn3c3/2JFJsJDT9m4qREHqiV
	oImCE1HOGi+yfsRPe7Tz9KazYszGpf7tSrlSIMZ4U9t0widV64MVR5C5T
X-Gm-Gg: ASbGncujBnNtm0LFGF2wAuy6qdWyg+M/cvPDFwnTDJ6E/BvRztfXzNcpM3HlKej2Nv2
	KqD2Rk11RCFj+KVomzTw7JWLTQaa/v1Z3NjCR0TWi6flBsfiyJI0IATgF+PG3hkIRNNAP/OFHvx
	ODEzcBuK9pIGVBWOqPgNAWh2lw6+lmcCodA7Ad7GSCT5OabdhJ0WxQ4wlo4PMj+o8gBEnhmzOgh
	uYEAAyv
X-Google-Smtp-Source: AGHT+IG+ilMcacJzrGfy67Gt5SnyIG3oRn1w901jpk/xQoevubQ1rvd7vOk9clCmbKV5svvHYfPvxAprCcCgIdzn9Uc=
X-Received: by 2002:a05:6000:1846:b0:3d4:a64:6754 with SMTP id
 ffacd0b85a97d-3ee888278f8mr7584321f8f.62.1758451599361; Sun, 21 Sep 2025
 03:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
In-Reply-To: <20250920161958.2079105-1-joelagnelf@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sun, 21 Sep 2025 12:46:26 +0200
X-Gm-Features: AS18NWAQxPNKNG6co6Lg1atbGPV5cDqDMJUHPiD_9mntO-WWhUhMuYW01BNVl8g
Message-ID: <CAH5fLggXGMHM1bhmaUb94gDu_LiUbMGugARpOZoUNSTU3phm=g@mail.gmail.com>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com, 
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 6:20=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> When printing just before calling io.write32(), modpost fails due to
> build_assert's missing rust_build_error symbol. The issue is that, the
> printk arguments are passed as reference in bindings code, thus Rust
> cannot trust its value and fails to optimize away the build_assert.
>
> The issue can be reproduced with the following simple snippet:
>   let offset =3D 0;
>   pr_err!("{}", offset);
>   io.write32(base, offset);
>
> Fix it by just using a closure to call printk. Rust captures the
> arguments into the closure's arguments thus breaking the dependency.
> This can be fixed by simply creating a variable alias for each variable
> however the closure is a simple and concise fix.
>
> Another approach with using const-generics for the io.write32 API was
> investigated, but it cannot work with code that dynamically calculates
> the write offset.
>
> Disassembly of users of pr_err!() with/without patch shows identical
> code generation, thus the fix has no difference in the final binary.
>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

The actual bug is that write32 uses build_error!. Trying to change the
printing macros is just a band-aid. Someone already mentioned that it
breaks the ? operator. I think this change is a bad idea. We should
fix the actual problem, rather than making random changes to other
parts of the kernel to work around build_error!'s inherent fragility.

Alice

