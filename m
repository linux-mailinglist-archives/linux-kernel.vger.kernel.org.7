Return-Path: <linux-kernel+bounces-897140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B4DC52216
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5832F3AA591
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA402313E30;
	Wed, 12 Nov 2025 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGuhsPBd"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E729D31354C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948258; cv=none; b=hhv7xlpfJfsli/uOziR1Lhnnh83hZB1VClCwyTbut2zAb7q9vmh3XBLqlf0oEWOMMdnXMPuu/dtyUM5HOmieMZWtj41YwFs4iOTvQBDV/FRWE4XXkSOhjNCXg8eTQ9eB8quje7CXO+zQ9U1Q4p2Y43yvvYosxevTQwcaCxhhsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948258; c=relaxed/simple;
	bh=xvlwHWf1SMuF3y/TP+P5AIWO7Uq0VOvUIReTHrd7u0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3z682YP8qFTH6Cm29nUTorsf+aW2Q1fgCtQDB4wXe7VrQpFskDuVMLzuG2NR4DId9dHpaQS4HYAqVw0vf4qRFrRbAhFrt+2X7caoivHVn0UuOKOy9w0xx9TPyUnIHiakkO0V9jblU9oVx5rTeDe7Bk6YUzrKFWGpUXS4jOZn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGuhsPBd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297ea4c2933so588325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762948256; x=1763553056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6GdXqVWriU7YAQ5HMP7u4HkP5SDJbJWdJuWZZSvfNM=;
        b=QGuhsPBdZE9cQED307f+SafeY914FbvXj8POsaolQcBzXmMK/4NtLBVc6Vp91LpGfY
         RBhqDkPBpyLtL7ktt9cJ1xtBlckGcfG8mv0lCXDyAaIleu54IiHZoyqGHQO+YK35csyJ
         rd+A9YiCqRl55BCEnPwn9gJXsdKA9WO9gwxDjd5V+o1xUItzW3QOFBPKYMVbf5X8RzXs
         TvGw7bqxIot0UennmR28YRVARIO65YDTZ2OwVfjv/+stGyHyQOexvEiwM6XdjkWzC08D
         LJWFTwwamr9qZNpVdmv3RhvFYzWP3b6WyGUHBJNg6FwlQfaSqM9TtBhy5je+SvAuNL8R
         SCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762948256; x=1763553056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6GdXqVWriU7YAQ5HMP7u4HkP5SDJbJWdJuWZZSvfNM=;
        b=nwtK45UAZ7R8xtb3VI2OaeYHYYVJEzlhzIoQ5Opnt/rYEmB/iWAPxxtrf4Cvn1ZZ3s
         9ZKa1YVFugIssCjatYNkWiCC5FcfN/FfZ+9tAcls+eu4jsYGT+NVaqjTRdkUkGU+Fg89
         Ath+IN9h28DR7MVe4/E8511aPSVDiuY05YR9WyktzQP68R0lHfVGh1W9e1I6IX3+xLyN
         F2em4a32igHrhBwWvLeAnlW4e5VU2Jcuy5zoTuCGE8bLkFJWuRoKvCF0pLQxeKmXD6KJ
         uPS80mcbt3lqa1Xi8D1r244uyaB30fonEomWAABG/K1rFvBukanGjT4pvCUjxTM+n8B9
         E1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVo8L2uw8PDL8AZ/gpTtuAlAN1wUmt5V9/XaJbyRpIok1BHDmC37+tOx4+GcS+aDp7d85RshNt8DrAHUaE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4F2kVUsDYxkfgmVsKHbu6KoB+8gRnz9RdLiu8cm8/iT+dI6i6
	Mdx1LKxuukqJPckcmaLauzuyJLzDXsGqaCHEZb72alvBzHbfWwVVCVBKPpNYv1csLUrnoK9IsQl
	0YTNbSh0Ylz8Q9RHEP0GFUVbJESdYTaY=
X-Gm-Gg: ASbGncumPsNWBJxtjv/+j/p2IxmYMWUGzJPMb6smNMyTRazYwNXl9RPWOP+TPflpwz5
	JLXkWgpSza9TiCP06JKm0nv8SiL0XorZ+9/FWih5Sp3fbCdM1qpuOHCTJpSa9ImG9JzI+sv7auc
	Kg1gsIvxPy2gI8jhCcOf571YTaKVRQPXNnNSVkeHi9TaWCArwfeuzs4fP14Ip/282hC9LFiNomx
	buVOzHConYAcEovw5I1cDaWD5BjEVUZAKd5n2Ev2d9Q+OzoZFb7ZEamgKPDOqShEAQ2TH2fm426
	JK0RYSp/CJwQFQ5p6gE3GJUM1QkzWOHSaHOq2LLMP954friX0R+gbDyTBzz1GRnkANGm7VClgXq
	PCq0=
X-Google-Smtp-Source: AGHT+IHJac4HVCmu5Dh9YFRTfhcVyqy3R7ppk8nIqv7Fjiu3amcoiL+MboK7bGpoZlkJ6T+p2bAicskCFHV20oVawIM=
X-Received: by 2002:a17:903:2343:b0:297:e67f:cd5 with SMTP id
 d9443c01a7336-2984edefd70mr18586945ad.7.1762948256198; Wed, 12 Nov 2025
 03:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
 <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com> <aRRgbZ67cuW4ZoBN@google.com>
In-Reply-To: <aRRgbZ67cuW4ZoBN@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 12:50:42 +0100
X-Gm-Features: AWmQ_bnHL2zcHUg9QHxtpIL6OkJJHQbSfHaurUXNslUBcWWv6xMSKUqjoGHiz_g
Message-ID: <CANiq72=5WDFCufEhLSnoSzUrTZ+dBwEeyGWO+OkGmdB5AyXqog@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:24=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Maybe later. Right now I think it's more trouble than it's worth.

In case it may inspire a newcomer, I filled:

    https://github.com/Rust-for-Linux/linux/issues/1203
    https://github.com/Rust-for-Linux/linux/issues/1204

Cheers,
Miguel

