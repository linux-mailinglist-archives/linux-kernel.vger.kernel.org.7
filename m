Return-Path: <linux-kernel+bounces-730732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DCB048CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFFC3B6CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF651238C0C;
	Mon, 14 Jul 2025 20:45:17 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B578F26
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525917; cv=none; b=ewVZb3QgUv+1Wsuvpm+Zhob/yL+aTPnRyMdrXORrkyoRbL3NSBQQnI6YkezobQSId96PQKUcNOK69HWAJCqQZgUEjzHIO3dFzPzED1cg47vOURCrMs+YEiQcEek3csylS2X8aIMRqDN9893FgFTGiolrhTV73D14QV5Of59pRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525917; c=relaxed/simple;
	bh=hwkys9nIf+3n1E41XWQVmpecsfpK7X+vZMBgLSNWhBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jj6+WvjTderKRSVqRG8mJxsTf4+7vKWeYsHliF9he/rv9Gy4811rNnODS3bDl2iicoBAp9cl6Gwgorgcb6Te85D4fVVLsfsZN9XXOEiZ8001AkflhUoWALkGKMKrnvVx+opg0ZsQt/PRsF0Ovt7CZ07yps0edm/1GfUX/Pzg4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [172.20.10.11] (unknown [37.168.28.62])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 29D3C415E9;
	Mon, 14 Jul 2025 20:35:03 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 37.168.28.62) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[172.20.10.11]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <ce2b8d4b-7396-43fe-b948-5ab59294832f@arnaud-lcm.com>
Date: Mon, 14 Jul 2025 21:35:01 +0100
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
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <e7b79c66-22b4-4d01-be5f-adfc5ba7e50b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175252530422.29268.1871237425922975958@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Thanks Dave !

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

