Return-Path: <linux-kernel+bounces-853855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B9FBDCC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B29407ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF683126C6;
	Wed, 15 Oct 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv8q55Xv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8272D2499
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510519; cv=none; b=DAyC3WE0enBfKZOOERLAfVhU1fuzyZAF648FQTOzuT3LHciQ3vOgna/lhc5uV3mEezUt3FHET10jWCmo4MHESuDckXSxW4tHsOxJ0QAURpPiLhV6yzrm5dZmBucBHqIkvBFx4eR7jdBGukMdnz698U+ceSDrz9ffoyzH6xZ37SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510519; c=relaxed/simple;
	bh=7ueWLGthCRnKiKyK3au2L4WjMFYE/UlGA7PZ+YmJV/s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FhvStO0oMFNRfKDsYCaQWki1KKIFKEcmYp/XZN4s6qxlpIpb5vIG1Zny+nm/F6CumvH8C/2VuTC+6avZ7+zloKBhRhgZtMraKTspvXlpg8qjQSa+US82jOln/t3AEbflkOiQT+RWJoc12l0XB8StlKnY+eUaajBm+o3cdbsgfrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv8q55Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A379BC4CEF8;
	Wed, 15 Oct 2025 06:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760510519;
	bh=7ueWLGthCRnKiKyK3au2L4WjMFYE/UlGA7PZ+YmJV/s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Yv8q55XvvArrOpwOBYMqk5hpoKouIC/IPOpP3MD52LD0MW9IUufWtKcqXjTGU8/Bs
	 alIlAbR6oQp0MSVgD0F29NogUp8RgWz8tKJwTVj24DZkQ9myEY1/W0Z9TEyK6qD0V1
	 OPLEgM8EwmHTftNdefy5SISCqRlDub1MQZKS59Usv8BozeZgG3JiT6HTBagw6rBSvT
	 da8gWj4aiVzxdcFwFT55fjvKDQ6PwPL7tNEQJ0YPUcmsmz8RGuIY2JoMsv8/1TI6DA
	 3z7rt+05fI0DiqPgrtPbLq5AW6ZMcJHg9osnOEqSZYvDpbzExJiCUJuOUb0srFVpLr
	 1zfTILTjGWpAQ==
Message-ID: <235adbae-cc45-4b84-b712-1ba9e5a48dce@kernel.org>
Date: Wed, 15 Oct 2025 14:41:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org,
 syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: Perform sanity check before unlinking directory
 inode
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
References: <20251003134731.470392-1-zlatistiv@gmail.com>
 <839306c1-5f7a-4e89-b2cf-7534d279a03c@kernel.org>
 <gupgic53ouhmdwrglwdviw2mzeaqfjsvyr47u3ebu2ztayswy4@4oxvnu252rdb>
 <9d0fef9d-4093-4a80-af3f-6dc45ffe886c@kernel.org>
 <zomib7dzvmnggqqy6aqlwij3zihbvzkzrnfvzhk7tcp2mdgh34@tjjugevo4q4a>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <zomib7dzvmnggqqy6aqlwij3zihbvzkzrnfvzhk7tcp2mdgh34@tjjugevo4q4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/25 20:17, Nikola Z. Ivanov wrote:
