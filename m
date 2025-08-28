Return-Path: <linux-kernel+bounces-790473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB4B3A7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB2E16B35C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 17:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A105C335BC4;
	Thu, 28 Aug 2025 17:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qVEWwtd9"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D95334725
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401610; cv=none; b=kNURe+YJK8Dlm5tyZMxYwR7OcAyf21IynSO/Y8wglwGf+uof89JTV0d66f/VrnbaK5lpQaPUWs1ErOS1XD5qSjQCV7ZAAChb4/+q/f6+jfHRuLVM/T52Db+NYip/C3d2rrHCc/VnKAO5OJ2ZR2YYWWqNtS6/N578A/34J1mMoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401610; c=relaxed/simple;
	bh=VNDRFOm6iD0Frw1D88ZQaVB/vKrn9vS5tlXTgHOkvcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPmoSsFJfGsaVBYsL7f+M1Al5sIQqv5ERJb48wF5CmB/HHsQo2eG2zwQjMaNuxz+CeAgtO0QcjZa16RpJNDl2VQcWbDfg78YdQ8yJTRdYkcHGHk/SnyK6KtNFN+JHbiSmFDt6Na6amzhSka0oTprDXWxMGM//gEF7+nYcVjDN2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qVEWwtd9; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4e5cc2c-ca62-467c-9b58-52831ebeb032@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756401593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pyHKGykIxOwM8LqQ483zBF7dyZd7CrXVY89y5CfS7A4=;
	b=qVEWwtd9ZgjaNvp1q7hz6fuVvkWUE4DwWZ8LuGnemPwGykGEdnZNZNU5JsDgD8ECKrThYt
	lQVxHozdOUCM8EN2pRumAHq1oVP8vyJ2tY+gwmtXm9PVGpLIFo/w46urDhYk8hawvzdIR2
	+kb+jtWv8PTdwJETT3GLjh6Mw7jC9Lo=
Date: Thu, 28 Aug 2025 13:19:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: macb: Fix tx_ptr_lock locking
To: Robert Hancock <robert.hancock@calian.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "efault@gmx.de" <efault@gmx.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>
References: <20250828160023.1505762-1-sean.anderson@linux.dev>
 <382f53239ff21a050089bcabb38d31329836ad98.camel@calian.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <382f53239ff21a050089bcabb38d31329836ad98.camel@calian.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 12:13, Robert Hancock wrote:
> On Thu, 2025-08-28 at 12:00 -0400, Sean Anderson wrote:
>> macb_start_xmit can be called with bottom-halves disabled (e.g.
>> transmitting from softirqs) as well as with interrupts disabled (with
>> netpoll). Because of this, all other functions taking tx_ptr_lock
>> must
>> disable IRQs, and macb_start_xmit must only re-enable IRQs if they
>> were already enabled.
>> 
>> Fixes: 138badbc21a0 ("net: macb: use NAPI for TX completion path")
>> Reported-by: Mike Galbraith <efault@gmx.de>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>> 
>>  drivers/net/ethernet/cadence/macb_main.c | 25 ++++++++++++----------
>> --
>>  1 file changed, 13 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 16d28a8b3b56..b0a8dfa341ea 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -1228,7 +1228,7 @@ static int macb_tx_complete(struct macb_queue
>> *queue, int budget)
>>         int packets = 0;
>>         u32 bytes = 0;
>> 
>> -       spin_lock(&queue->tx_ptr_lock);
>> +       spin_lock_irq(&queue->tx_ptr_lock);
>> 
> 
> Hm, I think I used a non-IRQ lock here to avoid potentially disabling
> interrupts for so long during TX completion processing. I don't think I
> considered the netpoll case where start_xmit can be called with IRQs
> disabled however. Not sure if there is a better solution to satisfy
> that case without turning IRQs off entirely here?

Well, we have a single producer (macb_start_xmit) so we don't need to
take a lock to enqueue anything as long as we add barriers in the right
places.

--Sean

