Return-Path: <linux-kernel+bounces-819704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA265B7DE28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EE462F10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15278296BDB;
	Tue, 16 Sep 2025 22:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWft4ecl"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC551E7C2E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061875; cv=none; b=ArHChZ7iYFKphv/sFjJrtmyWJ8yCl8Teb2GOOMGsXQuL0YozNOYZ9y5qOQoibW8tYWRe6vl1YK5bza0SKY/rL0XAUREm55lb+N4xNGOdgJMFd8JeKili2GWUXZA48GbX1jRjM3N+GTplRKbwNQsfSO2xSzjwGUS8TPgRo0v3d7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061875; c=relaxed/simple;
	bh=70euft8nNaEavx97tmBiq2s9K/PdZiNtorux+6Y5OhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz+AvL8X2tUw6niA4Iz3+NGkTN3NTBengQt3dgCQbdU7vs3/YxB+QvubxQfKqSCk7oHzmhKN8DAHB/mOY7Z1rkorRwO5gu66v5x0PKnDyIcegnNj1eDX5qybMUnhmMyDrZXKX/e/b+dNX4enLK361lO74+XXMp4DdY70pPzOGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWft4ecl; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8127215a4c6so37729985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758061872; x=1758666672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVu791aZ8rwgtxvUL5SlLK827bghZulSR52djuOwSHo=;
        b=MWft4eclkGSXZq2fpuh24kiUhAhuaIH7SUSVkE5+kDtjhR5W8gehelneQR41YdrnTx
         0nOLQ9TBDltackM9FZL9Oy5CpHXyaYEeGFMrpRI15U0TYHqTMjOwzyeS/P9nEFvlDHRc
         j7b/gm/XUaNfIpWjWIZSErWenGqyN5fmi57YcGcc8tFGYSYvWdKuya03S+ZFLMJVxGFH
         gSXQZ/fDVW7RC2MqVGxf+7CmmwkYMlI2ClC+u6vlZfSphOKo1HuWcvkLh6ElFLHIfZox
         D3231YzgKbugAuMoq9P6TyotLKD+A7EvqAcTJOftZRRTaQBZ/Scva2EOE3J6qGojKqor
         Z1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061872; x=1758666672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVu791aZ8rwgtxvUL5SlLK827bghZulSR52djuOwSHo=;
        b=Jfh4pubB1HyJJOQUQiWBReL+7L5nTKyJI3HYOjRQwiGOV1nHG3BUfvrycAW/fcFmJM
         lnA8qDA+JRLCyBKgbrfk28QiqglzZJqF+T/ZYaUnAKpjhjwd4Vbs4qYIq6uNxgoiLJ0/
         yrM40JelB9nWwxXpkSWnXn0T1VLpghPnDmmKfzxKzzSnw1LyRzBshkDIRMAe+NDQZ2rt
         QOgEO5ak+6rQwTPaDes7s9ZFm1AxrS8u+ZrNANDx4QUu+EG8vjwh/RON8kBpsQAJHAMV
         s+gOT5fzE33hp8u+b/4CjTAckz5FU7nIwhgN22FIlQcLDRucSE8YXKjPcBZ2JzC4qp3L
         ykrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5vttNIaHp2Qdo8oe3894Y7rnHe1oad9J0nxridr82kfRCQI3ff8e+Z8m3SBuvs+jcjAZ2F6SpkHFnEOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTZsWZ/A8P1CBJ3C1leXHj5r9lrPm+RqLRQR8zeQqQPgHw/+f+
	J14P5o/FmSH+dDtW99pUAhCM67UiRLkL8FO9cb51ILNqwqOSdZKihNm4tMBq5gYm6EiW664FB+I
	vf25oyqd+TqV6M4Eh3Ix5qkVaNc2FLEw=
X-Gm-Gg: ASbGncszAnd5mwi10/NjhRRzGluAvIUpDrQDWk4srOk6AQqYJv8Q9NoZ1FZqkH2831E
	cM/4S9rO+Z8yEvrEEO5N1OjsdCkuGqvI4Zkxvrbrb9a5ussjTKdwOwCNHBWXhBq3RWxzM4nqOFX
	ZjT+3AJLpjMFveGi7y0igzBqcu43d3RlYBmRb5m8RlcdUpToS7kyXfIT0nAIK7MU5FpO3INi0rs
	GU0jlnPq3Yhp4mKQannNZ0ZtDInBgBJe0khiP6IJg==
X-Google-Smtp-Source: AGHT+IFIRssh1dOgOKjza1bMxgt39yDVYAyE4daOrN2DtM1F7DovO/IaysRsYWeYGfTW4CsCPbmXrBVEP2SojZmKhqQ=
X-Received: by 2002:a05:620a:4624:b0:81a:bbce:6d39 with SMTP id
 af79cd13be357-82b9ed54ab3mr492130085a.40.1758061871739; Tue, 16 Sep 2025
 15:31:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-16-ryncsn@gmail.com>
In-Reply-To: <20250916160100.31545-16-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Sep 2025 06:30:59 +0800
X-Gm-Features: AS18NWB7adgYb7oVzvL1zIv7CnUkXbq-89QDCv2evtv_By4LbIsvCSvGNRnSMr0
Message-ID: <CAGsJ_4yrDFAe-3sMj1K2JeWrqNXCBvYvULY06b6B3ogSYjqasg@mail.gmail.com>
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
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:02=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> We have a cluster size of 512 slots. Each slot consumes 8 bytes in swap
> table so the swap table size of each cluster is exactly one page (4K).
>
> If that condition is true, allocate one page direct and disable the slab
> cache to reduce the memory usage of swap table and avoid fragmentation.
>
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>

looks good to me, with just a minor nit noted below.

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
> +static void swap_table_free(struct swap_table *table)
> +{
> +       if (!SWP_TABLE_USE_PAGE) {
> +               kmem_cache_free(swap_table_cachep, table);
> +               return;
> +       }
> +
> +       call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
> +                swap_table_free_folio_rcu_cb);
> +}

Can=E2=80=99t it simply be:
virt_to_page(table)->rcu_head ?

Thanks
Barry

