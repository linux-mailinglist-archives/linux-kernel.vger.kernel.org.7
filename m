Return-Path: <linux-kernel+bounces-598678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E438A84955
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724929C138E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465D1EDA08;
	Thu, 10 Apr 2025 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MK/1B4yh"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8631EE00B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744301509; cv=none; b=bCcJgxu63TCyWFCTnAUR/qkg44keHWD0ZVPb5G+PdTYXryIgJz3KSw0Wcb4s45t8siMP33gI21DWQebsBY6XAPoYFLl9pO+JcnlDOuoEIbnn1lFJR4/CwkK9USyARljfuwxzgcmozhER/0c69oK9rXEptpIMMqH/sARAS2z+vfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744301509; c=relaxed/simple;
	bh=DyggEqEwdpDsE5QfvjLY0NOCs8JKh1LVoE0npEzn/GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMyiOBqzx3NfPd2LsLzGIzErskTOnWWyDk+riBdzrVGJhTwZdP8D/xjsdzgVQKFpCql6ZTNy09qhY4GiM/nMajI3F2fIJsHG2AX0p2BKWcRCYzNWhu2TT7cT/vu6el20IOxAGyRRFRc/p0Kinp1Ek5lZKMLZbxyG6EOoLfbtSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MK/1B4yh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <075de7dd-f3a2-4806-9e4c-9dfd38d12f69@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744301504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nt8tTtiMTltGMqw9E6kWYY4DjCgOZXnH5VaO/hXPHBA=;
	b=MK/1B4yh1QrTfDd0DGcc6inqsSf7ID5ZuX8d8dyp+QQOsgtB5QwyefUOX27HxDqowrZ1ZD
	Fr7KThsm62xnBGXF212EZGRMk+zKWMoq5kj8Z2ajnQkH3NocN9tzw1nOpUN/k8oWN9ATEo
	LsGkVJIM/KafKAJLnhn3+a9MR+gKFQM=
Date: Thu, 10 Apr 2025 18:11:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] null_blk: Use strscpy() instead of strscpy_pad() in
 null_add_dev()
To: Thorsten Blum <thorsten.blum@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <dlemoal@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Zheng Qixing <zhengqixing@huawei.com>, Yu Kuai <yukuai3@huawei.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410154727.883207-1-thorsten.blum@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250410154727.883207-1-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10.04.25 17:47, Thorsten Blum wrote:
> blk_mq_alloc_disk() already zero-initializes the destination buffer,
> making strscpy() sufficient for safely copying the disk's name. The
> additional NUL-padding performed by strscpy_pad() is unnecessary.
>
> If the destination buffer has a fixed length, strscpy() automatically

Looks good to me. The destination buffer is indeed has a fixed length, 
it is DISK_NAME_LEN.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> determines its size using sizeof() when the argument is omitted. This
> makes the explicit size argument unnecessary.
>
> The source string is also NUL-terminated and meets the __must_be_cstr()
> requirement of strscpy().
>
> No functional changes intended.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/block/null_blk/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 3bb9cee0a9b5..aa163ae9b2aa 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -2031,7 +2031,7 @@ static int null_add_dev(struct nullb_device *dev)
>   	nullb->disk->minors = 1;
>   	nullb->disk->fops = &null_ops;
>   	nullb->disk->private_data = nullb;
> -	strscpy_pad(nullb->disk->disk_name, nullb->disk_name, DISK_NAME_LEN);
> +	strscpy(nullb->disk->disk_name, nullb->disk_name);
>   
>   	if (nullb->dev->zoned) {
>   		rv = null_register_zoned_dev(nullb);

-- 
Best Regards,
Yanjun.Zhu


