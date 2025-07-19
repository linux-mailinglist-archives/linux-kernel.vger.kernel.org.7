Return-Path: <linux-kernel+bounces-737817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23749B0B0EA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FB217B2DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152628851C;
	Sat, 19 Jul 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHZATABx"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FB7F477;
	Sat, 19 Jul 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752942598; cv=none; b=PRHS1p9499v5fchlf5tw7sVL/f8Ls29YFuhwndLKV38WbnvU0MK7J0VJAgc9mMdVL8GpgIV9sQj2hTDM4VJ7fVSGH9MT4ATSROcOVsihaoSaZko/KoiNBU+XjcAZ0t627NJL1bhBKSgG+AZeo5hohCiUWT9IHr7wurFXrPCQ7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752942598; c=relaxed/simple;
	bh=sDlxeqjpDea3IcYX9KdVR0fwZthgGTewPooPnxHY0SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOQTbbkFTZf87xTn6OxKO12RYh3Ib0FAZQ4dTykAIXsGxktD2LGwGVYgM3omM2tTZtvdR+QrM+ADtouLJ8umeYOtTFCMNfGN+D+JcLymgS95rT0pWtbmG+htuMgkv5oYYoJZ07/iMC1PGTES0e56G6XGU1t1/1iDlSylX3n5QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHZATABx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31306794b30so539332a91.2;
        Sat, 19 Jul 2025 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752942596; x=1753547396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDlxeqjpDea3IcYX9KdVR0fwZthgGTewPooPnxHY0SE=;
        b=YHZATABxLIIFC4EWnv895b3eRJkqIQozf5sOTm433MFYXpY3D3opzX6t0eZGVcL8mD
         X603E/wjQLcs20r5ITEBAgSJZ4xGtapPnvwpX45oERXGs3qWP3CSuXwD2rmcpEZvcCqP
         5S12rpkXnPAEpxo3700gOUkC/LnvzuyfaXdCHsZq672U/tJ2cvlhCdYusq17H2EAYCvQ
         7/VlapRAGngMMV6z2u+nnUwJfWMVJFj2gQ0/p8neDTEcEI15qTSYJ4x/bONT9SsL06hp
         x7VjIwVcsJ+19viR+kV5BzPT60bmODpWoz5KGyRNNpxHNC/lJzPGoOyX6YIYprvjqF6M
         ECag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752942596; x=1753547396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDlxeqjpDea3IcYX9KdVR0fwZthgGTewPooPnxHY0SE=;
        b=FU4LWriCg4IciSgAYg8/pTGPoMro4hIq7cRCJk9r/mPiQllOatX8+Z5CCafEBTy6yP
         03M4NfWZcldXxbKL8JpTQc9i/y+qIPZl40emlep6g1RyUsdyz4JJnjW41vDAPhmd+1SB
         VHD9ya921QgrbLtElT4fvADEnHuZFQvgO3YpFW19cLpyMrNwSmEapWsXeAXRhzojywFb
         Po9LMPuOeRR96XYyKu00Q5aVB77q/xxw2pgwYP3QpHHmgh3WoiomDhi5eEmEBQP2cI2n
         +UonxArg+WwDd2ygM9UPddS59zojKgp3fpIz3YEwohG5AEMDH9vzqbX+qVD3ACv98VUy
         KhPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVovEEwUrXuTdUv0G+watBKVcGp5bHpKjShc0I5LdtwlyMszObOMUfc8v8R+/+Lvl66cPsNXLvP4jZtTAJsMuM=@vger.kernel.org, AJvYcCX3qJI8U+lGnvwaoqWOp2WVKWtgf5sEdOOMV+bH5ex2ZJC8BRMhwRxamd1CTH03GYRdZASAYUbIqaddYZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ7+pPWpRnKKzfRufm0XfHfNGWXaMpbrijCCnhDVL6U7d7xWvO
	O2jw9D9/GAmPsay27xTgijz3Yj4s4DnUj4GCdfesdYvFnvZm5a8HYLHXeTo3U5n+CDtpLHxBOBO
	8hgjjYgn9wfw/BPKUJdINOOAauJiQDnE=
X-Gm-Gg: ASbGncuD5EPRPjv0xrcwMt7CCzzeCwzmlfnsL76KnKdXR7fCZxBY+3aeabCt/BZ2b7b
	71KuR1zQA8W7OkEYodHM8D7btkDu1dW9GP7UEILCgg6W8hG8f3bqFkzzWfYao19ihwSEA8gsvTG
	vsJ6y5MJycuCYWkMa+741Yt+KiSAyjHLLoebaLoAq5HQOpxOH13EWGHP7Xz2YYTqH6ItxKeYxcS
	/bi+6XO
X-Google-Smtp-Source: AGHT+IH9SiFlJvi3yHGt82o/LqOazDJyLe37YRLnfkzafo8Bnf/rlOx+uqZH8uGFC9XWOQI/CPwtT8ZCWeKw/c2sqZ0=
X-Received: by 2002:a17:902:f68a:b0:231:c9bb:6105 with SMTP id
 d9443c01a7336-23e24e14eb5mr87578285ad.0.1752942595769; Sat, 19 Jul 2025
 09:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
 <20250717-topics-tyr-platform_iomem-v15-3-beca780b77e3@collabora.com>
 <DBG25OQZJ18V.1W13FEOPX8MOH@kernel.org> <CANiq72=LAaQuii3O_+Pa+wYSXyd_Joi8aecNGVqn5fww8PbZ7Q@mail.gmail.com>
In-Reply-To: <CANiq72=LAaQuii3O_+Pa+wYSXyd_Joi8aecNGVqn5fww8PbZ7Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Jul 2025 18:29:42 +0200
X-Gm-Features: Ac12FXznE1-Mhz87YX0IjGhzzhS27Pz08HhHD6IHZGHnJnV2hgbkPPGj-koBfvo
Message-ID: <CANiq72=XaFgMR6rqH5gGoqoAgs4Ub4cicrAqdFGMaKZVij167A@mail.gmail.com>
Subject: Re: [PATCH v15 3/3] rust: platform: add resource accessors
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 6:19=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yeah, we had this in the past -- when I introduced the lint, I just
> went with putting in the middle, e.g. in `rust/kernel/sync/lock.rs`'s
> `do_unlocked`.
>
> It has been fairly confusing, because long ago AFAIU it was not
> intended to be supported, but then they introduced a config option for
> it, and then it was made the default, but there were false positives.
>
> It seems it has been finally fixed in
> https://github.com/rust-lang/rust-clippy/pull/13888 for Rust 1.87.0.
>
> I would say just put it in the middle. The only advantage of using an
> `allow` would be using the "reason" field to say we can move it >=3D
> 1.87, but if we really want to move it, we can always use a normal
> comment to say so instead.

I have added some information and links about this to
https://github.com/Rust-for-Linux/linux/issues/349.

Cheers,
Miguel

