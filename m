Return-Path: <linux-kernel+bounces-744323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7DB10AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FAA587AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A52D5419;
	Thu, 24 Jul 2025 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiDFtDhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5F2D4B7F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362583; cv=none; b=BvtLaoEfx4g89ywogLTw3HORFbbGXGQXfUpeClRcnJ5QwA7hF++bODR6QBzEAf9IJmGyilO8Bj/WknDROocSSz/hoooEHrYObYIBeyvcWWzosUfvdRsnihpCmENnL4zHShD+wodL8EBjd0v7+sha+JKsZYwUpTn44VsJbBoshks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362583; c=relaxed/simple;
	bh=IXt/noFSvrehS4Utza8A0lxjekW096nkpDvGqnkMVEE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LaTSzcEbDZtpg+tSCalqMFmaHe0qw2GoBM3RB/HZ2408Du+ZrhWTt7Wt0eG6YaHzPV9EXnAxpCC+DhkC/vkYAjor1dLoYLJ+Xwz2JVUs+JdXKtIsy2UzFPbPmfeLOSJeym3agBJzfwafJOiykvh9gE5QgG7mIRAXXAdMoAvrbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiDFtDhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC60C4CEED;
	Thu, 24 Jul 2025 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362582;
	bh=IXt/noFSvrehS4Utza8A0lxjekW096nkpDvGqnkMVEE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UiDFtDhzzEtBEcXuZOzTeJ+Vu1R5i/Q8vHHpUulgV+ZFLFFAMefqEsGzap70+uHO+
	 W31aJlUmfIVwKVVfa6vbYng64I08molTv+IfGE/VRryj0rHE8yw3Z8cYtgpzLwsI+0
	 /a8/nh/iIUR6mFhu9s5Jw6afj6fKdcFbDPD70V5lrUA5XZwSZBCa6gZ83YRd8xUF6z
	 lG9sxsH+QgUuEpGjtiNaQf4++JkwZbixfAfNToxwEtZd3Hjkg5wBhGoxatxErT9OzT
	 wtNiVxm7WNKwMNxV9MdxcxejGgkovaKqeIl9cceV5Z7aZ0QTCxifxDnn/LbU+3Aqtm
	 fr9MohyMw49eg==
Message-ID: <d5355d7d-4e93-4741-9ef7-c7407d600ec0@kernel.org>
Date: Thu, 24 Jul 2025 21:09:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O
To: hanqi <hanqi@vivo.com>, Jens Axboe <axboe@kernel.dk>, jaegeuk@kernel.org
References: <20250715031054.14404-1-hanqi@vivo.com>
 <056e083b-8e41-45a2-9b0f-2ec47d1a9f71@kernel.dk>
 <f7408161-eaef-47ed-8810-8c4e8f27bfc6@vivo.com>
 <51168786-6c30-4065-be82-6d07b2ae74a8@kernel.dk>
 <4366bf0f-64a1-44ae-8f81-301af2d179d8@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <4366bf0f-64a1-44ae-8f81-301af2d179d8@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/7/16 16:27, hanqi wrote:
