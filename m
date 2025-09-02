Return-Path: <linux-kernel+bounces-797062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2ADB40B58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CE8562B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB851341641;
	Tue,  2 Sep 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWnzN3y2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5C6342C9C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832298; cv=none; b=RI/cK3fiurhWufK0ZSqF/W31aksf6kj5XdDdMJ/rcP41ypEonpDZWCkJDdoyo42ZKeEhBCnCu0qGjO/a5Ww302TLO6dK4LdQC/0qGH14Be2CCAFRYf0jJ3pO30Q2PHQ2P17LZ4Q283Xc3Iz4O/2ciE+yKhe538MhDdLcLvc8xGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832298; c=relaxed/simple;
	bh=1DqzUf+rokfxWS7zx8j4EhXH84SFLtCBUyk6VBoprNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z37yQPVy+9olRZoyPdLYdcQkLVvDNzpeFfIhtEthGvGn2TIFT6MvE2Y8K6beTXOwW6Ie66Xw5O99Nakr4/631pATmlKDwJngnQUsrjKbC2ESyOOtczXAeyJ0J+ddWDEckKiDBZCRQflcXZ25fM0MjMm2GntZORV/2spGvQcRmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWnzN3y2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7322da8so1101894266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756832294; x=1757437094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1DqzUf+rokfxWS7zx8j4EhXH84SFLtCBUyk6VBoprNQ=;
        b=gWnzN3y2+B9jE3Dvz90rkkW546XIcPJhJ/97ITRp0To03CvmYhZu2vFcGW74ZOqPxo
         2bVeGRkvxe0FNjU1gJvnZB/kox2Hy2D2TOGn4uU/aztW/DRdfubVG4/bXmTsFqXnEiwm
         sS25E/A3hRd/9KXySfjiIXvOL34gWPULBS29pQ0MnEyqB96aHJwL5Ea2FtJycFShaSOI
         AGFqj1Xwr52rgjP3fJsR11WcRF5X5vSz/uuXVZxGFpA/QeiCfsHo5+QeZoI8eMWkmJfq
         rsgmGrjnUzgANyWV+yNGaSoV8BinjNYy4psCz72VvQnkq4qRrSlw4+NLgIet9V30VJmi
         je7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832294; x=1757437094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1DqzUf+rokfxWS7zx8j4EhXH84SFLtCBUyk6VBoprNQ=;
        b=RyoODJiEByDBlUMMBQ8YtC2S3JCgXogRMn1ZN0KDH3Y3ip8bNwrZMN3SVy5dS1ppd3
         cHkRR9crpPnK8FuqpMerWYb/VgwLvIbR1V5weCS6s4CtgWLzrwrdq1MJByIeCBRIMFZP
         07l+GVm2tF25nPaVVUx6JEf1O9KxhO/MTler/kwWfZJ7lug6CuhIs8H5Pi1oobmQYiIP
         rMDZ07QBO5qGnD6RI9aO6h3kvIK2g+h/fniq4gIkCg5ca/mfKOzkVH/H2EhoFpPjycyb
         bAPZs1Ki3sBqunRuxf2IAZAP0Nd6c5yKs/UC4QqBoI5vn47gj81JRf5FoSsM0ONlIEfR
         sKkw==
X-Forwarded-Encrypted: i=1; AJvYcCVdTrgbVqrWvfreHS8XeLhIQjdK5C0zS5fibgs2LlsBxfmmfZJk2YY+ZioN2dw9PfuHAhC+XyXym1uKjeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZF42dr/QQpfjiX05FwwGKMRFsngDRWubv80m5NlSpSAPWJofE
	7wJJhrjRu1UtsokgGeMnWVxMgNkKKDxgt0EXlpgHXcICSuLhu8ijM29E+DStqBF0sn9pegqCNVm
	J3rxAGExRWD/+hCVrayl7R1WaAMQqhY4=
