Return-Path: <linux-kernel+bounces-889676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478DC3E37E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 03:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6731886AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 02:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE7D2F25E0;
	Fri,  7 Nov 2025 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oTND7xti"
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4E2ECE97
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481530; cv=none; b=XvwET415Iab1pSNtiYOm0wnv/E/sDZ40X5yE+xi7G0fjDKQps7HN97Io+GI54ZBvR145iIA4x3d8PL22Yw0ESIJMve051BWWnKa+tp38TYdr5XCKr6Q83TZAgoEFlMjwkIjyWZioVZKXx+2dvNiiSuMvg7S8xvZoIvyvrW0dDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481530; c=relaxed/simple;
	bh=0Kd3k8MrGVEdb2T54AztInB1tCRKQ2x1zCDizw7cUjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNHBeGIDKHAajuA5aMQPKdg4DvR5xXViheFUPLMDDcYwzjYTcGUNp88+b8C35g3iAe5oRhjsvnjZg++wMLVg+IqUjMVdSBNIMZk5ZHs5HNaqiids66X+GPyLbVHYo7BKz4EVKBX3xYHOx9UVv/YIq3YWFJkxzNNRgxZF6TVzTOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oTND7xti; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ttYbeCKJ3OLF2JIak+cm/+0cAJg3a7naHdhTZ5oTJCM=;
	b=oTND7xti/NC2W3lp57ZxBg2RHkOYc/x3+yPpDVhMGAvw36UguiT3bsave9p82GjGlyyJlPVeJ
	riF/XR32j7XsPV8Z5V3xtQ+vm+V4FQD0LAWcXx1na6m0zI3r0qH38BwDsXDVzMiYcML6iuRsn1G
	5/ha/SAcUUlu419yWmwHzwM=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d2jFb4zgPz1cyV7;
	Fri,  7 Nov 2025 10:10:27 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D3F3140159;
	Fri,  7 Nov 2025 10:12:04 +0800 (CST)
Received: from kwepemq100008.china.huawei.com (7.202.195.91) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 10:12:04 +0800
Received: from DESKTOP-DKE2JV6.huawei.com (10.67.110.146) by
 kwepemq100008.china.huawei.com (7.202.195.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Nov 2025 10:12:03 +0800
From: Liyuan Pang <pangliyuan1@huawei.com>
To: <markus.elfring@web.de>
CC: <alexandre.torgue@foss.st.com>, <chengzhihao1@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<mcoquelin.stm32@gmail.com>, <miquel.raynal@bootlin.com>,
	<pangliyuan1@huawei.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<wanqian10@huawei.com>, <young.liuyang@huawei.com>
Subject: Re: [PATCH] ubi: fastmap: fix ubi->fm memory leak
Date: Fri, 7 Nov 2025 10:11:37 +0800
Message-ID: <20251107021137.874150-1-pangliyuan1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dff05531-f5e3-400a-abf0-a5307c50357e@web.de>
References: <dff05531-f5e3-400a-abf0-a5307c50357e@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq100008.china.huawei.com (7.202.195.91)

On Thu, 6 Nov 2025 16:16:05 +0100, Markus Elfring wrote:
>…
>> +++ b/drivers/mtd/ubi/fastmap.c
>> @@ -1644,3 +1644,15 @@ int ubi_update_fastmap(struct ubi_device *ubi)
>…
>> +void ubi_free_fastmap(struct ubi_device *ubi)
>> +{
>> +	int i;
>> +
>> +	if (ubi->fm) {
> +		for (i = 0; i < ubi->fm->used_blocks; i++)
> +			kmem_cache_free(ubi_wl_entry_slab, ubi->fm->e[i]);
>…
> +	}
> +}
>…
>
> May the local variable “i” be defined in the loop header?

I think it's better to leave it as it is, most of the code in
ubi defines variables outside the loop header, and defining
"i" in the loop header may cause compilation error in some old
kernel versions that use C89.

Regards,
Liyuan

