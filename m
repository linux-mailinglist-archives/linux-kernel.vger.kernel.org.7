Return-Path: <linux-kernel+bounces-819245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC2B59D33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF8724E21A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6231FED7;
	Tue, 16 Sep 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ky7UgO1G"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB562DF134
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039291; cv=none; b=EdIWQYBDsrZdBj8d/Fm7mcnXWsFCyCst3OD+TBP3eIZVjjor9byufM/evAbTwrsssEc3r+HDkqNkDd1Opz3tXwim9GvNCRxqrn3T3GR5/OpIkwU5zFMek4TJT+puxync5adhkHSWGMsEDwi1QYrjK1sJpulDqkCXf2ueiNOwvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039291; c=relaxed/simple;
	bh=nCspZXbYgBEeT/yWlgTEnHVXD9ZAr3pI1W6tGEUs16k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uxm9vrEr8105X4TPpGrYZhCrOVDZbVA61/BjpgmsjXl9aXGb/1cco7hd4n+3DkAL64qxDLSSXkaylxO4O0R6KV2OsJtEkD5FD85GRaup3rzhtpNmgkchAonyH4lXvqw00fJXb8b2ogup6xH5u3bQiFadYIXGAz12RAkD0Xti8HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ky7UgO1G; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a35e2d54-f1f5-4ae4-9daa-ae1f3a8a302b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758039287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SNmCIEwcZ4e13p0I/AT02il2AZu+ZHcccjAcZWxU8pk=;
	b=Ky7UgO1Gvl4Aq2strv+i4L2ECO6vSXbzIyDyCJ8yXojQbhh41opmKt7rOH6QaAKjIK9L8H
	jOjmiJmuiWEm2+4s74XBg6qa72akUUnw72uw936hfshyKUzYI+08Lr3CvaCiWgBhHJOlN4
	+9irM9Fk2CnWpLsOdGc0+GAtjfH58kk=
Date: Tue, 16 Sep 2025 12:14:40 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] coresight: Fix possible deadlock in coresight_panic_cb
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, Yeoreum Yun <yeoreum.yun@arm.com>,
 Mike Leach <mike.leach@linaro.org>, Linu Cherian <lcherian@marvell.com>,
 linux-kernel@vger.kernel.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 James Clark <james.clark@linaro.org>
References: <20250912151314.3761026-1-sean.anderson@linux.dev>
 <20250915095820.GH12516@e132581.arm.com>
 <3e618117-96bd-44f3-bede-7cadfe0264dd@linux.dev>
 <20250916160027.GK12516@e132581.arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250916160027.GK12516@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/16/25 12:00, Leo Yan wrote:
> On Mon, Sep 15, 2025 at 10:31:24AM -0400, Sean Anderson wrote:
>> On 9/15/25 05:58, Leo Yan wrote:
>> > On Fri, Sep 12, 2025 at 11:13:14AM -0400, Sean Anderson wrote:
>> >> coresight_panic_cb is called with interrupts disabled during panics.
>> >> However, bus_for_each_dev calls bus_to_subsys which takes
>> >> bus_kset->list_lock without disabling IRQs. This may cause a deadlock.
>> > 
>> > I would rephrase it to make it clearer for anyone reading it later:
>> > 
>> >   coresight_panic_cb() is called during panics, which can preempt a flow
>> >   that triggers exceptions (such as data or instruction aborts).
>> 
>> I don't see what exceptions have to do with it. You can also panic
>> during a regular interrupt.
> 
> The commit mentioned "without disabling IRQs" gives the impression that
> the deadlock is caused by IRQ-unsafe locking, which might mislead into
> thinking why the issue cannot be fixed with IRQ-safe locking.
> 
> Regardless of whether IRQs are disabled, and regardless of the context
> (interrupt, bottom-half, or normal thread), the conditions for the
> deadlock are only about:
> 
>   (a) The bus lock has been acquired;
>   (b) A panic is triggered to try to acquire the same lock.
> 
> [...]
> 
>> > When I review this patch, I recognize we can consolidate panic notifier
>> > in coresight-tmc-core.c, so we don't need to distribute the changes
>> > into ETF and ETR drivers (sorry if I misled you in my previous reply).
>> 
>> And this kind of thing is why I went with the straightforward fix
>> initially. I do not want to bikeshed the extent that this gets removed.
>> IMO the whole "panic ops" stuff should be done directly with the panic
>> notifier, hence this patch. If you do not agree with that, then ack v2
>> and send a follow up of your own to fix it how you see fit.
> 
> I would fix it in one go.
> 
> I agree with you that "the whole panic ops stuff should be done directly
> with the panic". The only difference between us is that I would keep the
> `panic_ops` callback. To me, this encapsulates panic callbacks into
> different modules, to make the code more general.
> 
> Could you check if the drafted patch below looks good to you? If so, I

As stated above I disagree with a half-hearted removal. If you want to do that,
then I will resend v2 done with an rcu list and you can make your own follow-up.

--Sean


