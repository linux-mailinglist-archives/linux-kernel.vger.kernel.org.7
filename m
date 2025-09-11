Return-Path: <linux-kernel+bounces-812578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D48B539E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3198E1CC3C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF035A2B8;
	Thu, 11 Sep 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0eDmjdkO"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F53568F9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610244; cv=none; b=O+oe9HAyaY5DAz1CBXzGSK/9lfZLlzITmFbE2emdZ4LgcgUBgHH8T0uKDTFpvk6u4gojEfoPwksZCXXReGZTXg775y8fEbjWSSDMFNzDHrR72yxW3IEc7bYbck+GW1cccLFQe6of4DbyYKuv1sdjenC/p8+XcDACQ/Kk6t2TN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610244; c=relaxed/simple;
	bh=+42IpGgvpU5Rb22QfM0/F0+oLnFIEFSa51EvfnlPZXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qkSzLIELGhIIldFDtKXxLkTkHnKeCBgkbq+w4DHgTIJPZovXsrgGprJ43bRcKDDGF3tF4GDpIJVAY/MTdl7SsojV4Twxs9d0fcnrGjVx1xtWhDWBBZczcTqoWhFK4Hvo7DDcumEkMMwjjugFxTHryOYGJReEEyodqbvpg4nlv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0eDmjdkO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b4bcb9638aso31281cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757610242; x=1758215042; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQgslLEwd32nm06AW1hca6ZfctObnHJl9ok4oFIr7kY=;
        b=0eDmjdkOIqtAfPX9YJvoF2Xorpnh75/VUIOhz5hL5RUzlMA2FCp3HEH4s+OAo4sMh/
         bD8h+z8S/VT2xkrRGgf8+qh2yU19wxZca2n9GeLLpx67bWOe8sgGxvJh/xteFYMetFxv
         8I9ydiqS0clYW9PV4dxO/rxrL/3oaewdduCcC+JklRCq5rYEtW4hU1iyeY5Dy0/j0ASB
         NIjzJ2XqCznH7/NqiroOVZkAYXOHnWvkTjrExMBz/TcLApQrjf7K6YDaEnV9SdWAy+QO
         UwYEO+A3uOclgqrojJqYWXbIRElaRVSRQZ+XPxMg+aWE1Bbf+Sc/SRRQCHPzewlI9opp
         KrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610242; x=1758215042;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQgslLEwd32nm06AW1hca6ZfctObnHJl9ok4oFIr7kY=;
        b=scQNNiycVwgZvloEw4r05yOOsV+5eGi4qH5m1HrQPayfmTuj/Vml/p6aX8A8t14o2m
         g+ALr3X/o1A53B4ZZjNDmFjOc6v1k9XhDt1AFW5zQ52Rj1gQFQy3fjRKOPrWGHpTeu8u
         s/NuX9Hng31k8rNUxRo1OiVaBWShfbmtAoUimAHNF9QIcEpw/1boGFbPUThsb0g2VdZD
         fkwvC3Yjd7DieJyj+/pwfHiP7BHhkPfQXGIO1WtbDs8Kg5EhKQ8BoFjwouDY1+fE2tKg
         4ULbgYodl+KSRaYdRqlAks6c+4YUd5SQ/285yycavaxdrjiJ0Yc1043M1PG9MekNrMA+
         2Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCW6QxgpbyNlLbVWwX3bIw+zXa9ufAM4gtHAhu2f3tKCKaVZWEnHYNKNyykOqhMpb+UFOy6GSrzsyU2X2TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxpVmSalsC6ZYOzxailsdD3wTMtDhdUbYVbxalNzBqLRuVGRV
	bD/qq5YBHGG4v3ppOR1jW0m0cpr9uGp36j7FE2x179mcM+M6TiHp+KW4wGQCI2l6qYsPv0vAN1X
	PzOkphB23b/lgXYkMRaG4U3Y9B9zBpwie6+0hyFNS
