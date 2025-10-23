Return-Path: <linux-kernel+bounces-866197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB19BFF23A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAB19A1E72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AC41E7C27;
	Thu, 23 Oct 2025 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LbxndL5F"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF515E97
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194305; cv=none; b=DB+7txrvu8fjW3EofmaOinpivvyBlbMSeN6o6jKsS0+wGjrtQ2R2SA9Xre+bpxN9xUoIsgqWRgUTB96Mmx9j4h2L8j6zvbIebi2ahfTzZPOYAE8G83zbdZDCVdgnfmog2bZWUH8inwvtQbwqwJB/HcHqZw+uyqeh2oOqg8NB5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194305; c=relaxed/simple;
	bh=U7/ku0a0DkHgaVRKKYi9AcIHz/S4r3e0Ujc9Z7ce5FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KZEAbBLYv31rhBOWnyKQ6H7tHoWDivySc2TzQ7f0vONjmVlwl+me25NenoaISqvsVydOk407CjI5a5k9lwFMCNxZIHTkkRFVosy07Enmx1xRh6JP7J12Dl9ikPxkNn/Y7EmiTvFas7Mm040gxeH18y1rOy9+cKRSjrBwk7bj5O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LbxndL5F; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59N4cFcf437476;
	Wed, 22 Oct 2025 23:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761194295;
	bh=U7/ku0a0DkHgaVRKKYi9AcIHz/S4r3e0Ujc9Z7ce5FQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LbxndL5FPPmJw/w8f07IBoI+/ufdk7EZtLrdN7tU56XHBHI4lUXaGK2iD3P2OdPDK
	 Mzd8W1EEhiPk7pFHWANzeH9djbxxaA2gPRbqusk+h7M9HZXrF2SDv9GZOjCs6leQeB
	 m4IXfJjSpNU3G2/EuTngpZjk/yrF2vTq+/6rUORI=
Received: from DLEE206.ent.ti.com (dlee206.ent.ti.com [157.170.170.90])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59N4cFw22124550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 23:38:15 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:38:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 23:38:15 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59N4cDGv2281762;
	Wed, 22 Oct 2025 23:38:14 -0500
Message-ID: <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
Date: Thu, 23 Oct 2025 10:08:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
To: Andrew Davis <afd@ti.com>, <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: <hiagofranco@gmail.com>, <hnagalla@ti.com>, <u-kumar1@ti.com>
References: <20251022102015.1345696-1-b-padhi@ti.com>
 <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 22/10/25 21:37, Andrew Davis wrote:
> On 10/22/25 5:20 AM, Beleswar Padhi wrote:
>> There may be pending messages in the mailbox FIFO that are not consumed
>> by the remote processor for various reasons; the remote processor may
>> already be powered off or may be in a bad state. Instead of aborting
>> suspend because of these pending messages, flush the FIFOs and proceed
>> with suspend. Pending messages could also be restored in the resume
>> context, but since remote processors are typically rebooted during
>> suspend/resume today, there is no point in restoring stale messages.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   drivers/mailbox/omap-mailbox.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
>> index 680243751d62..5e6373911630 100644
>> --- a/drivers/mailbox/omap-mailbox.c
>> +++ b/drivers/mailbox/omap-mailbox.c
>> @@ -341,13 +341,10 @@ static int omap_mbox_suspend(struct device *dev)
>>       if (pm_runtime_status_suspended(dev))
>>           return 0;
>>   -    for (fifo = 0; fifo < mdev->num_fifos; fifo++) {
>> -        if (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo))) {
>> -            dev_err(mdev->dev, "fifo %d has unexpected unread messages\n",
>> -                fifo);
>> -            return -EBUSY;
>> -        }
>> -    }
>> +    /* Flush out pending mbox messages before entering suspend */
>> +    for (fifo = 0; fifo < mdev->num_fifos; fifo++)
>> +        while (mbox_read_reg(mdev, MAILBOX_MSGSTATUS(fifo)) != 0)
>> +            mbox_read_reg(mdev, MAILBOX_MESSAGE(fifo));
>
> I'm still not convinced just throwing out messages is the correct thing
> to do here, but for now at very least let's print some warning here when
> messages get zapped.


I am also considering:
1. Mailbox queues for RTOS-RTOS communication could be
firewalled for safety/FFI usecases. In that case, the above flush
would result in an exception.
2. This driver is common to OMAP SoCs which supported proper
suspend/resume, meaning those rprocs could consume pending
messages in resume. So clearing out messages from Linux
might not be the best thing to do here.

What else can we do here? Should we just fallback to letting
Linux see only it's required queues for IPC? By setting
"ti,mbox-num-fifos = <4>"?

Thanks,
Beleswar

>
> Andrew
>
>>         for (usr = 0; usr < mdev->num_users; usr++) {
>>           reg = MAILBOX_IRQENABLE(mdev->intr_type, usr);
>

