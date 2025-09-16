Return-Path: <linux-kernel+bounces-819676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2EBB5A482
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281E53A1BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3130D323F68;
	Tue, 16 Sep 2025 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpNmcJU8"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA032D062F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060010; cv=none; b=LmvF9GiBeUIzyXTaJ4ZKH4xx5bXL4YIp1GFNxw6WO8BZrOgPFEEGIFxcRRg4FfbROL3AxPtR2QJRzQ9vBuAoxRiCrg74MvwLHCzY+b1t+7wQNitg3L8VcYJpTxRppp3uYs6fR3h/DSGgs8a/xzJ9gxMayJik0fOM/5do922E0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060010; c=relaxed/simple;
	bh=ctWYl+XVk8pw3fWML+1bwsI8mlPxf1b1v2W/yth9b90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sS8bjeoOdHoghJQfJQ5NFeaM4vnulOTV0YsvCyOw1emnIVP0KYsFo4bfbCAhz3RPvizLEZ1vDfuQ98D8SlVuGtnNrdHY5wy0L9fJrThU1VwjDi2D9+j9rHRsseaI9i0Bey2iVPHlh9iMoAdX/C8+vsrbbibqhNHL76mJTri7nPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpNmcJU8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-816ac9f9507so34805385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758060008; x=1758664808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThoOhf+6dHZWhwOpzvQ+ee+2qRgrSoe6WcpIwwuJkt4=;
        b=DpNmcJU8ACQDOeRZOEcc05ilE3a/RtwvgWyDyV9AkFG8yQmIht0gjccsWhe1itNt8v
         vxr0VViCwAXASagRougviilHxxsf6ykq5bdh43TBYgw05Tc5UEeKNJ36dc/xTMTfYp2l
         PxOcDq6DdE3cag0Usp5Y1fMuCOK7gDJBsHa9Ji6y0Dxm5FWRpMrwVYVfBxPHugdg07Np
         2z8Yj83n+6dtJPH5UTgaJrgk6kKZxaCLiFMzYDAKSr2/mFgRwg17ywDfAR6Q+c4eUpRi
         1NMDNf+Ks93IvuQYBAZENzBSCexDaA3jp0gG/yd0JZiq8wuW9mLQmEHO8dWY/1ycPnCd
         sA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060008; x=1758664808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThoOhf+6dHZWhwOpzvQ+ee+2qRgrSoe6WcpIwwuJkt4=;
        b=eCYqbR6saFYP/VdCiMtcB2AYjuWh0GUAysN1HlI7r3h1hCW3KKGIm1DMOFhWl0mmRb
         IxRiNydbeTv8oLPIbf14t/CI8Ao6VaPVemYNr1qOMk1yxvaQG5LHFPwA/el9IaA/zTbs
         lTrCqQlfgOq0G7JDt5r+uGJltEyuWRBrkoFknog0dCLEWsZvKZq7BNr6Hy90iTi/GyFn
         XjhwwxldSuUb3+YPsvKl6l3M4hf/DcfOkq3iIFyHxvhwtIqI4GGo878P12WaK72yaSwN
         ufp/VHR59BYapbmWjl65CsblyrLHc6qjI0QBZgy6yEu/459DWvMHy317NTExeWkYShNQ
         xKDw==
X-Forwarded-Encrypted: i=1; AJvYcCW9NlmrRuzZ6jJCW6yN1eavE+4/0Cl5x+CM4hgeCXPDgMIm88EyAuLXXmAPs7DPVAtgovLyBK7bQgl1RXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CTdt+QKPnDiR+0BgmAWmjN/de2X1BYfLNLIwEDOGZeaRbiFb
	W4t/vNPwAKhqLEQVwHTwJLu40uLUizAo2xNM3ui3VkDQNg1NhbY4XQYUX9aLYMj5/twx2iB4RRl
	K1+ja09TSqwpgNMOgcrV+7g/VAG5x6KLfrjJWnx/5KiC0
