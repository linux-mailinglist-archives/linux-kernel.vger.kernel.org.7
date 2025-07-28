Return-Path: <linux-kernel+bounces-748489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA24B141C4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5942E17F87E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310B272807;
	Mon, 28 Jul 2025 18:14:15 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE16224FA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726455; cv=none; b=lGTwbcgnzFHDbtbFX+DyWILZrxjB9pBrRyElkhv3XNDBiyWqElJkymzHz503ByZ6YySkG7HrJzQdiDpwYc12O8xLjvC8WU+l2hUSEiYl+4MDqkJzH7pcFs4STOFYQL7CcsJfCrXBglNQ2O/wKvGQofrnuQMY110LXgMMPr7TwFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726455; c=relaxed/simple;
	bh=uJvZ0PF9JyZngXohD938zBOjYZaN5FF959aU0fVJVUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LawE+736zPdlzbmXcIhp3b4i5LqHGME2Wq02NY3Ii0s1nylSk3JtQNIq6CsfOstnmj8W7ow2DBjiT7EEF3mxi6Ndb+Z6wCPeMhgEsxJT7HSRvg1uOGU5n4Wt83zbNLOJRi++ANiI8+RVgqx2Zym5YlT28jzTj6opFXtp27Kg+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [IPV6:2a02:8084:255b:aa00:b1cb:3dd6:fb96:876a] (unknown [IPv6:2a02:8084:255b:aa00:b1cb:3dd6:fb96:876a])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id C26FB404B5;
	Mon, 28 Jul 2025 18:14:04 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 2a02:8084:255b:aa00:b1cb:3dd6:fb96:876a) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[IPV6:2a02:8084:255b:aa00:b1cb:3dd6:fb96:876a]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <35094576-897f-4ab4-8835-e47940a1f0a3@arnaud-lcm.com>
Date: Mon, 28 Jul 2025 19:14:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: upper bound check of tree index in
 dbAllocAG
To: Dave Kleikamp <dave.kleikamp@oracle.com>,
 Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
 syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20250424-ubsan-jfs-v1-1-2eab57c1ac50@arnaud-lcm.com>
 <e7b79c66-22b4-4d01-be5f-adfc5ba7e50b@oracle.com>
Content-Language: en-US
From: Arnaud Lecomte <contact@arnaud-lcm.com>
In-Reply-To: <e7b79c66-22b4-4d01-be5f-adfc5ba7e50b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175372644531.17396.11877905302170947884@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Lovely, thanks !
Arnaud

On 11/07/2025 20:23, Dave Kleikamp wrote:
> I'm finally trying to catch up.
>
> On 4/23/25 5:13PM, Arnaud Lecomte via Jfs-discussion wrote:
>> When computing the tree index in dbAllocAG, we never check we are not
>> out of bounds from the size of the stree.
>> This could happen in a scenario where the filesystem metadata are
>> corrupted.
>
> Looks good. I'll apply and test this.
>
>>
>> Reported-by: syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=cffd18309153948f3c3e
>> Tested-by: syzbot+cffd18309153948f3c3e@syzkaller.appspotmail.com
>> Fixes: 263e55949d89 ("x86/cpu/amd: Fix workaround for erratum 1054")
>
> Removing the Fixes: line. This doesn't make sense.
>
>> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
>> ---
>>   fs/jfs/jfs_dmap.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
>> index 26e89d0c69b6..7acebb9a21b0 100644
>> --- a/fs/jfs/jfs_dmap.c
>> +++ b/fs/jfs/jfs_dmap.c
>> @@ -1385,6 +1385,12 @@ dbAllocAG(struct bmap * bmp, int agno, s64 
>> nblocks, int l2nb, s64 * results)
>>           (1 << (L2LPERCTL - (bmp->db_agheight << 1))) / 
>> bmp->db_agwidth;
>>       ti = bmp->db_agstart + bmp->db_agwidth * (agno & (agperlev - 1));
>>   +    if (ti < 0 || ti >= le32_to_cpu(dcp->nleafs)) {
>> +        jfs_error(bmp->db_ipbmap->i_sb, "Corrupt dmapctl page: ti 
>> out of bounds\n");
>> +        release_metapage(mp);
>> +        return -EIO;
>> +    }
>> +
>>       /* dmap control page trees fan-out by 4 and a single allocation
>>        * group may be described by 1 or 2 subtrees within the ag level
>>        * dmap control page, depending upon the ag size. examine the ag's
>>
>> ---
>> base-commit: 8560697b23dc2f405cb463af2b17256a9888129d
>> change-id: 20250423-ubsan-jfs-3a58acae5e57
>>
>> Best regards,
>
>

