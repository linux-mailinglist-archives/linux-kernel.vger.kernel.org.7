Return-Path: <linux-kernel+bounces-859869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC7BEED52
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 23:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CA93BCE8D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F2219A81;
	Sun, 19 Oct 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQpBR7TD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A6227E95
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760909134; cv=none; b=rhP6vnT2PY4o/ns5U+4oqrMCM7OwEVeHT+fJKQjGzCJShNeShx6kuFJZVOxY60XKv5A0JYG5kWOi9r9oUcwqmQZyRaOlyhGyB7OVzNPblzg+ZXFgmsqK585h88Cm4TsMXnTtTbcC2Vs1haodXI/c2hECKTUKOrq7wKHbGzk7Pt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760909134; c=relaxed/simple;
	bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGT/ZW2klO1WyILao2TLFCyAKYN4+dKsfkRNwqPJ5HCqILdFIIKDxpadiz/5Q1uIoYTsy2cvyE8rTMvZFyTmBsr25ybF4PP/ehFujPosBPQxMR0RPvl2Tw1ZBExbUDRwvXn8qzlJgJo//D1auBAN+hi8mxJbQMaNwzNxs7bO6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQpBR7TD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290aaff26c1so10500415ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760909132; x=1761513932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
        b=DQpBR7TDwXQXpp+mLTN7vd+6pDnwCn94aRLrW2xwzkgw2/+WaWr58QDfXIvSUuAqDH
         QI5muLpHKfPn+kWy8wAqnTy2Hz31tHhGBgTx+c5edPcT4CdtCPp6IAaL9QhohOyWsJqV
         F0gc8tvOd5VhlugYbumG8RlBw6JFDuLefCoaGv4PkXl6L1O5K7kQC6tfeJqUTJwSBWKS
         TXT4b8Y6ZacsUC4ZRQ9TuhBoQZlu7GnpToYI9ONvaFVFevnO97oqkMcfK6zLeIOeSy9m
         dYb3QfBD3pHg4Ub8DkC9J9ULr4Dw8dOOSDOrVKhzGpL/7+sjm7ZWulyEvcPboG9mvKaz
         rMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760909132; x=1761513932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycAfcyNNCDvL8r+cj6EK2T80BYm3/AHXV1y+txWFqzI=;
        b=Zn95KeW0yLUyCphvfFHQRiiAUcAhPgrIEdlK9K+PfZMg6wXxnxoPSHzK+9kyfMcwja
         HQrVRI/slR1cS3/CPim6THUVCDxGhvAhjqVyn5FJkMUuiq8TqSQKz1ynuTa56M/1cdTj
         EZsXHv45tJ4hOZ0UauaTVVI1NWi6kAh8PSrG1yyKIh9BzXd4bSslqPoOq/3VLpZX7PFR
         +rGEPmskMXsCQE1ZxW7aOtvuO+SDWgQ4jwaFWwLmJNwGThqbAMFHw2NjpDiTJdF8MIHY
         UrECGCLB3mjErQHfFm0j3WVpnVcA/fDfRCTn0LKh6dB67ySxuD6KQDCYd3U0ZIZrL4qZ
         nlKg==
X-Forwarded-Encrypted: i=1; AJvYcCUHnd//Ag4rxu4z/dUiU/YXZEmkRiiTxubo5WpN0XC0XxKqUHlhJ03srwYszShGZhfepNR79ELIBZDyRRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa43hzqrPZ0flnGg7UMYZol7XYQaklxQpHQPKTQ3rcL8jCsaCE
	sNBbuqCYu9Gou3oglViiDJgCbaVUAUU7l2BfgLkRlf0Vr/RKqzDjowJh+9Rw3OIGQf+rM70s7r5
	uIdfqkzwrLvIWGHYfOO5wha0Fi6EWg/k=
X-Gm-Gg: ASbGncs92lmKoCl9THej7jyVuBBszDqYitgSW8Le5cW9RGMLKWT9H9miv5PqJzWDwhs
	lbNYM/WfFtQzflyo8vLQYFj/7vDTWGgf/gXbh5Eb4ZcyuFPLRxu21Wuueg3D9J2OfJGi099u8e5
	GgdogjimzsAMlvv3lx4LYyNZ5J9ymR9Mh5CiaLQ6PMiZtoVuc1J2oXgerBTCNE/PHff0LzEhol8
	9wM84P3XBKC3/BgkmV6Gm+W3bUw6sBZmZWfv+ZjdQBKSnntVwNmNid0EYSPB5B98Yu8jBUgn+sz
	KFPu+ClQG3Jp0XN0hLnL4kNgVM60N3G6ULFh4V1OwT2L0QGx9ZT3cVlNEmB0Dw/RGEWW7VbfbGk
	JqqWu7APEUGRTag==
X-Google-Smtp-Source: AGHT+IEqij5v9mJs5/CWA1m9c2NrE8PMDKfGOLkkgvIBrH2S+dVqx6DMlKfweKNo3iNjtFuT7Y5fW/l69CjJHY+CKa4=
X-Received: by 2002:a17:903:b8f:b0:290:c5c5:57e6 with SMTP id
 d9443c01a7336-290c9cff139mr74090165ad.3.1760909132458; Sun, 19 Oct 2025
 14:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018-cstr-core-v18-0-9378a54385f8@gmail.com> <20251018-cstr-core-v18-14-9378a54385f8@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-14-9378a54385f8@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 19 Oct 2025 23:25:18 +0200
X-Gm-Features: AS18NWAMycluR5p3NBfaTwCbAsRiC2-Lwc15QqFISNzvPKOcYBFx7NoYnd__ov0
Message-ID: <CANiq72md2Gt-UUpPdnoOimUW8d+M8Wp=9jDTZ47NzvruhfP6+A@mail.gmail.com>
Subject: Re: [RESEND PATCH v18 14/16] rust: clk: use `CStr::as_char_ptr`
To: Tamir Duberstein <tamird@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
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
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Breno Leitao <leitao@debian.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
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

Michael, Stephen: I will apply this since it would be nice to try to
get the flag day patch in this series finally done -- please shout if
you have a problem with this.

An Acked-by would be very appreciated, thanks!

Cheers,
Miguel

