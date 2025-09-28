Return-Path: <linux-kernel+bounces-835318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FE4BA6B77
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4497A1899AA3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C1F28D8D1;
	Sun, 28 Sep 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PTrz+ZsL"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4215E90
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759048597; cv=none; b=MSLIrfF3oZ5ypsg+7ha9iHWd8rw2A3PzA8rqmun1kPjJRJB91J9hPPPEW851lPdCELunOuzt2gYZm3235wCKyv6StOi6Vnaj96IPjHq2cDMoN0QufpT4vXJlVWv2QA5o9Un0G+Wgawh92+gcaXudNegnqbBadP3/9hjUquehdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759048597; c=relaxed/simple;
	bh=Gp/VJMqiN0E0WUrDcQM2Bgl/BeMGlbZT5jo5D8Hu2Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PznzVI2BH5V35yojxIjdhfte7xdm9zZJMKtbSI51rwO3gbVwiLlv0Eg/z6SDIQ47+1OXLNV87LcyC+ijiWbfQl/fiNFV5vGbfC6/qOTLAfwvUNx4KKte893lHS1V1p8kRvXxBIwgZfALMb/er5lbnD31zb+WcIM01aC51acKnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PTrz+ZsL; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4d8a1e66-a7a2-49a0-be34-2b918c73f092@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759048582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZzFUD3gQ/t+AjJEre6cd9w3693csXe/U0SjQqAd8+A=;
	b=PTrz+ZsLAoBLl53mYgZx9Ph9Pgl1n3WIb3cHS+a0XyoyBqJkQ5hIu/cI1x0CpGr6z6Zo5O
	6JLs6L/Eaz5WtBu/8GizchAJTxMzr2IJ0KppeAFR5SsmmHHGq/APbz46gxaTHY/Tir4yut
	xKQ0+CcwrB6DF3NRG27DMRVBfJ1J5sc=
Date: Sun, 28 Sep 2025 16:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: Add the nlink annotation in btrfs_inode_item
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250926074543.585249-1-youling.tang@linux.dev>
 <adda6065-26a2-4d31-b4f0-ccb20e0fadeb@gmx.com>
 <bda4b547-4dea-4c05-8679-1cf021bbe340@linux.dev>
 <b431fe00-43f3-49c2-a58b-8f79cb2134dc@gmx.com>
 <bc7a7e81-8e71-44ee-af4c-96193c9cb8e8@linux.dev>
 <d788b939-7191-426d-b2eb-944fd1c6b9ed@gmx.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <d788b939-7191-426d-b2eb-944fd1c6b9ed@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 9/28/25 15:37, Qu Wenruo wrote:

