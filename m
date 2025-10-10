Return-Path: <linux-kernel+bounces-848613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5FBCE2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092C11892D48
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ECB26F297;
	Fri, 10 Oct 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTvspQ/W"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C27223702
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760118984; cv=none; b=bJ54XO+SPdFkFXguY6bH6ZwgtZNU/w9/vdDnKZQqjjjcTNFvoXfGMJvmFJJTd6/fmry4bLGrb54oi01ExkgftPf1xTKwp3kFq8kM9LrYCGbL7V1BS0ykBHSaKZ6Pr9G6Z+Ux14X7cr16uUJeHZTKz4QU1rWXijZpWpbU1ehb0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760118984; c=relaxed/simple;
	bh=FYddxNKVlvuxn6KRlr8ziTyvw390YXyBRvEtBSMfX/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmPrmvMJbC1y24S/5W63O6D4zf1f1YXQrVMiPwXqQq4A6Z5u3rqHN3fxlimkKVPrf7OXYHxBaH+EA8CS92qabG5d41dECA3i/6HSAg55wekt8iEJlfUXdJyiPIgT+6IfWzY/MTpNcaDdjvl6qpEiI1/w5+N52JZF8at/TT8SLrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTvspQ/W; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2697051902fso3680875ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760118982; x=1760723782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCmMvXhYPJMDbeiu4F6ExT6qgUVkPhneV+v5LfsjIUQ=;
        b=BTvspQ/W2+kAt3qpeIG6dku0bRD1aG6lWjn9Yv9ySU/hLPrTGo6btuJPmsK2wahXsN
         ml1syTYtH9qZaIHvfqQgZXHhwwjNF6e6h9K57II5aieFjqAjnvaDXF9ZUM6fwR/ktyIo
         ZUfGIk/ZP8qMYlT/EnMStemHmuGl/KnK7anFMo9/c71ZbFoGFVQB7FwrmhXe9L3l7dN7
         Zs4fMThDEQqSEZ/nLdjtw1oZjOXHLtViMMzKvJA1Uc2VGFF6zlaA1M/YpT9F7xWQz9Kg
         8xNl0r4e/EIc0H1YfWf5OObTwAwdgqhf/kA0+mBuSPI7SdxcOZaXQCPHuEn3ubL+jsRf
         tTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760118982; x=1760723782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCmMvXhYPJMDbeiu4F6ExT6qgUVkPhneV+v5LfsjIUQ=;
        b=D5oq8Xq4BQ7k63bCZeiyvdXGfZ6RK3n/Jp6kjXLy9tybXc7c6XhjDu9Y/5mUGN5I1P
         VHlECRT0xbGav7xS0judRNzbV59AEM6CVGObkwwfMtF2wlxG1coKznSKirwyzZXMv5af
         K92pCkz4w7MAj2szDmqRUm/ulZcXtaeZOHkjWJNawuvao+DKsUYKRLSnbhok3kmbRZqA
         rH+xYL2ckKNQDTWfClloq5UkT0oyiesOpn8A4ESv6mVLg/IXap0noAX16ZsFPsT7ff2V
         8lrhuDeO23CJ3F9bPD2DqkV7+x6VdCANKyEHelldkKfRV/9JtMyBC/6kMgBKMWAG1ftc
         lzUw==
X-Forwarded-Encrypted: i=1; AJvYcCXw7v6iCVuBftEo3So36awDGj7suyunlE01NrCaM7fcr9jOrtmHI/D4k0FCE9h5Bg606aoJMgtzEM6H6io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6UO+385DK/V9c07f8nOhD3OLAD3iZROWlacl0iVNedNaEWx1
	ySHcxv28D6uys7QlE73zBAPHKgfFFpwJFMVpOFnF1phFoWWifUo7k5iy7OKjwLar1GhPxPzecEb
	Jp2UDFHWUcgXrEM1bxnq3B3a1Cg0daAc=
X-Gm-Gg: ASbGnctJ3Dx/VzcaIJqxzQDD1Pt50r+pFL6LH98Pg39CDsLtjF5BNYlYrF1WimKe+Fl
	jE2mxiHL6nBsQo/NsL91LQ1wXtyifpks1bp23OanC5nMBLN7sHHyRlkJ+hG1+OyuT+48eeVDs7V
	1R1j6Xq3UYlJbzzFmO3u9q+PVInXCGwZCNr7RHoELRu2zE/DnFBLvo0DgLmtnDA2/qRfh2GD56y
	7u+Sp2aLewSUe5WxJ2CrozstuMxw7UMxHRrKaYFvQThJ0AHQYGgZBCqEBe/h073j0QpZ9edoD7A
	SgJib6aVjNfw9L5GLr1Ai5nEKzmZbstayxzvYf+ux0bS
X-Google-Smtp-Source: AGHT+IErDZhGht8Q40upZIbRDfo9H5F5zwiTUHyBtlxroHX0A9XfFZxl4TsHpOiRcasjpaOjRktRyfefCj5CGQhZNo0=
X-Received: by 2002:a17:902:da87:b0:269:8407:499a with SMTP id
 d9443c01a7336-2902723ba15mr96224555ad.1.1760118981915; Fri, 10 Oct 2025
 10:56:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
 <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com> <3771775.lGaqSPkdTl@hyperion>
 <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com>
 <CANiq72kDB1cX1XXX7sc3yQvnaUUYB8q1wVKNxykv8=OV-=rWuQ@mail.gmail.com> <CAHk-=whe8NLsT-TnBxzzW8sCL_X3BN7zv5ELVufy6=sZ_k=uGw@mail.gmail.com>
In-Reply-To: <CAHk-=whe8NLsT-TnBxzzW8sCL_X3BN7zv5ELVufy6=sZ_k=uGw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Oct 2025 19:56:09 +0200
X-Gm-Features: AS18NWBHmzOKd8qIpJZZyZFAg4-H2OpmRvLlXowYddpXdIHzElTdr46iW0guefI
Message-ID: <CANiq72mhc6b35=cZ0Y4N+gRpX_x8FYJnnJZPgS359KnREcwWAw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>, John Hubbard <jhubbard@nvidia.com>, 
	Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 8:35=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 7 Oct 2025 at 10:21, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > We can use a trick today to approximate that, which is adding a
> > comment after one of the commas, e.g.
> >
> >     use crate::{
> >         fmt,
> >         page::AsPageIter, //
> >     };
>
> Ok, I think that's pretty ugly, but as a "waiting for official support
> for the magic comma", it's probably about the best we can do.

Sent:

    https://lore.kernel.org/rust-for-linux/20251010174351.948650-1-ojeda@ke=
rnel.org/

Cheers,
Miguel

