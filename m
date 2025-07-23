Return-Path: <linux-kernel+bounces-742216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCBB0EECC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DD13B81B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B3628B4EC;
	Wed, 23 Jul 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTnl6RyJ"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8C286D62;
	Wed, 23 Jul 2025 09:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264338; cv=none; b=sMVlv+1B3mEVkbyMY5OnmAsHTWikUPw+BwtaoaroCLgnlonLOAMOsWcX9DvAlvzh39IBUPgmvhhfkqwxhLPm8rM42bzJbRg4Y0GTOI5qE2lWcsdQR+3G79HIZqlk+I1MEaMUKRwNJswqV5EPXD+YpBSncu9oe9pgmizK03m4LTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264338; c=relaxed/simple;
	bh=N/dbalNatsU+qJPlZyF8dzo8wixIe5QIEqdKyRkmytU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5TPqthmNoTnpWyeSFj5AeapZ6XhOOR1MMVwwlNme/G1qAex+5i1dPlqt0YAmgovhHOKpIjONrhE78i6MkhkfJNjx8FGmLKrBiLjOTdFbgAOSqHrL51nk7wqiqa8ng2CnJ/1ToF/UH0Zx0b2x6QNFru+WJkrRYcAsEgBI3g1Ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTnl6RyJ; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-312efc384fcso300607a91.3;
        Wed, 23 Jul 2025 02:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753264336; x=1753869136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+/dV0S/yM5ebUUQww27WfFYh9svGL82SiTI5/e7B7U=;
        b=dTnl6RyJ4TUIVoJmqUuDJYhoEObZ+jPz20Uwkq4Ex0TwNhW82mw79oWBi3sdAkFlWv
         LYdzUY71UlUuTTW5eBAYIiEtAx8sFaCBAgRIcxS7j6NU6ICaSjB+ZpFrCyHJu1ib6+jN
         1nLYAt0UhfxMn51VlbBgUz2WRJXk/ZlfD2u+E+lJCi50bZHViwInbmr3jyQ1GYXiwv72
         Oa0a/hlP+9BikAWge6Tdb0m/bOLIvjtjvdjJNrGNlnXutHeQHwnAwweEopcvN8xXzw1w
         t8kGEsTBW8DdVb0krsGX4PXwYFRtLsAVwwo5m2oYKpbjoP3zuE04Spx8B8leBvbVSkKf
         JVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264336; x=1753869136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+/dV0S/yM5ebUUQww27WfFYh9svGL82SiTI5/e7B7U=;
        b=X8otmHbftmGdNOH5Yqe4YuJQGdDDaw2o7WG4RgvRbVBrdwFRz4c7CfnNUpg1xPRqss
         +8+5B1FFZQ6xr8qjcji2Xp/mv8FWnZmjgnpwF6hdJ66Iw8vCNAuuWmFU46NUmLUw2KDN
         1sXLrX4rHoKGVs0S9xVPb0rKvLlx8V0BbfKyhX6Z7FXBcD4T9dgWZ29JRDrmP5LuWWWl
         EH+n4Svca/DO1VIuSNs8CRnAMGOwa0nTbZ9pLJXHbKvt61kvPT5mRBjrPUlDxfDwMPjS
         CB57gcOeFQDD/EeOqwjvWCvMeZYuc3J2CnzG3tQElOQ1iqRVsqzQOCnZ0jL9eUiuKY5z
         RlZw==
X-Forwarded-Encrypted: i=1; AJvYcCV6xzoJ3djBx5hodol06k67k/APIs8dQG6Hj1ePGiYQJgHQDFJ7ILbnBlFCRPqUtv0jvtvczC/xRwfoXtyM1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHE/NsZTFp+3hnpqVegBFrwhYo5o4IwA7dNN4t3p8NTaxrXOS
	pigrp//6ljiMuFb4yY3cQoBaPLTehB/m3d9MVKD56xafFJLPB6ALkQNGabm0p+Dcj+qoqVrwkTy
	8N+sOBznmNsPKCukARmZKKkKAzfYh2C0=
X-Gm-Gg: ASbGncuzQT9f7pq6WyAeops+YTftB4FX9xmb83l4gnQguKiHgx4dkTt3eIcjr2LG8Vj
	07zOLUcubUlM2udtB11IF88htKGKApYFNHArRzBaRzfCuOdun8389jlGJUvI+4ca4u24DxHSr0M
	cusMRqyJC9l+I1YCQzE6kCmRXr9QeWp8Jmh1x4gQuzg8TdNsoeLBlK2RA8YEjSCihskqpir5pNP
	RJGJyQr
X-Google-Smtp-Source: AGHT+IF5yp3x1uoUnaGZMoJBe+fzYcdYddNENz2TuSijJoibHeDm9sWJWjMzhPHdSfVi3F/pn5nO7IChbp80rUU+c7Q=
X-Received: by 2002:a17:90b:4a47:b0:312:e76f:520f with SMTP id
 98e67ed59e1d1-31e5088598emr1376264a91.8.1753264336236; Wed, 23 Jul 2025
 02:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502094537.231725-1-fujita.tomonori@gmail.com>
 <CANiq72=Hr5rg7tYta8aUoxt8hOPjR2ik5_-xMWZwacr63=-7KA@mail.gmail.com> <20250723.152042.1300024463910400.fujita.tomonori@gmail.com>
In-Reply-To: <20250723.152042.1300024463910400.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Jul 2025 11:52:04 +0200
X-Gm-Features: Ac12FXzZ5eWdKPVCRlnoxNrP6D3TFPlJaL8XzNsPkRFhVqP5xsNvOO-4LiDYGFY
Message-ID: <CANiq72nLQkJo8voGONJBEgE8st7=A4RW7VP+W++SVCWse49n=Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] rust: Add bug/warn abstractions
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org, 
	kernel@xen0n.name, tangyouling@loongson.cn, hejinyang@loongson.cn, 
	yangtiezhu@loongson.cn, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 8:21=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> The patch for arm64? I tried to minimize changes to the original code
> so not intentional.

The riscv one, i.e. from the range diff:

    @@ arch/riscv/include/asm/bug.h: typedef u32 bug_insn_t;
                "2:\n\t"                                        \
     -                  __BUG_ENTRY "\n\t"                      \
     -                  ".org 2b + %3\n\t"                      \
    --                  ".popsection"                           \
     +          __BUG_ENTRY(file, line, flags) "\n\t"           \
     +                  ".org 2b + " size "\n\t"                \
    -+                  ".popsection\n"                         \
    +                   ".popsection"                           \
     +
     +#define __BUG_FLAGS(flags)                                        \
     +do {                                                              \

If you look into the `.popsection` line, your patch adds a newline,
but I guess it was not intentional. In x86 there is a newline after
the directive, but there we have `extra` afterwards.

(I noticed since I went to expand the macros in a dummy file, given it
can be something tricky to spot differences in the normal diff, but it
is visible in the normal diff.)

> Yeah, I followed the original code style.

And here I meant (i.e. the first part of that paragraph) that:

    -                    "\t.org 2b+%c1\n"                                 =
 \

now generated those two spaces around it:

    +       "\t.org 2b + " size "\n"                                       =
 \

> I've just tested rust-next. Looks like all arches (x86, riscv, and
> arm64) works as expected.

Thanks a lot!

Cheers,
Miguel

