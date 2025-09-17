Return-Path: <linux-kernel+bounces-821796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB47B824EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F30B48822C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9832950E;
	Wed, 17 Sep 2025 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW8/rVmq"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497B265630
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758152288; cv=none; b=n8o1NXPYp028f4UvOTg9lisNJxQ12ToMlAT/ykFuPcLpTvMyn9euJ6DaEs/m/M1n3J94mn8hqc0nLPtgF7EQL66BWFob3trmHKogn23lEQ59YKHT2kKpBt0wWmkeMJPq9pdnWQ826wFWLNlXg9dikxOvSHdaZtOuKyY72aX+Bcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758152288; c=relaxed/simple;
	bh=J5xOsOuE7mqFHBoN0AADm8mFAldkd/OpLs/yDFgnsng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWnLFAqsHqjfEB/ROpVTL4MDIxHqvrm5FfZh/eW/LtSPftOIlBONHAzWMPnjMnVD7gVID9ZgJrZ/iVZ+8/v6+vYe9Jv4iNg38tAvismw+tn6wdjWBtuo8CKty3KTK/RC4eC2+QQfcN41ylnYBJu4z3WWHJX5UXzZb/gnRq4/l6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW8/rVmq; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-544c15d4eeaso80784e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758152286; x=1758757086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5xOsOuE7mqFHBoN0AADm8mFAldkd/OpLs/yDFgnsng=;
        b=QW8/rVmqvzl0vzpP/V+Gfv2/os4zz0jXLboKqVl6/Swdbq5nt5BsRvuIWP++qzYdgo
         IyEZ/YavkHG75bEo6QR/5DD31MxVkb8SiOec8+rPzzVp/Pd6G4I/RWf2gMIbRH2e9eb6
         MF9l8O4iWdG7OX73kegAXBC6JmFdbuH9ZYesfLW6FL3Q/nWk0LrCkw3B5XsIMlX/rLzM
         99YlwM7u5ewpxjlW6R19EVEzELXSGYPpVz5WknObdNb/do9OcezmcgA4HVjANBw0TtYM
         UgqTliw9Sm1WududrLhGiDfkL52juidDFkD1DQuzanFPavgEiP+aDA+ZdM6Z080Ve+Bx
         CWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758152286; x=1758757086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5xOsOuE7mqFHBoN0AADm8mFAldkd/OpLs/yDFgnsng=;
        b=IuuVB21/+Nbqo4HO+ysdJPOeYA+e+swS/NVAMlncSOuWLOyLtmqReURdMPR54CPd7B
         p0Rr7ttN8uJ2f23PD4SwwYEZBhKMbvpR1ZoJHsW5amoebXNb1kIBqI2X6Z+H+ROqveN5
         1rmzgeaSr9/BtiRGo82K3wHki9yF6hzJskjgeYLmRvMX2PFvbnoyDVbvsCmA1HGJeITP
         cbU/hzfY1tzwUkI7h44ssjqtXHj2qntppuOJCNRm8n0aYVZaCsStAaI4nmlOSFQybMPJ
         i2yuHxmuFKf5hxKMKkOjNmxbkVaplLgrSTRWgmZrFP5Z1pvnUgbxBcJz4zhf/6S3wCju
         MYuA==
X-Forwarded-Encrypted: i=1; AJvYcCVIQwhZ8QoyuHkAUB9qdJ1wEP9p2lIT1Bbng6c4JYnn8P8zez0UmosNbhCn6VFynx//cjDdrNpSgPMoQ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTH32xEOJVDzquEebB1WnsH/VDrdnlDA32H+CiRjf4gdJ+Dz/1
	TqZNPUzcheBoo73cArqVV81vaep5IHAjHMVRfB9odr9tMTL5m89srSQbFsyR8qVHNTPE1ZimzT8
	IpFZoK94byvhJ2lsJeq1KWoavpCy9sqE=
X-Gm-Gg: ASbGnctAviDfL93mYZ9rZVewOo8jt5cqDt8bc5d/GmuUUjRL9kQW9Eb7Kuoh0lyRAFa
	YcBPj6imRS7obQmGDfzGPJClpqMHzWUuJgXQTLBD7SVxEhmxFD1GDM/c1nyCOG1JuoKqwHKXAUW
	Uw/ga7p/eDimiBNlxOC/TppZClNx9SOUbNFVW52UYOPINeG9cLskSxyW/62EvGtZ7hzg1BUouTv
	Rr2kjP9kzzFfgYbYHNLsLavi7EfW3BGowniUDFLAZsGv213OuGuvE6MyDBYltFIZmN7nFw=
X-Google-Smtp-Source: AGHT+IGuqRn72jg+dK+mDqGoNA+LUSb6AsSThdLpogcwx40T2F6VAgrf5kHi3x1xlQcu937+V7+9oMNPzX+vYBPG/lE=
X-Received: by 2002:a05:6122:1d56:b0:544:90b1:1a with SMTP id
 71dfb90a1353d-54a60a7a22dmr1414035e0c.13.1758152285466; Wed, 17 Sep 2025
 16:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
 <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com> <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
In-Reply-To: <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 18 Sep 2025 07:37:50 +0800
X-Gm-Features: AS18NWBcPj9Qd_aVSIjWDbzxxGvwYyUsh2BZYSK1JiFlFC7naijW-G7wdpR2M18
Message-ID: <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > This approach still seems to work, so the 32-bit system appears to be
> > the only exception. However, I=E2=80=99m not entirely sure that your de=
scription
> > of =E2=80=9Cthe second last level=E2=80=9D is correct. I believe it ref=
ers to the PTE,
> > which corresponds to the last level, not the second-to-last.
> > In other words, how do you define the second-to-last level page table?
>
> The second-to-last level page table page holds the PMD. The last level
> page table holds PTE.
> Cluster size is HPAGE_PMD_NR =3D 1<<HPAGE_PMD_ORDER
> I was thinking of a PMD entry but the actual page table page it points
> to is the last level.
> That is a good catch. Let me see how to fix it.
>
> What I am trying to say is that, swap table size should match to the
> PTE page table page size which determines the cluster size. An
> alternative to understanding the swap table is that swap table is a
> shadow PTE page table containing the shadow PTE matching to the page
> that gets swapped out to the swapfile. It is arranged in the swapfile
> swap offset order. The intuition is simple once you find the right
> angle to view it. However it might be a mouthful to explain.
>
> I am fine with removing it, on the other hand it removes the only bit
> of secret sauce which I try to give the reader a glimpse of my
> intuition of the swap table.

Perhaps you could describe the swap table as similar to a PTE page table
representing the swap cache mapping.
That is correct for most 32-bit and 64-bit systems,
but not for every machine.

The only exception is a 32-bit system with a 64-bit physical address
(Large Physical Address Extension, LPAE), which uses a 4 KB PTE table
but a 2 KB swap table because the pointer is 32 bit while each page
table entry is 64 bit.

Maybe we can simply say that the number of entries in the swap table
is the same as in a PTE page table?

>
> Thanks for catching that.
>
> Chris

Thanks
Barry

