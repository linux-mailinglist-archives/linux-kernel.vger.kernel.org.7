Return-Path: <linux-kernel+bounces-888144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06442C39F85
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FBB3B2E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD1C30DED7;
	Thu,  6 Nov 2025 09:50:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7235A2E6CA6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422606; cv=none; b=I8CugEJtWpwqkyjdQ+XP/GQ4AnYSWg3oJQ7AL8AadWm8J/IgrB2ljQyZhnzM8p2epmwCkF1AKlqnQ4WMFcZpzyQg82HVVw3VfOsWjFitQnnk9dCJ3G04p93DU+mw8Bj/1KA48uaXeiTVKNXjkwyAq2fua9RHICO7Vs0JIgJ+dP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422606; c=relaxed/simple;
	bh=bnJDi7GETiYUPS32zPGfoTvP1JsoBPSsJZuoaB5Gr5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZaAVI6WDLEYdsozOHUD6EvsJXmUnNAOaP3+V3byBmqlbWscvdrgmAUA8VSlb1OI+PzsjXaNL0nrhcy4515efdiZSTEUMB9eGofJyeUaVlIFaNsE7rFux0PTN3KQKK41TGt1Gnaxvh7IQOc/ZjSghGhe13M6K/tHSvqLXtUtsYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2H1v58zTz9sSV;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kAhLEPwwxtXU; Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2H1v4Sh9z9sSS;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 88B0E8B77B;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id pF7VBQ2TqCs8; Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2177C8B773;
	Thu,  6 Nov 2025 10:28:51 +0100 (CET)
Message-ID: <994bea8c-7b28-4aae-a6b3-e4f33731cb29@csgroup.eu>
Date: Thu, 6 Nov 2025 10:28:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] powerpc: Use shared font data
To: Finn Thain <fthain@linux-m68k.org>, Stan Johnson <userm57@yahoo.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, sam@ravnborg.org,
 benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org,
 Cedar Maxwell <cedarmaxwell@mac.com>,
 "maddy@linux.ibm.com" <maddy@linux.ibm.com>
References: <20230825142754.1487900-1-linux@treblig.org>
 <d81ddca8-c5ee-d583-d579-02b19ed95301@yahoo.com> <aQeQYNANzlTqJZdR@gallifrey>
 <20108eef-b7cf-3f23-264a-5d97021f9ffa@linux-m68k.org>
 <aQgJ95Y3pA-8GdbP@gallifrey>
 <3cc3d311-35b0-42f1-b20f-ed59391bb8e0@csgroup.eu>
 <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <ead4ef3f-9f8c-a98e-b48d-f052bc9492d0@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/11/2025 à 05:11, Finn Thain a écrit :
> 
> On Wed, 5 Nov 2025, Christophe Leroy wrote:
> 
>> 1/ Either build font_sun8x16.o with -fPIC
>> ...
>>
>> 2/ Or add a PTRRELOC:
>> ...
> 
> Thanks for your help with this, Christophe.
> 
> I fixed up the whitespace problems and forwarded those patches to Stan,
> along with instructions for applying them. He tells me that patch 2 fixed
> the hang. Patch 1 did not.

Fine. Then let's use PTRRELOC.

Will you or David submit the patch ?

Thanks
Christophe

