Return-Path: <linux-kernel+bounces-789846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E87B39B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D98463422
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2D30E0D3;
	Thu, 28 Aug 2025 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9rGY1ej"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355D4A23;
	Thu, 28 Aug 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756380408; cv=none; b=IEsNgeA4Q16/Dt2vzfMghEj31ZD0eAdfYpjVdxtSyWdH/mfTQdyUR59mbdk8cEiT9S1D6jkLDhyOXre5ftn6xN7bit+Tqrh/NXlc00suIGvwbXZgwp8pxctN6raeFc/ayFkbVRHK/nntmKjIqbW+eVoJ59ZAS71NKjYkl3plPuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756380408; c=relaxed/simple;
	bh=lJaQWwx/56+lS65+Ml8qliH1iA7FVtZkb6ocqsoNu+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxmJZ1SU/4QpfZKXnt+gAtvUQbrunTm+38MhfTijlNJOAWNrb/rQyjmEYc5DAOz89ohLvRkBQd/ZpeHe8ITGuvckVcE0GqC0JPyrfTxQxb3CSxzpje5c55siBYvEYehnGhnGzHjZAXIw+T3KXa/PSdqql/Epty21l5cz3AWsS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9rGY1ej; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-248e01cd834so1018635ad.0;
        Thu, 28 Aug 2025 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756380407; x=1756985207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TB49lARAguv+2novlKNuN0CFuq7GTPMP7W+cgTo2Hmc=;
        b=C9rGY1ejQ9CmwE9G/swwJMmyurYprEW7Y+kSnW5o4RFffWs7fpAXrGz8cYzLiM1pT1
         g280CSS36gpT8zQzbyXCZ8e/NeE4xbMAist7U7pBAFdJLDQgaB37gwAtOpOVZP1rZmld
         AKQXbUYqFwNv9G/693mDaQE8IzgaWSkcVdMkKxqtGmH2jwFQ14hSIouCMmcHuX0ZEb8K
         jzIUzsUY/uybWKd1BZGTXaBITkpyHfGsqW/AnCvigQ1MI2TC8zRmwdrKMV9tlUlF59ax
         qNMpQwEennLh+zDJYfN3pH4Nw7kP3IybiiKrNA3OMwED0HuKeTYm4YUbC1btNJJ0MAIR
         ltkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756380407; x=1756985207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TB49lARAguv+2novlKNuN0CFuq7GTPMP7W+cgTo2Hmc=;
        b=KV1kTpdbarqh0xOTrFQlKHGXXJua6Dxx3bHVVHEac80WRluUxVbFFDtdHNoaawJ3/a
         +BqtTyFl/bMsLj9ZixT+GTh2RW+Y+/okFYE6aqOSBaFdAj8ztoKUwoZiVx8+QyHYJiJy
         oKXalVtha/SUcnVuOsNFGuAwixx9I5C5mKLOH4NpB5/Y39izL7Lx/6jDcmGsJITbsBOr
         3a1ivZxRNZdstB/TXu4Xe6NtTGCUaleMBdfKTNYEO+apqC2Igt+0FlVf87bYKNShy1Eq
         31+90RUO8PqjyJzIe+UPw9kPlXnbSM1UT2rc9/2CG5A/yfPGBPBI21DJKGKt90V0kz0y
         1c1w==
X-Forwarded-Encrypted: i=1; AJvYcCUqKGZ11YhMf+jzOMV0fuvTCUYQdxtqwyL9PzBQNsPsXJjmaQ8pD7FYqX/Uq8UklUJpWo4PRi4mMPKxfZo=@vger.kernel.org, AJvYcCXcT1HhNYxg/HOZFaMny710nObloBy5Q7muco65JiFOsiIGXf6wBJ5L72HewIy0N9Ww4881N04EC9t5F5QZYtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9HkvYGolMjGX+FUCI3wj6RUaZY7tQwILQhk4JWT1QZlBOB4K
	pXhBnnHYwlgg4lcTZgdOhsT8JK3gF6a5RTXN+IEw5jNuXh2ay5F5jtqxEgOsNdea0kpEAjTR/2x
	9tVxE+XPJlbAQoVRP/h/O6RqIvRJ/yUFO6gkAjd0=
