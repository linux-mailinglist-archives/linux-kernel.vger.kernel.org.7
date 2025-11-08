Return-Path: <linux-kernel+bounces-891456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB4C42B31
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B59994E4498
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793732FC01C;
	Sat,  8 Nov 2025 10:20:38 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3082FBE03
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762597238; cv=none; b=sdfe07pajz11kvBZji+vThteja31T3hzuIPHg6XIwk9uIWs829CArpG18LRNRB5WzVZdGkyugjE6cGAPchI4CWvPrFTCtGHurJQoMAIz48L6j8/sjQQFHBX5JQCeSXVH8F3O+KIyUdCC76fuX3MhBpfdbXbGnuzAYCVTvbmljE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762597238; c=relaxed/simple;
	bh=DcWAWnhwnnkPAVMlgf770/p6uJPqIPVRx3w1H56fpsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0VIQoUcU9CsvUldP9vz5EapUqak6FkVeD/UoritZucQyg8mhCEKNNxZjl4xcEwYJiJYbjk766YGGlludAfxmLYrw1VJMmaIt7ifGbdNW5HPgKUfn0QdV4YXEZnmdWkrC6/2kRCYskpes/H4Q+XfuMDRgRZBEFvnasa3nexA0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d3Wkn2r0vz9sSC;
	Sat,  8 Nov 2025 11:05:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EYKS8o5x8h4Y; Sat,  8 Nov 2025 11:05:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d3Wkn1bYrz9sS7;
	Sat,  8 Nov 2025 11:05:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2601C8B765;
	Sat,  8 Nov 2025 11:05:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4IyjPBp86TFh; Sat,  8 Nov 2025 11:05:05 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A409B8B764;
	Sat,  8 Nov 2025 11:05:04 +0100 (CET)
Message-ID: <eb0cd539-9d76-489a-b5f4-ecef2a6d32dd@csgroup.eu>
Date: Sat, 8 Nov 2025 11:05:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom: at25: convert to spi-mem API
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>,
 "mwalle@kernel.org" <mwalle@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "florent.trinh-thai@cs-soprasteria.com"
 <florent.trinh-thai@cs-soprasteria.com>, "arnd@arndb.de" <arnd@arndb.de>
References: <20250702222823.864803-1-alexander.sverdlin@siemens.com>
 <638496dd-ec60-4e53-bad7-eb657f67d580@csgroup.eu>
 <2025110513-manliness-repayment-d005@gregkh>
 <db80adb8b8006fbdeee77a386feabb81537d27e6.camel@siemens.com>
 <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <e0037dc532f3aecb101c78e7d91b66430b15d541.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander,

Le 07/11/2025 à 12:49, Sverdlin, Alexander a écrit :
> Hi Greg, Christophe,
> 
> On Wed, 2025-11-05 at 08:20 +0100, Alexander Sverdlin wrote:
>>>>> Replace the RAW SPI accesses with spi-mem API. The latter will fall back to
>>>>> RAW SPI accesses if spi-mem callbacks are not implemented by a controller
>>>>> driver.
>>>>
>>>> With this patch (kernel v6.17.1) our powerpc boards are totally unstable, we
>>>> get multiple random Oops due to bad memory accesses.
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
>>> We can revert it until it comes back working properly.  Can you send a
>>> revert so that I can apply it?
>>
>> what is known for sure is that it triggers a bug in SPI_FSL_CPM [1],
>> which probably justifies a revert in -stable. But there are no indications the
>> patch in question misbehaves itself as of now. I'm going to KASAN it on all the
>> HW I can get my hands on this week.
>>
>> [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F764858d5-5633-4aeb-aabe-52f9eb1eb530%40csgroup.eu%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf9772eb8a7ac440e64ef08de1df3c518%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638981129997670721%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=VnQ2%2B063DdxLpc0vMopRRqGGHXt6zgqUV%2FITU19Zg0s%3D&reserved=0
> 
> just letting you know that I stress-tested the at25 driver with KASAN on two ARM64
> platforms, TI AM62 and i.MX8QXP, in the latter case it's even spi-nxp-fspi driver
> only providing spi-mem API, while the TI SoC goes over normal SPI. Up to now it
> went smoothly.
> 
> Christophe, while I'm trying to get my hands on a PPC32 HW similar to yours, would
> you be able to test with CONFIG_DMA_API_DEBUG=y? The fact the KASAN doesn't detect
> anything after the fix to spi-fsl-cpm you've mentioned makes me think the corruption
> is external to CPU core? Will you post you fix to fsl-cpm code?
> 


I'm now back from travelling and have been able to dig more into the 
problem.

So it seems the (only) problem is due to the buffer overrun when t->len 
is over 256 and odd. And it is only on CPM1 (mpc8xx), you won't see it 
on CPM2 (mpx82xx)

It looks like when this overrun is properly fixed the board is stable 
again. The collegue of mine who tried to fix the KASAN report used AI, 
leading to a stupid fix: it just truncated the transfer to the below 
even length, which fixed the KASAN report but created more problems.

The problem was introduced by commit fc96ec826bce ("spi: fsl-cpm: Use 16 
bit mode for large transfers with even size") which fails to check the 
length is even before switching to 16 bits per word. The right fix is:

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 2f2082652a1a2..81d5c3f4eb6fe 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -335,7 +335,7 @@ static int fsl_spi_prepare_message(struct 
spi_controller *ctlr,
  			if (t->bits_per_word == 16 || t->bits_per_word == 32)
  				t->bits_per_word = 8; /* pretend its 8 bits */
  			if (t->bits_per_word == 8 && t->len >= 256 &&
-			    (mpc8xxx_spi->flags & SPI_CPM1))
+			    (t->len & 1) == 0 && (mpc8xxx_spi->flags & SPI_CPM1))
  				t->bits_per_word = 16;
  		}
  	}

Now I'm trying to understand why the problem surfaced with commit 
8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")

Christophe

