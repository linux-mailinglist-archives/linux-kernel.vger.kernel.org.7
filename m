Return-Path: <linux-kernel+bounces-750106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61888B1575D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FBA3A5429
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB219E806;
	Wed, 30 Jul 2025 02:00:11 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85E1D799D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840811; cv=none; b=TGMl45aDHUiRjjA8POdZVzu2aKVU34Jo99pMbc29SewblafDOCOd5oIggrVVaeMakcbhgekfYIqGQTzBhJfbVGaNwOs828zr1qzz/1IfJgNN5/VSIIby9lMi8aDopu3ibdyPsaab4VEHlgk2vfh2F5JnXxZ6XTEA6s89ZyxQ7Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840811; c=relaxed/simple;
	bh=5gTZbGpY6YL7Uwtr/UnSTpheLEBzGtwkuHA71h+i8Tg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Yp/qL0NBaUNnxHBeRIIgZV1H8g9qAP10GKPCK2Tzo4hlZ0tdf96u6OfISU7G0EH+Bi7+MQD1AQY7/ALNb9EXt8oNXMoqQ38buOG83OolwAsUbdY/pwZDnvPnn7gSSCCFyTE0CQ90Joeq+RHrGfrzWIGF/Nvi8hBQYsV5++FzBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bsFfT4qJBzSjfM;
	Wed, 30 Jul 2025 09:55:29 +0800 (CST)
Received: from dggpemf500008.china.huawei.com (unknown [7.185.36.156])
	by mail.maildlp.com (Postfix) with ESMTPS id C1BE81402DA;
	Wed, 30 Jul 2025 10:00:04 +0800 (CST)
Received: from dggpemf500012.china.huawei.com (7.185.36.8) by
 dggpemf500008.china.huawei.com (7.185.36.156) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 10:00:04 +0800
Received: from dggpemf500012.china.huawei.com ([7.185.36.8]) by
 dggpemf500012.china.huawei.com ([7.185.36.8]) with mapi id 15.02.1544.011;
 Wed, 30 Jul 2025 10:00:04 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>, Sunnanyong
	<sunnanyong@huawei.com>
Subject: Re: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
Thread-Topic: [PATCH] /dev/zero: try to align PMD_SIZE for private mapping
Thread-Index: AdwA8B+aYBqfNHtAQZ+Ap7afBezwHQ==
Date: Wed, 30 Jul 2025 02:00:04 +0000
Message-ID: <2348ddc4573143e48de87cfc66e6748b@huawei.com>
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

>=20
> On Tue, Jul 29, 2025 at 09:49:41PM +0800, Zhang Qilong wrote:
> > By default, THP are usually enabled. Mapping /dev/zero with a size
>=20
> Err... we can't rely on this.

OK, I will update this description in next version. =20

>=20
> As per below comments on code, I'd update this to say something about
> fallback if it's not.
>=20
> > larger than 2MB could achieve performance gains by allocating aligned
> > address. The mprot_tw4m in libMicro average execution time on arm64:
> >   - Test case:        mprot_tw4m
> >   - Before the patch:   22 us
> >   - After the patch:    17 us
> >
> > Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
>=20
> This looks ok to me because there's a precedent for using
> thp_get_unmapped_area() directly as a file_operations-
> >get_unmapped_area e.g. in ext4.
>=20
> We also simply (amusingly, or perhaps not hugely amusingly, rather
> 'uniquely') establish an anonymous mapping on f_op->mmap via
> mmap_zero() using vma_set_anonymous(), so we can rely on the standard
> anon page memory faulting logic to sort out the actual allocation/mapping=
 of
> the huge page via:
>=20
> __handle_mm_fault() -> create_huge_pmd() ->
> do_huge_pmd_anonymous_page() etc.
>=20
> So everything should 'just work', and fallback if not permitted.
>=20
> So in general seems fine.
>=20
> > ---
> >  drivers/char/mem.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c index
> > 48839958b0b1..c57327ca9dd6 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -515,10 +515,12 @@ static int mmap_zero(struct file *file, struct
> > vm_area_struct *vma)  static unsigned long
> get_unmapped_area_zero(struct file *file,
> >  				unsigned long addr, unsigned long len,
> >  				unsigned long pgoff, unsigned long flags)
> {  #ifdef CONFIG_MMU
> > +	unsigned long ret;
> > +
> >  	if (flags & MAP_SHARED) {
> >  		/*
> >  		 * mmap_zero() will call shmem_zero_setup() to create a file,
> >  		 * so use shmem's get_unmapped_area in case it can be
> huge;
> >  		 * and pass NULL for file as in mmap.c's
> get_unmapped_area(), @@
> > -526,10 +528,13 @@ static unsigned long get_unmapped_area_zero(struct
> file *file,
> >  		 */
> >  		return shmem_get_unmapped_area(NULL, addr, len, pgoff,
> flags);
> >  	}
> >
> >  	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath
> it */
>=20
> Let's add a comment here like:
>=20
> 	/*
> 	 * Attempt to map aligned to huge page size if possible, otherwise
> we
>          * fall back to system page size mappings. If THP is not enabled,=
 this
>          * returns NULL and we always fallback.
> 	 */
>=20
> I think it'd be sensible to have an #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> here, because thp_get_unmapped_area() does the fallback for you, and
> then otherwise we'd be trying it twice which is weird.
>=20
> E.g.:
>=20
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> 	return thp_get_unmapped_area(file, addr, len, pgoff, flags); #else
> 	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff,
> flags); #endif
>=20

Trying it twice is realy unnecessary. This looks clearer and better, I will=
 refer
to your suggestion in patch V2. Thanks a lot for your and helpful advice.

> > +	ret =3D thp_get_unmapped_area(file, addr, len, pgoff, flags);
> > +	if (ret)
> > +		return ret;
> >  	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff,
> > flags);  #else
> >  	return -ENOSYS;
> >  #endif
> >  }
> > --
> > 2.43.0
> >
>=20
> In _theory_ we should do the thing in mmap() where we check the size is
> PMD-aligned (see __get_unmapped_area()), but I don't think anybody's
> mapping a bunch of /dev/zero mappings next to each other or using them in
> any way where that'd matter... So yeah let's not :)

I agree with your thought. Do not make check here.

Thanks.
Zhang