X-Gm-Gg: ASbGncvcs9a8oxaybpOQFjINLwX5Gb8r/vhm0AQSBPQNCX47RKtwwExlhfdTjSLf1RT
	IEjJtynduynJPA3dq6CgfCY/S6pWu2mrKHBMtkpTm/Yl+/Ho6yaPwFDMCktES1a3b927IX3bQxM
	D7itYn1pQR4ufRMlAHEhV699z9w6XyqzL4eOPbFauns1e/HJoxUYZRewmoLnZbc5SsEqpS/9U6x
	1bp5ti5uWKzSIymJlxLLVj7U7BZWw/SPcx68JFj7j2ORbrerpZv6+0=
X-Google-Smtp-Source: AGHT+IHqbiGah87j8zSM/09k9x/M4LWKB8k+6W9TDlBfbElMpUdW6cfAK3HgAE1jbY83Odjkmyb7AUicNQ8GOcD1nGQ=
X-Received: by 2002:ac8:5841:0:b0:4b4:979d:8764 with SMTP id
 d75a77b69052e-4b626f0f0f7mr14105241cf.19.1757610241449; Thu, 11 Sep 2025
 10:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909190945.1030905-1-Liam.Howlett@oracle.com>
 <20250909190945.1030905-8-Liam.Howlett@oracle.com> <CAJuCfpG4D4ikZO1c8zN7HNgLTAco1ggk21rg9AUFwoztA95qSA@mail.gmail.com>
 <dfd8b8c6-d697-4032-be2a-569b9629c564@lucifer.local> <CAJuCfpGFXbSFnqQtikNq0RoMfc93cLLnqrApq8211H+FpZpJ1Q@mail.gmail.com>
 <aw6vbshqvskf6lwql354dc7xn4dh445uaadbqoydzai3rnbbc7@j2lm7ryywi4o>
In-Reply-To: <aw6vbshqvskf6lwql354dc7xn4dh445uaadbqoydzai3rnbbc7@j2lm7ryywi4o>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Sep 2025 10:03:50 -0700
X-Gm-Features: AS18NWCx7qwqt4iajy7xB4ie291-ePMvSQJ3leQlwvyqSDueOKTvF8feEM27VyY
Message-ID: <CAJuCfpEuuS+OnARDNQVcK4WnYkWJ-3t5woCN4QMOK86OSUSAog@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] mm: Introduce unmap_desc struct to reduce function arguments
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Charan Teja Kalla <quic_charante@quicinc.com>, shikemeng@huaweicloud.com, 
	kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:56=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250911 12:51]:
> > On Thu, Sep 11, 2025 at 2:22=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Tue, Sep 09, 2025 at 02:44:05PM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, Sep 9, 2025 at 12:11=E2=80=AFPM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > > +struct unmap_desc {
> > > > > +       struct  ma_state *mas;        /* the maple state point to=
 the first vma */
> > > > > +       struct vm_area_struct *first; /* The first vma */
> > > > > +       unsigned long first_pgaddr;   /* The first pagetable addr=
ess to free */
> > > > > +       unsigned long last_pgaddr;    /* The last pagetable addre=
ss to free */
> > > > > +       unsigned long vma_min;        /* The min vma address */
> > > > > +       unsigned long vma_max;        /* The max vma address */
> > > > > +       unsigned long tree_max;       /* Maximum for the vma tree=
 search */
> > > > > +       unsigned long tree_reset;     /* Where to reset the vma t=
ree walk */
> > > > > +       bool mm_wr_locked;            /* If the mmap write lock i=
s held */
> > > > > +};
> > > > > +
> > > > > +#define UNMAP_REGION(name, _vmi, _vma, _vma_min, _vma_max, _prev=
, _next)      \
> > > >
> > > > Maybe DEFINE_UNMAP_REGION() similar to DEFINE_PER_CPU() or DEFINE_S=
PINLOCK()?
> > >
> > > Look at MMAP_STATE(), VMG_MMAP_STATE() for precedent in vma.c
> >
> > Yeah but UNMAP_REGION() sounds like an action while MMAP_STATE(),
> > VMG_MMAP_STATE() do not. Anyway, whatever works I guess.
>
> Is UNMAP_STATE() okay?

I think so.

