Return-Path: <linux-kernel+bounces-846372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 58787BC7BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0465A352125
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1DA21638D;
	Thu,  9 Oct 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d2JEtOgs"
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2437F4FA
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995624; cv=none; b=Pw+neRMjJKbSOcP7Q44oatF0gwg4CI1Xz9tIgmokz5Ff3sy+EHgfzkWwTA4RhT8k3JSL+c0g6tgVk1hYxS8yx0qycJe7NlTSrhaVGLIX6qIq17BFB+sRS7ciYP0BxwRFoe2DZD3EPvWusYdRDisNqntYkLzyR11RYO2fbJdkPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995624; c=relaxed/simple;
	bh=lJVMrN8b566rKCI8xVGraN1cNXO76QI0vxrQLWZt8OI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=SCBAgMWAzD2q590SHoVMxR+mDRZM+W7SvcVynt9hS3GUAYNx+x9wwBdrkbB4UdjFnp2bMh78rTr4KWbbgJu9E+o2j95A2JM3MpEM+8iuAa37CsfNITiNsIxEs5HA/8Th5OJfeHUfTvZzelkro+U2+JAXtbqosWWkulIh/xc+bPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d2JEtOgs; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759995610; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=fmkkQQ3u5wzLEz28oroV4vlMCTJQvx36W8GzggAdlhg=;
	b=d2JEtOgsmc9rvdiUzC90Tuc67iB034+WsPT7rQpTbdM77oMYfpZN2eItE4g7TQBVxr2DqfB80Hw8KiVGCJeDIyrOwPaDmP8bEep8SQboUDKFKosz7iQOgb5hV7o/x/g5hECgNYOopptCtiywOw0lQVDewaaCPT4hsRIkPSkMeIY=
Received: from LG41624401116(mailfrom:yadong.qi@linux.alibaba.com fp:SMTPD_---0WpkCT8Y_1759995291 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Oct 2025 15:34:51 +0800
From: <yadong.qi@linux.alibaba.com>
To: "'Andrew Morton'" <akpm@linux-foundation.org>,
	"'Huang, Ying'" <ying.huang@linux.alibaba.com>
Cc: <urezki@gmail.com>,
	<linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20251009061410.820-1-yadong.qi@linux.alibaba.com>	<87zfa0tw9o.fsf@DESKTOP-5N7EMDA> <20251009000356.8e18395dd9979045e0c66de2@linux-foundation.org>
In-Reply-To: <20251009000356.8e18395dd9979045e0c66de2@linux-foundation.org>
Subject: RE: [PATCH v2] mm: vmalloc: WARN_ON if mapping size is not PAGE_SIZE aligned
Date: Thu, 9 Oct 2025 15:34:51 +0800
Message-ID: <001201dc38ef$33162220$99426660$@linux.alibaba.com>
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
Thread-Index: AQDNMrr7Fq5t9NtUPwBpedxNSvimKQKJivZeASdK0me2ue+C4A==
Content-Language: zh-cn

> -----Original Message-----
> From: Andrew Morton <akpm@linux-foundation.org>
> Sent: 2025=C4=EA10=D4=C29=C8=D5 15:04
> To: Huang, Ying <ying.huang@linux.alibaba.com>
> Cc: Yadong Qi <yadong.qi@linux.alibaba.com>; urezki@gmail.com;
> linux-mm@kvack.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2] mm: vmalloc: WARN_ON if mapping size is not =
PAGE_SIZE
> aligned
>=20
> On Thu, 09 Oct 2025 14:38:27 +0800 "Huang, Ying"
> <ying.huang@linux.alibaba.com> wrote:
>=20
> > Yadong Qi <yadong.qi@linux.alibaba.com> writes:
> >
> > > In mm/vmalloc.c, the function vmap_pte_range() assumes that the
> > > mapping size is aligned to PAGE_SIZE. If this assumption is
> > > violated, the loop will become infinite because the termination
> > > condition (`addr !=3D end`) will never be met. This can lead to
> > > overwriting other VA ranges and/or random pages physically follow
> > > the page table.
> > >
> > > It's the caller's responsibility to ensure that the mapping size
> > > is aligned to PAGE_SIZE. However, the memory corruption is hard
> > > to root cause. To identify the programming error in the caller
> > > easier, check whether the mapping size is PAGE_SIZE aligned with
> > > WARN_ON().
> > >
> > > Signed-off-by: Yadong Qi <yadong.qi@linux.alibaba.com>
> > > Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>
> > > ---
> > > v1 -> v2:
> > >   * Use WARN_ON instead of BUG_ON
> > > ---
> > >  mm/vmalloc.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 5edd536ba9d2..2cad593e4677 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -100,6 +100,9 @@ static int vmap_pte_range(pmd_t *pmd, unsigned =
long
> addr, unsigned long end,
> > >  	struct page *page;
> > >  	unsigned long size =3D PAGE_SIZE;
> > >
> > > +	if (WARN_ON(!PAGE_ALIGNED(end - addr)))
> > > +		return -ENOMEM;
> > > +
> >
> > EINVAL?
> >
>=20
> If this errno gets returned to userspace somehow, programmer is going
> to wonder what was invalid about the arguments which the program =
passed
> to the kernel.
>=20
> But either way, the callers of vmap_pte_range() should be audited, to
> verify that they take appropriate action when this happens.

I believe we should modify vmap_pmd_range(), vmap_pud_range(), and
vmap_p4d_range()
to accept an error code from the callee instead of simply returning =
-ENOMEM.
If there are no other suggestions, I will create a new patch.


