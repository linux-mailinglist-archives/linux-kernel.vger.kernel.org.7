Return-Path: <linux-kernel+bounces-742780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF67B0F6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1EA1894EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCC02FCFC3;
	Wed, 23 Jul 2025 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mY8ORgke"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7582F6F91
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282929; cv=none; b=J3lkiso0F9x8sybgwABt3altIuragZgccorqSnM2xI87ogpxwGxZSiID46NyTWlc1DrupoOAcwWeOuxhOSW4isJdebKUa7diLMd/vmUslakormbsIC177ltOGoV0qC4eF1p5pt03jFndSETX3pgxZcC1UH5JxcPk/evAKheABL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282929; c=relaxed/simple;
	bh=iE1aBZYKqQwEYNiRMnq//IWDWufJ3w5YS/WloRgwiBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaXohfxfnEC8sqFDqImfaVQkbeUSE25MhE8vOYMoGSP4lIm7xwiFqtLBDDacc7sruk7BL8vyc0WKtDwil6Dq1VXHHm18Sxbbi7GbOWLTYbtgPx2b4GJtHWk+P3wHscTQEsFBbp32XZSJ+xFwScSuqToRsgIOGd5IoSfbgp7sZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mY8ORgke; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-455b00339c8so49098975e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753282912; x=1753887712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkED1IFnrdQOrvPX+FEDqQyJbbz8ySr0pcHO2vzmZv4=;
        b=mY8ORgkeMqot4uEjGnYMYmtPMYFU4yXkUjVRzbrGVaArMpIR5Bz+YFf/Ad3QNZQ5rP
         5YpAoMUNAlKRE1/FZQxTjcE68GVbvBi/4douPtk1XB5wvozcRDHC1LeNXKofDSmMnbFf
         esPoTpKXproQ1BR/qhYRoV24aW9JbAcUfzyiP6m//5U31+NP3y82NwDKULklwCWkvDJ9
         LDdC5LJwfPO+m/i25r5JMaB3vIzFT/ug6iY85ZlIfnTCZsxhoDGk3mQMC7x0vU5MZwBK
         MnwM9V9EC8Hlz9j3nLnZkr0h2dtoQ0mYvrct+pGQjtrex0PV6+NM/4LCTCPwyBrj6cvH
         s1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282912; x=1753887712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkED1IFnrdQOrvPX+FEDqQyJbbz8ySr0pcHO2vzmZv4=;
        b=S+FtFx31QBg3KhKWsHD4715prmCsP7WQjFWr9+6rvfW/0FoXB0Dz84YW8EabhOQWHu
         r/cEFHYIH4/cnpNo/5EkkFuHjGG54qEEVmj+NComAwqEs/r/jGe4NMtssRDDnV7SUR1m
         VqgQMU4f1wXwbQMyovIXuraRlHC+UNCQaPtKJw3aPXfMNsmCMJ5QYnd8atVuVzhI/fru
         AjNHt9zJmBZYIGkbo8+Y9MPmJZDUrxO9fS91doIa9nKG9QTvGftuwMSG1RNOo69QUGwc
         fNGYocb2XXHcQhZxNM1ZSUUfhylusgeSib9kOHbdK3RzGbJXBJl//PaT+qgOhm8IFyjt
         JqgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZxnmdSeJ9rIx6r0SMA8En+7K9tvPjT5Gw6Gf2AH/YlkLq/bO1NLmGg/l/NObzE18z//QcQlQXj7KAuIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySaXb0CZJk0TaHswIdzTTvk06fLS+JAG4PjGxpN5N34lRoMDXv
	R4zAT4FbXOuzsli6gK4ckMzcRMBkELV/Jvu7EcVk7bVOg3eqLN8qTq0WYlgz37P4TkSYz4oFqOM
	VBMhKZZIMgWYm8EwGMvTDWpzrcCCVeydxBSkDDFJIo8xfxmGx6GgA6ZqE
X-Gm-Gg: ASbGncuhNF5a43Ne0nPBdcXcPQLq6gZVFtpMPE18ghL2tU9jkkwJrxM+0YuVxqCGuJ4
	L6ktqTgDjg4lCiAxG+LYSj2DFGBn/SmRwCLVg/VakaXXZLohkyhM77mPC63w3t/g9bIU0OXuGIH
	UY+InUyLQZMVjF5AAnYAs/Qaw/f8SofkgyX3aFySZWD7so8f4uKNMoJJgOd1t1CKAIuVWHcvrSK
	SrgJVMY+PLuc9m1hSru74xO//vHvKWynyvB4iCiH0/gQbRF
X-Google-Smtp-Source: AGHT+IFo6IwyLbR5G5tGGMDaDPd7c+A7mFM1EecPzUD9PrHXz7Z7GSYJhFYbhBZl9Tl4KwnUO6QlPYWlXLeyCswGE/g=
X-Received: by 2002:a05:600c:3483:b0:456:1e5a:8879 with SMTP id
 5b1f17b1804b1-45868c9454fmr32278955e9.9.1753282911854; Wed, 23 Jul 2025
 08:01:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com> <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
In-Reply-To: <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Jul 2025 17:01:39 +0200
X-Gm-Features: Ac12FXyaXk0Tn1xnIVYCpD8QPrGtzpt5ky0enjvHtYvN2fs0RSIRfx2AoBIsbAU
Message-ID: <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
> >  impl LockClassKey {
> > +    /// Initializes a statically allocated lock class key.
> > +    ///
> > +    /// This is usually used indirectly through the [`static_lock_clas=
s!`] macro.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The destructor must never run on the returned `LockClassKey`.
>
> I don't know how lockdep works, but Boqun mentioned in the other thread
> that it uses the address of static keys. But AFAIK there is no mechanism
> to differentiate them, so does lockdep just check the address and if it
> is in a static segment it uses different behavior?
>
> Because from the safety requirements on this function, I could just do
> this:
>
>     // SAFETY: we leak the box below, so the destructor never runs.
>     let class =3D KBox::new(unsafe { LockClassKey::new_static() });
>     let class =3D Pin::static_ref(KBox::leak(class));
>     let lock =3D SpinLock::new(42, c_str!("test"), class);
>     let _ =3D lock.lock();
>
> Because if lockdep then expects this to be initialized, we need to
> change the requirement to only be used from statics.

My understanding is that it has to with correctly handling reuse of
the same key. In your scenario it's not reused.

Alice

