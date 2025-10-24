Return-Path: <linux-kernel+bounces-868975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86387C06A07
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC07A19A0FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA0631D36A;
	Fri, 24 Oct 2025 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qHZvf9MG"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EDB2DEA6A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314899; cv=none; b=DmoNZrxfcn3Cn9LOMTjL5/uw98WzPgqhl+sCAc22BPBF8N/TyYJU2ubzLz0nNEuaui2XDmwo2b/WwfI8T3Kqo6zTSX4VbYO54ZFJEU4a/PJsyZ6mMf4eegJM0Ay0pxzze9MlIqCj/MGzNsCKam+70P4Dts06TP0CF48L5Mb4BOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314899; c=relaxed/simple;
	bh=jZNunPED/37W2kx5HuE/DP3MLyrBGR8mEldbdJEdk8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X+Fi75hPgd21qd2frVY+Eg6AcsOMEoEWfT20DxXPSg6c1tlNiKhRqVsxRWTBrMWGdwmdBYjZlYNuLleWHYrBiqJbIrkuWar8xb4/DkUAthkUBxS9Q00pqv9W5xL7h6qhWEJaSiTvB4U/AUezPp7Zqt9KGDb022gAt8Gn+AKYUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qHZvf9MG; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59OE8AR51916364;
	Fri, 24 Oct 2025 09:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761314890;
	bh=0qrrTj2ISX2ZHGxKtEtsT3qSl3+wcO5LDkl3ZD6jLk8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qHZvf9MG5XWz4ct1KJP9DRslyEvM2SYitfjVov+6TQGP+4fb8wSz7q9nCZ5SWJFXS
	 unmolG3p0eFzCWzayTMHi7ZqPbnKUxQgxsCo+KgH2IG2Ht6NgkSyltQ+gGCobMmm45
	 E83xUZBNgdT3pxI1wDprRo6yCBYKCmzB66BHJxYo=
Received: from DFLE202.ent.ti.com (dfle202.ent.ti.com [10.64.6.60])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59OE8An63625492
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Oct 2025 09:08:10 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Oct
 2025 09:08:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Oct 2025 09:08:09 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59OE89Dm439475;
	Fri, 24 Oct 2025 09:08:09 -0500
Message-ID: <da788554-1962-4fca-8318-278e9224af59@ti.com>
Date: Fri, 24 Oct 2025 09:08:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <hiagofranco@gmail.com>, <u-kumar1@ti.com>
References: <20251022102015.1345696-1-b-padhi@ti.com>
 <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
 <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
 <d8662d13-40bd-053b-6761-1a0ff7404782@ti.com>
 <abec6709-b9ef-4f33-afbd-eeb69a07b941@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <abec6709-b9ef-4f33-afbd-eeb69a07b941@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/23/25 11:48 PM, Beleswar Prasad Padhi wrote:
> Hi Hari,
> 
> On 23/10/25 22:48, Hari Nagalla wrote:
>> On 10/22/25 23:38, Beleswar Prasad Padhi wrote:
>>>> I'm still not convinced just throwing out messages is the correct thing
>>>> to do here, but for now at very least let's print some warning here when
>>>> messages get zapped.
>>>
>>> I am also considering:
>>> 1. Mailbox queues for RTOS-RTOS communication could be
>>> firewalled for safety/FFI usecases. In that case, the above flush
>>> would result in an exception.
>> Yes, flushing all mailbox messages during suspend is not a good solution, as there can be in flight RTOS-RTOS communications for non participating cores.
>>> 2. This driver is common to OMAP SoCs which supported proper
>>> suspend/resume, meaning those rprocs could consume pending
>>> messages in resume. So clearing out messages from Linux
>>> might not be the best thing to do here.
>>>
>>> What else can we do here? Should we just fallback to letting
>>> Linux see only it's required queues for IPC? By setting
>>> "ti,mbox-num-fifos = <4>"?
>> This makes the assumption that the first 4 FIFOs of the mailbox are used? and why 4? are you assuming first 2 for Linux IPC and next 2 for RTOS-RTOS communications?
> 
> 
> 4 is just an example. The mailbox FIFO assignment is also
> a firmware configuration. So the idea was to let Linux only
> care about the FIFOs it uses for Linux<->RTOS
> communication, ignoring the ones used for
> RTOS<->RTOS communication.
> 

The issue is Linux is still shutting down the whole mailbox, so it
can't just care about it's own FIFOs as it is still deleting all
stored messages, whether it checks them or not.

>>
>> How about, let the mailbox driver simply save and restore the config registers and ignore the FIFO messages? i.e if they are lost with the main domain going into OFF, so be it.
> 
> 
> Hmm, this was how it was until 2016 when commit
> 9f0cee984a25 ("mailbox/omap: check for any unread
> messages during suspend") was added. Do you
> suggest reverting 9f0cee984a25? Hope it doesn't
> break any existing usecases for OMAP platforms.
> 

Checking for unread messages during suspend is still correct,
what we then do when we find them is the open question. We can:

  * Not suspend (current situation)
  * Suspend anyway, deleting them but with a warning
  * Save and restore them

Ignoring the problem by reverting 9f0cee984a25 is not a solution.

Andrew

