Return-Path: <linux-kernel+bounces-721256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A0AFC6B5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAED188ECE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC52BEC31;
	Tue,  8 Jul 2025 09:07:34 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A32153ED
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965653; cv=none; b=a5kmofduu6CjCbrWLM1TAJwhebFi3cCY13sqLW+mpE2pVZdb4WJZOi4gIPCEGX6ITvUTMCx9Z4IWIYCq0gblyJzijrmZwi9tv0YPtvH/odgTjIoqGGaQZlFL26UaPYZatz9iLTsp7YZACNK5hcskHF6AQQ9bJbZQ1Mph0lwaZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965653; c=relaxed/simple;
	bh=EnzK60yhKAfZWWzHVu38i8WNczrl81z1SJICTHds6Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adzdV2s5AyEAW8dGzL7r2x2g4psbyYCXd7IjGEgZYEzEpWEz6k7ODbMTRB6qTqc0vh3a8wO5twevvHIGiGmoNjzF5/L4Sx6wIMpnkaR0T8NKQODKPwohsQqVrgoLJscURCOuah+STxwqA5S76+NAmrYyI8w8OU4E3bBtnkAfo9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0430432D6;
	Tue,  8 Jul 2025 09:07:17 +0000 (UTC)
Message-ID: <44501b6d-12de-49dc-8d81-443500031d4a@ghiti.fr>
Date: Tue, 8 Jul 2025 11:07:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: mmap(): use unsigned offset type in riscv_sys_mmap
To: liu.xuemei1@zte.com.cn, paul.walmsley@sifive.com
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250707193411886Kc-TWknP0PER2_sEg-byb@zte.com.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250707193411886Kc-TWknP0PER2_sEg-byb@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudekhedrvddufedrudehgedrudegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedukeehrddvudefrdduheegrddugeefpdhhvghloheplgdutddrudegrddtrdduudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhurdiguhgvmhgvihduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrn
 hgvlhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

Hi Jessica,

On 7/7/25 13:34, liu.xuemei1@zte.com.cn wrote:
> From: Jessica Liu <liu.xuemei1@zte.com.cn>
>
> The variable type of offset should be consistent with the relevant
> interfaces of mmap which described in commit 295f10061af0 ("syscalls:
> mmap(): use unsigned offset type consistently). Otherwise, a user input
> with the top bit set would result in a negative page offset rather than a
> large one.
>
> Signed-off-by: Jessica Liu <liu.xuemei1@zte.com.cn>
> ---
>   arch/riscv/kernel/sys_riscv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index d77afe05578f..795b2e815ac9 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -10,7 +10,7 @@
>
>   static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>   			   unsigned long prot, unsigned long flags,
> -			   unsigned long fd, off_t offset,
> +			   unsigned long fd, unsigned long offset,
>   			   unsigned long page_shift_offset)
>   {
>   	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


