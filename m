Return-Path: <linux-kernel+bounces-793666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F231EB3D693
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891133B9B08
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C2E54758;
	Mon,  1 Sep 2025 02:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mX//IuTx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97361323E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692928; cv=none; b=RdCMtOWWeu33Fb7H+a1fVK35ANI6SLthbvaST++VdygZsgkh7/LCKQYcuYUlkmYbeWyJ3SFBmHmzhL6Y13bFq+mspXjKaN2schzLIsH9Iv3gHyRaVmn1GLIpzDUgu6aUVZSqaev527yWcFGaZITzuNBnQa0OPAlHjfZXp4EP4UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692928; c=relaxed/simple;
	bh=XO+FH4L46snPbiIleHTk7JE9h89KztDGTl+m6r5W5nw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iTmN814g5XJtBFr56qgDy/NsnbgvJq9lOK6hq9BYkC+xvvkihmHucre4xQJ/uERu3bbNzk4RMSYeD9G+oAjF4wiKHXUpq8FDExnIbhIJhcZwrQydmNIgArmwQs0nx/f+ISz5JZ+ReDRhhDHan6SfCYnXh3jZGTH9dxKxdcpGYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mX//IuTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653D8C4CEED;
	Mon,  1 Sep 2025 02:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756692927;
	bh=XO+FH4L46snPbiIleHTk7JE9h89KztDGTl+m6r5W5nw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=mX//IuTxF22YSaGeKcAgIaJaBlL5eM8DglNPukYlc4M5IYozCEtLtYY7gvuyMiT/7
	 vsIccJ8jN4JsKnGCRaleNqacj5OGZvgBPx5Hrvta3RxkWQJtCbMIFLf0VplK6MC7BX
	 Cnaics/y4UK+8I4BQ2hd2iiD/D0BOo/ypdQ0vzZdVtgB+0vFpPMRMNk0j9rhY7ruP5
	 ac1WzNYNEIalMQAT6pNjK+ui79cdnGkJk/m93H1y9gSbjD3bfZO3Kbw7aEkn2BztZ5
	 wSLbm7ymsyawnLR+nGOJdOUTB8PAZeIq0173JxWVwve8vUoFXUuf1iBHaCRBnq/3UB
	 Ycd0W/4T3JW1A==
Message-ID: <887d9b30-0069-4f4d-8107-48662379fd30@kernel.org>
Date: Mon, 1 Sep 2025 10:15:24 +0800
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
 <d0357cd2-5435-4d99-af31-cc56fc05ce9a@kernel.org>
 <aLOPPQFJEqoYQg24@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aLOPPQFJEqoYQg24@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/25 07:54, Jaegeuk Kim wrote:
> On 08/30, Chao Yu wrote:
>> On 8/30/2025 4:47 AM, Jaegeuk Kim wrote:
>>> On 08/29, Chao Yu wrote:
>>>> On 8/28/2025 11:23 PM, Jaegeuk Kim wrote:
>>>>> On 08/28, Chao Yu wrote:
>>>>>> On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>>>>>> Let's split IPU writes in hot data area to improve the GC efficiency.
>>>>>>
>>>>>> I didn't get it, IPU may be not friendly for migrating data along w/ write in
>>>>>> hot area?
>>>>>
>>>>> This deals with IPU in the LFS mode.
>>>>
>>>> Okay, so, we missed to add f2fs_lfs_mode() condition, right?
>>>
>>> Why do we need that?
>>
>> As you mentioned above, this deals w/ IPU in the LFS mode. Am I missing
>> something?
> 
> The IPU flag indicates the data is hot. In lfs_mode, we missed to allocate
> it into HOT_DATA. In normal mode, IPU will update the data in place, which
> doesn't affect anything, while newly create data is also good to store in
> HOT_DATA as well. So, I think we don't need other condition here.

It makes sense, thanks for the explanation.

Reviewed-by: Chao Yu <chao@kernel.org>

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
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>> ---
>>>>>>>    fs/f2fs/segment.c | 3 ++-
>>>>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>> index e0f6589c6a1c..bb79dad55ac9 100644
>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>> @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>>>>>>>    		if (file_is_hot(inode) ||
>>>>>>>    				is_inode_flag_set(inode, FI_HOT_DATA) ||
>>>>>>> -				f2fs_is_cow_file(inode))
>>>>>>> +				f2fs_is_cow_file(inode) ||
>>>>>>> +				is_inode_flag_set(inode, FI_NEED_IPU))
>>>>>>>    			return CURSEG_HOT_DATA;
>>>>>>>    		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>>>>>>>    						inode->i_write_hint);


