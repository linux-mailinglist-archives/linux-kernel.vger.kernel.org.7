Return-Path: <linux-kernel+bounces-789256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104C8B392D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FC237B0B88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8EB1DE3B7;
	Thu, 28 Aug 2025 05:20:36 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A00347C3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756358435; cv=none; b=SOY00P1oFhEEUNus7xfAdv2V9QVaAU2hxRue1LXEJgaDywKRQmluL1gtf8+WNtx596lbLVKIgMi5ojHiNbsNm+MHtwYvNFnfxIGUGMBINOBmjp+QBKPRQSSN8uTtz9JKhV02lC9b36NMiSM8EpVkwjQhUHG4VbSwe0sdl2U8UW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756358435; c=relaxed/simple;
	bh=aGssaD5mfKRD/M7jHhUYvOKit/yKbzr9eL8qZRi9q2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sez2QqAHoWm7pI7jHQpc7+LEyRWEEs/lnBgsxckANWTppUr7fuasI3DJdLXPfATpUR+QAn4XWK5TXsz5VNm2b9sWCEbxBxO4oIiVVXTedqyqIEg23HxSnUrq2qcdJGrTbcC2TMjMrpVYUTV6WUpeTvNmeM2R0gdoVQ6I/P+vUFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cC89c3Sp9z9sS7;
	Thu, 28 Aug 2025 06:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ma-oCaIkKbZ1; Thu, 28 Aug 2025 06:51:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cC89c2dhnz9sRy;
	Thu, 28 Aug 2025 06:51:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3EDDA8B764;
	Thu, 28 Aug 2025 06:51:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QunPaQfOtMZw; Thu, 28 Aug 2025 06:51:00 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F266E8B763;
	Thu, 28 Aug 2025 06:50:59 +0200 (CEST)
Message-ID: <4c7e5a00-87dd-4836-a57e-45282ddf4c0b@csgroup.eu>
Date: Thu, 28 Aug 2025 06:50:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/powernv: Rename pe_level_printk to pe_printk and
 embed KERN_LEVEL in format
To: Joe Perches <joe@perches.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <df3a7ca31d2002ca447ab062f5b5e32ced9bec85.camel@perches.com>
 <732ae03a-f0a7-450c-8896-e8a4975a5254@csgroup.eu>
 <5b914354f29e58097e373dde76ee26b246a64ce6.camel@perches.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <5b914354f29e58097e373dde76ee26b246a64ce6.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2025 à 02:04, Joe Perches a écrit :
> [Vous ne recevez pas souvent de courriers de joe@perches.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Wed, 2025-08-27 at 18:42 +0200, Christophe Leroy wrote:
>> Hi Joe
>>
>> Le 21/06/2019 à 07:36, Joe Perches a écrit :
>>> Remove the separate KERN_<LEVEL> from each pe_level_printk and
>>> instead add the KERN_<LEVEL> to the format.
> 
> Hello Christophe.
> 
> It's over 6 years since I wrote that.
> Is that the typical review time? ;)

:)

I'm trying to clean patchwork and drop stale patches that are still 
there. At the moment we have 240 'new' patches. 88 of them are older 
than one year, with a few older ones being almost 10 years old.

> 
> I would expect it doesn't apply anyway
> though it should make the object size
> a tiny bit smaller.

It still applies when doing a 3-way merge indeed.

Christophe

