Return-Path: <linux-kernel+bounces-763900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E8FB21B60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4331A27A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996F52E4245;
	Tue, 12 Aug 2025 03:06:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE62E3B12
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967987; cv=none; b=gzMlsBtQZYgNFaBCICUy7MM/3YRAmaAhpLcVOUpTEnS41cKbZvD9i8nRFC7QzhkoFrobhCKWVpwzczqU5KvVIlm6/lsUQkMK7oCaKBYFirqTnPzN8yDK1gvwNzU58Nrs8QIkGL9XMrsVeIw1qkvT9BhYppovglfad1gJ+mBHQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967987; c=relaxed/simple;
	bh=qLOyNyMY65j/R6eR7kHYUpEygR04DnqalOtAIu+vX10=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EcHHLFZKaiYEd78Sgcu9YpMM2izw86fNqXCDxkXqiyCN4JbJ8fvM/Oh4M0ejM7luSbH9nz8Sga5qyLMFM032Is28RD/svx5ZlnzBN9WvES0IO9/mC1qHNNQmCrXotyBq/rxBvl1sNUmERyD+zDq4XgfaZbbPrnWVmAfITLa7/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1GY01m91z1R7pJ;
	Tue, 12 Aug 2025 11:03:32 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AF2A180044;
	Tue, 12 Aug 2025 11:06:21 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 11:06:21 +0800
Subject: Re: [PATCH v2 1/2] ubifs: Remove unnecessary parameters '*c'
To: Xichao Zhao <zhao.xichao@vivo.com>, Richard Weinberger <richard@nod.at>,
	"open list:UBI FILE SYSTEM (UBIFS)" <linux-mtd@lists.infradead.org>, open
 list <linux-kernel@vger.kernel.org>
References: <20250812021009.414756-1-zhao.xichao@vivo.com>
 <20250812021009.414756-2-zhao.xichao@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <be8c49cd-82e9-10ff-30d6-f5dfd461d731@huawei.com>
Date: Tue, 12 Aug 2025 11:06:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250812021009.414756-2-zhao.xichao@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/8/12 10:10, Xichao Zhao Ð´µÀ:
> Because the variable *c is not used within the function,
> remove it from the ubifs_crc_node function.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   fs/ubifs/io.c    | 4 ++--
>   fs/ubifs/ubifs.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
> index a79f229df475..e0dfe6827d65 100644
> --- a/fs/ubifs/io.c
> +++ b/fs/ubifs/io.c
> @@ -395,7 +395,7 @@ void ubifs_init_node(struct ubifs_info *c, void *node, int len, int pad)
>   	}
>   }
>   
> -void ubifs_crc_node(struct ubifs_info *c, void *node, int len)
> +void ubifs_crc_node(void *node, int len)
>   {
>   	struct ubifs_ch *ch = node;
>   	uint32_t crc;
> @@ -432,7 +432,7 @@ int ubifs_prepare_node_hmac(struct ubifs_info *c, void *node, int len,
>   			return err;
>   	}
>   
> -	ubifs_crc_node(c, node, len);
> +	ubifs_crc_node(node, len);
>   
>   	return 0;
>   }
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


