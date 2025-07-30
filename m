Return-Path: <linux-kernel+bounces-750395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73241B15ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD8A3A6D01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E636264623;
	Wed, 30 Jul 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEZ8tCpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DA35971
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864812; cv=none; b=sMmbc+KNAmBG78OKt1eJS3qdwsdBsCTsVYmVrW78qcUtOsRy5Jx4R1pR6P6HKBjxL7LNolNDDLvuksR8OU/b3FH8NuovkIDly9gvDq6QVTHffDYj737ttPYHv+Q+4Uz4/J6qe5q66CM7bWhZuIBDtPIhoPZ153eVwNnMzEgbezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864812; c=relaxed/simple;
	bh=XUSplBUZMrx9VWLBtC5rkzHiN5UsP5oB18QNcfT2Kg8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UULnSn1fRK8dWA9Yl5drV/XU0J0XWhClRMmgyYuFilPs8ZZ9SXwXJ5dbD6joBHNFukxX0wh98blIlPpQbGAzntm+f03gKkuIJhX8emo9BqNiwBhsQcO/TC4ELUyc5LotiN26w+nrRPbKV09nmFiXBAhJgPOv39I94dMmaYeQUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEZ8tCpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D536C4CEE7;
	Wed, 30 Jul 2025 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753864811;
	bh=XUSplBUZMrx9VWLBtC5rkzHiN5UsP5oB18QNcfT2Kg8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pEZ8tCpIX7tSdxYjunx3v5XiR0UtrKlhX8NXy9BA+MvnEv974sqEqEWRwSyHraPV9
	 24iMZp3/XyR71dWZR5ULXvm+hfuImNnxvIv4pRA6vJRQJyc6/2X02Ul3//f+U2AUHF
	 uj96/U/pryHPnOG4WV0iGrzlPWVr6xEQ9Z/8BN1DBdtp1MUZrcOXrvqCtNcBCfO7s9
	 xzYbL8QGFyKn/NEACOUTEHcseD8v0OJ1g1CyXCpnL2KaLvKjGEu4YZh1ch11c648O8
	 3NN2Vk+ePtG8NKShk0c2a0T46s7yKk3Qeu1LeBp80DkP4u5TRejBs5MR5xRLOTmSJ6
	 kGEOur5nbA6tQ==
Message-ID: <1735962b-043d-48b5-b593-d1705ddd4a97@kernel.org>
Date: Wed, 30 Jul 2025 16:40:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Jan Prusakowski <jprusakowski@google.com>
Subject: Re: [PATCH] f2fs: dump more information when checkpoint was blocked
 for long time
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250729063326.435167-1-chao@kernel.org>
 <aIjjoBJqYjdNv63m@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aIjjoBJqYjdNv63m@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/25 23:07, Jaegeuk Kim wrote:
> On 07/29, Chao Yu wrote:
>> generic/299 w/ mode=lfs will cause long time latency, let's dump more
>> information once we hit case.
>>
>> CP merge:
>>   - Queued :    0
>>   - Issued :    1
>>   - Total :    1
>>   - Cur time : 7565(ms)
>>   - Peak time : 7565(ms)
>>
>> F2FS-fs (vdc): checkpoint was blocked for 7565 ms, affecting 1 tasks
>> CPU: 8 UID: 0 PID: 1614 Comm: f2fs_ckpt-253:3 Tainted: G           O        6.16.0-rc3+ #406 PREEMPT(voluntary)
>> Tainted: [O]=OOT_MODULE
>> Call Trace:
>>  dump_stack_lvl+0x6e/0xa0
>>  __checkpoint_and_complete_reqs+0x1a6/0x1d0
>>  issue_checkpoint_thread+0x4b/0x140
>>  kthread+0x10d/0x250
>>  ret_from_fork+0x164/0x190
>>  ret_from_fork_asm+0x1a/0x30
> 
> Can we add more information for debugging this?

I guess we can add more stats in write_checkpoint() to see which
stage we cost most of the latency.

Thanks,

> 
>>
>> Cc: Jan Prusakowski <jprusakowski@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/checkpoint.c | 9 ++++++++-
>>  fs/f2fs/f2fs.h       | 3 +++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index db3831f7f2f5..b0dcaa8dc40d 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1788,8 +1788,15 @@ static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
>>  
>>  	spin_lock(&cprc->stat_lock);
>>  	cprc->cur_time = (unsigned int)div64_u64(sum_diff, count);
>> -	if (cprc->peak_time < cprc->cur_time)
>> +	if (cprc->peak_time < cprc->cur_time) {
>>  		cprc->peak_time = cprc->cur_time;
>> +
>> +		if (unlikely(cprc->peak_time >= CP_LONG_LATENCY_THRESHOLD)) {
>> +			f2fs_warn_ratelimited(sbi, "checkpoint was blocked for %u ms, affecting %llu tasks",
>> +					cprc->peak_time, count);
>> +			dump_stack();
>> +		}
>> +	}
>>  	spin_unlock(&cprc->stat_lock);
>>  }
>>  
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 46d23c2c086c..3130ca6a4770 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -350,6 +350,9 @@ struct ckpt_req_control {
>>  	unsigned int peak_time;		/* peak wait time in msec until now */
>>  };
>>  
>> +/* a time threshold that checkpoint was blocked for, unit: ms */
>> +#define CP_LONG_LATENCY_THRESHOLD	5000
>> +
>>  /* for the bitmap indicate blocks to be discarded */
>>  struct discard_entry {
>>  	struct list_head list;	/* list head */
>> -- 
>> 2.49.0


