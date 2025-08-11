Return-Path: <linux-kernel+bounces-762535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D5B20820
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 963894E310A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD41F2D29C8;
	Mon, 11 Aug 2025 11:46:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18E2BF017
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912810; cv=none; b=uT75ha6BF7Jssu3ISridvE3+LE9YShX2DeT5O0+5y8cbzBqjZjQOjZaUhoitEJ3WOcIfZV1ZWtsYqN34TNhV7Ob0xuh5LflPYoiznI9mR1rsUjarvw5RZLYlg6wt0X2jF0mjue2xc9yG7kJ3/l3ujrCpPWlHT+K9B3Ftx2T2IGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912810; c=relaxed/simple;
	bh=GOIeHwDBaAlwbrutr3PO+Prmk0wFxAN2n1PBTfsTmko=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BTt4ztR0xYGrR7UWyO2IaojDuOiNWoJ+o/m5aklpuPvocnagC735uWZ+ynmpxwLg4bfu+9rTafXgOwjdMYbL0JyCIY1bn4Z4DE+GKzTvIgrl7pEeLDXQazLhLe4c3vuqA5FQkIN0716JqNpTkHlMeOKawgzYmc8l88cW15d5zGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c0sgS4cPXzdc8H;
	Mon, 11 Aug 2025 19:22:44 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B71E18007F;
	Mon, 11 Aug 2025 19:27:03 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 19:27:02 +0800
Subject: Re: [PATCH] ubifs: Simplify the code and remove unnecessary
 parameters.
To: Xichao Zhao <zhao.xichao@vivo.com>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250811101529.436635-1-zhao.xichao@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <36b86ba2-504a-11b0-ec1b-3b39bd978251@huawei.com>
Date: Mon, 11 Aug 2025 19:27:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250811101529.436635-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/8/11 18:15, Xichao Zhao Ð´µÀ:
> Remove the parameter '*c' from the ubifs_crc_node function,
> and replace part of the code using ubifs_crc_node.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   fs/ubifs/io.c    | 13 ++++---------
>   fs/ubifs/ubifs.h |  2 +-
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 

Hi, I think the code of crc calculation in fix_size_in_place() can be 
replaced too. If not, we could make ubifs_crc_node() be static.

> diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
> index a79f229df475..6c6d68242779 100644
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
> @@ -395,7 +392,7 @@ void ubifs_init_node(struct ubifs_info *c, void *node, int len, int pad)
>   	}
>   }
>   
> -void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
> +void ubifs_crc_node(void *node, int len)
>   {
>   	struct ubifs_ch *ch = node;
>   	uint32_t crc;
> @@ -432,7 +429,7 @@ int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
>   			return err;
>   	}
>   
> -	ubifs_crc_node(c, node, len);
> +	ubifs_crc_node(node, len);
>   
>   	return 0;
>   }
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
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index 5db45c9e26ee..5d172509091a 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -1743,7 +1743,7 @@ int ubifs_write_node_hmac(struct ubifs_info *c, void *buf, int len, int lnum,
>   int ubifs_check_node(const struct ubifs_info *c, const void *buf, int len,
>   		     int lnum, int offs, int quiet, int must_chk_crc);
>   void ubifs_init_node(struct ubifs_info *c, void *buf, int len, int pad);
> -void ubifs_crc_node(struct ubifs_info *c, void *buf, int len);
> +void ubifs_crc_node(void *buf, int len);
>   void ubifs_prepare_node(struct ubifs_info *c, void *buf, int len, int pad);
>   int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
>   			    int hmac_offs, int pad);
> 


