Return-Path: <linux-kernel+bounces-768303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BFCB25F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218131C82C65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90082EA47E;
	Thu, 14 Aug 2025 08:50:37 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9F62EA171
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161437; cv=none; b=HXYmGax+/AncSuvqYtdZhM6AcFKV//Z4y+xR5+hA8rTWZF3RArPY/iSTPzauOKdVYp0JhK/tyUG/HyxtgtbVhFKxCAmwnQtVyhjHKCOiHkj/3xbXgju1LD5zNFFf368sU4UTd8fJ4Y1g1ed2dAVJMsqleAWSfQc59gDHP6rhVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161437; c=relaxed/simple;
	bh=6ZIyyM5zaS7uVMYtvcL6aGUnfvx4uAfg6dCvZifmzYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzZUOMupdYbfAG17Tus2/izJimEvcmUBjrxGdp+4pBEvg4CDDO3JWRl5bXhZUZKKr6AvbTbmvW3yhU4TFBkYzuYr9cuOMBvKrbHTBDKYkjvWSd4/a38eNfK5VucThTlZoxr2jbjj3GB/jNmrLgJC+M4366H/8pAldTy6Zky5NTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c2dnG3Xs7z9sSL;
	Thu, 14 Aug 2025 10:33:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1tkUzicEPWcZ; Thu, 14 Aug 2025 10:33:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c2dnG2pKsz9sSK;
	Thu, 14 Aug 2025 10:33:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 472C48B764;
	Thu, 14 Aug 2025 10:33:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PmUnmtuep_BF; Thu, 14 Aug 2025 10:33:54 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D38D28B763;
	Thu, 14 Aug 2025 10:33:53 +0200 (CEST)
Message-ID: <52be7ae1-34f7-49ef-80b0-0eb6577205ff@csgroup.eu>
Date: Thu, 14 Aug 2025 10:33:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] powerpc/8xx: Drop legacy-of-mm-gpiochip.h header
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
References: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20241118123254.620519-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andy,

Le 18/11/2024 à 13:31, Andy Shevchenko a écrit :
> Remove legacy-of-mm-gpiochip.h header file. The above mentioned
> file provides an OF API that's deprecated. There is no agnostic
> alternatives to it and we have to open code the logic which was
> hidden behind of_mm_gpiochip_add_data(). Note, most of the GPIO
> drivers are using their own labeling schemas and resource retrieval
> that only a few may gain of the code deduplication, so whenever
> alternative is appear we can move drivers again to use that one.
> 
> As a side effect this change fixes a potential memory leak on
> an error path, if of_mm_gpiochip_add_data() fails.

Is there a reason for having done this change in cpm1_gpiochip_add16() 
and cpm1_gpiochip_add32() [arch/powerpc/platform/8xx/cpm1.c] and not in 
cpm2_gpiochip_add32() [arch/powerpc/sysdev/cpm_common.c] while all three 
functions are called from cpm_gpio_probe() 
[arch/powerpc/sysdev/cpm_gpio.c] ?

Christophe


