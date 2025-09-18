Return-Path: <linux-kernel+bounces-823327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DDB86222
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 682097B4A39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BE2550D4;
	Thu, 18 Sep 2025 16:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXnI6/a/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC625393C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214618; cv=none; b=YLmtqPGKBXez6MEBqQL+J5JPtRfy9kSbWeBgeKSFt37y2tybDKhzVTfrN16wfwvxRIuqdP6INvsBoWRGN7A7AyETZt1o1Aq53W6ui//+3LWwN3tygzOf1pwZsiTuh25PacKyJe47WuFRUshTlEPId/9SNhIArUtn71Kma5V9tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214618; c=relaxed/simple;
	bh=UQkDnZN2YupD3ElsirlzPOzXvwseK0yLG5wxXtspicI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGsgT70Yi5+MhiLkS4BqV3o04mmKXR7xKIiauTHzehx+/tMrROdV48dE6EpE+LccSOm++9+IvAgSadmZuJDsztytm8znR6BzydYMeaIFC0Dv9TDHXjpcKlmmFMMYl1WjmjlTmTmhC/OLbiNtx4gPwCgwhXXmecjG3tROqvF8fio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXnI6/a/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso11688735e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758214615; x=1758819415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4k3y0PregncblUWSi1Dac4GIHe0eZqcNbIV+BL8uo7s=;
        b=jXnI6/a/zYADZ6DbYb48EmA0qVXPzs8yc5zVkLeB0qcfqHKcsKjnYM39qYMpb+MQ19
         KUqSECu7skJ67CR+L65tYZKoQ1by+VtvawEcsHqDAklyZTinf3+kizlueVUOq3WicDhA
         Ag4/XiQpeSypQj4V8hji+WTtdkzsWMOG/36za9s78YF+vdakheOsLMUAMZPoiNjmOP13
         FcH5wpYtUPRc4zXXur1btnrfjzsTqt9lwtQXuMpIofk7ZuNLOQEk1bRc786BM58BplMq
         LMJkRMNMypqF71ivnYWF5r7PkzszOt7DjLy0C3KhfNKYn63bMC8DFQLqL6lKJKBvdgxu
         r4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214615; x=1758819415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4k3y0PregncblUWSi1Dac4GIHe0eZqcNbIV+BL8uo7s=;
        b=IYC7nJO50dW3Q5FIwcshnsfPL4GgFE+SjOmlNfsGmIGG7CXPlWVYasDufj/SyHyISk
         IUd4aa1jU5Jd8LI+HUgb85HJFoFEUtsdxexZzj/VI++1G62lJtwW35j5rH6B8J5wCa9H
         hb+7sge8e5piwTNA6IPv4/J30ivFXbqkgU6oNqEm07UH4n8ZQPplLCTFJkpBeyqkiIBj
         Bp951gnh4bih4wfASzvHnlhAW6KZqNcBAyoCWuEjHoWKhgFJKWXDzZrpHT3IkUNsuZx4
         cQjn4wrSB6kGZtQDlCSD+rmju/6aekcsbD1dyI6FqLsgBch1HGcjrha6xh2W3PS+jdK3
         riYw==
X-Forwarded-Encrypted: i=1; AJvYcCXBquEkHgefYxjpzTv3DAR5pJjTsTjzp0U7Z8dqI4Lyoc+GEGSpY29MuO53Ml9Z3lgPpJcosVvQ6ncIxFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyum18wvkBJouyOINDEKoSMnbGEGPvuf6j2LfDTHDevPqtW8tM9
	0cNzRqdFexZyql3gqlM9ypTg4ZCEStGqvH8UzGNR+apEvD7IlVEaAdghEfScqAHKrCtLozvMJ6L
	R7YM+IqBHIar8tgal9EK4Gs6jpltr2z/mHmi7eN6W
X-Gm-Gg: ASbGncvR+4HpiI3y4jxEDYz75n2ST1RSTp+TiBblewt8cOZev30Vc86ewrWhUw1q1IN
	1D/jjNKuEWh4AcnUv1jNvqCT64Q6rcqZR0JhQ5Al+CTWI3mgzMr7VGcCZhZp+OE4LiJ6MEXnpQD
	80bfSRhLcLGnoEGVFTmzktT/bFPG05w5RmZaAsnvNReByVHR2MxfjrTKGFeRnEx9+hYSXm74sRX
	BKcWmkRi2xf05J9i76+8fMWHAA2/2RBU+qf4D9budB/PTgk85pATTxTpjmgsPLR
