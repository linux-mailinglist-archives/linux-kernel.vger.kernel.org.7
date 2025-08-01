Return-Path: <linux-kernel+bounces-753066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE3BB17E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7371C25A26
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E025D218584;
	Fri,  1 Aug 2025 08:29:42 +0000 (UTC)
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660F1F4613
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754036982; cv=none; b=CItfSOecOcFNnHv1HttrpFMxnGaNJqSMFih7q8jlKL2yPCspNJdBtVyPtKkfCcmdMxRcwaqq0ud/xlzzYjbbdK5EpSDhUffC1kyRmmqP/ipGkhFMUdhM8WzOW+iLsIkAi2Hlrd7f6/hD4g4JxzcBOJmw+lG+rybkxKE2uV1xzrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754036982; c=relaxed/simple;
	bh=tIW1t8nDozqBDNO3D6TVuP+vr2UnzVGJXgFuSJogYLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXoKLr3egTGg2tFhTfjauTZiHhAGlhzr6Kgx8JMKmTnwlxW9HkjiQlJfTFfRg/hgY1q1Pr10LQZP3V4q+TRpuRtRJbmrIr0b9nSORswNYY974E2D2Qrg06zBb215482m/CgoneEgW8+J2+dh7NuCx5veOCRdNRaTb0Q+qMuyHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0913A438CF;
	Fri,  1 Aug 2025 08:29:28 +0000 (UTC)
Message-ID: <918d999b-ecef-487a-a486-40b1d94beb15@ghiti.fr>
Date: Fri, 1 Aug 2025 10:29:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] riscv: mmap(): use unsigned offset type in
 riscv_sys_mmap
To: liu.xuemei1@zte.com.cn, paul.walmsley@sifive.com
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250801104948133AaMr5S6E382PbNNhoJgHA@zte.com.cn>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250801104948133AaMr5S6E382PbNNhoJgHA@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepteeiieetgffhuedvvdejieduheehieffffegveeitdelheegfffgtdevkeethedunecuffhomhgrihhnpehinhhfrhgruggvrggurdhorhhgnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemvggumegujedutgemfedufedvmeefkegrudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemvggumegujedutgemfedufedvmeefkegruddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemvggumegujedutgemfedufedvmeefkegrudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhurdiguhgvmhgvihduseiithgvrdgtohhmrdgtnhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdpr
 hgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Hi Jessica,

On 8/1/25 04:49, liu.xuemei1@zte.com.cn wrote:
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
> arch/riscv/kernel/sys_riscv.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index d77afe05578f..795b2e815ac9 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -10,7 +10,7 @@
>
> static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>   			unsigned long prot, unsigned long flags,
> -			   unsigned long fd, off_t offset,
> +			   unsigned long fd, unsigned long offset,
>   			unsigned long page_shift_offset)
> {
>   	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
> --
> 2.25.1
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


I had already merged this one for 6.17 but I did not say it so you could 
not know, sorry about that, I'll do better next release.

Thanks for your patches,

Alex



