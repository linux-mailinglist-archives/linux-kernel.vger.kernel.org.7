Return-Path: <linux-kernel+bounces-796091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFEEB3FBD0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2613B1835
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB4F2EDD53;
	Tue,  2 Sep 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj13A9HQ"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647062E9731
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807634; cv=none; b=ivHT4W3jbg8QSi2eG6bFhQHA3DS3ziHRqV+QdqYbMrdyyenVCpuTALjuxdlMmQyCgGi4Cl1O4po+OSM5g7kJKZInu6Gmqq1D9nYgnBS2X6YCM7yEQm2TNP470yrhGgS9phuJhfZp7Zc2Ajcdp0XtxnIh/qJAHAkjpkyRg/GiInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807634; c=relaxed/simple;
	bh=jrAOpTnL363G+6BC29hgzUSrK5gRlkPfx59tzKZpZe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDkC6hKHC+whltH1+wG1rFqgC25SY9TT2bHV2076KPGU51621RMAgEo2EJS6ygvnzJDfkxnnOcJFrVWLS4n926x8PZw8jrn6xZ96PCKimURyyc9TY/qfwyYryBkSG8LdLdBCYIXK5HPSYFGkXAyy4pApUxNiv7X7aNakrhJvssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj13A9HQ; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-53b174ca9bdso3710390e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756807631; x=1757412431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrAOpTnL363G+6BC29hgzUSrK5gRlkPfx59tzKZpZe8=;
        b=Kj13A9HQ15bF0izgO+799JCKvqbioSRjW+e4jqV+/IVcEbYkny35tGxO/nRN4B4SQa
         RczE1mixuEvCgGTCCh21IFiomTwJr+LfFZQaNCAnuYOYz67iq1dtR0dtdBMxLEKHKVAn
         8wiqWohVnHO9fPTz0U1PszbDCEQcY4utFZyDKpeYWL+GOfGQB3vv21e320GNf9mkXABG
         q23DkLpAwZ9cxv0nZVRHgXT+JPjTdu2ii1D8zlD3uro4GId+ASrhNa1x3EoRjmDt/Azn
         gmqhRAye429lGxc9h4Yt8BezVO6E8LnVGpO/XI+aVUdY5qbbggPFXPlurbysa+EvD1Cu
         BCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756807631; x=1757412431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrAOpTnL363G+6BC29hgzUSrK5gRlkPfx59tzKZpZe8=;
        b=sbwHLwD1n+GnCWd2++tjHtTbWq15WrRRhRcQArqpzNqqMqN04rnGQiekflcywSWbFO
         JXUvIjNwz5vI4mLepFDLb88EV6mSTj1xXJrYjA68WJhJh79mJb7dMerwxpVVfqeMFjeu
         uGen5yoP0aKPzjMHo6klgq7Z0FRV4ET6VZLwEV48uOMEK9y26p189Xsd3sT6/4+rCdxR
         w9fTtUuts5UEEJicWIa0TltjAv5KLJy3srN8dzZuHk3g2LFuAn1QmZnJnhZbbkN04/I7
         r1nzVQsMDX0Ip+xR+hSEOseHvinR8GATHGHGrcgXl+rBym0KnOHVEYsZps/bEFUUn667
         PN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCURfCw4iC1c/fHEgkcm+XDERThwpYXAozuH6ywYVsq3GETxhKpxMKyaFYOrHAWRCtEVtVURWmqgIycke40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfd6cewW64sakde5GZEXBKnRTxBaPzyJkFeIaaQ9snAac753FV
	2AAHXoYsU1PVedoNxt7Vt+jJ4waWWmkMXNnZzu0rr75vG95czp1JJhizeJ15fCfxW4TooGP7EVM
	yKUpTcfpfR+WWp80dBW1pYfSWOCtFrFo=
X-Gm-Gg: ASbGncvC/8zqae/HuUxb0M1FqV5NVwCkx5rNi3THPrJ4dQIVt/q4j7cUVa5VtR2kbVZ
	/60T1vFcd+QKEs+r3cqPmkolpjQXJZKb24BBtndH0nDerLYob7uc76WGklE0TDpVEoPB9Y8Znvd
	ahF7MNXAR6vVt/KvyO8jNTo7WkfpgLsFyGEqqqmJuPVzK9wZt+u4Fu1jTtmJmKUn3PPgXqyFzAR
	rEAEz894VUR/6sTbA==
X-Google-Smtp-Source: AGHT+IFj6WTlzVmDMSvbDwsIF7zaKqomYaay4LaA2X4TYZ0wC13TBbd0pTml2AKOE5bBGAAX9jk0YV9AyGMxwXWAdtQ=
X-Received: by 2002:a05:6122:459b:b0:544:79bd:f937 with SMTP id
 71dfb90a1353d-544a032697cmr3707407e0c.15.1756807631529; Tue, 02 Sep 2025
 03:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-8-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-8-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Sep 2025 18:06:59 +0800
X-Gm-Features: Ac12FXzr_QuDNQ1ketQVI0L0O2e5pn7ImaHsrDqHTF4iWbuQt0_ufzEsJP1Vm7g
Message-ID: <CAGsJ_4xNydZqSx7GJ9GfUGaSVERZ2Nj82D5eefMN_Q-OUjnoyw@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 3:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cluster setup will try to shuffle the clusters on initialization.
> It was helpful to avoid contention for the swap cache space. The cluster
> size (2M) was much smaller than each swap cache space (64M), so shuffling
> the cluster means the allocator will try to allocate swap slots that are
> in different swap cache spaces for each CPU, reducing the chance of two
> CPUs using the same swap cache space, and hence reducing the contention.
>
> Now, swap cache is managed by swap clusters, this shuffle is pointless.
> Just remove it, and clean up related macros.
>
> This should also improve the HDD swap performance as shuffling IO is a
> bad idea for HDD, and now the shuffling is gone.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.co=
m
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

