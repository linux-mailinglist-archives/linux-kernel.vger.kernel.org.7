Return-Path: <linux-kernel+bounces-868097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9149C045A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AECB4EB8F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F1F72612;
	Fri, 24 Oct 2025 04:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rv4IO5PY"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB935B122
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761281319; cv=none; b=BPIURvUBWvifa8FQZrBvvO4WofKPE4WJJOVMvp2+RAaGORQWJHaQmXMMcQwEqMJjWJW7EthfgXtbyCtB9xD675eltKBCwlxWpZgo4CzyLRS4MoNGWF5KSa1f8HwOxaiuNw1J5jNgkSgu+WtzNVwsLRsr85QNPvqTi2S0JsU+eZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761281319; c=relaxed/simple;
	bh=9CKGJpTHz5lXg/Av4ZIJYfH3qARo03Hc4Ds25/83IS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P3ulb4wNa7b2fodRw7B4f2LTqE/6iAHZ7y9QD2gclI5QFxR2GzZ3pR6zlaTps1jUye5dJ7vwsMqda8n+dBIKnhuF4E1QhK8ZZxAkqETcuZqcAMqEp++Yasw5Vzvxa3vlFE4C5seGK1+AKFcN4Q1BPZrY7CY522jhjaaEXgpN80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rv4IO5PY; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59O4mZQa1832599;
	Thu, 23 Oct 2025 23:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761281315;
	bh=9CKGJpTHz5lXg/Av4ZIJYfH3qARo03Hc4Ds25/83IS4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Rv4IO5PYcaWT9dE/MSpm30hOwV31CannFLU7yARbRxCzmVx7pgCcYNvGJdbzX8wdM
	 2e3ni+qgC1ShGMlSJq23GtNNpgRkBujECiqfeuGDa7hlt7dtctY9ItDLAVavtqBSrb
	 3rGCO/pC+/W3GCHZ86Y0/0dy2HtKnFB1oxiG+iSo=
Received: from DLEE213.ent.ti.com (dlee213.ent.ti.com [157.170.170.116])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59O4mZT03632306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 23:48:35 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 23:48:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 23:48:34 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59O4mWNm3978346;
	Thu, 23 Oct 2025 23:48:33 -0500
Message-ID: <abec6709-b9ef-4f33-afbd-eeb69a07b941@ti.com>
Date: Fri, 24 Oct 2025 10:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
To: Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <hiagofranco@gmail.com>, <u-kumar1@ti.com>
References: <20251022102015.1345696-1-b-padhi@ti.com>
 <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
 <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
 <d8662d13-40bd-053b-6761-1a0ff7404782@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <d8662d13-40bd-053b-6761-1a0ff7404782@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hari,

On 23/10/25 22:48, Hari Nagalla wrote:
> On 10/22/25 23:38, Beleswar Prasad Padhi wrote:
>>> I'm still not convinced just throwing out messages is the correct thing
>>> to do here, but for now at very least let's print some warning here when
>>> messages get zapped.
>>
>> I am also considering:
>> 1. Mailbox queues for RTOS-RTOS communication could be
>> firewalled for safety/FFI usecases. In that case, the above flush
>> would result in an exception.
> Yes, flushing all mailbox messages during suspend is not a good solution, as there can be in flight RTOS-RTOS communications for non participating cores.
>> 2. This driver is common to OMAP SoCs which supported proper
>> suspend/resume, meaning those rprocs could consume pending
>> messages in resume. So clearing out messages from Linux
>> might not be the best thing to do here.
>>
>> What else can we do here? Should we just fallback to letting
>> Linux see only it's required queues for IPC? By setting
>> "ti,mbox-num-fifos = <4>"?
> This makes the assumption that the first 4 FIFOs of the mailbox are used? and why 4? are you assuming first 2 for Linux IPC and next 2 for RTOS-RTOS communications?


4 is just an example. The mailbox FIFO assignment is also
a firmware configuration. So the idea was to let Linux only
care about the FIFOs it uses for Linux<->RTOS
communication, ignoring the ones used for
RTOS<->RTOS communication.

>
> How about, let the mailbox driver simply save and restore the config registers and ignore the FIFO messages? i.e if they are lost with the main domain going into OFF, so be it.


Hmm, this was how it was until 2016 when commit
9f0cee984a25 ("mailbox/omap: check for any unread
messages during suspend") was added. Do you
suggest reverting 9f0cee984a25? Hope it doesn't
break any existing usecases for OMAP platforms.


