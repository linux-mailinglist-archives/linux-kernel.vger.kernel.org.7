Return-Path: <linux-kernel+bounces-784105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AC9B336C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406C21897730
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA242868A2;
	Mon, 25 Aug 2025 06:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB7928469A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104637; cv=none; b=KpvWsOJ8rScY68+wJsLP0woQNru1rTChV4ChxCjkJSgQgTRmp+BR0sRvCceYhUnTSbm1mS7AjZu1fAUBHi69EYYRl0AKmB3G4ALASJAeaD6fDdom7M4+7o8W8yft1bfDla6pDwtrCx8r0kXX7RQsP09+SQk7/6e+lA+OfaHYlwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104637; c=relaxed/simple;
	bh=U9RSZ71WickwzXbA2VC7ryrRGeAGTFfe85C0MTRaJDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hefQMXzNdI9fPstlIIk42YYMXP/ZkJhWXWa2Fi+lqGDxl3/9ctFdxR0xd/qJ+bfyglhF0LpyeO7jkaw8PyRMWXTxoH1BnEl+VqS7l8JrsgCvTETtPUwjn4MVx0f3MfciUy54ALshh7z9J8nO2sI0yt0MZEAeUnUj8D3qvkLK13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c9LKK5zQYz9sSL;
	Mon, 25 Aug 2025 08:21:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5uVW3356aDM; Mon, 25 Aug 2025 08:21:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c9LKK5Cjjz9sSH;
	Mon, 25 Aug 2025 08:21:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B8958B765;
	Mon, 25 Aug 2025 08:21:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WYi6JqpQl8Lp; Mon, 25 Aug 2025 08:21:25 +0200 (CEST)
Received: from [10.25.207.160] (unknown [10.25.207.160])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7318E8B764;
	Mon, 25 Aug 2025 08:21:25 +0200 (CEST)
Message-ID: <1eec11c9-d2f2-45fb-ad7b-6b33bd62cf04@csgroup.eu>
Date: Mon, 25 Aug 2025 08:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: fsl-mc: Check return value of
 platform_get_resource()
To: Markus Elfring <Markus.Elfring@web.de>,
 Salah Triki <salah.triki@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <aIH4t9Ekj8hn7EEk@pc>
 <b107c2a6-bb56-4b15-bf0f-d9eca8163aa1@web.de>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <b107c2a6-bb56-4b15-bf0f-d9eca8163aa1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/07/2025 à 18:24, Markus Elfring a écrit :
>> platform_get_resource() returns NULL in case of failure, so check its
>> return value and propagate the error in order to prevent NULL pointer
>> dereference.
> 
> How do you think about to add any tags (like “Fixes” and “Cc”) accordingly?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16-rc7#n145
> 

Fixes: 6305166c8771 ("bus: fsl-mc: Add ACPI support for fsl-mc")

> 
> …
>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> @@ -1105,6 +1105,10 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
>>   	 * Get physical address of MC portal for the root DPRC:
>>   	 */
>>   	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +	if (!plat_res)
>> +		return -ENODEV;

Before the blame commit, of_address_to_resource() was used and 
of_address_to_resource() returns -EINVAL in case no resource is found. 
Should we keep the same return instead of ENODEV ?

> …
> 
> I suggest to omit a blank line before the if statement.
> 
> Regards,
> Markus
> 
> 


