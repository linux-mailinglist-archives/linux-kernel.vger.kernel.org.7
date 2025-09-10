Return-Path: <linux-kernel+bounces-809972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3A3B51426
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764774E827B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A322C0F8A;
	Wed, 10 Sep 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vni4fn16"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC52475C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500856; cv=none; b=WH9qrcnrtwHUcG9VByquOKmg8S2qw3FQ8XWGuLDSYnJHOpnaLH4HQGTYtoUvkuwUOJNPUdqzyva0uhTtssaHt50yz6CpUwXGNcb6rjAbMz7SkRGH5jmLMeNOpl3KfQFh3626kZNPKuKTkEKHjepsfWj+j35uyTLruJQw58F4+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500856; c=relaxed/simple;
	bh=Wns6sS2pcIr3iv078DE04wA4JW/ZNA5tmPg+ifTffxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrNqTrVXMiJjR25jlG2skdRm2Vn+dV+5PbgT/cPOYqZxWKngdteQE9AtRVWGbEIQ2Ak9hs9MV7pkFs+FssMdENz3D2Uss0YNIPwUQ28BIYBgKLdyLktFunr6Qg5JSQA1wdgyC/QRgtw+xRG/LqFYGK+P0NKCLSFBToQ35BTmo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vni4fn16; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3dcce361897so4409031f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757500852; x=1758105652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wns6sS2pcIr3iv078DE04wA4JW/ZNA5tmPg+ifTffxM=;
        b=Vni4fn16IehxmfrbrRk3IeU1cH2Nioxv/tYoGyLN9UblLa8v9cJTqmeFF9seqX5jV7
         2i3zCplmQ2riyU+FE0wJypDG9/i2xCbYRZe0C0vh7dtRuUyeb7yo/yM+PcuuSzXdmVNm
         Nvy2gyB+dsFwK85RSmuAI2D+MWYIo1OWwWI3wFRHKU68PZTQa/N0lRCrqxiuG8m1HTcD
         QPDKJgAqQWBOTj6Y7gDk6mNGrLvOzcYbvutSMOaW8ujb6qrGMffNeFzB1PihdQtvFUId
         RGBtmngMbqNpJz16Fjc1qOrT5Zayda6pMCrUm63qY3E7J056+hy9WY4A/B5Cv3AsMsMy
         cmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757500852; x=1758105652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wns6sS2pcIr3iv078DE04wA4JW/ZNA5tmPg+ifTffxM=;
        b=qyKd/pNWu7z5fMaeKB2FUEJclJbdGi8qRi620EpyA01M3J0QNOxjJRbg57gydyyX5t
         xIuHLjRmjskEHpdd9HIJFFpzFyHjyZTLsmdwtebwDYR+pzHbjWB4UuvletFbUM5FJO3E
         n7hftn+LXWMbUMSYZtf5WuguwRXaYuf2OqkfMOPfodR57tfG2yX6MYXYDhG7MQL5CPA3
         tSsOoWdqIYzjl3Fb/GLWEobFoAqtF1JrH3bxtrwX7jo//BWGbCXLMuZt579kH3hyVLsN
         h6MRBAsrxGwzYY6YoIAR9aijIpgNyXWxhaHh0v7gcKG+uOEJJ/TwRRXZbFgL5yglwQl8
         KYHg==
X-Forwarded-Encrypted: i=1; AJvYcCW+G6HtYSCsgAojK0d+/T7krGIn+i8Xm1TNEjxGnH9bri3RByODyphRaxUNSOBtW+Lg+jAFFI7Q7EJNiWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UvwYr9HUIqNlUhLX5gra/F+LR7mCFYZWVF/aMwD2rxdYoekK
	u1aZYaFdt0vRRqmXLqCaC0be+yMpTHWxFWN1PjFxDeWBdAy0FsV8s2t+6+nEWjVo5NJcJN8CgoZ
	yMbcVbLPwhbj9tce5wHLXeBgqmIJWkF9LMeOZaoNb
X-Gm-Gg: ASbGncs86D5BHvvrlEwRbPFP4leA3A+2caP1UzgUg3bnUZEiis9FabQEvyMbUZvadU3
	Oe7Haes+/qQfYmu4PRDr+K6G+3FM6U3Je/kECuBOHKSp8Rz1t8Lq05SpSy172Z/ax5uwznl02Aa
	QdPFh2e2ZzlmaheiAkzS8JVZd4naXFV08n3hb813FmF5duZLthZ3j03RgjYdafvVpwDdaeUD6t0
	mmigvGuMWxfpSYPMggEGZ4IKuxx5JaD9eaRmiiWkX11+Ws=
X-Google-Smtp-Source: AGHT+IFyoqz+yFl9emZ+M8hdpldto4NzhxwR45/60xCqklRMedBpcace6NPWfsvipC8Nylf2dM38FdnLwjI76aGtoDM=
X-Received: by 2002:a05:6000:1885:b0:3de:e787:5d59 with SMTP id
 ffacd0b85a97d-3e64c3ac7edmr8097730f8f.50.1757500852380; Wed, 10 Sep 2025
 03:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910100755.2361281-1-lossin@kernel.org> <aMFQL-Hq1KvBG5lh@google.com>
 <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
In-Reply-To: <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 10 Sep 2025 12:40:40 +0200
X-Gm-Features: AS18NWC425qAg6IjeBoODYU3Z7WVEBCQjIq2zbB60jPOkQv7VJ_nQ7wcD4ZftVg
Message-ID: <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
To: Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>, 
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:36=E2=80=AFPM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
> >> Assigning a field a value in an initializer macro can be marked with t=
he
> >> `#[bind]` attribute. Doing so creates a `let` binding with the same
> >> name. This `let` binding has the type `Pin<&mut T>` if the field is
> >> structurally pinned or `&mut T` otherwise (where `T` is the type of th=
e
> >> field).
> >>
> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >
> > Is there a reason we can't apply this to all fields and avoid the
> > attribute?
>
> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
> might be surprising too, but I'm also happy with no attribute.
>
> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local

IMO the ideal is if it works without an attribute. Perhaps trying that
in the kernel is a reasonable experiment to find out whether that's
reasonable to do for the general language feature?

> > Do we have a place that might be able to use this?
>
> I didn't find one, but Danilo plans to base some changes on top this
> cycle that need this.

Danilo, what plans do you have?

Alice

