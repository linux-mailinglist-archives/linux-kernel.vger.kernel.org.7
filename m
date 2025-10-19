Return-Path: <linux-kernel+bounces-859868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46239BEED34
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1423B99EE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC052192F5;
	Sun, 19 Oct 2025 21:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFVHgf1e"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475FB13774D
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909132; cv=none; b=SbC0ywrAYWejlkkq+Qv2Wvb0LW7+VNQyr4M16XwXm81Ftpdbo1KK1Tf1OcngG/zudU90KK3D6vEdR4cN08De1PjTMWoPghfAxLaxQ1DqwcWdbW6v/UMlxRKREH0Z69xFX3FuDaI/0VOUXzJn1cIpRhT25xpFbdtyAzwzU7+Lh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909132; c=relaxed/simple;
	bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muTKMRUR29vmrwhrby47F4VjiG9yST51AheFe6VuaHhC+S8nU/Djw7bwntEWq7yRUngkE6qLKObHUoXcd17sZG+t2pvOOCDEeLmsp6oMZEXfiSFHDWI5qvN2+frs8Tc+Q1/tSCwNu170e9wi3V+B6nhCh8vI1wAxHgjenrGPvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFVHgf1e; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33bdd2b3b77so651684a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909129; x=1761513929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
        b=BFVHgf1eBxrRlVa4HQwtg+9JdGx+ckCck1jX46JQ5chJaRBSqsc6IKXoNvNltJhS5z
         SrqUVnX4pqzWiqNACvkDi1zVvk0GidVr9CkWudBq60rIZd3EAb5DXaA+0AHy7UMlu2IG
         fOjsqzm45BHLYsgMbYQvLre1c4z0LdXIonBIBz/gncQQg8glng0WpBLHu/TfVJFWVi2R
         N6nphsFpZ+PNw+cXdn0SfRcjuXCDssB1hHtfya3a4thXk9G7paDwq4vzO7Ul3foqBdju
         mPnqrYMM8J9oyfVNXdQhhChz/diK6X8qnWUsWRiaNkBcK76mIzKAYNBEDTup+TwJgR3A
         HOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909129; x=1761513929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMzOcGlzTmgP7Sx2K6Mr5nIuxpWb7Ycpm/3lBUKh9gU=;
        b=DlgTMKuEHbjR4WpfQNu6ulwVJTkDANTtbMhQuLPCS6xUq6LXuVPtGO1t3PSm/BdvuN
         CcIFP6TONDDtpJWBgDeehWbIuvGtYfj1D/wpWb1aSSvn+/maG3pPFbqA6yYXeNVnwY5u
         lS0Sr/kI+adYQnvKlBiOYS9TBTtNsrVDifbCLX2R38DbD+Wvhj7uS9uUZgFsC90WFlvJ
         5iLkcoGoFAwFPqg0QV2v5RlF6QucwATlLcfrtzMzykQRYvdJhAz3tBOmNhLuVpRhXD+f
         TIhC3WyERFE+POEsRjaCr/C+HWRUjjBQlgk7DMr8E313gU5SjPlfSMToXxl3ZjHEYV3U
         v/tg==
X-Forwarded-Encrypted: i=1; AJvYcCWPcsAYM761c9yZlMHWATtDueuKrwnRVV42VBkipKrgRi5pKJRnGER06P9pQqpoF1x8epe2gPTLqIWfC88=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhHeI2n8w/JIK/wHy5US9+buPqQXiQps3Zs7v0DTYNQEtFbxVE
	hWFzux0ssfUqvIQjfIJFth/BRRCyGb68sNlS/epVxOwEofTdZLPgWYXu7Fps+aF9BJ+wPdpxw+v
	5NIcFp1eHDiRRQUMO4PpuUXIgvEOG8m8=
X-Gm-Gg: ASbGncuDlvKYuIn2QOwEK8vdPoiZCym1981EyNH4M8fxXwwpGcEtycP4otpmxNedRry
	f/MI7xDGk+yihrogoys7WREEZD9Ww4YvXbKvT0MqiuS1kvpjrrhgnz1Voysohz1qnoD8OcFzj02
	4TYfPdnjhfKASQWnh9odQa9YKdfp8dRx97MEyJGDAgFj6R9VqH5Utm3ymmWwlFGzyuVfabT1dvM
	6lnEb/pJp2GCqX3k552mdRSl1JTz3UIiTy0BsvcBbnjH3HmTNYR4S5+YF8fvF5l9MF+b61sIJnm
	eoqISIHVP5tDoTgKjolohaUAZUCXhDMYEk64zqqAx4ggo9K2nHuuFRU54hgCJoaCFNtZc/zE3d+
	rHQJBpFxqED9EIQ==
X-Google-Smtp-Source: AGHT+IFkXmb/qgb/KgY8CoxXBFCqji+DioDep8k1ccK80l52uLY2VJCsOrEx4mXqL5zBbM0jkYzLAt9Oa8qgqgiQULk=
X-Received: by 2002:a17:903:1a0b:b0:27e:eb9b:b80f with SMTP id
 d9443c01a7336-290c9c9a8a7mr71999045ad.2.1760909129461; Sun, 19 Oct 2025
 14:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-13-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:16 +0200
X-Gm-Features: AS18NWDXrZ8O-3KwwwBOxfZWPwAGhp3HE5GT4mOk-9o3K1qGCus24KCpGnZzuZA
Message-ID: <CANiq72mpmO2fyfHmkipYZmirRg-x90Hi3Ly+2mriuGX96bOuew@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 13/16] rust: regulator: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>
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
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Michael Turquette <mturquette@baylibre.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
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
> Replace the use of `as_ptr` which works through `<CStr as
> Deref<Target=3D&[u8]>::deref()` in preparation for replacing
> `kernel::str::CStr` with `core::ffi::CStr` as the latter does not
> implement `Deref<Target=3D&[u8]>`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Liam, Mark: I will apply this since it would be nice to try to get the
flag day patch in this series finally done -- please shout if you have
a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

