Return-Path: <linux-kernel+bounces-848991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969DBCEF84
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D923E6F37
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590CF1EEA5F;
	Sat, 11 Oct 2025 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZIeW8Rh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B00191484
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154759; cv=none; b=f+HjzFu27nE2K3ipQBr/8BWspDNanAVGeFDeQ8YC8L+XGk40Y+j+LpY6gE/GRGHs4f6Jcc9ZYnDvPblNuyoycJbghc5bl9H1p21BmV1OhP039G6PUR3NpJGTjHWNHd1i+d9hIQRA81jKdUPjaat+SXbTyAF0Q2H62IuM4oeBODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154759; c=relaxed/simple;
	bh=FTXSRjckTCYZ6O7UwucqhcQ8vJP8Oi19x78dwPfl488=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A8SNxyBxu9kNxrZ7SSmSN7YkdA6jObGcsoWIKLar11P/WI06+HbmjromYJ2j92MrxJMwVRNXw2j1eGYS/d/w9Hx+L14XDgitICztybg4W3Sf1rGYdtOvjf/F+m6IcZUmRsGNg21Kp02fSiplrDcnGwyXWfoMCLltH7Q6wSLErMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZIeW8Rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E703EC4CEF4;
	Sat, 11 Oct 2025 03:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760154759;
	bh=FTXSRjckTCYZ6O7UwucqhcQ8vJP8Oi19x78dwPfl488=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GZIeW8RhNPjOnicTWIkhboeUQ+JkcUBhYXxvWh2DldnocY8HfY9edk5JjvKuSh2E5
	 JNZrl/CDWEMPhcIxAB3WjJOLTdBnZ1DaKJ8zXt3jNocSNZ94eJRjmlBvGnKRrjghjq
	 2cQXLMe5y+Tu36d+VyLs6vNF+3vFqOmkguHu3yyAtts5VEY/dC6rr+Hlz82iSD2U/P
	 jYpDpgrr3Cphn+Sh9fFi976TGfK6J2w8sjrGXO25Xpns8nq6VYWNIqtzmCNmmapBfd
	 FLxLwFKtBGbISNdn/qPEbTZzzrsJ5ArfP/FkqEEUo0lWX9CstUV18CDcFp8fyV+LgC
	 3B2gruqTn/o5w==
Message-ID: <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>
Date: Sat, 11 Oct 2025 11:52:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jan Prusakowski <jprusakowski@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20251006084615.2585252-1-jprusakowski@google.com>
 <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
 <aOkuA_Ffq2klE5g6@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aOkuA_Ffq2klE5g6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/25 00:02, Jaegeuk Kim wrote:
> On 10/09, Chao Yu wrote:
>> On 10/6/2025 4:46 PM, Jan Prusakowski via Linux-f2fs-devel wrote:
>>> Xfstests generic/335, generic/336 sometimes crash with the following message:
>>>
>>> F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
>>> ------------[ cut here ]------------
>>> kernel BUG at fs/f2fs/super.c:1939!
>>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>> CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
>>> Tainted: [W]=WARN
>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>> RIP: 0010:f2fs_put_super+0x3b3/0x3c0
>>> Call Trace:
>>>   <TASK>
>>>   generic_shutdown_super+0x7e/0x190
>>>   kill_block_super+0x1a/0x40
>>>   kill_f2fs_super+0x9d/0x190
>>>   deactivate_locked_super+0x30/0xb0
>>>   cleanup_mnt+0xba/0x150
>>>   task_work_run+0x5c/0xa0
>>>   exit_to_user_mode_loop+0xb7/0xc0
>>>   do_syscall_64+0x1ae/0x1c0
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>   </TASK>
>>> ---[ end trace 0000000000000000 ]---
>>>
>>> It appears that sometimes it is possible that f2fs_put_super() is called before
>>> all node page reads are completed.
>>> Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.
>>>
>>> Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")
>>>
>>> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
>>> ---
>>>   fs/f2fs/super.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 1e0678e37a30..5c94bc42b8a1 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
>>>   	f2fs_flush_merged_writes(sbi);
>>>   	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>>> +	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);
>>
>> Jan,
>>
>> At this stage, GC and checkpoint are both stopped, why there is still read
>> IOs on node page? Who is reading node page? Can you please dig more details
>> for this issue?
> 
> We don't actually wait for completing read IOs. So, I think it doesn't matter
> the threads are stopped?

Read on node page should be synchronous? so if the threads are stopped, there
should be no node IOs? Oh, Or there is still pending asynchronous readahead IO
on node page after all threads are stopped?

Thanks,

> 
>>
>> Thanks,
>>
>>>   	if (err || f2fs_cp_error(sbi)) {
>>>   		truncate_inode_pages_final(NODE_MAPPING(sbi));


