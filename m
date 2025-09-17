Return-Path: <linux-kernel+bounces-819966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E7B7D4BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FF1165B11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 04:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E11237172;
	Wed, 17 Sep 2025 04:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7KAesK8"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CD921D3C0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084083; cv=none; b=XQ4h/iHFNQ8GzW/DGa/UusJdLmzFk3y0bCOs7xISpMeUZ9Ias8kWDjqL7xxUS6Ceo5mToGzly9g4Facfu6G469kSxL3auIp49ZpDghlT+qk5C5b7sgqBotMVP7IGLloq2z7b5/3+hHFOy+JK/5S19sr+JmK9mcHe7myMMNFX7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084083; c=relaxed/simple;
	bh=FC8Zlz7B2gfWYoOhm8fGqe/rxWWpxRoPofvijyUDX6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbFJEYXtlTaf013dBCGIheXAIlBE+5dvv5uBX6hIV3V1M/QnlDyFtg4qrYAZwstmn6/58Z2tDHMnvaCcFqa+xtmlArYTPJejRqCBjdwc+VCjFVv7OlCkbW7bZGvlJb2tQ4k/kmnshYFznWPrmzK18wqJqR8ghOyz+HETv+eloNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7KAesK8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-827906ef3aeso359656585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758084081; x=1758688881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gon5BfaqGtVq5KGh55kJh0yGA0JZXCzjrgKlwNh0aHo=;
        b=C7KAesK8vDOvzfDiJLhAtxUDlmfVX/j9BwPG7X5Lfi1XcysPmtixSfnMdiADZssB+q
         MPXpKZtho6+SFl4JMew16oFldayhqmL8DDt4ibq9JFde9uGiZKNbBQpl7KqoiiEfgg54
         JjQS9B13vW7KS5IEg/MW8gX+sZioBDYtmXdP8gVieOTh4xmgL3zMFqd3JDy+hNrlsZq0
         JxVQfDUaTnJuZa6TGY1FMnVPS/V+LsbK32KQrofTND0YIEvRbotIKEHfdkuRR4ySnizb
         kSnCRMwApXPbCcVIG+3BYMVQrz3QEJkoaMMAEiijJiWNEO0p3CepVLGN0ZF3hXzF0hpZ
         ECtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758084081; x=1758688881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gon5BfaqGtVq5KGh55kJh0yGA0JZXCzjrgKlwNh0aHo=;
        b=ooTrtM4cByIKjloJqIF1Ce/ZOTjT0xNaCyF7r2Pj0q4EHzr/T66ZXf2fldHPUEagzA
         D9+4V+Kkx/ttCKX+OTlujnhZ61UfYTjyuXimRnrkmZDXtAT+UGZP9BO/Qvmht5GOb9tL
         HJblmQvBpNhbFJSXdZAW5YLm2XFl2IKN/GU9OjB2YzyU4e8UWfGxLr+eurXEQbKRyJYi
         Qk2Al0JR9jtiVo1qm3rb6M+XdzNclVU6FUNER3QuW1ZylBilVeWPibskyCzNcMUrgNxr
         9hHqG4qHMzbXplrl85WPx5bzysAvusWVeZ6hH2TqtFxPUpWgfuLb4OlyBAS9H6BiZCRK
         wWmw==
X-Forwarded-Encrypted: i=1; AJvYcCWzIyLesXDuM2N4Yh2TeROZC5Z3934EQBxNRxOhRcTfBlYYicHmSyU8Di+Hk0F1HGEuexMg7aRbNBpF+e8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8i0/QJDJWIM9ZDzD2+amh+qpOv0rKQ/3+ZI/Ba3Xp4IPYFlXR
	Ma+T7JtAdlkOJP/S1Op5S3mbfshHG4M6FPP/l2ak3UYQY77zSiXT3ALSTBCQuMp77zABbh/zU6H
	tsbMUyRLjpK4MekTKzU11uhzC+dkLeUs=
X-Gm-Gg: ASbGncs63UkkketrRxdfR1+6D2G/8KLq71BOaB1vBqdSNt5XCTf/L8M/WWemd3QanbU
	oXxRlnu/8+rCruzuVz7jpdQEFAsuZHEeFbeemsFlU16qzWxGV5GrmOT18Blu9rbO/gCwRXPaf9P
	F5jqeszfPrK5HJ6Ght4v3MFKrPr6pT82jXoM5tUB/W5uFHVgghjxulKYy6R6XOCfiRLYWfCMvzM
	jwI52fti6e4GYJ9x65x5ub3ebxPk3JjgHXrFfiMhw==
X-Google-Smtp-Source: AGHT+IHmqnmNEJt9Zp7ueUn+TKxIVVriRysUdeARSQEDPs7LH5hJe/p5khqKRU5SiZkOkKGakYwYphqODKUWjZXhZZ8=
X-Received: by 2002:a05:620a:2887:b0:811:76d4:6d5f with SMTP id
 af79cd13be357-8311053c402mr73152285a.60.1758084080693; Tue, 16 Sep 2025
 21:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-16-ryncsn@gmail.com>
 <CAGsJ_4yrDFAe-3sMj1K2JeWrqNXCBvYvULY06b6B3ogSYjqasg@mail.gmail.com> <CAMgjq7AJ1=ji4iw03JmdN07MpY8V0CFdtUHpF58mTnSjGf=rGA@mail.gmail.com>
In-Reply-To: <CAMgjq7AJ1=ji4iw03JmdN07MpY8V0CFdtUHpF58mTnSjGf=rGA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 12:41:09 +0800
X-Gm-Features: AS18NWCg85JktjCHMlaLqxFptGC1bgva_j3Nzmnq8WvHDBi87jCKk26cFVpIEwo
Message-ID: <CAGsJ_4wH8ATOQLodxm7fEZb7Nt0oCxeyuiiUcf3ZYBpyC0kiFA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] mm, swap: use a single page for swap table when
 the size fits
To: Kairui Song <ryncsn@gmail.com>
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

> >
> > > ---
> > > +static void swap_table_free(struct swap_table *table)
> > > +{
> > > +       if (!SWP_TABLE_USE_PAGE) {
> > > +               kmem_cache_free(swap_table_cachep, table);
> > > +               return;
> > > +       }
> > > +
> > > +       call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
> > > +                swap_table_free_folio_rcu_cb);
> > > +}
> >
> > Can=E2=80=99t it simply be:
> > virt_to_page(table)->rcu_head ?
>
> I'm not sure if we prefer folios when possible?

Not sure either, but even Mathew still sometimes suggests using PAGE:

https://lore.kernel.org/lkml/aLrrQDCBzaMwwmA-@casper.infradead.org/

BTW, "(folio_page(folio), 0)" looks quite strange. I mean, why is it 0
instead of 1?
Although we know it=E2=80=99s always one PAGE, 0 still seems strange.

>
> Either way is fine, they are identical for this use case.
>

Thanks
Barry

