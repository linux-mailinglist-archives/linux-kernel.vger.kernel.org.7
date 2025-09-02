Return-Path: <linux-kernel+bounces-796261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BB6B3FDFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332F87AE8B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743C2F7473;
	Tue,  2 Sep 2025 11:41:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE02F7459
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813273; cv=none; b=KcApWrfxa567tR5TjJOAWZduTdJJEb7jvGcmIMgUx/ZogM1jrx573wgbSe7XRCVdVrWgIU4mgjZPcIk+XJMdaVhbfVXJGZtXpAx63MDBEiAIOstjNK7l71qyTuI+jvHkklH7PnTzza6wv5tuqZXFNKZUB+U2qLSJ2vE93hViiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813273; c=relaxed/simple;
	bh=FCVI3Lj01xloXkNPeoWwTjbRkdy9DkilEARuu6rTEYE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NRwhPoTDv79UmCwtQ2N7aNHfIZ/zfMsAxlCzC+/AiWxaZvvpTufM7B3thmer6RG+rxOwfuNDLwCKcssmKMdK6Kmvj0qIi0TdQNL/cAghsNCK6Fih2DMA8kiEKHpdpvYsSgrHh7vFAWsF+RoPsMxgjkacGisvUyS/naHMlTWnJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cGP2K5XLHz14MVs;
	Tue,  2 Sep 2025 19:40:57 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C6B4180490;
	Tue,  2 Sep 2025 19:41:07 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Sep 2025 19:41:06 +0800
Subject: Re: [PATCH V2] mtd: core: skip badblocks increment for blocks already
 known bad
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20250902092732.2244544-1-wangzhaolong@huaweicloud.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <95bf5e07-7f03-efb0-da9b-cb50999c2524@huawei.com>
Date: Tue, 2 Sep 2025 19:41:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250902092732.2244544-1-wangzhaolong@huaweicloud.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/9/2 17:27, Wang Zhaolong Ð´µÀ:
> Repeatedly marking the same eraseblock bad inflates
> mtd->ecc_stats.badblocks because mtd_block_markbad() unconditionally
> increments the counter on success, while some implementations (e.g.
> NAND) return 0 both when the block was already bad and when it has just
> been marked[1].
> 
> Fix by checking if the block is already bad before calling
> ->_block_markbad() when _block_isbad is available. Only skip the counter
> increment when we can confirm the block was already bad. In all other
> cases continue incrementing the counter.
> 
> This keeps the logic centralized in mtdcore without requiring driver
> changes.
> 
> Link: https://lore.kernel.org/all/ef573188-9815-4a6b-bad1-3d8ff7c9b16f@huaweicloud.com/ [1]
> Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
> ---
> 
> V2:
> - Checks old state when _block_isbad exists and bails out early if already bad
> 
>   drivers/mtd/mtdcore.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 5ba9a741f5ac..096a3c94670f 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -2337,10 +2337,11 @@ int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
>   EXPORT_SYMBOL_GPL(mtd_block_isbad);
>   
>   int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	loff_t moffs;
>   	int ret;
>   
>   	if (!master->_block_markbad)
>   		return -EOPNOTSUPP;
>   	if (ofs < 0 || ofs >= mtd->size)
> @@ -2349,11 +2350,19 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
>   		return -EROFS;
>   
>   	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>   		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>   
> -	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
> +	moffs = mtd_get_master_ofs(mtd, ofs);
> +
> +	if (master->_block_isbad) {
> +		ret = master->_block_isbad(master, moffs);
> +		if (ret > 0)
> +			return 0;

Hi, Miqu¨¨l.
Here, should we keep the same logic with the lower level(eg. 
nand_block_markbad, onenand_block_markbad) when 'ret < 0' is returned by 
master->_block_isbad. Many specific nand drivers(markbad) return the 
negative code when 'isbad' fails.

> +	}
> +
> +	ret = master->_block_markbad(master, moffs);
>   	if (ret)
>   		return ret;
>   
>   	while (mtd->parent) {
>   		mtd->ecc_stats.badblocks++;
> 


