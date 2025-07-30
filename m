Return-Path: <linux-kernel+bounces-750102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC53AB15753
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE41518A7E04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35FB199FAB;
	Wed, 30 Jul 2025 01:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iWsT84Cb"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09EA22318
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840499; cv=none; b=enF7/7wdmT9SLYDV89okPzs9HRVNF16hSteQzZWkTD9XlNchA79Zq01IYSD9BcGmwhQmJAVFB9Y+GjrXwOY0BNLGZ4cX1SNjdBuKRdrT+ADWYY5NJeoP9U89WqQmkIgXg/C9krHCs8NjvVajUazxhkYvmIWjFovZSeytIYkd0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840499; c=relaxed/simple;
	bh=3nmrzvt9T2OTj6OUt0SRV9AgvZb7btlDrbPL1yJkRa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6MnN3qo5t2tYfquahN/Lp6GBNlGAcxQPVdwQx0lM21csuQz5jOITU+CmAbmc0G8v7muLBY0JqY9MXFjlySbUGVzxy2pnYaNSNwy9ofqhjHTNSHBzuhV0XS0VHDpCUTFaPPvbGiJ83/H+uzdAsb3U2bhEVfEaeoDJOLl8nsM67M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iWsT84Cb; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fd349fb6-be25-440e-932e-b15b6daedeee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753840484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s6TFnWpvz0r+x9+h2O76oBP9t3gNEcHthOWOzMwa2ao=;
	b=iWsT84Cb6OVvZzU1qXYXmR+MpgvZT/YrQMX1zqTq3lLkqkqBlIOdAet2GiqXCs4BJ7oxb3
	gLEnVP0zXgUBkjClbtusDUvNKcYRa0nAsnoG8M/bQY67I4Cc9knNUEDJ5GcUd9LCX2x6fm
	Ri+c+1mbqOMWp0CqCbMPaMofbzzaGJE=
Date: Wed, 30 Jul 2025 09:54:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] LoongArch: vDSO: remove -nostdlib complier flag
To: Wentao Guan <guanwentao@uniontech.com>, chenhuacai@kernel.org
Cc: kernel@xen0n.name, xry111@xry111.site, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, wangyuli@uniontech.com, zhanjun@uniontech.com
References: <20250725132651.1974717-1-guanwentao@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250725132651.1974717-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 7/25/25 9:26 PM, Wentao Guan 写道:
> It is clear to remove the -nostdlib for ld, it is similar to commit
> bdbf2038fbf4 ("MIPS: VDSO: remove -nostdlib compiler flag").
> 
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Since MIPS has removed this, we should remove it too. In fact, other architectures also use $(LD).

       fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC) to link VDSO")
       691efbedc60d ("arm64: vdso: use $(LD) instead of $(CC) to link VDSO")
       2ff906994b6c ("MIPS: VDSO: Use $(LD) instead of $(CC) to link VDSO")
       2b2a25845d53 ("s390/vdso: Use $(LD) instead of $(CC) to link vDSO")

If Huacai is willing to apply this patch, I suggest supplementing the commit message.


Reviewed-by: Yanteng Si <siyanteng@cqsoftware.com.cn>

Thanks,
Yanteng
> ---
>   arch/loongarch/vdso/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
> index ccd2c5e135c6..d8316f993482 100644
> --- a/arch/loongarch/vdso/Makefile
> +++ b/arch/loongarch/vdso/Makefile
> @@ -36,7 +36,7 @@ endif
>   
>   # VDSO linker flags.
>   ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> -	$(filter -E%,$(KBUILD_CFLAGS)) -nostdlib -shared --build-id -T
> +	$(filter -E%,$(KBUILD_CFLAGS)) -shared --build-id -T
>   
>   #
>   # Shared build commands.


