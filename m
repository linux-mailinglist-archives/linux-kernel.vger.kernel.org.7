Return-Path: <linux-kernel+bounces-795659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AB3B3F605
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E3F1484766
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352F1C8FE;
	Tue,  2 Sep 2025 06:55:42 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F702AF1B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796141; cv=none; b=XOSpozSDOBCvr3GbSZi59V1fRjy80MKOiLCZz3STX9J/R/FXV+ctPPDOdENb8N3xF1HtbnSZFTlRrO9sMzXWj1J6BEe4LjhHNac1c8ZjDfN3UXiBP/p/t9gDaQpI+8KJhqHcUphdlcTfjhkAOttixnUE6FfkXrlYrwVF31T6X8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796141; c=relaxed/simple;
	bh=a2TX6V7qR4EZB6IwDc8aeRHzVD7f96/pD1jgYNgiAcE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rNmqXgtVcQcxV/m9JdPvl7wPMYY4dSSTGFhmM2Xk4lgJJHvhOE2JZQuNmdYXQGVsJTrKSZLDSlPe8jbfZ4k65sypviV7SqQFMZHlIeR6ozfzPG0mAyP9OG5SXOY3TF3pjqfTGnm2AWQ48aaI4vgC97Xa/5HM/p52xtEHIdftZnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4AA281F74D;
	Tue,  2 Sep 2025 06:55:26 +0000 (UTC)
Message-ID: <aad3213b-1dcd-4619-9719-fa4585012cc8@ghiti.fr>
Date: Tue, 2 Sep 2025 08:55:24 +0200
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
References: <20250814092936030rQLylo3a7HXUWKIniqFy1@zte.com.cn>
 <91570387-4da1-4b26-a274-bed1c59ef12f@ghiti.fr>
Content-Language: en-US
In-Reply-To: <91570387-4da1-4b26-a274-bed1c59ef12f@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleegfeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepledtffekgeffleehkedvgfelleefffetjeegueffgeeilefgvdfhteetueejgeeknecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppedukeehrddvudefrdduheegrddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudekhedrvddufedrudehgedrudegiedphhgvlhhopegluddtrddugedrtddrvdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhiuhdrgihuvghmvghiudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehsphgvrhhsvhholhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhll
 hgrsegrrhhmrdgtohhmpdhrtghpthhtohepmhhikhhishgrsggrthgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Jessica,

