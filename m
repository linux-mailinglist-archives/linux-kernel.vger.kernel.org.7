Return-Path: <linux-kernel+bounces-745202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5772B11687
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 04:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C847BD761
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF151234973;
	Fri, 25 Jul 2025 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeKLKl2W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A7F233149
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411005; cv=none; b=kjSXNkD5dUArSXwBnPMYglNRLgMd4UmjVTogPHkIKyG/ovZvbF2LawofctWtDzpV/LCpzzao/b6mA3dyD7bk6fGy17UDdHJ2DusHc+xSCXDNzGDA620+nst/XbNa6xKjE5kAud724vLOEI+OV1QKxwHsmOfJpRZaZFSj6uyPcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411005; c=relaxed/simple;
	bh=PcieKZXvp0nbEeGoMVMnk++vnyS3t/GKGyNSGEnagdM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sprnFG7S2Uw57B2cK3/74tilKxEf45RbNW0YPS6M5nPi4ee0pNfSOds2N1hdFKC9hDXd/XhZFIt9hVs683f0lCf1iYsvidE0FhS+XMx2gB4pNFEgIgRqr/RnqsBNClVRNO4W3wyPc74UfjKXPuUocjzkz8Y8Ciiy0hdP5ONj110=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeKLKl2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537F4C4CEED;
	Fri, 25 Jul 2025 02:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753411004;
	bh=PcieKZXvp0nbEeGoMVMnk++vnyS3t/GKGyNSGEnagdM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SeKLKl2Wfs2l0nfo6k6zaTY7lKysosEGqk3OIqfg7ANP/+Uyf0LtGLLg6LkwiijnW
	 832E/xSEJWeESoJUGNa5FRyDHV/WG2JyFM8+6HQBGQ+KWRbKOZHbgt4/9rvYUEJ+Sp
	 /pNoQ5jNXO/irCf5nbjaPOejIkfTV8kfPNpj2Egacnk3DYp/QCl/5KLLXwtWAoa/sX
	 57Gq7RvrCUBhrbHxXL1nTrTMqwKElJtXxIgyeZRcBVdsYOB8VpyJXGKMf8UR9J2OQ3
	 Bu70v7v9FWsUdXFYJ6PhAMl8yBHSZ/m/F4VqyXzyXBr4wia3XcWP7yHKMWSWHk4S0r
	 AeesX06/agiiA==
Message-ID: <8a2f450e-2e10-42d2-a5a8-fa3fdc3aee27@kernel.org>
Date: Fri, 25 Jul 2025 10:36:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, feng.han@honor.com, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: directly add newly allocated
 pre-dirty nat entry to dirty set list
To: wangzijie <wangzijie1@honor.com>, linux-f2fs-devel@lists.sourceforge.net
References: <524de02e-31a1-4b98-8601-edaa51d40d56@kernel.org>
 <20250725021738.1011413-1-wangzijie1@honor.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250725021738.1011413-1-wangzijie1@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/2025 10:17 AM, wangzijie wrote:
