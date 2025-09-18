Return-Path: <linux-kernel+bounces-823218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B5B85D29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B38B2A4B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA493148AF;
	Thu, 18 Sep 2025 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hqj8KHXv"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829A8313D64
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210729; cv=none; b=WkQVTRzFQL8eoqBvaIrNVREefLI8NAEXc+SbHqKwGQBt9bm2TqmIRgjjrbdP5TcKeRe/hyqJy/y9Il05ObZ3M+leTGKFVPYwJyqfQmuPl9zFA0Qup2EdVuwGrTpq155tYJjoBm/qVUcHqH41UqOGYoiJw4XC2a0NZt7CsvsHPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210729; c=relaxed/simple;
	bh=s3V+V2LAckakdZsEF41B0aB9f19oz/vHCu2aN/xcjFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1dNEh/Hv3ZAJ9gTzhA/SN+Fwpi4RmEELD6rSIGlgwfRFR+LdHPA6z041UBhby1tXrMLlV5GH0dIlEdm/v99aREVUDLaEW0oPEdgP3swv02/FrkEUMBaTtSlY68mtCclI/5sLUcbftvbtHLXaHazbKPtfqVwQE1EXTMj4qMfyUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hqj8KHXv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3306d93e562so709784a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758210727; x=1758815527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V04anXbncBY8pG9J//7xkYd/M3GClEPh+3YGabPQNsk=;
        b=Hqj8KHXvIsWRal/Q0jbxZkJArUG30lDKizlsTUCAkAeecu92v4d8kSsIJhE4ACK7J2
         NoBnrun1J46N6Bx4vtKN5PimAXiihr5PeWc1k/5alsrIOuMH3GXx20yZCT7mJ+m2DYIC
         j8VOKWeNf2R7i2Ls8UdLjVOHLBF5E/YTxnjlBcrMvQqlYJ0JwWycgEenxOdoykfiFRas
         8eAuDPuJuPi1DeuQ0QKdBsTQSG8+c2Bej5Qo0yN3pZgjYRAg1td3NPSNWLxmCHenkvvB
         6Mp8rwdtCQpy1zg/jRIGSf7Imxl9DEp0z0S7Zbn+eJrsmfuDY4BDXjOxP0ixehcu9X+u
         g2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210727; x=1758815527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V04anXbncBY8pG9J//7xkYd/M3GClEPh+3YGabPQNsk=;
        b=iPgVTba1xoG7jkRDb5vlPP8dxnwCSJQioWNNW0APlviZdP7NID46GFoA4fpe8buLX/
         9S1T3Awb04vBSaAbgAsm7zP159waXNdXQZBTncsYR02ytO2BsiIWzz8KKLDqLSd0eEWf
         +7eninaur+NxBGY/EJKJEP7Tt/oYY3Oj0/5/MIkax6eFKsDIzGb1WFN4hjkCfU2vh+jN
         wyyaHKzwRpiFlkyLSneOmu74/nZoYIJAIOQqD88gV8pmV4jIDE2s2my03QPSbGtS8BXc
         G967dEyrKUqBQIvCce8RmF/Mt5gq1tBQ5RRpkEJsokRCh+MJKPnrFlpai9xTARWAGBHS
         95Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUZwuL+TUJJeG7AD1OvplJQXj2+qXA94nufyz8HJR4lvcuHj3MT0oDJ8ZYubNO3OVrQK9MJuXh4D/FSYkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqVAZL2TsP783WdZxnliPlC7EyTgTmI6HAvPEoEgd/FnOg7Gxp
	v4/374OlQp5H02J3MWGl0nRe5BRFZxYTTeVQhfrrK+ofAqpi8WuSbXb7P/mWl2hw9Bagt7twpHD
	1jMLyxDALoS8NxDktaIg/a8yv0OKP0qJakVpXD0Rr
X-Gm-Gg: ASbGnctjTQonLErFZR0V3DVGZdF0JXlWqQo+Py2034nMlfp7zQo9hWs9ZcecJNeZcHs
	wYcztt/HSOt8ZuaQ+Zd0WYsdjb3LLkShZ3xu2/CskrdCY/k5c4hiP1gRr/9cYXvJoyEEAsyZa6Q
	rIIjqQp8uaNyUlWJTDI8/qKOQlVbnTHaYnX9V6vSa47iaW3E/XIut3DSjLX+IHnKNqr9UVQ19Xq
	pd5XQQRLZPub7SMrGEgtO9z3g==
