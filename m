Return-Path: <linux-kernel+bounces-817189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69C4B57F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E033B1165
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA6930EF87;
	Mon, 15 Sep 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OvMI5Nrd"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F985189BB6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946752; cv=none; b=ngG+ki//FLy5b7FlUh0fO0LMDMQ/rizIhom7ild2lHbPlJc5bFpqRQ3y9WYg+AT1E16mBwXG5uw38tntpDN1qUgbpVUmH1XF+CBO/5Q62V86WQl0G21RpwpwiH1xlJhDhEwMRdxVJKj1wqPFCPyQpS98yNyFCDllmkc0ADDyuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946752; c=relaxed/simple;
	bh=en2gsb0Sq3gjPHeL7sQd25zZ8WMD5ViYQN65lxx3xzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKNU2SLvhInGxUG4OUOLBHox1QWU2ZlNfYMPl7OHKWZpujK8DdpMv01ICVpY2DJxf4HD+cnII/NLec3ePBo/thKn5asvh0iA7W7Q2MicGEa8HnHh8nh2+05sDVZ1U+0puEVpWlYLnZ59BRAloXV8e3e4bscW27HrohksVKkXDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OvMI5Nrd; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6c1694b-c5aa-4b1e-baef-c48546d28539@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757946748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkqLPPhwp3NLt6yybUUBOI+18CkgZjGtJx1gNUIBcDc=;
	b=OvMI5NrdjNUTgE/ZWXff6E0jRDjEwfgbls7DPegTCZuxtMKrEgmo3dtptEo8zNw/mXuf22
	vpsUTYC891Is6G5J+xvxYYIM5SQVSke8fVYIyre+hDEbLtumXrfowJWMm4yHl2oEY2kUZP
	oxC/5K/6hvQXKnF1bJ2UCnIKtVwalTY=
Date: Mon, 15 Sep 2025 10:32:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] coresight: Fix possible deadlock in coresight_panic_cb
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mike Leach <mike.leach@linaro.org>, Linu Cherian <lcherian@marvell.com>,
 James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org
References: <20250911153315.3607119-1-sean.anderson@linux.dev>
 <20250912093534.GF12516@e132581.arm.com> <aMP95WqHyIQq8TcS@e129823.arm.com>
 <6d833ea6-328f-4743-abfa-fb09b168849e@linux.dev>
 <aMTzdJRGdTCBZyo1@e129823.arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aMTzdJRGdTCBZyo1@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/13/25 00:30, Yeoreum Yun wrote:
> Hi,
> 
>> > Hi,
>> >
>> >> Hi Sean,
>> >>
>> >> On Thu, Sep 11, 2025 at 11:33:15AM -0400, Sean Anderson wrote:
>> >> > coresight_panic_cb is called with interrupts disabled during panics.
>> >> > However, bus_for_each_dev calls bus_to_subsys which takes
>> >> > bus_kset->list_lock without disabling IRQs. This will cause a deadlock
>> >> > if a panic occurs while one of the other coresight functions that uses
>> >> > bus_for_each_dev is running.
>> >>
>> >> The decription is a bit misleading. Even when IRQ is disabled, if an
>> >> exception happens, a CPU still can be trapped for handling kernel panic.
>> >>
>> >> > Maintain a separate list of coresight devices to access during a panic.
>> >>
>> >> Rather than maintaining a separate list and introducing a new spinlock,
>> >> I would argue if we can simply register panic notifier in TMC ETR and
>> >> ETF drviers (see tmc_panic_sync_etr() and tmc_panic_sync_etf()).
>> >>
>> >> If there is no dependency between CoreSight modules in panic sync flow,
>> >> it is not necessary to maintain list (and lock) for these modules.
>>
>> Yeah, I was thinking about this as I was preparing v2 of this patch.
>>
>> > +1 for this.
>> > and using the spinlock in the panic_cb doesn't work on PREEMPT_RT side.
>>
>> What do you mean by this? I am using lockdep and it did not warn about this,
>> so I assume that on PREEMPT_RT IRQs remain enabled in this path.
> 
> Hmm, I don't believe this.
> When you see the panic(), it explicitly disable irq.
> and preempt_disabled() before
> calling atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
> 
> also, atomic_nofier_call_chain() is rcu critical section.
> 
> As you know, since the spinlock becomes sleepable lock in PREEMPT_RT
> this is problem.
> 
> The reason why lockdep doesn't report this problem since it was disabled
> before panic notifier chain by calling debug_locks_off();

Ah, that makes sense.

--Sean

