Return-Path: <linux-kernel+bounces-857760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A8BE7E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36433425C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495C2DAFC4;
	Fri, 17 Oct 2025 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgzB5jNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899DD2DAFB1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694466; cv=none; b=AkaL1IELg0ZZIoXEFToS3cx11YgshriXRgIl5F3COBoWroxtcH0sHcjXlaIFWXShgkSS5ijSNTAEtfOusuGbT452uaKMvPTlBegyoMQnIBzz+TvvS30uHqb+iDD+ymJoLovjWt0ExydnWhC6UJ6rfORBJSH1I+La+raztp18eXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694466; c=relaxed/simple;
	bh=TgohWvrr8PPcueUdJIB8RPjo736OQrsal4Ke867tpaE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UAjeRVhhxljTMQXv4FqZuywL4nw8dErjQWsYqddzIrnVsxCtujIBYX5yNv69bJKVWtS+8396dsMG+Q3Iph0ky4m5bWFGKomK2NhO1VquNiJZB6Cd9yFvz4116S6pVbcUtNROOgOIGFFO9mCJEHnXIkaGFMymmCkmHaR7FY9ZeUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgzB5jNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00624C4CEE7;
	Fri, 17 Oct 2025 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760694466;
	bh=TgohWvrr8PPcueUdJIB8RPjo736OQrsal4Ke867tpaE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CgzB5jNGATGcNf741gRjhmva5S4P6nntGbmy77yPZX+dr3vBP0NmnuNMcYfVEdZXH
	 Qiowd0Y+zH2AWsFNci2ZtP72GBz7qIuaJVw+V0ITGWcCkDtTX56mWwgtIrwcsVNTy/
	 AsruebVqs8yGKtGZAqNBMdN/6C8UKzPZEd/jizJScSLNJjD+S8BWnIGIejpxYFP4ti
	 ugrK1qX0Yk9sDAePMUd8XzcnyPJSRBRuYDrKaMVw/6dul0LqhuYlwm19vehovyrY1k
	 eNqSStlm+lDqhQSIzRQ1lGS36FBPzZm8G41e8Cxs5Z2f5VA80aWYsJdTOXV2GxU3q4
	 GRq9SyzjQc/RA==
Message-ID: <b4a0af34-bd8b-4130-a96f-6aacbe0fb576@kernel.org>
Date: Fri, 17 Oct 2025 17:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: ensure node page reads complete before
 f2fs_put_super() finishes
To: Jaegeuk Kim <jaegeuk@kernel.org>,
 Jan Prusakowski <jprusakowski@google.com>
References: <20251006084615.2585252-1-jprusakowski@google.com>
 <c4643bb6-882a-4229-b938-e94398294905@kernel.org>
 <aOkuA_Ffq2klE5g6@google.com>
 <ac1bcf67-cc5f-4288-a2f3-c4fb6013c38a@kernel.org>
 <aPEvpeM_cXWcxcZe@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <aPEvpeM_cXWcxcZe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/2025 1:47 AM, Jaegeuk Kim wrote:
> On 10/11, Chao Yu wrote:
>> On 10/11/25 00:02, Jaegeuk Kim wrote:
>>> On 10/09, Chao Yu wrote:
>>>> On 10/6/2025 4:46 PM, Jan Prusakowski via Linux-f2fs-devel wrote:
>>>>> Xfstests generic/335, generic/336 sometimes crash with the following message:
>>>>>
>>>>> F2FS-fs (dm-0): detect filesystem reference count leak during umount, type: 9, count: 1
>>>>> ------------[ cut here ]------------
>>>>> kernel BUG at fs/f2fs/super.c:1939!
>>>>> Oops: invalid opcode: 0000 [#1] SMP NOPTI
>>>>> CPU: 1 UID: 0 PID: 609351 Comm: umount Tainted: G        W           6.17.0-rc5-xfstests-g9dd1835ecda5 #1 PREEMPT(none)
>>>>> Tainted: [W]=WARN
>>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>>>> RIP: 0010:f2fs_put_super+0x3b3/0x3c0
>>>>> Call Trace:
>>>>>    <TASK>
>>>>>    generic_shutdown_super+0x7e/0x190
>>>>>    kill_block_super+0x1a/0x40
>>>>>    kill_f2fs_super+0x9d/0x190
>>>>>    deactivate_locked_super+0x30/0xb0
>>>>>    cleanup_mnt+0xba/0x150
>>>>>    task_work_run+0x5c/0xa0
>>>>>    exit_to_user_mode_loop+0xb7/0xc0
>>>>>    do_syscall_64+0x1ae/0x1c0
>>>>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>    </TASK>
>>>>> ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> It appears that sometimes it is possible that f2fs_put_super() is called before
>>>>> all node page reads are completed.
>>>>> Adding a call to f2fs_wait_on_all_pages() for F2FS_RD_NODE fixes the problem.
>>>>>
>>>>> Fixes: bf22c3cc8ce7 ("f2fs: fix the panic in do_checkpoint()")
>>>>>
>>>>> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
>>>>> ---
>>>>>    fs/f2fs/super.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>>> index 1e0678e37a30..5c94bc42b8a1 100644
>>>>> --- a/fs/f2fs/super.c
>>>>> +++ b/fs/f2fs/super.c
>>>>> @@ -1976,6 +1976,7 @@ static void f2fs_put_super(struct super_block *sb)
>>>>>    	f2fs_flush_merged_writes(sbi);
>>>>>    	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);
>>>>> +	f2fs_wait_on_all_pages(sbi, F2FS_RD_NODE);
>>>>
>>>> Jan,
>>>>
>>>> At this stage, GC and checkpoint are both stopped, why there is still read
>>>> IOs on node page? Who is reading node page? Can you please dig more details
>>>> for this issue?
>>>
>>> We don't actually wait for completing read IOs. So, I think it doesn't matter
>>> the threads are stopped?
>>
>> Read on node page should be synchronous? so if the threads are stopped, there
>> should be no node IOs? Oh, Or there is still pending asynchronous readahead IO
>> on node page after all threads are stopped?
> 
> I remember we submit IOs and wait for its completion when we need by lock_page.

We also support readahead on page from meta_inode and common inode, so how about
waiting for all potential inflight read IOs?

In addtion, f2fs_wait_on_all_pages() is used for write path, how about simplifying
as below?

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4c7da160ca27..ea731f8bf19c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1983,6 +1983,12 @@ static void f2fs_put_super(struct super_block *sb)

  	f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA);

+	/* wait for potential inflight readahead IOs */
+	for (i = F2FS_RD_DATA; i <= F2FS_RD_META; i++) {
+		while (get_pages(sbi, i))
+			io_schedule_timeout(DEFAULT_IO_TIMEOUT);
+	}
+
  	if (err || f2fs_cp_error(sbi)) {
  		truncate_inode_pages_final(NODE_MAPPING(sbi));
  		truncate_inode_pages_final(META_MAPPING(sbi));
-- 
2.40.1

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>    	if (err || f2fs_cp_error(sbi)) {
>>>>>    		truncate_inode_pages_final(NODE_MAPPING(sbi));


