Return-Path: <linux-kernel+bounces-736383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE41B09C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134A916556F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC121B9F1;
	Fri, 18 Jul 2025 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TCfw/0mE"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24C21B1AA
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823137; cv=none; b=uZ5v6Vv0DS0TM8WU/QXZQLXbk3bKPZrfaIyQyZ+f+wXFuMo15labZ+Z+41j65fX7fBlFghnEHmSqtc0+46jWZNknMYbyPnWYjldm3htwIlou+JTA+C4u35UPvEasbTXop3UFWgPfne8EypwevvKp+HUADtoiIvSPmlGeH6XagFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823137; c=relaxed/simple;
	bh=UNW6EirPsr+wWrlq93+7OM1U1NLixJu4Jdjaz/d2pfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTNJvpgkNIuC6iAmTMta+osk1rYW7UDTs5aKbQsuozRLnTN4f7t/J2R2x+kcrqNa3iWm4bFa/qwv0jMBtL5IfWuIM6bWHO6aNeX95ZMMDTraLmOplLtdZtSfiWMh0Qcxn9zy8SFOnHw1yBwHDDLTrhrnL1/DUsazc+itJQIcwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TCfw/0mE; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752823130; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qOQtZWK71CEUFEPs+wC1xse+G2jR4a/7IF144JLOSlA=;
	b=TCfw/0mES4FL3RWHuHEHl8z0sRgJX/A1w+jAZtHGPLtInG61Vk3WLMFBPoVoWFum/Bx7AekYuZcspHbbDWBlUGGtMhIKHx8ssadJTwrdzHp2nO73+w8LoRbG3/yWYtZSiUejjq64vKR/CS/LG4VRozi4rscjXswY5u17v+W1Nfc=
Received: from 30.221.129.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBLOCV_1752823129 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 15:18:49 +0800
Message-ID: <3134e79d-9f91-4af5-a15c-ab65509bef55@linux.alibaba.com>
Date: Fri, 18 Jul 2025 15:18:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: fix build error with
 CONFIG_EROFS_FS_ZIP_ACCEL=y
To: Bo Liu <liubo03@inspur.com>, xiang@kernel.org, chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250718033039.3609-1-liubo03@inspur.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20250718033039.3609-1-liubo03@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/18 11:30, Bo Liu wrote:
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

> 
> change since v3:
> - change Kconfg to select CRYPTO and CRYPTO_DEFLATE

These two lines should be moved under the line `----`, since
it shouldn't be part of the commit message, but I've removed
this time.

Thanks,
Gao Xiang

