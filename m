Return-Path: <linux-kernel+bounces-750585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E41AB15E67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CD24E8302
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137628BA8C;
	Wed, 30 Jul 2025 10:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deeXBOSm"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CC271442
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872156; cv=none; b=lE/ynxGVA6pJmZdSSvGkp+30YuSu+/ekm8Y+wEh0ETlZyzvWPgsMedQZypDrKe+h0DgixvUI3zLSwERD+ixKjtTzl/jZVhyQ1RYJQVUS9enNFQ0DxdotUcq4h8ipzKRrS4eiX1ZSMhMXNJvLTdrJ3U5VSbIMxpXh3byyApcZdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872156; c=relaxed/simple;
	bh=mA07c7zOm5evdRA8P5fLOIWXI5kQHuCjIpvKdz0aXSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mGaaA2juqiQ/JTop6EatWYmXvKbeD6Y0d4SI9+ubzxiYwUvr9zN3bj3/LfampOvJuHIsSJXNZ58yXfFKUfqgqhX5FP3YzOa0JpsZOilk/8kbP4twZzT8CKwFOCtnFB1SG8AaOtjoxrUflwABmUMyGghkcA6OsjCK4P1vRycIZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=deeXBOSm; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c0a29513-dcc0-470d-b45c-5d2645e11a7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753872151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=npIa/BgRKsde2nmyZOMF6T9r7cGdg+XbGICUEGkEbzw=;
	b=deeXBOSmi04RrTKN55SHzsv+RJ2OYRipisfAvhGJM7RUcQ1NiPeq15cwX6HMr7bMIAfuA0
	Lgj403gCMYTlNEyMUT+cVUPipPlkwusRlc6pA9diGbJ9u43Fu8Fcpi4cx2/JHXsMoH/nNq
	0srrLGlOt+wDuZSAOFrNtqG9LfAkSbs=
Date: Wed, 30 Jul 2025 18:42:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
 Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
 <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
 <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
 <28364352-99b9-405f-831a-000ad090dd12@linux.dev>
 <20250730190100.64042746476687eae2eaa253@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250730190100.64042746476687eae2eaa253@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/30 18:01, Masami Hiramatsu (Google) wrote:
> On Wed, 30 Jul 2025 17:36:04 +0800
> Lance Yang <lance.yang@linux.dev> wrote:
> 
>>
>>
>> On 2025/7/30 16:51, Masami Hiramatsu (Google) wrote:
>>> On Wed, 30 Jul 2025 16:59:22 +0900
>>> Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>>>
>>>> One thing that gives me a bit of "inconvenience" is that in certain
>>>> cases this significantly increases the amount of stack traces to go
>>>> through.  A distilled real life example:
>>>> - task T1 acquires lock L1, attempts to acquire L2
>>>> - task T2 acquires lock L2, attempts to acquire L3
>>>> - task T3 acquires lock L3, attempts to acquire L1
>>>>
>>>> So we'd now see:
>>>> - a backtrace of T1, followed by a backtrace of T2 (owner of L2)
>>>> - a backtrace of T2, followed by a backtrace of T3 (owner of L3)
>>>> - a backtrace of T3, followed by a backtrace of T1 (owner of L1)
>>>>
>>>> Notice how each task is backtraced twice.  I wonder if it's worth it
>>>> to de-dup the backtraces.  E.g. in
>>>>
>>>> 	task cat:115 is blocked on a mutex likely owned by task cat:114
>>>>
>>>> if we know that cat:114 is also blocked on a lock, then we probably
>>>> can just say "is blocked on a mutex likely owned by task cat:114" and
>>>> continue iterating through tasks.  That "cat:114" will be backtraced
>>>> individually later, as it's also blocked on a lock, owned by another
>>>> task.
>>>>
>>>> Does this make any sense?
>>>
>>> Hrm, OK. So what about dump the blocker task only if that task is
>>> NOT blocked? (because if the task is blocked, it should be dumped
>>> afterwards (or already))
>>
>> Hmm... I'm concerned about a potential side effect of that logic.
>>
>> Consider a simple, non-circular blocking chain like T1 -> T2 -> T3.
>>
>> In this scenario, T1, T2, and T3 would all be dumped as hung tasks.
>> However, with the proposed rule (dump only if NOT blocked), when the
>> detector processes T1, it would see that its blocker (T2) is also
>> blocked and would therefore skip printing any blocker information about
>> T2.
>>
>> The key issue is that we would lose the crucial T1 -> T2 relationship
>> information from the log.
> 
> I just skip printing T2's stack dump, but still show "T1 is blocked by T2"
> so the relationship is still clear.

Ah, I see! That approach makes sense to me ;)


Thanks,
Lance


