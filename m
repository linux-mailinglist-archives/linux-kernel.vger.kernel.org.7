Return-Path: <linux-kernel+bounces-742164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B6B0EE25
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2007F5682C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F362857E9;
	Wed, 23 Jul 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ozY1M+gW"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADD284B25
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261911; cv=none; b=ZMLDM25xfm0+h3T442cPXsvBEHVmOBnoBmUCgOJD86duIMPnZdjpGDW/6U6ZmlX1Q+I2UY7xcdRhhtcHcneGnvirKIT+nfbVBDG4FQ6FJyG9Jq6UP7w0U+zt6eS7W5Ookcz1lHklPsYS7o8sw6xrdYL4lEXo/ZP8GXOv6Ozq9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261911; c=relaxed/simple;
	bh=OqOxpnrWDk4SXpOuDqY33UWW77OOcRnobJwbaevCgKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShGeRb2CY8W3m24qbw6jP9kp2SvDCdJiQ1/XQNtK1NhfwG6x5P1bPKJ/QIULFo6OyS3TcxLpN2H84oBvVogIZjgzYVNhW+3jVeOV1Jc0G/uVOrH1ibZaOWPOWS9LYJ/cFH3qc9hb/0pc7i7IdDz/YpwCnR3AGbsofAJZvhJu36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ozY1M+gW; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6y3noge4MPktXIThvqTt61WWdx+cI0v3XW84889Wcek=;
	b=ozY1M+gWZSKJxwvpVf7EFQKX9iJFlyU/BLza4jRksH84zYkkesidqJIcWlCGdZ
	5M3EodbTtmx45ahKPa7hNLimy3eZnc4kX2E7owhUb/IyxjFVhaxPmnHCCOhF8j93
	d/KchzBTfeBg50B55kOugp+elbxE0Bysw0i8vU8e5XgH8=
Received: from [192.168.22.151] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3u98Hp4BoV+L_Gg--.6882S2;
	Wed, 23 Jul 2025 17:10:38 +0800 (CST)
Message-ID: <5cdd3e44-3e3c-4697-905a-ecc61093f7bc@163.com>
Date: Wed, 23 Jul 2025 17:10:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
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
Content-Language: en-US
From: Xuanye Liu <liuqiye2025@163.com>
In-Reply-To: <8dd1e8f6-f96d-4d36-ac2a-c258ac842f75@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3u98Hp4BoV+L_Gg--.6882S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWxtFWkur13Cr45KF4fAFb_yoW8ZFWfpr
	4xKFsIgr4kJrWftrn2vw40yF15t397Gw15W3s8W347GF90qFy8XF4xtF4UCFyjyr95Ka92
	vr4jqF9rCa909FJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jr2-nUUUUU=
X-CM-SenderInfo: 5olx1xd1hsijqv6rljoofrz/1tbiRwSTUGiAkoh+YwACst


在 2025/7/23 16:42, David Hildenbrand 写道:
> On 23.07.25 10:05, David Hildenbrand wrote:
>> On 23.07.25 09:45, Xuanye Liu wrote:
>>>
>>> 在 2025/7/23 15:31, Kees Cook 写道:
>>>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>>>>> The check_mm() function verifies the correctness of rss counters in
>>>>> struct mm_struct. Currently, it only prints an alert when a bad
>>>>> rss-counter state is detected, but lacks sufficient context for
>>>>> debugging.
>>>>>
>>>>> This patch adds a dump_stack() call to provide a stack trace when
>>>>> the rss-counter state is invalid. This helps developers identify
>>>>> where the corrupted mm_struct is being checked and trace the
>>>>> underlying cause of the inconsistency.
>>>> Why not just convert the pr_alert to a WARN?
>>> Good idea! I'll gather more feedback from others and then update to v2.
>>
>> Makes sense to me.
>
> After discussion this with Lorenzo off-list, isn't the stack completely misleading/useless in that case?
>
> Whatever caused the RSS counter mismatch (e.g., unmapped the wrong pages, missed to unmap pages) quite possibly happened in different context, way way earlier.
>
> Why would you think the stack trace would be of any value when destroying an MM (__mmdrop)?
>
> Having that said, I really hate these "pr_*("BUG: ...") with passion. Probably we'd want to invoke the panic_on_warn machinery, because something unexpected happened.
>
The stack trace dumped here may indeed not reflect the root cause ——
the actual error could have occurred much earlier, for example during a
failed or missing page map/unmap operation.
The current stack (e.g., in __mmdrop() or exit_mmap()) is merely part
of the cleanup phase.

Given that, how should we go about identifying the root cause when such an issue occurs?

Is there any existing way to trace it more effectively, or could we introduce a new mechanism
to monitor and detect these inconsistencies earlier?                                         

Let’s brainstorm possible solutions together.

-- 
Thanks,
Xuanye


