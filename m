Return-Path: <linux-kernel+bounces-752169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311ECB1720E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF9A585B83
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8EA2C3259;
	Thu, 31 Jul 2025 13:29:14 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB62C08DF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968553; cv=none; b=lvSqhSzPGxAacOYJ9IrQKnUKHfH3LifyX+hHuvSCw3/1Ibmv25IyZVsABGAicqJWmSlRzayYhJWrfmpTPgsXQfZFChFw/cvw4NN/5X8r03n2BTkx02mpzjKhmFdwRBsVQODD8/OblA2ikUgdEFk5HcxomXOZqb+9qzBo7Ibv2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968553; c=relaxed/simple;
	bh=HTYZCkREjKOmLq/D3iYUJtpfLnpxr98JgtzDe8Mjgp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+AnRuEhI218PEl+FN3CyIyf97XZPZbA5CXxYBffcs4cd7bPCpx7PtjsDoS9JufNWgbd24d0S+uevQXtlnDMrlOmaS78zkFwbLA74ANgVIga0iI1KlyKga1hGJBX32nRuufalAQ+Taf+RVKBI36ubnTp8qqSIw8SO71EzyUdyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A28D42D7F;
	Thu, 31 Jul 2025 13:29:01 +0000 (UTC)
Message-ID: <d339833a-5784-407b-816d-ab95d35fbe4e@ghiti.fr>
Date: Thu, 31 Jul 2025 15:29:01 +0200
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
References: <20250725104425229ArF_W-F7CmscLJKs0yoiQ@zte.com.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250725104425229ArF_W-F7CmscLJKs0yoiQ@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnheptdfhleefjeegheevgeeljeellefgvefhkeeiffekueejteefvdevhfelvdeggeeinecukfhppedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtdegmegtvggttdemuddtjeefmegslegsgeemjegvtgekmeehhegutdemgehfvddvmeeigedvkedphhgvlhhopeglkffrggeimedvrgdtgeemtggvtgdtmedutdejfeemsgelsgegmeejvggtkeemheehugdtmeegfhdvvdemieegvdekngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehlihhurdiguhgvmhgvihduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvv
 ggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohepshhpvghrshhvohhlugesghhmrghilhdrtghomhdprhgtphhtthhopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopehmihhkihhsrggsrghtvgesghhmrghilhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Jessica,

On 7/25/25 04:44, liu.xuemei1@zte.com.cn wrote:
> From: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> As described in commit 1845d381f280 ("riscv: cacheinfo: Add back
> init_cache_level() function"), when CONFIG_SMP is undefined, the cache
> hierarchy detection needs to be performed through the init_cache_level(),
> whereas when CONFIG_SMP is defined, this detection is handled during the
> init_cpu_topology() process.
>
> Furthermore, while commit 66381d36771e ("RISC-V: Select ACPI PPTT drivers")
> enables cache information retrieval through the ACPI PPTT table, the
> init_of_cache_level() called within init_cache_level() cannot support cache
> hierarchy detection through ACPI PPTT. Therefore, when CONFIG_SMP is
> undefined, we directly invoke the fetch_cache_info function to initialize
> the cache levels.
>
> Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
> ---
>   arch/riscv/kernel/cacheinfo.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 26b085dbdd07..f81ca963d177 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -73,7 +73,11 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>
>   int init_cache_level(unsigned int cpu)
>   {
> -	return init_of_cache_level(cpu);
> +#ifdef CONFIG_SMP
> +	return 0;
> +#endif
> +
> +	return fetch_cache_info(cpu);
>   }
>
>   int populate_cache_leaves(unsigned int cpu)


Is the current behaviour wrong or just redundant? If wrong, I'll add a 
Fixes tag to backport, otherwise I won't.

Thanks,

Alex


