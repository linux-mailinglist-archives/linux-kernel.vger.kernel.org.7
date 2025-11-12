Return-Path: <linux-kernel+bounces-896960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51411C51A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B135189433A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C157302CAC;
	Wed, 12 Nov 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6E7gJKa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413953019A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942915; cv=none; b=pVuusHcUOIi0sUp98qgK14NSIkTi9XMK2YIEz/K2zmBYNviod4H+9vLC+WW/1DRYi0md9VVCv6NuVS5XsumlZba5fWkiYKCEJ1pZg+iEwWShzkdZ8s98O3uz++EHUbNl1hAWKzVIpR4zYVZzf/vdLLYsO8kNEOWZE738pzT/ME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942915; c=relaxed/simple;
	bh=a1LbZXoKqASbEUpN7+CIMVVnKdzk5okC7gkeCo+wSp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfAYLdZB5w6rX/odoGYgM1nctPg4e/RgJzCH2bP7gj0RXKyH+qYwkqo+OhSc8ftYBccMEqtpofpKi5itNeaLJ+e8aZEx1A1KSsdFBcAYdXn2vrhaOqQpOg88Zah1+wgynekMzgAGw4+s1IZ5/k6w1UCmthaRer7x7mgRPeNK68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6E7gJKa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297cf964774so705825ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762942913; x=1763547713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2Q8979WUafsHbF02hsz6ih8XON9WMXfl3cHVtdnFpw=;
        b=F6E7gJKaKWo8qWNzwWiazf17nyl7mlepSv9EzH41Fcj2QRl+eNAQUHgbiY/jReHdi7
         mv1ngTSDwAfoRRP0oUzyQkSwVPjo9MisANNMazYn86c7C/WWAsd22gfsBoupuBuesk4t
         SspKbkaxGD1aX2GG2CB/bV9m5KYjPcXZcrms9Bzle9fpqpzhO8JqpUdklyk+GAwr30dJ
         IRgkedogZ52v9Yy4TmDS7uXl/aTxbzeCAAKOioZTlvDmWqFoWQyrA7JO7GU9b5S9tie4
         jstxqQUy+O1a0rZfcJDdKO4mNuZvvU+tOVv3wwpZ6Mo+wsN7dWkJT7XK7kTW5KZAgln4
         Tx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942913; x=1763547713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D2Q8979WUafsHbF02hsz6ih8XON9WMXfl3cHVtdnFpw=;
        b=KlAd1vUdS39GprY4WniGC0+xRWxI3hRjxhgS1yu2aREULDMl4eQlIxvyx/sC51sQ1p
         krs9afyOpxQg+fExPWfOQ/o7Ik07KlPT1RESO68czP7YP05Nucf7zyr/suHeBaLhfZnL
         uc+bWu/GcwHXq6ZcQ895Lj0BoziPx5hWwvkAKl+WmD+7sTIc9cZ/qBGiJjbzEOW2OhEX
         ad5cm2n8iLThJ8Oap2O7dGS0kVTA0wifdpqlb8PxgQBemZSW9hJuJWniWi7FRj4Y+lKR
         gPkkP4l6p7GNpUIhTpA96pPciuzaTM39f9X2tFh/6yP4bMLiLiTjoUrEbz2MYrupRjud
         OiMw==
X-Forwarded-Encrypted: i=1; AJvYcCVTgQV1iR0iVP0IufeiPorW/elYXDFJ5P3ZTCHq42aXCtbSUQ6wWZOwSz+Fvh1GvRSIZ0hKmLTG4DkbgQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsowYcW60BeGCzfbHEoBuN7+FY3pYFrxutMxXtlynMn/+I5B+
	ie9dnSdHNtCdlGr/KWOA/7TT4/TXiBfJYp+Am1ueoQeZ+mgQsujmZ+8Rjh3HaJpaAw2gPcxZT04
	Tu20lsBRt7++rDYzotDWUS9G5PzmD7zc=
X-Gm-Gg: ASbGncsQGuSLqQ8U4jEf7f7RR083JVsvQXFa9JRNxkDz8T2IywEZ8WwmxR/Fx2vtYF3
	LwGrcy+PQwIFC0CNFXMHle1aZtPK0HlQekOjbzp2TRnnpjYaF6zIydzzhrN+dzfG5sRJLKA/RgW
	l4O+KdWaRpPPcYskK7Tkafiw9GlVH/MqzrEdK4MT0UHmEUgMDKWNM3MTI3+YXausepnI/fM+uvZ
	JKMNBXeweAqhO0dk2ilF0vrcLl4CB+w7vuMdoZ/zvkHCHjG1FN5mRPukKtE4lzC8VvoWdABuH+7
	+Okr6z9VgO63I7/D87EHZN0Do4ijKYkcWdUcFXbRJxFLDPM25GXVC8HvtD4ln27dwm4zuLq39Sk
	O2x/MNujvBu9VHQ==
X-Google-Smtp-Source: AGHT+IGmicDENKU7JiFKpvKuaoETjK/7j3jCXmA+p5saOFKLhmhJuX63oTyY/v5MtBwRvWCmwk5r79w7uF8r3OmPhsU=
X-Received: by 2002:a17:902:d50f:b0:298:371:94f1 with SMTP id
 d9443c01a7336-2984ed2b38amr19650835ad.1.1762942913408; Wed, 12 Nov 2025
 02:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com> <20251111-binder-fix-list-remove-v1-3-8ed14a0da63d@google.com>
In-Reply-To: <20251111-binder-fix-list-remove-v1-3-8ed14a0da63d@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:21:41 +0100
X-Gm-Features: AWmQ_bnHq9qt4ZLqIUwDgKVWFlRiETETpEIpC5CnP6lKPeTrcA2YHnmb1wWl4Lk
Message-ID: <CANiq72kR6hsr26gxOJp+Ok85ru50QqW-jXjC=cKDssUUchrCQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: list: add warning to List::remove docs about mem::take
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 3:23=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> +    /// When using this method, be careful with using `mem::take` on the=
 same list as that may
> +    /// result in violating the safety requirements of this method.

I suggested adding an example or similar to hopefully help prevent
this in the future, and this note is "to the point", so that is great.
Thanks for adding it!

Nit: intra-doc link [`core::mem::take`]

Cheers,
Miguel

