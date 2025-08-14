Return-Path: <linux-kernel+bounces-769396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E9B26DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4533F1C283F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946C30E0C6;
	Thu, 14 Aug 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPnRqPJo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D96264614;
	Thu, 14 Aug 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193366; cv=none; b=UiD60dwwvhXBWaMgBlIxAQuqzeD5BbvcifWXHzMVf/k9D6bqShhfzwkCCAX19d0EkHrpgJ9BUuEd+g7ay/JTKryLoMdB+/fhY12OjU3KtxkdutsLqyfCzLVVuq8lct0cfXPcqfmmb81fxB72hJ8gB/D9mN8Y8IT8HDMB8BdSMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193366; c=relaxed/simple;
	bh=yR2zwBCG982hTiJjUi6O+KQnO4OZIKVyy61m0AAI0cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQ7xARi4t8boZa7tABMEiAAEba74ygBa6jLXs4nz4MVFAdz8e7fEw1VS3IDTKe3VrAIY8VDOdSoqQ4nTNw7Z+RgAdRfKZbOcz2W1IxV7S/EsKcgXPWqW/e7JdDI6mohc/jkjj/FwB2PEvaVhKbGy17TYSelIbFVDkA7xd2iRSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPnRqPJo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244581cd020so1727515ad.2;
        Thu, 14 Aug 2025 10:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755193364; x=1755798164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR2zwBCG982hTiJjUi6O+KQnO4OZIKVyy61m0AAI0cs=;
        b=JPnRqPJoRg/Hsp+QMzvqjerSb4Jk+07IxM2B04V8cm1XH/msTf0v36lKnMK4MjIVjI
         qnF9Lk6sFprsJX3V0L7qvW5OjQLapUti81Evy8vHlEuW62p2MPQGana6RER155GfkeMP
         hUSrm9MdcsRp7AoJl+8DEUsV+lbP6lNwVoPmHwEh9x4NwnriB9+wfDasImPwugopIb8I
         N4RUnSQZWN6UeK6CSuZEeiOdK2jXHzzvqgz3rdw+FmAuYq7fM4YufSN4oLg3r4tpI72L
         Bi5ACgAIO5qTBOajSXV+XNumrEhTCZ8VB8Rl9zT7XnsjKt0kwLINOgwZ8o49zQNnh83a
         jF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755193364; x=1755798164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR2zwBCG982hTiJjUi6O+KQnO4OZIKVyy61m0AAI0cs=;
        b=A00/3413bFQW/IaXihv53IXLQXqfyQDGNoTn0jM8v05J0cckGg4xkMM9574Nq237Sm
         3Lg36iMWVN8Srgd/bMAX8NI3vBco6LiJ0R0XVJV8qzVew9z7jlltM1pD40Dm8q4z6wSG
         km9J0BuiFF+v94F71KOE6pqqfjyLzNNqMN9bR8AXOjbPrFkDms8Cu33wAMD+ILrx1ZnK
         OnWgCNGRgWEDo/nBP8ZUR7aAzWGQmfeB8d0f8GKvRs0sC8+lf0fV7j7rdOCMiRcpUu4x
         5FIfseiqN+vUOyqBaxNZv/agAzUInYZm/wJ/p6oQjbn6y6f7rh7l2muMr7/PEuVMKhe7
         NdaA==
X-Forwarded-Encrypted: i=1; AJvYcCUi+nqup45GmNUcjzt2f1RFWJ1fiGCYERjn3v31F6RBJhQBrcXRoNGKFeImCFevlmj53waKsD2plSAEA2fIBs0=@vger.kernel.org, AJvYcCX8zmYr1l8wmmfht9HA/2Yde318NpFFOQRl/w6hyKIchf9VbQatTQFD6CXT63qKuc+v/wVQmiZ1pMrpGmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyn8RN1d5PHsKFYNUHCoTuFKT7FD7hO6hIP8ZcbDsnVaoGxOTI
	gCiju/YnYG6r8RYb6jaX7V8wMDfHyyWvegp/jMYMku4U+03bJJUCHzJdhTtwNBG9fOkg/W0y9qQ
	FFnTtJUo7zVjX/SH/3k2/vMTWWNfNSw4=
X-Gm-Gg: ASbGnctbbvgTIDatY2KbVIsG/9ILlfMgJJN8eu84Jim8KbAxG1ck33xGq03jTndVKZ3
	YCR0BZ76EzzS9at3S7yf3aRik793ENEkZRgRg5BT0nrkCE0r0Ho4iFhbcZI3FmJT3BkhHxP35eF
	BP+wL2Kk4ZgTHp5bBOVS/jjyCaOHGv333tsLTDrpitPzGQYwvCgBvZWNIFysVTzjKV38k2cSlSi
	yBk9YEO
X-Google-Smtp-Source: AGHT+IFVRWRKMNpPNMXe4pUN3qwj9nK+CZW0/Uv4J66/szRyOsOJHYXCKkVSkRf+pjgUBCpz7NIgvR/0Ou6u9Ge1P6w=
X-Received: by 2002:a17:902:f550:b0:240:4d65:508f with SMTP id
 d9443c01a7336-244586aa416mr31153045ad.6.1755193364393; Thu, 14 Aug 2025
 10:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814093046.2071971-1-lossin@kernel.org> <20250814093046.2071971-8-lossin@kernel.org>
 <CAHC9VhQXOezJ2=B1BQOqLgfuzDJEVS5G_r9+_bQ+OUNTpjZCKw@mail.gmail.com>
 <CANiq72=vhPsGjSx9u0FvDa6uzMFkFQFP9qG+DhtZ_U5TyV=bJQ@mail.gmail.com>
 <CANiq72k8kWHeBGLgHVE6vN36n6ashq-TVX3+h6WxLtc1jpUefQ@mail.gmail.com> <DC29H09I86EP.1WC5FDOG2NMN9@kernel.org>
In-Reply-To: <DC29H09I86EP.1WC5FDOG2NMN9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 Aug 2025 19:42:33 +0200
X-Gm-Features: Ac12FXyb_mA9ffVMQ-zR9enRFTHwkDr0YIPyhThHultJbKNw-p7hdR7H505ly8M
Message-ID: <CANiq72=FuzBB03nOEKvRnYn0y-NLkJ0R+TaSENNffh-zF_WtDw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] rust: security: replace `core::mem::zeroed` with `pin_init::zeroed`
To: Benno Lossin <lossin@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Jocelyn Falempe <jfalempe@redhat.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 5:38=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> There are no pin-init changes in this patchset (in v2 there were, but I
> took them for v6.16), so I think it should go via the rust tree.

Sounds good.

> We can of course wait with patches 3-11 until the next cycle and let
> maintainers pick them individually, but since they are so small, I think
> it's easier to just pick them all at once via the rust tree.

Yeah, either way is fine. I would say let's just land the ones we get
Acked-bys for, even if they are not all.

Cheers,
Miguel

