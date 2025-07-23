Return-Path: <linux-kernel+bounces-742167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D54B0EE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EC91C27934
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52E2E36FA;
	Wed, 23 Jul 2025 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Rv+Wuc56"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D9182D3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262189; cv=none; b=rRPj0sNLu21WeXRNYQAbBiZywVUxy8ifkARPfW53KvrKbYRJWWWmskFxUYXtBsnFb6PrpCcKQg9e1D9xCEMqtFskZpNSSKZga6PW4NuYmHY3KiFC2QfBJ/G1CrRjBbFxk10bt+aHvpnSdiJEmU1BPX/lnStEr5yiift3pD8udlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262189; c=relaxed/simple;
	bh=667QNfxQTGuB7L2EIKf6avEw3Wnj/9gWKZ8FW7o2iOs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nNaHYqwzXpoy5gWcz0ogXosrVhQuOoJdsdWySH5JcuvgB6hoyFI3UwrYbofgPPkIX56nq/6NBVhNBfKO+e8V49w8Bm6HsmaNGt3AYsESHR02CUHIFf2LfdRSUD2oAcEU3OzYpxKp8tDoL081M95om5c8S7sFdQRqFb5bSankv+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Rv+Wuc56; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=KfmIGalj8HpP9qPJNlYe/A5JdLaudkbT95VyHLqIUDk=;
	b=Rv+Wuc56ztzb31Dd43khMV2ID4Z/PK+JTzL+s0RycDbhKOp3Wxrp4OpyNQmSI6
	57ZXhuWShkP8SVzuSrAVa3jxkyLKijznWnx5Qxr+Ovm9VuyKXFpsaIrpilwqKM91
	MaxKngNic/o/xfNzcZcarHLReLpDQ6OrCE/PivkZ5GLzY=
Received: from [192.168.22.151] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBH737sp4BouccnGw--.323S2;
	Wed, 23 Jul 2025 17:14:28 +0800 (CST)
Message-ID: <270d8240-fb64-46e0-a534-80790c4cc905@163.com>
Date: Wed, 23 Jul 2025 17:14:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
From: Xuanye Liu <liuqiye2025@163.com>
To: David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
 <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
 <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
 <8dd1e8f6-f96d-4d36-ac2a-c258ac842f75@redhat.com>
 <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
Content-Language: en-US
In-Reply-To: <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH737sp4BouccnGw--.323S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr18Xr1xWr4fAF17uw45Wrg_yoW8tF1kpF
	1rKan0gr4kJryftrn2v3W0yr15trZ7G3y5W3s5W347Gr90qFy8Xr4xKF4UCFyjkr9Yka9F
	vr4jgF9ruFZ0vaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jodgAUUUUU=
X-CM-SenderInfo: 5olx1xd1hsijqv6rljoofrz/1tbibhOTUGiAnoznpgAAsF


在 2025/7/23 17:10, Xuanye Liu 写道:
> 在 2025/7/23 16:42, David Hildenbrand 写道:
>> On 23.07.25 10:05, David Hildenbrand wrote:
>>> On 23.07.25 09:45, Xuanye Liu wrote:
>>>> 在 2025/7/23 15:31, Kees Cook 写道:
>>>>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>>>>>> The check_mm() function verifies the correctness of rss counters in
>>>>>> struct mm_struct. Currently, it only prints an alert when a bad
>>>>>> rss-counter state is detected, but lacks sufficient context for
>>>>>> debugging.
>>>>>>
>>>>>> This patch adds a dump_stack() call to provide a stack trace when
>>>>>> the rss-counter state is invalid. This helps developers identify
>>>>>> where the corrupted mm_struct is being checked and trace the
>>>>>> underlying cause of the inconsistency.
>>>>> Why not just convert the pr_alert to a WARN?
>>>> Good idea! I'll gather more feedback from others and then update to v2.
>>> Makes sense to me.
>> After discussion this with Lorenzo off-list, isn't the stack completely misleading/useless in that case?
>>
>> Whatever caused the RSS counter mismatch (e.g., unmapped the wrong pages, missed to unmap pages) quite possibly happened in different context, way way earlier.
>>
>> Why would you think the stack trace would be of any value when destroying an MM (__mmdrop)?
>>
>> Having that said, I really hate these "pr_*("BUG: ...") with passion. Probably we'd want to invoke the panic_on_warn machinery, because something unexpected happened.
>>
> The stack trace dumped here may indeed not reflect the root cause ——
> the actual error could have occurred much earlier, for example during a
> failed or missing page map/unmap operation.
> The current stack (e.g., in __mmdrop() or exit_mmap()) is merely part
> of the cleanup phase.

Dumping the stack still has some chance of helping identify the issue — at the very least, it
shows which task triggered the check.                                                       

>
> Given that, how should we go about identifying the root cause when such an issue occurs?
>
> Is there any existing way to trace it more effectively, or could we introduce a new mechanism
> to monitor and detect these inconsistencies earlier?                                         
>
> Let’s brainstorm possible solutions together.
>
-- 
Thanks,
Xuanye


