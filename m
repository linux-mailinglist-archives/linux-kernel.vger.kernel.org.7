Return-Path: <linux-kernel+bounces-796434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B5DB400BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EE4174673
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326C22154D;
	Tue,  2 Sep 2025 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoJVAyD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66E21FF44
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816385; cv=none; b=HpDZ2MB7pmGFdp+bUXRBefhtHZ2UtfmRbF0CiSo2oNpcgOH9twtyRxlnq9Zwf6N8Uzs7k/pxv1G8Qqd5UBa4Xc9WTbezIhOOU2KC9P1tWkUMhP0l9m6RlwpeZW5dc6end/ZMKOt2jCdKfC46zP9vkuymXQZpPSYR9R2U+KUGpbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816385; c=relaxed/simple;
	bh=CA0UUA72UigpJyj1WkBvnnwxWytyjCGoELrQPL5uv00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdiVXoc8oLDJBKnu06S2KAdtEvF65Uh3+Y48TP2Eq0usmiCHk/cr9mlA8U0noVitE6a56o5KYHAqUAArckmjm4Wd9beGtr9IJZ2rxvpm3F7uOJm0YBHuhThUpjrcJ/kiphgTT4aEknTgfv9liAt3krAA+xJRO8pHN7neFlSadh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoJVAyD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E77C116C6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756816385;
	bh=CA0UUA72UigpJyj1WkBvnnwxWytyjCGoELrQPL5uv00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VoJVAyD4t9u3SwwyzLu8QVYRndeyB5drflEfsebmVMqGOVE1Wv8d7/3lBjTCEoFWn
	 itUOpaZugcOGS0jWXb2q9az2yi6f4rRQQwtDPyO5e8f/NRhXikOP9OyxIxzmH8FnyZ
	 NG7S43AB17FFyo6euWCFfdWhrypGAZnVN62j8BKNYLk0armBHsq0M7O1ESgvZ2W+F9
	 +M/4BpwOV86PzB0pBzG5rPA3YAVyHb6sSDozB3tOlEAt0VI//ifkCGds3e9WeoqzNu
	 z39mGn9AauxCtapJexLThXHk4RrO2urOCuwoKNdF/08WfKDLktrl21OiCeAu53YOrg
	 Voxo26Ze+Hc5w==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d6051aeafso45328047b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 05:33:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7eUf6R3dZhntrGBXgWMzxN1CK6sDPQkzpH3nknEWvxukWXfkEFjlraYndjg6T4YyH5LR7Sb88MZa5MKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycP01KfqsIJINTscAwqnaCOZ7G6kIkz2WcOsgSvAnWVh1vHyQx
	mG7nAHmgQRCDnc1PfppBQpRz0PpVlRsems9ToWqZ70ccG1sfv7yqucnbje0qdQvscJ16FRUSn5R
	y5LrRHSC3YyOvX76NjAPm44vSM7z7MdcuiZXDiVlC7Q==
X-Google-Smtp-Source: AGHT+IFfYPr1k+1vxa1r96GXeWzehyJG4pmR2rrje/td5emhAfo5OQhJx8XV8yU9JqVgGrdT/u4cpNxwqOOd1C7ndJg=
X-Received: by 2002:a05:690c:6f81:b0:71c:bf3:afb0 with SMTP id
 00721157ae682-7227650c487mr98822267b3.40.1756816384211; Tue, 02 Sep 2025
 05:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-2-ryncsn@gmail.com>
 <c4a729b8-be9e-4005-aab6-91723fcf0080@redhat.com>
In-Reply-To: <c4a729b8-be9e-4005-aab6-91723fcf0080@redhat.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 2 Sep 2025 05:32:53 -0700
X-Gmail-Original-Message-ID: <CACePvbVQGbyO=csbLG-0uP8gwY3JkS73nHCBb8Eq7xNwD=N=9A@mail.gmail.com>
X-Gm-Features: Ac12FXxpY-4M4Ku106VflhPcLiF6Pc14_5Y_oPbRVEBK8d5OsGab4H4c580H9cM
Message-ID: <CACePvbVQGbyO=csbLG-0uP8gwY3JkS73nHCBb8Eq7xNwD=N=9A@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:07=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 99513b74b5d8..ff9eb761a103 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -69,6 +69,21 @@ void show_swap_cache_info(void)
> >       printk("Total swap =3D %lukB\n", K(total_swap_pages));
> >   }
> >
> > +/*
>
> While at it, proper kerneldoc?

Agree, add the kerneldoc while we are at it. Those are important API
to interact with the swap table.

BTW, I already submitted a design doc for swap table to Kairui, which
will show up as the first patch in the V2 series

Chris

