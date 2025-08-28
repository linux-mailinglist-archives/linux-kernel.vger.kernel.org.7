Return-Path: <linux-kernel+bounces-789868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B2DB39BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698153A8781
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64ED30DD12;
	Thu, 28 Aug 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbz5rIYv"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B910205E2F;
	Thu, 28 Aug 2025 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381557; cv=none; b=Cj3U+xb4AlSMJf8pszq8hSeB8vA2dE0M0qR8KYv8jhK3sCeB2m4PNMSxY+JSd4eOPZv38nELiUJHonl2VFyJioLzrMzJ4KMPMjcXwDuRj6FBBtRX4PkpEF3/enGgFqqLh//7DX64L4ZauG3Xl0R3k0mxlOnI4uQf/o2ThC9saGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381557; c=relaxed/simple;
	bh=I2H56yO/8NFGXQtE7p7bHZ/o1E70dyX3AMAnCJlBt6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtFY7NR7o88o6dQXqb8LprVzAu4XpcjttTiYWmaS7hXh4JJ/STPeRhnPPPQ7BhPC5ultGMn3X2jCcU8Po3WPAU3zlGJjDkfV5EKIgs7SD4qn+haDZ0bOeUGtWScE9wnCpuhPMx67X2Y/7PXNx0/0UqVw1gx4jz/6Sg9YcYO5tX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbz5rIYv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32749113e0fso136830a91.2;
        Thu, 28 Aug 2025 04:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756381555; x=1756986355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2H56yO/8NFGXQtE7p7bHZ/o1E70dyX3AMAnCJlBt6w=;
        b=Kbz5rIYv8fnYnnRBCquiJjZHv3xAvPWEw577/0CUZg0+KJv4FqbiT57oYbFK0pq/i2
         QQTX3ex0yKd6VLYYPP/gzSdoktw2qjS5lXuxn2lYWAh9ETJmvBdoKbQb/xAN8BglLbHo
         EMp0z4ra24yGCbg92atgEbpouG1Hf8f07STsA9JP6U2+kSNvGwbu8LhSdMyFhL2ErZ7z
         ppOO7ufekGx1BVs5VH+9/u8YIj7w9T/tDN9Y1DViyWU6HyWbsqkIkSZjIy5l7D8fzUuN
         JyNiEhPrE5GKedubD/fI1YiePO70IOiMdOn9+AbhAvKxmwCGP6uXWqwDnF6FWZidf9yI
         jzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381555; x=1756986355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2H56yO/8NFGXQtE7p7bHZ/o1E70dyX3AMAnCJlBt6w=;
        b=t5b4KopknMhfIDp4uy/vU7KbwrKXuQAZ3vMhNkMV+YxvIifR4MrS79v62yinCKRYGW
         c4A9jEewdUxFfhd4sGkGjsKjYL68JAfsFnK0r8uMJaRVj5cUuK7D9Q15oaSwv9/12n5q
         RIstU5D9t/D+VRESZSK1YXQS8dTElAZQi5hRd2PC2zuTPyMryTpphk5lTRoE1q5fr32A
         flM8ia1n5ikqy5ndPsfAQhSqX04FNNyqfrSPyuWy/wXw6H3SIVVBBzhd3KwHo1EfabaA
         z4xzSLGzIjZDlQ3dsJ2pCINm3oXOuybgCUZkAZagWQ5OKPI7K9E/zfd/yec8rQOiu/kj
         Z9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV5p/iYKoPMYxavkMSS9o/WyYRGt+cRZ1YNaLBJJ7Jz3rHkfrcT3SpfTfx41jaZ9Y1ESGOFS6TIzZSjLFA=@vger.kernel.org, AJvYcCW+L4jnM0ma22RszVOAnWQNTnNNxyXIjCbu0IEUHoOFUOI+wRuaRurVphbv5Kx/ctyADVq0/6FlVbyhEzr7mNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+e+POr+KK/8Bs7IO5dWY/jjAh8COt4orB68Fkd1pNTinQz99
	Y/2/CoyC0loSoJr3wvI6kCTKZ5ld4Pr4GVEa4g436NFAiLSd7sBbm+yxh+Xggq4D9fDCmZ0WtNc
	9bi99wu6f/Q7KFujndgjo9s7c+l8nhL8=
X-Gm-Gg: ASbGncvc1CUtQhcNJ46GVwRgU9HfGxnkcKhU31MAMN1fMO7CeuXuWN4KXMllZVYkwtt
	CDwSfep8e9XUHCXT7FixXXkgiJHcBZsSFipYklgLqkhraHyrTja0XntT1froU0ACCxSln7L8+BE
	YQzJ1dVuALdUd6p5eVAvMelzAoygn2k5kddb5ybQ/UQTd5q+v4q+COyuAqRsLjYJNr/LYaBPBTY
	XPwbQ4EQTaKpiTvi1MFuGS38FqAK5nSfA4tyvQuJozpSq/3pkYBEZ7CSoxbyhIlPJRwmIya6uJt
	30ajYS6V7SkPs79hH4JtxXRwj7wuwc4SDHk2
X-Google-Smtp-Source: AGHT+IG1ihsWTuJC99RCEFetl0OaKKf7I0MSOaGMg4ugbXGYCXUCMWGrBO89xxuGWPNGJExxHbx0h7dAYm9Df/5VgN0=
X-Received: by 2002:a17:90b:4d01:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-32515ee8b50mr16448907a91.5.1756381555273; Thu, 28 Aug 2025
 04:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <20250826-nova_firmware-v2-1-93566252fe3a@nvidia.com> <DCE0VZXSP39I.FKGHKONUTB5L@nvidia.com>
In-Reply-To: <DCE0VZXSP39I.FKGHKONUTB5L@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 13:45:43 +0200
X-Gm-Features: Ac12FXzDZTEvSN_jSpG0n7-NSUbagH20PpVfLwEy9ehcrmoj8GVXqea9N91DQ_U
Message-ID: <CANiq72=Z26jzVMbGfqL-_Wq8boX5qApmPCVGA1D6cwzOxgWWLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] rust: transmute: add `from_bytes_copy` method to
 `FromBytes` trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 1:26=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> We got 3 Reviewed-by on this patch - Miguel, are you ok if I merge it
> together with Christian's `from_bytes` patch, since they are closely
> related?

If you are taking this series this cycle, then sure!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

