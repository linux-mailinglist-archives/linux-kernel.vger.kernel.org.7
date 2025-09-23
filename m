Return-Path: <linux-kernel+bounces-828200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFAEB9429F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEF1188B15D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E526CE15;
	Tue, 23 Sep 2025 03:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Drjoyeyh"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF791B040B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599993; cv=none; b=Re2CfeegSaDD0hy1YRap+2+TsPr6+n9q1YsYGBkp/ioDzjqlA7VM7KqLSFQUtAb1ngC0kYQBzD5bWFf0AfdueCsx5V3kx5h1J33EjpGxfmIb49HG25YunypOoOD5kWaznZjrTpWkVyMYleesn9cv7WW99LTa/4gOTrOsys09Atg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599993; c=relaxed/simple;
	bh=stufo5VaflHTD5Dch8msOtonFZ5qNNcz+IiyCZiyGe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlP0VT8sSl1REbTTTw78ui6n6iPfiaYvyHKQuv5WR1n/sWxH+Ub0jn8mBtFCx4q4xxFP4m/NRdVq8h+uVFv8mvo8mFav9s8XzX7ZZ0K31NHBEUxEfMrn3k+OLgagqpL5NfZMctG0ivFpI3KHEVeXxh91y6vi2Yqt9FncnzPGyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Drjoyeyh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9067a88d-f5df-4d6e-b3b3-2e266ebcf3d0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758599979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBb7AifhcOJYVqzVR28gnq9RZ3Lo8WspOuJNKw0BLWU=;
	b=DrjoyeyhpJzeaP9BvJa1Zj2N6qGxchqojKau7q5f6FSO7Y9Y42GNjix0LLb8EKXzkP9Hp5
	NhJ/rTh7jV2hX0Rn++ixLA1iJSV46Yd9q7zVJVj3r0ocBnWP/ACAWDN8iLL5PU08UTxM0F
	JBwmOYsd4uAYrhHjwp04CMtS+uDAd44=
Date: Tue, 23 Sep 2025 11:59:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] hung_task: Support to panic when the maximum number
 of hung task warnings is reached
Content-Language: en-US
To: lirongqing <lirongqing@baidu.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: corbet@lwn.net, mhiramat@kernel.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, mingo@kernel.org,
 dave.hansen@linux.intel.com, rostedt@goodmis.org, kees@kernel.org,
 arnd@arndb.de, feng.tang@linux.alibaba.com, pauld@redhat.com,
 joel.granados@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250923033740.2696-1-lirongqing@baidu.com>
 <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250922204554.55dd890090b0f56ad10a61f5@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/23 11:45, Andrew Morton wrote:
> On Tue, 23 Sep 2025 11:37:40 +0800 lirongqing <lirongqing@baidu.com> wrote:
> 
>> Currently the hung task detector can either panic immediately or continue
>> operation when hung tasks are detected. However, there are scenarios
>> where we want a more balanced approach:
>>
>> - We don't want the system to panic immediately when a few hung tasks
>>    are detected, as the system may be able to recover
>> - And we also don't want the system to stall indefinitely with multiple
>>    hung tasks
>>
>> This commit introduces a new mode (value 2) for the hung task panic behavior.
>> When set to 2, the system will panic only after the maximum number of hung
>> task warnings (hung_task_warnings) has been reached.
>>
>> This provides a middle ground between immediate panic and potentially
>> infinite stall, allowing for automated vmcore generation after a reasonable
> 
> I assume the same argument applies to the NMI watchdog, to the
> softlockup detector and to the RCU stall detector?
> 
> A general framework to handle all of these might be better.  But why do
> it in kernel at all?  What about a userspace detector which parses
> kernel logs (or new procfs counters) and makes such decisions?

+1. I agree that a userspace detector seems more appropriate for this.

We already have the hung_task_detect_count counter, so a userspace
detector could easily use that to implement custom policies ;)

