Return-Path: <linux-kernel+bounces-874039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605FC155DA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F68A1A27BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A8432F773;
	Tue, 28 Oct 2025 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKcxyVFt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A8330336
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664370; cv=none; b=sJQvionI31C5L2Kb527uzvJCjnO/QwbNsc8xupPS86Rs9zYyrreffZQkAWqCxFxY/02Ic31aQZblMVJn6gjKHr7Yzz58Yq3j8KbeQWIQQ50e/16ZaWUlIXyTV7vVSXqltEXuGSv+6fmuxfRwokTFCwMcHYGvEFL09E34JepN/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664370; c=relaxed/simple;
	bh=5snQUvhRWkb9C2jeab2EsORSQy/NoakHLRvzEAR046k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHWq1Vr0yDFOJI0xQR79sWSUsq6xxD9NKxRGxpfxdK+nUXGPDGnfgme81iQAHv1sv+lHrBZKatCeVoWtSvbL7rOrIECQlFUaPd1lPB+yP/k/LY6klUjd+muBG3dzrmvTh6kn1XTil1tk011T5XCt3pIGf6cMGVLFyzno2OFAwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKcxyVFt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-26987b80720so10871325ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761664364; x=1762269164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5snQUvhRWkb9C2jeab2EsORSQy/NoakHLRvzEAR046k=;
        b=PKcxyVFtt+oUhsjAFL8E3uUOhoMFld2/GnJFxztnedI5XSkMRzGreFOVs7bdVDUWh8
         eTYLiHMqrAYr2oXBxox3CPmBylH5u4EEfFCuDOwQ9zc3iIAxDVvrpMhcZxQ+52/MHg6K
         1rZdHgtix6I2I8aJ3UkRo9jBhClJZ6KQ+sAOFAysprqyKD3AC44vgYgmXl9FbzhPJeA5
         CE33ZxJpf6gjn3yEyRbKjXl7dFwGIcH2fBXiQsiqdxbUTsxIMbwx5dLeRHkCFMhc6XJ2
         y/etP7kEkZoW8cAQTSvzx94836cNQIEc2eurfTajg1DX1OJMHXqujQu4mxSYF8IxN/M/
         uvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761664364; x=1762269164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5snQUvhRWkb9C2jeab2EsORSQy/NoakHLRvzEAR046k=;
        b=PaLnxGVkb4X8qd110iqCNjfMvP7cLXE02dnDeGkUggYz9M8WO8DptV61UjkYqIFh5y
         0BU8YriVzNmsNQfGiPcWmzAdsaFtJ45+idKed4lGGbDz3GUGfNGkglzsOQdQGkXmFOKp
         Ky8qxYPqxiIkopbvNMWKAo4z2rSq59Y9kawPPcwgP5YTpN1QebKuyyh2WhVBqjq8QqCS
         hehSRJELXLJr2UbrbX0PciG9gv/8MklhyWpSErTbnall0OtIjrL5c9Azpu6nEQ/jsqxT
         Qzx/BzJX6klRJ5btL4+vtbQlgumfF3G2e9Fw4sy+YDemxStsQF19zAqn2XPKyAvbgqZy
         sgYg==
X-Forwarded-Encrypted: i=1; AJvYcCXGDPgSOlWYS9sETAxddYltCAftV4DUvQ/7gpTJwGxNrtVLlWs+sczao47YiXNNLCQSCRvenALe//g8UZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVcU77GVEr+9AiOfA2N7MiFatqMorhQxVjHt4bPfQ9Lt/Y4CeB
	znUpsWStbiGw0eLRfUOU1umg5oaM8dOQuBi2HXDANKSIO147A7oosTDYw2wGHo9aEAejQsIMDRp
	vkjWr3W27DhRVZoBLjrfU1bF4wi0I56k=
X-Gm-Gg: ASbGncsfvKiEBJvgjnDExxE1y4cA7KD9SQyVsmqZ4WofkfjVyy1Yzex4WC0Da3+zjD1
	h/lqeKAe1iZ7IFvwWNKn3pf6BTC64OkLqlfQ7ZhOFPSrh4fXb0QUsIfCiCoN8Dv+8fPtan9ZiLM
	SwmfMtO0eEJ9sI3OeWdvEOYj6zlQOV5nnz1lWGK/Y4fJ5UAPD4DcvYtiJPyDzjAF/UV5a6+LZMm
	k0HTIG/pomrYaUBPZXj1GSxzl8r3YYuZr1iJYQbnaare2HvnVxhyY2MFJA+v5rxX/GzgRAL5D2m
	lYd061t/ogPeS+q8hiJWTb9cksDBy4ucFvMwgyvxLD2YYIA4lqVHgqXd48WORJKiGNp0PNMzYfE
	WgCg=
X-Google-Smtp-Source: AGHT+IFYPGiAfq6Bkpv4VIZbnQ2eB25p+ZAfZMrF5Pziev/2opSXlTlA+Qb2DBeslIA+t2R0h3bM5akBnOcG/++7Z0U=
X-Received: by 2002:a17:903:8cb:b0:27e:da7d:32d2 with SMTP id
 d9443c01a7336-294cb500277mr27314415ad.7.1761664364153; Tue, 28 Oct 2025
 08:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026-nova-as-v1-0-60c78726462d@nvidia.com>
 <20251026-nova-as-v1-5-60c78726462d@nvidia.com> <CANiq72mgoW_TyWf9Nv=5t3Qij_dsDjicNpGsa=F1t+sg23vxSA@mail.gmail.com>
 <de796658-ed1d-41f1-b153-f3d1089656ba@nvidia.com> <DDU1AQDW78QI.1CBHEW03926H0@nvidia.com>
In-Reply-To: <DDU1AQDW78QI.1CBHEW03926H0@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Oct 2025 16:12:32 +0100
X-Gm-Features: AWmQ_bma5_85Uxd8PIaUq6SaqwUjakaAH7XUFCSDVLctaYXwoFO8A3BqGERgpOk
Message-ID: <CANiq72nbYiwFO6Vqc+yoW1-qT_uMN-CftgOpPe8Mqn56b1Fq9g@mail.gmail.com>
Subject: Re: [PATCH 5/7] gpu: nova-core: add extra conversion functions and traits
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Alistair Popple <apopple@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:44=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> intent with the latter was to say "I would normally have done an `as`,
> but instead here is a method that attests that this operations is indeed
> lossless and safe".

Yeah, so you want that, when we see `_as`, we are reminded that this
is the equivalent but lossless of that, which sounds OK. Though I
wouldn't say "I would normally have done ...", but rather turn it
around and say "Since we want to avoid `as`, here is a method ...".

Now, I suggested a change because typically I would expect names to
mention what they are about/do, rather than how they are implemented.
The implementation in this case also doesn't say much, i.e. a type
cast expression can be used for many things, and worse, the operator
may or may not be lossless, so it isn't a big hint.

But, yeah, I understand that you want to evoke the relationship above.

I also suggested it because when I wrote the message I was thinking
about the `cfg`s message, i.e. most of these depend on the
architecture, and thus having an `arch` or similar does evoke a
"careful, my code may not be portable anymore".

On the other hand, it is true that the `u32_as_usize` case will most
likely always be available, in practice, unlike the others. So an
`arch` for that one isn't great (but I guess it could still matter for
someone wanting to reuse the code in a different project/domain).

In any case, personally I don't mind it too much either way --
whatever looks best for most.

Cheers,
Miguel

