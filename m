Return-Path: <linux-kernel+bounces-782915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6D6B326DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 06:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFBF7AB5E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 04:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8411F0E3E;
	Sat, 23 Aug 2025 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IgT8iM9x"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE01C8621
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 04:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755924512; cv=none; b=DLtou9dQyS4naVopWmSX+DWlbnlndK/z0tsyQ+ccNxNl5G47tvoxHutAf0MDPMmmko5z5QneKpiHckDsNI51THoOiQI/D5Myfrh58CPE4VzUwlE+RK47E/uUhPKJhsMRy3IH6OkZAAfgo+xyzFcmH2t1gR5kF9OlpMpnmvdYJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755924512; c=relaxed/simple;
	bh=YTygal563vIa8BBT4fhes3EZZbMXyy3wCtNeW8Kh1Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQzgaKgAuKD5Z1IdZynbp7rghjbeOPrcuCq/hbxW1+DuCJj1i1yF1Svmv88RM5cgqx4XJu4t3y+ITtNAHXGY/Q0qpoCd6Y48HrBgrxWLQ0JEcVvszQXzdSxjXONimKDl2qWnhgKgwQ6WTEqja8ZCrHkdKX30hQXHuVHuYdycYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IgT8iM9x; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755924507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rx1zRUogywbxWLbR+OhpeeJ+9zD0zkYG0vUZZmhs38=;
	b=IgT8iM9xBhNEdSP3/oO4BB+/GQhKvP1SlCFJ0EgX/4qLk0DkPQpC9lrNkz1U/Jjk58TXYd
	0TndKED8dRkL2id8BmXfD9ADsQhrlyYvdYzh1f4YdlQtmYMcKH5e1C3LEXtLHT3BW+0b6o
	YD4ckqV2M3lxG3qejP/YBcdE96vpvPk=
Date: Sat, 23 Aug 2025 12:47:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/3] hung_task: show the blocker task if the task is
 hung on semaphore
Content-Language: en-US
To: Finn Thain <fthain@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, mhiramat@kernel.org
Cc: akpm@linux-foundation.org, will@kernel.org, peterz@infradead.org,
 mingo@redhat.com, longman@redhat.com, anna.schumaker@oracle.com,
 boqun.feng@gmail.com, joel.granados@kernel.org, kent.overstreet@linux.dev,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 tfiga@chromium.org, amaindex@outlook.com, jstultz@google.com,
 Mingzhe Yang <mingzhe.yang@ly.com>, Eero Tamminen <oak@helsinkinet.fi>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Lance Yang <ioworker0@gmail.com>, senozhatsky@chromium.org
References: <20250414145945.84916-1-ioworker0@gmail.com>
 <20250414145945.84916-3-ioworker0@gmail.com>
 <CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com>
 <da53a828-137a-4efc-a192-a2b49a06d050@linux.dev>
 <CAMuHMdVTBSq2D+-rzGTr+Fz52sDFeeApUcG=LdDYBO5sY+rQxQ@mail.gmail.com>
 <d0fe3163-32d9-4d81-81bb-d964f2f43f17@linux.dev>
 <6ec95c3f-365b-e352-301b-94ab3d8af73c@linux-m68k.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <6ec95c3f-365b-e352-301b-94ab3d8af73c@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Finn,

On 2025/8/23 08:27, Finn Thain wrote:
> 
> On Sat, 23 Aug 2025, Lance Yang wrote:
> 
>>>
>>> include/linux/hung_task.h-/*
>>> include/linux/hung_task.h- * @blocker: Combines lock address and blocking type.
>>> include/linux/hung_task.h- *
>>> include/linux/hung_task.h- * Since lock pointers are at least 4-byte aligned(32-bit) or 8-byte
>>> include/linux/hung_task.h- * aligned(64-bit). This leaves the 2 least bits (LSBs) of the pointer
>>> include/linux/hung_task.h- * always zero. So we can use these bits to encode the specific blocking
>>> include/linux/hung_task.h- * type.
>>> include/linux/hung_task.h- *
> 
> That comment was introduced in commit e711faaafbe5 ("hung_task: replace
> blocker_mutex with encoded blocker"). It's wrong and should be fixed.

Right, the problematic assumption was introduced in that commit ;)

> 
>>> include/linux/hung_task.h- * Type encoding:
>>> include/linux/hung_task.h- * 00 - Blocked on mutex
>>>    (BLOCKER_TYPE_MUTEX)
>>> include/linux/hung_task.h- * 01 - Blocked on semaphore
>>>    (BLOCKER_TYPE_SEM)
>>> include/linux/hung_task.h- * 10 - Blocked on rw-semaphore as READER
>>>    (BLOCKER_TYPE_RWSEM_READER)
>>> include/linux/hung_task.h- * 11 - Blocked on rw-semaphore as WRITER
>>>    (BLOCKER_TYPE_RWSEM_WRITER)
>>> include/linux/hung_task.h- */
>>> include/linux/hung_task.h-#define BLOCKER_TYPE_MUTEX            0x00UL
>>> include/linux/hung_task.h-#define BLOCKER_TYPE_SEM              0x01UL
>>> include/linux/hung_task.h-#define BLOCKER_TYPE_RWSEM_READER     0x02UL
>>> include/linux/hung_task.h-#define BLOCKER_TYPE_RWSEM_WRITER     0x03UL
>>> include/linux/hung_task.h-
>>> include/linux/hung_task.h:#define BLOCKER_TYPE_MASK             0x03UL
>>>
>>> On m68k, the minimum alignment of int and larger is 2 bytes.
>>
>> Ah, thanks, that's good to know! It clearly explains why the
>> WARN_ON_ONCE() is triggering.
>>
>>> If you want to use the lowest 2 bits of a pointer for your own use,
>>> you must make sure data is sufficiently aligned.
>>
>> You're right. Apparently I missed that :(
>>
>> I'm wondering if there's a way to check an architecture's minimum
>> alignment at compile-time. If so, we could disable this feature on
>> architectures that don't guarantee 4-byte alignment.
>>
> 
> As Geert says, the compiler can give you all the bits you need, so you
> won't have to contort your algorithm to fit whatever free bits happen to
> be available. Please see for example, commit 258a980d1ec2 ("net: dst:
> Force 4-byte alignment of dst_metrics").

Yes, thanks, it's a helpful example!

I see your point that explicitly enforcing alignment is a very clean
solution for the lock structures supported by the blocker tracking
mechanism.

However, I'm thinking about the "principle of minimal impact" here.
Forcing alignment on the core lock types themselves — like struct
semaphore — feels like a broad change to fix an issue that's local to the
hung task detector :)

> 
>> If not, the fallback is to adjust the runtime checks.
>>
> 
> That would be a solution to a different problem.

For that reason, I would prefer to simply adjust the runtime checks within
the hung task detector. It feels like a more generic and self-contained
solution. It works out-of-the-box for the majority of architectures and
provides a safe fallback for those that aren't.

Happy to hear what you and others think about this trade-off. Perhaps
there's a perspective I'm missing ;)

Thanks,
Lance

