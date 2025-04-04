Return-Path: <linux-kernel+bounces-588266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A09A7B6C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 06:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39BC177E46
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 04:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A704E433A8;
	Fri,  4 Apr 2025 04:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtjQaZzE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF323C38;
	Fri,  4 Apr 2025 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743739713; cv=none; b=mOscNowBcGS2xdZxzEiD3jfo/k+EMfpU8+CbC1YyibSe7bVP+lscy0xeldZqZnYZwZdwAEUax0GNGSOrpkkgTFwjcc0pMZVqUpTE3YGkrhqDtxjfhGrXRmU7K9NYuIdyDvNyT3g6OE6fTwTwprfWNmruMghsVP3E/81JGQPdMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743739713; c=relaxed/simple;
	bh=uIuWubAC707nIM1l+lqobRX4kj7WrrEU9dYEXroJP6I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uXaOJspop7t4rZc1/fcTVH59rm2VveECA/mdSlKSePA30IRsPocfTp44NnuqH1cFiI7ufzHO7opxzegjqsNUr55HRBdq0mMLa5Hv64kNmjqJLs7oPZ8d7AVAY1O4fcdLJnAJ3VQrTf0ye+GNapzzYt+MxQu2q49W0ZLg1Y9SlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtjQaZzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80EDC4CEDD;
	Fri,  4 Apr 2025 04:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743739712;
	bh=uIuWubAC707nIM1l+lqobRX4kj7WrrEU9dYEXroJP6I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=rtjQaZzE+AaOiEE+RTdfRxwfzfHVuZSt9elCsXnHjnzMj9LBswg6SQ/UQGUy1wMi9
	 XvESKwysWVaZD493v/lg32bniZ7zhAQ6mvvobeOrFgt5HZ+4hcBSYa7NEUhhiHkwYX
	 8kOCok/jTi9rJ3Wlmv8QrADXvxTGMkhxQR3JKTn7JlDRH97YoAOw56FvJiUdKvMIrj
	 WRo7gCLxTu0KA+MYWPd4otvT09AGcFXZP2ykmtMpukgGvOvRZWxTS1YyBa7VaEnHmM
	 qbL02aoKq33hQGiuohm8jzWuaYFy3VEm5vBL54ZWMcXhjhueVRdT0lnYe94eCcM3Ld
	 CGtLZqTLAAAlQ==
Message-ID: <d16bdd67-5060-4bb1-991b-6c82f3936ace@kernel.org>
Date: Fri, 4 Apr 2025 13:07:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] [ARM] pata_pxa: Fix null-ptr-deref in pxa_ata_probe()
From: Damien Le Moal <dlemoal@kernel.org>
To: Henry Martin <bsdhenrymartin@gmail.com>, cassel@kernel.org,
 linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20250403034520.59597-1-bsdhenrymartin@gmail.com>
 <f1e0683a-579f-470b-afa9-4869ac3ced98@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f1e0683a-579f-470b-afa9-4869ac3ced98@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 12:58 PM, Damien Le Moal wrote:
> On 4/3/25 12:45 PM, Henry Martin wrote:

The patch title should be:

ata: pata_pxa: Fix potential NULL pointer dereference in pxa_ata_probe()

>> devm_ioremap() returns NULL on error. Currently, pxa_ata_probe() does
>> not check for this case, which results in a NULL pointer dereference.
> 
> , which can result in...
> 
>>
>> Add NULL check after devm_ioremap() to prevent this issue.
>>
>> Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
>> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
>> ---
>>  drivers/ata/pata_pxa.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
>> index 434f380114af..cc76290a3b1a 100644
>> --- a/drivers/ata/pata_pxa.c
>> +++ b/drivers/ata/pata_pxa.c
>> @@ -223,11 +223,16 @@ static int pxa_ata_probe(struct platform_device *pdev)
>>  
>>  	ap->ioaddr.cmd_addr	= devm_ioremap(&pdev->dev, cmd_res->start,
>>  						resource_size(cmd_res));
>> +	if (!ap->ioaddr.cmd_addr)
>> +		return -ENOMEM;
>>  	ap->ioaddr.ctl_addr	= devm_ioremap(&pdev->dev, ctl_res->start,
>>  						resource_size(ctl_res));
>> +	if (!ap->ioaddr.ctl_addr)
>> +		return -ENOMEM;
>>  	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
>>  						resource_size(dma_res));
>> -
>> +	if (!ap->ioaddr.bmdma_addr)
>> +		return -ENOMEM;
> 
> Please keep the blank line here.
> 
>>  	/*
>>  	 * Adjust register offsets
>>  	 */
> 
> 


-- 
Damien Le Moal
Western Digital Research

