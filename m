Return-Path: <linux-kernel+bounces-768478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F2CB26175
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47533A5AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061052ED157;
	Thu, 14 Aug 2025 09:46:28 +0000 (UTC)
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB92356C6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164787; cv=none; b=rLPi2EATn0MQ08kXZuddmyEXw6MzXZDYopauP0j0I2KwJ7jRsRdNzb4TA7yOWRk/pS8wE43aezCqSErW+KcPjp4H3DDr6zZ21czoVfcDhQVm8j050Mn69DF/MXAla+pw/X2wPcH/ecql2HbxO8dhDfZIWDrLMxM7UdI63p4F94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164787; c=relaxed/simple;
	bh=yAqV101NWbVQFpIeokC3X2GR32acILqx0sryRaYjW1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWPLMnuuimirLIBSVWQfrPAxwa4Um7n1tplclAml6GrNQeY/U2BfIfBmoIUOLd++7Bc0Q+3qdGdj1lbQ24at6/dMhnqGZcm1rVEbZ4JBg7BKJAQni5fx0fCDHbeEHEj/2Fk3uz53ntFIxr/Uq7z8KgsrvhgMbJ+5VWqoXzG8qZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id EF919580F0B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:20:31 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAEE743195;
	Thu, 14 Aug 2025 09:20:21 +0000 (UTC)
Message-ID: <b2a4df29-f35c-403a-a2a1-47ca9fce0023@ghiti.fr>
Date: Thu, 14 Aug 2025 11:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: sbi: Switch to new sys-off handler API
To: Andrew Davis <afd@ti.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250813151855.105237-1-afd@ti.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250813151855.105237-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedtjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopegrfhgusehtihdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesv
 hhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Andrew,

On 8/13/25 17:18, Andrew Davis wrote:
> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   arch/riscv/kernel/sbi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 53836a9235e32..5e8cde0552643 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -148,7 +148,7 @@ static int __sbi_rfence_v01(int fid, const struct cpumask *cpu_mask,
>   
>   static void sbi_set_power_off(void)
>   {
> -	pm_power_off = sbi_shutdown;
> +	register_platform_power_off(sbi_shutdown);
>   }
>   #else
>   static void __sbi_set_timer_v01(uint64_t stime_value)
> @@ -682,7 +682,7 @@ void __init sbi_init(void)
>   		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
>   		    sbi_probe_extension(SBI_EXT_SRST)) {
>   			pr_info("SBI SRST extension detected\n");
> -			pm_power_off = sbi_srst_power_off;
> +			register_platform_power_off(sbi_srst_power_off);
>   			sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
>   			sbi_srst_reboot_nb.priority = 192;
>   			register_restart_handler(&sbi_srst_reboot_nb);


Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

I'll take that for 6.18.

Thanks,

Alex


