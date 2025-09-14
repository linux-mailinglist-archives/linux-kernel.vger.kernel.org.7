Return-Path: <linux-kernel+bounces-815922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E5B56CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E9A189A904
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5523C50C;
	Sun, 14 Sep 2025 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTStEvn1"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F820E6F3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891959; cv=none; b=kMHEOO4HY/3x7CRhsU6Uvx+B4ry7DMYQeWMwEFRUYl/OhC7JqludyGKRruiVIEw994I/1JR/t6RTMtpOlN7SC7wkQUXMQUK7MfE3SX4oLcArDS7eGudBEs+HoIfMXJXbYKNBYMpo6H7wghz2JwPmXiX4KNVkuJVoqOYdLMThO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891959; c=relaxed/simple;
	bh=omcPYzJjDcbZzUlVphuK5HmLBUOUCLdxi4R3x8sDZEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBsgnwhF0lR4aVigsA9Zw9Xr8JlLe9ZdUAcasu3tp9yIPHn/YvT9YKIGzke2xKRXTMscpRhqKSH67z5pRLwaQUWTqVsMTTD5Igikcan+DKReEPi5+PQfdpw/if8F+PIMffZ3mn5Xm6MLsXXs5ZgBTnxgEQqITOIvTZAtOeqOCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTStEvn1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-260f41a85f3so3314695ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757891957; x=1758496757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omcPYzJjDcbZzUlVphuK5HmLBUOUCLdxi4R3x8sDZEI=;
        b=FTStEvn1FvY29nK5V2tZWxTV98tV3CUETsb8vJdK0qifTlYbzRTpD6vM+rsodRF9n2
         keesJy5ci0qeN8jXmXFfF8LiAtgFG8fmiJiEBvikf+GFmct/w20uls1X4ltGCcOIUDpb
         OIs0cg97osAcQY2Cq106x6MBgAa0aKL02qhT7EBuES8Z5uZe5D6hBhbnCJ7w+9VRt6ae
         H7kP+zYFvfto4oCMdl97vO1XoFgKEPanDHBLKu2SqeQnkeRjyxHpI122bq++Pc4Ub1qr
         GD3YB+cJliJ/hBe0Rby5mup/DXDDHjlphdpnEDtlnk+1uPLhZ05//rPAjWvxRnzQxZ9K
         RyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757891957; x=1758496757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omcPYzJjDcbZzUlVphuK5HmLBUOUCLdxi4R3x8sDZEI=;
        b=VuymmkaCmJSZJ3AEtbSG+dFiyyhcVNZOhVSQuGHRgHC0hsVz8dbuBYBgeVMl5ZSiOv
         9Qr+6WRa6whMKaRaKbiudO5jNW5DanRHcoe0PdUTk7EsfSV0mLl2Qb+O9JUsJqn8grMo
         8Nbr+5ByWqH1nu/xng5HTOHc1IFtFxiSaBE33wXss2RkVQADl6IbUGoZUh4f57jnrkl5
         VldK9x82RibjXetFJSn3kgY2BcldgwGnNqU6kkFjuCbjjF7g5A8GRa8jE0CIJTJ+wMu4
         OzXnuvxTohVim6x3E7EaID3/9rl2eGyUZagPoSio2VLsjIwooZP4Ic5w0Pzc9Kl/vwXh
         WaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+jopj8Wnx/Ea9Uh5oXMpVrKzjIputxf5VUHPRbeTHeDClUnnm75IjPghSW6f/81/3PDkERIkAsomGbi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sdK6NK1aviLuNBsI6XLzUJppagC1DYDnSxnV/9x4YICFirg0
	SPhe2dVmKz5XLIqeLJHJP4cMB6u+b3awx08SRVI05SrBPMsapyLN2QjZfr/H3FvNKv0EssBkUcf
	nzVeARzOEUTFMKyfnUpyLP9f1i8+9nbo=
X-Gm-Gg: ASbGncs87u2a3PNwWSjJ/FcAKiFUEkt3jQ3glJrbspJSPGS0TNPtApp7nWC3yxKluqI
	53eQSoX2yMkwNFsjScDQ9+sgD7xlMkVzMWgO0KituqmHD3rUCvh5B4wR6lI+Q+wSGtaPMbqbAfC
	gvTt778pVYMSxBtGx7lxdDzNmrqBo/0aJmiIK7mDCpJ/W8MkBqcHid83g733av4j02NzJrPeSsG
	0LZibMGt8HgL3mSyEXr/frxjvZGQLOsodX5K6S3jVZQO4+wIGtSblRugfgin+lqHmzDK0Qfqyew
	ByV8a+ZB472NG/KjGRcPaCPz02s1XECwTuWg
X-Google-Smtp-Source: AGHT+IEqTWUrkgAg391naIf2SYlobFHRHjDHthJoC1Hi3VAJyaxY3GOaXFV76sfylnD3tU/KoicdHzIBmG4240mViMs=
X-Received: by 2002:a17:902:ea02:b0:266:a65:f531 with SMTP id
 d9443c01a7336-2660a6601afmr14295185ad.9.1757891957078; Sun, 14 Sep 2025
 16:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811012000.444173-1-ritvikfoss@gmail.com>
In-Reply-To: <20250811012000.444173-1-ritvikfoss@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Sep 2025 01:19:04 +0200
X-Gm-Features: AS18NWCMprE13pfkOk_iOgOEovBSGcWOl86_vfy935lEgAyXnMRFq7Jbua59akw
Message-ID: <CANiq72m-HcTSmLrzYsn6YEfHkaSy54=u+tgMwy_JSukjWaSOYA@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: cpu: mark `CpuId::current()` inline
To: Ritvik Gupta <ritvikfoss@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, skhan@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:19=E2=80=AFAM Ritvik Gupta <ritvikfoss@gmail.com>=
 wrote:
>
> When building the kernel using llvm-20.1.7-rust-1.89.0-x86_64,
> this symbol is generated:
>
> $ llvm-nm --demangle vmlinux | grep CpuId
> ffffffff84c77450 T <kernel::cpu::CpuId>::current
>
> However, this Rust symbol is a trivial wrapper around
> `raw_smp_processor_id` function. It doesn't make sense
> to go through a trivial wrapper for such functions,
> so mark it inline.
>
> After applying this patch, the above command will produce no output.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

