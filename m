Return-Path: <linux-kernel+bounces-790852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98AAB3AE53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 01:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A593BD145
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03E2D0C7B;
	Thu, 28 Aug 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pb8GujEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276A25CC42
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423026; cv=none; b=lX72172DaiaQ0nQK0EstkeyKXkOCcR0Tn8jAqUIQwe/0IfhiyaXxj4YqH3G128h1rg32qtWPG2/II0JXBFucEYN8naQV3jWlMwVE5QC9C62kd2nv8rb+0tBhYYB8/GgWZv7LJsuSJuQmm9UK6e95Lxued9jTkhrapElEjYa/LPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423026; c=relaxed/simple;
	bh=vyNzlhZ4CJ+EPkkki2G+silw4Yi9AWcfRQxB9K3f7Y8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rJGVUt0GIa+/jMokut7kn32BUxcA8Gu3vt3jYrBqqC71M8PJrPLS1qzBN2FABTPDqhHjriUe3C9NTBWf7pEFNnOj1TqQEUEsWTWvZB4XLqz6x9V45738MveJvJioxqTDQYdKbeo/MIbOtDMN+19HKlOaABbdU2LA+mTpDo0PcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pb8GujEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB2C4CEF4;
	Thu, 28 Aug 2025 23:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756423025;
	bh=vyNzlhZ4CJ+EPkkki2G+silw4Yi9AWcfRQxB9K3f7Y8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pb8GujEFEf+1a+YHXO2bg1bKKqcxZGi84a5Ia4StEMwb1a5/wFa7z1xMValewbA2M
	 +5qYl4f1rLe331VqnkLcATHJCfA2muBSxIHd09wfVofMCGZEhkowo6uHj2DiHHoema
	 Fm6PDRIsKwNzQNYobZBSpSiy6CiiSBFWCEXTk2e68TG/tMY/E6MLt9r+jgye6mtbi8
	 HMho+7izKtGUpFVjScTB9ZluOM/tHq18pChaofK5hCZ3vLvkgZZfJRWqCpeDULQdpw
	 +7ErT3EpOXUAEmeGe+qiW9nkumsA8VEabt4P8fiTgaGHJx1NZoT7GFTpmV5zRD/Nwx
	 dzZSRlw5ucLZA==
Message-ID: <c7a0afdc-3f33-4de7-b36d-b0d5f55216e2@kernel.org>
Date: Fri, 29 Aug 2025 07:17:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
 <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
 <aLB0XeQh_tm2tXIA@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aLB0XeQh_tm2tXIA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/2025 11:23 PM, Jaegeuk Kim wrote:
> On 08/28, Chao Yu wrote:
>> On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>> Let's split IPU writes in hot data area to improve the GC efficiency.
>>
>> I didn't get it, IPU may be not friendly for migrating data along w/ write in
>> hot area?
> 
> This deals with IPU in the LFS mode.

Okay, so, we missed to add f2fs_lfs_mode() condition, right?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>   fs/f2fs/segment.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index e0f6589c6a1c..bb79dad55ac9 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>>>   
>>>   		if (file_is_hot(inode) ||
>>>   				is_inode_flag_set(inode, FI_HOT_DATA) ||
>>> -				f2fs_is_cow_file(inode))
>>> +				f2fs_is_cow_file(inode) ||
>>> +				is_inode_flag_set(inode, FI_NEED_IPU))
>>>   			return CURSEG_HOT_DATA;
>>>   		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>>>   						inode->i_write_hint);


