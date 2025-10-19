Return-Path: <linux-kernel+bounces-859871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8EBBEED79
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44533BB491
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3825E15278E;
	Sun, 19 Oct 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDq7Fqvo"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737252264C0
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909170; cv=none; b=O1xgtRfIzG0TocxsQGMgqqSRin4lhkoIhzNP5vN8MhOFNCRxYVk4qcoZIox1/ZObyL0s7GUmztbkPgBdO1lF5VFKmtObfO8gNEJ0DmypBFRbrK6WPc36+mXHi8N0q9Npwe7bR/bsPpYC6yZhajz64va5ualefNJrWH7KLlWPr+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909170; c=relaxed/simple;
	bh=i+LGfQKWIvVBT05pMeCKog85n15IAvxhMtSIzthF5hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8a/2Gq/KTf+2fo87Sk2nh34W/wSTGEZYXFNjkeg6Y28JaFwo+Nmo1rPA4sJZIRPtPcvHsuWe7cMZuvTTjfRFO2hJ8j+U/8h+F9WG0EryHUEgMGDd+ipDkOAWYviuWKp3xCTV+sqQ2DK52gC17Acqx5Xupd1NiVq3jz32ii4mM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDq7Fqvo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33bb66c96a1so1048984a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909168; x=1761513968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+LGfQKWIvVBT05pMeCKog85n15IAvxhMtSIzthF5hw=;
        b=PDq7Fqvoti6jPtW18JV8zNYCD4MF+/+5YXqFhSF40rJQ2ZFet8SRtKsBsR97WCothn
         qASGpWu/s+Pi6zMEJX0BTA4qKHPIeIb9rrBMjXogOlE6D6FwEub6lA33lq6V50E40sS+
         sC+6jjHrEVnxy2466yLZHos/VGNYN4QtGHXPPJvUjY93p5TydGBDeDzWMG+Xrsj2F1u+
         Nf7+jAOmXHe5o8D70M9FfWLfPQXkD6KmyR59HiYceSduOwnxZ3KKCwkfRgDsU+DQT6wo
         HC/pKRdC0Paci7gbI9oIUOxQPXfKmxajfD65UJyql4eobfugI+a+6j/sSpxPVJxrK4xO
         f4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909168; x=1761513968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+LGfQKWIvVBT05pMeCKog85n15IAvxhMtSIzthF5hw=;
        b=qjHmsus9FJMOPZWnR6hEb4nF3dI/Yu6O2TGdCu1FPtg5ck8a1JDnjsmvYWbobprysA
         Wj8fPeN7dbuweQgyVJ0KnTYvjrqGcNW5r44yBI/nAtntITOe9CQzsJ0hit4ZP1X9wYFB
         PVoKyIX3+IpmbWbM9lfvS9asjCAyJYHJonpdsASY5eOqwBtosoH6p1cDxaxzKw8yeD15
         HjeezdZeK/DABpJws/it43uoT5iyuXo9Z+JO0/dOIh5dGWkk8EEjtUAgpbUJMRQ2Q2Hr
         lYodTJ94zmoem4MR9jLIE2Mj4ZG559SCllzn6NTInQFWn6LpRRofKhqDVxVKeveRmCkr
         ie9w==
X-Forwarded-Encrypted: i=1; AJvYcCUpbr13gNMNOCqmuPQWHgnIhY8wD/Wh4U4+jj4taZ+mQna+2bRfD48NAMbARotYalSdKHYfpWKMaPcpwvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsYRNQLefOkuC6bKN7XOl132f92rIaX1PATi6SZD00bRAAysX
	qHtIYG1BWthRtu25ndnnxiH76Cyu7XdZ8hUSL4VonFRSgH7xHDsKeeZOyqcEyPPjUNcmvABhPz8
	6gtjUfIoU2rDmtyuR8/wyLDwHHpyDGY0=
X-Gm-Gg: ASbGncsOb7Uw+x/unNy9tV20dnrIyGJPIxBEw/LDjWjjcW6O763jNM6J1k7muGM/h+i
	Aqr9OdyIR4X65nGQV5U1H+BW7hU9047VoNH3TSofkAadGXQ0BzlhSMJWdG31Y+UleELTPhXP904
	C2h/kZYFQRHdESdm6n6sdlsr9uzxIbSYtADisxhSAXGXoemjstDIMIzAr9nt14sUNERtMG/WHsX
	g2s6zzBDrx9bjDCmbY/Ut2+FUxd8qANEtRz7WR1EhwkAc7ZCoxlQhkMUyFwnij4cdD6KLUV2BfZ
	lt+lfO7h7vRoaGyp8qNspG/e1AijMMkIz02Zgz6PdwtSCv+Tn58hXM7EAj6CQwYntOIJGxjLQU6
	8QnY=
X-Google-Smtp-Source: AGHT+IEwx4nwwBhH/hNxoUVwvTs3X2bARut2TDi7HRPmGCV4tokc0LBHgVVevC+PQZA8tTr6XyTnNa7XyeNocxVrSx4=
X-Received: by 2002:a17:903:b8b:b0:290:c5c5:57eb with SMTP id
 d9443c01a7336-290c9d2dd08mr73269955ad.3.1760909167598; Sun, 19 Oct 2025
 14:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-11-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-11-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:55 +0200
X-Gm-Features: AS18NWDjBjMG5pR4bntjwqt3T7EHDFAllndAmj435I7b4c65f3XvqG9PcKa-Qb8
Message-ID: <CANiq72==SKsYkogrQhKTzCXwxeYfbL3V5jOiQKiunwzLta5=Pw@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 11/16] rust: opp: fix broken rustdoc link
To: Tamir Duberstein <tamird@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2025 at 9:17=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> From: Tamir Duberstein <tamird@gmail.com>
>
> Correct the spelling of "CString" to make the link work.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

It is private, but it is good to have this done so that eventually we
can potentially enable a runtime toggle for private docs.

However, this is independent of the series, so I would suggest that
Viresh et al. apply it independently.

Fixes: ce32e2d47ce6 ("rust: opp: Add abstractions for the
configuration options")

Cheers,
Miguel

