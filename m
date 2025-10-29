Return-Path: <linux-kernel+bounces-875091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C93C1834B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9BB18848BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF432ECD3E;
	Wed, 29 Oct 2025 03:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jekl99XM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D622EBBB9
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761709290; cv=none; b=lZaPBXMHBsSAd41hLkiYkGxpuuJLq84McWkkrqZz9/sr6UxdlomMEGJgZnVGxlqQEHZXq4TG2iYpeWVM5YpFclmPKK9aQEuS0B0K1oGaXN9xOjg+PGAVwWHNPGINaVsPBJBqTRb/E65NTyhyjH9UzXq5JUeVOAHZ4O9ZSTRUruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761709290; c=relaxed/simple;
	bh=LM7xw1gY84IyMupCcGYFAo+7pgbrAfWLJtfDO2qizCc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VGulLw0+w6rWMhTe58qld+uokcG5seyCgvc2EUAStGpCexNGzT7Z6yfTXHs0DE+YL1amO3sOqsi3+7Q78jpgOULCTnFT6icEM404VUbReWabgEFwRAJqr82MT7wjBPcqX74qcKrxTGbr2MJrcuS974Wre7NHuIIrkLAOblFG/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jekl99XM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18950C4CEFD;
	Wed, 29 Oct 2025 03:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761709290;
	bh=LM7xw1gY84IyMupCcGYFAo+7pgbrAfWLJtfDO2qizCc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Jekl99XMprGXJdjtBTQM4gk/HjgvYv91axJHmKfLvDcaAlp6Fusg2oI32gmLBIEmZ
	 bBYPEMY0NVaC5QQLcSqBNV6r83cWpc1k7J2VzSPwy2LBU2pMbR/CwfJLn46pDcixYz
	 cVih+2WV8HBh75cBkwscMDLNAX1iZH2EHO/wLMw9j5peyk5TdZP11zJIxDWO5bazgS
	 Appi5OTHnO5458pfs+9g/jeQGVIgN3Z9jps1sqOJVKwkcRJrKvBcfudFSrZV+yWHsa
	 3dQtOgVAWvcdwL76Uc3Z15an740vskzjIO4aNcMsNffBZXzWMwYCngPLiE8rWeYUJX
	 /WVOpZ8AQDrZQ==
Message-ID: <490569af-8e87-4cea-81dc-3bc9f59aa2b4@kernel.org>
Date: Wed, 29 Oct 2025 11:41:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add fadvise tracepoint
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
 <81602674-b9f4-4ab2-91f5-0afc762e7cc6@kernel.org>
 <7040b501-6e25-42da-bda0-a15614a80d5d@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <7040b501-6e25-42da-bda0-a15614a80d5d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/25 11:13, Yongpeng Yang wrote:
> On 10/29/25 10:06, Chao Yu via Linux-f2fs-devel wrote:
>> On 10/29/25 03:54, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>> This adds a tracepoint in the fadvise call path.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>   fs/f2fs/file.c              |  2 ++
>>>   include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
>>>   2 files changed, 34 insertions(+)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 6d42e2d28861..4a81089c5df3 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
>>>       struct inode *inode = file_inode(filp);
>>>       int err;
>>>   +    trace_f2fs_fadvise(inode, offset, len, advice);
>>> +
>>>       if (advice == POSIX_FADV_SEQUENTIAL) {
>>>           if (S_ISFIFO(inode->i_mode))
>>>               return -ESPIPE;
>>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>>> index edbbd869078f..b7f5317b5980 100644
>>> --- a/include/trace/events/f2fs.h
>>> +++ b/include/trace/events/f2fs.h
>>> @@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
>>>           __entry->ret)
>>>   );
>>>   +TRACE_EVENT(f2fs_fadvise,
>>> +
>>> +    TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
>>> +
>>> +    TP_ARGS(inode, offset, len, advice),
>>> +
>>> +    TP_STRUCT__entry(
>>> +        __field(dev_t,    dev)
>>> +        __field(ino_t,    ino)
>>> +        __field(loff_t, size)
>>> +        __field(loff_t,    offset)
>>> +        __field(loff_t,    len)
>>> +        __field(int,    advice)
>>> +    ),
>>> +
>>> +    TP_fast_assign(
>>> +        __entry->dev    = inode->i_sb->s_dev;
>>> +        __entry->ino    = inode->i_ino;
>>> +        __entry->size    = inode->i_size;
>>
>> __entry->size = i_size_read(inode)?
>>
>> Thanks,
>>
> The other "__entry->size = inode->i_size;" in include/trace/events/f2fs.h also need to be updated?

Yeah, Yongpeng, I noticed that and fixed them right after reply:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=bugfix/common&id=ffd21bf791143957f6ff1fc14d7dbd6e8466b320

Thanks for your reminder. :)

Thanks,

> 
>>> +        __entry->offset    = offset;
>>> +        __entry->len    = len;
>>> +        __entry->advice    = advice;
>>> +    ),
>>> +
>>> +    TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
>>> +        show_dev_ino(__entry),
>>> +        (unsigned long long)__entry->size,
>>> +        __entry->offset,
>>> +        __entry->len,
>>> +        __entry->advice)
>>> +);
>>> +
>>>   TRACE_EVENT(f2fs_map_blocks,
>>>       TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
>>>            int ret),
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


