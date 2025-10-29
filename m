Return-Path: <linux-kernel+bounces-876914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F1C1CC29
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EC73A54D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CF235580A;
	Wed, 29 Oct 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAFJf5qQ"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD645225397
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761934; cv=none; b=qFHdboickwaoOcgP/+dcZVDNrbxoQzcI9SkI+aYYTSls8fiIP0QXCTlEISXPzDQTDbzGbp7MtynELkFzepOIsZ7IFCrzcLvq6otwoQTO58pOp22CbAdTwAuDdt8gxIWUCR7VuWSC57/wxv1GLgDWFOt7qqlIQIIdKhBdjAKtrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761934; c=relaxed/simple;
	bh=P60WA2IekOhXcaoabZ29P77AB+IQvR9LQbwR2bw+CmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIMfZInX807JLLqaja2AMZPHkU6fm+k0nYJNJxA5bq5fwh6hByEJLmfMp1nftU5P95eOGVSC23CosvMQzohVw4XZpnVJpXxTC0uUaMqvJwTSLSY7PONUm2JVFoYdTEuFVA1mpyNSD6buSp9efAEBuBp1f9CdVcxb2bnwSJTmv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAFJf5qQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b8b33cdf470so7813a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761761932; x=1762366732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGHEJFApFyOFo7pmpc4STS/EO5YU8lCBDcbtrWvNjWI=;
        b=kAFJf5qQ9N8bj9qZPJ0oD1LZuAiZP4KNXsrDyLaemTocyfNeFeiiwHTMBwC43xDzSP
         THvqcijF97GKepMiXmAVOaR4ReD8Rijxueb4wudo1Zkk5fNE5SWIv7jD2mXRsfaF4qA1
         5/JyfJK11UONsuHdQEraHR6bVl+tc7WcjYWW94euCBDQjV8Ooy1AauU9e0BlCUIz2S+Q
         UC4dNMP6/wfS5BdU0qyNWWPG4Xq53b5PoCOvXcGF584FNaIBCTL4hPiC8c7tbo/5vsMF
         chdBHQHpgzwOgIQd20E8O9humhBMCJSh1CANi8sqLtDWfEkPMu32nZqte7xzBuTPLctl
         JeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761761932; x=1762366732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qGHEJFApFyOFo7pmpc4STS/EO5YU8lCBDcbtrWvNjWI=;
        b=UYGpOTSQkxbsGO7v3qDpQcHKf51ipYOkyTJptHi1O52zmmfdxMmztHC+kn1MIRdMsr
         fr+oQdslZvioVndRNPTDdKu2tzI6cNQTITYR9gu2NlP0gpqrykOyBGC8lCK15G2c8tvs
         v/oaFRZFgJ91YUbx1YxFRx8Z+62TE4erJDP8CwNym77sgdSvyOioJmUt/3yZxJ66JIci
         2K2ih9+EwN2sKo9wuo0M/94oEwaDW42n2nHDWGRQRgj0qQ7wo+r41sUUkyksS57hSlla
         Te8fgCJz+U3NwqkWRXzoacIllYYV8rULUry9UyuqHjVTvRZ04K6EcvUxcV8WsPOoDLsj
         Zk3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2sUdz2yC5lCm5BGbFoORLakpNNlNvSTrTZveIwWRyDBeuxtGtOt9n6NPR0BK1OLGmGJvpv3cEZy4wN1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz90udbGrhT6bSV1koMBjGuXgpOxN0vmb58JSUPU7pILMkWWn95
	+n6epdy7uuG94fThHY/i3/ZcOjqKXC77f0TkZZY7fHa+tt0HoWdKiGGuClqjVsFACVrooE+qKQH
	eWFzI2fm7Z9VeZtMQsuDboSRACOu3iec=
X-Gm-Gg: ASbGncsd15LoVbYOx/3Q4v6DGqzyl572jk0tyFvoBPs3oOyog914QsACddqbO8rR9N9
	Emz+9UbyOOeZ0bWM/0Rfk09DuDrPdj0sbrgrMOf0icrq5ZDcvebRN+7+DsFb1hVXfgj9Uw/vuKO
	58iGGvWQc8Elrl87ADRREmgbBKlsprdNpdPTA8oD/K1G2QFQHPzz9jXZWLoQvNnmh2PHuEA6PsN
	UNab7vDAGEKkNlUINQwvxLSs4FpJl0YO4s8nDdKM2eifTqCTKZj7/I01C5aUw6AzQNPqFNk35qk
	806QBFVBT7b6CS76lr0lKDJdeZAqT6JqCglZ/E7myxSsVwCVy+I/bpVgXRQEVdBbExH8HWi0N5h
	bb4pBdiSKQseylg==
X-Google-Smtp-Source: AGHT+IEUmxwJv4cATlvHI24p6sTswb9GOB92tay5pdawn1K9j7QGYDSkyOSrQLmeFPpDeZNCF+IzUDuiQtDiWnxBse8=
X-Received: by 2002:a17:902:ea05:b0:290:af0d:9381 with SMTP id
 d9443c01a7336-294deec2ed0mr25872405ad.7.1761761931934; Wed, 29 Oct 2025
 11:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251028122315eucas1p159b65037cf6f3f710c1917e2464399b5@eucas1p1.samsung.com>
 <20251028-pwm_fixes-v1-0-25a532d31998@samsung.com> <2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
In-Reply-To: <2dedlnknikkrwg5f6ocuvjrogdjuqyg4sg6zkkao4w4yyvvsje@dkt7rco3fen3>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Oct 2025 19:18:39 +0100
X-Gm-Features: AWmQ_bloR4yaxCgQSRgH9rsP_79aHVebA5y_V5RdiMta-mOKTPlfL_2N2hFhhSs
Message-ID: <CANiq72n8QvygNsdHjaMgYrXiErT82BkWm1XMkc3eUZB1Xy_uAQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Introduce import_ns support for Rust
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 11:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
>
> If you could mention the command that makes this warning visible, I'd be
> glad to add that to my repertoire of build checks.

Yeah, please do!

I do my best to keep even linux-next and stable kernels Clippy clean
as much as possible, so it would be nice to have that Clippy fix added
to -next soon.

I have other steps that maintainers/contributors should run here:

    https://rust-for-linux.com/contributing#submit-checklist-addendum

Essentially / most importantly: `rustfmt`, `rustdoc` and `CLIPPY=3D1`.

I am sending a couple fixes for those.

Thanks!

Cheers,
Miguel

