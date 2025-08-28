Return-Path: <linux-kernel+bounces-789277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD38DB39343
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D87174E31
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F2272E4A;
	Thu, 28 Aug 2025 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pMSeZFTw"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA534A02
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756360043; cv=none; b=G2CYoGAVf858uQ3l0P5OwaQCidtdU7WznEXXstiEBUVxDKehyCRk608MSrMi0c8OowdMfjWtJwPi3/ql5z0ygwBU8j0efQ63rx1ykUNND0j8AxOJKyjStlRZATexLI2hhfiQzLpxHNZRequhXk5K4cSfnKbqLSddNGbWc0aP32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756360043; c=relaxed/simple;
	bh=Ff6A/ABlVfhd6bhCEZE0EcEpn+vTrvMxWpYNAm22cuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXm7BzxPIA3w8Wcj5VWDd+mmJhZJkJOr8TotGprG78ME7J8v/w2od4r0qbrsI47TzrUcmeQConNxhsioqtmDGLe8phkpptN6KBf19Kp6NgooZ8U/0yK/Yol8StaW2OPoh0nGUkZ3FC2ek3byB0sGTHe74w7Ue1eUkmoI9uzHtZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pMSeZFTw; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0e11216-71b0-447f-beab-351d024810fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756360028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYX598SGYrabtNqXPOOzLPxTx6DBbwS3J2JRDMSkHWg=;
	b=pMSeZFTw5j1KInjZqAY0Cm9HmHjNLLF+anqWIUbhwi6NeDJHpc87TDgtJOEqtDuBiJZ+vT
	kGGli7O1KkzX5GbfIE38cWTXu0JgyVcZvYHub2XoZh4k0pKB2IuqcsVad3fFbZNYELjYbL
	kAePHyJERwMHv6W0sz8q55/1Ci4fhJQ=
Date: Thu, 28 Aug 2025 13:47:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Loongarch: entry: fix syscall_get_arguments() VS
 no-bultin-memcpy
To: Wentao Guan <guanwentao@uniontech.com>, chenhuacai@kernel.org
Cc: kernel@xen0n.name, xry111@xry111.site, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, zhanjun@uniontech.com
References: <20250826113225.406238-1-guanwentao@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250826113225.406238-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 8/26/25 7:32 PM, Wentao Guan 写道:
> Loongarch use -fno-builtin-memcpy in Makefile,
> so cause a extra memcpy in syscall hot path:
> 
> syscall_enter_audit
> ->syscall_get_arguments->memcpy(__memcpy_fast)
> ->audit_syscall_entry
> 
> Just avoid memcpy() altogether and write the copying of args from regs
> manually, which shows 5% multi core score up in UnixBench syscall.
5%? Awesome!
> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>

Thanks,
Yanteng
> ---
>   arch/loongarch/include/asm/syscall.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/include/asm/syscall.h b/arch/loongarch/include/asm/syscall.h
> index 81d2733f7b94..171af2edd569 100644
> --- a/arch/loongarch/include/asm/syscall.h
> +++ b/arch/loongarch/include/asm/syscall.h
> @@ -65,7 +65,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
>   					 unsigned long *args)
>   {
>   	args[0] = regs->orig_a0;
> -	memcpy(&args[1], &regs->regs[5], 5 * sizeof(long));
> +	args[1] = regs->regs[5];
> +	args[2] = regs->regs[6];
> +	args[3] = regs->regs[7];
> +	args[4] = regs->regs[8];
> +	args[5] = regs->regs[9];
>   }
>   
>   static inline void syscall_set_arguments(struct task_struct *task,


