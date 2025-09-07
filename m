Return-Path: <linux-kernel+bounces-804866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B38B4810E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB471885CA2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F222541B;
	Sun,  7 Sep 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATzfk1d/"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DD1FF7C8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757284271; cv=none; b=fSueyS0tGr2dHGx4k4C+wdwsIYUh7aeSYYPp47oaGGGt7qPFOSHZyeDYoOpGfWbKS3ddvSC6hXAoa64V3GKxHsc4ga6Cl/2uCpmNuvZD6Dlzvn0Avr7IiKD5TuDY+CtEOqG7EaxEp8q4gZZ9mStf418V/7+2foOn20gvRgNf/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757284271; c=relaxed/simple;
	bh=CSFBlBtDLQ60LZNRpaUXVbkiMpIx+cA4r6gRvNosVrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKjAe2cVawHX2DoXYdYCN6QdycfvO4+9qdHVeUF9y+naC4mAlouy7jVQCN8TC7Pjr4Xl5jYNOWI2CPD+5qkMV9JkHfuUXOPRaqnllwcBKGr8pUnEiz12QdqTih9Dhn18l6GHTw5qzJPSZ1UfFCMjJnaUX8bjQXf2BspuE7stsog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATzfk1d/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24b150fb800so10454975ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757284270; x=1757889070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9bPu15Z4/dThW5eomvhcfyNbJrTtij67l4baLOyMhc=;
        b=ATzfk1d//Juk/VG5BxRmzz25+ABMjpU1lCUl+iWoh50ZUqPvUd7JB05UQ0/hTP0T9U
         SOa28a7RWGfLdU41jzkwXeDHH4ssXBT+W8DV6RMAyXDO2UA3z7uZ07nnqn2sr5PME7rs
         x+jvvsYPDHyc/mEj/40i/FKogEdUbdrk44Xl6Dd5NUIE2zEn8dZH4OzlVk40eDjl9tUs
         3VIIwj8v3n8HsD9RNxgDjuMwsw9SfPmle3Qd7Ssn8WX4GuaIHJOnUbapcQkjfQUpPMfb
         WJQyzMeyq3Fpf1JpFNtOuip27vo63xipjcgUxRphs3LMXoFKQiCLALyC8D5yHDiB2kax
         JZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757284270; x=1757889070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9bPu15Z4/dThW5eomvhcfyNbJrTtij67l4baLOyMhc=;
        b=FClN2myWNU8VtOEI5wPPHx6LkTKO5fDOV7Ptz+TfQEfsfjiS1BDmgCbBvOxlzqV5rJ
         0JdHjm5yIvUBqrGDWJT3WXxM5qwVhjQFEdY+8d0qVQTLGA5n40Q6UdfbxRl/21W4MvmQ
         Wob5PD3os5GjBzVDLLJrd3xxcdx/DbpkHonmJPh4VhkVP/wmMqgRpaVSPsiv1nlBLSuv
         kJoyMJP9DtEk0j+Z399M0OHo+xLV3vFLcbOBxxnIsPNn5F4PVZx3LWR3nsOFus3WHE0X
         uhJPeL2aqLKw4gTUT80eWE6+die808gr3Q3W3MexdL+psuHjBMCR+6K9RxWNCo7tMoki
         xtqw==
X-Forwarded-Encrypted: i=1; AJvYcCUWTT0TeBw7uYGzvQyLsh0DM/lLLgROTT1j9WkCwhqw62uG84d3fAsLgXZp7DaLbFpz8GxdFn1uFA2Krb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDpSx68Jy/vVOBV3U5z6VIdtynGriHTnEaTHsG81YPHeGCtfV
	ChkX5iTO3Jr081BI2R2fesODTBQx2whCl8z5fzVY4njFgRVp99jeg7AD6WBGWrd/hQDhyO9pG/4
	cPc4nVzyFn5tJsc34O2HTKvFbau37ZU0=
X-Gm-Gg: ASbGncsJG23GkHo3cWNcD9+AhG5xF1FVPfPbjQ7xBWbKtRVMXejL+iiGM+WpQ9SCqnz
	MpWAsNZonhkuUzF5BXyox+L36lf0P1g6n3BawwQFwuSvzeLn6q/zr8Lj4ltY3uZLXAjJP/zjH3n
	f5c+8XqHRnZY1Ves50VOf1JAoCr88LuTWF8RXiP4SK1PLUPL7W7+Qk0qDQK+LhokZ076Uuagamg
	gpQWIxy1gjQAIgZ4e3OSV5tXDb8SDdSY1OhdbO5xIHEHXlm4ZkZ+4IvyRYWMi3SoQGoJv4mPw5L
	8YJ8yvcm2qs4SwAgm7rlYmtppYCNLbdsSwEpo3qkFyFEMSQ=
X-Google-Smtp-Source: AGHT+IEj4AVClx0YLlxE3BvIdWOpSMLw0zkdrNVU6iMlzQLJXUNXJO8RnxcSaBFanH1/GPk0Wy3TwbgoCxNXplP3A44=
X-Received: by 2002:a17:902:d4c4:b0:24c:cfcd:7356 with SMTP id
 d9443c01a7336-251663b6f4emr41816155ad.0.1757284269623; Sun, 07 Sep 2025
 15:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801161752.443431-1-ojeda@kernel.org>
In-Reply-To: <20250801161752.443431-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 00:30:57 +0200
X-Gm-Features: AS18NWA5OqPbW63AgbnzQJKJXtbFL3DAUQrImPSTwrtiRAD94szVxKKASywRaM8
Message-ID: <CANiq72myxAFJbKYaxsuf1PmRQetEct=3yqeJ2sqNkJROT1CQaw@mail.gmail.com>
Subject: Re: [PATCH] rust: prelude: re-export `core::mem::{align,size}_of{,_val}`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 6:18=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Rust 1.80.0 added:
>
>     align_of
>     align_of_val
>     size_of
>     size_of_val
>
> from `core::mem` to the prelude [1].
>
> For similar reasons, and to minimize potential confusion when code may
> work in later versions but not in our current minimum, add it to our
> prelude too.
>
> Link: https://github.com/rust-lang/rust/pull/123168 [1]
> Link: https://lore.kernel.org/rust-for-linux/CANiq72kOLYR2A95o0ji2mDmEqOK=
h9e9_60zZKmgF=3DvZmsW6DRg@mail.gmail.com/ [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

