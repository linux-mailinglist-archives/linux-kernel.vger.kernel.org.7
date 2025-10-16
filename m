Return-Path: <linux-kernel+bounces-857057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB3BE5C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC4B14ED331
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B232E54A8;
	Thu, 16 Oct 2025 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzfF03Mn"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63AC2405E8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657117; cv=none; b=q5sCi9UltRd8Doz1WuuDVYYlbKYDbQmNOirlfTWr9zSBA043KTYcjHgMUdc/1Benoc18ZpFH4Dzr2/ed4GcT3FR0D4FkoYM1EzEhhvao6f8+vqU26g4OJjdg9Wogx90T0nnJTYqh51LXpu79UCh9xPgnuqXDoIjNROAvxosAxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657117; c=relaxed/simple;
	bh=NaoJwlqs6RJ9zPQIEFByuLYzAhJ363qQIKtmEJXBZ50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0xEGoMoq2VMTrEjzwv4M4pyMkhoxe7soC6XJJmN3pfkmlHw2TWZZOHWtretyBHH5HJL4PdziHqksfexDFOtHsTnn+AlY3TJ+MBlZvydOaq7gxIpTJtINHPjv/B0eVPuKf9dTGdhjNYA+sGEvk+S8hQODLXGM9WZtcEZvsCpqFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzfF03Mn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26816246a0aso1706815ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760657115; x=1761261915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaoJwlqs6RJ9zPQIEFByuLYzAhJ363qQIKtmEJXBZ50=;
        b=XzfF03MnTOAlE0eGr7Sii4GMoJ4aW+v1Apiq+nsfGBLDdPFQSBG+oYQh1aphi+GO6L
         smDGJGpvIxA6tOPf0B8K9nL6g8elll77FOmbkN1zfoJCRTk+9x+1ZI/0YH1mzDkAnGYg
         V7LWItwDP5JNVzxuWgKMEmRXeO4LYqzu8PHbj+lJ5qJfhbNZ76LngqUeMqTubUS7g8kI
         syJhBM2fjqV8ce7GAJMgmFCU5901ZRATUT0+cDbFXnyDkugSPebrKPJ4nrccKOoLfOaS
         uO8y4uANzx0fnN9nT6FKfGD+gz6zcduxLab3F+yOAfvVEKEm/b6cZMBd8Owu3fLjokli
         +nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657115; x=1761261915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NaoJwlqs6RJ9zPQIEFByuLYzAhJ363qQIKtmEJXBZ50=;
        b=AgWU1Ea6hTX9uuzH41hyZQMdP/1R11kbeFdFX6ZqtP6VKIl/labxpKOr72gw1SDjm1
         tmM2BjYv1wa74SEMRQk1qGYalhDS5K05sxVDyEzcNVrnkxOs6F5sHpj+aTHi9U52g2De
         HDiT0I9AF1IcJ9SLIQrb/2rL/Mmyu35dnAQEsPhff0uK5D7eZcZLcQXZC6YwAP+LY786
         PO5PWcmrRpbyY549/hlQ2uQQtXJ6BTMyxTeYjwzzxvjRYI9Hf43CV9hI/yxorZww9otW
         In6uyy+Dv1Gfr8iaibUsM53MmHKjuwkR7XY1lmE/X95XI+sz7avhU3x0dvIOoxni+Bjh
         tPYA==
X-Forwarded-Encrypted: i=1; AJvYcCVNR80P0oG258SB0q/ADC64lHb77L/iFN2B7lTTIv+6K3GWjxB8rvF90+ByNwpln+ZwnYXotYdFfwTdVTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGk6z6FHYlVzZY/zbeKMCQVWV6yJFt5YUd8mFfy8nXsA37qIPu
	mHzxHtcD6o/fAbIQLqENBUszSJIImxXO+IfUWP5rpNpIKX7Z/10wPrrThu1XRaZhs9qlXOFvfUI
	gSbqwjuM02qfpHh00TmixUOQtkLzsxA4=
X-Gm-Gg: ASbGncupTpkzJ8mw3FW4EzD0lNH5lKScHBHdq+j0LGcBZ+k79Q8OiqkHgtIleCgEZOr
	ivjXqkvNuba3B6PsYH8oNm3q+5Ar2/1emPVxR5yJdYZQdBgEAAK9YTNX1Hr523yYLa7L46aJ8YQ
	HC2/rO8R0b47BzAoERo+lzIqGqQnX4KfwWhk57QETnYaAjKOkvyoNuHRq8iyK7F3s1UPhs796A/
	Pba0N3aE3tRW9dZ6d5/W2aHo/pNw9+3cuSwkh3TRvcesoyOJzVd1P+nfBQ/kRrtvHvTYJn2G/ob
	AchTN8VNBhjN66P/kfy+Gd/6CCXyr6pNenp3cjKLinOd5Y+6IotSrBpsgE62SeG5N+YIRNZqPVa
	8yV0=
X-Google-Smtp-Source: AGHT+IHKez+rkRZENZvy/hZJ8rzFedxcLXv76zCn8uMa8clcMKyVyIuSWC0YxEtCrU1ccFU8WzBv306p2NdIMP1l0SM=
X-Received: by 2002:a17:903:8cd:b0:26c:3c15:f780 with SMTP id
 d9443c01a7336-290cb7568c3mr9104045ad.8.1760657115196; Thu, 16 Oct 2025
 16:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174351.948650-1-ojeda@kernel.org>
In-Reply-To: <20251010174351.948650-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 17 Oct 2025 01:25:02 +0200
X-Gm-Features: AS18NWAKsC4mVl1hI4d0Walzq8300iiHYVsaJlXnwFoTiPZWBDqN1Yy7f1pfzfY
Message-ID: <CANiq72kjoOWNFw8xuRHk9QzhfYHDjymKV_TTt099UH_f5Kv2qg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Clean `rustfmt` formatting and define imports style
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 7:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Hi Linus,
>
> Please see these commits, especially the documentation one. It is a
> follow-up of the discussion on `rustfmt`.
>
> If you are OK with it, please pick them up for -rc1 -- this should make
> CIs green and let people work easily after -rc1, which would help even
> if we decide to do something differently later on.
>
> I can send a quick PR if you prefer.
>
> Thanks!

Since I didn't hear anything, I will send you the PR after tomorrow's
linux-next.

Applied to `rust-fixes` (plus one I just sent to the list) -- thanks everyo=
ne!

Cheers,
Miguel

