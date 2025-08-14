Return-Path: <linux-kernel+bounces-768232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE76B25E90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A0B71C80734
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E752E7633;
	Thu, 14 Aug 2025 08:16:15 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48383CD1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755159374; cv=none; b=Cbu1Hvhv+katefr8Ikc3ICIaD7C9xfAadFAixa/UAZy+Trnoa6WxMHxZja/fZbk3qVRSh3UMNTIsp7HFLyIkZdGeIiYkpxA1cW0GP9UduKT48mCg2FjhA+k5vdIJrZSY9VCP9kg+eoHrr70vBc5VaGSr/2Kwq6S9BzhSav2DUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755159374; c=relaxed/simple;
	bh=D8achbcoVMkGQQu9jch9Hu1D9Go29DH78PlT4IZj0x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaIhSqzH3HablDaxEmS1F6KFWcJHPnZuXe+npZyloB9MPsQZT05xYUoDRDc4bxwtTIcczF3IxyAiI7yYl/qtmLt1H3drhcoc3dI6f0lcgVOzbsxkvM0FedtRNrqH7/GQ5eWLHZP7ZeJCGmwWVdWMOuEfE5M+zA8YgNsS1LYa3uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E19F81F68E;
	Thu, 14 Aug 2025 08:16:06 +0000 (UTC)
Message-ID: <91570387-4da1-4b26-a274-bed1c59ef12f@ghiti.fr>
Date: Thu, 14 Aug 2025 10:16:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: cacheinfo: init cache levels via fetch_cache_info
 when SMP disabled
To: liu.xuemei1@zte.com.cn, paul.walmsley@sifive.com
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, spersvold@gmail.com,
 sudeep.holla@arm.com, mikisabate@gmail.com, robh@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250814092936030rQLylo3a7HXUWKIniqFy1@zte.com.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250814092936030rQLylo3a7HXUWKIniqFy1@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppeduleefrdeffedrheejrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelfedrfeefrdehjedrudelledphhgvlhhopegludelvddrudeikedrvddvrddutddungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhurdiguhgvmhgvihduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepshhpvghrshhvohhlugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopehmihhki
 hhsrggsrghtvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Jessica,

