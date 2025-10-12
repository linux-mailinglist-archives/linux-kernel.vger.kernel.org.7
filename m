Return-Path: <linux-kernel+bounces-849643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C5FBD0921
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D8304E17CF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4352EFD8A;
	Sun, 12 Oct 2025 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOwgGBbw"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB5F1E3DDE
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292095; cv=none; b=gO+0j4oRDdNm+D3XVXa7RHkWMb3pndEiHFKtawvOZNTefjfZRKFeNgQZLdmCqYfa3lzg9W9IpR7P2/GDpwEKf4jIcoDNsi5EZJxXUjT/P2MLEO6iF/SMc6Hw9aMyFqK7Z1ozFJ1A+8CqbU/hL2cxUAvcM//0cNaN7W6gWZu2iTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292095; c=relaxed/simple;
	bh=4fayUwMhvNCuwkW+8rNVem+fLCn52jNvzMtaSiWAkLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjv6DUbxa3Webp3U+2Mm9VNdYDGNKSwtLhk9wJiYRPhtKOj2uphHuLUXqzkSksvx3tehLQcmzQRlKiN2YEriOngPJhOE357rOUx5MBkCobaf73qJd4QlxWRupIU3w7m49pngM39oJEbXxbPHVQjYEVYuAarAYOkxZjwFAGdRgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOwgGBbw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27ec3db6131so7812975ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292092; x=1760896892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fayUwMhvNCuwkW+8rNVem+fLCn52jNvzMtaSiWAkLg=;
        b=KOwgGBbwqNWEeHxP/ZMjx2TuWDiRiVnut5hGcNGRblR4r7qC26m97EL0/LM5DwxLLx
         0+ASJqz9LrjseUtmTtV903OQyg2WH5bDmo5IeaCLY/dHK+8BRnVNGQFreiTHQabvrq5Y
         QaOh/o7K+zojYNHDBNVAP5Mwl1N15Olw7cCdVXbez1SZ2BgaC9r/Ynvr1iNlSrqs+5sv
         gEad0pnv5ldo4tYa4wcMuVbJSC388Z/2Pw6Q0ryBXBHeERGKFlmOvypcqy4TNx1uPXjS
         k1EDkgtDKd1V2PWQuxPrQd2mBO//nSpGsLrWQVD0Hr26lMMbA38MeqzwrLYShX3VbTcv
         wFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292092; x=1760896892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fayUwMhvNCuwkW+8rNVem+fLCn52jNvzMtaSiWAkLg=;
        b=KUkPG7xFvznxKd0WnfvhOOT4iPKBLiv5xOsXK79SnwmmmNrEtWCinlwIY+wWb+T84h
         Kgq7yC/cYBGSErILCtmw4yA07+TIHa8Wes/douLsytuFW9+9xYPFpRt7wTnP1qdWfDjy
         3TKadk4mRAHRSl1Pf5ksvkQjwrMfawNveSFt8x9mEcY+xUnUOwJ05jZA4k1pp6TgQBMx
         SoNe9wbSSdzQbFvsCTtnE2fVj2u8NFR5S9bJyuGrBtvhhzvMncJUgZl4KjoaXPZfDpyt
         9etwM5HrRngIeW/cuKRaid54qJVgBxUyR5n5jbJ4zadgiIiLV8tm6wD1e374JI7wiZYn
         9dbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjYZTPCkoyMVnL4DmUt3/WB/J1AFqghXFSaHoExmt3ADWQBSzCHsbkVj8AUWP95Wb2pK/X8jHBSpbBlkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41/JasDA0nDONIHHFBszTm8ElTtzeM+j5J2lpC3c7ctoLJBvr
	qcooK04ZO9nubNve6cES8O7YsGhbmrIB1Vg26EEQTgtOQKAhJj2/5O4OmRA2+P++QBxZEsmHTpW
	rrqC+2FdpcVM+FMOdfBrK/5oLZYM1vao=
X-Gm-Gg: ASbGncv+rZ2TuJj8y+Iwt71VPLd+oWgOtTTfrMVkmMfUKlTHOpuweHVr/ykgnWM6pkX
	dBjwXrSZ58RaZpRPjEbFlByP+pdqriXsnp4shDhxynabiNyHrsE/VVhs+OrmHHHXEE2hTsIAn2M
	je6cPZqv3wCy8eybe24Kbf0BagQOiHOkMphXMdr9E+YGenOMzC/zYFg2g0c5JN81MR7rE9EmHTV
	CrAwmFi+boYh8K33E9wmNCqNClDeJSneFADG6prXXIq6a22b/hgkh40wmBgOeWK926CmeDN2+PU
	QcV7wxad04Lis2CL0+GFa5r6T4NW0UiIp425kG65PUv4
X-Google-Smtp-Source: AGHT+IHYH8KB551DFy/1CS7sVwLsfOMU6Z0zgv1Of6oPsAllrb8RWF6/5SDkS+dRRNp5FM5qU9kgMEXU6hEBhHvJ/v0=
X-Received: by 2002:a17:902:d2c4:b0:273:a653:bacf with SMTP id
 d9443c01a7336-2902725d2ebmr144860115ad.0.1760292091934; Sun, 12 Oct 2025
 11:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72=ox809CAhMijbvxvy_-tx4QgJ=pGbbWfCcZR8J8XFrkg@mail.gmail.com>
 <20251012140451.155219-1-shankari.ak0208@gmail.com>
In-Reply-To: <20251012140451.155219-1-shankari.ak0208@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 12 Oct 2025 20:01:19 +0200
X-Gm-Features: AS18NWDeTKrh-JDZioC1DogND9yn9-Ck_Lq9XxawqjsuxcO889ag6EhHA-dF5Qk
Message-ID: <CANiq72=hSTpAj7w8bvcwoJkivxD_FPKnx9jD6iNvhsENnnXBzg@mail.gmail.com>
Subject: Re: [PATCH 1/7] rust: block: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 4:05=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> I'll resend it on top of -rc1.

Yeah, please, thanks! (in v2 I think you say it is on top of
linux-next -- did you mean -rc1?).

> I also noticed that several files have received new commits using
> types::ARef or types::AlwaysRefCounted.
> I wanted to check if it would make sense to update the documentation
> to reflect their new file location.
> Without clear documentation, it might become increasingly difficult
> to remove the re-export as soon as possible, especially as more such comm=
its are added.
>
> Let me know what you think.

I think it is simpler if I apply (even if temporarily) a commit that
moves everything and removes the re-export in linux-next -- that way
people will notice when they try to introduce the code during the
cycle.

Cheers,
Miguel

