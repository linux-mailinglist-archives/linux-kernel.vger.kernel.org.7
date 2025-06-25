Return-Path: <linux-kernel+bounces-702027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6F4AE7D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F301C22C56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0872DCBE5;
	Wed, 25 Jun 2025 09:22:48 +0000 (UTC)
Received: from mx-a.polytechnique.fr (mx-a.polytechnique.fr [129.104.30.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6070252906;
	Wed, 25 Jun 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.104.30.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843367; cv=none; b=X57JH6hN+So72DGVQebtzaodA8ZKKSceqDKJOde4r2bVX0oL6qfUn606UtAh83S9YRE+GZJVtbDHS0Bs/Lwukaaqn6B6obO/nxvrrA4difFusdkmLiqnhsIq1FRhXduzU2DsP9h4Tdv0em0Ck78tQfwfM0LWm8dr7jbLVHPsHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843367; c=relaxed/simple;
	bh=qqM24CG38I0YgdVs6wHu9lNFb6fYyDWo79Ns61wNk2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huTWsuma7Gpq8ikxn4DO/PR6wd1jLogj1rvPUitv/01AirQq/31RqwyZI8NVJrKVYpzXC+6Rq7FOL2cXOirwegGzdqL1tQ0Si93cRpbjby7fvlR1MseGpR6hh+5wWp0AoB4FMHQKXeQvGiaa4q2q6LO/ocsO5leMiJjokCnLz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=129.104.30.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from zimbra.polytechnique.fr (zimbra.polytechnique.fr [129.104.69.30])
	by mx-a.polytechnique.fr (tbp 25.10.18/2.0.8) with ESMTP id 55P9EwnY023896;
	Wed, 25 Jun 2025 11:14:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by zimbra.polytechnique.fr (Postfix) with ESMTP id 8EA3B761E58;
	Wed, 25 Jun 2025 11:14:58 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra.polytechnique.fr
Received: from zimbra.polytechnique.fr ([127.0.0.1])
 by localhost (zimbra.polytechnique.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 0ewgABPHqW04; Wed, 25 Jun 2025 11:14:58 +0200 (CEST)
Received: from [130.190.109.159] (webmail-69.polytechnique.fr [129.104.69.39])
	by zimbra.polytechnique.fr (Postfix) with ESMTPSA id 181BE761F7F;
	Wed, 25 Jun 2025 11:14:58 +0200 (CEST)
Message-ID: <4c6deafe-a6ec-40bf-873f-dc0df1a72dc4@gmail.com>
Date: Wed, 25 Jun 2025 11:14:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Chas Williams <3chas3@gmail.com>,
        "moderated list:ATM" <linux-atm-general@lists.sourceforge.net>,
        "open list:ATM" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20250624064148.12815-3-fourier.thomas@gmail.com>
 <20250624165128.GA1562@horms.kernel.org>
Content-Language: en-US, fr
From: Thomas Fourier <fourier.thomas@gmail.com>
In-Reply-To: <20250624165128.GA1562@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/06/2025 18:51, Simon Horman wrote:
> On Tue, Jun 24, 2025 at 08:41:47AM +0200, Thomas Fourier wrote:
>> The DMA map functions can fail and should be tested for errors.
>>
>> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
>> ---
>>   drivers/atm/idt77252.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
>> index 1206ab764ba9..f2e91b7d79f0 100644
>> --- a/drivers/atm/idt77252.c
>> +++ b/drivers/atm/idt77252.c
>> @@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
>>   
>>   	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
>>   						 skb->len, DMA_TO_DEVICE);
>> +	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
>> +		return -ENOMEM;
>>   
>>   	error = -EINVAL;
>>   
>> @@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
>>   		paddr = dma_map_single(&card->pcidev->dev, skb->data,
>>   				       skb_end_pointer(skb) - skb->data,
>>   				       DMA_FROM_DEVICE);
>> +		if (dma_mapping_error(&card->pcidev->dev, paddr))
>> +			goto outpoolrm;
>>   		IDT77252_PRV_PADDR(skb) = paddr;
>>   
>>   		if (push_rx_skb(card, skb, queue)) {
>> @@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
>>   	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
>>   			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
>>   
>> +outpoolrm:
>>   	handle = IDT77252_PRV_POOL(skb);
>>   	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
> Hi Thomas,
>
> Can sb_pool_remove() be used here?
> It seems to be the converse of sb_pool_add().
> And safer than the code above.
> But perhaps I'm missing something.


Hi Simon,

I don't see any reason why this would be a problem,

though, I don't think it is related and the change should be in the same 
patch.

Should I create another patch for that?


