Return-Path: <linux-kernel+bounces-773123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595D4B29BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0823BC3D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6CE2FD1A8;
	Mon, 18 Aug 2025 08:06:34 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1812264B3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755504393; cv=none; b=uD2g842wEHaN+hXJeZ4qosJSK/9mg4KgHIDeyq6sr1v07OPdtWeNvrtXIbgMgrfvsIhz+Az8+BZQd6waayXOpwY0kXkRlnDaEjWwvR5BNwXxa0lHl3k8WmmkyZOpVhuKsMl7n/1BjBz7WAueLXdXtzqSBMt/nvQe20ZX+q4V8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755504393; c=relaxed/simple;
	bh=3zjTbDG9oXCEoOhYiOs0k8H22OSc2p2w7agGjMx5pKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rsb3dvTFyyo00k3SdH2U6iJz6TGHyalDDc3O7g2TC0AynxY4Z/5a7aZj4EVoYdTBNpivHrs2Wak+67Epgpo5QXQe/sml1p9BVOv3PtVJ/is5FfIxXerAOgsrn4F6zMi9Run49JcaaJcEW5jJJHQTK6CNnZD9Ix0e6TnaSLZzMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c54tS1whKzFrjJ;
	Mon, 18 Aug 2025 16:01:52 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AEB4140158;
	Mon, 18 Aug 2025 16:06:28 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 16:06:27 +0800
Message-ID: <f503b139-ba90-40ae-8900-db0ba7789525@huawei.com>
Date: Mon, 18 Aug 2025 16:06:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] f2fs: fix to allow removing qf_name
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20250818020939.3529802-1-chao@kernel.org>
 <20250818020939.3529802-2-chao@kernel.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20250818020939.3529802-2-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Chao,

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

Thanks for catching this. Do we also need the patch 1/2 ? It seems this 
patch also solve the syzbot problems.

Thanks,
Hongbo

> +					f2fs_info(sbi, "remove qf_name %s",
> +								old_qname);
> +					continue;
> +				} else if (strcmp(old_qname, new_qname) == 0) {
>   					ctx->qname_mask &= ~(1 << i);
>   					continue;
>   				}