>> On 7/22/25 22:36, wangzijie wrote:
>>> When we need to alloc nat entry and set it dirty, we can directly add it to
>>> dirty set list(or initialize its list_head for new_ne) instead of adding it
>>> to clean list and make a move. Introduce init_dirty flag to do it.
>>>
>>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>>> ---
>>>   fs/f2fs/node.c | 37 ++++++++++++++++++++++++++++++-------
>>>   1 file changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index a23db6238..20bcf8559 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -185,7 +185,7 @@ static void __free_nat_entry(struct nat_entry *e)
>>>   
>>>   /* must be locked by nat_tree_lock */
>>>   static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
>>> -	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail)
>>> +	struct nat_entry *ne, struct f2fs_nat_entry *raw_ne, bool no_fail, bool init_dirty)
>>>   {
>>>   	if (no_fail)
>>>   		f2fs_radix_tree_insert(&nm_i->nat_root, nat_get_nid(ne), ne);
>>> @@ -195,6 +195,11 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
>>>   	if (raw_ne)
>>>   		node_info_from_raw_nat(&ne->ni, raw_ne);
>>>   
>>> +	if (init_dirty) {
>>> +		nm_i->nat_cnt[TOTAL_NAT]++;
>>> +		return ne;
>>> +	}
>>> +
>>>   	spin_lock(&nm_i->nat_list_lock);
>>>   	list_add_tail(&ne->list, &nm_i->nat_entries);
>>>   	spin_unlock(&nm_i->nat_list_lock);
>>> @@ -256,7 +261,7 @@ static struct nat_entry_set *__grab_nat_entry_set(struct f2fs_nm_info *nm_i,
>>>   }
>>>   
>>>   static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>>> -						struct nat_entry *ne)
>>> +					struct nat_entry *ne, bool init_dirty)
>>>   {
>>>   	struct nat_entry_set *head;
>>>   	bool new_ne = nat_get_blkaddr(ne) == NEW_ADDR;
>>> @@ -275,6 +280,18 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>>>   
>>>   	set_nat_flag(ne, IS_PREALLOC, new_ne);
>>>   
>>> +	if (init_dirty) {
>>> +		nm_i->nat_cnt[DIRTY_NAT]++;
>>> +		set_nat_flag(ne, IS_DIRTY, true);
>>> +		spin_lock(&nm_i->nat_list_lock);
>>> +		if (new_ne)
>>> +			INIT_LIST_HEAD(&ne->list);
>>> +		else
>>> +			list_add_tail(&ne->list, &head->entry_list);
>>> +		spin_unlock(&nm_i->nat_list_lock);
>>> +		return;
>>> +    }
>>
>> Nit issue, above blanks should be replaced w/ tab.
> 
> Ah...my bad :-(
> 
>> Can we clean up like this?
>>
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index de99b42437c6..60fc2c7b8e10 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -280,30 +280,23 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>>
>>   	set_nat_flag(ne, IS_PREALLOC, new_ne);
>>
>> -	if (init_dirty) {
>> -		nm_i->nat_cnt[DIRTY_NAT]++;
>> -		set_nat_flag(ne, IS_DIRTY, true);
>> -		spin_lock(&nm_i->nat_list_lock);
>> -		if (new_ne)
>> -			INIT_LIST_HEAD(&ne->list);
>> -		else
>> -			list_add_tail(&ne->list, &head->entry_list);
>> -		spin_unlock(&nm_i->nat_list_lock);
>> -		return;
>> -    }
>> -
>>   	if (get_nat_flag(ne, IS_DIRTY))
>>   		goto refresh_list;
>>
>>   	nm_i->nat_cnt[DIRTY_NAT]++;
>> -	nm_i->nat_cnt[RECLAIMABLE_NAT]--;
>> +	if (!init_dirty)
>> +		nm_i->nat_cnt[RECLAIMABLE_NAT]--;
>>   	set_nat_flag(ne, IS_DIRTY, true);
>>   refresh_list:
>>   	spin_lock(&nm_i->nat_list_lock);
>> -	if (new_ne)
>> -		list_del_init(&ne->list);
>> -	else
>> +	if (new_ne) {
>> +		if (init_dirty)
>> +			INIT_LIST_HEAD(&ne->list);
>> +		else
>> +			list_del_init(&ne->list);
>> +	} else {
>>   		list_move_tail(&ne->list, &head->entry_list);
>> +	}
>>   	spin_unlock(&nm_i->nat_list_lock);
>>   }
>>
>> Thanks,
> 
> We need to init list_head before using list_move_tail.
> I think we can do more clean up like this, keep refresh_list part code.

Ah, that's better.

Thanks,

> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 20bcf8559..ebb624fa1 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -196,6 +196,7 @@ static struct nat_entry *__init_nat_entry(struct f2fs_nm_info *nm_i,
>   		node_info_from_raw_nat(&ne->ni, raw_ne);
>   
>   	if (init_dirty) {
> +		INIT_LIST_HEAD(&ne->list);
>   		nm_i->nat_cnt[TOTAL_NAT]++;
>   		return ne;
>   	}
> @@ -280,23 +281,12 @@ static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>   
>   	set_nat_flag(ne, IS_PREALLOC, new_ne);
>   
> -	if (init_dirty) {
> -		nm_i->nat_cnt[DIRTY_NAT]++;
> -		set_nat_flag(ne, IS_DIRTY, true);
> -		spin_lock(&nm_i->nat_list_lock);
> -		if (new_ne)
> -			INIT_LIST_HEAD(&ne->list);
> -		else
> -			list_add_tail(&ne->list, &head->entry_list);
> -		spin_unlock(&nm_i->nat_list_lock);
> -		return;
> -    }
> -
>   	if (get_nat_flag(ne, IS_DIRTY))
>   		goto refresh_list;
>   
>   	nm_i->nat_cnt[DIRTY_NAT]++;
> -	nm_i->nat_cnt[RECLAIMABLE_NAT]--;
> +	if (!init_dirty)
> +		nm_i->nat_cnt[RECLAIMABLE_NAT]--;
>   	set_nat_flag(ne, IS_DIRTY, true);
>   refresh_list:
>   	spin_lock(&nm_i->nat_list_lock);
> 
>>> +
>>>   	if (get_nat_flag(ne, IS_DIRTY))
>>>   		goto refresh_list;
>>>   
>>> @@ -441,7 +458,7 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>>>   	f2fs_down_write(&nm_i->nat_tree_lock);
>>>   	e = __lookup_nat_cache(nm_i, nid, false);
>>>   	if (!e)
>>> -		e = __init_nat_entry(nm_i, new, ne, false);
>>> +		e = __init_nat_entry(nm_i, new, ne, false, false);
>>>   	else
>>>   		f2fs_bug_on(sbi, nat_get_ino(e) != le32_to_cpu(ne->ino) ||
>>>   				nat_get_blkaddr(e) !=
>>> @@ -458,11 +475,13 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>>>   	struct f2fs_nm_info *nm_i = NM_I(sbi);
>>>   	struct nat_entry *e;
>>>   	struct nat_entry *new = __alloc_nat_entry(sbi, ni->nid, true);
>>> +	bool init_dirty = false;
>>>   
>>>   	f2fs_down_write(&nm_i->nat_tree_lock);
>>>   	e = __lookup_nat_cache(nm_i, ni->nid, true);
>>>   	if (!e) {
>>> -		e = __init_nat_entry(nm_i, new, NULL, true);
>>> +		init_dirty = true;
>>> +		e = __init_nat_entry(nm_i, new, NULL, true, true);
>>>   		copy_node_info(&e->ni, ni);
>>>   		f2fs_bug_on(sbi, ni->blk_addr == NEW_ADDR);
>>>   	} else if (new_blkaddr == NEW_ADDR) {
>>> @@ -498,7 +517,7 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
>>>   	nat_set_blkaddr(e, new_blkaddr);
>>>   	if (!__is_valid_data_blkaddr(new_blkaddr))
>>>   		set_nat_flag(e, IS_CHECKPOINTED, false);
>>> -	__set_nat_cache_dirty(nm_i, e);
>>> +	__set_nat_cache_dirty(nm_i, e, init_dirty);
>>>   
>>>   	/* update fsync_mark if its inode nat entry is still alive */
>>>   	if (ni->nid != ni->ino)
>>> @@ -2924,6 +2943,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>>>   	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>>>   	struct f2fs_journal *journal = curseg->journal;
>>>   	int i;
>>> +	bool init_dirty;
>>>   
>>>   	down_write(&curseg->journal_rwsem);
>>>   	for (i = 0; i < nats_in_cursum(journal); i++) {
>>> @@ -2934,12 +2954,15 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>>>   		if (f2fs_check_nid_range(sbi, nid))
>>>   			continue;
>>>   
>>> +		init_dirty = false;
>>> +
>>>   		raw_ne = nat_in_journal(journal, i);
>>>   
>>>   		ne = __lookup_nat_cache(nm_i, nid, true);
>>>   		if (!ne) {
>>> +			init_dirty = true;
>>>   			ne = __alloc_nat_entry(sbi, nid, true);
>>> -			__init_nat_entry(nm_i, ne, &raw_ne, true);
>>> +			__init_nat_entry(nm_i, ne, &raw_ne, true, true);
>>>   		}
>>>   
>>>   		/*
>>> @@ -2954,7 +2977,7 @@ static void remove_nats_in_journal(struct f2fs_sb_info *sbi)
>>>   			spin_unlock(&nm_i->nid_list_lock);
>>>   		}
>>>   
>>> -		__set_nat_cache_dirty(nm_i, ne);
>>> +		__set_nat_cache_dirty(nm_i, ne, init_dirty);
>>>   	}
>>>   	update_nats_in_cursum(journal, -i);
>>>   	up_write(&curseg->journal_rwsem);
> 


