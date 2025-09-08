Return-Path: <linux-kernel+bounces-806134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C417B49244
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D41516C3FB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9ED2FB965;
	Mon,  8 Sep 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+IHncyA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFD4690
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343721; cv=none; b=u/Ry+B6wmZyRtUZLqpPFNtrYdbaaLOLVtwwEEGVQPwrTZRU1F/rFT5FBZZ/U3rcGq4x9s0PBx6TfTZH4ZtoRoixe80DeRr1nlVzkam0/L6auYiwfq29ImyZ7sVD2w+vtIlY9iZOqTZLymGVOeeHWrlOI2iUmcI8myO7kui6c4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343721; c=relaxed/simple;
	bh=OM1OnbaCgtCJHQx8TjEqp20e7QRXP/rperJMzvdyHJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAdeEyvln21XXRd8c1a+1zXPog/DvQGWj7fiB7pqL+PHV/lRPtPLCy9fjVPhygPF0GIdF/79ym82/ThzYOl0ttN2Ni8gfurtlX90YkSVcsiPHvLS8VztJb9XTTXpGTvFe7H1oI753365gA6+qIoP6kL5GgATNmOhEDFkuyF4UBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+IHncyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701DBC4CEFE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757343721;
	bh=OM1OnbaCgtCJHQx8TjEqp20e7QRXP/rperJMzvdyHJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t+IHncyAt99nsaBlpRj5ClL+DBgHDhjRApzY1W2mNG5Nhm0qqqbNnm+pk9K1YF/zw
	 KDab1+gLRhxOVBZUYOlP2dO5aiRy7IdayqvEunDj0ihLrD3n92vfVUHepBqaR0hZjl
	 EmPvHqY5g8HTk33PapRve6SVvfyvIlCGbRygHVeB25033RdxRS+iyx1Pa6wGM2r85y
	 CbbX49t4lxFTQrBl90e0QpwG2VB3doEsA3efpj/xCqzaXZ4/Fkz6WPo1GsB7e9B9yF
	 qfexhXX2mBJIrVCumMuy7XmkNhkqiwV4c7YnyaWdvOqdNajzLJmcaqYtvl1K1mWSuY
	 +/8U30RB82fOw==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6083cc69so43943507b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQse2RcN9XskG1v7my756Cuk2KD0S1lNFL88JMFmSi1Y1gSm7sN7M/AIePXGUOXYF1VOgEV433zCwkOow=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywadj2Xai2h9tvXDiiC221VeXoRYRm05YhtSDuSIRH3IpbJpcIw
	pyS/ZnbJe7j3L3wgvVkVyYl5X3mkZIb6GjKZBwKTONQm21l9egQOcpCJJG/+MONJPyZihIebCnU
	4+Gue99uWlC2deXB5poAa8WDpUBBapKn+6bwz7z4qfw==
X-Google-Smtp-Source: AGHT+IHWbXOCSB5y6ER64K0ZmM5y11hkhIk4ACM6eQQ+BVtQgZ3qMKAziLcIoqDNeTbp/CE9+BjYyloFcWxkmFw5I8E=
X-Received: by 2002:a05:690c:7691:b0:729:afb7:2a2b with SMTP id
 00721157ae682-729afb74a58mr34955597b3.46.1757343720607; Mon, 08 Sep 2025
 08:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-2-ryncsn@gmail.com>
 <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
In-Reply-To: <aL7NrhGw5ftOXUZs@MiWiFi-R3L-srv>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 8 Sep 2025 08:01:48 -0700
X-Gmail-Original-Message-ID: <CACePvbXi3Avsic62fMdhLaDfiq4LS_t8-wbm9yQnEkScoxYO-g@mail.gmail.com>
X-Gm-Features: Ac12FXwmTYW_a0Q3ghO_ME29Wz56bBlZ-2vE9ttlwiVb8HKkdfVHMJ78txT5mGw
Message-ID: <CACePvbXi3Avsic62fMdhLaDfiq4LS_t8-wbm9yQnEkScoxYO-g@mail.gmail.com>
Subject: Re: [PATCH v2 01/15] docs/mm: add document for swap table
To: Baoquan He <bhe@redhat.com>
Cc: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 5:36=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/06/25 at 03:13am, Kairui Song wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > From: Chris Li <chrisl@kernel.org>
>
> 'From author <authorkernel.org>' can only be one person, and the co-autho=
r
> should be specified by "Co-developed-by:" and "Signed-off-by:"?

That is the artifact of sending another person's patch in a series.
The first "From" is from the email header sender. The second "from" is
the real author of the patch. Just like an IP tunnel packet there is
another inner IP packet wrapped in the outer IP packet.

I think that is all normal and did not violate the kernel rules. When
I include Kairui's patch in my swap allocator series. The same thing
happened there on Kairui's patch. In the end the git will know enough
who is the real author, because those patches are  outputted by git
anyway.

Chris

