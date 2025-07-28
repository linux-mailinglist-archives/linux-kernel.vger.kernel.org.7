Return-Path: <linux-kernel+bounces-747890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C384B139C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF0007A491F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6322C32D;
	Mon, 28 Jul 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pomFTSss"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05641DDF7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753701584; cv=none; b=gnsIEKx2p4l+jU+GT6b9CI/Jj5qddNy1DAykmU/bIUw8+mvcteMniTKf9GRya8QuOuVRejXz611C9lOvZNmutA38JIjkTUPkxnc/E9ArIjHJ6t+gbXr4jvCb69SEug5BCcFdq+2wUj//zbeh8ORgGVHmjiwXZ3cqg+0mGbRzcJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753701584; c=relaxed/simple;
	bh=fMvFtqY0dZeTgFscTQ6EikQG17iQn9yAO5mQTlzzO6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StreHYnId2xI+6ZZv24u4vJcdn13WLWmG8rHGWUhphKAHabIFYMTwN3fBvPwSpWyErByCHkTXWdeK9X7166oPqwDOt0nSfK67Ofq6/yYySGR/7EY8rFTy8vwjZU0Q9rV/iihr+0oiT/tvY7ze0Er56DzdYb4xxvrZeHZLunFo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pomFTSss; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f379662cso3017949f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753701581; x=1754306381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbmSA0QipmAIbHbKw8GhXr6SE1pl+CI9qEcVQNYIoK4=;
        b=pomFTSssg9OZS78aX3B2oQCP66eYFLleaf8LeMbmqb0u9lPSCqOGon0bBkcedsjAIa
         cv8xrVYcHkkl0CoqxGk5GpCLjDSVDgD6UfNPwD8+sQXUgltn+NGaAYqlSuvA1HRdBLml
         iePnVcTXn5ldKmJj7sYQDdpiJh/duiq2Wd+ZDl32ooQVTU+mRRQN2MMHTObLLwr+YUsj
         t3/iRWgOgAaUz8+3l+tgLxqY5fQA0L0sYtXa40qPFvu/yJs9DrHTnTY+eZdyMUer8U8y
         2CysKo5CIalA4LVATua72YJoLWM372YfV1BYV1jGWRHVKdWO/2U01CcGO6EVuRcot8sj
         29oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753701581; x=1754306381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbmSA0QipmAIbHbKw8GhXr6SE1pl+CI9qEcVQNYIoK4=;
        b=ncm8F6BXVaENiuNyrdYB86zTNYql4HQGGkuJvfL0vBU8Eg4ZRrSD3HcciFJBKh2AtP
         xNemhYizc9uvfR1nzp8j7buxNPce+GUkBILQjXp1rgAvdHIZzk0tXI0yW6wB2Hjxjm3O
         wTvv1JOrOLe5jOJzDfylUYhVS/m/ZOla4vvmkqrxHDUo6it/Bzkyo1TluYJalameTifO
         ai3+f1oYXDf/GUM6ch0eq+K281XdVAPdP5o7NU5vdOgN+Ug7XS0nGWNdis1sHardZDoV
         La5Ezwk9MydSL4apfnIaojDTT6N5dhQtcgJnNQ6w7dPlya5qiLRVANDnhRXCiunOMpCo
         RYqA==
X-Forwarded-Encrypted: i=1; AJvYcCVg7K4Vum/xtx44O/S2EUWidGdDky0USIt4nbJ1hiaO2f2laAurKuLd2eM/s38+GnG5f0HCtvNxe0aeKD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YybQbe2WwUcxb1lO5GNzym1/LDuOtmDEQm8QZS2cG2zrUTM6F+p
	TOzFEK4YJAKXQOMbVmg0P1Bdrz2s5Bb9PPsTtEYesjqj3AwEFeLIIL4A3MgvR/8vE1abEDMkNpC
	sNaI+5/5jf42A+CqznmdQI82/nQzFJTZVx8T2Je2v
X-Gm-Gg: ASbGncs9jnsS010SDSuLSXX6r/M4Z/2qRdV+rvbJO1ui6bvxhk1dBZtEF4XT4Gtqzmi
	6Oy/YCqCVygOMk1hBnfW6CRsyuLHwJlPiWlBuxr4/Li4WVkPhZkARimH3A9JRx0kw3Ge2vVaTtZ
	iKsj2lq5tFaVu96uom/K0JJTCNPIgHb5+dW/IJwYYrmsIo9XJdYtOna8BEaZB1X2KajD+bU0foK
	Jp1MdXTB/2lGsHhZ530SE9OOIq0DzONXQIL2w==
X-Google-Smtp-Source: AGHT+IH67iNxNSkrojY3fM95xQae5TfwbJj4xs2uDRg40WNQDB01MpvP3CEcQwXZKV/Ly+szDBAKEgcdFxAhv/DfOFQ=
X-Received: by 2002:a05:6000:290c:b0:3b7:8832:fde5 with SMTP id
 ffacd0b85a97d-3b78832fff5mr2866538f8f.13.1753701580696; Mon, 28 Jul 2025
 04:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
 <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com> <a4b93eb0-9742-4f24-86d9-486ce87fbed8@gmail.com>
In-Reply-To: <a4b93eb0-9742-4f24-86d9-486ce87fbed8@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 28 Jul 2025 13:19:28 +0200
X-Gm-Features: Ac12FXytrZNUlSdOYgH1ca32A8QXnXdUtZWRs5mU3kT7ILNpSGtpDjWYR9OsYM0
Message-ID: <CAH5fLghK9RhbEXAW4fYS=61Dps34+jgv1UGAOMf7_LD0DVO6rA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 1:11=E2=80=AFPM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> On 7/26/25 8:23 AM, Alice Ryhl wrote:
> > To load a value, one must be careful to hold the lock while accessing
> > it. To enable this, we add a lock() method so that you can perform
> > operations on the value before the spinlock is released.
> >
> > Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> I have a couple of nits, but overall looks good to me.
>
> > ---
> >   rust/kernel/maple_tree.rs | 94 ++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   1 file changed, 94 insertions(+)
> >
> > diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> > index 0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c..c7ef504a9c78065b3d5752b=
4f5337fb6277182d1 100644
> > --- a/rust/kernel/maple_tree.rs
> > +++ b/rust/kernel/maple_tree.rs
> > @@ -206,6 +206,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
> >           unsafe { T::try_from_foreign(ret) }
> >       }
> >
> > +    /// Lock the internal spinlock.
>
> probably should add #[must_use] here.
>
> > +    #[inline]
> > +    pub fn lock(&self) -> MapleLock<'_, T> {
> > +        // SAFETY: It's safe to lock the spinlock in a maple tree.
> > +        unsafe { bindings::spin_lock(self.ma_lock()) };
> > +
> > +        // INVARIANT: We just took the spinlock.
> > +        MapleLock(self)
> > +    }
> > +
> > +    #[inline]
> > +    fn ma_lock(&self) -> *mut bindings::spinlock_t {
> > +        // SAFETY: This pointer offset operation stays in-bounds.
> > +        let lock =3D unsafe { &raw mut (*self.tree.get()).__bindgen_an=
on_1.ma_lock };
> > +        lock.cast()
>
> This cast seems unneeded. lock should already be a *mut spinlock_t.

In some configurations, the type is BindgenUnionField<spinlock_t>.

Alice

