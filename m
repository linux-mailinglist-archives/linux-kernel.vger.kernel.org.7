Return-Path: <linux-kernel+bounces-775216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C57FB2BCAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD9F7B782B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095FA31AF33;
	Tue, 19 Aug 2025 09:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TRCq3NN5"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299C315777
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594614; cv=none; b=LnZMhX/iulj0rnaqKFA4qK+9U+dB2q/P7ZJLk4wagPqIZo2Bo2cYqnLo39NCpBhWy/yiTokmoT9N99rtPAJDaPAUlEnktNDnNZwaBsIgn2nRo5/5cWZMG1qG5Z4DGijhBHlfv/F3R4zFIuzBrqUawZ2NGcbfvG9D2Ri8cFWwAGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594614; c=relaxed/simple;
	bh=7ek/XcSlPOTA9wFSe80Ag3IAFpD2dLzpSLsq/5EQJl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yg7aZHOYeLuSAZcuX6A8hN4669y0od52UG+RlAMzM0Aj0s16boC9VO0wMUsOytFOAYzcdK7CVhdm7iF9nyeknAfoX3oWaw/ohP6A47SdOYO8i65jxBj+vt5tkeSuh7EuhQZO6MSwqXSrbWxTVWgl2AcR1CdaWlEiqhJeEXVZS2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TRCq3NN5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e415a68fso4545636f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755594611; x=1756199411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9/jnxBS7I1AR5e/02apEhjBpEazFeyENxAvH1Nm6yo=;
        b=TRCq3NN5tnBIwhZrMkR+sJlPFKenz+qWGBX+bl3NfNUEhlJP/8C1VNTmGhGVhVeA/2
         Ibf21hcyYiiBYi4Yfsj5r8XJ6gkAs0x8/1Fa3doALXvDAeFhqPJbJvzTJCNzihPd5qEL
         Phcp8MvkANhjtIs+jVTQwaNzNs/IKUJAVG+tci5FNioLwcLwTJi5zOkSp4bgo4Fh3970
         KxLIb361iAAj8wmtWzgmy3Xe9FPy82nG0+v641XeWtZahD0bKLMgWhbd3BbKVzj+eLZ9
         bx2kevEpJa+XSar4/pWQGYvmu3ZpqA3fRCp1K6vb4Ikj4NjBLtvKNhvU9SrF2NB9kF+j
         P14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755594611; x=1756199411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9/jnxBS7I1AR5e/02apEhjBpEazFeyENxAvH1Nm6yo=;
        b=DdFTkn+D/qfiZY3Mm1x6Fy6pryLZvA5WYL8GOeFFo/24foxfL5xP6BS5B88PVugKYz
         N5UPAsU0p6IeNASTNrBLdQ/3jmLeQHqlK5y28DAZSxWGil+CwTjqZ1T+iJ5WNd7w4SHU
         fBC9/UN/QpFYgdqNRuppDxj5dtfcLowfHOyEbo3ZK79vtN0kXshJf8aCJTg7suv0iDTn
         4tHAasv9w2qTH7rHEBeWDId5RNtJ/0brNNaqLLFS52ICOOSOlB+c2NhIe5osUiNTxxM+
         AyaxgTZ2TGDisdWqd0Rqi3DzuDXVMuEH8pdltjUK8i+7cNByGikf0TDI+JbRwTfZJcKv
         cIQw==
X-Forwarded-Encrypted: i=1; AJvYcCVnJ0iHa0D88/3aqKttpj2Yksoo6xHa/GT1JxD9sYmPfmnFNqaWumyZ61Oynq+/IAUeHp3wzkdZuz4/btw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW8J19Xdu5h2MoLguJf7DuLqspdypMsZJV3GUxvLLJ7kWV4YH4
	3Vx6m4SPkIAOA8ZS+QWWgyEtEcq1/O75MVwnCuuaqiNU2qCUbpEypsEQXZYeM15n3GI+/H/Q2lF
	G4K4WnEy0YED5GaJfBbK/v+MTkH7O0rjNVfZiDGIm
X-Gm-Gg: ASbGncsrOkshqxqs9qbzUT4gjtzwGyZpXYsr2HmKknmJUH3k5/lYTyYNxSgm/SvT2Rv
	cpsripC4kOg7CLYg+Q6QYHUAJ/NYg7FL5cwoN/+rEbIY9CdZGkO6zPC20EzL3HpNNU0ZhHEswvJ
	/5TlKUoaBMHP3OK/TRsm043KtZAVEfOyz1wBIhBjIQgdWpQ8gx6k1oIRzFdzGS7WTfAh4/66bpy
	Pt/wLe40JPqGdmqslvTwEY5XcRKijvdy4e5pYij50BQv05+6yM2D3M=
X-Google-Smtp-Source: AGHT+IHVUVNrk5qRTajk434+TVEPOUXm04X7Uh+fxd2pvvGn/JXpX/RvG9pR2tzt3ATebxLW997HovRzB564pm6TmpA=
X-Received: by 2002:a05:6000:1ac5:b0:3b8:fe01:cc29 with SMTP id
 ffacd0b85a97d-3c0ec476b13mr1451794f8f.45.1755594610630; Tue, 19 Aug 2025
 02:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-1-27a3da7cb8e5@google.com> <20250726164527.6133cff6.gary@garyguo.net>
In-Reply-To: <20250726164527.6133cff6.gary@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Aug 2025 11:09:58 +0200
X-Gm-Features: Ac12FXzIjOR60cK89wW_NrK29HmSiiv16L1E4oN_6vVa5petNytsfqPo9w5zs2E
Message-ID: <CAH5fLgg=_rfx9mBn6GbF9S0+thO5kGZOvOFT77XKJiGG1iozfg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: maple_tree: add MapleTree
To: Gary Guo <gary@garyguo.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:45=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 26 Jul 2025 13:23:22 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > The maple tree will be used in the Tyr driver to allocate and keep trac=
k
> > of GPU allocations created internally (i.e. not by userspace). It will
> > likely also be used in the Nova driver eventually.
> >
> > This adds the simplest methods for additional and removal that do not
> > require any special care with respect to concurrency.
> >
> > This implementation is based on the RFC by Andrew but with significant
> > changes to simplify the implementation.
> >
> > Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Overall looks good to me, some nits and thoughts about the error type
> below.
>
> Best,
> GAry
>
> > +/// Error type for failure to insert a new value.
> > +pub struct InsertError<T> {
> > +    /// The value that could not be inserted.
> > +    pub value: T,
> > +    /// The reason for the failure to insert.
> > +    pub cause: InsertErrorKind,
> > +}
>
> Hmm, we've already have quite a few errors that look like this, e.g.
> `StoreError`. I wonder if we should just have a generic
>
>     struct ErrroWithData<T, E> {
>        pub value: T,
>        pub cause: E,
>     }

I don't think we have any existing errors that look like this?

> > +
> > +/// The reason for the failure to insert.
> > +#[derive(PartialEq, Eq, Copy, Clone)]
> > +pub enum InsertErrorKind {
> > +    /// There is already a value in the requested range.
> > +    Occupied,
> > +    /// Failure to allocate memory.
> > +    Nomem,
>
> Given that we already have an error type for allocation failure, how
> about
>
>     AllocError(crate::alloc::AllocError)
>
> ? I know we're getting ENOMEM from C, but this would match what the
> error type would be if it were from pure Rust code.

I don't think it makes a big difference, but ok.

Alice

