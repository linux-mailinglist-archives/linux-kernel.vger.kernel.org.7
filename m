Return-Path: <linux-kernel+bounces-883759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C23C9C2E515
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 23:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ACE84EACBE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 22:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C362FBE05;
	Mon,  3 Nov 2025 22:50:05 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260F2FD1C2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210204; cv=none; b=T7Ze227rODT7RC74BqYoBsH+VqwML7p/Ojvs360iNGdtvQrzrKG2QU/FXj/YP84ZhHvigpRn6u4j3+zvVTs7oa4m2T+yYVFM3RADSUYrF0qMhmSmfxOQRgqREAua5Lb734tnFMvPDkj5fntLtME2KvgcREfF3QUwS9T3cE69HDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210204; c=relaxed/simple;
	bh=HlqGKweeaCh2VVgHeepXVH+hY+FFpb+LAdUua0UKtLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwbGYYEfEf55Ws8n6CD9LpFbNWxWF1lj8Kx6rNOhdf6NbubhkvhBk8yjA4OyNJHvfVQPdP7yX5v+wjLoTaUXr58m8Kdxjt6aWtGaKvQUHSFVVc05nTppkCUvLWR3oJj5GD6ibLNgVdzOTmdRJXGJLJsprPjtSM4Azt7KO2G9w38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d0mdx43bmz9sS7;
	Mon,  3 Nov 2025 23:36:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3_wS541s9o7; Mon,  3 Nov 2025 23:36:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d0mdx3CMqz9sRy;
	Mon,  3 Nov 2025 23:36:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 579718B76C;
	Mon,  3 Nov 2025 23:36:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1APe-jDfmn1x; Mon,  3 Nov 2025 23:36:21 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D0B0B8B763;
	Mon,  3 Nov 2025 23:36:20 +0100 (CET)
Message-ID: <764858d5-5633-4aeb-aabe-52f9eb1eb530@csgroup.eu>
Date: Mon, 3 Nov 2025 23:36:20 +0100
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
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <437fcacbc39286d1256e1f7ef034a2a3d52a8b18.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/11/2025 à 23:29, Sverdlin, Alexander a écrit :
> [Vous ne recevez pas souvent de courriers de alexander.sverdlin@siemens.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Christophe,
> 
> On Mon, 2025-11-03 at 22:46 +0100, Christophe Leroy wrote:
>>>>> Replace the RAW SPI accesses with spi-mem API. The latter will fall back to
>>>>> RAW SPI accesses if spi-mem callbacks are not implemented by a controller
>>>>> driver.
>>>>
>>>> With this patch (kernel v6.17.1) our powerpc boards are totally
>>>> unstable, we get multiple random Oops due to bad memory accesses.
>>>>
>>>> With this commit reverted the board is stable again.
>>>>
>>>> The SPI driver is:
>>>>
>>>> CONFIG_SPI=y
>>>> CONFIG_SPI_MASTER=y
>>>> CONFIG_SPI_MEM=y
>>>> CONFIG_SPI_FSL_LIB=y
>>>> CONFIG_SPI_FSL_CPM=y
>>>> CONFIG_SPI_FSL_SPI=y
>>>>
>>>> How can we further investigate the issue ?
>>>
>>> could you share these "random Oops"?
>>
>> Sure. At the first place they look unrelated. Something is likely
> 
> indeed, no obvious connection... Do you have a chance to run KASAN?

I ran KASAN, it found an overrun in the loop in 
fsl_spi_cpm_bufs_complete() when t->len is odd, but once fixed the 
random problem is still there.

Christophe

