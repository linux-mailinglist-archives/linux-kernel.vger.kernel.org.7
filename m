Return-Path: <linux-kernel+bounces-787742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E21B37A79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662517A9D50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55229AAFD;
	Wed, 27 Aug 2025 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYM86aQG"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AD2FAC1F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756276492; cv=none; b=Cp6BJNLkiG9lAE7PcLolblgLXKrqSX5sCoBA/R78jiBnCv/5d2TPv75AjIJb/Ih70DZKfwsUh6oRu0iSSoRdpquNdFhddwC8rQZtPgr7PCKEl9IU98sQypnwyqBMZS9xvxkR8EDLR9x6MGXTlyNBvEiRIDzJTzoV2iDQ/YmHAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756276492; c=relaxed/simple;
	bh=pCyH8a8IPF53a4+xGnuijfrRt1r9Qpf/OOe8y/sPNKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAfQSdyG8HKZ4r3kU/XXF7i+WEzMXxAQgS9OnvFIlvP1pYj2+DxxEnJ4ddpyJ/GsCM9pxBfyvMBJnxrwWrU7bPiLBg8pyG5/4+u9ahZJyLVRRqzMSD6OVuifAk0R/bUvCAIfVukzdBmLC/GFwwelWqH1/peiCrUJR6F3UFdUemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MYM86aQG; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso3206524f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756276488; x=1756881288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCyH8a8IPF53a4+xGnuijfrRt1r9Qpf/OOe8y/sPNKU=;
        b=MYM86aQGmDiGJ1DSGwjfiaAG4hzrMe3wCquaVneCOVhvAVRZqvgHFil+F9z4jKOXjH
         /Ada35TI9RtLSjgsKiDYFj+4CFkczGhMALb7o23Cr2xC2vjy1pRYiOUkp5A909DYrE6l
         aDdozVWZdOJnmz+hpClXSWiGoxt8yP+LWUwIZIGqiwYgDIVKwL7Bfq0hxygsEx8JbEXx
         El++JPwU4w5gWVxl2mzIjpoVjL/u6RVMn04PD3wJctAyIqqdEAxU/TgWUEH4uvP7IY5o
         Ss3qdyRhjY+yEO57Ftm2nKOWzkJPFbJ5sAavV20iVtRB5gwOHK8IcLQTvUd6vVoYyrSb
         Xrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756276488; x=1756881288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCyH8a8IPF53a4+xGnuijfrRt1r9Qpf/OOe8y/sPNKU=;
        b=ggiNRQuXekWzFR2Lfl3GOWXJCok784nDga1ncLVQvKJaNe/03deWfSnsqBaLv52eeo
         iEHqiyqRnSE8Bcc1FhhpRFYSvnyPa1l33JEwrhC/RklyRAnTsZ2+Zz1PVRZY1Z+AFnv4
         5ZSF7lQ3LmoxI/sF5VvdbiiSDZKHjUO6p6ZmLeDsMFWFIKJSz+KKFLqWm5iHQww4VAZg
         HEdE7dKiLySZd1Cpd36sluoFwPM40BcEIKM4aDoCpuCO5a46y5oiwDKjQmGoQ73mEj/M
         hLXnVNofvnySs5xm3zNrYbQvao5zHReIppqAQ7u1kt9l7QJylSG6WgF9XbSQhBYNXlJZ
         2OWg==
X-Forwarded-Encrypted: i=1; AJvYcCWNd7Bi4DtyNA0MVF/vp7YrlukzbPtwCtt0LDqtDdcbdZpshgeuknSDP4uhG/IXFgKQe4Qn7UvjG4ec87Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17H6JmffDfHkD3er1oQFBXSP4pl9Aln6la/L+S+8hRhhoC+SB
	2RAyHBbOwJrLigYQNBq90rMSdUWXvQ/Xlt9Dlb1CSSFktGruz88IMl2D3SCm4PGXRx7l0OtYhTk
	gIUug0zZ5fPW0n0y/eny6g/v/seFdlzoU3ofEToQ2
X-Gm-Gg: ASbGncu3mbNmL8r5aSnaV4OrF9SSzJG/AD4X/N3OY3TuJOelejNAfAH6/KClkJ1VAl1
	8VgTYzRlLJSzrKtjBN2nGzSdvmvNnZKHFcEJce9o5oMEMtVghte8NNUHPnoQNJCb36WNu/C8230
	kf+otvuGVrRDtYZOhxGL79TO+l1YUs+Y05HCI339NmGyxn5FZ3UK6QGs07R6gOywpGAsOfG7wRD
	O52Tn1RwCq/Z2z9zwMLvHx1qKPWkOv1RqEN8YMk1lxeZQCUf9XqWicX3xpcPyGcKp7hFxx+VPbb
	pDU+msJE0LM=
X-Google-Smtp-Source: AGHT+IHRMHJeg+OlS34CwVPeTSsJ6oKbe0SYtoe+2fYCZi20TFk6OnqX47DgEgm12EW1OVuqdS5DyjJt1m7YfsCFUbE=
X-Received: by 2002:a05:6000:4021:b0:3c9:2a0:1a9d with SMTP id
 ffacd0b85a97d-3c902a01d54mr8204739f8f.33.1756276488229; Tue, 26 Aug 2025
 23:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com> <aJ2Y21Yjs3a0CnAo@google.com>
 <aJ4Y_DAZe__0EWEm@yury> <CAH5fLgid9fF2fb06No9zmeQfru_nQicaM_9bb+DWe3zsOwm_cA@mail.gmail.com>
 <aK5KJDSDKiOsQ4gN@yury>
In-Reply-To: <aK5KJDSDKiOsQ4gN@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Aug 2025 08:34:34 +0200
X-Gm-Features: Ac12FXyexUrBaVTscx3URjfoCL-mSxtGR999p3jbzclq_r2ZesgUeNBJDls89MY
Message-ID: <CAH5fLgg0BXtbqR2Yw4xxsU4MWmiM0kz9CGCjm=HytAgQog4aoQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 1:58=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Tue, Aug 26, 2025 at 03:58:01PM +0200, Alice Ryhl wrote:
> > On Thu, Aug 14, 2025 at 7:12=E2=80=AFPM Yury Norov <yury.norov@gmail.co=
m> wrote:
> > >
> > > > Thanks a lot for doing this, Burak! I gave it a spin locally on
> > > > v6.17-rc1, and it seems to work.
> > >
> > > Does this mean Tested-by?
> >
> > Just to confirm, is the plan that you will pick this up through your tr=
ee?
>
> Yes I will.
>
> This series is very related to bitmaps, so I think my branch is the right
> place to move it. Let's wait for a few more weeks. If no any objections,
> I'll apply it.

I agree. Thanks a lot!

> Everyone, please send your tags if you had chance to test and/or review
> this series, especially the rust part.
>
> Thanks,
> Yury

