Return-Path: <linux-kernel+bounces-821926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD6B82A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C508C486149
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6F2206B8;
	Thu, 18 Sep 2025 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SS3ZKsfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279111B394F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758161763; cv=none; b=h00VAWCnwaptJSQpY3AlYvfYL1yeZafq9E0FQjOeHMOBSkiirfwtsAqzA617LStyiGI4UFW2lZN6aZ7RGxnkny2FMerspQeoGM2XE08JDGDH5+iewpxZJMcOFxr8LLWzPCKRJNVrgVnSbodhqvIyMuCrkLpO+ueRbg3D+M4i5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758161763; c=relaxed/simple;
	bh=l7d4dtAEETZSUstygVX4FRF+R9k53ZclT8NfzTMJ5x0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GFj4q2hjIuh+ZHhq+BNRxrkeFEcHst5mMbJ/VEq1g9wIDIiv3pVV2LXigmSqTVZKD1mu2hq/X2MmkdUJoMwObPE5OWHFNPKo4+tUfNgT4DJuj+xmIhO4YTvydpEElhABi2qFtCTeuzV6VxG2k+gGvwjMatcHqA8/+z2A+bcvkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SS3ZKsfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDDEC4CEE7;
	Thu, 18 Sep 2025 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758161762;
	bh=l7d4dtAEETZSUstygVX4FRF+R9k53ZclT8NfzTMJ5x0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=SS3ZKsfKBXdhznuLLjRWrONmKw5IHrJdEgFo0C+zGUH7vkJSN2hVx/aOmAPOUu3dn
	 NFxK2723LW7yk5pheuCT2icTBeV6NeizeLRp90BP2G+A7r6WsF0MwJ2EOYSTMwf8B2
	 0gKte8XgHEuR7YWTQw4eu3a/eHOuW1SZ44jmwxcAaNFHhEmSBkhvyV9G3DRZPaoZaC
	 gaokYNOXBdN50vDAmWQTwdISS0EOOcDAeu63u9s/YctkDPQzJOQqHxyMhw8+rv1dfj
	 MPoMXOyQdOu9AXIS5YP5druj9jow/dQg3oFi43VksFZUYi7cTXFMvBJ8B6PC5XvTTn
	 R07izys9tS6iQ==
Message-ID: <b473d03c-79d4-4c49-abe3-b41ff64982c3@kernel.org>
Date: Thu, 18 Sep 2025 10:15:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, wangzijie <wangzijie1@honor.com>
Subject: Re: [PATCH] f2fs: add sanity check on ei.len in
 __update_extent_tree_range()
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250916085243.4165099-1-chao@kernel.org>
 <aMrkjSRJ0yyEfvfl@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aMrkjSRJ0yyEfvfl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 00:40, Jaegeuk Kim wrote:
> Do we need this?

I think so, it can provide a way to dump more information to troubleshoot
in which function we're trying to update w/ a zero-sized extent.

Thanks,

> 
> On 09/16, Chao Yu wrote:
>> Add a sanity check in __update_extent_tree_range() to detect any
>> zero-sized extent update.
>>
>> Signed-off-by: wangzijie <wangzijie1@honor.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/extent_cache.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index 199c1e7a83ef..3070d1cb0676 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -664,6 +664,15 @@ static void __update_extent_tree_range(struct inode *inode,
>>  	if (!et)
>>  		return;
>>  
>> +	if (unlikely(len == 0)) {
>> +		f2fs_err_ratelimited(sbi, "%s: extent len is zero, type: %d, "
>> +			"extent [%u, %u, %u], age [%llu, %llu]",
>> +			__func__, type, tei->fofs, tei->blk, tei->len,
>> +			tei->age, tei->last_blocks);
>> +		f2fs_bug_on(sbi, 1);
>> +		return;
>> +	}
>> +
>>  	if (type == EX_READ)
>>  		trace_f2fs_update_read_extent_tree_range(inode, fofs, len,
>>  						tei->blk, 0);
>> -- 
>> 2.49.0


