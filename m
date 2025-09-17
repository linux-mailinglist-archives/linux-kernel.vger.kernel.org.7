Return-Path: <linux-kernel+bounces-819950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96170B7CCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C29F582DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B522798EA;
	Wed, 17 Sep 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4a+wE2r"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA6E26C3BF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081252; cv=none; b=oYqwOwAw0z3qy53SUS7aI1UTdAb0ve7nA+4wbr0jzUB8q+UPCQ3eBOZh8AVhiO59AshkPs9OFFELR44l4pFyMJzqgP9hlDe/1XW+6274YUvS1xbQFnA7Bj0nO3LBvZVSnj4q7q0rz3oEKrWDCfaXz07VCeaYBlYjkZc98b4B6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081252; c=relaxed/simple;
	bh=+MqiPb3ov0IKVWlpRr7bR9ZISO7h6uwkFV280vsZjH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euAYo/qBzCc6ciHR64U/KF5p4uIIQQjBb1XoK2ur5Q08IZ3nD7nFOAvIerUiS1xICXUwq20FnYelSUJJxod5vQ8y9HH5ReTvcVB8X3Rl8OKPfAGbVFiD4GT5TRK8xyXeRuKqER6+LuwF62FKU96lkEHs4Ak5WZ1c/dzfSo3o1PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4a+wE2r; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so11162287a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758081249; x=1758686049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0QwMkAAX/U3GVYuIcwJivoYCBq4VWe1sqX6AUImt4s=;
        b=J4a+wE2rPhXsKu88z9r6VN/MHyN3EzIIclg9DqqRfA0MtZh+lWS7W32dQrM9a7VdvL
         5lEtSJJAJxxtoFXu4NgaGNIjH9JRjnrQ2rS9rKpz8WEcCAhU0vb4KraWz17VDMfsKimK
         rNc380yrIkxfOUjyNMK8q4+DkdsNlYkiwOMW1DdGAzP4Y5KN3nqgZUYO2x06JAdk7Wiv
         ht70g2nx5U1Uxj4zrTnqNKqC96mkKitGM3WvEmBu80o4IkxLIGgPgMUIPo6i9ov/OdY/
         pBOeS/hh8rx0phwryt5XGMCJQG1JdeobXLr8fXE97AFEm2Ggd5bA/ccit4bh1lCyQJaO
         ZCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081249; x=1758686049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0QwMkAAX/U3GVYuIcwJivoYCBq4VWe1sqX6AUImt4s=;
        b=iQX+9r8bNtkWobllze9KBeV01stRgepaHtJbq793ooCiKZ5l6LxQUhJv50YvXFxbw7
         6aKtEz82h9fCS1peZPAojM+Mn+wwXk5wIv1Ua3stAVrvB87CnRGmbSVBAvxWSJZgjMz8
         CnoC5WiX5Ojq5CV0tLp3YgZGjDoo6LvxTJD7t59x7BitZr9qJWpkGtlHDAwKqgK66V7F
         fbZqny+e0+9Rf8CbKDTOhE7xRp82MSnXpATkTTFxc+UQWqbgY0GSYeOkW2X/LjA9qOHe
         ulD8JYXVVfGfczQH6NPtgHwfsSOgGoZBi1VDOjnWVPf/oji/YnJHfPa3l1n5msgGVl+b
         kDPA==
X-Forwarded-Encrypted: i=1; AJvYcCWrw+4neIVCDJAj0p1GDVHebE9FOSbFTcwulLXvb44rwTM8xfPV3nPygAZEUZ9yv/MH0JR3c6rMoQsJrnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Z9X3PsF5uABQkzNys3dvoOw8TJT2XLD6Wi0Aqo8Mxq8Pm35a
	IvzM7Ti6cLdoEKSe0Ck6bQcRYB557rImhWOaNMGihnm6Y7plAQ0e9MGmcgWZvGv47gNI0iBuKOm
	BYCpPNSDVaaI71ns/wLCGnzG7pCg/tGY=
X-Gm-Gg: ASbGnctlODE6dLOFblny6plfJc0rwhdE7P50G4tEcyYKw/XfNDfupeDgvySK5lZpGet
	1zIhUxiLREZ21+gpGzdcCcdos/nLEEWtwZCyqXE/qSE/GVBdDU+yX+7x6G6+XCY8TbEkbecyORH
	3wa0B4wq7L63oOHP3DmviB/2Xie7jo3cyoSdy71t+n0N9v9HeKUXmeIkXyzIGyTev8NWElmOvDF
	4p079xOGkE=
X-Google-Smtp-Source: AGHT+IGhRbEhR4Oo2vBtn2h/CPfWnxXTyRl5ODWLuAjQjfM1dwrXBEVwTAXFoqpp4dj/i/oD+7ds9W6OZF+WhV/3FVI=
X-Received: by 2002:a05:6402:52c3:b0:61c:7090:c7de with SMTP id
 4fb4d7f45d1cf-62f84222764mr901341a12.13.1758081248924; Tue, 16 Sep 2025
 20:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <99f57a96-611a-b6be-fe00-3ac785154d1c@google.com>
In-Reply-To: <99f57a96-611a-b6be-fe00-3ac785154d1c@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 17 Sep 2025 11:53:32 +0800
X-Gm-Features: AS18NWDLbQi2oDznlq4BBqwefgqt9eAxrqURM48ErVF0viZ-1CzrWKG884E532I
Message-ID: <CAMgjq7Dx51gPWfE0eobNQBtMzUDwxuaZrrSDW=q2CsVqBamRZA@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] mm, swap: introduce swap table as swap cache
 (phase I)
To: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 5:23=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Wed, 17 Sep 2025, Kairui Song wrote:
> > V4 changes:
> > - Patch 14: fix potential cluster leak when attemp a sleep allocation o=
f
> >   swap table: Just remove the logic that check and return the percpu
> >   cluster, it was trying to avoid fragmentation, which wasn't very
> >   successfully and may not work at all if there are multiple devices.
> >   The fragmentation is not a serious issue and given the chance of
> >   hitting that race is extremely low, let's just ignore that [ Chris Me=
son ].
>
> And in Patch 11 I can see that you've made an important fix to the
> !folio_ref_freeze() block in __folio_migrate_mapping(): there had been a
> swap_cluster_unlock(ci) which you've fixed to swap_cluster_unlock_irq(ci)=
:
> I was going to report that, with the WARNING and "BUG: sleeping function"=
s
> it caused, but you're ahead of me.

Oh thanks for pointing that out, I fixed that some time ago and forgot
to include it in the change log.

>
> Thanks also for fixing the shmem_replace_folio() locking and stats
> update, which I'd noticed too (but never hit): looks good now.
>
> Hugh
>
> > - Patch 8 & 9: move some changes from Patch 9 to Patch 8 to avoid build
> >   error, no code change. [ Baolin Wang ]
> > - Patch 9: Fix locking section issue, should protect the shmem statisti=
c
> >   update with spin lock irq. Also fix an warn on condition.
> > Link to V3:
> > - https://lore.kernel.org/linux-mm/20250910160833.3464-1-ryncsn@gmail.c=
om/

