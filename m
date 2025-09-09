Return-Path: <linux-kernel+bounces-807012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EEB49EE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2400C189A0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18223BD1B;
	Tue,  9 Sep 2025 01:58:03 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5592101DE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383083; cv=none; b=V2JGTGbrr9gZ0Xjah7RtmCzdq/eZm3ecK/lwHxjcBcplKlfpEB1Rnb4tZfEj4HuZ/q8yvCXvu7LD80R2Yd7o85eWMlQ/8mchviGIoxjWU8zPq1prVog3GLjja7XtYyL+T8UwNRaSEqYeHr0+C4ZYYLZnpapvtF8RD4sMdCVNn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383083; c=relaxed/simple;
	bh=fpqBvIPfI1z4gYC0+ewNa/wSPfUsoJWXYTNxV6tdyoo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YPaPmrH4L7q6EBetKMVCwto+W6YZpWcZdevJC/v07PP7uETQfDjxd5TqDFsSJC65Qnpw9i0E4/Bru921BQQ3BDC7bamwzi1LE/i1JNzsmq710xVsbM07DoqipnJDf1+Fz12aCNnWgPtidFqh3IoiuAbTQDz1kYMwQJ5Pha6oTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from wmail1.cc.ntu.edu.tw (wmail1.cc.ntu.edu.tw [140.112.2.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 65F9C33FA3;
	Tue,  9 Sep 2025 09:57:56 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 09 Sep 2025 09:57:56 +0800
From: Bill Tsui <b10902118@ntu.edu.tw>
To: Will Deacon <will@kernel.org>
Cc: oleg@redhat.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: ptrace: fix hw_break_set() by setting addr
 and ctrl together
In-Reply-To: <aL7y00ggniiCTpZS@willie-the-truck>
References: <20250824124317.390795-1-b10902118@ntu.edu.tw>
 <20250827014113.5852-1-b10902118@ntu.edu.tw>
 <20250827014113.5852-2-b10902118@ntu.edu.tw>
 <aL7y00ggniiCTpZS@willie-the-truck>
User-Agent: Roundcube Webmail/1.4
Message-ID: <dcb568c3dd5feb15890fa75e988e33bb@ntu.edu.tw>
X-Sender: b10902118@ntu.edu.tw
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-08 23:14, Will Deacon wrote:
> On Wed, Aug 27, 2025 at 09:41:11AM +0800, Bill Tsui wrote:
>> PTRACE_SETREGSET fails when setting a hardware breakpoint on a
>> non-4-byte aligned address with a valid length to a 32-bit tracee. The
>> length should be valid as long as the range started from the address
>> is within one aligned 4 bytes.
>> 
>> The cause is that hw_break_set() modifies a breakpoint's addr
>> first and then ctrl. This calls modify_user_hw_breakpoint() twice,
>> although once registering both suffices. The first modification causes
>> errors because new addr and old ctrl can be an invalid combination at
>> hw_breakpoint_arch_parse(). For example, when a user sets a hardware
>> breakpoint with addr=0x2 and ctrl.len=1, hw_breakpoint_arch_parse()
>> will first see addr=0x2 and ctrl.len=4 (the default) and return
>> -EINVAL. On the other hand, if a user sets the same value to
>> a breakpoint whose ctrl.len has previously been set to 1 or 2,
>> it succeeds.
>> 
>> The fix is to set addr and ctrl in one modify_user_hw_breakpoint(),
>> effectively eliminating the discrepancy in validation.
>> 
>> Signed-off-by: Bill Tsui <b10902118@ntu.edu.tw>
>> ---
>>  arch/arm64/kernel/ptrace.c | 34 +++++++++++++++++++++++++++++-----
>>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> Given that:
> 
>   (a) This is a pretty niche interface (primarily/exclusively (?) used
>       by GDB)
>   (b) It's been like this for a long time
>   (c) Userspace can work around the problem
> 
> I'm not sure I see the benefit of trying to handle this differently
> in the kernel.
> 
> If somebody _does_ have the time and energy for significant surgery
> on this code, then the best thing to do would be to remove the
> indirection through 'perf_events' altogether. I did make a start on
> that once but it's a thankless job and I got preempted by other stuff.
> 
> Will
(Fixed email name with real name. Sorry again.)

Thanks for the reply. I did find this bug when helping test lldb.

The primary problem is that this forbids hardware breakpoints for Thumb 
at
addresses only divisible by 2 (not 4). So half of the instructions 
cannot have
a hardware breakpoint on. This cannot be worked around.

The first patch should be accepted, at least. The arm64 case can be 
completely
fixed by simply merging modifications in one call, making the code 
reasonable
and correct.

I often debug 32bit executables on arm64, for CTF challenges and my 
hobby. I
get extremely confused when some breakpoints just cannot be set. This is 
also
why I worked on lldb and finally traced to the kernel. As a student, I 
am willing
to take the task of moving ptrace out of 'perf_events' as long as 
someone can
review my patches.

Thanks
Bill

