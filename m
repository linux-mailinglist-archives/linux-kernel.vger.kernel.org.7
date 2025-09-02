Return-Path: <linux-kernel+bounces-796055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32E8B3FB64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142DE2C2F99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED312EFD80;
	Tue,  2 Sep 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhUHRDWG"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDC2EB862
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806942; cv=none; b=iDfiNrgvhBhdLIj4gEHhvCXPIStd+CuBCwxGaXgeynox5WFab7eVmE3aTx8zfLfVRenQ7hDOc95KVP1Od3huqzYeO3TXsJgNfs+LBmzqb+J3l+iTTtRo03jViaryuc19eAVN8d279WJNNh/CTiA+8HzKCrz2rDoybiFVGBdTFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806942; c=relaxed/simple;
	bh=te1x9GRQzySHMfYUz+aGIzwsAjTcUDPAv54CQb/MGVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA9s2RroVIkUR7N2YsDqt9pVGMi3lAiFdYvogDKut2GFcsNqY8L/flx0A9saiGKzYvRLQLQ5//68JOyUmFuLhp+C4Nn8e0nXgqvMn55kLOK9FuM9lXzQUCEnbXggHokSEZdsv5MhPnLpCvUEv22M3QIg2QeIE+ys8fT3QKhbnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhUHRDWG; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-89018eb083eso2368049241.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756806939; x=1757411739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gKxrWfhHC2C3xRmL6LvcZpN3YLRP1h6fc19HOwfkXiw=;
        b=dhUHRDWGas/IJbfQq93ezdgLZssf6HSwwOxxCObSSjuYUgzPn0DyG+HRu5VGDUG06A
         GzgXWbyHUgVRkGMJe2nkhJAVjpq7beDs+J5+5raD1fVaRy5ApHHHRcibbAr2Xlp0eOey
         ymyFZMQBZ66E1i5SCsvxmy0sQVCnE5jfCnMtkeMWiVjzUUYnHRtgvzl1nRWC5up9ygBT
         i2gUWktfT4Dp+bpcA76GxaS7VPVRk3wjqD1MWEuhElJxdgibzvVwsyWUIupf9euz7hjf
         dodx+SmpR85+nlwdNZXaH2zalicxlJd4IQ13nKs9VM4lqQfSEtZ8ESl1eIroDn9qsxOL
         ESEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806939; x=1757411739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKxrWfhHC2C3xRmL6LvcZpN3YLRP1h6fc19HOwfkXiw=;
        b=CQrjyTa7kNr036G+9oAL6enZjNNVeGUCxJDFXrtDqSfUc44OySmPGPsTICMU7PFSnK
         AYTynERTvizXeKnQ1jdVDI+y7j75j8l2kEqNR5gsGRzBM+9ksE734QLE9KXEIgwy7C9g
         YI6+knFpJs1etZLJU2wUFjlmXTVNyU4nSaIjCFuHBxDjD4quHnr0J/7Mt3Eso/JsZcdq
         maZHWQjCEX9LnbEKaCO4MomHCPsEUUXn/ublhJU3Yq6NVB0GT71Yrx4g+66aPiyC9JVZ
         W5k4Yh3bUw8PTmMtKiYevL17Rm2XXSs8r7wbdApY3iWB1QTaL50jeJ7dwkSyYXs8IsLe
         7ksA==
X-Forwarded-Encrypted: i=1; AJvYcCWfN2Tfw42ieNcx+Y7BkoyM01bSPkvMGbJCSPRCwrnCGpE40tfKg1L20EK5Ybks2s2Mib9uZUCFaOSmI8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirZJRQvat/60vQ+MFeeHBZRADgxf9UqdgbqjJWXDpYfYa9bGw
	52TkGKgASG8b90ahaW7HK9uVI1DCBay43vF/rpbycBg5QJjPu+41OBqnwNm7LkM5C8k+rxacHT7
	l0JDMZnqoGdAfFbZCSiQ9NRTub0yj9gU=
X-Gm-Gg: ASbGnctKFHNvf76m5lq/ktj5vrPB85xgcfem6k5575+VObMWQBGhnO+PLgDenIpVyGv
	mKuF0u68CQ7YFv98+Bzk4rDBRRrquZ7sIw7lY0em4ltad4oyG9uw9SHXNNSUZ3HgNqPAFaT7vrB
	nnkmn0VxlMqO7/6D/a/XsmMo5ubkRYda9ED5fBVr+9gLiNiTzY7o8hoy9XEaVVJTAv9GeHe28jb
	9PSXHH6FzUygKttWA==
X-Google-Smtp-Source: AGHT+IGMmik5TyrlyuE4RR8Ka3YV/vug+vCKrCh4aJKu7j2UH+hFmE+M6JoAk2k5wtHMN7tJ+U54772t0OLJN4gWEoY=
X-Received: by 2002:a05:6102:c4f:b0:51e:609d:316c with SMTP id
 ada2fe7eead31-52b19435191mr3421265137.4.1756806939367; Tue, 02 Sep 2025
 02:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-7-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-7-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 17:55:26 +0800
X-Gm-Features: Ac12FXwlqVH04N2I3ixY3ZLjS5V-FXn4ZrhEjnHyji21ZZqBEmu0Hd-OTtthbYw
Message-ID: <CAGsJ_4yRa65ogB0d90LmtOigGTqQ9mM-eUU6VbmcX63j6vgHEg@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm, swap: use the swap table for the swap cache and
 switch API
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +
> +/*
> + * Helpers for accessing or modifying the swap table of a cluster,
> + * the swap cluster must be locked.
> + */
> +static inline void __swap_table_set(struct swap_cluster_info *ci,
> +                                   unsigned int off, unsigned long swp_tb)
> +{
> +       VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
> +       atomic_long_set(&ci->table[off], swp_tb);
> +}
> +
> +static inline unsigned long __swap_table_get(struct swap_cluster_info *ci,
> +                                            unsigned int off)
> +{
> +       VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
> +       return atomic_long_read(&ci->table[off]);
> +}
> +

Why should this use atomic_long instead of just WRITE_ONCE and
READ_ONCE?

Thanks
Barry

