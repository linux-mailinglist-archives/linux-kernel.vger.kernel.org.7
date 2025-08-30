Return-Path: <linux-kernel+bounces-792634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523A7B3C6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5770A24934
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043E22FDEC;
	Sat, 30 Aug 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih+3OATp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC4A79CD
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756516320; cv=none; b=JueX9W8dRSY9J6rKAVQc2A45vGrih1bO6GTMtiaD/ii5OXNfEm4EOWF67qndpFkz7i2ggaeDDua/JVkT/jrrFoSVesfEhVJZkweiPXYyPSVhB/u8R4neEz+EiEBoQcea4SjHZ5V8SVMH0j7u34m3nZycxrX261e2Wnre8GRvX5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756516320; c=relaxed/simple;
	bh=tycl4yGmvMLiJ12nt0D6Iv196uuT9CH0W3/80EDmza8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ofl1b+K3vXiqHBQn7lFtuQHQHDMMQDA4n/4TW/X5Xvb3oHDJdlh/+/VLMPssi7wI6TsmTnYosKiE0znqntCodDkPZzCulhmCsq3Y2H97AlyZkisWugSAvNajpkAHUKKWFXS0EnCcTvadCwpDqFHxXi2h0hA4c1uRY1ny9OOnVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih+3OATp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85877C4CEF0;
	Sat, 30 Aug 2025 01:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756516320;
	bh=tycl4yGmvMLiJ12nt0D6Iv196uuT9CH0W3/80EDmza8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ih+3OATp7z1kjkOLPNQ8RA8UjGhW3fAwlMok0LsgbTACMo0pqG/ila36CZYnoVj/y
	 cu2Mmr2IG1ej0s0TLZ8qRwMAGkeKUSVRmNiqSgQEZoy+BIEsPlWqDYBlxiDN9e97Fz
	 E/cFvtq4nVGWQ57InuVkjlKEkGV5QB0hHS4NSSQDjlOCBGFBoWtS69X+YNN9KjuoS9
	 tvdDP0SfRzn2e2JUM9Ngz0TS5iQV70GDZ1dlzOnoEcvPYPGKGzxux660ab29TaBDcO
	 Zch4H2VoAzDy7b2lxKfKR4WYM73DlEcU8ZI+BbYyE0APmu8eOEufGoKW8oVmTOl1fV
	 3UH6KKn+TdofQ==
Message-ID: <d0357cd2-5435-4d99-af31-cc56fc05ce9a@kernel.org>
Date: Sat, 30 Aug 2025 09:11:59 +0800
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
 <c7a0afdc-3f33-4de7-b36d-b0d5f55216e2@kernel.org>
 <aLIR7BaaAizkdzgl@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aLIR7BaaAizkdzgl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/30/2025 4:47 AM, Jaegeuk Kim wrote:
> On 08/29, Chao Yu wrote:
>> On 8/28/2025 11:23 PM, Jaegeuk Kim wrote:
>>> On 08/28, Chao Yu wrote:
>>>> On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>>>> Let's split IPU writes in hot data area to improve the GC efficiency.
>>>>
>>>> I didn't get it, IPU may be not friendly for migrating data along w/ write in
>>>> hot area?
>>>
>>> This deals with IPU in the LFS mode.
>>
>> Okay, so, we missed to add f2fs_lfs_mode() condition, right?
> 
> Why do we need that?

As you mentioned above, this deals w/ IPU in the LFS mode. Am I missing
something?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>    fs/f2fs/segment.c | 3 ++-
>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>> index e0f6589c6a1c..bb79dad55ac9 100644
>>>>> --- a/fs/f2fs/segment.c
>>>>> +++ b/fs/f2fs/segment.c
>>>>> @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>>>>>    		if (file_is_hot(inode) ||
>>>>>    				is_inode_flag_set(inode, FI_HOT_DATA) ||
>>>>> -				f2fs_is_cow_file(inode))
>>>>> +				f2fs_is_cow_file(inode) ||
>>>>> +				is_inode_flag_set(inode, FI_NEED_IPU))
>>>>>    			return CURSEG_HOT_DATA;
>>>>>    		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>>>>>    						inode->i_write_hint);


