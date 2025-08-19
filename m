Return-Path: <linux-kernel+bounces-774666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92363B2B5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD5B3B47BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A651922FD;
	Tue, 19 Aug 2025 01:16:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2565433F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566201; cv=none; b=u/2hYNrziInch1vk6ieqvEJKJaaKwucRiZOpJhODXdGCcL+AbPpQOGz7Vz2hW87m7e5um27q3/eDDBSK1Td2diwTpvpbjeQkRjfkwbOPab0WnbFkYc5AisjJk3TZ/fUDqrPmVTSQP75BGWr4f+eGzV6sQe8r1MZj4+QdPmj5V/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566201; c=relaxed/simple;
	bh=h5eqmYA6QCM9xdKdGQ84KdodBCw8NsQSwIjQ6oEkGGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CS+UBNtN5iD6t3ZITasTBJF5tjilKTaTSv0QEl59yIjgKx0wL9P4rpmCUN+dojSe3abe+CO1YeeM1ukoKxVEPE+8FDzs6zFkJ21HWutiC76ZAfzfK+eF2CUW4pCsdNKEotJ5kOkW+2TpEFiH6twzT+ya8bgviOwxiGPDMlAiJ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c5WrJ0zZ7z14MG0;
	Tue, 19 Aug 2025 09:16:32 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 51971140275;
	Tue, 19 Aug 2025 09:16:35 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 Aug 2025 09:16:34 +0800
Message-ID: <5c282df8-c1bc-4433-9cfb-f5c8e8c955c1@huawei.com>
Date: Tue, 19 Aug 2025 09:16:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: fix to allow removing qf_name
Content-Language: en-US
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20250818020939.3529802-1-chao@kernel.org>
 <20250818020939.3529802-2-chao@kernel.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250818020939.3529802-2-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/8/18 10:09, Chao Yu wrote:
> The mount behavior changed after commit d18535132523 ("f2fs: separate the
> options parsing and options checking"), let's fix it.
> 
> [Scripts]
> mkfs.f2fs -f /dev/vdb
> mount -t f2fs -o usrquota /dev/vdb /mnt/f2fs
> quotacheck -uc /mnt/f2fs
> umount /mnt/f2fs
> mount -t f2fs -o usrjquota=aquota.user,jqfmt=vfsold /dev/vdb /mnt/f2fs
> mount|grep f2fs
> mount -t f2fs -o remount,usrjquota=,jqfmt=vfsold /dev/vdb /mnt/f2fs
> mount|grep f2fs
> dmesg
> 
> [Before commit]
> mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
> mount#2: ...,quota,jqfmt=vfsold,...
> kmsg: no output
> 
> [After commit]
> mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
> mount#2: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
> kmsg: "user quota file already specified"
> 
> [After patch]
> mount#1: ...,quota,jqfmt=vfsold,usrjquota=aquota.user,...
> mount#2: ...,quota,jqfmt=vfsold,...
> kmsg: "remove qf_name aquota.user"
> 
> Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
> Cc: Hongbo Li <lihongbo22@huawei.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

>   fs/f2fs/super.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 465604fdc5dd..07f6c8cac07a 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1219,8 +1219,11 @@ static int f2fs_check_quota_consistency(struct fs_context *fc,
>   				goto err_jquota_change;
>   
>   			if (old_qname) {
> -				if (new_qname &&
> -					strcmp(old_qname, new_qname) == 0) {
> +				if (!new_qname) {
> +					f2fs_info(sbi, "remove qf_name %s",
> +								old_qname);
> +					continue;
> +				} else if (strcmp(old_qname, new_qname) == 0) {
>   					ctx->qname_mask &= ~(1 << i);
>   					continue;
>   				}

