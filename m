Return-Path: <linux-kernel+bounces-611442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BB5A941F8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 08:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5991898670
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 06:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBE118FC74;
	Sat, 19 Apr 2025 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jpWO06uP"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5C2C190
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745045085; cv=none; b=ruJcYKKkoxuqcYXiR+KpeS+U7/fkMGyyYM27i4HuuZhMiv5TxQoNrReeDlXM6qSte+42NqFmuD6gyszf9UImfH+2EtmI3KUEA+Jol12hbF6XnDwnjK3FAwIwrYAYyIg8uQABD4yrBKwrGrW6O+ReLhKG7AMIGRi9oZKCNQZVo+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745045085; c=relaxed/simple;
	bh=f/wUfOx93l3R/ve9eoN8A0lUZqgqMMvyIXEZA4V9Kik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHJC+Y2fh2PpyOXzJVcnnNaUWQTCDU5d5kpoJ0g7VfnWg0W/EX1ZejFI6UMYphbg0tHELxV/3KXgmRSc4m7ZqD9U2yZsWtjcjuMqBApeivkLs5sVKJ0dPg50wt5yD6bZRPMuKvtnBEc48eosUJ4d8Jn8RLF/uhWnhs6dlEIMpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jpWO06uP; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ca8fd94-da46-40ad-8ced-31fe033ee100@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745045079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8BRY2zacbXxHIh4qRZFRRrjEw4oANmnG8Oe151M0EY=;
	b=jpWO06uPRYMJSoqh7zR7KHARG/+pqiE75E6TeMgLuT+dU8oQ2t6PF39qgYzf2/wLIwbdpF
	ACIVnC06GgiZKtenEsjHo+J0HkOud4Zz+ArxP5uKXc1Xct3L0ZjGn+HXFSMMNW/QXPJ7z4
	ViLjTX6uevrQ3Qck1cb5mHaA0tphYaU=
Date: Sat, 19 Apr 2025 08:44:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Remove unused rxe_run_task
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250418165948.241433-1-linux@treblig.org>
 <bf07ce66-32e8-4069-894a-7eff120a07ff@linux.dev> <aALsrZxAqhwxDD7d@gallifrey>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <aALsrZxAqhwxDD7d@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/19 2:22, Dr. David Alan Gilbert 写道:
> 
> Hi,
> 
>> Thanks a lot. Please add the Fixes tags.
>> Fixes: 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")
> 
> Thanks for the review;  I've tended to avoid the fixes tag because
> people use 'Fixes' to automatically pull in patches to stable or
> downstream kernels, and there is no need for them to do that for
> a cleanup patch.
> 
>> And in the following comments, the function rxe_run_task is still mentioned.
>> "
>>   86 /* do_task is a wrapper for the three tasks (requester,
>>   87  * completer, responder) and calls them in a loop until
>>   88  * they return a non-zero value. It is called either
>>   89  * directly by rxe_run_task or indirectly if rxe_sched_task
>>   90  * schedules the task. They must call __reserve_if_idle to
>>   91  * move the task to busy before calling or scheduling.
>>   92  * The task can also be moved to drained or invalid
>>   93  * by calls to rxe_cleanup_task or rxe_disable_task.
>>   94  * In that case tasks which get here are not executed but
>>   95  * just flushed. The tasks are designed to look to see if
>>   96  * there is work to do and then do part of it before returning
>>   97  * here with a return value of zero until all the work
>>   98  * has been consumed then it returns a non-zero value.
>>   99  * The number of times the task can be run is limited by
>> 100  * max iterations so one task cannot hold the cpu forever.
>> 101  * If the limit is hit and work remains the task is rescheduled.
>> 102  */
>> "
>> Not sure if you like to modify the above comments to remove rxe_run_task or
>> not.
> 
> Would it be correct to just reword:
>>   88  *                               It is called either
>>   89  * directly by rxe_run_task or indirectly if rxe_sched_task
>>   90  * schedules the task.
> 
> to:
>     It is called indirectly when rxe_sched_task schedules the task.

I am fine with it. Thanks a lot.

Zhu Yanjun

> 
>> Except the above, I am fine with this commit.
> 
> Thanks!
> 
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Dave
> 

