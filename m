Return-Path: <linux-kernel+bounces-807847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C94BB4AA3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4469816FF3B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C30321F3E;
	Tue,  9 Sep 2025 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5peua5g"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28A320CC3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412998; cv=none; b=Lh7wzkM1LFKv4YymclC3SIvIVxMNoiza2V4JHAbugwPhZw3+yRAieKowfXHMBOwH9Uou3euwQSErerPXsbny8ufNiT58dN01I6IOL6d6b7J5fh4Vipo5xK6JcidK9QCAJ19t1j27vm6EhF2o9fHctYqfKeCvaky/46TsGkXxQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412998; c=relaxed/simple;
	bh=BA//Cphq5edMK4Qw1gaH2KdEhbSdge9EaLUpTsUxTOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcHuHFgAkaBvy/TtoOYyOheeI4RsNehFZYQRqDNuw10aRXBEIdS1DN9kKQCjXuiMxsoAKVz8H3REMMaxwhW+Ib1HyeHbZsZinW9+7cY56Ul/LMn7hidi1a3xulH3LDuTEEyUNMdCW9N7ihbbrHbZwSMXHAdWBI7yij60FlQ71SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5peua5g; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24cb267c50eso8292745ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757412996; x=1758017796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRA1tNnGH/MfGCb7e8SaVap6oHhoVBPZzEtWR1E3eD8=;
        b=e5peua5g3ILU+0wnqDy0NkdG0g4fpvIirUcW+Mi/AT7KqJ0ljBl31smdRf6hP1kMxB
         XU288g7MORHsmEgFF8VrZzG/T1zJl51RN/4XNwWs2rBQ1oXYg60cDydNho59BRlvSKc1
         RBXiap7wrbaNYsGZRKNwY4BITHd0gER3UnRegmornzWep2g3lG+erfuPhaJEKO/dAPFr
         VO4yyq2UlSFrtggFL1caL6ltc4Y0WISyW5meP/axngdKl8QQDPbCqSywczD2h9sfTnbY
         b4XvmWEG0XBOjRD//cJB3K//qWhKKhrTmK1kne26VzBZISMddZiLX3kk2QlkOuUcfVSd
         kP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412996; x=1758017796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRA1tNnGH/MfGCb7e8SaVap6oHhoVBPZzEtWR1E3eD8=;
        b=wKZVGui/Y7+b70THi8MyoAWRQmieHoLaKsGpGw0f0YO5dKQ4h3c+JfICb/RXWer6De
         41EIZW3SWNm2/Ny68aXwQwlvbAWzvRNvzex5FpvbtmJtWNZdnNW5pkcY7ZJ/rB+MWj07
         rKg26ySKGls9hQCBpfxTYo/ZrLY41sX1Y67rVZTy+BmqtQYFwjiuGQ7WjmWI3Y8frsu+
         wmjI5segYdcynW2aPPDcIjiMqi8faKcBsbunnGTJ5vfT0f7+66edVvLGjB3U7N3cWdhu
         Xk4QWrsuNQvtQIDMC6rUbnVcl8pvmVqDwFFEbEWZpOujOO0W/C8RuBzaz9F/7KemTt2y
         pbmA==
X-Forwarded-Encrypted: i=1; AJvYcCU47dzEZmpFZ6FJgaVg+1eUYkAiJ9oelYx+4hf4Ie2xTCBxIw7Q1SEWE5dW3c0Lv8cceGztm7jRHX4cH2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/yYoo3WAfEBUGX337g5bKftM2vyBR70M1IkuWCAqukI/3bRY9
	eTzmw5iYk+ijtSrJiw+Rlulcio0IFtgEGqcGHM7XLgPJbHZFqcVs3O6VAyqHr1TMth6ObCIPVH/
	n+7mZmyOjXDsSkzp8OM7to/nANjypMGY=
X-Gm-Gg: ASbGncv2bqtqjVPnRQTFnuGfzFH571G6oy/iJIvNnk1+Xskxkrjvq+N7LpC4TGabPRf
	xkXQVZWuNNT8dNT3FmJyYkWup22ffgbaOb0CWc58pBPw9YaiWnlSVBaP7jzOU7scg99JUGwLDoH
	a74S9KLZyjAwyHKw0KpCBUtMiBl+sQHPKiIijsEmTBWnHp1XisQzLQwyMPEN1shvp87IgyyAC8T
	EVfnA8dtyZ2zfJvZg44r6VgqV8lHeQJAAy9p5JHOsX9U+Qq7Kwinznv+jYejbHqUS1GZu0GlxRW
	EbdI8bbC1Zx6FXLahHw/fo2zwg==
X-Google-Smtp-Source: AGHT+IFRVKo/Gtkg+6TprWyzPoJr3m/eSYj6SZpUwtqQlLRttkeYnxvnIbsHYeRNu819giRbB97IRmdiE0doJRE7eVM=
X-Received: by 2002:a17:902:e845:b0:24e:a074:fbbe with SMTP id
 d9443c01a7336-251703939dbmr75623775ad.3.1757412995866; Tue, 09 Sep 2025
 03:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909092707.3127-1-yangtiezhu@loongson.cn> <20250909092707.3127-3-yangtiezhu@loongson.cn>
In-Reply-To: <20250909092707.3127-3-yangtiezhu@loongson.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 12:16:22 +0200
X-Gm-Features: AS18NWBru0Kq2XMwTpEiOoCDlYbqPUJ3s50syOJN4CqxsvVJPRxFAC9ia-wum2c
Message-ID: <CANiq72n7OSCUzycAQXFybx6BSVnj3MWAXvZj7U=AWf_UQwmO+g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] LoongArch: Handle jump tables option for RUST
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Matthew Maurer <mmaurer@google.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:27=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> +config RUSTC_HAS_ANNOTATE_TABLEJUMP
> +       depends on RUST
> +       def_bool $(rustc-option,-Cllvm-args=3D--loongarch-annotate-tablej=
ump)

I am not sure if this needs the `depends on` -- from a quick test, it
seems to run regardless of it (and your `ifdef` below doesn't care
either). Cc'ing Matthew in case he remembers why the docs mention that
the Kconfig one should be guarded by `RUST_IS_AVAILABLE`.

In any case, it shouldn't hurt and it is only on the LoongArch Makefile.

If you will be taking this through the LoongArch tree:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks again for fixing this!

Cheers,
Miguel

