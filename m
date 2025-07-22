Return-Path: <linux-kernel+bounces-740751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEBAB0D89E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282EA1893AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8BB2E4248;
	Tue, 22 Jul 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYVKOSx2"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51BD2E1753;
	Tue, 22 Jul 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185286; cv=none; b=VqMprPeE7swv2OmjVLQM1BFsY02sW5KYrPdPyZgt/ZpHsQt1gfrNPnIMtORmuFODNPBvg1laOKcmAwuwevuMwrMTX/UNIoj4hPjEb5oN5x7f5Jx5s+tXjf/2uCenwgBHTtJmD6WXlYSE83DH+9ola5YZbuIjmwxeIq4o29qFfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185286; c=relaxed/simple;
	bh=CWfPOoOCrHQ7QC5TtAqMkOPGuzFamJ/2ckdxhHpuGL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/EqFd1FfBBaGouOyO6tRhS/PWtNOXQ6KQJfjhDIIkxTQFoVwjFT8ARoqJqsOnvbONZlbdvzYfOr3+kiNCNswK7eS6p3ZIb396J27rx3fHIJtzXWrK/BBQP6ecoaIVh7lyP7F+R9cpVKgHgbPZLlda1Xgwm+W+j0E0KmanPis9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYVKOSx2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7481adb0b90so475703b3a.1;
        Tue, 22 Jul 2025 04:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753185284; x=1753790084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWfPOoOCrHQ7QC5TtAqMkOPGuzFamJ/2ckdxhHpuGL4=;
        b=UYVKOSx2Yyes2GqOBZZ+rsD9x9bgB8X86nc4bTq9hvjGrALf49eAtg4KacRExb8AYo
         ah6+JHpLGYbl+k+gs5zr0g6DLycbkUlDDfBbEfd0rtdc7IannTfKxh8lm6X/BjCOUrlJ
         8MYbC1ja/Rd+xRRNmPMnmLp9bgJdSDgx6b0rgHfKX5E4wRqVMcR5eVSp34vFeqLjKOPh
         o+T5HnHs7Cveh9MqQflSBfcvshabKIBQyr/ASpRPE6Kvm6WCwqvRDS0Q92YzNgCyxx0g
         xx9BSrewgsWM9DMYL/unNR/F9wfLc0WphBqdrAlDQjX5tkq99a/tDxIU6CULY8lTJ+UP
         PpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185284; x=1753790084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWfPOoOCrHQ7QC5TtAqMkOPGuzFamJ/2ckdxhHpuGL4=;
        b=RJGFllPgFQ5k5VXI6yG23vl6n0bySF04l1vvOvJCP274x2w72WO3wdQeq4CFXSSn0u
         t8asEI5pBWw/+CkeiI9Rgg77LBfAuUU4HhlYT1n0mbNymjhN8re+0Ky3R2ndYJfh3P3I
         /JpP2+XZz7D94IkYfuO1jxBJPkzgZOGDD7JRQYdwI4a1SE2PI3NWaicIDGiXeGujg3ZP
         HhQEcMufm6o4Gx5YwodQdhMqeoMuoBdp7S/6AdVgcQJj2AFTiD5NnrpesswCRQzK0BNS
         D3RX7ICZWqMhl4gGSVW+KLHzs2gmpUVEj7d3ET24Vw2JqfTMsTKipWw8FvcyGNrhpktl
         JlCA==
X-Forwarded-Encrypted: i=1; AJvYcCVhICGfhHIE/Z8x//K6sZBRWvXTCRiRrb4BH6wcbCkpWb77zWGb5+T8Dyq941UChave1MxnfTMoPdPHduw=@vger.kernel.org, AJvYcCXPu2RdOB6h+Lw+bQ+MvKgKjYQdOSfCPo8g2/1Jeh45dSGAInBszmM3d1VA/PDoYx4lYZ3i6gLCL0PtnybZ7QE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywil1amgWBNhykyxww5fPt205zQvmuY9GkluejwSwUqARi4cSSN
	yXt0QgRiAG3zFsTlVc0vURlKZ5D6lqUeVxI5YDM1fnQr3YINiDvw1VlHy7bnUL8XdrifSAAjFPq
	s99LyCPO2vzUhuxHDbTGbIehlxgA8fZdtQ0/4
X-Gm-Gg: ASbGncsFK5t+KH+CNHvKc0HbqU3DjAf0iA8e9ohmsXpGal6m0+h7u9g8tbx/u+PAkks
	VhxErJeTwtr+mIOeMYYg1nU/AjfAmv37pgQe+/YhEF4Ek6Wwfjl42rHEZRRcEdhlFUahWrDl/Rm
	50Zko0zjcUuZyJMovadmsHm03Tv76GV9ZPDpAMFzj8uleBkUKSo62Vnq4BajNAVcW1K71lSMidq
	L3SyGPR
X-Google-Smtp-Source: AGHT+IHq1VNpNoNk/M9O5QHUTrBVlG0YGfhmvgjiJdoOFd5iW3fmmVrb68ncf/6Xqiql4B677IRdggYmSXJ1rfIajnQ=
X-Received: by 2002:a17:90b:4a85:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-31c9e7a47d2mr13302208a91.7.1753185283697; Tue, 22 Jul 2025
 04:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520231714.323931-1-lossin@kernel.org>
In-Reply-To: <20250520231714.323931-1-lossin@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 22 Jul 2025 13:54:31 +0200
X-Gm-Features: Ac12FXwVmcXeVmCZBLZ1AG0FP9rN3l3Uh4Z3aE9-OxTYNCjvYKPW0h8qWzJBA10
Message-ID: <CANiq72kgW7oo9XQK7Ea-oaiLVHGH3stdkCtX2c_0vLw1BvD4rQ@mail.gmail.com>
Subject: Re: [PATCH] rust: sync: fix safety comment for `static_lock_class`
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Mitchell Levy <levymitchell0@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 1:17=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> The safety comment mentions lockdep -- which from a Rust perspective
> isn't important -- and doesn't mention the real reason for why it's
> sound to create `LockClassKey` as uninitialized memory.
>
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

