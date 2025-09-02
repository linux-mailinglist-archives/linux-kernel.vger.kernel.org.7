Return-Path: <linux-kernel+bounces-797463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24DB410C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937A21A828C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E5F274B39;
	Tue,  2 Sep 2025 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcFqBMPm"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC1023B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855875; cv=none; b=PVabN/bIDGP145C17RMqqZXp0MSHRNwHOWiS2dYN2MnXA/c4EFFJUixnuADQ9QReABhyibPzf/oCLkAWI2btoBEUAFvAw3LMD67M22s+4PNl8NHiYqBEhZRgXTxJ2zWFKQa4jsUhhF7Yk3vHpseJwf/JrX9VDIdn5buC2Cv7Xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855875; c=relaxed/simple;
	bh=7LVBuPseF5aM/yDxSF13Qdsk7UYGzFKIVlH6DW5hLIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpbqphY7E5cOQZn3XLDbdlY7UFrKCpZORqa4I2au6OuhYJxTG7owNAk59lPuVl5GRIoLOkjFANMjwmjFxoMTlxpQOdSagw4U4o/QxvmjjkNgIsVXu/C7GXcrZcY6fs4z0yBvIMr6rVrJLj97ZcxCYSKIJ07Xmezl2IrZ0QZsr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcFqBMPm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f901afc2fbso37712785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 16:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756855872; x=1757460672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LVBuPseF5aM/yDxSF13Qdsk7UYGzFKIVlH6DW5hLIw=;
        b=HcFqBMPmq3etYMA/1k63E8l0RKtK82EmL0RZ9AiHce0A+5LQT39xFNXI9sUdlshLMO
         kEg+HjmGuUdBq3CYHPHmoWIjVa9p2Zi/QzZBh+EI+MVkg1NrKgbn/1bSKfLg5k1I1/PG
         p8LwaHWEf3tAGREQQRjgGQPH/OydU53ILCHYXCkNfra7BIT3Y+de9Y1fcaZEfs75534M
         ykaqaDZi5Bgy6Sb4BTQsGPFyilmr7Gra5n2pfxrDkbBtR9+Rwq/O3eepIqvQYyeVYirP
         wErXwaPI9VuwWv6XluIxyoh+nPUUrIUg8171nf9yzbNlKZGavVDKN8//a14ib063+qgx
         sn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756855872; x=1757460672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LVBuPseF5aM/yDxSF13Qdsk7UYGzFKIVlH6DW5hLIw=;
        b=TrLYz8MODP/DvRz49RDuRMAKopFK0gbtBLstUAoRsQFFrxXpHAzH1xQ+bPboj4RkAF
         Het6e/t2ZA9hPAl8VkJDMD5XuooNQFpTKIJNcJHpl5elaRSHrqHpPk7OC81FlyZ66Dgn
         uVmwgGvuXJjLwwylf9UzPvMN5tcqJRwNIZAVW0t/Mgj/2JgA3sDld8qxU9Q/zCcS88g7
         shYmUnTyjncT7W/OF3m/hLPGg3qvs9nc0bUz1vMMIzcn1bFsprNCEM9fFfcun0qTP8/s
         9qdn4ecCejuMUvwUoogGepspaZx6eBoO0Du6fy1aSAxF1phKyDGLAMpxQuc/orLD+AKM
         zqzA==
X-Forwarded-Encrypted: i=1; AJvYcCUCG8SPaCzFXBSMtcIPGVC4pKxt0Y9SgSfopPiTg+ZP1P5i9LnZ23DmH+blZ3BDqMPLZjTc2msDZHg8Nv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBZbdkR3q6C2Kh6sIUNK9ADM8xpA0GcaQCWJVn0SNnYIT4enXG
	lxn9VJpXVxoj+on4qsWl8giq/Td6WDlkuWUlWVyUJuFbEjgxvTwVjMYb/lopgysmv5vR3esdC2E
	l0WT5nzrc3A98YfWqb37df6MVjCbdevs=
X-Gm-Gg: ASbGncvUZr1/RlkOFL+If8dOcXjMdRd0kbyhQFs6zdjmOiD/al/yOuZpT1jiJQ7a5aB
	yh837EUG5ClID8sTTWKlIYp0ieSx0uXxQJpWGahcrZfK+esbUoxbAlzQTtsjB++l+a5ejc5pMFc
	od3wdUOEYKm3nKIkqZKnl1tRgybFaUBlJVqj8cOtYBwdokmdgCUBE7x6ZOxWKydl+ShD9y1n11l
	1KYv7D+uTDicDWn8Q==
X-Google-Smtp-Source: AGHT+IEJLw9qpc3tQQ8vy9ZMUJY17lV1WyVh4e91TjneayFN+zbp3fRwAGsuY4KKA7CdFz6YwO9eM5ggPcvXrrsIiVI=
X-Received: by 2002:a05:620a:29ce:b0:7eb:afd9:463f with SMTP id
 af79cd13be357-7ff26f9fc12mr1347288085a.7.1756855871751; Tue, 02 Sep 2025
 16:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-9-ryncsn@gmail.com>
 <CAGsJ_4xON7fYg1VvcjLOsgBb_Wp4ruC+vdA4Q496GH1jXunU1A@mail.gmail.com> <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
In-Reply-To: <CACePvbUVK45uRPVoO3ubDfQHikebSHFNQOsMTMvJ91QQZH2HwQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 3 Sep 2025 11:31:00 +1200
X-Gm-Features: Ac12FXx-yZJov-6VFLojy9utawTEbZVFjq9fGBjMlLTrZIwLwdL0r_i7z5HV2jc
Message-ID: <CAGsJ_4we4ZfNqJ+v7+=0hjNKLakJ-s8qtRsGo_kp0R_th7Xvkw@mail.gmail.com>
Subject: Re: [PATCH 8/9] mm, swap: implement dynamic allocation of swap table
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:17=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
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

What I=E2=80=99m actually concerned about is that we keep iterating on this
cluster. If we try others, that sounds good.

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

Yes, I agree there was an -ENOMEM, but the difference is that we
are allocating much larger now :-)

One option is to organize every 4 or 8 swap slots into a group for
allocating or freeing the swap table. This way, we avoid the worst
case where a single unfreed slot consumes a whole swap table, and
the allocation size also becomes smaller. However, it=E2=80=99s unclear
whether the memory savings justify the added complexity and effort.

Anyway, I=E2=80=99m glad to see the current swap_table moving towards merge
and look forward to running it on various devices. This should help
us see if it causes any real issues.

Thanks
Barry