>
>
> 在 2025/9/28 16:39, Youling Tang 写道:
>> On 9/28/25 13:16, Qu Wenruo wrote:
>>
>>>
>>>
>>> 在 2025/9/28 11:44, Youling Tang 写道:
>>>> Hi, Wenruo
>>>>
>>>> On 9/26/25 16:34, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> 在 2025/9/26 17:15, Youling Tang 写道:
>>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>>
>>>>>> When I created a directory, I found that its hard link count was
>>>>>> 1 (unlike other file system phenomena, including the "." directory,
>>>>>> which defaults to an initial count of 2).
>>>>>>
>>>>>> By analyzing the code, it is found that the nlink of the directory
>>>>>> in btrfs has always been kept at 1, which is a deliberate design.
>>>>>>
>>>>>> Adding its comments can prevent it from being mistakenly regarded
>>>>>> as a BUG.
>>>>>>
>>>>>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>>>>>> ---
>>>>>>   include/uapi/linux/btrfs_tree.h | 1 +
>>>>>>   1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/btrfs_tree.h 
>>>>>> b/include/uapi/linux/ btrfs_tree.h
>>>>>> index fc29d273845d..b4f7da90fd0e 100644
>>>>>> --- a/include/uapi/linux/btrfs_tree.h
>>>>>> +++ b/include/uapi/linux/btrfs_tree.h
>>>>>> @@ -876,6 +876,7 @@ struct btrfs_inode_item {
>>>>>>       __le64 size;
>>>>>>       __le64 nbytes;
>>>>>>       __le64 block_group;
>>>>>> +    /* nlink in directories is fixed at 1 */
>>>>>
>>>>> nlink of what?
>>>>>
>>>>> Shouldn't be "nlink of directories" or "nlink of directory inodes"?
>>>>>
>>>>>
>>>>> There are better location like btrfs-progs/Documentation/dev/On- 
>>>>> disk- format.rst for this.
>>>>>
>>>>> And you're only adding one single comment for a single member?
>>>>> Even this is a different behavior compared to other fses, why not 
>>>>> explain what the impact of the change?
>>>>>
>>>>>
>>>>> If you really want to add proper comments, spend more time and 
>>>>> effort like commit 9c6b1c4de1c6 ("btrfs: document device locking") 
>>>>> to do it correctly.
>>>>
>>>> My understanding of nlink is as follows, please correct me if I'm 
>>>> wrong,
>>>>
>>>> /*
>>>>   * nlink represents the hard link count (corresponds to inode- 
>>>> >i_nlink value).
>>>>   * For directories, this value is always 1, which differs from 
>>>> other filesystems
>>>>   * where a newly created directory has an inode->i_nlink value of 
>>>> 2 (including
>>>>   * the "." entry pointing to itself).
>>>
>>> Have you checked what's the meaning of the nlink number for other 
>>> fses and why other fses go like that?
>>>
>> I have examined ext4, XFS, and bcachefs. In these filesystems,
>> when performing the following operations:
>> ```
>>   # mkdir -p a/b
>>   # cd a/b
>>   # ls -la
>>   drwxr-xr-x 2 root root  6 Sep 28 14:45 .
>>   drwxr-xr-x 3 root root 15 Sep 28 14:45 ..
>> ```
>>
>> In btrfs:
>> ```
>>   # ls -la
>>   drwxr-xr-x 1 root root 0 Sep 28 14:48 .
>>   drwxr-xr-x 1 root root 2 Sep 28 14:48 ..
>> ```
>>
>> In filesystems like ext4, we can see that the link counts for
>> directory 'a' and 'b' are 3 and 2 respectively:
>> a: The directory itself + "." pointing to itself + ".." from 
>> directory b pointing to it
>> b: The directory itself + "." pointing to itself
>>
>>
>> nlink changes during directory creation in ext4:
>> ```
>> ext4_mkdir
>>      ext4_init_new_dir
>>          set_nlink(inode, 2) //Initial inode->i_nlink value for new 
>> directory
>>      ext4_inc_count(dir) //Increase parent directory's nlink by 1 
>> (for "..")
>> ```
>>
>> In ext4, when the DIR_NLINK feature is enabled, if a directory's link
>> count exceeds EXT4_LINK_MAX, it will be permanently set to 1.
>>
>>
>> nlink changes during directory creation in bcachefs:
>> ```
>> bch2_mkdir
>>      bch2_mknod
>>          __bch2_create
>>              bch2_create_trans
>>                  dir_u->bi_nlink++ //If creating a directory, 
>> increase parent's nlink
>>              bch2_inode_update_after_write
>>                  set_nlink(&inode->v, bch2_inode_nlink_get(bi))
>>                      bch2_inode_nlink_get //If directory, nlink 
>> increased by 2
>> ```
>>
>>
>> In XFS, the xfs_create function contains the following comment:
>> /*
>>   * A newly created regular or special file just has one directory
>>   * entry pointing to them, but a directory also the "." entry
>>   * pointing to itself.
>>   */
>
> You didn't even understand what the nlink represents on these 
> filesystems.

I understand that the nlink of a directory represents (1 + '.' + number 
of subdirectories).
This was already reflected in the a/b directory example I mentioned earlier.

However, I was unaware that find uses the nlinks >= 2 scenario for 
optimization purposes.
Thank you for letting me know.

Thanks,
Youling.
>
> If you even bother to check the code of find, it exactly shows the 
> meaning of nlinks for directory:
>
> gl/lib/fts.c:
>
> ```
> /* Minimum link count of a traditional Unix directory.  When leaf
>    optimization is OK and a directory's st_nlink == MIN_DIR_NLINK,
>    then the directory has no subdirectories.  */
> enum { MIN_DIR_NLINK = 2 };
>
> /* Whether leaf optimization is OK for a directory.  */
> enum leaf_optimization
>   {
>     /* st_nlink is not reliable for this directory's subdirectories.  */
>     NO_LEAF_OPTIMIZATION,
>
>     /* st_nlink == 2 means the directory lacks subdirectories.  */
>     OK_LEAF_OPTIMIZATION
>   };
> ```
>
>
> For filesystems returning nlinks >= 2, it means they implemented the 
> optimization to indicate the number of sub-directories of it.
>
> If you didn't even get this correct, all your words are just words 
> salad, no better than AI slops.
>
>>
>> Thanks,
>> Youling.
>>
>>> Especially the impact to user space tools like find?
>>>
>>>>   *
>>>>   * BTRFS maintains parent-child relationships through explicit 
>>>> back references
>>>>   * (BTRFS_INODE_REF_KEY items) rather than link count accounting.
>
> This has nothing to do with the nlink implementation of btrfs.
>
>>>>   *
>>>>   * This design simplifies metadata management in the copy-on-write 
>>>> environment
>>>>   * and enables more reliable consistency checking.
>
> All these make no sense.
>
>>>> Directory link count
>>>>   * verification is performed during tree checking in 
>>>> check_inode_item(), where
>>>>   * values greater than 1 are treated as corruption.
>>>>   *
>>>>   * For regular files, nlink behaves traditionally and represents 
>>>> the actual
>>>>   * hard link count of the file.
>>>>   */
>>>>
>>>> Thanks,
>>>> Youling.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>       __le32 nlink;
>>>>>>       __le32 uid;
>>>>>>       __le32 gid;
>>>>>
>>>
>>
>

