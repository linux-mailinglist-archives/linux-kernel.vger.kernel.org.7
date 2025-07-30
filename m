Return-Path: <linux-kernel+bounces-750330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133FDB15A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E8818C1028
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59214235046;
	Wed, 30 Jul 2025 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1oil1KJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CD24B26
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862462; cv=none; b=CAM2E4iSQ4wHb9q1ZspzvmCyd24bGQCq1r9ToiVUZwKShB7w6thlg//4S0nntsoicmkjqqzFHELH/g5T71ScH+R/qYM5AuP4I/R0MDXAAKJD1mZSQu/wG58D755Inoqss9u2o1ocCcFTj0aAmA28hiVkvMuSSxYRl825NKX6Gu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862462; c=relaxed/simple;
	bh=Ki7ihbcUX3y1qlZQd6ZzLNSF2Z+gQobdg0k8jMlnOHo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dL8JK+Vf6R9Y+lcRJjIBzjes8/qwTiJ8OoFemg1xHWBrcKcbKi+osE7eF2ym/E9lru2WNOACZNTS/fSPTGzCZ3GRDS5JAMye1fwo91qwT9n4mmqB58HFgBq3mxoxfmHvUzDWF2aPoiMwhmYB41qfIHkmNtcKtad6LPRyW1208hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1oil1KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA99C4CEF5;
	Wed, 30 Jul 2025 08:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753862462;
	bh=Ki7ihbcUX3y1qlZQd6ZzLNSF2Z+gQobdg0k8jMlnOHo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=J1oil1KJcTG4zOZ1FisWuAjSWcsjQANfJTnk4eW1kJjsZ9PRmfFJrgMjd7+v7rBOD
	 6tVI+juuNcJ1wbcUloS1yVCoI/LU1pmimdv5ohbh1olGtENowlhJc9Iqig9wCx/6Rd
	 yyTQXJqSbCn7d68b6k8gttJwM1+l58yHwL56bgcZOwaSJXLklS2CU8Lh/C4PV3TuA8
	 l3s+/UkNFdlgiSROUzooJuHH73v18LkZKgETzkMDY3sw2nb/aYchytRuNdRbPC9eoo
	 0J8Qcf2TmpQ5yR3C/bsTyzBfWE50QtNXVdBgzEa/aUmrHJHgusRdqq0HVC6UYI1NGI
	 0PVsx5HNSTBlg==
Message-ID: <9debb3ed-d8e3-4cb7-94d5-1db6d7e97721@kernel.org>
Date: Wed, 30 Jul 2025 16:00:58 +0800
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

Oops, I need to dump information in user's thread instead of f2fs_ckpt.

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


