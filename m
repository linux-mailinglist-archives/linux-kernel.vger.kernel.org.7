Return-Path: <linux-kernel+bounces-776473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3860FB2CDAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53563BBA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E46A3101DA;
	Tue, 19 Aug 2025 20:17:23 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F72571DD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634643; cv=none; b=ZVZQNK+Uvfj+T04mXtwalQxuoBtnbs8i6+XPS05GfXSQy+v77e4SgerFCBsBSBUJo+vjLc8LEISnZzxQZXInDjPiSQFk63byGn+IjmWIKFE6aNpt8FLNA9AA87HWeGnJRKE2XbTPrsT9SpgY6BgFvXIkFVjTmZ3HH3GiyueYfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634643; c=relaxed/simple;
	bh=DH6TL9lt+jX3riwfvSg80uM4qQZNxeVyTXmjA4pV13s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgLB9NiqNJmjRYKIKytB8Uu6/E8Y0uIrMB3DYfUQOm/KmsNa8CCP9oN2j1FBV7elnw1zGOsC9bGp/BCmY2om8KFDxYh+0w2q79F5uzxGi4hZDk3OSuzc9Phg8oEY3uW0MSPjP9M6xYz0e4SGTBvZfpIrbyI1zV3Z31x+waElyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50369449EF;
	Tue, 19 Aug 2025 20:17:08 +0000 (UTC)
Message-ID: <bc3bc5ca-4000-43d6-9019-bae03c65d43c@ghiti.fr>
Date: Tue, 19 Aug 2025 22:17:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header files
To: Thomas Huth <thuth@redhat.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, atish.patra@linux.dev,
 anup@brainfault.org, linux-kernel@vger.kernel.org
References: <20250606070952.498274-1-thuth@redhat.com>
 <175450055499.2863135.2738368758577957268.git-patchwork-notify@kernel.org>
 <d1fe7fdf-b3da-4c53-8a5a-a87acd38d525@redhat.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <d1fe7fdf-b3da-4c53-8a5a-a87acd38d525@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeigedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejieeuudejieekveeutdeguefhkeduledugeevhefffeejudeggedufffgleeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtgeemtggvtgdtmeduvdduugemfhdvfedvmegvfeefmegtfeeitgemvgeisgelmeeiheegugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtgeemtggvtgdtmeduvdduugemfhdvfedvmegvfeefmegtfeeitgemvgeisgelmeeiheegugdphhgvlhhopeglkffrggeimedvrgdtgeemtggvtgdtmeduvdduugemfhdvfedvmegvfeefmegtfeeitgemvgeisgelmeeiheeguggnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepledprhgtphhtthhopehthhhuthhhsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrlhgvgihghhhithhisehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehlihhnuhigq
 dhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegrthhishhhrdhprghtrhgrsehlihhnuhigrdguvghvpdhrtghpthhtoheprghnuhhpsegsrhgrihhnfhgruhhlthdrohhrgh

Hi Thomas,

On 8/18/25 08:08, Thomas Huth wrote:
> On 06/08/2025 19.15, patchwork-bot+linux-riscv@kernel.org wrote:
>> Hello:
>>
>> This series was applied to riscv/linux.git (for-next)
>> by Alexandre Ghiti <alexghiti@rivosinc.com>:
>
>  Hi Alexandre,
>
> I can't see the patches in the for-next branch ... have they been 
> dropped again? Was there an issue with the patches?


No issues with the patches, Linus rejected the riscv PR. I'll send them 
again for 6.18.

Sorry about that,

Alex


>
>  Thanks,
>   Thomas
>
>
>> On Fri,  6 Jun 2025 09:09:50 +0200 you wrote:
>>> The kernel Makefiles define the __ASSEMBLY__ macro to provide
>>> a way to use headers in both, assembly and C source code.
>>> However, all the supported versions of the GCC and Clang compilers
>>> also define the macro __ASSEMBLER__ automatically already when 
>>> compiling
>>> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
>>> With regards to userspace code, this seems also to be constant source
>>> of confusion, see for example these links here:
>>>
>>> [...]
>>
>> Here is the summary with links:
>>    - [v2,1/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi 
>> headers
>>      https://git.kernel.org/riscv/c/c47963980ba6
>>    - [v2,2/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__ in 
>> non-uapi headers
>>      https://git.kernel.org/riscv/c/b5eb1f12a416
>>
>> You are awesome, thank you!
>