X-Google-Smtp-Source: AGHT+IGrECi09TQaSKwSJ+8onLSD1LnP0+Uoq3q4qz+bp+RHGMmJnZZourdxee7Ub4Y3szZNq360euO9+rjTCqDTjSk=
X-Received: by 2002:a05:6000:310d:b0:3da:484a:3109 with SMTP id
 ffacd0b85a97d-3ee83cabbb0mr7006f8f.38.1758214615021; Thu, 18 Sep 2025
 09:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-rust-binder-v1-1-7a5559e8c6bb@google.com> <CAHC9VhSPo4+gSqR2g-6yvDtYGyAnQ4scw2_vQCUrKzbBBd790A@mail.gmail.com>
In-Reply-To: <CAHC9VhSPo4+gSqR2g-6yvDtYGyAnQ4scw2_vQCUrKzbBBd790A@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Sep 2025 18:56:41 +0200
X-Gm-Features: AS18NWAz8MdqEDamxmxcXKPJiVDlGZOQPplPG763EIp0srUdhSQtCXPruqOyyYE
Message-ID: <CAH5fLggNPBb7g-fq7YMCwi8KsRdpK4uD_+=o_Anqm4Uq7R5VbQ@mail.gmail.com>
Subject: Re: [PATCH] rust_binder: add Rust Binder driver
To: Paul Moore <paul@paul-moore.com>
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

On Thu, Sep 18, 2025 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Sep 18, 2025 at 6:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Please see the attached link to the original RFC for motivation.
> >
> > I did not include all of the tracepoints as I felt that the mechansim
> > for making C access fields of Rust structs should be discussed on list
> > separately. I also did not include the support for building Rust Binder
> > as a module since that requires exporting a bunch of additional symbols
> > on the C side.
> >
> > Link: https://lore.kernel.org/r/20231101-rust-binder-v1-0-08ba9197f637@=
google.com
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  drivers/android/Kconfig                       |   15 +-
> >  drivers/android/Makefile                      |    1 +
> >  drivers/android/binder/Makefile               |    9 +
> >  drivers/android/binder/allocation.rs          |  602 +++++++++
> >  drivers/android/binder/context.rs             |  180 +++
> >  drivers/android/binder/deferred_close.rs      |  204 +++
> >  drivers/android/binder/defs.rs                |  182 +++
> >  drivers/android/binder/dummy.c                |   15 +
> >  drivers/android/binder/error.rs               |   99 ++
> >  drivers/android/binder/freeze.rs              |  388 ++++++
> >  drivers/android/binder/node.rs                | 1131 +++++++++++++++++
> >  drivers/android/binder/node/wrapper.rs        |   78 ++
> >  drivers/android/binder/page_range.rs          |  746 +++++++++++
> >  drivers/android/binder/page_range_helper.c    |   24 +
> >  drivers/android/binder/page_range_helper.h    |   15 +
> >  drivers/android/binder/process.rs             | 1696 +++++++++++++++++=
++++++++
> >  drivers/android/binder/range_alloc/array.rs   |  251 ++++
> >  drivers/android/binder/range_alloc/mod.rs     |  329 +++++
> >  drivers/android/binder/range_alloc/tree.rs    |  488 +++++++
> >  drivers/android/binder/rust_binder.h          |   23 +
> >  drivers/android/binder/rust_binder_events.c   |   59 +
> >  drivers/android/binder/rust_binder_events.h   |   36 +
> >  drivers/android/binder/rust_binder_internal.h |   87 ++
> >  drivers/android/binder/rust_binder_main.rs    |  627 +++++++++
> >  drivers/android/binder/rust_binderfs.c        |  850 +++++++++++++
> >  drivers/android/binder/stats.rs               |   89 ++
> >  drivers/android/binder/thread.rs              | 1596 +++++++++++++++++=
++++++
> >  drivers/android/binder/trace.rs               |   16 +
> >  drivers/android/binder/transaction.rs         |  456 +++++++
> >  include/uapi/linux/android/binder.h           |    2 +-
> >  rust/bindings/bindings_helper.h               |    8 +
> >  rust/helpers/binder.c                         |   26 +
> >  rust/helpers/helpers.c                        |    1 +
> >  rust/helpers/page.c                           |    8 +
> >  rust/helpers/security.c                       |   24 +
> >  rust/kernel/cred.rs                           |    6 +
> >  rust/kernel/page.rs                           |    6 +
> >  rust/kernel/security.rs                       |   37 +
> >  rust/uapi/uapi_helper.h                       |    1 +
> >  39 files changed, 10409 insertions(+), 2 deletions(-)
>
> This is a pretty big patch, in the future it might be nice to
> decompose things like this into a multi-part patchset.  Regardless,
> the LSM/security bits look okay to me.
>
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks!

