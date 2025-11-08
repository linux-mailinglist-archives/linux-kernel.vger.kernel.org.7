Return-Path: <linux-kernel+bounces-891273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F438C424D6
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 03:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C183BBE61
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 02:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF1283FCD;
	Sat,  8 Nov 2025 02:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZkXb17V"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EE74BE1
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762569073; cv=none; b=rsWLOpYfpKO1ZLUBjZsgQotZvXvfIChV9Ds+UrQk8EJpLGfw1SjDiOs1MFh3oxkJvf06HO4f/kpGY4B4zDUq3iZsKeVRNPRgtJJSn/5XLXRXlT4fkTpS+CLXJTaG0+/NF9+tT1R8MpFWnV88f2xRTaNX7/5zJi4OH8NLG2kgIEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762569073; c=relaxed/simple;
	bh=hEsds1aJcMa/MFnGEl+oWU8IGfV52JAmFi/ogcjALRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJCFrEpyIhnmc7ohSKK78nFRoKGjwiCoBgB8luXZ408/9NmcfN1AsCkPfOUQd03iEaZRIZyXb2jwYGERAXUAX63Rgb72ZzKDbxBu3wXk5VyEfd/8ovTqZ1TIAQhE4WoIV88nLgXOGkSlYDlZlDBosPBeQrfxRWnP7fd7/GCi9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZkXb17V; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343610f3990so153746a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 18:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762569071; x=1763173871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ywt5KnXkAWuPtF4O67B6+CrKeKvSZlIbIOBaVjdLrc=;
        b=TZkXb17VDXSi/hdNX1nnsUIBUikCDSDYabE2oBnc3ou2BnHl91qhrr8ryuMls+eW4+
         iBXg+fLjOHRcvN1gpg3FLTPwA+TPMNItQ5PAdWwL6eO/+P80WsaqPG5lW0A/6WkRSK6i
         G0uqVqIw0XwaQyN+EFtNoxWqKoEq2gH6qLe/3FqLdOVnIU2YOKl9HUQ4qvaE3EYaoNvg
         BJUKoX6qqzMmXobdQdas2gzy6c/RVHzxcq5XErBAC1g3FACKOP14RVuGsm23EvyndIyz
         d6LBl2nTzq/foUEHxJLTbB6OLk2HIPjAbMBL7I6bc9mns0h52vgFl8rCnvytZPYOcoji
         X3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762569071; x=1763173871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ywt5KnXkAWuPtF4O67B6+CrKeKvSZlIbIOBaVjdLrc=;
        b=ZpXHt+I1CKdIyjJ8N4TkztVFk27bpjMvGjwhoXKg5uhWipKNJmtRSzd6PArIxK4Etp
         yxTLaHsFzdJMJ7MrYpsQuK5O3Ue0R7IJ7DfMt+wRn9dACDngZpS7j4AxaiWdGNSZ5afx
         JEPZcB+yFp5osdZxFMMNeMz2D7RKDW66Iaq54trKgef39lpxl//9vmUUSw2Q+3Ocn5Xu
         njA1I74hyHPV5QqzHqHZpKIwL7a4GG7Cc5D3mtN3+8dj/nRn1/m7d3zU33il6JcNuMgq
         5bxjlbqJYa6nGHdHRQ2vFLw1Y6tMF99ddT5V0eiM0JH9G6V7QGyDXXBPf3/F/MECkGGR
         ncjA==
X-Forwarded-Encrypted: i=1; AJvYcCWjAm6trFRN1B38KlY52cjNJPCulbOGYWamZRArTuw1Spj1QzxD5fc6GuXhHuq1PuHXwXEw/XitCyrqF6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfM2N8iSFw8RomxHycmVymJmLGJKZtwpO37ugdn1Jpr3AHHk6Q
	pJv93B9zDmApNO11F5OcqsVDYb2hf68TBsVCTlyxDcTJPVnMXvuWShOY9BnvEuBAVmpyx6Qyr1D
	EFGhDja/rjZhvm50rA5jFBHsxAMQjEtw=
X-Gm-Gg: ASbGncvkG7e012Bl8qjnSh1DSuCuN2p3KnKL8EW7w05bsRxogGsNZ9QgsXx5D8dVcAQ
	kOHjnQ4ZttiOymbcdpPq7/AorEZz4fpetRXSv/vjxorxLzmpE5aBLQ/ydHC6lJ40GL9vGSrnrBJ
	fNPvJpKxtNidrZxemOV9L0Sir7zW+1wijvPWL3RPWH4Hcvync5jgl0P6r6I5smyN7nQlh7cVFHk
	mc8D5W3R07mL60/kcGbibWYnrTNhpCH9SWdaBSSwInsYjj2HEelLd7DuyRougoFh9FSB7WnU60V
	6sL/VB2q8fIWkJXyGxIJd24lIbsiEuQSHKciR863KX+kuv504M+C/YX7GJ7+/jG54zHsWnK4ePh
	qW18=
X-Google-Smtp-Source: AGHT+IEPt/zum4mIPzur6pOWm9ugmaOB4ZnZwdF37jH/QJbMUq5i1HmGSC61s/z25m7jSEylTziMZI9njr8XmEb4iEk=
X-Received: by 2002:a17:903:ace:b0:297:e67f:cd5 with SMTP id
 d9443c01a7336-297e67f0dc3mr6100935ad.7.1762569071389; Fri, 07 Nov 2025
 18:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108014246.689509-1-ojeda@kernel.org>
In-Reply-To: <20251108014246.689509-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 8 Nov 2025 03:30:57 +0100
X-Gm-Features: AWmQ_bntWx41R6dVeerjev8Ne9qVeKQ30TdFKSebUZNEnjznMYZ4D9bO5nuNd7o
Message-ID: <CANiq72nKC5r24VHAp9oUPR1HVPqT+=0ab9N0w6GqTF-kJOeiSw@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: skip gendwarfksyms in `bindings.o` for Rust
 >= 1.91.0
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 2:44=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> note that `CLIPPY=3D1` does not reproduce it

And obviously this means we have to special case this one too...

    $(obj)/bindings.o: private skip_gendwarfksyms :=3D $(if $(call
rustc-min-version,109100),$(if $(KBUILD_CLIPPY),,1))

There may be other cases that disable the optimization or similar,
plus we may have other small crates in the future that could also
suffer from this, so it may be best to simply force to generate the
DWARF with a dummy symbol from that crate for the time being as the
fix:

    #[expect(unused)]
    static DUMMY_SYMBOL_FOR_DWARF_DEBUGINFO_GENERATION_FOR_GENDWARFKSYMS:
() =3D ();

With `#[no_mangle]` may be more reliable and it also gives an actual
exported symbol.

And then later do something in the `cmd` command itself or teaching
`genkallksyms` to auto-skip in cases like this.

What do you think?

Cheers,
Miguel

