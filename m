Return-Path: <linux-kernel+bounces-884847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BEC314CC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C578434DBAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69980327207;
	Tue,  4 Nov 2025 13:50:09 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBD4747F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264208; cv=none; b=YV8x6M1PMDwDNV6eyIlIU+FnG1R+fWexCteO0kMConihIj1I2tMXE1ThXMbzY+RUebJaU9ZRXgv694Gs23k954/e626AoXPNKSurnfMUW94ux7LABWs2aZDt6nhQW7bOgpnAU/4u/vH7v65DaDHfi0B5fcOf3Yl/VWJxGpjzYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264208; c=relaxed/simple;
	bh=g3H9v8zHBcOwptwnfQ24IKjsoTZvkYpvXqyay7m9Yi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJVYIQLQYc5Xqp3lzB5+8sRGhDTKG5wRIKgQxHl03D5qog7paN5JHr8pKZqk+K/r+nbTRYWI1+vDZYQHgb4rvSnHFGk6isRO02VkhaXrrd9v/PCl9gc6ULt0x7IJYBGDo/so5xLpSGJC33XyiyGkpx5RhoD7Yk8jSSfsAJJK5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d18LT6q3jz9sSR;
	Tue,  4 Nov 2025 14:24:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9RAU3SiOuaqo; Tue,  4 Nov 2025 14:24:17 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d18LT66CQz9sS7;
	Tue,  4 Nov 2025 14:24:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C064F8B76D;
	Tue,  4 Nov 2025 14:24:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Sdxd-TxWLqNS; Tue,  4 Nov 2025 14:24:17 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8098F8B763;
	Tue,  4 Nov 2025 14:24:17 +0100 (CET)
Message-ID: <a74bac93-88de-4d45-9961-b5a3aa342c70@csgroup.eu>
Date: Tue, 4 Nov 2025 14:24:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "florent.trinh-thai@cs-soprasteria.com"
 <florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
 <44b4f443075818cc0799724c9adf635b786e97b4.camel@siemens.com>
 <662a5f56-8851-43a8-af27-237acd799943@csgroup.eu>
 <437fcacbc39286d1256e1f7ef034a2a3d52a8b18.camel@siemens.com>
 <764858d5-5633-4aeb-aabe-52f9eb1eb530@csgroup.eu>
 <2941b3527113a0b09b9a380e4746bf899948708c.camel@siemens.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <2941b3527113a0b09b9a380e4746bf899948708c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

Le 04/11/2025 à 14:13, Sverdlin, Alexander a écrit :
> Hi Christophe,
> 
> On Mon, 2025-11-03 at 23:36 +0100, Christophe Leroy wrote:
>>>>>>> Replace the RAW SPI accesses with spi-mem API. The latter will fall back to
>>>>>>> RAW SPI accesses if spi-mem callbacks are not implemented by a controller
>>>>>>> driver.
>>>>>>
>>>>>> With this patch (kernel v6.17.1) our powerpc boards are totally
>>>>>> unstable, we get multiple random Oops due to bad memory accesses.
>>>>>>
>>>>>> With this commit reverted the board is stable again.
>>>>>>
>>>>>> The SPI driver is:
>>>>>>
>>>>>> CONFIG_SPI=y
>>>>>> CONFIG_SPI_MASTER=y
>>>>>> CONFIG_SPI_MEM=y
>>>>>> CONFIG_SPI_FSL_LIB=y
>>>>>> CONFIG_SPI_FSL_CPM=y
>>>>>> CONFIG_SPI_FSL_SPI=y
>>>>>>
>>>>>> How can we further investigate the issue ?
>>>>>
>>>>> could you share these "random Oops"?
>>>>
>>>> Sure. At the first place they look unrelated. Something is likely
>>>
>>> indeed, no obvious connection... Do you have a chance to run KASAN?
>>
>> I ran KASAN, it found an overrun in the loop in
>> fsl_spi_cpm_bufs_complete() when t->len is odd, but once fixed the
>> random problem is still there.
> 
> thanks for the quick reply!
> That sounds promising already!
> 
> Do you have a chance to run with CONFIG_DEBUG_STACKOVERFLOW=y ?
> 

Unfortunately I won't be able to do any additionnal test until Monday 
next week as I'm travelling at the moment.

However, our kernel is built with CONFIG_VMAP_STACK, so a stack overflow 
would have been caught by the early stack overflow detection, see commit 
3978eb78517c ("powerpc/32: Add early stack overflow detection with VMAP 
stack.") for details.

Christophe

