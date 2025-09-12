Return-Path: <linux-kernel+bounces-814156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D0BB55006
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39352164104
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3030DED0;
	Fri, 12 Sep 2025 13:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067C14EC62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685036; cv=none; b=NnU/jvR6uMcMU2Ft/1+P48uRBSvArRV/rtRryp0F9FXBpiekhiKZfmBrsF8ei/MBEVpCjwSQrSnSyeP48Sd6QD6M0BawYBTsMPFhrb4eIkpQlAfn4oSp2pDITaAhYNe4pP8wkC40fqAo3wRpk18+wCl4eNJnpO/z4h/N7lCH5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685036; c=relaxed/simple;
	bh=neSgLYdM9N09DtH248eIShadedDlU7L6yXq+VjAnkes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUY825MTPy4c+r5LxK8ZLNaOfl5WuQTzz0B/OGvYUGsZx9WuJJgGBFRF+h1++Mr9SNWZ2PhlMS+ng0Lz98lbeMGQmAMyZhsqhju3oQuAZZARb6YyFH0Jd4f9RQ2F7Qe8eZRz+YlYlAqou4Bwfv1ZpML5ofaYZ6lB/9gltlz15BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cNb583xjNz9sj9;
	Fri, 12 Sep 2025 15:34:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0ANH-naw3LRi; Fri, 12 Sep 2025 15:34:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cNb5837Bsz9sj8;
	Fri, 12 Sep 2025 15:34:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 507FB8B7A7;
	Fri, 12 Sep 2025 15:34:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id U1ZvI99EDa4A; Fri, 12 Sep 2025 15:34:52 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 33E138B764;
	Fri, 12 Sep 2025 15:34:51 +0200 (CEST)
Message-ID: <73b75b17-adde-44f0-b252-5a7ea2f9d138@csgroup.eu>
Date: Fri, 12 Sep 2025 15:34:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] powerpc/32: Fix unpaired stwcx. on interrupt exit
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <6040b5dbcf5cdaa1cd919fcf0790f12974ea6e5a.1757666244.git.christophe.leroy@csgroup.eu>
 <aMQfD5M5yNmYxLho@gate>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <aMQfD5M5yNmYxLho@gate>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Segher,

Le 12/09/2025 à 15:24, Segher Boessenkool a écrit :
> Hi!
> 
> On Fri, Sep 12, 2025 at 10:37:34AM +0200, Christophe Leroy wrote:
>>   BEGIN_FTR_SECTION
>> +	lwarx   r0,0,r1
>> +END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>>   	stwcx.	r0,0,r1		/* to clear the reservation */
>> -FTR_SECTION_ELSE
>> -	lwarx	r0,0,r1
>> -ALT_FTR_SECTION_END_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
> 
> Hrm.  So this is for V'ger (mpc7450)?  What kind of issues does that
> old thing have with unpaired larx/stcx., some performance impact?

No idea, The original commit (from 2007) only says "some processors can 
have issues if this stwcx to address A occurs while the reservation is 
already held to a different address B".

> 
> The extra "dummy" larx has serious performance impact itself, on most
> implementations (also on all newer stuff).

To be honnest I don't know. I just discovered I made a mistake when I 
implemented C interrupt exit and this patch is aiming at restoring the 
previous behaviour.

If you think this is pointless then no problem, I can instead just 
remove the impossible case and that's it.

What is odd to begin with is that we have two features that seems to 
address the same problem but in a slightly different way
- CPU_FTR_NEED_PAIRED_STWCX for PPC32
- CPU_FTR_STCX_CHECKS_ADDRESS for PPC64

What do you recommend ?

Christophe

