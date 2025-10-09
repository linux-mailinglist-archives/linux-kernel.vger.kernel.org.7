Return-Path: <linux-kernel+bounces-846653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBABC8A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B33528A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572B52DECB0;
	Thu,  9 Oct 2025 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KfoK2xnt"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D02E8B86
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007476; cv=none; b=NMgxCnnN5T3goKU+GzQ8FnHeni+mTRtBHymQfo5gxEIjXN8Jd4DSf7JIBuRqXrDf0mHhc/H23JGMlBbImQFHeTc6bdxi0QJnqZaXKmkijHOv4a1AVxHb5Qn72BUWbsUUKvK6orNe3IbH3xvj0f1Og4znE4BO6+G3egxiZ3F8/kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007476; c=relaxed/simple;
	bh=hyh+LCEuQE7GJamlSAFoXKnjp8PQejpEGYginwJsIxs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=XT32X8YYXJ9uztrxuCsixEOJ78HsYuTwNqPliGiFHv+/Jma2jgGt7mcG8xI8MWiLUP+7pM8pp96XpTEf5OQvJP8afnEpkmD5i5iz+twmXQ5jD4ehXRC3IKeK4C++PI61fj3c6/hrAGjF+qOBnCC1hoS/5fSubib3nghdZ6ioeMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KfoK2xnt; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760007469; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=7r1quKn+BuTk3jaZkpXZ3gMtPbVEjL5mdTyR1kfEgUw=;
	b=KfoK2xntLWcG1STa+j9KstT3PTnFSq9SfEiQGjunoAMFYaY6h5c8U7YjamK3R9zeLoN1gsDkcezZcjHLlkE9r69pQ/K/Ulu3g6CwWDhMB7b5gPMXJo/pwDHt2mEMXiQuMIoiImSdgpb1iiUxjwHe3JFFwM7sT0+EZq/UY/Plk0c=
Received: from LG41624401116(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0Wpmiumm_1760007468 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 18:57:48 +0800
From: <yadong.qi@linux.alibaba.com>
To: "'Uladzislau Rezki'" <urezki@gmail.com>
Cc: <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>,
	<ying.huang@linux.alibaba.com>
References: <20251009093707.868-1-yadong.qi@linux.alibaba.com> <aOeEYHzXUVOpu174@milan>
In-Reply-To: <aOeEYHzXUVOpu174@milan>
Subject: RE: [PATCH v3] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE aligned
Date: Thu, 9 Oct 2025 18:57:48 +0800
Message-ID: <001401dc390b$8d074680$a715d380$@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGd0BTLCsR2DZmbflymI0KNfeFshwG5mHeetSipVcA=
Content-Language: zh-cn

> -----Original Message-----
> From: Uladzislau Rezki <urezki@gmail.com>
> Sent: 2025=C4=EA10=D4=C29=C8=D5 17:46
> To: Yadong Qi <yadong.qi@linux.alibaba.com>
> Cc: akpm@linux-foundation.org; urezki@gmail.com; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; ying.huang@linux.alibaba.com
> Subject: Re: [PATCH v3] mm: vmalloc: WARN_ON if mapping size is not =
PAGE_SIZE
> aligned
>=20
> On Thu, Oct 09, 2025 at 05:37:06PM +0800, Yadong Qi wrote:
> > In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> > mapping size is aligned to PAGE_SIZE. If this assumption is
> > violated, the loop will become infinite because the termination
> > condition (`addr !=3D end`) will never be met. This can lead to
> > overwriting other VA ranges and/or random pages physically follow
> > the page table.
> >
> > It's the caller's responsibility to ensure that the mapping size
> > is aligned to PAGE_SIZE. However, the memory corruption is hard
> > to root cause. To identify the programming error in the caller
> > easier, check whether the mapping size is PAGE_SIZE aligned with
> > WARN_ON().
> >
> > Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> > Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> > ---
> > v2 -> v3:
> >   * change error code from ENOMEM to EINVAL
> >   * modify callers of vmap_pte_range to handle return code
> > v1 -> v2:
> >   * Use WARN_ON instead of BUG_ON
> > ---
> >  mm/vmalloc.c | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5edd536ba9d2..1fa52f203795 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned =
long
> addr, unsigned long end,
> >  	struct page *page;
> >  	unsigned long size =3D PAGE_SIZE;
> >
> > +	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
> >
> And it might be worth to use WARN_ON_ONCE() otherwise there is a risk
> that a kernel buffer would contain only such warnings.
>=20

Sure, will change in next version.

Best Regard
Yadong


