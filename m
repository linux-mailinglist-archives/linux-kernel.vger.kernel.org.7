Return-Path: <linux-kernel+bounces-859839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0423BEEB9E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CA3BD26C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8AF2E54CC;
	Sun, 19 Oct 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQsLGpmC"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A911F03D8
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760900486; cv=none; b=UUOw9Hn5SN4IgffStODPSWxyU0370CQysdDDVUIigfRHSaxbEZFE1OrtXADpjkZ/h+FwcpX/IRGPSNAxUAao0/Bj9hMvtrBc/E3OdBpdphypU5kSA4pk6TvHRE/jfqRe/KFEGaK1SOcwD/no7A+Mq1mU9nQR34R8ZMFyxVmA3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760900486; c=relaxed/simple;
	bh=N6oBlf88V+X4V5N7lbg0Z2/a2FgY0X2uO4yeWGr/fH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNWH0nFeQIUfY6s+QgSHGTTIvzehoszo+th+HZIh4SDZGViIKkrAG5OF2eH3hvlUmpNdqqCnYK/bsuEPJX39T/9a3VTGPhVq9C8WrTgfb2R0DDROWsk99ACsv4nm/NR/cEglDU/GZ9FSon5WjjI328H8EYVPTgGjIqWerc0WhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQsLGpmC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33d758c9d34so117888a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760900484; x=1761505284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EJ7gzHyhyTuLiaSvoYLggBrx/bbuMIAVpkTav441jk=;
        b=aQsLGpmCdv4WcIoXK630QD0WMYCRFVHE+CFTs9LfjIK7h0LnYloDSnUtqQCyHc3jg1
         2SrkhSVah/04BB9puD11J0YtkieVUdxQ4qLxF01IHCxTcKc2FMjmSvcm23Bvc9g8o5Pg
         gasxOq/lKhIRpCnvvzKmEgYZKvjY6FpSFGgl7g8guPlVcEKranZVxDd2nRLwWrntKBwm
         NC//4F50fV3VggQf2NYkH6LGGD1XuWSOfHhMEmv65zft0moGjMCBGXb/5dnAn+o7JKjS
         tTp2tFGzTJ1C+hJM/lDiuwHyN6kE1Q27kpOsR3PYb+v4TdDbokoNBuzVUrSbYgsLd73l
         lJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760900484; x=1761505284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EJ7gzHyhyTuLiaSvoYLggBrx/bbuMIAVpkTav441jk=;
        b=hQ06l5WYkuEsI2rPPKZFCHduzs46MMTMxhnbeP2Faye/Du7+yVrsjR4D7hbNRSHy9g
         449K3cpjKrJ1oP2Eqp6u4L1MA9kOm7nac1tR1mlUn7lh/IFOJ5w7yc3wxG73X3AzoYC5
         nndLYSI3/Pi/0SLn2n4+ROUWX9jSIhXVn2eSv2wl3Q0pE6LvOcJTRqJx0a4OE2zD2Uqn
         c6WFtCPjCI/QQO/uF6Hr/TYobayyYe6yZWye/vMOsVF9TKahKqPhQahuzWrPCdm/RBkQ
         i7v0EymFSXeiwqHx3AvKY2CuJ+jlNm57Xefs7prTUxWZsNC6xHhaSkNmBYeH91USvf7U
         jr0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUL8pudagfHzOxzP51zn+Bz/ygSNesDSbCm8SaTtagRuFxrDt5yBIeCd/FsuhkNDW298Q6IGOTBHwHGsbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvZ4cGxLYVwalOLFK2NITAbwudLfo61e8njKcz3yJYaOdUhfi
	zCstShT6vehf/em65TuLvIF/fCUQby0C56Uy8VgVnSwV1WsWBirizmgJF0zA8HSAjAcZhiqG4G4
	4XXbX9izYVJG+WCeliYubKnhK/Zvt+bI=
X-Gm-Gg: ASbGncvEWs+iI0p4AZ0MGvuA6UHck3SSguGxfeCGyQgma2uo7WhI/bkSABq0D6MA63n
	O2jyeHOw2nAFTws9t2OTnTWeZuy6tN7SXwhHKrEhuDuoxBfNTTQx9P3kVMLiHshkXsIk9iedL/H
	TdmbO1i2bj9wSTXU1IVS0MXd/PUpwONuu01OfI0GaesuPlsR+49Y0U++c3P433YavRTZNoFP49X
	XfWzyjQw9LBN514nUO3yNhk7mGAn9mgAerehF5wXOCAS1lXgG6t5Kg08yEAELTb4K3D7GWLMVya
	HC66TVbJ+gWUo8Sk43HfBHYhQGIvCI4ZYEo4lWHVynW+JpMm52Uc0+oe3/czp/3YapVF4gv9yvg
	E1Kc=
X-Google-Smtp-Source: AGHT+IH01Zp7Kv3YR610YIrHBC7qgKnb4bJrOZJOKSp2IPxLyP7uL/gDGXWoA6wL1HkkjvVFr8A00rAVeHz/QkcsVMc=
X-Received: by 2002:a17:902:f550:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290c9cfec04mr77331165ad.4.1760900484175; Sun, 19 Oct 2025
 12:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016232118.1419895-1-ojeda@kernel.org>
In-Reply-To: <20251016232118.1419895-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 21:01:12 +0200
X-Gm-Features: AS18NWDyESJna8eLVVdolUWQrhFdWWW4rqvJ2M-P6m9yEz3NGpLoYYFNiU5MU9E
Message-ID: <CANiq72nFr0rfNpGfXGMrRVnvGtk0RdeLowvF1MciJbhbTQwLxQ@mail.gmail.com>
Subject: Re: [PATCH] rust: bitmap: fix formatting
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:21=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> We do our best to keep the repository `rustfmt`-clean, thus run the tool
> to fix the formatting issue.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#style-formattin=
g
> Link: https://rust-for-linux.com/contributing#submit-checklist-addendum
> Fixes: 0f5878834d6c ("rust: bitmap: clean Rust 1.92.0 `unused_unsafe` war=
ning")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> This one will go on top of:
>
>     https://lore.kernel.org/rust-for-linux/20251010174351.948650-1-ojeda@=
kernel.org/

For completeness: I applied this one together with the others and they
got merged by Linus. The tree is now again `rustfmt`-clean.

Thanks!

Cheers,
Miguel