X-Gm-Gg: ASbGnct4N4jh2TyumnumzGJggIpWsf3GMfhDvoiR1rIQ6Fq/CoEzYh54AVKAqoVt50g
	L92M/QgZYDKimKHCKQ+38rpJyFBPkG2OLogsLIBQHJ+l6qSOL3MfBw+xAjn9ZBKKvrK/VIamed7
	yZ/opUhzB/y5heTm1FTbtEQAVDYgRCqLEIHm/rkd5Tm9eiaGn10H0krI1BhTTj/SkjpWyYhDGUb
	3CY/kpsSP6swaXAjWXCU/6UNEJNMloQTpOiEdRDj+4iQxFJJ9rbX50WEbKV7jaDB6/7mMfb/Xd5
	X0duzi6+vv3KzYKLR4hHes22UrqiX/j2oTdBgL4PO3v+Sao=
X-Google-Smtp-Source: AGHT+IHHmDIHqxhO7l79GLUkJwaWQ7dZNpLn1zpLg1iQnq0+hdNtOQx1/t6zWJjm/sSiYUD2aH3gJhMn/p7bQf7ZDaE=
X-Received: by 2002:a17:902:f60d:b0:248:847b:8906 with SMTP id
 d9443c01a7336-248847b8b62mr52656055ad.11.1756380406614; Thu, 28 Aug 2025
 04:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-nova_firmware-v2-0-93566252fe3a@nvidia.com>
 <20250826-nova_firmware-v2-2-93566252fe3a@nvidia.com> <9adb92d4-6063-4032-bf76-f98dcfe2c824@nvidia.com>
 <DCD2VJ1WJW2O.VM7E4PD3DFYO@nvidia.com>
In-Reply-To: <DCD2VJ1WJW2O.VM7E4PD3DFYO@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 28 Aug 2025 13:26:34 +0200
X-Gm-Features: Ac12FXzy24K1wGe7TQOMJcL6Fdf60t07YBP-70leUEy1vm3L-w174pbiaRtsL7M
Message-ID: <CANiq72=nGbziZCKt=AneE_vXw76i=+td0dSVfbOJ8kJ9eYHw9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] gpu: nova-core: firmware: add support for common
 firmware header
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Alistair Popple <apopple@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 10:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> However, `fw_start + fw_size` can panic in debug configuration if it
> overflows. In a release build I believe it will just happily wrap, and

In the kernel, it is a panic in the default configuration, not just a debug=
 one.

We have debug assertions too -- and those are disabled by default, but
they are separate from the overflow checking, which is the one enabled
by default.

So, any use of those operators is limited to cases where one knows,
somehow, that it will not overflow. And e.g. user-controlled inputs
cannot use them at all.

So, conceptually, something like this:

  - Static assert if the compiler knows it cannot fail.
  - Build assert if the optimizer knows it cannot fail.
  - Unfallible (like the possibly panicking operators) if the
developer knows it cannot fail.
  - Fallible/wrapping/saturating/... if the developer isn't sure or it
simply cannot be known until runtime. User-derived inputs must use
this option (or rarely the unsafe one).
  - Unsafe if the developer knows it cannot fail and the other options
are not acceptable for some reason. Ideally paired with a debug
assertion (the compiler adds these already for many unsafe
preconditions).

In the past I requested upstream Rust a way to have a "third mode"
("report and continue") for the operators so that it would wrap (like
the non-panicking mode) but allowing us to add a customization point
so that we can e.g. `WARN_ON_ONCE`.

That would be ideal, because it is a nice middle ground that is not as
punishing if a developer gets it wrong, especially for "normal users",
where panics typically mean lost reports etc. And other kernel users,
like cloud operators, can keep the panicking mode.

As for discussing no-panic, sure!

Cheers,
Miguel

