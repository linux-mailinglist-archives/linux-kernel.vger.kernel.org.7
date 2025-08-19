Return-Path: <linux-kernel+bounces-774667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E269AB2B5CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF9B52687F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143031922FD;
	Tue, 19 Aug 2025 01:17:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AF154425
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566229; cv=none; b=OOfYprwqHR6tXpb0htk02TvK7VUkwvUwFHr63AGVHG/jl4eoxsR4VQuPgTqHC9WxTFzCS1m60l8glQGg8LpR61qBT/YQMiOBnepJA3kM/lY7fjPJe8zyn7yxSpkMYxKLgjYugVIkZQu7t6SLCy5L393VYqdDdoGsENAsc47DcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566229; c=relaxed/simple;
	bh=jn8R404uzuZB3JKWoRV1cmOoXRvbVqAaf4NRbctYFdI=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CMiCgps76dxje7kGZ1+uhdqyN/vQW9judZzJx+TQ9qm++hC4H7d6gsB7CKZxlanmkXqO6gDerQGN/rIj8aQ7ho2uhnQEbjMjo0elAvcDGtNzqsXii5EGV4c29cszY3uxr1d/8UKMUWfkFTydZCPObpkbhFpv7/9QxUAXAWZFtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c5Wlc4hBVzPqRD;
	Tue, 19 Aug 2025 09:12:28 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 7428B1402C4;
	Tue, 19 Aug 2025 09:17:04 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 09:17:03 +0800
Subject: Re: [PATCH] ubifs: vmalloc(array_size()) -> vmalloc_array()
To: Qianfeng Rong <rongqianfeng@vivo.com>, Richard Weinberger
	<richard@nod.at>, <linux-mtd@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250817081238.44785-1-rongqianfeng@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c46d7739-592e-b8c4-7a7e-6b39015156d7@huawei.com>
Date: Tue, 19 Aug 2025 09:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250817081238.44785-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/8/17 16:12, Qianfeng Rong Ð´µÀ:
> Remove array_size() calls and replace vmalloc() with vmalloc_array() in
> ubifs_create_dflt_lpt()/lpt_init_rd()/lpt_init_wr(). vmalloc_array() is
> optimized better, resulting in less instructions being used [1].
> 
> [1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   fs/ubifs/lpt.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/lpt.c b/fs/ubifs/lpt.c
> index 441d0beca4cf..dde0aa3287f4 100644
> --- a/fs/ubifs/lpt.c
> +++ b/fs/ubifs/lpt.c
> @@ -628,8 +628,8 @@ int ubifs_create_dflt_lpt(struct ubifs_info *c, int *main_lebs, int lpt_first,
>   	pnode = kzalloc(sizeof(struct ubifs_pnode), GFP_KERNEL);
>   	nnode = kzalloc(sizeof(struct ubifs_nnode), GFP_KERNEL);
>   	buf = vmalloc(c->leb_size);
> -	ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
> -				  c->lpt_lebs));
> +	ltab = vmalloc_array(c->lpt_lebs,
> +			     sizeof(struct ubifs_lpt_lprops));
>   	if (!pnode || !nnode || !buf || !ltab || !lsave) {
>   		err = -ENOMEM;
>   		goto out;
> @@ -1777,8 +1777,8 @@ static int lpt_init_rd(struct ubifs_info *c)
>   {
>   	int err, i;
>   
> -	c->ltab = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
> -				     c->lpt_lebs));
> +	c->ltab = vmalloc_array(c->lpt_lebs,
> +				sizeof(struct ubifs_lpt_lprops));
>   	if (!c->ltab)
>   		return -ENOMEM;
>   
> @@ -1846,8 +1846,8 @@ static int lpt_init_wr(struct ubifs_info *c)
>   {
>   	int err, i;
>   
> -	c->ltab_cmt = vmalloc(array_size(sizeof(struct ubifs_lpt_lprops),
> -					 c->lpt_lebs));
> +	c->ltab_cmt = vmalloc_array(c->lpt_lebs,
> +				    sizeof(struct ubifs_lpt_lprops));
>   	if (!c->ltab_cmt)
>   		return -ENOMEM;
>   
> 


