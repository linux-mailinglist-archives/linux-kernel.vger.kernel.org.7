Return-Path: <linux-kernel+bounces-768244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA49B25EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B599E4D24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863542E7BB8;
	Thu, 14 Aug 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOaLjk+T"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837725B2E3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160007; cv=none; b=Pf01jZOCa+KZ3KYQz8825Fzfe6L0VDkxgW37JQ00RaDUS82+VhhJtUZUxydnAramZ8/90Gj62V7tIeoM7ZiyVTAC1/cXwNKIZDfuNcceo5mTxvUhwok9MxEWI0R8aYEf0xPLIwVWXFI2VFX/znzeQVLdDLIKokKV+kIAVEw67GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160007; c=relaxed/simple;
	bh=7ZIi+MkP1OxwrEPzpZafzArHv5qoy2iK0OXCG9SMGMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DSnoI8WzfOkyU0HB8PQC+5TpbOnrqFzUEMDfrVO97hE4rBsqqpECv+2EBWhbN9VLz6w5I2n0drN02gAeox4uQQ/0tuMoximjT4IF2dSO/FMdc4leOTnPV6wK81cqeZ7yIGJNqP9FSnfJRRlm814IsKFOwtoFyMcSBIpWrsCIpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOaLjk+T; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0045a0so3293575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755160004; x=1755764804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZIi+MkP1OxwrEPzpZafzArHv5qoy2iK0OXCG9SMGMU=;
        b=dOaLjk+TWTBAd0vn+0fBgoVHMvvK9fQQ5qR9Cq0LhznxjUx+gDIG8sSeaed6fISV/s
         R5M2aRr+KZGbMwyYv3c8naogAfQqs/rjDAHDf/xcB34CAv+D5eIbINv1qbEapIE0xp5W
         SZnvjFthz6VvDJl0PbFj9wItIQajDX6/kugW1pDaiKwgI+NCSNBFznBAB00O/l3LGpoa
         OunsmNjZ21qxZk5b9swUZWqMsuBKnI6/PFmdQIcZER7OjS7CBPEn4Sk/aHtwdk8Abaxm
         LZKWEyjXbXde591xyOka6S3D+CNshegu7xp4cL5mxtAkg5es46BrKxzb62MHCzs28uwX
         CYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160004; x=1755764804;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ZIi+MkP1OxwrEPzpZafzArHv5qoy2iK0OXCG9SMGMU=;
        b=UfYao6WVD4XPVMHESdkCPMkRHbo/LG1CJSamYlqBi2l5rt3k5WdNBgfhzV3IeI3/+p
         DarDXF3H2T6nCB5quywH8+ae9hRE3tfhJiBbq+PnSKK39Ez4xq1I8ZbfTioP6PRRt6xg
         MsMtbyuQLai+VUg9TT6T9+8AwJQLEeM2yEaePDC2s/zjkgJKPE9KWHML33AXIIot4Rgr
         MwfBHZuiZyd07z+7tNIebvHFatOQRpy5wwmwaX9xrhrdkuSLdub/5x65kJ5eVR/6uWLc
         eQTpm9YnM8ViQp545aIWQHxuvH1+ukSzVXvH/nutYDAdVzBohY+YWKBWrchx/nL2rNxQ
         EOSg==
X-Forwarded-Encrypted: i=1; AJvYcCWJkWePrE2A5h4w1bWEWaRW2rP3QdV4iQG1MJvPCFI3LrTYLsqJvb3EkYvyGempyZj0seOqhdapvRNLHdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/9mtp9Az2iCTxeBCvpqDTiQyaFjuDTTleMUawIEkufTbRoSKv
	Cd6SuXSQ4ZFkXSxD5GvOCU6BRs9rDiRCWJZz38vdAU/oKZF+tyehm3Z+5n9pjCdYzF2S9u3nqeA
	LPcikQW15231VFEUUxw==
X-Google-Smtp-Source: AGHT+IG9Pl+Ba6YPk1J0Vi/poXN6DiF5c3p/B8XyGbVL2OKVmjjV2Fnd88y+GbnqivrOCG20FfIAUfst1JOn5lc=
X-Received: from wmsd13.prod.google.com ([2002:a05:600c:3acd:b0:459:da33:b20c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:138d:b0:43c:e70d:44f0 with SMTP id 5b1f17b1804b1-45a1b6697d0mr13496565e9.19.1755160003795;
 Thu, 14 Aug 2025 01:26:43 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:26:42 +0000
In-Reply-To: <20250814.151147.29094382820492173.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
 <20250811041039.3231548-3-fujita.tomonori@gmail.com> <aJm9A_D-zlJtbV6X@google.com>
 <20250814.151147.29094382820492173.fujita.tomonori@gmail.com>
Message-ID: <aJ2dwkHX0i7bFobg@google.com>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: Alice Ryhl <aliceryhl@google.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, ojeda@kernel.org, 
	anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com, 
	me@kloenk.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 03:11:47PM +0900, FUJITA Tomonori wrote:
> On Mon, 11 Aug 2025 09:50:59 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> > On Mon, Aug 11, 2025 at 01:10:38PM +0900, FUJITA Tomonori wrote:
> >> Add read_poll_timeout functions which poll periodically until a
> >> condition is met or a timeout is reached.
> >>=20
> >> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> >> macro and a simple wrapper for Rust doesn't work. So this implements
> >> the same functionality in Rust.
> >>=20
> >> The C version uses usleep_range() while the Rust version uses
> >> fsleep(), which uses the best sleep method so it works with spans that
> >> usleep_range() doesn't work nicely with.
> >>=20
> >> The sleep_before_read argument isn't supported since there is no user
> >> for now. It's rarely used in the C version.
> >>=20
> >> read_poll_timeout() can only be used in a nonatomic context. This
> >> requirement is not checked by these abstractions, but it is intended
> >> that klint [1] or a similar tool will be used to check it in the
> >> future.
> >=20
> > I would drop this paragraph. You have a call to might_sleep() now.
>=20
> Do you mean that, since it=E2=80=99s obvious might_sleep() can only be us=
ed in
> a non-atomic context, the above statement is redundant and can be
> dropped?

I mean, klint is nice as it's a compile-time check rather than a
runtime check. But might_sleep() still counts as having the
abstractions check it in my book. So you shouldn't say that you are not
checking it, when you are checking it.

Alice

