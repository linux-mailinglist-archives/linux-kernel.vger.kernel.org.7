Return-Path: <linux-kernel+bounces-762477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B52EB20740
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD24427A31
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD272BEC57;
	Mon, 11 Aug 2025 11:15:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA722BE7AD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910941; cv=none; b=Bel18Ce6rJvXZVX/CzhoQrPV1UINBNh3lAFPOMpKFJ/aSNE/IUJaX1Ji0K4qKtnUbfqmUGObtbr4UyAdjy026+XvXt0n/zLCkzdzcaeg4072Lnd+ADknxTGYoayB2MuxHACCDCh/o6iobeQ8/tpKnzF+am2NUI5IieX+9uo5FBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910941; c=relaxed/simple;
	bh=d8PN3eGQqXeJW5ezvzcct/ODNQy7RgIfETcyQy+sB5s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RzFsCSQIl+VKh5nmxynIFy3Pl9ukhqbcZ9OKORj1yBWf2UgB+90sAPtuLV1lWSODHU4a6TC8sQjzMS+bc8DbVZsOgSJf+AH5hlXRAep8Fk6DARlsO+ZqSvqtdatOB51bOIfgUI0eAYYq044KPj7brWqzqfug54Ddc1abQo+iEjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c0sRB37fQz13Mbt;
	Mon, 11 Aug 2025 19:12:06 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 21EAB1402C7;
	Mon, 11 Aug 2025 19:15:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 19:15:27 +0800
Subject: Re: [PATCH] ubifs: Remove unnecessary variable assignments
To: Xichao Zhao <zhao.xichao@vivo.com>, <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250811100949.431764-1-zhao.xichao@vivo.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <b93c0677-f26b-b8da-bd70-7cec43bd8d00@huawei.com>
Date: Mon, 11 Aug 2025 19:15:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250811100949.431764-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2025/8/11 18:09, Xichao Zhao Ð´µÀ:
> When an error occurs, ubifs_err is used to directly print the error,
> and different errors have different formats for printing. Therefore,
> it's not necessary to use 'err' to locate the error occurrence.
> Thus, remove the relevant assignments to 'err'.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>   fs/ubifs/tnc_misc.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
> index d3f8a6aa1f49..10b222dc6a53 100644
> --- a/fs/ubifs/tnc_misc.c
> +++ b/fs/ubifs/tnc_misc.c
> @@ -321,7 +321,6 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   			  c->fanout, znode->child_cnt);
>   		ubifs_err(c, "max levels %d, znode level %d",
>   			  UBIFS_MAX_LEVELS, znode->level);
> -		err = 1;
>   		goto out_dump;
>   	}
>   
> @@ -342,7 +341,6 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   		    zbr->lnum >= c->leb_cnt || zbr->offs < 0 ||
>   		    zbr->offs + zbr->len > c->leb_size || zbr->offs & 7) {
>   			ubifs_err(c, "bad branch %d", i);
> -			err = 2;
>   			goto out_dump;
>   		}
>   
> @@ -355,7 +353,6 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   		default:
>   			ubifs_err(c, "bad key type at slot %d: %d",
>   				  i, key_type(c, &zbr->key));
> -			err = 3;
>   			goto out_dump;
>   		}
>   
> @@ -368,7 +365,6 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   				ubifs_err(c, "bad target node (type %d) length (%d)",
>   					  type, zbr->len);
>   				ubifs_err(c, "have to be %d", c->ranges[type].len);
> -				err = 4;
>   				goto out_dump;
>   			}
>   		} else if (zbr->len < c->ranges[type].min_len ||
> @@ -378,7 +374,6 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   			ubifs_err(c, "have to be in range of %d-%d",
>   				  c->ranges[type].min_len,
>   				  c->ranges[type].max_len);
> -			err = 5;
>   			goto out_dump;
>   		}
>   	}
> @@ -396,13 +391,11 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   		cmp = keys_cmp(c, key1, key2);
>   		if (cmp > 0) {
>   			ubifs_err(c, "bad key order (keys %d and %d)", i, i + 1);
> -			err = 6;
>   			goto out_dump;
>   		} else if (cmp == 0 && !is_hash_key(c, key1)) {
>   			/* These can only be keys with colliding hash */
>   			ubifs_err(c, "keys %d and %d are not hashed but equivalent",
>   				  i, i + 1);
> -			err = 7;
>   			goto out_dump;
>   		}
>   	}
> @@ -411,7 +404,7 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   	return 0;
>   
>   out_dump:
> -	ubifs_err(c, "bad indexing node at LEB %d:%d, error %d", lnum, offs, err);
> +	ubifs_err(c, "bad indexing node at LEB %d:%d", lnum, offs);
>   	ubifs_dump_node(c, idx, c->max_idx_node_sz);
>   	kfree(idx);
>   	return -EINVAL;
> 


