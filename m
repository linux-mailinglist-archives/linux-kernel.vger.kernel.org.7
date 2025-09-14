Return-Path: <linux-kernel+bounces-815924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D5B56CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA6189AA48
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039A21E1DEC;
	Sun, 14 Sep 2025 23:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwrEDDwU"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03AD23C50C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757891981; cv=none; b=InylbV7yAybitZ8mMl640NhEcV3xVwy6X5w5hSu6iAzOX1hWesZ6ffk8KUDzYqDbxSNSihb7NuT0APIa1KYp0ymH0SKFdl7C1A8MIJ8ZkHUQOsrSuOAY9zASncyHqGq923olrZKOskjp8Tyedxj4Y5HXhL5FbQLvPRAF6YQIGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757891981; c=relaxed/simple;
	bh=pHXoHH5RRUugrHmOu9g05vKyxCyEE7WNLmye7njoGms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gD3GSvR+adR27G3j8DdHf5Oh6ZdoHWxnABoiO9ecQ5VqSPNZCsWS+Qa7zJnXde2qy60pI81mj0TjVY69Xiub8DdnoN3PseS7lrvHTFAXcnOWgF+WR0cSIPOzEHo4HB+UDTTZURPFhCHJbHd9KoawXC0dLz9FMgK5wECxTQbUFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwrEDDwU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-25f897894bfso3832625ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757891979; x=1758496779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr1SRhKN9RJNHAY9fHUf/uZeZSb2ann41OGAwqEckBk=;
        b=PwrEDDwU3WQ5ezDeqxpBM7emjnq2AHFKoJwVFfGX+e0XbuyoT/9bFS7ot/137z1u6L
         BT6hN1QPIQmBQQyUe4fzYpOcrdAR0FW4IjSApibK7d9AdBghstvPnysw5lam4B3Jg51w
         oFJsCQJumHejz23F0RTq0GrE8x8J/HIs2R2R8WvDofYOUafED4tWdyjSO/WerTz+bgdK
         scoDXdqZhVN5bzXYW/srl7I4Q6mdVg1TIdgpCmUmhkNdEM6YaAA3pVQgNEdu2cSg6J8/
         9wOkWYvvXm9apTyf70oEWhjKba3Aa/cHRm+SCLODsIhLUOSMQ7Z80ahCq66AiM6cJdfP
         XPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757891979; x=1758496779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr1SRhKN9RJNHAY9fHUf/uZeZSb2ann41OGAwqEckBk=;
        b=RW5gh347yZOIQugK8ifmgf1DOzxd/A2QU0pJzB0xANppT3gXydArCa+58tMqikGt2J
         R+QojHl217p77VWNoRLcVLMuzacfvw4GkYb9WaJrkHHJiS/FI3Ztk8IxbF+PCkr/5Y7B
         YTm1JtXWPgjAHUZ/KgFpNHeQXMy/lqL4xD+M5CvKhwvlSLGbqPTS5e+WIMGpXfzYtnNB
         2oSwWy00qjJ9MdqJsaKlb8dQrhCTFRjBUvNJP1+SfXesM7wOlAYYfOh38kxKZ/1uQqcZ
         EjRjmbbOq78qhkbrRt13UAL1P0qkdmRWqpd9QYmEmLULwZmOt/Mt/ca5ff05vsp95jNa
         NDsg==
X-Forwarded-Encrypted: i=1; AJvYcCWpHvWUB3LPUujTl6kscQ/mdGr1KyuOOchHebOwLwz+Y7HmRc460doFXNq5Ddl3TZ6j/XhC7hYezgIyqn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYSeD1qiBvHu9YpyY5vPMzZytmx9ZQEVOx/ZVH3FPaj6ogP/m
	vZX208z+VW6+4MZUsiRE5UXHHV1QpV5YibnOW91iwWxIxfz0Dl6j2s+O4m4ThCX1jV1PfqC3Z6D
	653XQsWFzdJIdAtPgmzO3wiTey6GAS3A=
X-Gm-Gg: ASbGncvn+ZHsi6sJgodbmN9i8izuxwEwPAKIEGQSwSPqCCwwWg/ztb+lfORFPTu0QWm
	ADSbtP8HmremHdjDhnImp9OLWAK8bis8+guRSTLOextmyhFXT7KeWKPMv0joPDWVGlw2xIXAUX9
	m1sHdcKwhe6AOEsnERnz5ZTPs2Kxg2CA9FsZ3apGtGfC4EekILFhyR8xppzNkd6tyGR5hHxJHh0
	J0lPEtINs35suzANGNKd8AVSOdCA/thB66/SxCbrkOLb0n1jKUy+ZXjy1sHpVBfxv+bkf8/HtCV
	9h1fa8Q/yFpuZmr+gr5rNpRP1A==
X-Google-Smtp-Source: AGHT+IGhpkmNSnE/555/rmLedmEw7I+1SCyv5XhUvG9ewb3MUhstOJJKEYHDfT7SRZL2g28uuiuKafYeYRMNCxOJ2uw=
X-Received: by 2002:a17:902:ce83:b0:265:98c5:3efc with SMTP id
 d9443c01a7336-26598c54355mr15027375ad.9.1757891979049; Sun, 14 Sep 2025
 16:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724172005.11641-1-boqun.feng@gmail.com>
In-Reply-To: <20250724172005.11641-1-boqun.feng@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Sep 2025 01:19:25 +0200
X-Gm-Features: AS18NWBLpcVZaz0uXp5qhEnAAfVLnpu8P6jVe1KdZV4E_JnrY3DZ1aw-Ou0NaW8
Message-ID: <CANiq72=5gPRSFEDZCL5kSiinZVJCFd6UX+vzkx+oM+AvotCXsw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: list: Add an example for `ListLinksSelfPtr` usage
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, I Hsin Cheng <richard120310@gmail.com>, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:20=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> It appears that the support for `ListLinksSelfPtr` is dead code at the
> moment [1]. Altough some tests were added at [2] for impl `ListItem`
> using `ListLinksSelfPtr` field, still we could use more examples
> demonstrating and testing the usage of `ListLinksSelfPtr`. Hence add an
> example similar to `ListLinks` usage.
>
> The example is mostly based on Alice's usage in binder driver [3].
>
> Link: https://lore.kernel.org/rust-for-linux/20250719183649.596051-1-ojed=
a@kernel.org/ [1]
> Link: https://lore.kernel.org/rust-for-linux/20250709-list-no-offset-v4-5=
-a429e75840a9@gmail.com/ [2]
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-4-08=
ba9197f637@google.com/ [3]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Fixed typo. - Miguel ]

Cheers,
Miguel

