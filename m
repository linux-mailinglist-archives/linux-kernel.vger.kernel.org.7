Return-Path: <linux-kernel+bounces-795568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF079B3F4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C061E17F509
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461EE2E1751;
	Tue,  2 Sep 2025 05:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jbf45uF9"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6112E11C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791632; cv=none; b=LyVAM4qUvRhmlG8dKBYn9dF6eQrKpOl1drkzve7kzeq/bH2m26EI8q4VlOjzsMsPHw/XQ6x8hBGWlyccbtlziixBzYWAyYerl+gCADa20OxV4m9BCfG0I8OMBgtCMfCzwkkhIsAVrYRrJYDh1KBY4oo2XhNvGvAF6rS1uhEsP7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791632; c=relaxed/simple;
	bh=AM0nxi7EiA0SRGiZ1UELrcehodZqP/yvAeARJacY3Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4NE36MFS8/5COWFTPacdxj4y55oIgQX+IAFAB5kYF1u4FtTd2jLtogcFlxypwKlrgIiTAfKIAOTeJmkqa+2gxf26fKoFwVf3h+3kEbMhPFyXZjnIdw7ta4x98nOEu2bqsqsZagS4Dv43Nm/wTDYjL5iNuM8tuZ98I3KbjpOjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jbf45uF9; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b109c6b9fcso48770461cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 22:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756791630; x=1757396430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7cMIMYJQfFGiekE60FGRLjgl1mruUZ9xHSw0rex8Y04=;
        b=Jbf45uF9EDbtdfVcZoC9wb2ku5wUVrkBAHZItSYsybzhpxZtcenDlYc0xkze4E5OZy
         9nwV63sjrYt9mNOyChJ54X0wmucETnryMYz/JOs9WLVdmQk5L2AoJMpm2b7dmAl9hsIG
         Q5Hq5X26LnQ8wCj7JgI0857k8uF5RfxW8Yt3mlID7AwJrvqmEfEsu8/Z4An6+w+VFmrb
         eUl9llNniCCULGHNJyPvXUJxeL4WCTEVpcRbjjjAIRuy99W5a5iSqMXCF5uQ8fdmGman
         8O+Uiy1243ieV4f7pq/pTsJXR9dCfEeQuhptcXUYIFBsCR0SbnEEjRFnsnjLGB1xQ5JM
         Wfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756791630; x=1757396430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cMIMYJQfFGiekE60FGRLjgl1mruUZ9xHSw0rex8Y04=;
        b=eh/uy+6cpW8GbtdR4ExpM+zeERP6i0hBI/WftLKbbS6OSR9FbsSCnGlAahZV3Gfnj7
         k8BFJOKmdvMQASAKEtxLONLvZDMR468u+vGgWWM/EvvGLyOlU2ZwOGppPCD9niNKSQ4T
         EPvLg4qSHkCVxZT5qINJYvMtOwlhtammREPo1zwQyS/1XjjTbBj+iQ65sTC7Q3uJ/DlN
         e4Ei/ZOpGu1to0Bxr3MMu4masWdQwAV/uFuHKq25IFiodcAr09vEkfSgpSOEeH1pMTCz
         VGfAsoG47GQloH6cY4Wq7ym9qh8Xf3eG4mVXnoKBvadF9OBfT3nuoslfL9hx/EmfjGet
         /Hpw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4VofXlW5HxombacKZbYNG/5fNWwnenxDJlOIr2u3CcTwauPyqWUJ70+pyGNOQYxyn89LoAnG16/c++M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnItHF2PKBE0183ZHg343iZKyk5x2bHvBVRVmfSb7/2F2Z6tSe
	/9sxxn5nHU20DTVeuU5KU2Q4Cq5kV05/Ljo+4ZCF6wcUKz6MBBt+GRZ8/6kRb/bwbDsgbFNY0AH
	75UdU2cJLRJlBAHbRNQWDJZ71tBB5agA=
X-Gm-Gg: ASbGnctzhX8wvuh+CoUkhuQRdxBNzTUfQ4e98E/W4WIPlhAsp4BtVCGJdrffefdxf8m
	Pl9HNyyxLO5an3IQB1vjZJz0gbbbLWgai/3i4AbJfLm4+y01BnPnc3E2vBTqONz7JH/orWhjMpI
	CJHMpP6luq1I87LKRmJv12unibTp9U0l057+o+kJ5f0mvfCKpFxPnA1jbV+9ytgpq/WkgTf+k8p
	yxFD+dswRHQyjf8ZQ==
X-Google-Smtp-Source: AGHT+IHuM1h51UhnlA/yxdASgBhPyYJPIAYIMlQ610qlfw2XDY3Jn8anY5Kxkxf21TbaAbOqt3gpgmcGZLfm0zhJ2z0=
X-Received: by 2002:a05:622a:298e:b0:4b2:9461:58a7 with SMTP id
 d75a77b69052e-4b31d89da64mr112097321cf.4.1756791630032; Mon, 01 Sep 2025
 22:40:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-3-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 13:40:19 +0800
X-Gm-Features: Ac12FXx7uTtHy0cUMFCpITeASjSt1GLFJr9Uq8Fm7KxX6iJV8A0j1aBTmHg3o7s
Message-ID: <CAGsJ_4yMdzUOU6UZ+Ueo__wxHS3WPJoh6u3Lqo7iU05qBHc1fQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
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

> +/**
> + * folio_contains_swap - Does this folio contain this swap entry?
> + * @folio: The folio.
> + * @entry: The swap entry to check against.
> + *
> + * Swap version of folio_contains()
> + *
> + * Context: The caller should have the folio locked to ensure
> + * nothing will move it out of the swap cache.
> + * Return: true or false.
> + */
> +static inline bool folio_contains_swap(struct folio *folio, swp_entry_t entry)
> +{
> +       pgoff_t offset = swp_offset(entry);
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));

VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);    ?

Thanks
Barry

