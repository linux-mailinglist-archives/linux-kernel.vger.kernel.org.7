Return-Path: <linux-kernel+bounces-796349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02216B3FF55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608303AC616
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447E2F7465;
	Tue,  2 Sep 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRu5uo6M"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACAD2F4A18
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814359; cv=none; b=KQ07y1PT4pa9SUX2gDBfv/83yvFvH1AL45/QRFucjrrt5C8+LWZld4K6SCUeFqyeoePHOfnlGTeBXkiD8s6waYtBg42jQeqxnvcH7EdtpjZ8cXBNKkcOFiCKhVNots/HbRofWmg+3C9xAv14/NrwDhNUWL7r3bbM4Gnp/Uw89L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814359; c=relaxed/simple;
	bh=aTeSGYrDCcpo0u9+UOoja+bqdImlK8vqFceEZiAkR98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eI1iXI3Os8ACpnOjnkxGtuu+LcBDdN+9WLn41yIJFMNZ0Z75XN7QORgcboH1R7BYuVfttw5zt0NKyiAOiK2zvc6bH+s0satsxiNTxCaDUj21z6d6+6Hv5HjXhYK90H+WVi8dA/XZ1zx9WQLAtFh//wrLrnrgFeEpk6wHilFI/sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRu5uo6M; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b00a9989633so548719066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814354; x=1757419154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/rRTNTgDeV7WZN8C7XdtIQtoR+krIiqqTl6aPopePc=;
        b=eRu5uo6MqGSJ0w4vW/zp/xJbeHGarJ5GuUVCM/+di4xNkt9GDnrtu2oKDpC6W4iBZM
         ntRRgWB06eIIMu3tqnkhQoJzv+Vmuj9Ol0btG/PEgqpfI5nh6GE5mEhZOZ8nDy9QjF03
         UCERNeUloCcuNMRa/ZLgELLtwNiYyPH/69S2Koy8rj5nziGAzItvCDeBthAMbmnrBCaZ
         teDIREsP/V4gC6uJuABIk2aKkUE73GRscps0NYwlq0hI2YNNBQ3X5TUmhc3eLHOHjvwF
         4CA/Ts06Dbr7dE18S8ZAziDm+9WE8v2PCYE7kUqcFqu/ktx8hgy8SUdhYaiixhVXyplw
         csVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814354; x=1757419154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/rRTNTgDeV7WZN8C7XdtIQtoR+krIiqqTl6aPopePc=;
        b=V6WM8rdMuvXzJVgWu7EBN3mN/RhHBmcv4iGBLI5vMSEVP+kTLXuLlRudZYnITQHMJ7
         MIznF/4YAAjFDAmMzxN5zs8U6iR7LqGBx2VN3UMDgTTQJE4JieBNLrxf5Gd/BSaHZQbq
         WzfmIEvfGt/SRYh1Bi0WMINg8A0Mn1QajiUfzd5HFelhmtrJcIu2jHWD2cIUOYxpJ5CG
         NoVWa8Hw9t1vyKyghsGR3gd8DoS4pseBKx5bbaDI8UqSEuv3YzFFhBoFhs8qRVdfgL5D
         lgu7bb8vwSVNCat5rUFfFebp3z8OK8zt5tFRxuEtrUEpKeUSAx4Becn5Lu36bJ938vrJ
         Remw==
X-Forwarded-Encrypted: i=1; AJvYcCU16G8SmYF6ruObq4ZFUaMDQZXGzodIrFuENVBlfwLpzAzShAWQGOJFDCtLcuI+jRBD5f0T05SqTKDY10I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLNj5B2CUEQRbKeqxwoXxnqmpoUSTu2zrzWdhaxWuB0W9j5VA
	2qYUWtQcdsmwAv+Cs0dsrofpiO32Zd2Z1B2jvM6ep6avXtajtvd6bz/3VQVxpAmTByxCgZ16XZy
	TvKj1ZxTkqGgUsmFY+DKhG/91r4PTN8k=
X-Gm-Gg: ASbGncuzq/R1EjY8zUt4Jk4G4fCwk1eDMvZgxVlnmv2p1V+kormfKsDyOWDQd4WVUf1
	A3sHd92dCuX+DtKGOs5qY6yZ0YmHakIb/UkNC7k5Dw3r9g80Y2YUP0YrNRxs3HmQGedpIGP9d74
	T3v7C70AwRxhy0o64yCYjw/D4eOH4hC9Om0KRLH/Eplwn9L29+a/gFtKFvdqYFZROVG/HMrg6G5
	orhDdtqdMbGrF6VYsl0Ig==
X-Google-Smtp-Source: AGHT+IH96vNCRDYjRrmA8BrrQLQupz7l9Z3JuWlZeRrzq3CZkEVPsZwF1xPwnw1X52AfWmVbpiXurN+uWD1JeqFq2qY=
X-Received: by 2002:a17:907:940a:b0:afe:159:14b1 with SMTP id
 a640c23a62f3a-b01d8a8b621mr1294060366b.9.1756814353782; Tue, 02 Sep 2025
 04:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
 <CAGsJ_4yRa65ogB0d90LmtOigGTqQ9mM-eUU6VbmcX63j6vgHEg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yRa65ogB0d90LmtOigGTqQ9mM-eUU6VbmcX63j6vgHEg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Sep 2025 19:58:37 +0800
X-Gm-Features: Ac12FXzMS08RqhaPgBLjPU1ESc3Sp741JjUDRDBoHqptC_mA9p4mUNoPzbg6dBo
Message-ID: <CAMgjq7A5Gr2V9TDFg=_S+SjZ1r1gWXTtRGNofuzAgWNYLMW_DQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:46=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> > +
> > +/*
> > + * Helpers for accessing or modifying the swap table of a cluster,
> > + * the swap cluster must be locked.
> > + */
> > +static inline void __swap_table_set(struct swap_cluster_info *ci,
> > +                                   unsigned int off, unsigned long swp=
_tb)
> > +{
> > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > +       atomic_long_set(&ci->table[off], swp_tb);
> > +}
> > +
> > +static inline unsigned long __swap_table_get(struct swap_cluster_info =
*ci,
> > +                                            unsigned int off)
> > +{
> > +       VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> > +       return atomic_long_read(&ci->table[off]);
> > +}
> > +
>
> Why should this use atomic_long instead of just WRITE_ONCE and
> READ_ONCE?

Hi Barry,

That's a very good question. There are multiple reasons: I wanted to
wrap all access to the swap table to ensure there is no non-atomic
access, since it's almost always wrong to read a folio or shadow value
non-atomically from it. And users should never access swap tables
directly without the wrapper helpers. And in another reply, as Chris
suggested, we can use atomic operations to catch potential issues
easily too.

And most importantly, later phases can make use of things like
atomic_cmpxchg as a fast path to update the swap count of a swap
entry. That's a bit hard to explain for now, short summary is the swap
table will be using a single atomic for both count and folio tracking,
and we'll clean up the folio workflow with swap, so it should be
possible to get an final consistency of swap count by simply locking
the folio, and doing atomic_cmpxchg on swap table with folio locked
will be safe.

For now using atomic doesn't bring any overhead or complexity, only
make it easier to implement other code. So I think it should be good.

>
> Thanks
> Barry
>

