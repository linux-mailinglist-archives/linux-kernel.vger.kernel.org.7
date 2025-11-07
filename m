Return-Path: <linux-kernel+bounces-890074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D51C3F329
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131E34ED498
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C165304BD5;
	Fri,  7 Nov 2025 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="v5tgvizv"
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A90D3019DC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508336; cv=none; b=Tk7X9A6sb/bFmZ9AoxYHXi+O9+33Eq+UjHXHOnodvPRtkVxzB6kTZguF5K106fh5HRWXqv3kfZ2Rl7+e/PF6dR8R2lWKTpBq8FFt8BxQlYP4HF2yXV/k55Yr205GsZqERIxb+HABCjHGO39YITMOnODi+wm1yTB4CtaQGwxhr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508336; c=relaxed/simple;
	bh=ZYDMZG9YlGoNakc8gs93AcqkTBL38dWAVsWRsNE6OEM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkCll+CvueFsKSGJqK7LcTjTPBaxuuUbYioiJLIdj3drVkcjpn0z+fg4+QIehLAzfocr8TUNuhMKCnTQaLWNuRQngzDsRGWI6TwUQUM8DRT8w7psQKRks5oAQ5mHu29bf3CsYcjwlKNRFEfLFhCpX6BLQ8tFrW8WY0KPvtGehnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=v5tgvizv; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6lG6deOb5NWhbiwLUm26+RJ/9qVvh6HCnpI4bUBb76I=;
	b=v5tgvizviGkzq6i9w85nQ0e/oouNS2MNUiLdxt1++3ztywUoe0t2IHd/856wrUOr6RNNybqzg
	+ij4oQejd07Q42moNksHixcS7PwAq4Y4FOp5cCJ6jpQsdJUs94BcKN9bhvTb9VhEbrVFDxCt0NH
	Mk9TP6lEIvUCkEIqIAdebLc=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d2v9632KgzRhRy;
	Fri,  7 Nov 2025 17:37:14 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 65501147B8F;
	Fri,  7 Nov 2025 17:38:50 +0800 (CST)
Received: from kwepemq100008.china.huawei.com (7.202.195.91) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 17:38:50 +0800
Received: from DESKTOP-DKE2JV6.huawei.com (10.67.110.146) by
 kwepemq100008.china.huawei.com (7.202.195.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 17:38:49 +0800
From: Liyuan Pang <pangliyuan1@huawei.com>
To: <markus.elfring@web.de>
CC: <alexandre.torgue@foss.st.com>, <chengzhihao1@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<mcoquelin.stm32@gmail.com>, <miquel.raynal@bootlin.com>,
	<pangliyuan1@huawei.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<wanqian10@huawei.com>, <young.liuyang@huawei.com>
Subject: Re: [PATCH] ubi: fastmap: fix ubi->fm memory leak
Date: Fri, 7 Nov 2025 17:38:43 +0800
Message-ID: <20251107093843.1077536-1-pangliyuan1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <396b2d11-29ca-4fae-97c3-7280c879cbfd@web.de>
References: <396b2d11-29ca-4fae-97c3-7280c879cbfd@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100008.china.huawei.com (7.202.195.91)

>>> …
>>>> +++ b/drivers/mtd/ubi/fastmap.c
>>>> @@ -1644,3 +1644,15 @@ int ubi_update_fastmap(struct ubi_device *ubi)
>>> …
>>>> +void ubi_free_fastmap(struct ubi_device *ubi)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	if (ubi->fm) {
>>> +		for (i = 0; i < ubi->fm->used_blocks; i++)
>>> +			kmem_cache_free(ubi_wl_entry_slab, ubi->fm->e[i]);
>>> …
>>> +	}
>>> +}
>>> …
>>>
>>> May the local variable “i” be defined in the loop header?
>> 
>> I think it's better to leave it as it is, most of the code in
>> ubi defines variables outside the loop header, and defining
>> "i" in the loop header may cause compilation error in some old
>> kernel versions that use C89.
>
>Would you support to reduce the scope for such a variable to
>the code block of the if branch?

Ok, I will send a v2 patch.

Regards,
Liyuan

