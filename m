Return-Path: <linux-kernel+bounces-826346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DB0B8E439
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 21:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A93BD138
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC12550AD;
	Sun, 21 Sep 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVrYsPlH"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DB19DF4F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758483225; cv=none; b=lX+g5G6W8n2BdDZj7ddSFwGqfjXwAS9S9GxppHdKI/1IpksJcmIdwBXbXt7E3AhbeaK/u0T/RE2w9ZM1Dxu9uIXGRlf/jy1tX6HnRtvcV/Rq0ozor+2UcgaguUTaely3IhyuPFvquEXnlY/uieWNFkqBKne9WdbUWW+LOol4cW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758483225; c=relaxed/simple;
	bh=2m+X/nfuv9HOhbheWVXsceeU1oB9iRe5Dx2bNoWj8Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEW5/XYhM7E9watQ4BwhWP3sLWLekhd5XCBHGoHrNEW+UxmuMGDYhYqrikqxUPkguZt78yN9wcPd7etCgCdKPvo6v0Gx9oKFoe4WkzqyGMsH2YEbabHw0S6M1ERzjpHyRVrVN24YOHbSazvyeZ5+DLakIgpgSLWmm/mQxSOl3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVrYsPlH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5235737aedso324414a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758483223; x=1759088023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m+X/nfuv9HOhbheWVXsceeU1oB9iRe5Dx2bNoWj8Nk=;
        b=iVrYsPlHUKHFnbAiVhbYhvmklGBuwzao+VxaBFs5HshgvkoEltUflAIWD2EBMGmHpP
         +Fue7Vw5Oh4WYx9r7/8OxZwZCgIcqvlaxj2LldgnNGWagm2Ot5h5h5PAPNoL7B3Kbw3w
         Q6jvLKDUM5Rsb0LBtrav+O93R2v+csm93AiF4NmqiHpsKjNIA0JUqBtDKHiJ1OjiOXaZ
         RjxUvxIY8fYb/6d48fdqIrL+GkGC/wVYZ4izq3DygmMIFV9aKaPD5zCucJTzQVhMR+bn
         gTS0CqBmqCRyjRKSt/MoyRz4JhFzSS98Q4D77jXT77qbl6eMyZuKhf7w7ROCkuKrO9oa
         Lyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758483223; x=1759088023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2m+X/nfuv9HOhbheWVXsceeU1oB9iRe5Dx2bNoWj8Nk=;
        b=qfOiJ9hepVsbkXGbqMo7pO5QOa9C5IuXB0asNhCEoX4CIxLNv9Od7bP5GJxCFkNG0w
         LvBoNgCI6SNXTBEgL8B7lqDQUmaKTbI9QNJ0pajuxUYS+/Ud2g0t7vhCrvKOQ6DOHoqh
         gRqUxBqEsJgZWw3JhNigIq047bTAzDjbrBKzAZN8wIUPTwJ9qnXspqNXAUxS88HoVgpk
         YgNiYytxy3SSmThO3oUdvV/l/LeTICypT7axzCjSi6N5HMrt4zuL3ld428f7LLRxe8Tr
         KqmSNxR2TEmwUNCZzVkCX5o105sP1TiJudBvQPAIoeomUzfeTZffTGN/J/Q7Ma83umA4
         NFvw==
X-Forwarded-Encrypted: i=1; AJvYcCXhSHXDltHP0kXeIKS64yN2/ReWfFqqdyCy8u3lXQHEIuDhFcD1LavCsaO6u+4nbfTBOkyt5n1s2RZzEKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9N39F+eHB28ccrM4HpPDEn94xqgXUapU3pxSq7xKtAp6No2Y
	WHCe1RRjEGDcdgjYA+9TlVnBiVxKqR+tpZeqCCD78xZ39t3Qv9w8qvYrneW/mXqia7E39vBpmsU
	K/DIx71mqWNwqXk7uKjhumIWumilt1GU=
X-Gm-Gg: ASbGncs+EXKC+SOpvt+ig4HgtsR1hkI4UDyprJ1lH9F+ELjnx1JuTGXB3T4GEkG779l
	bqWky02v6mQIUghQzDljBSl4H+c2KXWzBoGjchPloZf9cCpaHhUP37zW0EhlvdiOWBeBFLM0pYK
	XfJhcoFxWacUvMcSiaLpXHgw1sUuKS+AlhgR8WkmhC0mi59jKirXCio0MBlh9Jz/+D6wyNrFIa5
	L2i0HlBs6c1cMdpDHrkd1bfD1S2m2FCkkuxkS8PcUGmy/D8aPV4tP0igNNKLzASQok92VJDR9Bm
	0Re2DvYJ6YOlRMFk6+YQIoTPmA==
X-Google-Smtp-Source: AGHT+IG4kRzeiPGLm59ZZQszVAWsNaDqqCH2KI2Z0y+NJALvZL1xRg5SeR7LL082wuOV46ofwPf8NpR+imqiZxjX0Qk=
X-Received: by 2002:a17:902:f68e:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-269ba2611c1mr76464005ad.0.1758483223077; Sun, 21 Sep 2025
 12:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914-gcc-rust-v3-v3-1-34d4d5864144@gmail.com> <73d55231-d1e5-400d-9446-1914a78c0db8@iscas.ac.cn>
In-Reply-To: <73d55231-d1e5-400d-9446-1914a78c0db8@iscas.ac.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 21 Sep 2025 21:33:30 +0200
X-Gm-Features: AS18NWAcFs0MDi_Dw6rCzaLkE9gp-FV3yn7YymzJYRPsBMfxvetkj0p00jJxboU
Message-ID: <CANiq72n6_JdbgBiZHHiTg4vqnFHdfQhHcV2JpyQ0pz2J+KBSDw@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: re-enable gcc + rust builds
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Asuna Yang <spriteovo@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Han Gao <rabenda.cn@gmail.com>, Jason Montleon <jmontleo@redhat.com>, 
	Conor Dooley <conor@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:21=E2=80=AFAM Vivian Wang <wangruikang@iscas.ac.c=
n> wrote:
>
> Is this necessary? Maybe this can go in a separate patch, or even
> submitted separately entirely - it's unrelated to "RISC-V: re-enable gcc
> + rust builds" and would be weird to see in git blame.

Agreed, I mentioned the same in a previous version of the patch.

Cheers,
Miguel