> 
> 
> 在 2025/7/16 11:43, Jens Axboe 写道:
>> On 7/15/25 9:34 PM, hanqi wrote:
>>>
>>> ? 2025/7/15 22:28, Jens Axboe ??:
>>>> On 7/14/25 9:10 PM, Qi Han wrote:
>>>>> Jens has already completed the development of uncached buffered I/O
>>>>> in git [1], and in f2fs, the feature can be enabled simply by setting
>>>>> the FOP_DONTCACHE flag in f2fs_file_operations.
>>>> You need to ensure that for any DONTCACHE IO that the completion is
>>>> routed via non-irq context, if applicable. I didn't verify that this is
>>>> the case for f2fs. Generally you can deduce this as well through
>>>> testing, I'd say the following cases would be interesting to test:
>>>>
>>>> 1) Normal DONTCACHE buffered read
>>>> 2) Overwrite DONTCACHE buffered write
>>>> 3) Append DONTCACHE buffered write
>>>>
>>>> Test those with DEBUG_ATOMIC_SLEEP set in your config, and it that
>>>> doesn't complain, that's a great start.
>>>>
>>>> For the above test cases as well, verify that page cache doesn't grow as
>>>> IO is performed. A bit is fine for things like meta data, but generally
>>>> you want to see it remain basically flat in terms of page cache usage.
>>>>
>>>> Maybe this is all fine, like I said I didn't verify. Just mentioning it
>>>> for completeness sake.
>>> Hi, Jens
>>> Thanks for your suggestion. As I mentioned earlier in [1], in f2fs,
>>> the regular buffered write path invokes folio_end_writeback from a
>>> softirq context. Therefore, it seems that f2fs may not be suitable
>>> for DONTCACHE I/O writes.
>>>
>>> I?d like to ask a question: why is DONTCACHE I/O write restricted to
>>> non-interrupt context only? Is it because dropping the page might be
>>> too time-consuming to be done safely in interrupt context? This might
>>> be a naive question, but I?d really appreciate your clarification.
>>> Thanks in advance.
>> Because (as of right now, at least) the code doing the invalidation
>> needs process context. There are various reasons for this, which you'll
>> see if you follow the path off folio_end_writeback() ->
>> filemap_end_dropbehind_write() -> filemap_end_dropbehind() ->
>> folio_unmap_invalidate(). unmap_mapping_folio() is one case, and while
>> that may be doable, the inode i_lock is not IRQ safe.
>>
>> Most file systems have a need to punt some writeback completions to
>> non-irq context, eg for file extending etc. Hence for most file systems,
>> the dontcache case just becomes another case that needs to go through
>> that path.
>>
>> It'd certainly be possible to improve upon this, for example by having
>> an opportunistic dontcache unmap from IRQ/soft-irq context, and then
>> punting to a workqueue if that doesn't pan out. But this doesn't exist
>> as of yet, hence the need for the workqueue punt.

Thanks Jens for the detailed explanation.

> 
> Hi, Jens
> Thank you for your response. I tested uncached buffer I/O reads with
> a 50GB dataset on a local F2FS filesystem, and the page cache size
> only increased slightly, which I believe aligns with expectations.
> After clearing the page cache, the page cache size returned to its
> initial state. The test results are as follows:
> 
> stat 50G.txt
>     File: 50G.txt
>     Size: 53687091200      Blocks: 104960712       IO Blocks: 512  regular file
> 
> [read before]:
> echo 3 > /proc/sys/vm/drop_caches
> 01:48:17        kbmemfree kbavail     kbmemused  %memused      kbbuffers kbcached   kbcommit     %commit   kbactive    kbinact     kbdirty
> 01:50:59      6404648   8149508   2719384   23.40     512     1898092   199384760    823.75   1846756    466832     44
> 
> ./uncached_io_test 8192 1 1 50G.txt
> Starting 1 threads
> reading bs 8192, uncached 1
>     1s: 754MB/sec, MB=754
>     ...
>    64s: 844MB/sec, MB=262144
> 
> [read after]:
> 01:52:33      6326664   8121240   2747968    23.65      728     1947656   199384788    823.75   1887896    502004     68
> echo 3 > /proc/sys/vm/drop_caches
> 01:53:11      6351136   8096936   2772400   23.86     512     1900500   199385216    823.75   1847252    533768      104
> 
> Hi Chao,
> Given that F2FS currently calls folio_end_writeback in the softirq
> context for normal write scenarios, could we first support uncached
> buffer I/O reads? For normal uncached buffer I/O writes, would it be
> feasible for F2FS to introduce an asynchronous workqueue to handle the
> page drop operation in the future? What are your thoughts on this?

Qi,

Sorry for the delay.

I think it will be good to support uncached buffered I/O in read path
first, and then let's take a look what we can do for write path, anyway,
let's do this step by step.

Can you please update the patch?
- support read path only
- include test data in commit message

> Thank you!
> 
> 


