Return-Path: <linux-kernel+bounces-867461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4031C02B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2AD11A65C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B946338916;
	Thu, 23 Oct 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GydCvfVk"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C83446CD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239917; cv=none; b=H9ZTI+npoBzEe8Y/jNCqjgeGsx/JWf5OlKdjXW74sIkU5uRQ3OdT2nCmkbwJJlqmWC/roZEO3wluw+atNVBPJ9R2yxo1SXW3/ZH+HS9J582YCwOGWtP3KtHQoIekhLuKhc82ViZbVYnfDO3yP+LFBSUJ8f63yNpK8H3rDvNHG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239917; c=relaxed/simple;
	bh=52Ev5KmO2yQ2PAqYMEJONK73klk7V7BTzACocvKD3gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f6fGlamfe3KZKWQnGrQwNL03+VRYEDvqP/TiNOD7t/PiS7xPnuc0tlrml1TF+swNzYKdk16uaTwIo/ptcqNKNnUDmL/uoTvTUvX34sXDtK01+XLgKekl5l2JtKc+mDmBnsXyfQKMLhy5TXsHMx9RAC8ypFYWNG6kKqHUh9DydSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GydCvfVk; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NHIRx81718297;
	Thu, 23 Oct 2025 12:18:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761239908;
	bh=LGiS+rwANakgilNIw3jZzvO5rbQ3mwA083n3XBvsWQ0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GydCvfVkUfH4kHJZHW1KllPbnc3IxEwMxnHalG2UXSQJA8u6iabP7NMb/Ev4Tt+ki
	 83dIe+0S5Ni/W6OjzVkMT2MYbIl5CJ7jxv1vRfm7Y6ABW5pinm/RdRqZlnG7fnFWZJ
	 l3e8vw5QC4bxWaXQ/TivVr8/adAjNlGdh+OXGDH0=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NHIRcB2865966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Oct 2025 12:18:27 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 12:18:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 12:18:27 -0500
Received: from [10.249.48.175] ([10.249.48.175])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NHIRJl3215348;
	Thu, 23 Oct 2025 12:18:27 -0500
Message-ID: <d8662d13-40bd-053b-6761-1a0ff7404782@ti.com>
Date: Thu, 23 Oct 2025 12:18:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] mailbox: omap-mailbox: Flush out pending msgs before
 entering suspend
Content-Language: en-US
To: Beleswar Prasad Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>
CC: <hiagofranco@gmail.com>, <u-kumar1@ti.com>
References: <20251022102015.1345696-1-b-padhi@ti.com>
 <40726a57-35a9-450d-ba0f-879313f60732@ti.com>
 <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
From: Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <e71ec0d8-300a-4e43-9e67-15828f11ccb4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/22/25 23:38, Beleswar Prasad Padhi wrote:
>> I'm still not convinced just throwing out messages is the correct thing
>> to do here, but for now at very least let's print some warning here when
>> messages get zapped.
> 
> I am also considering:
> 1. Mailbox queues for RTOS-RTOS communication could be
> firewalled for safety/FFI usecases. In that case, the above flush
> would result in an exception.
Yes, flushing all mailbox messages during suspend is not a good 
solution, as there can be in flight RTOS-RTOS communications for non 
participating cores.
> 2. This driver is common to OMAP SoCs which supported proper
> suspend/resume, meaning those rprocs could consume pending
> messages in resume. So clearing out messages from Linux
> might not be the best thing to do here.
> 
> What else can we do here? Should we just fallback to letting
> Linux see only it's required queues for IPC? By setting
> "ti,mbox-num-fifos = <4>"?
This makes the assumption that the first 4 FIFOs of the mailbox are 
used? and why 4? are you assuming first 2 for Linux IPC and next 2 for 
RTOS-RTOS communications?

How about, let the mailbox driver simply save and restore the config 
registers and ignore the FIFO messages? i.e if they are lost with the 
main domain going into OFF, so be it. Let the remote cores handle any 
missing messages. More often the remote cores may start afresh after a 
suspend to RAM.


