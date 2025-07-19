Return-Path: <linux-kernel+bounces-737912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF83B0B1DC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A94AA220E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3693230BFF;
	Sat, 19 Jul 2025 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWZKUC55"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26763BB48;
	Sat, 19 Jul 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958502; cv=none; b=ewU56VaWztrxtfc9vYJXudL4L8JsKp6INvmoRE8+39qgKYP6ihJ0ROO+mc4+xTo3iqH1oiUfulqHdn2fFi4xNh8sZ+lToaPOdz/YodPCGMi8Cv+HLtnb+MYWLX1VV4JYsrZ4M748MYg0rwkEFvwRCjs4Q4Ia35aSkA8zF8LXCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958502; c=relaxed/simple;
	bh=GQBzpFMnqoLsh0Qg2t2pSTObf/g0qvnCU1a/voob+BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaRC9j42cTX5ezLS1KPIYPLnP7wxtwv2cJuJRCboAxfEsEKbfZW64jKeWslupftBahzmm7RbH3e+76XAsqF+hg5Vb3fnoWe5Srown0ywufPO8pDaHO0p2BIy9zTakxS/yU+cU78ngFclQf09Vxvefu9f1rAYDSbilh1vHEozenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWZKUC55; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31306794b30so576505a91.2;
        Sat, 19 Jul 2025 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752958500; x=1753563300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYpMyf5txQ4BgkimxSYertgNk0vxadUizqxxBkE9GQ8=;
        b=kWZKUC55rItRNfsWBV9afaIJtNmMlCaK37PTaTlm5wG0Aa1MRwPKQSPnm7TyHkfrZl
         MHHxWIXO35/rjNdFva9l47uhD5OikKfRZ0LAqPhq8kDqQyIs6FJAsn2C519RAhvDkSnE
         agiK86jlYye0u5KYKGTWMLJ07h62VvEGGcZHLHFY8j6txJegcElVR4t4XZwfnd8iJSO8
         60B7qI7dZeehTxnfouQY79V7LC+c9cKE/K7Z5LIfnET88/5ex8HPao0cEXXuEDznqDrf
         zqFoAQOk7E2c/iMMK4slPI7wBEPS3eLRZyukLtlaQmEnEo4DMJcsNQTArnl7n12+mCf8
         IPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958500; x=1753563300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYpMyf5txQ4BgkimxSYertgNk0vxadUizqxxBkE9GQ8=;
        b=qkaqoU3vRYnWn7fKL7PuddArvOsy8H00BZDLAVUf4dvVpRYHtJ1ahA4tD+3RyXwKbp
         VjO7hbiIzHYZq2LawX+x9mUcALbAy743ch0YzBgFIx3JKWt0HZRzqshUK8Taync2B3Nm
         2Vncpff18ovlDrpKfIjd9MJwpjaTuX08jr1gkMiHDdD4OaW0zqLVVmvnXUD5d/rW3SZW
         A4R4ufc54KAEPQT+CmSJOd2ygH/eP7zEsGHNNdpOZJt3YpyLd2D4VcxB+Zf5soRVLcY9
         tiR29R/WFPUGBi+kYlHrRGkO0CYAur8+15JzUoTJwsWlH6pCru8FAWXVg0e4S3lGO9Dq
         Jl2A==
X-Forwarded-Encrypted: i=1; AJvYcCX22AuZdyZak+y6wqvF6y5mfZrA/ZWKLXGJhDrQXKKyifqjysiVxsZOubhsQomPaE+Vswt9OWVtMBQxn2Y=@vger.kernel.org, AJvYcCXAjGdcgkwu6QqEYXJfkwgPVfYabPaMlOCFIJ0caHY7rG79aGHqPYp7sV79O0ba1DBTSYOubn/8EpJEaGx+GP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBkn5Q+B67UIBsgXkKYSK8V++g3Q2N3gEWc3kasQLIHjipr2v
	4pK/RaI1YCk99YjeGBNKc03mgQ6knpt70Q5/5PLWUkpV6swXyO34646rCecoBEsMPZzho8kWVoc
	hGvHvbh51rDxnOnU2zWYlG37zTTmjvqk=
X-Gm-Gg: ASbGnctun3amLoGrPMIm1AJN+JxkhFpZ8tw+FVArYBvqhppXcVLxc8WJ9aELOlFbAzR
	36G2uiM/L68GjK3od7eZ/waIoCYC+rWT3MfkA2v46r9QXwcKI2w4NToFFzXHm9hC+xOoa25Fe63
	dtzzCgwTaTuEOojqYqLr9Zj1RYoZfcfdE7vvPXFA1R9/lsi5rtKjnBhhLiUZsWM7IMTScu84Fin
	ri8wAtSXf/v0zalCMg=
X-Google-Smtp-Source: AGHT+IEuGXufeXJN9bMObQp6jtSAYdJYqpVKoAURpO4xc6KAolWmA2we5Guh8+1nihduy91vBpbyIBJzf1O5jVuBvGw=
X-Received: by 2002:a17:90b:540e:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-31c9e79d3dcmr8495644a91.7.1752958500054; Sat, 19 Jul 2025
 13:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719183649.596051-1-ojeda@kernel.org> <20250719203646.84350-1-boqun.feng@gmail.com>
In-Reply-To: <20250719203646.84350-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Jul 2025 22:54:45 +0200
X-Gm-Features: Ac12FXxHqmkSLKpzkLvxms1iOKh3BC29spTi-sHdm1FLOjvWsRSZaYRN3fJIK5I
Message-ID: <CANiq72niUM8YAiVWooxAPCy3c3Yqt6_1fjW2HN7TVLnmL_GQMQ@mail.gmail.com>
Subject: Re: [PATCH] rust: list: Add an example for `ListLinksSelfPtr` usage
To: Boqun Feng <boqun.feng@gmail.com>, Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, I Hsin Cheng <richard120310@gmail.com>, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 10:36=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> It appears that the support for `ListLinksSelfPtr` is dead code at the
> moment [1]. Hence add an example similar to `ListLinks` usage to help
> catching bugs and demonstrating the usage.
>
> The example is mostly based on Alice's usage in binder driver[2].
>
> Link: https://lore.kernel.org/rust-for-linux/20250719183649.596051-1-ojed=
a@kernel.org/ [1]
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-4-08=
ba9197f637@google.com/ [2]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

I sent that one because I am applying Tamir's series, which triggered
the error -- maybe you can put it on top of those?

If you do, please note that you need a couple changes -- I will push
them to `rust-next` so that you have them.

    https://lore.kernel.org/rust-for-linux/20250709-list-no-offset-v4-5-a42=
9e75840a9@gmail.com/

Thanks!

Cheers,
Miguel

