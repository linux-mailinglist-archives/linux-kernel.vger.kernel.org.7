Return-Path: <linux-kernel+bounces-873637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43699C144D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8973940166F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138222FFDD4;
	Tue, 28 Oct 2025 11:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HO7joC8n"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE3212575
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650009; cv=none; b=g7VBv3U3xhE+cHEUe9pFqs2f7Za7O/cbwuB2zS4/U4h811hWZpNuB8XxaGAyt7JBrPv5SiQtzYwXLQdWq2AHJU22RDfyLTPimzSh0RnjD/Bp0PJh+eCqf4j381rTrnM9dnvI4+DPKHIBdgm91x73pGDm9MSX/DVzhiti9B7Nklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650009; c=relaxed/simple;
	bh=uggkgi3Q7362PrEjJk1FfF452uwKbfjn5GiV7MqBnPc=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=I0ueoBT4X7Nr+DeY9QAZSorpjd5LSYPDkvr+KKBpSotH8vUvYJm1Vm4/IelOIfvPZC926GOKiF2oC9xn3AsvuwlQxv91l/HaUO2P60VrDpuXUr+byXK9y5lEudHJKM6NNwt8klLFoBcygyTm6TUbhmpHgKYMjzFSrYwAqe6qoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HO7joC8n; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IruZ6tsBVucJWwjqgHjIbPoWLccutkeIxO4pOhVzLak=;
	b=HO7joC8nay2zm7gfgvo3nT4alXc9FalA+xPchBjsCjATqUI2d12omH8t3KByJQDv29FvDJP5y
	yZ5JyzoEkqFlkubOk8LCise9PxMgp5XjNoiXmtYnCE33B393RBvGAeZR0noGRtP7YRDl03NXlGz
	YP0JqVX0+6NToW2WH1J8E1c=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cwnm01D7cz1prLt;
	Tue, 28 Oct 2025 19:12:48 +0800 (CST)
Received: from dggpemf200009.china.huawei.com (unknown [7.185.36.246])
	by mail.maildlp.com (Postfix) with ESMTPS id DDD6A180237;
	Tue, 28 Oct 2025 19:13:16 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (7.185.36.8) by
 dggpemf200009.china.huawei.com (7.185.36.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 19:13:16 +0800
Received: from dggpemf500012.china.huawei.com ([7.185.36.8]) by
 dggpemf500012.china.huawei.com ([7.185.36.8]) with mapi id 15.02.1544.011;
 Tue, 28 Oct 2025 19:13:16 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Wangkefeng (OS Kernel Lab)"
	<wangkefeng.wang@huawei.com>, Sunnanyong <sunnanyong@huawei.com>
Subject: Re: [RFC PATCH 2/3] mm/mincore: Use can_pte_batch_count() in
 mincore_pte_range() for pte batch mincore_pte_range()
Thread-Topic: [RFC PATCH 2/3] mm/mincore: Use can_pte_batch_count() in
 mincore_pte_range() for pte batch mincore_pte_range()
Thread-Index: AdxH+5T+8zk9AGSdQ5COU3ncduDLzg==
Date: Tue, 28 Oct 2025 11:13:16 +0000
Message-ID: <29d2ad2f81b14c8384bd0a7d8d60ef62@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

 On Mon, Oct 27, 2025 at 10:03:14PM +0800, Zhang Qilong wrote:
> > In current mincore_pte_range(), if pte_batch_hint() return one pte,
> > it's not efficient, just call new added can_pte_batch_count().
> >
> > In ARM64 qemu, with 8 CPUs, 32G memory, a simple test demo like:
> > 1. mmap 1G anon memory
> > 2. write 1G data by 4k step
> > 3. mincore the mmaped 1G memory
> > 4. get the time consumed by mincore
> >
> > Tested the following cases:
> >  - 4k, disabled all hugepage setting.
> >  - 64k mTHP, only enable 64k hugepage setting.
> >
> > Before
> >
> > Case status | Consumed time (us)  |
> > ----------------------------------|
> > 4k          | 7356                |
> > 64k mTHP    | 3670                |
> >
> > Pathed:
> >
> > Case status | Consumed time (us)  |
> > ----------------------------------|
> > 4k          | 4419                |
> > 64k mTHP    | 3061                |
> >
> > The result is evident and demonstrate a significant improvement in the
> > pte batch. While verification within a single environment may have
> > inherent randomness. there is a high probability of achieving positive
> > effects.
>=20
> Recent batch PTE series seriously regressed non-arm, so I'm afraid we can=
't
> accept any series that doesn't show statistics for _other platforms_.
>=20
> Please make sure you at least test x86-64.

OK, I will have  a  test on x86-64 as soon and it may yield unexpected resu=
lts.

>=20
> This code is very sensitive and we're not going to accept a patch like th=
is without
> _being sure_ it's ok.

Year, it's a hot path, we should be extremely cautious.

>=20
> >
> > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> > ---
> >  mm/mincore.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mincore.c b/mm/mincore.c index
> > 8ec4719370e1..2cc5d276d1cd 100644
> > --- a/mm/mincore.c
> > +++ b/mm/mincore.c
> > @@ -178,18 +178,14 @@ static int mincore_pte_range(pmd_t *pmd,
> unsigned long addr, unsigned long end,
> >  		/* We need to do cache lookup too for pte markers */
> >  		if (pte_none_mostly(pte))
> >  			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
> >  						 vma, vec);
> >  		else if (pte_present(pte)) {
> > -			unsigned int batch =3D pte_batch_hint(ptep, pte);
> > -
> > -			if (batch > 1) {
> > -				unsigned int max_nr =3D (end - addr) >>
> PAGE_SHIFT;
> > -
> > -				step =3D min_t(unsigned int, batch, max_nr);
> > -			}
> > +			unsigned int max_nr =3D (end - addr) >> PAGE_SHIFT;
> >
> > +			step =3D can_pte_batch_count(vma, ptep, &pte,
> > +						   max_nr, 0);
> >  			for (i =3D 0; i < step; i++)
> >  				vec[i] =3D 1;
> >  		} else { /* pte is a swap entry */
> >  			*vec =3D mincore_swap(pte_to_swp_entry(pte), false);
> >  		}
> > --
> > 2.43.0
> >