X-Gm-Gg: ASbGnct9l3lekOwZX96gJDzdRv9yH2r58oZfsY7UP5lmbLVtLnpYwrMlvPxifumswe6
	62ek1b1Nu1MWB7wnpGjVSYE/FcBE/+YgebnjxHYa7HCkwLpAfpLT3K5X7dEYzfiGsIyJjKUX/5K
	3mA25gqKK/g+o+Ofgc81aR3+8eJ8ju/3ofqFNf+Dgdhf9rmIFU3LcogCOqe+/RIa6pysmEitdz2
	lcvyZRm2gHiyjNe1wAHGC2VSUwF9HdRCw40ezMzlg==
X-Google-Smtp-Source: AGHT+IFp40UDIihRYk9syb9JZvodewOvILFSFFVd5xhGvihtX7lMBcvp+BijPssbXYsS+F+G32VtT7aS7hCYn23A500=
X-Received: by 2002:a05:620a:3729:b0:809:b21:5421 with SMTP id
 af79cd13be357-82b9d9d342fmr496291585a.39.1758060007615; Tue, 16 Sep 2025
 15:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
In-Reply-To: <20250916160100.31545-2-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 05:59:54 +0800
X-Gm-Features: AS18NWBZzepHycNk5Ebg4834edrTcub9sHWJBZ1C11nD4dWKjdfFZmTFEHRW--8
Message-ID: <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Chris Li <chrisl@kernel.org>
>
> Swap table is the new swap cache.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  Documentation/mm/index.rst      |  1 +
>  Documentation/mm/swap-table.rst | 72 +++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |  1 +
>  3 files changed, 74 insertions(+)
>  create mode 100644 Documentation/mm/swap-table.rst
>
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index fb45acba16ac..828ad9b019b3 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -57,6 +57,7 @@ documentation, or deleted if it has served its purpose.
>     page_table_check
>     remap_file_pages
>     split_page_table_lock
> +   swap-table
>     transhuge
>     unevictable-lru
>     vmalloced-kernel-stacks
> diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-tabl=
e.rst
> new file mode 100644
> index 000000000000..acae6ceb4f7b
> --- /dev/null
> +++ b/Documentation/mm/swap-table.rst
> @@ -0,0 +1,72 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Swap Table
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Swap table implements swap cache as a per-cluster swap cache value array=
.
> +
> +Swap Entry
> +----------
> +
> +A swap entry contains the information required to serve the anonymous pa=
ge
> +fault.
> +
> +Swap entry is encoded as two parts: swap type and swap offset.
> +
> +The swap type indicates which swap device to use.
> +The swap offset is the offset of the swap file to read the page data fro=
m.
> +
> +Swap Cache
> +----------
> +
> +Swap cache is a map to look up folios using swap entry as the key. The r=
esult
> +value can have three possible types depending on which stage of this swa=
p entry
> +was in.
> +
> +1. NULL: This swap entry is not used.
> +
> +2. folio: A folio has been allocated and bound to this swap entry. This =
is
> +   the transient state of swap out or swap in. The folio data can be in
> +   the folio or swap file, or both.

This doesn=E2=80=99t look quite right.

the folio=E2=80=99s data must reside within the folio itself?
The data might also be in a swap file, or not.

> +
> +3. shadow: The shadow contains the working set information of the swappe=
d
> +   out folio. This is the normal state for a swapped out page.
> +
> +Swap Table Internals
> +--------------------
> +
> +The previous swap cache is implemented by XArray. The XArray is a tree
> +structure. Each lookup will go through multiple nodes. Can we do better?
> +
> +Notice that most of the time when we look up the swap cache, we are eith=
er
> +in a swap in or swap out path. We should already have the swap cluster,
> +which contains the swap entry.
> +
> +If we have a per-cluster array to store swap cache value in the cluster.
> +Swap cache lookup within the cluster can be a very simple array lookup.
> +
> +We give such a per-cluster swap cache value array a name: the swap table=
.
> +
> +Each swap cluster contains 512 entries, so a swap table stores one clust=
er
> +worth of swap cache values, which is exactly one page. This is not
> +coincidental because the cluster size is determined by the huge page siz=
e.
> +The swap table is holding an array of pointers. The pointer has the same
> +size as the PTE. The size of the swap table should match to the second
> +last level of the page table page, exactly one page.

On a 32-bit system, I=E2=80=99m guessing the swap table is 2 KB, which is a=
bout
half of a page?

> +
> +With swap table, swap cache lookup can achieve great locality, simpler,
> +and faster.
> +

Thanks
Barry

