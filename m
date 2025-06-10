Return-Path: <linux-kernel+bounces-680120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A6CAD40E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0115D7A9348
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D441241676;
	Tue, 10 Jun 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="flmXs/dX"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB6C1F4CB7
	for <linux-kernel@vger.kernel.org>; Tue, 10 Jun 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576954; cv=none; b=MBgm2SoVVpxRPZuqfjcgQESPZbd+xwe77ZXIKcppgLpTsSjwUUt1aLY3uA5Pdvv/eo59bzj8NnyF8qgGIBLvN+k67wfIYenvqCvqHKdw1j31fqScYxLdEzOYO+fNcQK7+kaeiDRHa8kb9o1O8O8xnHeLZ2rCyBObj60xs0rFH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576954; c=relaxed/simple;
	bh=YWMs+H1R1avtUz7Zxo5I8qnCe4kbf3dkkem3H/EZHXQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LBvpTJLZeS+sQOixM6MM0f//1RpreKkBDebvSypJ3FmtfDRrEHChOqGbOQ/8QD0B23LjYrxJi7el/NANoKpeHtEbSkZ1MspCTRaIw5h/9UHL7KAoECYJE8hP1K5GTl4QTB2NBPCgrej+9r0emFO1C48So1mVg8xJP4GkoqnEjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=flmXs/dX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.129.218] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEA0B2078629;
	Tue, 10 Jun 2025 10:35:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEA0B2078629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749576952;
	bh=umcZeKbZ0X54bScCEOCTXGAU3+QgdJ62r0B59TeumYk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=flmXs/dXHK/B+qHt9LU9IhLoj3HuHe0sBJ/1ZbNarOMnqmasmi4QVMbJMA501IsBe
	 GAwrz/bY9lYDN9HWZbrW0IAehElO8J+hWCDKUk34bWlkErk6FnklvC7bdpMI7iz/Cc
	 F2allUsgFGgTI1sMgi7uThujt4wfIMzd8Rrbr8/k=
Message-ID: <588d5a4b-72cf-4d2c-8eee-c4240ae067b5@linux.microsoft.com>
Date: Tue, 10 Jun 2025 10:35:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Andrew Morton <akpm@linux-foundation.org>, cocci@inria.fr,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: misc: secs_to_jiffies script: Create dummy
 report
To: Ricardo Ribalda <ribalda@chromium.org>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <aeacb653-efb8-42ed-a7ed-3e7be31b8f9d@linux.microsoft.com>
 <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <CANiDSCviy5SjOwEcEM8_1gtvQzFUS3d=S6vFdvZzVqbif7NKfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/2025 6:09 AM, Ricardo Ribalda wrote:
> Hi
> 
> On Wed, 29 Jan 2025 at 18:38, Easwar Hariharan
> <eahariha@linux.microsoft.com> wrote:
>>
>> On 1/29/2025 12:06 AM, Ricardo Ribalda wrote:
>>> When running cocci in report mode, eg:
>>> $make coccicheck M="$dir" MODE=report
>>>
>>> It returns this error:
>>> virtual rule report not supported
>>> coccicheck failed
>>> make: *** [Makefile:251: __sub-make] Error 2
>>>
>>> Create a dummy rule to avoid this error and run the other cocci scripts.
>>>
>>> Fixes: 551dbd1ec7ff ("coccinelle: misc: add secs_to_jiffies script")
>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>>> ---
>>>  scripts/coccinelle/misc/secs_to_jiffies.cocci | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> index 8bbb2884ea5d..2d85dca16418 100644
>>> --- a/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>>> @@ -10,6 +10,7 @@
>>>  //
>>>
>>>  virtual patch
>>> +virtual report
>>>
>>>  @depends on patch@ constant C; @@
>>>
>>> @@ -20,3 +21,8 @@ virtual patch
>>>
>>>  - msecs_to_jiffies(C * MSEC_PER_SEC)
>>>  + secs_to_jiffies(C)
>>> +
>>> +// Dummy rule for report mode that would otherwise be empty and make spatch
>>> +// fail ("No rules apply.")
>>> +@script:python depends on report@
>>> +@@
>>>
>>
>> Sorry about that, and thanks for the patch!
>>
>> FWIW,
>>
>> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> I just checked on 6.16rc1 and it is still failing.
> 
> Could we land this while Mark's series is under review?
> 
> Thanks!
> 

Can you provide a pointer to Mark's series? I actually just implemented a proper report and context mode
which I'm glad to send out.

Thanks,
Easwar (he/him)

