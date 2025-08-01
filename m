Return-Path: <linux-kernel+bounces-753303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2190B1814A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EB8541938
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939A72617;
	Fri,  1 Aug 2025 11:46:15 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD68BEE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754048775; cv=none; b=HqqId8dGGZyNks2JuXSn9gdFVxnvVzFfDvm4eWvCjKW2VZMnheD8eqiJLFr0HPPbZYVH9yPNLOTvxWxulniCbqUEgcrzkSWx7LLK9wF7tjfoaOqmb36a4jNSwkrWNezSDQ7ZexhlFobCrDnkK1y7zU+vaog9m74wJptOF91IH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754048775; c=relaxed/simple;
	bh=Am5u1xFAJXUBe3cT7nd3dGeDhVt+fDSY5rX8Wkd/SEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOxxoMnP1IsYmXrkd4J+LzVcQpX/qx31FpIdEB9rFiyCJ+LWzc/WPZg7uFvIF8Tetd6QvIVX7VvM+vr5KGcg53GuO5ZUpx+9BaYESGE8+JTdAIjerXMnbZqLmIZdgvMmoxWgT438u+4nNjezAbOQ3NXhcpUIllxWyPKnczFRKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEB37439C0;
	Fri,  1 Aug 2025 11:45:59 +0000 (UTC)
Message-ID: <ffb83627-bd28-4bf9-8051-57dfca407f87@ghiti.fr>
Date: Fri, 1 Aug 2025 13:45:58 +0200
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
References: <20250801093201232CYacRrFIHaDJWsjc3rbNz@zte.com.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250801093201232CYacRrFIHaDJWsjc3rbNz@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdeguefhhfevueejteevveeikeelkedvffdufeelveeggfeikeekgfeghfdttdevnecukfhppedujeeirddugeejrddugeehrdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedujeeirddugeejrddugeehrdeggedphhgvlhhopegludelvddrudeikedruddrudehlegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhiuhdrgihuvghmvghiudesiihtvgdrtghomhdrtghnpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopehsphgvrhhsvhholhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhllhgrsegrrhhmrdgtohhmpdhrtghpthhtohepmhhik
 hhishgrsggrthgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Jessica,

On 8/1/25 03:32, liu.xuemei1@zte.com.cn wrote:
>
> On 7/31/25 21:29, alex@ghiti.fr wrote:
>
> > > From: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> > >
>
> > > As described in commit 1845d381f280 ("riscv: cacheinfo: Add back
>
> > > init_cache_level() function"), when CONFIG_SMP is undefined, the cache
>
> > > hierarchy detection needs to be performed through the 
> init_cache_level(),
>
> > > whereas when CONFIG_SMP is defined, this detection is handled 
> during the
>
> > > init_cpu_topology() process.
>
> > >
>
> > > Furthermore, while commit 66381d36771e ("RISC-V: Select ACPI PPTT 
> drivers")
>
> > > enables cache information retrieval through the ACPI PPTT table, the
>
> > > init_of_cache_level() called within init_cache_level() cannot 
> support cache
>
> > > hierarchy detection through ACPI PPTT. Therefore, when CONFIG_SMP is
>
> > > undefined, we directly invoke the fetch_cache_info function to 
> initialize
>
> > > the cache levels.
>
> > >
>
> > > Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> > > ---
>
> > >   arch/riscv/kernel/cacheinfo.c | 6 +++++-
>
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
>
> > >
>
> > > diff --git a/arch/riscv/kernel/cacheinfo.c 
> b/arch/riscv/kernel/cacheinfo.c
>
> > > index 26b085dbdd07..f81ca963d177 100644
>
> > > --- a/arch/riscv/kernel/cacheinfo.c
>
> > > +++ b/arch/riscv/kernel/cacheinfo.c
>
> > > @@ -73,7 +73,11 @@ static void ci_leaf_init(struct cacheinfo 
> *this_leaf,
>
> > >
>
> > >   int init_cache_level(unsigned int cpu)
>
> > >   {
>
> > > -    return init_of_cache_level(cpu);
>
> > > +#ifdef CONFIG_SMP
>
> > > +    return 0;
>
> > > +#endif
>
> > > +
>
> > > +    return fetch_cache_info(cpu);
>
> > >   }
>
> > >
>
> > >   int populate_cache_leaves(unsigned int cpu)
>
> >
>
> >
>
> > Is the current behaviour wrong or just redundant? If wrong, I'll add a
>
> > Fixes tag to backport, otherwise I won't.
>
> >
>
> > Thanks,
>
> >
>
> > Alex
>
>
> Hi Alex,
>
>
> The current behavior is actually wrong when using ACPI on !CONFIG_SMP
>
> systems. The original init_of_cache_level() cannot detect cache hierarchy
>
> through ACPI PPTT table, which means cache information would be missing
>
> in this configuration.
>
>
> The patch fixes this by directly calling fetch_cache_info() when
>
> CONFIG_SMP is undefined, which properly handles both DT and ACPI cases.
>
>
> So yes, it would be appropriate to add a Fixes tag. The commit being
>
> fixed is 1845d381f280 ("riscv: cacheinfo: Add back init_cache_level() 
> function").
>
>
> Please let me know if you need any additional information.
>

I'm about to send my first PR for 6.17 so I'll delay merging this one 
for the first rc.

Thanks for the explanation,

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

