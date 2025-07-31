Return-Path: <linux-kernel+bounces-751596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E7B16B56
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E343568527
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F94238C21;
	Thu, 31 Jul 2025 04:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uQWSMEx4"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F25C23B601
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753937133; cv=none; b=tXooZafY4ROZRtI/+VQgk3IBVp/l5gGXlCqlK6RihRrGLXhyzNvH7QGka4qTgiTET/74cQlUBKCpkBriz0lixvPhfJkgKlaFrHESld/S8HwNHeSmrUJYH9Fw+FvmtwYMfbhzK9qO/WXI/RipONT/MfiOOxbkhSSRRDudVshMqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753937133; c=relaxed/simple;
	bh=Xhm/zogzKFduolX5hF6WB1DtBaAhzXMfb09rTK3B8ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gu5ME//F7Hc4LRuARiB1+/MWHEtipIqBBoQglLLEOSQE2e47c95DFGyrbNDVGrOCOjd1yZL6FSn+wnG1473jjDWgBejZa3xEGZxbkWxqPdCc8F/XpGl0HrR1ueI4Sa7pcyVZNJGvx6Pna929Ch7yeyYfZyx7mK097vlJ8YaET+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uQWSMEx4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d63b51f2-7c63-49ff-8dfe-f92a60db7c19@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753937127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GuYilt9iMvAMXVpxIhvpqryGMunfFXXWi/rj5lQQ9U=;
	b=uQWSMEx4T7bKu0KX+Qme5tr4Y2vMVosfSfCHPS/EdlHvNUY4Olr5j8odgPHieU/RDphF4y
	VdO+8AfeEyR7KnPIlhfp3OBHwcglBNWnXculEQM474bBs7OB027RxKV7fR3b2FZPDYcjFC
	jHDCTYnRl2fB2U4xTnm6jzT8gFcHcRI=
Date: Thu, 31 Jul 2025 12:45:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] hung_task: Dump blocker task if it is not hung
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
References: <175391351423.688839.11917911323784986774.stgit@devnote2>
 <reyd4bppb5tfon7gtqaelwknvptdeyhrsh5ijbcj77ezini3yq@ivkgxmiqzk3x>
 <e34a1a00-1728-4cf9-ad30-d8a7098b8876@linux.dev>
 <4c227812-23ef-4fe8-9bf1-cc4966fd31ac@linux.dev>
 <l27knfwpljnsgwvc47ifxtrwtuwaireojejiozjioqab5va65l@vrkuak2n3hll>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <l27knfwpljnsgwvc47ifxtrwtuwaireojejiozjioqab5va65l@vrkuak2n3hll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/7/31 11:37, Sergey Senozhatsky wrote:
> On (25/07/31 11:25), Lance Yang wrote:
>>>> Wrote a simple 3 tasks circular lock test (same that I had in real
>>>> life).  The output looks good:
>>>
>>> Nice work! The log is now much clearer ;)
>>
>> Forgot to add:
>>
>> This circular lock test is great. It would be very valuable to have
>> it in samples/hung_task ;)
>>
>> Would you be willing to submit it as a patch?
> 
> Well, that particular test is a deadlock, not sure how useful a test
> that deadlocks is going to be.  We probably need some alternative if
> we want to test backtrace de-dup.

Yep, you're right. A permanent deadlock is a no-go for a reusable test.

Maybe we need a test like a blocker chain (T1->T2->T3), where T3 holds
the lock and just sleeps for a while. Once it wakes up and releases the
lock, everything can finish cleanly.

Also, I might try to cook up a sample for that, time permitting ;)


