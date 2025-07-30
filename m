Return-Path: <linux-kernel+bounces-750436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD33B15B52
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4629918C19F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFBD2701AB;
	Wed, 30 Jul 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zj0o4ghB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5B19BBC;
	Wed, 30 Jul 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867035; cv=none; b=ocGrNXiZNv9bwybcuxY8fnotjd0Er2Y7npf72mnZcgGTb31PhHtNSlWJ/bWvz28vJrP08txIFMfjov4KWOhGQ1bGtYR78FsfDQOGz45GDUSjSadtnWsEC3s987oqBn6q6pHELxuxctpu1MpVHR8KWfnckHDIHuW/RroF7ZPFH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867035; c=relaxed/simple;
	bh=oyoz4k4QYMtoaz2JEU06qpYJL2BGR3kKis3s0TF7D1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vE+klDgd9dZXxfrRbj2RIPMHfVyerTIjf6udGWvAXbSEvPoYDZNF8rwSxvBHCXXk8IYGovZbyTeo4oJP5NJvdXBOLFx8KPi3Z4RQT9ZrF8gGP+1Z8VsOM7KG0lCnpPH4ZwcTKVi/HRhza8pQEgv3yR7pYHX+QCwXVbqTb948iiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zj0o4ghB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-240240f1478so3909415ad.1;
        Wed, 30 Jul 2025 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753867033; x=1754471833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cvx3jlCW1kUJS1UO86lbagV2SGRq3t/wFGliVna4Zs=;
        b=Zj0o4ghB3lrG7R6InXG+wIatNS9c/9frGAxc72gTcqAHRfPEy3Hko7Tek0pOuFh64/
         H6UZL8IGoFdm8wa7YSjxkHr0E3v2SWox/B9IuR4IcR4JTO1S/73D0ljbLF5uRfIO/BNw
         xbPGv6gxZUCeLn5AQQrbVNOCpJyTZxLVcziMekCIvlOZmJ0W9b9pYWqgwRELA0pYqSoj
         iyZ/fDu19461v7XGcJWFYJzmmaLsVtPXMagxcJpIREpSU1AUTXGerajSGt25u62Hh34g
         VlHiwB9VerTVcMpdMgDUfnl54r64cfu3ZGo9cit4kszhMSx+eQiCNpHz/ZqYwBmpsYAH
         71rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753867033; x=1754471833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cvx3jlCW1kUJS1UO86lbagV2SGRq3t/wFGliVna4Zs=;
        b=d3vSc4TiXJDEnbEDkawcilUKPa+JMYE7QQIkK7H1ZS4oK7M4i68Ve90FpdJtlJgbc5
         xIyKKLHIotUW0eBd3nHpf6Qzy57bBfe6MlWsw592uJxFhpV83PwzZIKR42wI2gcWkgjJ
         xyPdEU13dkBBDOnXC+d7AqfDLd0b/Y5dRqlO9tmlur7VpF1pN7MpvkGZmIhctiThJMms
         dyPE7cuskh2bcw7lZBmotRrh2p9/1+6d96Vv9xEMaHUac0X4uATqrobOR00R4DguGfUi
         KlcSs+4Oge1lRFvHEue/bIgb6xaPyFaLXw0Kj7mMlvezL+RXsFKC4ey4K8R+jywMY5iK
         Ai5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSeGj//hgYf1wA0aJwElg63AdIySP/L1jO4Wv7JhXjRQZGs4gcRMaLQxk5rSH16N0KG7+9Oaf+Kxi335qKBJE=@vger.kernel.org, AJvYcCWiV0kDcjpHvpmkRyZJKlEit947RysBGhnNVRC4x3RIgy6/IHK3kEAhE85ez26R9k0unI2nmV+s0VVDHXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtpNEAUdHZ4zwS3n8CDnUsFcZZDZ25OQQs62UJsyvWJlU+FW7I
	zagj3+Sqd/pf6FR1hs08J0eSFLOOgO/yy6Kl+93t0RzNHzYiAjp+W9Cd81CUYxSxtpryQ6P1ZCf
	WqOZ5Mhx0zaqOh/ynUM763pQVyoovwHs=
X-Gm-Gg: ASbGncvMvgdzqmMTwsj47k7fHq/pWUOjx9mWkl/Wb3WLzjI1Fl7+36ILTcsK19G7kUh
	qObaCN6Lj7FKunPLi8o6rE3AlFLiZm/xj0rTSWq9ffR8D2iYlM9GNg9noeirpnNAge/FhvTFpt7
	YudmkvYIo1Lp7SHwpPkDmvmQ36GYNRgndGDJZc4TiimZsHdwa0Fp3XVa7Xz3xqN8+BQi2kEi0ps
	sCqrna2
X-Google-Smtp-Source: AGHT+IFviiFpY5qURxAmF3cs+hlFE9oNjWne7PmU5uhh8IL6DjReVabkfDO1rSN8HCo6zGiWEaC1cgW28Uq4mulUdIs=
X-Received: by 2002:a17:903:22d0:b0:240:79df:48b0 with SMTP id
 d9443c01a7336-240969a3ce2mr17124625ad.0.1753867032977; Wed, 30 Jul 2025
 02:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753841900.git.zhuhui@kylinos.cn> <3ad14f15b6d2639d6e998ecd03158313414b69dd.1753841900.git.zhuhui@kylinos.cn>
In-Reply-To: <3ad14f15b6d2639d6e998ecd03158313414b69dd.1753841900.git.zhuhui@kylinos.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Jul 2025 11:16:58 +0200
X-Gm-Features: Ac12FXwFTq20Np7yHTit391o2Sr0cqxsPUwzM11RptHMvEB2b-XUHfvEScx2lv4
Message-ID: <CANiq72n_RnW=zma48X-txV-4AUDU9j0YGmYNBFYQ1CG3oxROJQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: allocator: add KUnit tests for alignment guarantees
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	vitaly.wool@konsulko.se, Hui Zhu <zhuhui@kylinos.cn>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:37=E2=80=AFAM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> +#[macros::kunit_tests(rust_allocator_kunit)]

Is there any reason for the `_kunit` suffix? If not, then we should
avoid suffixing `_kunit` to every suite name.

I see we already have `rust_kernel_kunit`, but that one is because it
is the KUnit file itself.

There is also `rust_kvec_kunit`, but we should clean that one up.

> +    fn test_alignment() -> Result<()> {

`-> Result` since the prelude is available.

> +            fn alignment_valid(&self, align: usize) -> bool {

We typically prefix these with `is_`.

I would also call it `is_aligned_to`, to match the upstream Rust one,
which we could perhaps use if it becomes stable.

Cheers,
Miguel

