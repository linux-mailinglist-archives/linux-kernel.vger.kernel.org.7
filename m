Return-Path: <linux-kernel+bounces-792391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469EB3C343
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716843A616F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4DF242D6F;
	Fri, 29 Aug 2025 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGBXvp3x"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D415E5D4;
	Fri, 29 Aug 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496619; cv=none; b=ZOU0lSTSNaxOZMqQqmJcmpqOMYPxa4hJvd2WC7DYFVBajF9x9c1LfcMuc3pjGrz2E04okYQtifnlCFpFkQOqKit9A2B79G93OswcAt9HPBdETXWsDuhK09Z6RWI1vLFDNGA6LqEDsfL1ABhHV2sr0cROfmBUVMNqC863n72cUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496619; c=relaxed/simple;
	bh=4nRNZ/OwQos6PIKG2HVphry94ftYsfgFC/siNRlqeIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rFopohoC0g5eQzEBkG+N8XUBwFs6TXW4UtDKMDyK2mCzGTQZHlG3W450uFBnzBTjMZdJDCrfHZas/tl6fnacwfGtXSumD0db/QPg8cif0b9jom476LxpTZn2b9Mvob5aGQnDEsnn8T9njM2trc1bZQsCoG0F5amzgUU+N6HLC1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGBXvp3x; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24498e93b8fso3072905ad.3;
        Fri, 29 Aug 2025 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756496617; x=1757101417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nRNZ/OwQos6PIKG2HVphry94ftYsfgFC/siNRlqeIw=;
        b=HGBXvp3xX8enkoUSj5t4/Ox1eF3x4XSioHwDGt7kR0mPq/ywKOq/GFQv+9GvmSEwk4
         bdkrqH6H2CDch98R3vVNtHBmMeZtT74rNHGm1NGKdL9ZAR8Oy7gUUZm9Vq2y4eBWNBZF
         dcYPf3MT7KtJaeZXDStdXlwLmAOGbUNjXhWRdlT1jfZMYd2fSHHxug/8NBTbUaasdbei
         qacxgy+80b/Q1waIfrmYhK6es09vgW2Iqnd8kaEG0IzA5tMFHssmDAT8Ox8t0OqwsXHq
         Y/aT3dJMNO9C1VJyzDFiGtdjwEUynHuEsnH2HT8T/FwTZTF4B79dSP4SIQ0EmpNhZbls
         aD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496617; x=1757101417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nRNZ/OwQos6PIKG2HVphry94ftYsfgFC/siNRlqeIw=;
        b=eTHNpW7GUue2MZmU1K4FznNAL7zv7nL/GRpemPDegcBivPCLfrmfR11bFKgFj2XkIy
         1A+jQbQkHtL/jKzGORpEAmTOXBvOdcNlChjvBH8eIJ9JmykGp98QRv5GSGE6u3Qzk387
         EOZSbPZFw30rsHkRwDd5++wz9qx/VkVEgwGJ5uARFXixje3MvQNy/x/UfedG3F4mUtSa
         V19CC5pYVNaVzI5yPIcExVzMyBuY2jEH3Ai7pG1yVZ8UxJoKtQjNbt9Pdr7r0FZtyS9t
         DfcW1wKB25f+bSRkGyGJRlHsBMaruxHGyt1E1EDSrqQFt/oRafrqfQ7jYPlR2FmE9tbJ
         ry3w==
X-Forwarded-Encrypted: i=1; AJvYcCUYCbqkK6gW7C592j4lSx7+K1mrpaaGxB6zkUAe6nFgpANCXOffPnAS/qtxMkVAw71Ge9LGYSwgbes3i9k=@vger.kernel.org, AJvYcCW1t/VZqvv5QtaqpnczkwELn5Zd+QR1FxU76YNZRXzigN0+zrp4Gl6LxUeJdyaSNVNzMVvAFVOfQgqwqOMnfcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI22HT0eUkNa+Ybs2398781dc3T60pX+Y4HAvngBBMF6tpE5eT
	IfG/R238xmMlt/J4McyWssjj0bno6+7yXQNgrovbz0tD0FqPTpkrv+2tr592vJPJV3KyFN+zItW
	GNLIQCUr9hB2xEKCawSLOTuwHIs/Wcxc=
X-Gm-Gg: ASbGnctxdlQfMBYrLc4aU521hS8CFEkEQEiENmVXhHJy657yLmAiXkCPf4MVHlXY8sN
	1wIdNN1OLnz8W4KoVgGOmPbaVkO7t7cyJWdigF4kR6wjSCxEDT1UdFhauUa99tgPB7dej5R1rQd
	LJMU3PjlYR/OaqmRlFvlxOr2meXbr9lzv/k9+m1qEkEimyj7rCDkYmdMeEHfrjXzQ4lKhBiIhcJ
	ANXQCEatzeGeoGhTXYHGi2JSG990EJwW8LNI5EaQb2n871ugV25p7hN3XfGLIuzjBs97nkMlqe6
	jkheQcG0OlQKPIqrLe07N+0VBg==
X-Google-Smtp-Source: AGHT+IFWZb4xaY7v5s0ylSP5ELEMnxzQujAXKzF//SpCqMfVGSq+8gvW+Xpth3BkeD9kVV8HxQDYlRSXEcjPedhBXTw=
X-Received: by 2002:a17:903:1c7:b0:240:8717:e393 with SMTP id
 d9443c01a7336-2490f7591bdmr25798105ad.5.1756496617089; Fri, 29 Aug 2025
 12:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829192243.678079-1-ojeda@kernel.org> <20250829192243.678079-4-ojeda@kernel.org>
In-Reply-To: <20250829192243.678079-4-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 29 Aug 2025 21:43:24 +0200
X-Gm-Features: Ac12FXxdaqCu4yJ1IdyQ22odRNAFIeLXOSCLMds7lUVCV-3Ct83AvKEf6yXHQx4
Message-ID: <CANiq72k7_GbFwRxW5vikF_SpiNcNm7Ff0oe6jyYX_voDg92QFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: error: replace `WARN_ON_ONCE` comment with `debug_assert!`
To: Miguel Ojeda <ojeda@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:23=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Thus, instead, use a debug assertion -- this assumes hitting one of them
> is not going to be considered a CVE (which requires
> `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`).

Greg: RFC on this -- this is the usual conundrum around `WARN`. I
would like to have an assertion or `WARN`-like entity for developers
that doesn't imply CVEs when hit by user interactions. More generally,
to know that such a config option is OK as long as it is labeled
clearly a debug one like this one (we can document the CVE bit
explicitly if needed).

Thanks!

Cheers,
Miguel