X-Gm-Gg: ASbGncvyM6p0bQWZFJd0BfuHxnWJOtmwzwPy6jDBUy/dhDXkagmuh/AxrlS8yqF5wQO
	4YQo6jbTEa9SEBkEhEHZHmyF3mwO//Chnf+hC9qcBpQPhGy/DNRFg3Vylt5j2oQhAbHT7NqLPBD
	J4W4gbLbpJu+g6zj+bEmm5ct3WpjkWyTHW8MjQqRUwttNC8GtisAwG7cYYBPgrHB24eXyCdirb2
	PhiHIgIalQTiJFU7pKiGA==
X-Google-Smtp-Source: AGHT+IFV2QlvgK4ES5Q5hipIJ0HYZ3QNaHslPIamKNny8rmThkrXzpfyiRWIDhc6Daw5bFI/xzPGYCZrlcgOio94HgA=
X-Received: by 2002:a17:906:9fcf:b0:b04:4928:7e33 with SMTP id
 a640c23a62f3a-b0449289c65mr377879866b.37.1756832294200; Tue, 02 Sep 2025
 09:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
 <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com> <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
In-Reply-To: <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 3 Sep 2025 00:57:37 +0800
X-Gm-Features: Ac12FXz176VVDB--mL2c8AYi8BveQ5DyAiz8PB-sBrX27q13GWBnbT3NtZeBoEg
Message-ID: <CAMgjq7CADKhU8r0xg+=xKJ20JybFbXc8mkBNYxaHsp3ZvYfV7g@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Chris Li <chrisl@kernel.org>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:20=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Sep 2, 2025 at 4:15=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > Now swap table is cluster based, which means free clusters can free i=
ts
> > > table since no one should modify it.
> > >
> > > There could be speculative readers, like swap cache look up, protect
> > > them by making them RCU safe. All swap table should be filled with nu=
ll
> > > entries before free, so such readers will either see a NULL pointer o=
r
> > > a null filled table being lazy freed.
> > >
> > > On allocation, allocate the table when a cluster is used by any order=
.
> > >
> >
> > Might be a silly question.
> >
> > Just curious=E2=80=94what happens if the allocation fails? Does the swa=
p-out
> > operation also fail? We sometimes encounter strange issues when memory =
is
> > very limited, especially if the reclamation path itself needs to alloca=
te
> > memory.
> >
> > Assume a case where we want to swap out a folio using clusterN. We then
> > attempt to swap out the following folios with the same clusterN. But if
> > the allocation of the swap_table keeps failing, what will happen?
>
> I think this is the same behavior as the XArray allocation node with no m=
emory.
> The swap allocator will fail to isolate this cluster, it gets a NULL
> ci pointer as return value. The swap allocator will try other cluster
> lists, e.g. non_full, fragment etc.
> If all of them fail, the folio_alloc_swap() will return -ENOMEM. Which
> will propagate back to the try to swap out, then the shrink folio
> list. It will put this page back to the LRU.
>
> The shrink folio list either free enough memory (happy path) or not
> able to free enough memory and it will cause an OOM kill.
>
> I believe previously XArray will also return -ENOMEM at insert a
> pointer and not be able to allocate a node to hold that ponter. It has
> the same error poperation path. We did not change that.

Yes, exactly. The overall behaviour is the same.

The allocation is only needed when a CPU's local swap cluster is
drained and swap allocator needs a new cluster. But after the previous
patch [1], many swap devices will prefer nonfull list. So the chance
that we need a swap table allocation is lower.

If it failed to allocate a swap table for a new cluster, it will try
fallback to frag / reclaim full. Only if all lists are drained,
folio_alloc_swap may fail with -ENOMEM and the caller (lru shink)
either try reclaim some other page or fail with OOM.

I think the fallback of nonfull / free / frag / reclaim-full might
even be helpful to avoid swapout failure when under heavy pressure. I
don't have data for that though, but I did run many test with heavy
pressure and didn't seen any issue.

Link: https://lore.kernel.org/linux-mm/20250812-swap-scan-list-v3-0-6d73504=
d267b@kernel.org/
[1]
>
> Chris
>

