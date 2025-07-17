Return-Path: <linux-kernel+bounces-734658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A2B0846E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0293564A86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C11F5413;
	Thu, 17 Jul 2025 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NJ5pGf6x"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A11A23AC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731871; cv=none; b=NKk8YDj5wQ5rztVuic6HkzUr0kktqFjneqj60AfzllMArXkA5f4YXmeBL93syaAGr9rGBVRT++azdjDFU9aklbbywyK/Bjkz3CicCGxyYj+VpifnEpJP+Xtt2EJ2i42YzylqqbRSksVfddPMkBod7/0XJ+/Oaa39njNxbr6sXW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731871; c=relaxed/simple;
	bh=EI5jDhNWlvtb+HOHlRrf3B6F9ZnNgho/VU0LtglrXIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPqevMec1ae7ss7AVs6cCgIoDdAaze1EeHaJZ+65Ogdhi725lK/nq50vxKyqXT6S52bxAPU7c2i5QuId+FNjNYHgh/MFqQ9lR1/CqjceSxRzDGvW6ILjLyf6CapoHSzZ0bGrHPJapitDHggO2t7q4npccE8IzDixU2r64F5mtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NJ5pGf6x; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752731864; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=aj9BSuaE7p+6r1rAbiSYzDfAMXCrPeCl4NXzz/D5Ee0=;
	b=NJ5pGf6xLC+lYZJOWhL6ysE7HfPTpoStKVNhX3kxJ+c+ALws6FjGr5zFyFlYYJn+zVDUFXN3NeX3215iL2bwf5CO/0d6G60mG79oaFvBqjAegq06SVj9WXQOX27f4t1krUuQIIQLzrW3mqFNeC/DeiJ1sQAPMCd8Nt+H426S7A8=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6wI23_1752731863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 13:57:44 +0800
Message-ID: <6248842e-3641-42a2-b8da-bcce3c0bc793@linux.alibaba.com>
Date: Thu, 17 Jul 2025 13:57:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250717053724.65995-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717053724.65995-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/17 13:37, Bo Liu wrote:
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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

