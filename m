Return-Path: <linux-kernel+bounces-800826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C395B43C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1231C806E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED817301032;
	Thu,  4 Sep 2025 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E6hlXJkG"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28492D948D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991289; cv=none; b=TrlZucc5QRe7D0X8DgJeZOwg3GbRSQIHe8ItN5YvXT/9Jg5uBND0NjSyKIIYwoWELFgRRppPfBIkfkch+G+T3jo7BvMTE2aoPPaN+xJDd4jRaR5MLYd257y9BlPtGNV79fieNk5uVV1p2PEyUH9VfI1M4iT+YY/B/PkqSoTSD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991289; c=relaxed/simple;
	bh=4cZqK9YzKCpf0+zZ9irAoAp8vCEv1wbUaz3rjA5fNE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBN5qIi4l1vQkp+J3NFV43EFTjNATRT9eWGDbEdrsrWuByrpAfnyYOGkw2AdC3nWAT/akQXlTgxHtuzDUG0kYgf27RYEVxIFhq34NukMb8XFuF6wKIrt1APN6Byfa4QyLVR1wYjB++AMniEvHZCkiQZg1QPTlhNodRzJf2CYJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E6hlXJkG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso744568f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756991286; x=1757596086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cZqK9YzKCpf0+zZ9irAoAp8vCEv1wbUaz3rjA5fNE4=;
        b=E6hlXJkG4hPYwLFypn3mCBhkVMicv7RpGvd7YkRty6WunpEBNzohzgsfp2MQx+WqVe
         6DKVPk8hFPp2FVY6VUocQrq86tWNTMqRQXdDJLWVCBymxivGlT1/046nQ00ld1+NJBsQ
         3NgKjqbajaqO0/5M/ANL2GF3OxU2MjHwmz4FyrN0ZFAsum87WRkENgWvJqH1tGPtc4Yt
         XyOwZX9d/nxi8lIqwPq4oho7Kril6qZuMl5uInVq5lVsJGMAMlO4DGzlyxDF4CHeZcNo
         aVJ34/ekU2+MjcvBS3N+g7K8u77833NitznLfr2vN7udLX2yGcbRwqZx4Vb95+XQZj2n
         cCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991286; x=1757596086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cZqK9YzKCpf0+zZ9irAoAp8vCEv1wbUaz3rjA5fNE4=;
        b=dcLAr6gAiPHZuW1D0WcVNVeNYYqQNSAeaZGuxqjON158VapfYbfFXO0DTadDDsPPcY
         gi3Nnn9Vn9ZG3Hqper7Da9M133T3Z4hwpNRf8aHombMVhaEbB/XvKz5hyOMu76QuO7GG
         BAAb9FvSb4z9YUEGyidvWBR7LlllKQeboBzI64NaYz78f8to3gNxQr9TCAGN2M+nhgd9
         XuZbmML+VOiL0+1sy4nxzANXZa2c0iTHAOhUEwef9HKOA65QtRSFygJCOf7hB6XokkEn
         AfPbnvRzeYSqumakdZxtHc86bNtpW5Hn5Ul3TxM5cDqAec7INVsYkZD+yoEofzZKTqG6
         K2cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP62LQtWBh/lqwnizZxMNNvWTsYszm7jUCddtZHQHApFnzhKgL9DMvK8xWrUnKiSGt1oGIVCSfcy7t0gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51gbGw+lEsxRPETZqc8iQzMKeUM4cxFU9+dUI48tXFIAjI2BE
	v03zooyGPLV1NwYUxPoLelsKFF3bAQ3eTKfale+wbKYD6SEzSa059GQQ9niOy/8qOkZOWc3SqTs
	PNT+YJ7d7lCpzbRyeAdQZikb/OA4bCF7mSNL59SfC
X-Gm-Gg: ASbGnctKD3hAMMVKMqskmqHLllhJezlS1a6kO2glaQSD/dno3TEELABJS41UlsW1DgQ
	Nvks6P9VjS2WPo8a0reo8B/ThrTQvHpAzZmDeLwh05e8clRM6+n4axpFwRBB9ya2CxKsdl6K49Q
	MimhdxR+GNmQY0n40DcamXdRCb4xXF6/9Wv7xFzu8vxQ3U2gexQmkCJoIxIQa+FOFYzJ1vQMKpL
	2yGm908TieIJNHn1YR/d06a0ff8mlkoDcuGYYdzLePwGYEZzgWbNfZQQHQh8XYNAi9PX0RkCfwL
	r+RAgMAhjpwwuH1ysdQINA==
X-Google-Smtp-Source: AGHT+IFg6AKl3SCJnL7g0+bfVP2sauEBpLDoUNy8WCcZYED03ALkKxVTPtnNlh4mcIMrUbbycxmFvWWlSYL5Ai+IHxo=
X-Received: by 2002:a05:6000:2308:b0:3d7:abf7:24af with SMTP id
 ffacd0b85a97d-3d7abf72cecmr10000884f8f.23.1756991285894; Thu, 04 Sep 2025
 06:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-clk-send-sync-v1-1-48d023320eb8@google.com> <CB9F3786-48F0-46EE-BE61-8823E437C786@collabora.com>
In-Reply-To: <CB9F3786-48F0-46EE-BE61-8823E437C786@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Sep 2025 15:07:53 +0200
X-Gm-Features: Ac12FXy7iJnmk3xcF8Jlr0VlqsGLW3OO3fce9tyZdWo45UwBU5P9xsN6P9IsbB8
Message-ID: <CAH5fLgjRaFjiw84_uP4N2kTs_iuDCe1vcZ7gyF4XiwDkbEgiWQ@mail.gmail.com>
Subject: Re: [PATCH] rust: clk: implement Send and Sync
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-clk@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:31=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
> Can you base your change on top of [0]? Otherwise it will become stale ra=
ther
> quickly, as this introduces new types, i.e.: Clk<Unprepared>, Clk<Prepare=
d>
> etc.
>
> I will push out a new version today.
>
> [0]: https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-=
896b53816f7b@collabora.com/

I would suggest the reverse. If your series is based on top of mine,
then this patch can land today regardless of how long it takes to
finish the clk refactor.

Alice

