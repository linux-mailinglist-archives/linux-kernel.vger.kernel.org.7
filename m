Return-Path: <linux-kernel+bounces-819948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C47B7CC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF771B25D25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F2626C3BF;
	Wed, 17 Sep 2025 03:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXW7K/ET"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2641266B52
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081188; cv=none; b=tQVM79CzCQPTcn6g92VNSeH0wXwarAGRAXUaGTbFhir2+wCtSmCQvsqO6fNsuQNk4djO2B5DaQhwnaQCjF+8e1bh71vIwYMfrJJ9qNl83FlEgJsb7wETuy0Xp8YMA3HOrF+6Pc5APpAz8SfEReY+2aj3wyfuBqc0DqHk2P3yTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081188; c=relaxed/simple;
	bh=pjt2q+LH8s9xN19RH6zzbPvFr9XwsVtQswKop2m6JBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgrcYW3x/4bB5JovlVClL+KiXU1LfE2WhDtw/6dbiOCvVBuCM7Vn4brfF+zqS9NrY5KITY2KeQil/BgDKlclGfPr+3bhJyxMB+U5QnTkGK/oLqV+++n17KST8IXUsXKqtWbSyAduCzAK748n4FUQCWYZh1zv8spojyMsotQDdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXW7K/ET; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07e081d852so677329366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758081185; x=1758685985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=br8Hpn4kqiDUWzOrzTfPA0W71LUsxF/Q6MRy1/vyP8s=;
        b=XXW7K/ETDlQav6XtS2ZU/ibKmSFKZm42wf7yxkGRFa6fJ8H+xuxX7NaewRZ9LhTzym
         6BlBFb+MOeL08Uh5As6WYyWL3Mg50PocDqRl/pNP2RF8Fo2tzaqnBfLkFauH98aaDrQz
         L9DKv2PtVpohq0VpiHsjKFJHp7D3z1xs80H7yOuKsevQ2XY9BlBjRZmtml1N79TQQ1Jj
         ih3voPefd7aTocNQc8kZ7CmMoxacaFnSQQMQBJsg7criEumsxKaTuKJD2tTT8x5g5FHp
         NlX1EX3TfkRdofqjUZVkyMi5earkRQ+q4MBpccNsuyS/1UgiHP6xN4oyTjnqyGsWwKAn
         Mskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758081185; x=1758685985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=br8Hpn4kqiDUWzOrzTfPA0W71LUsxF/Q6MRy1/vyP8s=;
        b=dPLBtC+FkrhwTojRhKazDsTETxoOOjcn+S9fxGqxgwkt3AfDgZNgQtw8zuLwKxCLMC
         WZr3cil6SrBJwZc3onPKElSpUXCxMlynlhxOljtG3BXo2kV1NsHDgjf+HFUjn33jPJlP
         LkRZLWKK0ZxnlFnfuAMlmJGsAi2LkEefKDe+WOh1/MNhWByVlbLx4//TJZ++uYppzxB+
         mKsxhGrunZpfVxOOk9ZzU5OQP93lc0Kw1Q5G5WRgaCeJOW9pFkXfS4VA4cTi+Uc6xYts
         lnxm+JPAOY9UU4cgPI6TfcyrBJNr1xgfJFbSfOQ8n9lRVyJrL0pfNXH/0YkCjIc9Iwys
         e0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWMRjrP2nnupiNlLFYDvPrtG9OVnme9wQCI2P8D0paeS9wGUUvpuJvYFwZMRwVeo5kijUfjZgNlfe/ntTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwFvxwGsWv06xcASfKr7ea4nh/Hv7QS4Qd9XSInhngUT3DopL
	w9kErT+m354vUV2s7I+jxtFWuA5ePN6N9zJKJyBvE48Ksd4SasCAPJ3Amw8Xpaxyve8GRXdCjhq
	Mj2UU91risQWmz0uPC/p1zvW3YvFfbC/z0al3DQM=
X-Gm-Gg: ASbGnctdfQGLUUd1OkHK1shabRhwSNukKC3SNQOjd/lt5tPMJfirZMKMnc5ZYlhC5wU
	twXo90YPHPDWVwRZciXoDeYogc6g3IkMUbdiXzwXgh+T0qgEpT4Vok89x6hgB6zQtPQ6rN/gkIT
	TzMfDIfaARBkzzM3h+SmNr7WEZb9L7Ad2hReywLtew3NRtUH/l90cAMM9sO49TeNT5RjYbhDNVW
	vsYRVl918M=
X-Google-Smtp-Source: AGHT+IFQbp1h2CTc9fOnSy7mCP+U4w9I3xAO5gikNl3D24j7X3s4e8n70fnOQLRYpTtZJci4soxx7luTGcJEEFKaECc=
X-Received: by 2002:a17:907:3e1f:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b1bb9b212c7mr83299166b.63.1758081185015; Tue, 16 Sep 2025
 20:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-16-ryncsn@gmail.com>
 <CAGsJ_4yrDFAe-3sMj1K2JeWrqNXCBvYvULY06b6B3ogSYjqasg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yrDFAe-3sMj1K2JeWrqNXCBvYvULY06b6B3ogSYjqasg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 17 Sep 2025 11:52:28 +0800
X-Gm-Features: AS18NWCU5i3HJlEO-iFWg0kNjEVA2stpm803avLHZ3n6QtGZVqQEufTNOeFsfmg
Message-ID: <CAMgjq7AJ1=ji4iw03JmdN07MpY8V0CFdtUHpF58mTnSjGf=rGA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] mm, swap: use a single page for swap table when
 the size fits
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

On Wed, Sep 17, 2025 at 6:31=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Sep 17, 2025 at 12:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > We have a cluster size of 512 slots. Each slot consumes 8 bytes in swap
> > table so the swap table size of each cluster is exactly one page (4K).
> >
> > If that condition is true, allocate one page direct and disable the sla=
b
> > cache to reduce the memory usage of swap table and avoid fragmentation.
> >
> > Co-developed-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Acked-by: Chris Li <chrisl@kernel.org>
>
> looks good to me, with just a minor nit noted below.
>
> Reviewed-by: Barry Song <baohua@kernel.org>

Thanks

>
> > ---
> > +static void swap_table_free(struct swap_table *table)
> > +{
> > +       if (!SWP_TABLE_USE_PAGE) {
> > +               kmem_cache_free(swap_table_cachep, table);
> > +               return;
> > +       }
> > +
> > +       call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
> > +                swap_table_free_folio_rcu_cb);
> > +}
>
> Can=E2=80=99t it simply be:
> virt_to_page(table)->rcu_head ?

I'm not sure if we prefer folios when possible?

Either way is fine, they are identical for this use case.

> Thanks
> Barry

