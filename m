Return-Path: <linux-kernel+bounces-734553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E045BB0830F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E0C7A5972
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA9A19F12D;
	Thu, 17 Jul 2025 02:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UbPzsB4k"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722841B3923
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720319; cv=none; b=czv+qRa5lrNocdZdtqSYJZgMvYBkzpAdiGX7y9scrxka/0SQngVv5sduw2e38lMb91N/MZfkRSg2/8vtWhTiwYlUss1FU8SeLhLfR1RHUM+jYdKp8E32V8ror7HxoC7C50J6Qw//WnwHUz/nV9uOjoWRRN+XjGYhe4on9dZhGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720319; c=relaxed/simple;
	bh=8vnsFQI38H05BDP0pNT1K2EEN6/wHpG+tvQ8xAP0/CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrMq/XOGFX/Rimtp9MeObnFIdzPEl5FW/V2UtIpoG172CQ8t0edomaxcOwm7JxYLMnP3fneu9TagGV7wdJ9HVHSYOgTm//8VJyeI4k3a5i/6eCPc4YEs65g//VfYO1LnMASevR4uAem0xVT5fVjbpNYAtlJkJsfdHjNUE72TjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UbPzsB4k; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752720312; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F9d/4K1zkZPJB2kB2UUc/hygJIY+cwOrg7BW+ay7QlY=;
	b=UbPzsB4k1zbGfF8w509GKgk8pLkUwMKzqHNYsESZRBk9sZGfSV2UE/BArL6S6brg4rm61VWTMI+gI6UzwbrfH4dnNXPhbqcb1AWk/F6lqgenDIwa/fWTY0Pbz6hEIbfnMrwHvUc8Sb8fTkZpLg6LCuXVeOSGldvfJleiyGoVmO8=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6Uh3P_1752720311 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 10:45:12 +0800
Message-ID: <c46f71ae-f04c-4aa6-99fb-cf8f8e751589@linux.alibaba.com>
Date: Thu, 17 Jul 2025 10:45:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250717015848.4804-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717015848.4804-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/17 09:58, Bo Liu wrote:
> fix build err:
>   ld.lld: error: undefined symbol: crypto_req_done
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: crypto_acomp_decompress
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_decompress) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: crypto_alloc_acomp
>     referenced by decompressor_crypto.c
>         fs/erofs/decompressor_crypto.o:(z_erofs_crypto_enable_engine) in archive vmlinux.a
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507161032.QholMPtn-lkp@intel.com/
> Fixes: b4a29efc5146 ("erofs: support DEFLATE decompression by using Intel QAT")
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> 
> v1: https://lore.kernel.org/linux-erofs/7a1dbee70a604583bae5a29f690f4231@inspur.com/T/#t
> 
> change since v1:
> - add Fixes commits
> ---
>   fs/erofs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> index 6beeb7063871..60510a041bf1 100644
> --- a/fs/erofs/Kconfig
> +++ b/fs/erofs/Kconfig
> @@ -147,6 +147,7 @@ config EROFS_FS_ZIP_ZSTD
>   config EROFS_FS_ZIP_ACCEL
>   	bool "EROFS hardware decompression support"
>   	depends on EROFS_FS_ZIP
> +	select CRYPTO

After testing, I think we should rely on
CRYPTO_ACOMP or CRYPTO_ACOMP2 instead.

Otherwise it will still fails.

Thanks,
Gao Xiang