On 8/14/25 10:16, Alexandre Ghiti wrote:
> Hi Jessica,
>
> On 8/14/25 03:29, liu.xuemei1@zte.com.cn wrote:
>>
>> Hi Alex,
>>
>>
>> >> Hi Jessica,
>>
>> >>
>>
>> >> On 8/1/25 03:32, liu.xuemei1@zte.com.cn wrote:
>>
>> >>>
>>
>> >>> On 7/31/25 21:29, alex@ghiti.fr wrote:
>>
>> >>>
>>
>> >>> > > From: Jessica Liu <liu.xuemei1@zte.com.cn>
>>
>> >>>
>>
>> >>> > >
>>
>> >>>
>>
>> >>> > > As described in commit 1845d381f280 ("riscv: cacheinfo: Add back
>>
>> >>>
>>
>> >>> > > init_cache_level() function"), when CONFIG_SMP is undefined, the
>>
>> >>> cache
>>
>> >>>
>>
>> >>> > > hierarchy detection needs to be performed through the
>>
>> >>> init_cache_level(),
>>
>> >>>
>>
>> >>> > > whereas when CONFIG_SMP is defined, this detection is handled
>>
>> >>> during the
>>
>> >>>
>>
>> >>> > > init_cpu_topology() process.
>>
>> >>>
>>
>> >>> > >
>>
>> >>>
>>
>> >>> > > Furthermore, while commit 66381d36771e ("RISC-V: Select ACPI 
>> PPTT
>>
>> >>> drivers")
>>
>> >>>
>>
>> >>> > > enables cache information retrieval through the ACPI PPTT 
>> table, the
>>
>> >>>
>>
>> >>> > > init_of_cache_level() called within init_cache_level() cannot
>>
>> >>> support cache
>>
>> >>>
>>
>> >>> > > hierarchy detection through ACPI PPTT. Therefore, when 
>> CONFIG_SMP is
>>
>> >>>
>>
>> >>> > > undefined, we directly invoke the fetch_cache_info function to
>>
>> >>> initialize
>>
>> >>>
>>
>> >>> > > the cache levels.
>>
>> >>>
>>
>> >>> > >
>>
>> >>>
>>
>> >>> > > Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
>>
>> >>>
>>
>> >>> > > ---
>>
>> >>>
>>
>> >>> > >   arch/riscv/kernel/cacheinfo.c | 6 +++++-
>>
>> >>>
>>
>> >>> > >   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> >>>
>>
>> >>> > >
>>
>> >>>
>>
>> >>> > > diff --git a/arch/riscv/kernel/cacheinfo.c
>>
>> >>> b/arch/riscv/kernel/cacheinfo.c
>>
>> >>>
>>
>> >>> > > index 26b085dbdd07..f81ca963d177 100644
>>
>> >>>
>>
>> >>> > > --- a/arch/riscv/kernel/cacheinfo.c
>>
>> >>>
>>
>> >>> > > +++ b/arch/riscv/kernel/cacheinfo.c
>>
>> >>>
>>
>> >>> > > @@ -73,7 +73,11 @@ static void ci_leaf_init(struct cacheinfo
>>
>> >>> *this_leaf,
>>
>> >>>
>>
>> >>> > >
>>
>> >>>
>>
>> >>> > >   int init_cache_level(unsigned int cpu)
>>
>> >>>
>>
>> >>> > >   {
>>
>> >>>
>>
>> >>> > > -    return init_of_cache_level(cpu);
>>
>> >>>
>>
>> >>> > > +#ifdef CONFIG_SMP
>>
>> >>>
>>
>> >>> > > +    return 0;
>>
>> >>>
>>
>> >>> > > +#endif
>>
>> >>>
>>
>> >>> > > +
>>
>> >>>
>>
>> >>> > > +    return fetch_cache_info(cpu);
>>
>> >>>
>>
>> >>> > >   }
>>
>> >>>
>>
>> >>> > >
>>
>> >>>
>>
>> >>> > >   int populate_cache_leaves(unsigned int cpu)
>>
>> >>>
>>
>> >>> >
>>
>> >>>
>>
>> >>> >
>>
>> >>>
>>
>> >>> > Is the current behaviour wrong or just redundant? If wrong, 
>> I'll add a
>>
>> >>>
>>
>> >>> > Fixes tag to backport, otherwise I won't.
>>
>> >>>
>>
>> >>> >
>>
>> >>>
>>
>> >>> > Thanks,
>>
>> >>>
>>
>> >>> >
>>
>> >>>
>>
>> >>> > Alex
>>
>> >>>
>>
>> >>>
>>
>> >>> Hi Alex,
>>
>> >>>
>>
>> >>>
>>
>> >>> The current behavior is actually wrong when using ACPI on 
>> !CONFIG_SMP
>>
>> >>>
>>
>> >>> systems. The original init_of_cache_level() cannot detect cache
>>
>> >>> hierarchy
>>
>> >>>
>>
>> >>> through ACPI PPTT table, which means cache information would be 
>> missing
>>
>> >>>
>>
>> >>> in this configuration.
>>
>> >>>
>>
>> >>>
>>
>> >>> The patch fixes this by directly calling fetch_cache_info() when
>>
>> >>>
>>
>> >>> CONFIG_SMP is undefined, which properly handles both DT and ACPI 
>> cases..
>>
>> >>>
>>
>> >>>
>>
>> >>> So yes, it would be appropriate to add a Fixes tag. The commit being
>>
>> >>>
>>
>> >>> fixed is 1845d381f280 ("riscv: cacheinfo: Add back 
>> init_cache_level()
>>
>> >>> function").
>>
>> >>>
>>
>> >>>
>>
>> >>> Please let me know if you need any additional information.
>>
>> >>>
>>
>> >>
>>
>> >> I'm about to send my first PR for 6.17 so I'll delay merging this one
>>
>> >> for the first rc.
>>
>> >
>>
>> >
>>
>> >So I took the time this morning to look into this, and I don't really
>>
>> >like the different treatment for smp, can't we just move
>>
>> >init_cpu_topology() call to setup_arch() (or else) for both !smp and 
>> smp?
>>
>> >
>>
>> >Thanks,
>>
>> >
>>
>> >Alex
>>
>>
>> Thank you for your feedback and suggestion. I understand your desire
>>
>> to have a unified approach for both SMP and !SMP. However, after
>>
>> careful consideration, I still believe that handling them separately
>>
>> is the more appropriate solution.
>>
>>
>> The current method of obtaining cache information in
>>
>> `init_cpu_topology()` is specific to RISC-V and ARM64. If we move
>>
>> `init_cpu_topology()` to cover both SMP and !SMP, it may require
>>
>> modifying the generic boot sequence. This could inadvertently affect
>>
>> other architectures that do not rely on `init_cpu_topology()` for
>>
>> cache initialization, leading to potential regressions and maintenance
>>
>> issues.
>>
>>
>> The `setup_arch()` function is called early in the boot process,
>>
>> and at this stage, the ACPI subsystem has not been fully initialized.
>>
>> Specifically, the ACPI tables (including PPTT) are not yet parsed.
>>
>> Therefore, if we call `init_cpu_topology()` from `setup_arch()`, it
>>
>> would not be able to retrieve cache information from the ACPI PPTT 
>> table.
>>
>>
>> I hope this clarifies my train of thought. I'm open to further 
>> discussion and
>>
>> alternative suggestions that can address the issue properly.
>>
>
> To me it does not make sense to retrieve the cache info at 2 different 
> points in time if the system is smp or not. I still think we should 
> find a common place where init_cpu_topology() can be called for both 
> smp and up, setup_arch() could not be the right place for the reasons 
> you gave, but we just need to find the right one :)
>
> Thanks for working on this,


I don't mean to pressure you, I know it's the end of summer and people 
are still on vacations or just back from vacation.

I just wanted to know if you had time to look into what I asked above?

Thanks,

Alex


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

