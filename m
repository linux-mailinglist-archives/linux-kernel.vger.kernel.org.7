Return-Path: <linux-kernel+bounces-852104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FEBBD82BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC9434F8A56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5830F940;
	Tue, 14 Oct 2025 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fy7NbVJG"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18CE30F95E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430431; cv=none; b=bhBTYVooP2DrJcH2pQ0xOQ+gQLJ2IKmofZBcG4RLFcRE5AQ940hkwxLV6dUl4s0faIYJu/MjyK3e0cb8Tvcj/vX08YpNnETbV9SNAGFrt8Sgi3M9y96PN5HyxcKUtKUN1Yc4XAW43yIk4iQtUEfC86IonyQyIj+S0GQhFZMV3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430431; c=relaxed/simple;
	bh=5WhqHunvbBpwbFTh48ZwaryVHrwZ3m6K6xFb15WaQCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/6a8XPkCJ6tMdOqeL+WPD/M2cS9KyUL9WR8+SxnJmKkqqL5jh/GrYSnUoAChnuVtTSrk3lnPnE2Y4OX3QQiHUQNbbbm8J0soaQOwcQ7pJM9YCJdASt+rPTpg0npiIrLxuPuV3hKItGhoZAyGxiPhG9j9KvJP/XmJlNoSpEN4ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fy7NbVJG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4a911279-5e95-499d-a188-dab72d75b6b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760430426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oOL3kdYYlknYR47TEXFdShOrQCn0oEFnG9MAYkawAg=;
	b=Fy7NbVJGzcvQp5AxZL9wsPPbNvhZ6Cv2KBbR1jXxS+80Ht4gbiS+kPd6pTdFaKtAiqqKI+
	MPLbmQ4tferMUufytYuujs6TT2k7skGYz4nBWKtog3AHoA7CXk9tQcHO2g5UXEt9w+CkEX
	2KwX3rMtkFa58wxX5TBsLlnCfWOq3Wc=
Date: Tue, 14 Oct 2025 16:26:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC RFC PATCH] mm: convert VM flags from macros to enum
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ye Liu <liuye@kylinos.cn>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251011093054.886460-1-ye.liu@linux.dev>
 <809f552d-3282-4746-ba49-066d2bd8d44f@lucifer.local>
 <7ca0960f-9d1a-4ba4-b074-a6502578b82e@redhat.com>
 <d619784b-b967-4795-aad9-6e79d4191b83@lucifer.local>
 <dfc18351-bb77-4099-bcdd-eb2bd4f1bea5@redhat.com>
 <fa2d7db5-688c-4d04-abcd-a60f79a6bb7a@lucifer.local>
 <71803dce-3fa6-494c-a4b1-55d98fc4aadb@suse.cz>
 <bb9cd331-326f-4ddb-8848-60195e41f012@lucifer.local>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <bb9cd331-326f-4ddb-8848-60195e41f012@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2025/10/13 21:19, Lorenzo Stoakes 写道:
> On Mon, Oct 13, 2025 at 03:07:18PM +0200, Vlastimil Babka wrote:
>> On 10/13/25 14:57, Lorenzo Stoakes wrote:
>>> FOLL_* flags are an anonymous enum, enum fault_flag is not used as a type
>>> anywhere, nor is vm_fault_reason. So those are both kinda weird as to why we
>>> even name the type (they're in effect anonymous).
>>>
>>> But also 'we do X in the kernel' doesn't mean doing X is right :)
>>
>> I think the example to follow could be GFP flags. Nowadays there's an enum
>> below it, and a layer that adds (__force gfp_t), so you could do similar
>> thing with vm_flags_t.
>>
>> However I'm not sure how compatible is that with Lorenzo's plans.
> 
> That's defining bit values in an anonymous enum so isn't really comparable.
> 
> But what it's doing, ultimately, in broad terms (other than the opaque bitmap
> type I'll be using for VMA flags) is what my changes will do.
> 
> And yeah, trying to do duplicate that is not really a good use of time and will
> conflict with my work.
> 
> Overall I think this change is generally unnecessary given that I'm about to
> radically alter how VMA flags are implemented, and actually will cause me
> problems.
> 
> But as I said before, I'm happy to prioritise the change that specifies the
> flags based on the bit numbers, I actually have it ready more-or-less.
> 

Thanks for the input, everyone.

Lorenzo, I agree with your assessment.
I'll pause on this from my side and wait for your patch.
I'm excited to see the new implementation.

> Cheers, Lorenzo

-- 
Thanks,
Ye Liu