On 8/14/25 03:29, liu.xuemei1@zte.com.cn wrote:
>
> Hi Alex,
>
>
> >> Hi Jessica,
>
> >>
>
> >> On 8/1/25 03:32, liu.xuemei1@zte.com.cn wrote:
>
> >>>
>
> >>> On 7/31/25 21:29, alex@ghiti.fr wrote:
>
> >>>
>
> >>> > > From: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> >>>
>
> >>> > >
>
> >>>
>
> >>> > > As described in commit 1845d381f280 ("riscv: cacheinfo: Add back
>
> >>>
>
> >>> > > init_cache_level() function"), when CONFIG_SMP is undefined, the
>
> >>> cache
>
> >>>
>
> >>> > > hierarchy detection needs to be performed through the
>
> >>> init_cache_level(),
>
> >>>
>
> >>> > > whereas when CONFIG_SMP is defined, this detection is handled
>
> >>> during the
>
> >>>
>
> >>> > > init_cpu_topology() process.
>
> >>>
>
> >>> > >
>
> >>>
>
> >>> > > Furthermore, while commit 66381d36771e ("RISC-V: Select ACPI PPTT
>
> >>> drivers")
>
> >>>
>
> >>> > > enables cache information retrieval through the ACPI PPTT 
> table, the
>
> >>>
>
> >>> > > init_of_cache_level() called within init_cache_level() cannot
>
> >>> support cache
>
> >>>
>
> >>> > > hierarchy detection through ACPI PPTT. Therefore, when 
> CONFIG_SMP is
>
> >>>
>
> >>> > > undefined, we directly invoke the fetch_cache_info function to
>
> >>> initialize
>
> >>>
>
> >>> > > the cache levels.
>
> >>>
>
> >>> > >
>
> >>>
>
> >>> > > Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> >>>
>
> >>> > > ---
>
> >>>
>
> >>> > >   arch/riscv/kernel/cacheinfo.c | 6 +++++-
>
> >>>
>
> >>> > >   1 file changed, 5 insertions(+), 1 deletion(-)
>
> >>>
>
> >>> > >
>
> >>>
>
> >>> > > diff --git a/arch/riscv/kernel/cacheinfo.c
>
> >>> b/arch/riscv/kernel/cacheinfo.c
>
> >>>
>
> >>> > > index 26b085dbdd07..f81ca963d177 100644
>
> >>>
>
> >>> > > --- a/arch/riscv/kernel/cacheinfo.c
>
> >>>
>
> >>> > > +++ b/arch/riscv/kernel/cacheinfo.c
>
> >>>
>
> >>> > > @@ -73,7 +73,11 @@ static void ci_leaf_init(struct cacheinfo
>
> >>> *this_leaf,
>
> >>>
>
> >>> > >
>
> >>>
>
> >>> > >   int init_cache_level(unsigned int cpu)
>
> >>>
>
> >>> > >   {
>
> >>>
>
> >>> > > -    return init_of_cache_level(cpu);
>
> >>>
>
> >>> > > +#ifdef CONFIG_SMP
>
> >>>
>
> >>> > > +    return 0;
>
> >>>
>
> >>> > > +#endif
>
> >>>
>
> >>> > > +
>
> >>>
>
> >>> > > +    return fetch_cache_info(cpu);
>
> >>>
>
> >>> > >   }
>
> >>>
>
> >>> > >
>
> >>>
>
> >>> > >   int populate_cache_leaves(unsigned int cpu)
>
> >>>
>
> >>> >
>
> >>>
>
> >>> >
>
> >>>
>
> >>> > Is the current behaviour wrong or just redundant? If wrong, I'll 
> add a
>
> >>>
>
> >>> > Fixes tag to backport, otherwise I won't.
>
> >>>
>
> >>> >
>
> >>>
>
> >>> > Thanks,
>
> >>>
>
> >>> >
>
> >>>
>
> >>> > Alex
>
> >>>
>
> >>>
>
> >>> Hi Alex,
>
> >>>
>
> >>>
>
> >>> The current behavior is actually wrong when using ACPI on !CONFIG_SMP
>
> >>>
>
> >>> systems. The original init_of_cache_level() cannot detect cache
>
> >>> hierarchy
>
> >>>
>
> >>> through ACPI PPTT table, which means cache information would be 
> missing
>
> >>>
>
> >>> in this configuration.
>
> >>>
>
> >>>
>
> >>> The patch fixes this by directly calling fetch_cache_info() when
>
> >>>
>
> >>> CONFIG_SMP is undefined, which properly handles both DT and ACPI 
> cases..
>
> >>>
>
> >>>
>
> >>> So yes, it would be appropriate to add a Fixes tag. The commit being
>
> >>>
>
> >>> fixed is 1845d381f280 ("riscv: cacheinfo: Add back init_cache_level()
>
> >>> function").
>
> >>>
>
> >>>
>
> >>> Please let me know if you need any additional information.
>
> >>>
>
> >>
>
> >> I'm about to send my first PR for 6.17 so I'll delay merging this one
>
> >> for the first rc.
>
> >
>
> >
>
> >So I took the time this morning to look into this, and I don't really
>
> >like the different treatment for smp, can't we just move
>
> >init_cpu_topology() call to setup_arch() (or else) for both !smp and smp?
>
> >
>
> >Thanks,
>
> >
>
> >Alex
>
>
> Thank you for your feedback and suggestion. I understand your desire
>
> to have a unified approach for both SMP and !SMP. However, after
>
> careful consideration, I still believe that handling them separately
>
> is the more appropriate solution.
>
>
> The current method of obtaining cache information in
>
> `init_cpu_topology()` is specific to RISC-V and ARM64. If we move
>
> `init_cpu_topology()` to cover both SMP and !SMP, it may require
>
> modifying the generic boot sequence. This could inadvertently affect
>
> other architectures that do not rely on `init_cpu_topology()` for
>
> cache initialization, leading to potential regressions and maintenance
>
> issues.
>
>
> The `setup_arch()` function is called early in the boot process,
>
> and at this stage, the ACPI subsystem has not been fully initialized.
>
> Specifically, the ACPI tables (including PPTT) are not yet parsed.
>
> Therefore, if we call `init_cpu_topology()` from `setup_arch()`, it
>
> would not be able to retrieve cache information from the ACPI PPTT table.
>
>
> I hope this clarifies my train of thought. I'm open to further 
> discussion and
>
> alternative suggestions that can address the issue properly.
>

To me it does not make sense to retrieve the cache info at 2 different 
points in time if the system is smp or not. I still think we should find 
a common place where init_cpu_topology() can be called for both smp and 
up, setup_arch() could not be the right place for the reasons you gave, 
but we just need to find the right one :)

Thanks for working on this,

Alex


>
> Best regards,
>
> Jessica
>
>
>
>
>
>

