Return-Path: <linux-kernel+bounces-883041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D6EC2C55B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3171897A45
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C9311976;
	Mon,  3 Nov 2025 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDnnWtQs"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFE330CDBF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179016; cv=none; b=jV/COZ4XDamPXwtLrzVybcO/pwCy9bH7nuWJrJwrl5rrGWRBQLRxKrIzGqZk6QQ0cwWv9giZTERpX5BmE8TdgLw+/6jp8iatvJRBCYFnIeSrbP8Q0TSVmV5bx5Q0yLcwjO6c8Cm1V+5mB4ebnp3B1H1vOFsndq3CufKigQ7HVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179016; c=relaxed/simple;
	bh=/MSFS9mN161JdJ6hiSa2/SgnqSacyhFr/nNU6+KwahY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bio6O9R1FnfwYwjOJvJ6lCFSvxpJ9SJ1znQB220pB6hYH3Hh4eN1v6ITyBHqt3m5DZlBXxZU5G+xlSMY9UvKIXj3HaMYVediILOfGgidhplaSIGGdXJNmGEgUL0GtWsIxOn0yGfsX980QrKlKKWLs3BPLafyV06snRPOtoaC4jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDnnWtQs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b9a5f4435adso201953a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762179014; x=1762783814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MSFS9mN161JdJ6hiSa2/SgnqSacyhFr/nNU6+KwahY=;
        b=mDnnWtQsFb7VhhmJjnaQyHKkRmqtLLoGSuYi1Hu6KjDt+Vt2J3twNs7xkYdzeQIuc8
         8kSeYrlgYUOHNFV4E9SNOJBTnCEGWaYnnf6fKIcuOcKc2xwnlREWIXkZdAvahcUx5JIX
         lbaEOSpkXhz1qcgS+TuEA4oU464Wz3SmFlIcxAYaXcS0YSxC/OXHq5B7fiaBCbKVXxyT
         yegzvoWYeUb1Nl3Bhtg9Imf1n5Yeod1YjxjgJIt/5qH2bUQmbzg64/Rub8vqex5f0k2+
         4rPgXpBzd/DiDxhQ5UQ5joS0x63kq4/E099IwqKPJk6RQcmPSphs3y975TbYeu2uR6A8
         t77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179014; x=1762783814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MSFS9mN161JdJ6hiSa2/SgnqSacyhFr/nNU6+KwahY=;
        b=rY5qNfHAq6ZYgRO7VaM9vt4jal8UYrQYlhUcZ1ui33hWCZATt5EDgQVFtqMG7MXWTY
         icoTAvXEcYGfrghQajmM/MfliBmjJX6SB8h3tyAX+ZYbWu1c38AvXS76l+HxA0mUjSzE
         3htp3KgR05U45iMdxQU1WqhVKUfSgM6UAacORjgOvLESkaF/ZqFsZKQ3q7TLj22lFx9u
         6Kjygs8P2G0WvSVaHtfP1N2YiQxMuhF8k7p2BVcAg3MimqNb2zGrnEObaYpDBqUYORZ9
         vIQbtkWNJW/M+xAu3YTJIloPU12ffPh3mABqx7ese4rk/i9KpCBLYzXw96ZJZCi3DMfr
         jTgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxPayIz6cnPI2ynOh2PBTOKWd2ziVz1uawV02BK2c0f2XVGgBV/5YDWNlYCoTjtNH+iJhS1Q1HdPrd2q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYRi1my6T9/NDLA24H8vHM49ZCh+td3L1sxszQmTeL2as/aKOR
	IPmRMYyffO8S5vdY78giJWElPqegisDNh8ZvwhlzTQmEOy/IZEDnWTeifSB0rCzXOtBK/X6Y5EY
	oFmkr6jDWwfG9HkpgKjeD1Yk4J6yaKHc=
X-Gm-Gg: ASbGncsBwsgrvKg7E9ae+kQ0erv0S79CKmAnn2VvUIY2dzZJNm6mtpT8RUKp4k7knSx
	3qizdNmuMWsIsHn65YBweigwRYI2vF39w1s9bkfZ2bI9rR/BGKcEeCPt8F81PGhtAPteM0saqCR
	Xw0hjYJWME/+V31tw+CjfdBBtJRycK+53+ZCkC6Ug7GhT+JUOIC2+wSDYlONtLsFor/15/QkqOf
	q+MKWSBQM6oZZzQbx4YHg3u0sN7ArlMDSalT2Gv759bKYD4XbO9TkbZuJ+FxGREWN5G2e5fzANQ
	avXw+X4V2OxZKlq0J7TM4JjLQSWEyYHD5eC6hSXU4nnBTSOZqida5Ji6fEkBrehISbxwbQZVVi4
	lB2ZiVCEIJpC1Jg==
X-Google-Smtp-Source: AGHT+IERZ1iyJZBPeT0YVQfb2PVMv4VFMRw0yRH9plwNDgHK1xJwSS9mH2Mrbs451CWBH4ib61IvfZSbmjYWHG0a5Zg=
X-Received: by 2002:a17:902:e891:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-295558d2f6fmr51352725ad.4.1762179013733; Mon, 03 Nov 2025
 06:10:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031-bounded_ints-v1-0-e2dbcd8fda71@nvidia.com>
 <20251031-bounded_ints-v1-1-e2dbcd8fda71@nvidia.com> <aQgQv6F0Ao4DH6U0@yury>
In-Reply-To: <aQgQv6F0Ao4DH6U0@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Nov 2025 15:10:01 +0100
X-Gm-Features: AWmQ_blqWQMEWzphBo6SNEUKCAPDaHlP1S6OkyILvvvtbDdStxg5wvCs5HYRH4c
Message-ID: <CANiq72mg-NntJLf_jbigz++0hK7G3WAxbvejRq1EzOc7GE+doA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: add BitInt integer wrapping type
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Jesung Yang <y.j3ms.n@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 3:17=E2=80=AFAM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Rust _must_ do the same thing to at least be arithmetically
> compatible to the big brother.

No, Rust doesn't need to do anything of the sort, sorry.

The point here is not to copy what C does, but to improve on it.

In particular, we definitely do not want to have anything like integer
promotions and arithmetic conversions from C.

Cheers,
Miguel

