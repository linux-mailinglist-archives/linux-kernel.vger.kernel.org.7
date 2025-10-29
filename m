Return-Path: <linux-kernel+bounces-875626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE463C1976F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBD3B584222
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99C313526;
	Wed, 29 Oct 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq8P9rOT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612E2512FC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730886; cv=none; b=JphhT9zuS+dU6c1EM56eW/AnQ/qAjSZBnj8c15jKkjlF5WM16DthdNAPLS9lTVpBz4YpbKGBymDLF570t4lqsZSkFN2ZTdKVpjgUUnO77f+tzE0f98moyaiFqct5152NOdVHOwZH8OLdsXD5SqNQUYHPkKrkrguFqEe49ahjaIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730886; c=relaxed/simple;
	bh=USrNmdE74cIwX8ZXj65xooCod66cGcvkOUom+iY60+A=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=olpD1lA+sy9e77FrPXlGVUlnGJxl3b6rjtdGZYkh9BXt0fhWScKvTlX26rd93homnuu1aNfN1VrhH3yYrvb5UGqV8cLJpIOGM1bzvY/OOInRQkzN+cZ4Ho1U4/rFfLAArmunfHyZ/6ZTHg0ymbdHeX4tY8sN8cXaSwpP97TSPdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq8P9rOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569E1C4CEF7;
	Wed, 29 Oct 2025 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761730886;
	bh=USrNmdE74cIwX8ZXj65xooCod66cGcvkOUom+iY60+A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Yq8P9rOTFDHjPDEPj1psPbSTT3Ba5xQSP0kQLGWobfXC8QIbi3Z3U7XIVF2ufHdzY
	 5OVRY3p6fxDxhmiw/bE3nPlLjxNjK/p6q2oCYRY7oGgvU/nWPDT08IdwQkSC3UIM+o
	 MiLBnsU2qEpnyFICMjXHbASxJUUg7I4WaLqLIwm3B+73fklRhQeK60vJy0SJ9EA0Wm
	 R1rJiQLLGJmAqw/3HUBsFNzWvPxYlO7lUg31kT+B8/hM5jFbiIKajs8NsBhdp5gAGE
	 sJ9GZLpTsRySIcBW15XJGHAWoPHLxstCwmGnvoqDmcNJGlTvIVIOlK+nNvOJi99vPg
	 /lejVudM8N0hQ==
Message-ID: <45823945-2ea3-4ec6-9b07-686814f38567@kernel.org>
Date: Wed, 29 Oct 2025 17:41:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to access i_size w/ i_size_read()
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>, jaegeuk@kernel.org
References: <20251029063105.989253-1-chao@kernel.org>
 <f9cf5992-0357-4702-be73-881c9997929d@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <f9cf5992-0357-4702-be73-881c9997929d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/25 16:09, Yongpeng Yang wrote:
> On 10/29/25 14:31, Chao Yu via Linux-f2fs-devel wrote:
>> It recommends to use i_size_{read,write}() to access and update i_size,
>> otherwise, we may get wrong tearing value due to high 32-bits value
>> and low 32-bits value of i_size field are not updated atomically in
>> 32-bits archicture machine.
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   include/trace/events/f2fs.h | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>> index edbbd869078f..e1fae78d64a5 100644
>> --- a/include/trace/events/f2fs.h
>> +++ b/include/trace/events/f2fs.h
>> @@ -204,7 +204,7 @@ DECLARE_EVENT_CLASS(f2fs__inode,
>>           __entry->pino    = F2FS_I(inode)->i_pino;
>>           __entry->mode    = inode->i_mode;
>>           __entry->nlink    = inode->i_nlink;
>> -        __entry->size    = inode->i_size;
>> +        __entry->size    = i_size_read(inode);
>>           __entry->blocks    = inode->i_blocks;
>>           __entry->advise    = F2FS_I(inode)->i_advise;
>>       ),
>> @@ -353,7 +353,7 @@ TRACE_EVENT(f2fs_unlink_enter,
>>       TP_fast_assign(
>>           __entry->dev    = dir->i_sb->s_dev;
>>           __entry->ino    = dir->i_ino;
>> -        __entry->size    = dir->i_size;
>> +        __entry->size    = i_size_read(dir);
>>           __entry->blocks    = dir->i_blocks;
>>           __assign_str(name);
>>       ),
>> @@ -433,7 +433,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
>>       TP_fast_assign(
>>           __entry->dev    = inode->i_sb->s_dev;
>>           __entry->ino    = inode->i_ino;
>> -        __entry->size    = inode->i_size;
>> +        __entry->size    = i_size_read(inode);
>>           __entry->blocks    = inode->i_blocks;
>>           __entry->from    = from;
>>       ),
>> @@ -1006,7 +1006,7 @@ TRACE_EVENT(f2fs_fallocate,
>>           __entry->mode    = mode;
>>           __entry->offset    = offset;
>>           __entry->len    = len;
>> -        __entry->size    = inode->i_size;
>> +        __entry->size    = i_size_read(inode);
>>           __entry->blocks = inode->i_blocks;
>>           __entry->ret    = ret;
>>       ),
> 
> inode->i_size usage in fs/f2fs/ also needs to be updated. For example in f2fs_need_verity(), which may not protected by inode_lock.

Accessing i_size directly in f2fs_need_verity() should be fine? Because fsverity
actived inode should be readonly.

Do you see any other cases which are not covered by inode_lock()?

Thanks,

> 
> Yongpeng,


