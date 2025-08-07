Return-Path: <linux-kernel+bounces-758998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E4B1D6E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA3A3B1B88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F520B7F9;
	Thu,  7 Aug 2025 11:48:38 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0342AA5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754567317; cv=none; b=UgoT1Hq2HYUYo4SvygFw1Y1yMI6njPs3jfDIi6Cj9dfvfk0kQYlV3yE+pz/oDtjX+CM15VEri7JuiHOgKxmNJkvnCRgCxGGHw2bDuCt7VbRpFoH07AfFP/mvx0KIO+tK5I2orvXvy00hA7bhjCZvmW2nZd/YBU2F8MpZf3Fvh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754567317; c=relaxed/simple;
	bh=hLucHAtcoxzNnq6uP4okoJ9btZ/nwS4PPElq1myj7qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTiaXoz0swIsGejueevbxbB4jGDWnx+8cMyhT8BHG4uAlOstHrH2wKfKGPbvvHoM047C+2rEV+6EBTvr+d8k2t9bfDHU91znBWsDKk3x/y1yW6kb/mpum692PO4M28GwMncxhGoCc2+MEHRVhl7Gz7TErUxReoOMPualzZ52X5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27D4D4318D;
	Thu,  7 Aug 2025 11:48:25 +0000 (UTC)
Message-ID: <d5e49344-e0c2-4095-bd1f-d2d23a8e6534@ghiti.fr>
Date: Thu, 7 Aug 2025 13:48:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:irq/urgent] BUILD REGRESSION
 9f7488f24c7571d349d938061e0ede7a39b65d6b
To: Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>,
 x86-ml <x86@kernel.org>, Marco Bonelli <marco@mebeim.net>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <202508071514.CFNi6mo5-lkp@intel.com> <87h5yjcxqh.ffs@tglx>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <87h5yjcxqh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejkeeugfdthefhveelffdvgeetgeelteeijeekheehfeevtdduvdfgteevgfehffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemlehftghfmeeksghfleemleeludgumeekrggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemlehftghfmeeksghfleemleeludgumeekrggrfhdphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemlehftghfmeeksghfleemleeludgumeekrggrfhgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhto
 hepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhgtohesmhgvsggvihhmrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 8/7/25 11:00, Thomas Gleixner wrote:
> On Thu, Aug 07 2025 at 15:10, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
>> branch HEAD: 9f7488f24c7571d349d938061e0ede7a39b65d6b  irqchip/mvebu-gicp: Use resource_size() for ioremap()
>>
>> Error/Warning (recently discovered and may have been fixed):
>>
>>      https://lore.kernel.org/oe-kbuild-all/202508070607.QKVa8DiU-lkp@intel.com
>>
>>      ERROR: modpost: __ex_table+0x1584 references non-executable section '.rodata.__func__.103779'
>>
>> Error/Warning ids grouped by kconfigs:
>>
>> recent_errors
>> `-- riscv-randconfig-002-20250807
>>      `-- ERROR:__ex_table-references-non-executable-section-.rodata.__func__.
> This has nothing to do with the above commit. That's just a new one
> of the same type as the ones which existed before:
>
> WARNING: modpost: vmlinux: section mismatch in reference: xp_fill_cb+0x46 (section: .text.xp_fill_cb) -> .L62 (section: .init.text)
> ...
> WARNING: modpost: vmlinux: section mismatch in reference: 0x19e4 (section: __ex_table) -> .LASF400 (section: .debug_str)
>
> There are gazillions of them and that's a purely riscv specific related
> problem.


Yes that's a riscv issue that was already reported by Marco [1] who also 
found the underlying issue [2]. The problem is that we emit too many 
relocations which overflow the number of possible relocations in 32-bit. 
After discussion with some riscv gcc folks, it appears to be caused by 
relaxations which, according to the ABI, require the emission of local 
symbol. We don't have a workaround for now and we'll discuss this issue 
with the ABI authors.

[1] 
https://lore.kernel.org/linux-riscv/960240908.630790.1748641210849@privateemail.com/
[2] 
https://lore.kernel.org/all/1714337938.319508.1750244108368@privateemail.com/

Sorry for the noise,

Alex


>
> Thanks,
>
>          tglx
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

