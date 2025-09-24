Return-Path: <linux-kernel+bounces-831268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D655CB9C3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1355519C3D79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B8F287505;
	Wed, 24 Sep 2025 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqezrkot"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C49287252
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748065; cv=none; b=latznGuNuZ+5rLhjyUB7oZGkoAKquEUMxDs13gVqOByffw8dQ8TwM9hk+JogQ1T/AcT5xHzEknHs6Z+jPImggE0o5zI9W5vk/xeMRs1G1WzvcK+X6npAeZm8Jdm12bGGGDANBshnjDmsdO/TVsbrOVs8oCpCamHKSHOYVlmlV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748065; c=relaxed/simple;
	bh=gE7xr797IjE97kDTlx6kiGCJ5AYi5oF7DWAxEs64oWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGRq3feydK0msG68vf3vFXvjdGrn8HuodLBwPFiqHghs/htxPKLC/+63gJX10kcSPQPBdMlzj8RKChrwb2YPPlaByn/ypCdibf9pPPd9S6K4Fj+cG3aUhEpJt6oN0t7FnF8Sx1lW8HioK1WId4RRNOj1Af9LmwCG++NXBK/yNOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sqezrkot; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3612c38b902so2009681fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758748062; x=1759352862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE7xr797IjE97kDTlx6kiGCJ5AYi5oF7DWAxEs64oWE=;
        b=Sqezrkotx+/CanMpSaIhtBtFjn5t41SfSFs2Hi+Q5ncLAt3lIM80PsjhO70u4ercYc
         ggU2+MYUCigpqC4gJS+FBfVMiZa42X3+nXIlyKByoOAZBNvMn/lIwV4yfLPeJzyOR+Q4
         7UKnTNVSVoe1nHEcGVs09i9Y2eU0XPi0GTmbixgFPEuT3avjTY5OJBRqQX6G9zOG7zyB
         NKEaGhmzyaju8KUeP+JbQVIpAmh7RYrEkm/zZC0RncYt4un/Vj3tEF3CyiOjUk3ys11h
         J/0MGeO4cKnpbWILU4DvbhXzqzUIkmH621pmAUgWxBSygtpHu0r5KQa2NjbE65vHxmLh
         8Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758748062; x=1759352862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE7xr797IjE97kDTlx6kiGCJ5AYi5oF7DWAxEs64oWE=;
        b=kb5KKfnlWoWdmcjWuvgtKJnxAJKErjWdw0GFMTJVOD3wL+FdObY3RdUP1zBDdUj/9n
         NZFRU3KxAxgvZVo71nwd/khuMhaRJpvbIufuHMjvAzn8h8yeA6Y4G4K6F7Vwt/pR2kqn
         NEdk7xFHAgZ/+ClBARkK0j1Hg9eT+uZJMjxPNDlIYfYN2D27Quq/K7DUyo0YGlTGPD/P
         5QxDsFBPvkG0G+52bh575wHjebKC1gWdloRR8wmakBoHtGjNRr8yrF1smWI4w/YgTWuZ
         UXadidSAs+9+3Smgu85DDDj9IKuYnE/dTrj/KCIypZ19x5dI4SFAl6mO3nN3iOAuxqpY
         NRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3H6HO1DyTEC3mxOGW/HjWq9AdWU5YPTsbfKdjFI4K7B6liHqm8zwpwxwjeyyZa4kqLUJDBZ5QfNJOks4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrU0STH3g/RtAOuoSdqf3sBlk7ePw5qMAtL4BjwgoHHquEms3
	PIsjfD53SskVYGKf9DF4CvddeIz31IqZnUNnpXuhvrOvBiE592gm1VEMZTJEUrtIu+vDPs9UZcB
	taMDIVZ+Hx1BUg7T8IEvGxj6YoDi9l98=
X-Gm-Gg: ASbGncvZRTFPm+KSxBofI1/CyX1pYGCh5CYe6tM5U3WsXHZCnfS+k/gWY/M5yEZfvvh
	fF3u+RG3tgG/43HPCgiAx/Mp6z8bIKjRRzb5CyHE9AdGJ/vrsVJs9mCVXPHje53OgeVoR92wuOq
	DKQQkNgI4ziZm+bB7YtyQpeJkzO9gA0+mxtaNh41oqi7YfQaUm1dIVrOIsLhhP2JFPrydvNSQHP
	oSMrEc=
X-Google-Smtp-Source: AGHT+IFJPiaImNUPooT24I4Y2aFWPRjLkZZydE30bY2itAhlYNr+0vlA+AsyScyy1wD17a1jFkKVooka8O95a0ZzO/Q=
X-Received: by 2002:a2e:9a12:0:b0:333:e590:1bc9 with SMTP id
 38308e7fff4ca-36f7f2481d7mr2143301fa.24.1758748061412; Wed, 24 Sep 2025
 14:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com> <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv> <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com> <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv> <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
In-Reply-To: <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Thu, 25 Sep 2025 00:07:24 +0300
X-Gm-Features: AS18NWAbw-7uGsKJ0oGYd7zu1yq2_988Moths_iRDqX3j-B6KBGWgGPm02szRx4
Message-ID: <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com, 
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org, 
	vincenzo.frascino@arm.com, akpm@linux-foundation.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, sj@kernel.org, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 5:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > Since the Sabyrzhan's patches are already in mm-stable (and I assume
> > will be merged during the next merge window), just rebase your changes
> > on top.
>
> That's fine, I will rebase.
>
> >
> > But also note that Sabyrzhan is planning to move out the
> > kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> > I would have also asked you to do with the kasan=3Doff patches), so
> > maybe you should sync up with him wrt these changes.
>
> Hi Sabyrzhan,
>
> What's your thought? You want to do the cleanup after my rebasing on
> your merged patches or you prefer to do it ahead of time? Please let me
> know so that I can adjust my posting accordingly. Thanks.
>

Hello,

I can make all necessary changes only next week. Currently, traveling.
I will send the fix-up patch Andrey has described somewhere next week.
Please let me know if it's ok.

> Thanks
> Baoquan
>

