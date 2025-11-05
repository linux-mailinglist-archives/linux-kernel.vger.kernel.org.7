Return-Path: <linux-kernel+bounces-887415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3EC382BA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C91904F0360
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433E2F12DF;
	Wed,  5 Nov 2025 22:20:08 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B152F0686
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381207; cv=none; b=IuKc37cEeQulfbxN3NuiflPD3Lm5woImYdMmcqLsfIH2nMOdJDEic2vpSxt6tLMpq0EwiNPABTxqPihPKC85NCKyaBfEf/hMDJfDS4buzWstfakbBRh7XkOpn0UPGGfUuCrZ248ngSHuXUGIiZDNUSlo+5oOl6wn9r7cu3IQtcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381207; c=relaxed/simple;
	bh=JH4ThYL/VcbHYZesbdovgJMfobqqkfsiF3HIQjaCbO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7sJqU2JsQx3sQeQF4DQj3clo1ZuNiTbeAh2ulRVD90okXFytLc1+k+qD3IYwsjxETpGJUlLS1mcyxTyBSdESmEKbFm55nz7BWqXD2FQHvnIHLO8xgoGK8UDCHB9rAK3nN1O/zuUXykA2giF8yRSZSOZYDuT2rRK9Fm0iLW6Edg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d1zPN02rRz9sS7;
	Wed,  5 Nov 2025 22:44:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1GfbrSwd72T; Wed,  5 Nov 2025 22:44:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d1zPM5zM6z9sRg;
	Wed,  5 Nov 2025 22:44:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B8C168B77B;
	Wed,  5 Nov 2025 22:44:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 37srmVnLvJ83; Wed,  5 Nov 2025 22:44:39 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A23768B773;
	Wed,  5 Nov 2025 22:44:38 +0100 (CET)
Message-ID: <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
Date: Wed, 5 Nov 2025 22:44:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] powerpc: Use shared font data
To: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Finn Thain <fthain@linux-m68k.org>
Cc: Stan Johnson <userm57@yahoo.com>, mpe@ellerman.id.au, npiggin@gmail.com,
 sam@ravnborg.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 Cedar Maxwell <cedarmaxwell@mac.com>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <aQgJ95Y3pA-8GdbP@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/11/2025 à 02:48, Dr. David Alan Gilbert a écrit :
> * Finn Thain (fthain@linux-m68k.org) wrote:
>>
>> On Sun, 2 Nov 2025, Dr. David Alan Gilbert wrote:
>>
>>>
>>> So I'm not a PPC person specifically; so lets see if the PPC people have
>>> any suggestions, but:
>>>
>>>     a) Do you know if there's any way to recreate the same hang/works
>>> combination in qemu; I know it has a g3beige model but I don't know how
>>> to get something similar to your failing combo.
>>>
>>
>> I guess we could probably reproduce this in QEMU if the BootX bootloader
>> could be made to work there. In theory, 'qemu-system-ppc -M g3beige' might
>> work.
>>
>>>     b) Can you get any diagnostics out of the prom on the mac?  Like a PC
>>> or anything to have some idea where it hung?
>>>
>>
>> Well, that's the problem: if you enable the CONFIG_BOOTX_TEXT diagnostics,
>> the system hangs instead of printing stuff. If you disable the
>> CONFIG_BOOTX_TEXT diagnostics (in favour of serial diagnostics) the hang
>> goes away.
> 
> Ah, a bug that doesn't like to be seen :-)
> 
>> Anyway, I imagine that the problem with your patch was that it relies on
>> font data from a different (read only) section, which is unavailable for
>> some reason (MMU not fully configured yet?)
>>
>> So I've asked Stan to test a patch that simply removes the relevant
>> 'const' keywords. It's not a solution, but might narrow-down the search.
> 
> I wonder if this is a compiler-flag-ism; I see arch/powerpc/kernel/Makefile
> has a pile of special flags, and for btext.o it has a -fPIC
> (as well as turning off some other flags).
> I wonder if bodging those in lib/fonts/Makefile for lib/fonts/font_sun8x16.c
> fixes it?
> But... this is data - there's no code is there - are any of those flags
> relevant for data only?

I think -fPIC is relevant for data-only here because font_sun_8x16 
contains a pointer to fontdata_sun8x16 in font_sun_8x16.data

I see two things to try:

1/ Either build font_sun8x16.o with -fPIC

diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index e16f68492174a..844306d7b15e9 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -20,3 +20,5 @@ font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
  font-objs += $(font-objs-y)

  obj-$(CONFIG_FONT_SUPPORT)         += font.o
+
+CFLAGS_font_sun8x16.o             += -fPIC

2/ Or add a PTRRELOC:

diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index 7f63f1cdc6c39..fc461cfaf4a34 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -20,6 +20,7 @@
  #include <asm/io.h>
  #include <asm/processor.h>
  #include <asm/udbg.h>
+#include <asm/setup.h>

  #define NO_SCROLL

@@ -463,7 +464,7 @@ static noinline void draw_byte(unsigned char c, long 
locX, long locY)
  {
  	unsigned char *base	= calc_base(locX << 3, locY << 4);
  	unsigned int font_index = c * 16;
-	const unsigned char *font	= font_sun_8x16.data + font_index;
+	const unsigned char *font	= PTRRELOC(font_sun_8x16.data) + font_index;
  	int rb			= dispDeviceRowBytes;

  	rmci_maybe_on();


Christophe



