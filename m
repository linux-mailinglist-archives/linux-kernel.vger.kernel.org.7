Return-Path: <linux-kernel+bounces-873834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546FDC14D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969381B27B90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B17330D51;
	Tue, 28 Oct 2025 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vOqZ7CBl"
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB6330B1F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658037; cv=none; b=dhr7/c/RI2+GrZ7YJtY4ZsUr2gC9PhAmgEqrDqdaeMkJOPoBFnRjSTmrb0mVylj42MdlcIuA/hm0rqIQ+HpkR9wshDtnUeeIPy7PFv5+ueFmfJX6DGhzdhsFhaDBGXpG+fez2IJiK0ozew8es/zyVp+VqNp8oMR9CvCWmbCTG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658037; c=relaxed/simple;
	bh=6tOvUVKpxOKb7Gg4h+XFORcgAcMdSB23g9jk3bOjqog=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JbNArCKL/gUokTnMD81LpINXNt4iLlpetPSOicUlxcAGiMsoIKekvaJ/T0dn8jwpPPO2HM1Ngp0/Fv4Uq5HmzX8uFgjlDZR0dk0UWRE5PIOYGj1mNlCSDvs0TPllVFpX2g4V0xKcE5HK1uncTk1WV7Vs22WPPDPHqbXVsOFP5wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vOqZ7CBl; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CGynThmWgqkc/pLRI/6X+ARzDe79YUlv0PioPW+llWE=;
	b=vOqZ7CBlO4peHO6+2xrvniiAJ6L+N9x4g+hLqNyez9wMLOZEZ+rVjym0lpE2lWLD0mVDPNur/
	NEq7lI+8CLZH4laP89Lynt3FGQih4O54neJQS9gc2VJy/f1jmMBxJJrIl8jxXrnato9nZc3FlLa
	jsVnUZTOYwLriEbBjTWM6go=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cwrkJ3lKGznTVF;
	Tue, 28 Oct 2025 21:26:32 +0800 (CST)
Received: from dggpemf200007.china.huawei.com (unknown [7.185.36.2])
	by mail.maildlp.com (Postfix) with ESMTPS id 351401402C4;
	Tue, 28 Oct 2025 21:27:10 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (7.185.36.8) by
 dggpemf200007.china.huawei.com (7.185.36.2) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Oct 2025 21:27:09 +0800
Received: from dggpemf500012.china.huawei.com ([7.185.36.8]) by
 dggpemf500012.china.huawei.com ([7.185.36.8]) with mapi id 15.02.1544.011;
 Tue, 28 Oct 2025 21:27:09 +0800
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
Subject: Re: [RFC PATCH 3/3] mm/mremap: Use can_pte_batch_count() instead of
 folio_pte_batch() for pte batch
Thread-Topic: [RFC PATCH 3/3] mm/mremap: Use can_pte_batch_count() instead of
 folio_pte_batch() for pte batch
Thread-Index: AdxIDDiulwIESNrFTrCD1E5/3V9Now==
Date: Tue, 28 Oct 2025 13:27:09 +0000
Message-ID: <8dc1d253056848dba950e74bed8218bd@huawei.com>
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

> On Mon, Oct 27, 2025 at 10:03:15PM +0800, Zhang Qilong wrote:
> > In current mremap_folio_pte_batch(), 1) pte_batch_hint() always return
> > one pte in non-ARM64 machine, it is not efficient. 2) Next,
>=20
> Err... but there's basically no benefit for non-arm64 machines?

It except have benefit in non-arm64 machines. In non-arm64 machine,
pte_batch_hint always return one although a folio are mapped by multiple
PTEs.=20

>=20
> The key benefit is the mTHP side of things and making the underlying arch=
-
> specific code more efficient right?

Yes, we except it could benefit from mTHP, and not just for arm64.

>=20
> And again you need to get numbers to demonstrate you don't regress non-
> arm64.

Yes, I will have a test on x86-64, non-contiguous folios or non-contiguous-=
folio
should not cause regression. Thanks for your kind reminder.

>=20
> > it need to acquire a folio to call the folio_pte_batch().
> >
> > Due to new added can_pte_batch_count(), we just call it instead of
> > folio_pte_batch(). And then rename mremap_folio_pte_batch() to
> > mremap_pte_batch().
> >
> > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> > ---
> >  mm/mremap.c | 16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c index
> > bd7314898ec5..d11f93f1622f 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -169,27 +169,17 @@ static pte_t move_soft_dirty_pte(pte_t pte)
> >  		pte =3D pte_swp_mksoft_dirty(pte);
> >  #endif
> >  	return pte;
> >  }
> >
> > -static int mremap_folio_pte_batch(struct vm_area_struct *vma,
> > unsigned long addr,
> > +static int mremap_pte_batch(struct vm_area_struct *vma, unsigned long
> > +addr,
> >  		pte_t *ptep, pte_t pte, int max_nr)  {
> > -	struct folio *folio;
> > -
> >  	if (max_nr =3D=3D 1)
> >  		return 1;
> >
> > -	/* Avoid expensive folio lookup if we stand no chance of benefit. */
> > -	if (pte_batch_hint(ptep, pte) =3D=3D 1)
> > -		return 1;
>=20
> Why are we eliminating an easy exit here and instead always invoking the =
more
> involved function?
>=20
> Again this has to be tested against non-arm architectures.
>=20
> > -
> > -	folio =3D vm_normal_folio(vma, addr, pte);
> > -	if (!folio || !folio_test_large(folio))
> > -		return 1;
> > -
> > -	return folio_pte_batch(folio, ptep, pte, max_nr);
> > +	return can_pte_batch_count(vma, ptep, &pte, max_nr, 0);
>=20
> This is very silly to have this function now ust return another function =
+ a trivial
> check that your function should be doing...
>=20
> >  }
> >
> >  static int move_ptes(struct pagetable_move_control *pmc,
> >  		unsigned long extent, pmd_t *old_pmd, pmd_t *new_pmd)
> { @@ -278,11
> > +268,11 @@ static int move_ptes(struct pagetable_move_control *pmc,
> >  		 * make sure the physical page stays valid until
> >  		 * the TLB entry for the old mapping has been
> >  		 * flushed.
> >  		 */
> >  		if (pte_present(old_pte)) {
> > -			nr_ptes =3D mremap_folio_pte_batch(vma, old_addr,
> old_ptep,
> > +			nr_ptes =3D mremap_pte_batch(vma, old_addr, old_ptep,
> >  							 old_pte,
> max_nr_ptes);
> >  			force_flush =3D true;
> >  		}
> >  		pte =3D get_and_clear_ptes(mm, old_addr, old_ptep, nr_ptes);
> >  		pte =3D move_pte(pte, old_addr, new_addr);
> > --
> > 2.43.0
> >


