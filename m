Return-Path: <linux-kernel+bounces-763901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C072B21B5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A3D468207
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAE2D9EF3;
	Tue, 12 Aug 2025 03:06:42 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10362D8798
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754968001; cv=none; b=rd+O26vnkTK5wIQ7sfpG2247n5kjb83zFKBVHKqdghyIm4KNXzHtybleVXH6Ji81GZqr35Na4JUVt9MF7DAZqjzlA/JxwwNIAdGopKxX17ow0grINI9WOb95QO4rCb1hTVRAdQvZDaZJgPdJ7qEH/2Zy8H3db7mOlRqYFVRb0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754968001; c=relaxed/simple;
	bh=Xb3KezRYrThyFsi7QYnZVuP/A2HtLlHgVOIY9QB1e2U=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JuGiTnOI3ABbSP3v3F6T4apgEuglqifGvW1yQSo6zckxAFUMvNC0lemZ4TPVzXyx1YuuBte1X1BkzYfWEvlUx5KrepexUQr1gTUAM1Rm6MPO5HFKZk+JBK7iHCGK9vQE21Daj8gfzdCFRKSxt5XONus9i9vhSJVKG8nMZ7tdl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1GVl2bXsz14MRF;
	Tue, 12 Aug 2025 11:01:35 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E1C8180064;
	Tue, 12 Aug 2025 11:06:34 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 11:06:33 +0800
Subject: Re: [PATCH v2 2/2] ubifs: Simplify the code using ubifs_crc_node
To: Xichao Zhao <zhao.xichao@vivo.com>, Richard Weinberger <richard@nod.at>,
	"open list:UBI FILE SYSTEM (UBIFS)" <linux-mtd@lists.infradead.org>, open
 list <linux-kernel@vger.kernel.org>
References: <20250812021009.414756-1-zhao.xichao@vivo.com>
 <20250812021009.414756-3-zhao.xichao@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b0c99eb4-ff3d-cfa9-5f4d-92d138e688a7@huawei.com>
Date: Tue, 12 Aug 2025 11:06:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250812021009.414756-3-zhao.xichao@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/8/12 10:10, Xichao Zhao Ð´µÀ:
> Replace part of the code using ubifs_crc_node.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   fs/ubifs/io.c       | 9 ++-------
>   fs/ubifs/recovery.c | 4 +---
>   2 files changed, 3 insertions(+), 10 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
> index e0dfe6827d65..6c6d68242779 100644
> --- a/fs/ubifs/io.c
> +++ b/fs/ubifs/io.c
> @@ -327,8 +327,6 @@ int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
>    */
>   void ubifs_pad(const struct ubifs_info *c, void *buf, int pad)
>   {
> -	uint32_t crc;
> -
>   	ubifs_assert(c, pad >= 0);
>   
>   	if (pad >= UBIFS_PAD_NODE_SZ) {
> @@ -343,8 +341,7 @@ void ubifs_pad(const struct ubifs_info *c, void *buf, int pad)
>   		ch->len = cpu_to_le32(UBIFS_PAD_NODE_SZ);
>   		pad -= UBIFS_PAD_NODE_SZ;
>   		pad_node->pad_len = cpu_to_le32(pad);
> -		crc = crc32(UBIFS_CRC32_INIT, buf + 8, UBIFS_PAD_NODE_SZ - 8);
> -		ch->crc = cpu_to_le32(crc);
> +		ubifs_crc_node(buf, UBIFS_PAD_NODE_SZ);
>   		memset(buf + UBIFS_PAD_NODE_SZ, 0, pad);
>   	} else if (pad > 0)
>   		/* Too little space, padding node won't fit */
> @@ -469,7 +466,6 @@ void ubifs_prepare_node(struct ubifs_info *c, void *node, int len, int pad)
>    */
>   void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
>   {
> -	uint32_t crc;
>   	struct ubifs_ch *ch = node;
>   	unsigned long long sqnum = next_sqnum(c);
>   
> @@ -483,8 +479,7 @@ void ubifs_prep_grp_node(struct ubifs_info *c, void *node, int len, int last)
>   		ch->group_type = UBIFS_IN_NODE_GROUP;
>   	ch->sqnum = cpu_to_le64(sqnum);
>   	ch->padding[0] = ch->padding[1] = 0;
> -	crc = crc32(UBIFS_CRC32_INIT, node + 8, len - 8);
> -	ch->crc = cpu_to_le32(crc);
> +	ubifs_crc_node(node, len);
>   }
>   
>   /**
> diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
> index f0d51dd21c9e..b36dc9b032f4 100644
> --- a/fs/ubifs/recovery.c
> +++ b/fs/ubifs/recovery.c
> @@ -1406,7 +1406,6 @@ static int fix_size_in_place(struct ubifs_info *c, struct size_entry *e)
>   	union ubifs_key key;
>   	int err, lnum, offs, len;
>   	loff_t i_size;
> -	uint32_t crc;
>   
>   	/* Locate the inode node LEB number and offset */
>   	ino_key_init(c, &key, e->inum);
> @@ -1428,8 +1427,7 @@ static int fix_size_in_place(struct ubifs_info *c, struct size_entry *e)
>   	ino = c->sbuf + offs;
>   	ino->size = cpu_to_le64(e->d_size);
>   	len = le32_to_cpu(ino->ch.len);
> -	crc = crc32(UBIFS_CRC32_INIT, (void *)ino + 8, len - 8);
> -	ino->ch.crc = cpu_to_le32(crc);
> +	ubifs_crc_node((void *)ino, len);
>   	/* Work out where data in the LEB ends and free space begins */
>   	p = c->sbuf;
>   	len = c->leb_size - 1;
> 


