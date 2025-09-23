Return-Path: <linux-kernel+bounces-829658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D02B97920
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0DA3AD1E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E230CB33;
	Tue, 23 Sep 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHGwRrl+"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD423A989
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662989; cv=none; b=uTg/6VS/IsesCDEI0qVVwzQvgyW4D97xErHL/EWFGFeeNqsxC4WishxALVs0cZi5Wzrn2UicaPvxshf6bVX2yeBzQp05AQp0Ep6C1uJ17T3LXJtvFSfm1A4jdSVwX2k7kNZFn2gmtU80djgpqDFvDZDJ7kmX5Cu/jDumqbN4MwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662989; c=relaxed/simple;
	bh=klwPCi4puQ0zuDEZyWWCXYcdBGsO/A0fjywC3l40eYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQGk7q2j6BQEAJPRmn0Z/3Lo21v99IRdH7CP6B38P+hQiNaTKwU/32gy5ZaQkge6uH24xhrtYxODeK3aiGvTQAFGWrOfecVcanHfe3Lx2EfAqjnLJCQOpRQYHaouuu1I6ItIx9lgxwGPA7S0nKBDNldpk1H/z8p2Gj3ZXiuZ9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHGwRrl+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-333abc4394dso103390a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758662987; x=1759267787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klwPCi4puQ0zuDEZyWWCXYcdBGsO/A0fjywC3l40eYA=;
        b=hHGwRrl+vRBIDsXW8Yw2H3AsVLKcoHwqEz3rusLUH847L0K/xR6LURZHK7LCyAWcKy
         4/Ex0JtciQx4FgwTlh52fghHp03M4ZEPJeeExyuFRKOY3UF66a3fS9b/SYIfLlEbEhKu
         SnfwYZO7KfVQ/uNvGv+Lis7zUA2/LgZprAg16U8FF4YgcPYiCghtF+uZFr+dEbosuIZ8
         sMUyc+SKv9/ks/XndtdMfQbrPccQoZHgZB2knAcJa4wJgFwttAoJEJUh/S9UFy2WsWM3
         L858KQYn3PDzteG83ra2UBUMq+6MkdmxT6H56N+EAZWU32N+a3YQ3WJ3qKgexG7+hEcz
         DqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758662987; x=1759267787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klwPCi4puQ0zuDEZyWWCXYcdBGsO/A0fjywC3l40eYA=;
        b=c+zS5gOo7f6kKtyJsMHVJOlq61Q6+scz8VFIEcy1mhMJqKiPj7QlSobOif0CredqQO
         la7zCh8joMKUzlAPgsVyW0BgbtF6c1Bd1wK3F4GC0zwf/5WR4UEgpToWygRnap/4u+Ch
         qb+gPs0u90M0gb77/0QSEWdOODTrTllemEucBjBjFhB7rKPjHFrf7RAthF9UlCBGxLJp
         751xAY8CbwGa0zFGz8cuYh3Hv0i43q/SGPcQ4CsO+RMDTTru0tSq8WDTN7vYnRyFb7Z4
         fpCvINP//1KLMKQW0lEoMZIsfd1Ow3HXoX1zfL75sODdgh8Yustvn246bOprVwlIMV6D
         2Lew==
X-Forwarded-Encrypted: i=1; AJvYcCXpkcNOzyoIHHsUUU2Q9rKlQBT7PGx0Gvv695AsvTxV3VBlMOjmz6f1CbQD87gf1zUEjQ4UlHM5ndlj/2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jKoiRcx1zn4GVJm6ryDaKF4wV/tFjy2FgAKhKqI1dT00Bgr1
	WWnAPYyAtR4l4AJ0RasJOPP+lcEL0N18iA2gi/y4CyBkpmd3Y6F8+85M0T2nws0+bubCzZwdIr7
	01irM+wzrQIBX7aoMj8+Cs2IdGXF9a78=
X-Gm-Gg: ASbGncuMEtajCg87T92CjcYRqIW1Nv+wV2x05MIXozJbT8H3jCHT1vRzh+2I4S14wxw
	LO4UHSp4RDz1bhdJNaDT8UfdQGM/2n2Sfot2N073AVnk7I+eYTkRYeWHA7ibaXV+eaaIL5kcPRz
	CSnAlr5jtn9O6kn03QcWOPH55Ua1jkJVV6L9e5pvX8Jh6srChYMAm3khCCP2gDvzepsdEbVaDZK
	B109xUmN1qrNmM3cbpc2mgpnYQYRC/ZAtlX33puPkmqnCLyDfm54ykFiN96VqzJnrsy5dxiAxLs
	2u5GoFE8lWhwGkDwB2medmF9LQ==
X-Google-Smtp-Source: AGHT+IHm3C1GpBA3VBrZexjxAHTLcQA1zEDuqcUGIlepgOANCbpnx97SeKPhu08lBO/7UGD9tgSCkuBSZ0I0ZfqhRPU=
X-Received: by 2002:a17:902:fd4b:b0:267:bd8d:1b6 with SMTP id
 d9443c01a7336-27cc5de0da0mr19480475ad.6.1758662987013; Tue, 23 Sep 2025
 14:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092338-elbow-dash-373d@gregkh> <CANiq72k4VG4UMDJUUfD=LNM+tJmvceNDxG=A-+6GDjLzCVXurw@mail.gmail.com>
 <F14B2B5C-C361-4670-88C0-61A1EC97E630@collabora.com>
In-Reply-To: <F14B2B5C-C361-4670-88C0-61A1EC97E630@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Sep 2025 23:29:33 +0200
X-Gm-Features: AS18NWDubd8RGsH6mIJhWBKGluo4Gi2SmLUql2vcus2XnvSic-9i6pFMqT971zY
Message-ID: <CANiq72noNB9ctcj51sJ=vvw6PfocgWRAD7sxBJHAfbNt9ZcVaQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:25=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Yeah, I did not add that on purpose. What=E2=80=99s the preferred approac=
h here? I
> wonder if we can add the Rust files to the USB SUBSYSTEM entry? I can mai=
ntain
> the sample driver under a separate entry, for example.
>
> I=E2=80=99m open to any other arrangements.

Up to the subsystem maintainers, so Greg in this case I assume.

In general, maintainers may want to maintain it themselves (thus
adding the files is fine as you say); otherwise, they may prefer to
have you as co-maintainer, or perhaps a new sub-entry with you as
maintainer for the Rust part, etc.

Thanks!

Cheers,
Miguel

