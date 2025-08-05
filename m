Return-Path: <linux-kernel+bounces-756139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D3B1B075
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11823162048
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772625744D;
	Tue,  5 Aug 2025 08:50:49 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB773987D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383848; cv=none; b=I++khRNL8uJmfb2a5bmmnygEsyjIREdFQEgJwWbtQMu7X2GUnApar2wCmrgdHPfxUEmEtYKAsRmmNFAx8Dj+TbasIwMnqZ41MFi9t3xbZRTR9dTkCGs5PMzo0AbhZQCMGWYmLtwrY6q7S806JOZkWJLXBO0evCcZ9aePQtOq9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383848; c=relaxed/simple;
	bh=hLeoxwhcTLd+s8Nhv5QdosvfSHOr/o5XZrt+mlV+0Ps=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JLTJCzGTAeHTEb34++aRsmEPUc+K4FvVUQP/mMXngf4vZ6amqwygb/d1kQg/xWW3dfO5+O+pAWpd020/Z//6xah3AkM1zcUWSA5tfm4K0+6rdgloM4Y1CrRCY6jV3G112YRyLRxkluEK9j8TeocyDJ3FsfdS7JGREUs4PladT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A8EC4388A;
	Tue,  5 Aug 2025 08:50:40 +0000 (UTC)
Message-ID: <b6fc0e5f-beff-45fb-9f93-822b72094c17@ghiti.fr>
Date: Tue, 5 Aug 2025 10:50:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: cacheinfo: init cache levels via fetch_cache_info
 when SMP disabled
From: Alexandre Ghiti <alex@ghiti.fr>
To: liu.xuemei1@zte.com.cn, paul.walmsley@sifive.com
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, spersvold@gmail.com,
 sudeep.holla@arm.com, mikisabate@gmail.com, robh@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250801093201232CYacRrFIHaDJWsjc3rbNz@zte.com.cn>
 <ffb83627-bd28-4bf9-8051-57dfca407f87@ghiti.fr>
Content-Language: en-US
In-Reply-To: <ffb83627-bd28-4bf9-8051-57dfca407f87@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepledtffekgeffleehkedvgfelleefffetjeegueffgeeilefgvdfhteetueejgeeknecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppeduleefrdeffedrheejrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelfedrfeefrdehjedrudelledphhgvlhhopegludelvddrudeikedrvddvrddutddungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhurdiguhgvmhgvihduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepshhpvghrshhvohhlugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhguvggvphdrhhhol
 hhlrgesrghrmhdrtghomhdprhgtphhtthhopehmihhkihhsrggsrghtvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg

Hi Jessica,

On 8/1/25 13:45, Alexandre Ghiti wrote:
> Hi Jessica,
>
> On 8/1/25 03:32, liu.xuemei1@zte.com.cn wrote:
>>
>> On 7/31/25 21:29, alex@ghiti.fr wrote:
>>
>> > > From: Jessica Liu <liu.xuemei1@zte.com.cn>
>>
>> > >
>>
>> > > As described in commit 1845d381f280 ("riscv: cacheinfo: Add back
>>
>> > > init_cache_level() function"), when CONFIG_SMP is undefined, the 
>> cache
>>
>> > > hierarchy detection needs to be performed through the 
>> init_cache_level(),
>>
>> > > whereas when CONFIG_SMP is defined, this detection is handled 
>> during the
>>
>> > > init_cpu_topology() process.
>>
>> > >
>>
>> > > Furthermore, while commit 66381d36771e ("RISC-V: Select ACPI PPTT 
>> drivers")
>>
>> > > enables cache information retrieval through the ACPI PPTT table, the
>>
>> > > init_of_cache_level() called within init_cache_level() cannot 
>> support cache
>>
>> > > hierarchy detection through ACPI PPTT. Therefore, when CONFIG_SMP is
>>
>> > > undefined, we directly invoke the fetch_cache_info function to 
>> initialize
>>
>> > > the cache levels.
>>
>> > >
>>
>> > > Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
>>
>> > > ---
>>
>> > >   arch/riscv/kernel/cacheinfo.c | 6 +++++-
>>
>> > >   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> > >
>>
>> > > diff --git a/arch/riscv/kernel/cacheinfo.c 
>> b/arch/riscv/kernel/cacheinfo.c
>>
>> > > index 26b085dbdd07..f81ca963d177 100644
>>
>> > > --- a/arch/riscv/kernel/cacheinfo.c
>>
>> > > +++ b/arch/riscv/kernel/cacheinfo.c
>>
>> > > @@ -73,7 +73,11 @@ static void ci_leaf_init(struct cacheinfo 
>> *this_leaf,
>>
>> > >
>>
>> > >   int init_cache_level(unsigned int cpu)
>>
>> > >   {
>>
>> > > -    return init_of_cache_level(cpu);
>>
>> > > +#ifdef CONFIG_SMP
>>
>> > > +    return 0;
>>
>> > > +#endif
>>
>> > > +
>>
>> > > +    return fetch_cache_info(cpu);
>>
>> > >   }
>>
>> > >
>>
>> > >   int populate_cache_leaves(unsigned int cpu)
>>
>> >
>>
>> >
>>
>> > Is the current behaviour wrong or just redundant? If wrong, I'll add a
>>
>> > Fixes tag to backport, otherwise I won't.
>>
>> >
>>
>> > Thanks,
>>
>> >
>>
>> > Alex
>>
>>
>> Hi Alex,
>>
>>
>> The current behavior is actually wrong when using ACPI on !CONFIG_SMP
>>
>> systems. The original init_of_cache_level() cannot detect cache 
>> hierarchy
>>
>> through ACPI PPTT table, which means cache information would be missing
>>
>> in this configuration.
>>
>>
>> The patch fixes this by directly calling fetch_cache_info() when
>>
>> CONFIG_SMP is undefined, which properly handles both DT and ACPI cases.
>>
>>
>> So yes, it would be appropriate to add a Fixes tag. The commit being
>>
>> fixed is 1845d381f280 ("riscv: cacheinfo: Add back init_cache_level() 
>> function").
>>
>>
>> Please let me know if you need any additional information.
>>
>
> I'm about to send my first PR for 6.17 so I'll delay merging this one 
> for the first rc.


So I took the time this morning to look into this, and I don't really 
like the different treatment for smp, can't we just move 
init_cpu_topology() call to setup_arch() (or else) for both !smp and smp?

Thanks,

Alex


>
> Thanks for the explanation,
>
> Alex
>
>
>>
>> Best regards,
>>
>> Jessica
>>
>>
>>
>>
>>
>>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

