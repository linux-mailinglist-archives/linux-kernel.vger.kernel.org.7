Return-Path: <linux-kernel+bounces-734504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BEB0828E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B11A64E58
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8931DFDA1;
	Thu, 17 Jul 2025 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="soMVv8ZJ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7B01E0DD8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716407; cv=none; b=Atjg+zscybV9mk2eFWFeJaWGXoxMa86wRaTWmVsdhS180sQ8rP9qSxa75KuxfVWtOlL8sfQP4cqLfNe5v/7z0xNmcvRCMxP6sfMVROd0AhxhVSn5E7K+np/NSrj8P3pSzriYm+cRrYkcfIrcI0bq01nBJa/ZClPPlzk41kq5B9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716407; c=relaxed/simple;
	bh=5deoJ+uRas8j/J6mIbb8n8Dx9oMIm2XRMDBiR/DHTpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccVN5msKgD7asiIEweN0sbsjUJpwbfHCWshWILNDLI/ZU+ezTNmWFr9zZvfDwTjOCmG4+yEGxRpwVuhRrWZQVLK1OfUX7XLnUjeGtt/2LKiCXblFwI5tQrz92o+04cLCS9CWXDS6gJXids5LDb+cTeNS8z6JjgpqSM/St77Uhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=soMVv8ZJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752716396; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rIDJJYj0IKdl0sdVgaOrA5B/DX1+SBnc5GnQWdJnhsc=;
	b=soMVv8ZJ9sKguZNArTcNwXbJAM9Wf5VbpLfcc+inph8jfACPRHT2Sb2y3qFtaSSJL/WETsURyC8uQUfw84tUgSQI9NNUOWQzYu1i+2yqQxEz+IOeys2O9YZg7gjrbyg9U6/BNXhugUKClgrGL6jK+6+Ta8oGnW36uOCwNPYNYY8=
Received: from 30.221.131.143(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj6DZKg_1752716395 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 09:39:55 +0800
Message-ID: <7d4b5f45-a8c1-47d6-8404-9cad88a297c1@linux.alibaba.com>
Date: Thu, 17 Jul 2025 09:39:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: fix build error with CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250717013431.15589-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250717013431.15589-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/17 09:34, Bo Liu wrote:
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

Could you add a `Fixes` tag for this?

> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>


Thanks, let me reconfirm if if can resolved the issue.

Thanks,
Gao Xiang

