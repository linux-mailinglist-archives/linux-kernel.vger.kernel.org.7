Return-Path: <linux-kernel+bounces-655621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4936ABD8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 15:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA53ABA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 13:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BB122D4DF;
	Tue, 20 May 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FfnwjPHI"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EB921C9F5
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746369; cv=none; b=F0es2cv0jH/Z6Z3ubNBMpYdGS0oUbVlnLOsvoAZb6V4jN4DW3WJyqyPKjdBCjVSF5vw1hfL9Y0Abjpey0desi2stkdMsDm0CS2alXQfNwE0T7D53n3q239BBFVsW27utT4Ef0AUl83XF5eDuKaPnywq1OweEQSvZTqLoe7zuSqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746369; c=relaxed/simple;
	bh=ygHawv2Kt/gl9imzYrpW3w0g6eLfPzMgRVuN3qs66T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/oP92596wENs2J5xmHDdTIIixK8y7FxumKGLmn51HqDP/abenp6ej4O7dUTX+5lQ7Emqbvhd8/FMz/wCrudbidl3/IUY21C8Ly+tB+0dQWzCJXaBEELbCyVNFQR0iaGv5Cjq9Dw6S5wFmewfGJP2UVMij5o44ouyLrqbMZ9w+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FfnwjPHI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a3683d8314so2597091f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 06:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747746366; x=1748351166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygHawv2Kt/gl9imzYrpW3w0g6eLfPzMgRVuN3qs66T8=;
        b=FfnwjPHIT3Y31B4/i0S0surlbTjZDCbcO9lzjCQ62aJM+HlfeGyyWPMqI+ANJbLxp3
         eibqCYXO54oCvgfe6yJ/6K7me6tP6I6/HxmNzVZ45ayTI0jmSkuFj6veny5Bc3pFYjL4
         aQm55d6pSgkVq2t8Y9kqPmpURULqsdXNNQprIuuhLgfbLUVnbNJmr2xxkyZv2AvYxzfK
         lKEr+H0h4be8wkon+zhJUflxhUvpjCpEXT49rhCo0YyaOpPw/VWi9cau7R04nXeB56ov
         fHBeVx/kGc+g6GgOXftGjxhfGw0tXB4JTF6PrKztfoHRI8zH0DHm+ZJpMwsHaEs3VZ6J
         lEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746366; x=1748351166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ygHawv2Kt/gl9imzYrpW3w0g6eLfPzMgRVuN3qs66T8=;
        b=W6iZ1tVn2uWfyUX9BeaM5rWHm3IevmLp58mjOuPNRQJFLedQEhY4UPyQ+g8aoZqhG/
         ujga46VKENzZvMj/c+jMvB3EedDBJMLz7z0HU1P9W5S8NUnC0/yZ2TEMSU4C9MET6ZYG
         h3Ix9xjfF5p8MclVKefTywC1RXp7goWQhwoUgBcPB2KSqnn4gG9v7WBvCAUSJ12HPKLT
         mj9V4aW/oPC+PnWDMhtycCryNiKwszB3+71w+aNLzdfFS1YO4HL0gIvaPfv1ZE0DTw/c
         47hMqqJA/1F1/rehte4+ldVKzmk90Pzcdk9h4M1TWRwH2JgBnoc1nUXSdHrJoond/fOE
         8W+g==
X-Forwarded-Encrypted: i=1; AJvYcCWVp1MfqxznRL0aMBk/ZarDtUSgOdTJ2baAn8eJzgTZilgqzvLnAH4dQAvvQYRGtykG5hvscoc5isj5X9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySSj+scNYp/IFcWL7agyx12ZebwJ0Z/xnrx/1KId3G47TpDXhZ
	rz5eDFoCSfEuQR2v7gFPX0Suwcp1LjQnhd7HI+9UWenNbdaLeuUOhC4ZmU/kfpu/IxLoM7jF/Qz
	fEv+5ssdp+lk1muiUak446EgROGq65obEgPUeKh8m
X-Gm-Gg: ASbGncsMT8KPvG9OeuECccuaqH9qLUR72KaT37Ayucpfy3swjc+1NtAcHSI0fseNhIg
	HNbDtdGUpqmWqUnqGI3AzKtmxtgFmiBhS1m2E/f5TijJXHZ6kMfJghdeUP5rnnFPGEo15TSOLrH
	2gb0wZo3t5r5IO1VJbN+QmjJHVoqv40+Up2eWY76l0PW9W
