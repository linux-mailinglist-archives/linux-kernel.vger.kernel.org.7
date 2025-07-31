Return-Path: <linux-kernel+bounces-752158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1056B171F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE485854E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFD02C08C1;
	Thu, 31 Jul 2025 13:22:50 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2FA94A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968170; cv=none; b=i9czwmfsIXaqcSS/r8fWUlJCaA2mP07wk0ZSXlqRrf99+2U4I6r3DEDdlRF69I/aqUY8/neRJVxfOMfNGNAvJPQlaG7thEegjVjReFopOKHZ4hDRvGIa7yX+upuFaQlczNkNIatgh5+HkOBXQsI9BVRCqXTepAl6DfOw4+I4KH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968170; c=relaxed/simple;
	bh=ep/OEVqOp0Lmx4zF3EqHLaMQIkD2/HCDEHG6behDgiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKrS+Y3/UV9IYx6sZCA6R37hTbhldocsPw5uW0HHtbT0A8OJQqR/sPQ2MtOFvOkP/G20s5jKecmviHBZslI/Ojhzr2DJDnFZ9sLL9Vhkof2ZALNddh/R7gZ6lmDhlVHISnZ0s4D5LPgVC4LBdly9tbpd10WLiXjGWPu1nETHOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19E654427A;
	Thu, 31 Jul 2025 13:22:43 +0000 (UTC)
Message-ID: <07628b61-ba33-49e7-80e9-d9c5312997fe@ghiti.fr>
Date: Thu, 31 Jul 2025 15:22:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] riscv: minor thread_info.cpu improvements
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Deepak Gupta <debug@rivosinc.com>
References: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeejieeuudejieekveeutdeguefhkeduledugeevhefffeejudeggedufffgleeugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemuddtjeefmegslegsgeemjegvtgekmeehhegutdemgehfvddvmeeigedvkedphhgvlhhopeglkffrggeimedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheprhhkrhgtmhgrrhesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguv
 ggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepuggvsghughesrhhivhhoshhinhgtrdgtohhm

Hi Radim,

On 7/25/25 18:54, Radim Krčmář wrote:
> Hello,
>
> I noticed that we give thread_info.cpu two different names in the
> assembly, load it as a wider type, and store it suboptimally.
>
> v2 is split for easy backporting.
>
> Thanks.
>
> v2:
> * transform [v1 2/3] into [v2 1-2/4] to simplify backports [Alex]
> * tested and reviewed by Alex
> v1: https://lore.kernel.org/lkml/20250722160556.2216925-2-rkrcmar@ventanamicro.com/
>
> Radim Krčmář (4):
>    riscv: use lw when reading int cpu in new_vmalloc_check
>    riscv: use lw when reading int cpu in asm_per_cpu
>    riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
>    riscv: pack rv64 thread_info better
>
>   arch/riscv/include/asm/asm.h         | 2 +-
>   arch/riscv/include/asm/thread_info.h | 2 +-
>   arch/riscv/kernel/asm-offsets.c      | 1 -
>   arch/riscv/kernel/entry.S            | 2 +-
>   4 files changed, 3 insertions(+), 4 deletions(-)
>

Thanks for the quick respin, I'll take that for 6.17.

Thanks,

Alex


