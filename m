Return-Path: <linux-kernel+bounces-814284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7AEB55200
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E705A7081
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D12FDC4E;
	Fri, 12 Sep 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DPxH7wWy"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A196D1A7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687942; cv=none; b=unmazQO+f5iEJAyP3cNdIUevEsJm+Ko8U4eSQAiFJKSMvuMzvhrV0fpo9A3A1HoPv+OoPgctQMVWHofAMzLKlPItI9f3I8cHTOV4cI9yP+WIpbMD4WDd/JZF/c7QTBeHfR47HjkT7qeoOFiv3gHftHO4sq9FMNRApQrNWTeQDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687942; c=relaxed/simple;
	bh=Zud9w3aS6gjRiWjbIx38CgQlpVxgN+4usfvAb5PGmpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBq1aRc81URJ09d7X4/o7JZNYt6cPbROL7ILhcxKpqCCYRLd+czqVZVC4T4cnitqlPzTNlenD2nrxEXUxzcV/W7e9gc7pco2wHtORLtpm9FiBzDgdwzJ7OybBOSLQRTYq2pJogThrK5mW/LvF7YoaghLy8wASyB+Z9xcYWXe3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DPxH7wWy; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d833ea6-328f-4743-abfa-fb09b168849e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757687936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KE1W/r+N8sTKSy321MZ4n/oyG8LmkGslI8PJ1jlVKTs=;
	b=DPxH7wWyt9AZqvJa+AsTpWqx+6kaakUlHGOVOps7k2s3j31Mq1ZMggEha6nkdR/z5Fx+0R
	iAHnA9xypPTGPI90VAuKJ0TLayj/SMbvwIA5RuWC+2HL5XVAim/E779dbk+htsPxXZbh1B
	PaKLQgEKd4EjtukTxm7HdtcNxtzDE9E=
Date: Fri, 12 Sep 2025 10:38:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] coresight: Fix possible deadlock in coresight_panic_cb
To: Yeoreum Yun <yeoreum.yun@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mike Leach <mike.leach@linaro.org>, Linu Cherian <lcherian@marvell.com>,
 James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org
References: <20250911153315.3607119-1-sean.anderson@linux.dev>
 <20250912093534.GF12516@e132581.arm.com> <aMP95WqHyIQq8TcS@e129823.arm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aMP95WqHyIQq8TcS@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/12/25 07:03, Yeoreum Yun wrote:
> Hi,
> 
>> Hi Sean,
>>
>> On Thu, Sep 11, 2025 at 11:33:15AM -0400, Sean Anderson wrote:
>> > coresight_panic_cb is called with interrupts disabled during panics.
>> > However, bus_for_each_dev calls bus_to_subsys which takes
>> > bus_kset->list_lock without disabling IRQs. This will cause a deadlock
>> > if a panic occurs while one of the other coresight functions that uses
>> > bus_for_each_dev is running.
>>
>> The decription is a bit misleading. Even when IRQ is disabled, if an
>> exception happens, a CPU still can be trapped for handling kernel panic.
>>
>> > Maintain a separate list of coresight devices to access during a panic.
>>
>> Rather than maintaining a separate list and introducing a new spinlock,
>> I would argue if we can simply register panic notifier in TMC ETR and
>> ETF drviers (see tmc_panic_sync_etr() and tmc_panic_sync_etf()).
>>
>> If there is no dependency between CoreSight modules in panic sync flow,
>> it is not necessary to maintain list (and lock) for these modules.

Yeah, I was thinking about this as I was preparing v2 of this patch.

> +1 for this.
> and using the spinlock in the panic_cb doesn't work on PREEMPT_RT side.

What do you mean by this? I am using lockdep and it did not warn about this,
so I assume that on PREEMPT_RT IRQs remain enabled in this path.

--Sean

