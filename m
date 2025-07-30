Return-Path: <linux-kernel+bounces-750583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBEFB15E62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE7C3B6098
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7938A2877D3;
	Wed, 30 Jul 2025 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LjeDBopw"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA0279783
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753872069; cv=none; b=AorRjiKEX+c2iFlMCGbKisInUnaT6jkwB9DhHFQTmYGj5wpR6OFJkA9SRuUS/AXdSmwbuLPyrD1Ho4Sqr/TfMJ899VRh8n2jtKZ5Eu4Bx1dS7zsm9xv/CTiA0k1oaunf39CT2PNmyqeU1F67g6khb54SKPcQVSyldot1yB+MmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753872069; c=relaxed/simple;
	bh=ouxioGDRPT52NeMWb4F/mLy3/3BPUtJTZZTZ6GXiJdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mH0DZtqLpdgweBhRhcgPL7VfQ46Cx1u1qGXjdLi/f63492VbMdDP2RaN2hYGLy9OJQZGIRTwTfPrHSntvTBOivVGkyGbUzeTcTlvJFwyKrsW49ekz8aE0QegVuRs2CVsX33+H2KlX6XgwEAaevBRp+FibxoVh+Ok7Eleg72RAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LjeDBopw; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1ccc327-5aa1-4b55-8bd3-f3b62223fa11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753872062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWK1hIvTx4YP/VUoLrHEYw/bN6uwNN9uQP8+O2ckOug=;
	b=LjeDBopwiqIFTQG8/oXwSjDGX9lFWZPGGY5KsnnHHL4Ww+42Q+tGIGGsfoCTJtMMJVXeLN
	pF/so4K2IipOjsEsjv1CZeWKutmckK343NJcGWqSvjGgRzO4Qg/f2HL4QwBOV2HHUWHNXS
	hXALR3T7YrOjgsbzCZsbpabkt6hJzZ0=
Date: Wed, 30 Jul 2025 18:40:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
 <npvzweqkpwqgcjzmb4h7ymp57m5kjrziwyl7pqeb2pgqeysbma@op25ggpv7ce5>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <npvzweqkpwqgcjzmb4h7ymp57m5kjrziwyl7pqeb2pgqeysbma@op25ggpv7ce5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/30 18:16, Sergey Senozhatsky wrote:
> On (25/07/30 17:36), Lance Yang wrote:
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
> 
> That's not what I proposed.  The suggestions here is to print only
> "is blocked likely owned by task cat:114" and do not append the
> backtrace of that cat:114, because it will be printed separately
> (since it's a blocked task).  But we should do so only if blocker
> is also blocked.  So the relation between T1 and T2 will still be
> exposed.

You're right, thanks for clarifying! I misunderstood the key detail :(

Thanks,
Lance