> On Mon, Oct 13, 2025 at 08:53:04PM +0800, Chao Yu wrote:
>> On 10/13/25 05:19, Nikola Z. Ivanov wrote:
>>> On Thu, Oct 09, 2025 at 10:54:40AM +0800, Chao Yu wrote:
>>>> On 10/3/2025 9:47 PM, Nikola Z. Ivanov wrote:
>>>>> Current i_nlink corruption check does not take into account
>>>>> directory inodes which have one additional i_nlink for their "." entry.
>>>>>
>>>>> Add additional check and a common corruption path.
>>>>>
>>>>> Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
>>>>> Closes: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
>>>>> Fixes: 81edb983b3f5 ("f2fs: add check for deleted inode")
>>>>> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
>>>>> ---
>>>>>   fs/f2fs/namei.c | 28 ++++++++++++++++++++--------
>>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>>>> index b882771e4699..68b33e8089b0 100644
>>>>> --- a/fs/f2fs/namei.c
>>>>> +++ b/fs/f2fs/namei.c
>>>>> @@ -502,12 +502,14 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>>>>>   		goto out;
>>>>>   	}
>>>>> -	if (inode->i_nlink == 0) {
>>>>> +	if (unlikely(inode->i_nlink == 0)) {
>>>>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>>>>>   			  __func__, inode->i_ino);
>>>>> -		err = -EFSCORRUPTED;
>>>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>>>>> -		goto out_iput;
>>>>> +		goto corrupted;
>>>>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
>>>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
>>>>> +			  __func__, inode->i_ino);
>>>>> +		goto corrupted;
>>>>
>>>> Can we detect such corruption in sanity_check_inode() as well? So that if
>>>> f2fs internal flow calls f2fs_iget() on corrupted inode, we can set SBI_NEED_FSCK
>>>> flag and then triggering fsck repairment later.
>>>>
>>>> Thanks,
>>>>
>>>>>   	}
>>>>>   	if (IS_ENCRYPTED(dir) &&
>>>>> @@ -533,6 +535,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
>>>>>   	trace_f2fs_lookup_end(dir, !IS_ERR_OR_NULL(new) ? new : dentry,
>>>>>   				ino, IS_ERR(new) ? PTR_ERR(new) : err);
>>>>>   	return new;
>>>>> +corrupted:
>>>>> +	err = -EFSCORRUPTED;
>>>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>>>>>   out_iput:
>>>>>   	iput(inode);
>>>>>   out:
>>>>> @@ -572,10 +577,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>>>>   	if (unlikely(inode->i_nlink == 0)) {
>>>>>   		f2fs_warn(F2FS_I_SB(inode), "%s: inode (ino=%lx) has zero i_nlink",
>>>>>   			  __func__, inode->i_ino);
>>>>> -		err = -EFSCORRUPTED;
>>>>> -		set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>>>>> -		f2fs_folio_put(folio, false);
>>>>> -		goto fail;
>>>>> +		goto corrupted;
>>>>> +	} else if (unlikely(S_ISDIR(inode->i_mode) && inode->i_nlink == 1)) {
>>>>> +		f2fs_warn(F2FS_I_SB(inode), "%s: directory inode (ino=%lx) has a single i_nlink",
>>>>> +			  __func__, inode->i_ino);
>>>>> +		goto corrupted;
>>>>>   	}
>>>>>   	f2fs_balance_fs(sbi, true);
>>>>> @@ -601,6 +607,12 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
>>>>>   	if (IS_DIRSYNC(dir))
>>>>>   		f2fs_sync_fs(sbi->sb, 1);
>>>>> +
>>>>> +	goto fail;
>>>>> +corrupted:
>>>>> +	err = -EFSCORRUPTED;
>>>>> +	set_sbi_flag(F2FS_I_SB(inode), SBI_NEED_FSCK);
>>>>> +	f2fs_folio_put(folio, false);
>>>>>   fail:
>>>>>   	trace_f2fs_unlink_exit(inode, err);
>>>>>   	return err;
>>>>
>>>
>>> Hi Chao,
>>>
>>> Thank you for the suggestion.
>>> I will add this to sanity_check_inode and remove it
>>> from f2fs_lookup as it becomes redundant since f2fs_lookup
>>> obtains the inode through f2fs_iget. For f2fs_unlink I will
>>> move the i_nlink == 1 check to f2fs_rmdir.
>>
>> Hi Nikola,
>>
>> I meant we can move the i_nlink == 1 check from both f2fs_lookup() and
>> f2fs_unlink() to sanity_check_inode(), because before we create in-memory
>> inode, we will always call sanity_check_inode().
>>
>> Let me know if you have other concerns.
>>
>> Thanks,
>>
> 
> The issue here is that sanity_check_inode will be called only when 
> we initially read the inode off disk, not when it's already in the cache
> 
> The syzkaller repro does something like this:
> Creates a directory structure /dir1/dir2 where dir1 has
> i_nlink == 2, which is one less than it should. It then does
> rmdir(/dir1/dir2) followed by rmdir(/dir1) which leads to the warning.

Oh, I missed this case.

> 
> In such case what would you say should happen, should the second rmdir
> fail and report the corruption, or do we close our eyes and just drop
> i_nlink to 0 and possibly log a message that something isn't quite right?

I agreed that we should keep i_nlink == 1 check in f2fs_unlink().

Thanks,

> 
> Thank you,
> 
>>>
>>> I will send v2 as soon as I do some more testing.
>>