X-Google-Smtp-Source: AGHT+IGHK64MwYO04bSsnMMTx3l5xs6cc0c36CiG/JwzvP03YtDz7B8RYzBt6ZEJM2wYQ8zXLBs1hm/F2ebCi5vuLes=
X-Received: by 2002:a17:90b:2e52:b0:32e:5cba:ae26 with SMTP id
 98e67ed59e1d1-32ee3f5cad2mr7263871a91.23.1758210726665; Thu, 18 Sep 2025
 08:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>
In-Reply-To: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Sep 2025 11:51:54 -0400
X-Gm-Features: AS18NWD0rI4CL8d-I3ThtruBnhZqOIxzK-M-XfFJiGvkJJ6szBoJDjngnfMmssI
Message-ID: <CAHC9VhSPo4+gSqR2g-6yvDtYGyAnQ4scw2_vQCUrKzbBBd790A@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Please see the attached link to the original RFC for motivation.
>
> I did not include all of the tracepoints as I felt that the mechansim
> for making C access fields of Rust structs should be discussed on list
> separately. I also did not include the support for building Rust Binder
> as a module since that requires exporting a bunch of additional symbols
> on the C side.
>
> Link: https://lore.kernel.org/r/20231101-rust-binder-v1-0-08ba9197f637@go=
ogle.com
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/Kconfig                       |   15 +-
>  drivers/android/Makefile                      |    1 +
>  drivers/android/binder/Makefile               |    9 +
>  drivers/android/binder/allocation.rs          |  602 +++++++++
>  drivers/android/binder/context.rs             |  180 +++
>  drivers/android/binder/deferred_close.rs      |  204 +++
>  drivers/android/binder/defs.rs                |  182 +++
>  drivers/android/binder/dummy.c                |   15 +
>  drivers/android/binder/error.rs               |   99 ++
>  drivers/android/binder/freeze.rs              |  388 ++++++
>  drivers/android/binder/node.rs                | 1131 +++++++++++++++++
>  drivers/android/binder/node/wrapper.rs        |   78 ++
>  drivers/android/binder/page_range.rs          |  746 +++++++++++
>  drivers/android/binder/page_range_helper.c    |   24 +
>  drivers/android/binder/page_range_helper.h    |   15 +
>  drivers/android/binder/process.rs             | 1696 +++++++++++++++++++=
++++++
>  drivers/android/binder/range_alloc/array.rs   |  251 ++++
>  drivers/android/binder/range_alloc/mod.rs     |  329 +++++
>  drivers/android/binder/range_alloc/tree.rs    |  488 +++++++
>  drivers/android/binder/rust_binder.h          |   23 +
>  drivers/android/binder/rust_binder_events.c   |   59 +
>  drivers/android/binder/rust_binder_events.h   |   36 +
>  drivers/android/binder/rust_binder_internal.h |   87 ++
>  drivers/android/binder/rust_binder_main.rs    |  627 +++++++++
>  drivers/android/binder/rust_binderfs.c        |  850 +++++++++++++
>  drivers/android/binder/stats.rs               |   89 ++
>  drivers/android/binder/thread.rs              | 1596 +++++++++++++++++++=
++++
>  drivers/android/binder/trace.rs               |   16 +
>  drivers/android/binder/transaction.rs         |  456 +++++++
>  include/uapi/linux/android/binder.h           |    2 +-
>  rust/bindings/bindings_helper.h               |    8 +
>  rust/helpers/binder.c                         |   26 +
>  rust/helpers/helpers.c                        |    1 +
>  rust/helpers/page.c                           |    8 +
>  rust/helpers/security.c                       |   24 +
>  rust/kernel/cred.rs                           |    6 +
>  rust/kernel/page.rs                           |    6 +
>  rust/kernel/security.rs                       |   37 +
>  rust/uapi/uapi_helper.h                       |    1 +
>  39 files changed, 10409 insertions(+), 2 deletions(-)

This is a pretty big patch, in the future it might be nice to
decompose things like this into a multi-part patchset.  Regardless,
the LSM/security bits look okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

