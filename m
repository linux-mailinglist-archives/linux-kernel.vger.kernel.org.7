Return-Path: <linux-kernel+bounces-841414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E6DBB73DA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F028519E46F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A84B280CD3;
	Fri,  3 Oct 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="A0BJupCp"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BA26D4C6
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503113; cv=none; b=hK1eSwhk+oCEJ8xFOlh1fg8Sgk4olrFyaUHuK3ceYNL8aNFHdLzN8lBJ1Cd6Knr66YLg9oZLdgJmpb+EFLZusi8DK46hhIbguTl2KWwHhGdqE/W9kF5nhvG1uD38L2jzR4joJ8Ar9KrbojMzDE+RHlkGWBDM24bg5WC5MN6iHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503113; c=relaxed/simple;
	bh=i/YUf1axjvgBB0oBuLEcFDe6+5YLN/s7LxvMOh+E9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YF1NkZFelQ9GB4xL3qIzUQOLcse3OSlGuwA3OqEqF0UsWlOAXpD4aiZvN+RRvyD+EAwDA8Ig4J1QIwj2MIcg3eCqHsvt4bjt2bvLUrIDkkkt2gwlEvN/b3myBpsrRGMpPATGdBQC+pyRJ9JvQhKYqQNEUw3tthEWnH9SIGGw1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=A0BJupCp; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id 4gUCvnWkov7244h8LvP4Sz; Fri, 03 Oct 2025 14:51:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4h8KvdcHbfjrX4h8KvXnzv; Fri, 03 Oct 2025 14:51:44 +0000
X-Authority-Analysis: v=2.4 cv=ItcecK/g c=1 sm=1 tr=0 ts=68dfe300
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4oHATN8Nx7vVUZJYxp75bA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=23AC6A14qyjZoQxIM3kA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jV1qtlxBFmkNX+E301lyZjQNxGWe0zxbBvqrtgqEyMg=; b=A0BJupCpk8ltfWzhHrwl2IilfY
	C1cNHLok+ikyxTGyLwqodAQBOPFtv1fh/dbzboQ3JDVqn2jWYvVxuuOtgS1kIEBV/uiPfrCge21XB
	DFH4P1S2iG/+HhWqwLsgfK4Puobet8d4I8pCIytJC1qRXlICNSmAo4nR3VOQ56ugPhr+z8kFUWUAZ
	+EE4Vf0oFkkxpyK2l9Krov50AjghhQVuTU/TVqPqbbdsGPUdSN5UFy/d38bbA5L/O5efLY+wIKcED
	QKCw55R7LLRxp10T6ded/vadv+HioyqN+y7gA+p8/Ji7X+4Uymv+ocCyOFIVfPcbvzv+x176k1jgu
	JFcN7Q+Q==;
Received: from [185.134.146.81] (port=45090 helo=[10.21.53.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v4h8J-00000001gmy-0fZk;
	Fri, 03 Oct 2025 09:51:43 -0500
Message-ID: <b59ed01f-d9d5-4de8-8a12-1e506962b2d9@embeddedor.com>
Date: Fri, 3 Oct 2025 15:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
To: dsterba@suse.cz, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aN_Zeo7JH9nogwwq@kspp> <20251003143502.GJ4052@suse.cz>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251003143502.GJ4052@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.134.146.81
X-Source-L: No
X-Exim-ID: 1v4h8J-00000001gmy-0fZk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.21.53.44]) [185.134.146.81]:45090
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH1aqKbbLJwXJOOWvVZlvSaNe8BWlxtVXu2AmpoIeg5Cbx+/WoXJe00wcSXYq1J8Aq4OQZAVNHQpDjp7MhDxSOuGvJcemO3dgPlmAYPxJiZH8A2iomhk
 viVsZS2aYrz+M2Zswxr2RP1x7p9A4Azb95PKo1iPNRVP20IF4x1Pv+oZ8zkEM2sgiQ8GejrzUr9HkEfMAqmO9gs8yY3MN273tp69ewFQdhrPvXPDuiMsPrI2



On 10/3/25 15:35, David Sterba wrote:
> On Fri, Oct 03, 2025 at 03:11:06PM +0100, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the corresponding
>> structure. Notice that `struct fs_path` is a flexible structure,
>> this is a structure that contains a flexible-array member (`char
>> inline_buf[];` in this case).
> 
> It contains a flexible member but also a padding array and a limit
> calculated for the usable space of inline_buf (FS_PATH_INLINE_SIZE),
> it's not the pattern where flexible array is in the middle of a
> structure and could potentially overwrite other members.

Yep, I notice that while reviewing the context in which this is being
used. :)

> 
>> Fix the following warning:
>>
>> fs/btrfs/send.c:181:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Otheriwse OK to fix the warning.

Thanks.

> 
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   fs/btrfs/send.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>> index 9230e5066fc6..2b7cf49a35bb 100644
>> --- a/fs/btrfs/send.c
>> +++ b/fs/btrfs/send.c
>> @@ -178,7 +178,6 @@ struct send_ctx {
>>   	u64 cur_inode_rdev;
>>   	u64 cur_inode_last_extent;
>>   	u64 cur_inode_next_write_offset;
>> -	struct fs_path cur_inode_path;
>>   	bool cur_inode_new;
>>   	bool cur_inode_new_gen;
>>   	bool cur_inode_deleted;
>> @@ -305,6 +304,9 @@ struct send_ctx {
>>   
>>   	struct btrfs_lru_cache dir_created_cache;
>>   	struct btrfs_lru_cache dir_utimes_cache;
>> +
>> +	/* Must be last --ends in a flexible-array member. */
>                          ^^
> 
> Is this an en dash?

Not sure what you mean.

-Gustavo

> 
>> +	struct fs_path cur_inode_path;
>>   };
>>   
>>   struct pending_dir_move {
>> -- 
>> 2.43.0
>>



