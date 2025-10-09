Return-Path: <linux-kernel+bounces-846293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9DBC77BD
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06C9D4EA454
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0453629346F;
	Thu,  9 Oct 2025 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H6r2fzRf"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD31F8AC5
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989855; cv=none; b=E8X4060PPAFlaUtSHujfZj5FtIX8KFTd5Pgj4air4lIbT2s0gKgP+tCzIhjvkSz8X4ROZVs0K0aB6HKjBOSG3asvipgCqq96Plcmjysn9fFUtERkkdsf5cItqzOH2WOXnoQp2gOGIOjREhDK1v7xGIrpBk/a5sA2YAa5iypgCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989855; c=relaxed/simple;
	bh=vODz0RN10J2bMCNb5BAyumCBvCiIgUcHFA3JTIAhW0k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SxilINh5nWvc1SWsR3pm8XKme238TvRw6AyF8OIQlelG3p0Kh4fCvEQPQoTeYKQLNqixyKowmZDG6KGD5NrhlUn9wtxzh1VWH/tV8cqEZdQ8sW+XU3LnO/PCeMfvrQ/zXUmDZzOadyZd+lwqzrB806WRyAQ2CpgeJkYzMyU+kQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H6r2fzRf; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759989849; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=bX2CmiGH9cU2/SkYhdfhaISvrY/NYRlNzsQnhnysgAs=;
	b=H6r2fzRfRbqrcWu06S+ZfmSmijyHcogOm1InrN7lWsOxwK0R+bX7qiu6uSIpUlDDsPoR3pcNNHyKOkJnW5DeWQgxwgFHx1J06RXNBzgywFka5pOZ+xLC7UkGGOLi0/BMQql2g00aK5gzUaYHN8LBUZ+K6H3Q5Q2+QQ0H22ifZis=
Received: from LG41624401116(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0WpjGwvU_1759989848 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 14:04:08 +0800
From: <yadong.qi@linux.alibaba.com>
To: "'Andrew Morton'" <akpm@linux-foundation.org>
Cc: <urezki@gmail.com>,
	<linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>,
	<ying.huang@linux.alibaba.com>
References: <20251009035943.526-1-yadong.qi@linux.alibaba.com> <20251008211714.5a8b9fbb57dbe454cd4a9c6d@linux-foundation.org>
In-Reply-To: <20251008211714.5a8b9fbb57dbe454cd4a9c6d@linux-foundation.org>
Subject: RE: [PATCH] mm: vmalloc: BUG_ON if mapping size is not PAGE_SIZE aligned
Date: Thu, 9 Oct 2025 14:04:08 +0800
Message-ID: <000d01dc38e2$86ab7460$94025d20$@linux.alibaba.com>
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
Thread-Index: AQEfqa1TUb5DdaMeKJ5HQMODeYaJIQI0Cl/AtiDDkRA=
Content-Language: zh-cn

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: 2025=C4=EA10=D4=C29=C8=D5 12:17
> To: Yadong Qi <yadong.qi@linux.alibaba.com>
> Cc: urezki@gmail.com; linux-mm@kvack.org; =
linux-kernel@vger.kernel.org;
> ying.huang@linux.alibaba.com
> Subject: Re: [PATCH] mm: vmalloc: BUG_ON if mapping size is not =
PAGE_SIZE
> aligned
>=20
> On Thu,  9 Oct 2025 11:59:43 +0800 Yadong Qi =
<yadong.qi@linux.alibaba.com>
> wrote:
>=20
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
> > BUG_ON().
> >
> > ..
> >
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -100,6 +100,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned =
long
> addr, unsigned long end,
> >  	struct page *page;
> >  	unsigned long size =3D PAGE_SIZE;
> >
> > +	BUG_ON(!PAGE_ALIGNED(end - addr));
> > +
> >  	pfn =3D phys_addr >> PAGE_SHIFT;
> >  	pte =3D pte_alloc_kernel_track(pmd, addr, mask);
> >  	if (!pte)
>=20
> We try to avoid adding BUG()s - deliberately crashing the kernel is
> pretty cruel to the user.  It's far better to WARN and to continue in
> some fashion so the user can at least gather logs, etc.
>=20
> How about
>=20
> 	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
> 		return -ENOMEM;
>=20
> ?
>=20
> (Or VM_WARN_ON)

Sure, I will send a new patch with WARN_ON.

Best Regard
Yadong


