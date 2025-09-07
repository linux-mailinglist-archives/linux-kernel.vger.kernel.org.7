Return-Path: <linux-kernel+bounces-804790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F87B47D00
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162427ACD5E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEC029B766;
	Sun,  7 Sep 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz/Roojm"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153302222A9;
	Sun,  7 Sep 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757272980; cv=none; b=ZttBEdvMQcPJHO9xVMbuoGD8DZnTJ9C2tMyzcE3iaoIpJwrIgVBFdgsHr56uzi45YtaAyidtLW3kk0QbZ3yjQFtIdTT5XdtDlaLNE0nkv1/CgeTS1wN3BTXBWnT+5UjpYK3uFwUfB2anJ9CXtQqphCpb9yRibvBLZzIR0lzFPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757272980; c=relaxed/simple;
	bh=O9qppLhJrFdjnO0BDVGG4qFudKZIpEcz9G6sqj99YGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxBen5kMinapE/jpvaGaOhIXZ1HSOukQAM9E8nuKyeL9IJCuIyvyBbGWs9shZWE5ZXeWdfbnLxv82aESCf0ltQG+uif19XkZMXADx99MjDgwMfUAVrJaC70JT/WJbNFm53t6/x/TK+Bz1Bkkz9aTGolIc6vzpavgnHIo0lE5d2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bz/Roojm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24cda620e37so8367495ad.3;
        Sun, 07 Sep 2025 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757272978; x=1757877778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9qppLhJrFdjnO0BDVGG4qFudKZIpEcz9G6sqj99YGA=;
        b=bz/RoojmLQKcmwalJYcpH3VQVuVdZzDL6L03yOEQVJQwxt3zTCT4Qwj2Qw+vbezl14
         OfC82Y0JxVVwPw7FuoGABz+Rz7NVSewVWiMLZTsajMtAQH/NDt94e8K0NLO2lZCLgWUb
         d/yChmHxff2nfM2BjEbMeqCmp/wAs+rTcdPPnZj8JLYdzkWj6rqoGZsJj3K0rFyjYlBI
         2n6+TkOEy+2xKYyjpsKYtReVVMNons6Tf1KMthwc/wXQcSLtNkd1ZMSnj3mErWecMbXY
         Wd6BZBgCNwjPw/34cnkmQosbo+B0w5WVZlKAmgOCCVJDWOrn6shsQflLneQrSv3aY0qW
         vscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757272978; x=1757877778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9qppLhJrFdjnO0BDVGG4qFudKZIpEcz9G6sqj99YGA=;
        b=LM1e8TzdQhcvYVZGN/4lhkpH87/eWewgvH1/kkK3rmv5Em47ZTlxo/LNQnuQfQ+fIV
         ZjDbbvZJGYNJefl1PUdNQ/sFByPJsjzDwOT3Qe6873sNRA/buXfR8XgmNiAZ3l8daq+5
         MdV1NVAbLdgXKvdVG08bwKwIZQJATfEG++p+HopIIxt6m7vh85BLm2RsIeJ2rdXmnFzn
         C5qAMGnKCDcRw+9mM6m297JfrvOem4BcNwaPjshjgMSSFvp6c3mmYp5YkgOHhx8qyTKJ
         0TIZa5uV3dQwSmG1cEuntVTQj3aZEjU8gSp0+qOs57ZWOYY8F2p2vaT4tnm9KUKpovsl
         fGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS5P0+18lruK9eNFLQWnNXgejMLpL1idCAbvyb8p1X9J36QS3OIZ+U1vSFN54y8PvoDchKK2vN5psjLUI=@vger.kernel.org, AJvYcCVUbaENVVDPAdBBeXqK9UmCmkkNSefv3U/x/9KOgERm4xNPIppvb+HZ0f8moAu+Jl08cphSXZBKq45sUT6OXbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5i18Qv+94627CwNtuZM4gfOdB1tWQY/e9qdjTpYKTIXRPGFns
	kAbTbwZJ0N1PCEZNezTPlDHcFmnGRdAsFjCT15IuLMi/aBa9AyhonZKmq09qCVipdoQUhwL7F7E
	fFJ3eSwQio4GbT7adui+BTcVXhkCOR58=
X-Gm-Gg: ASbGncsqBPqtJrJls38O19HGrK86O+d3MWDc6IHMLoGC0FzZUxGI7Ip/MfyFnz4rKwn
	C6JjAy3OxJhfd4zmHLFn2i7ElG6/buARwVwORo32Dh1XrFQ1S5HyRDBLnfb7akGGGPP5jw9A54D
	mfY55zCYwwb7OfS/ATFF925/SqbbeChLfg9+XMjdYPqkizzQYiyAvpqwihIV3IfFo7M4W617RHe
	zjogmBtK2Jr6s6kj8+VeF1JhlCOMuIgOYVUFjbtVWOpzeGYA/A4FwgB+vv3qBhNTxqncpr/EZ5l
	7PwqkL9pU4IQxGCxaxOn+0AKe5/B2XwkKt08
X-Google-Smtp-Source: AGHT+IG9yX7YTrisqI7Rxo8QTbikLjcKwRoWujERfLUMkae2pI2D0+hLhPSBxYgvPobhme1gsnfwfLZW89Q7xm2tV34=
X-Received: by 2002:a17:902:c949:b0:24b:2310:9824 with SMTP id
 d9443c01a7336-25175f6eb11mr46298535ad.9.1757272978324; Sun, 07 Sep 2025
 12:22:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811012000.444173-1-ritvikfoss@gmail.com>
In-Reply-To: <20250811012000.444173-1-ritvikfoss@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Sep 2025 21:22:45 +0200
X-Gm-Features: AS18NWAo30zVGsfP74LBLri6JUJ0z8lNv4k0MaRzoeIUSkg5OaYFBZAtzPELSSY
Message-ID: <CANiq72=7dQ1msy6Xqy+yfAFuzkz8XGnnTsFLb6t5CUFzsoSCfg@mail.gmail.com>
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

If no one is planning to pick this one, I will -- thanks!

Cheers,
Miguel

