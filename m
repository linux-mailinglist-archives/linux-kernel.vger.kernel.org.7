Return-Path: <linux-kernel+bounces-738718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF4EB0BC49
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD505179DED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E31F21D3F8;
	Mon, 21 Jul 2025 06:05:14 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264EE56A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753077913; cv=none; b=bV5aunzYpT1a2sTu4PLea9QC7Pc7A+Gb4BJpEK6b+jeM0s0u0MOtwSd9In1oOIjK1UAlcu6CVvGHLeu35axslSWwJ1Zi9Ag0NgfuTLKvybUiGgDGWngZ+M+ArF2aA1zr/IUCXCBo4OLasKNFGhVfV71C/JQd3QYaTZ62brZc3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753077913; c=relaxed/simple;
	bh=d1op7TC7QokF1G9nHrDrwL3lteFaG5LEUl3s4TBH8PA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aD4w1Iav1oXU+wI/OzFgc64jKGTqdTpXU+mDCZrhjtxVH3FPCJhZwnMKjst2BLKXjswsvjTIMqK2LTDVbXFRM+/qoK0//uX4adXun4ze+BIO9Lh/L2AiNmczZ5SsrpXvp4Q0VD/6FPljlc3huojr/6snAq8tqX3qmOtJGZC59uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4blqcj5tH6zKHMYF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:05:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CD501A113D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:05:08 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxSS2H1o8C_oAw--.24409S3;
	Mon, 21 Jul 2025 14:05:08 +0800 (CST)
Subject: Re: [PATCH] dm-raid: do not include dm-core.h
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: Xiao Ni <xni@redhat.com>, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <20250721034929.374552-1-ptikhomirov@virtuozzo.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <afc231d5-6c49-3edf-fde4-3eff376c02bd@huaweicloud.com>
Date: Mon, 21 Jul 2025 14:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250721034929.374552-1-ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxSS2H1o8C_oAw--.24409S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4kKF18GFWfJF4UJFW3GFg_yoW8GFW7pa
	1DC3yYkr4rJrWqqF1DXan29a4YganxGryFgryxu340v3sxGr1q9r4kGa9IqF48JFZFqFy7
	WF47AFn09F4FqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

�� 2025/07/21 11:49, Pavel Tikhomirov д��:
> In commit 4cc96131afce ("dm: move request-based code out to dm-rq.[hc]")
> we have a note: "DM targets should _never_ include dm-core.h!". And it
> is not used in any DM targets except dm-raid now, so let's remove it
> from dm-raid for consistency, also use special helpers instead of
> accessing dm_table and mapper_device fields directly. This change is
> merely a cleanup and should not affect functionality.
> 
> Fixes: 7168be3c8a6b ("md: record dm-raid gendisk in mddev")
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>   drivers/md/dm-raid.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks

> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index e8c0a8c6fb51..4fb5ddf50560 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -14,7 +14,6 @@
>   #include "raid5.h"
>   #include "raid10.h"
>   #include "md-bitmap.h"
> -#include "dm-core.h"
>   
>   #include <linux/device-mapper.h>
>   
> @@ -3305,7 +3304,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>   
>   	/* Disable/enable discard support on raid set. */
>   	configure_discard_support(rs);
> -	rs->md.dm_gendisk = ti->table->md->disk;
> +	rs->md.dm_gendisk = dm_disk(dm_table_get_md(ti->table));
>   
>   	mddev_unlock(&rs->md);
>   	return 0;
> 