X-Google-Smtp-Source: AGHT+IGiwEyvaaxNGP3p8OmMJE8qylxD5/OsHsmXFSKNlYqPCGvMnZ49i5JjquiQOA3AGv5mJej974Pj0vxbhasJKGg=
X-Received: by 2002:a05:6000:2907:b0:3a3:64b7:620b with SMTP id
 ffacd0b85a97d-3a364b7643cmr11366256f8f.20.1747746365859; Tue, 20 May 2025
 06:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519161712.2609395-1-bqe@google.com> <20250519161712.2609395-6-bqe@google.com>
 <CAG48ez2WdxXVCzVsAPeQWgso3ZBQS_Xm+9D1FLBx6UHFV1bGHQ@mail.gmail.com>
 <682bc528.c80a0220.13f632.9ec0@mx.google.com> <CAH5fLghNJYjxPFUc2E4-2pJpGT5umUr1EJstZvs88ox3MsXDGQ@mail.gmail.com>
 <aCwRZlkBWekRmDg7@Mac.home> <CAH5fLgj1NVodPy-95CFUygGO7WC0siNEKSyEhgLvpX-1zMXErQ@mail.gmail.com>
 <aCx77cCum_b-IR4H@Mac.home>
In-Reply-To: <aCx77cCum_b-IR4H@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 20 May 2025 06:05:52 -0700
X-Gm-Features: AX0GCFuHsICvFNulDXvpM7f_XY9rp0cDon-cvyaK34Cte_mRien9oBSvi2v0fiM
Message-ID: <CAH5fLgjqj7binVaLDh7Pc7SVKDM-XrYDEDj7GYBX_MnjHgufFg@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] rust: add dynamic ID pool abstraction for bitmap
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jann Horn <jannh@google.com>, Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, 
	Kees Cook <kees@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:56=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, May 20, 2025 at 05:42:51AM -0700, Alice Ryhl wrote:
> > On Mon, May 19, 2025 at 10:21=E2=80=AFPM Boqun Feng <boqun.feng@gmail.c=
om> wrote:
> > >
> > > On Mon, May 19, 2025 at 08:46:37PM -0700, Alice Ryhl wrote:
> > > > On Mon, May 19, 2025 at 4:56=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Tue, May 20, 2025 at 12:51:07AM +0200, Jann Horn wrote:
> > > > > > On Mon, May 19, 2025 at 6:20=E2=80=AFPM Burak Emir <bqe@google.=
com> wrote:
> > > > > > > This is a port of the Binder data structure introduced in com=
mit
> > > > > > > 15d9da3f818c ("binder: use bitmap for faster descriptor looku=
p") to
> > > > > > > Rust.
> > > > > >
> > > > > > Stupid high-level side comment:
> > > > > >
> > > > > > That commit looks like it changed a simple linear rbtree scan (=
which
> > > > > > is O(n) with slow steps) into a bitmap thing. A more elegant op=
tion
> > > > > > might have been to use an augmented rbtree, reducing the O(n) r=
btree
> > > > > > scan to an O(log n) rbtree lookup, just like how finding a free=
 area
> > > > >
> > > > > I think RBTree::cursor_lower_bound() [1] does exactly what you sa=
id
> > > >
> > > > We need the smallest ID without a value, not the smallest ID in use=
.
> > > >
> > >
> > > Ok, but it shouldn't be hard to write a Rust function that search tha=
t,
> > > right? My point was mostly the Rust rbtree binding can do O(log n)
> > > search. I have no idea about "even so, should we try something like J=
ann
> > > suggested". And I think your other reply basically says no.
> >
> > We would need to store additional data in the r/b tree to know whether
> > to go left or right, so it would be somewhat tricky. We don't have an
>
> Hmm... I'm confused, I thought you can implement a search like that by
> doing what RBTree::raw_entry() does except that when Ordering::Equal you
> always go left or right (depending on whether you want to get an unused
> ID less or greater than a key value), i.e. you always search until you
> get an Vacant entry. Why do you need store additional data for that?
> Maybe I'm missing something here?

Let's say you're at the root node of an r/b tree, and you see that the
root node has id 17, the left node has id 8, and the right node has id
25. Do you go left or right?

Alice

