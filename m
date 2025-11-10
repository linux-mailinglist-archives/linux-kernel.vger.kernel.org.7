Return-Path: <linux-kernel+bounces-892508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5514FC453C6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4342B4E8517
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68CB2EBBB2;
	Mon, 10 Nov 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4GVB/Sc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0E11FF1C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760356; cv=none; b=qGfaIbMG9Z2Ly/Ej9QaNCipvdm+F3Ov4U/vB5g9/YsN2nqYC/zHJzMjnxiAGUEA36Kcy3alMZpNVOtsNklQDeXMzroQfrF+A5iAaaNp07czbHMNXaYWATYK2PzbJIiTRWEpuKlsY1wir6qC0tS9xxhDsgxVSjbDxVa2jG92ft30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760356; c=relaxed/simple;
	bh=v9+z/sXopfnIMi9BT8Q6hCIry4QWb/AcTyhOPyNAz/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzWgkzXCrzuIzibbG/C8BCykYe/C9lELc4llnr1Lb/eqJQf2DNzHkXgQqJ955BtjpsXi/6F2sVMMdgKvrSOiSIXbJDsFOGF8z5Sb/E4fK6CQvVpKHckiXlbRMcuZj7OO/ixSwWg6YBCiT8EyUPEWMmncfD1+01/SYpugrwcydQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4GVB/Sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7489C4CEFB;
	Mon, 10 Nov 2025 07:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762760355;
	bh=v9+z/sXopfnIMi9BT8Q6hCIry4QWb/AcTyhOPyNAz/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j4GVB/Sc6HA4fle6SuGPHpc/4ihXqyfaU303DE/yjWqtLWjWeZvw0Sn9kHHlKwxVN
	 4qAmHQm9AgQt2WeRtcBOzK2mxrAdCVA58Vv4DOFWfsqVT1hKkIcnOwezdCBkZZ8ic9
	 gts1ecAzOQh8wUT+e3eDnZAj4v+rKm1dYfDvbtFRwiK2fxZWmBOzpfIhclcd5znVot
	 r9pxmQvJ3Z1ZBdxGF0bVG0G4bBj6Okq8I6FZwThwHXaxRar/CSRGupHDc2JMlsCAQn
	 BV9BGY1IhbMu0DQpQXVbSOohI8mo31gl9YX/7ndsLeNbD8YjGnyTdACDqkUzan1wn2
	 BqRK04KCsR7aA==
Message-ID: <4472655b-a7a1-4bb7-a05c-6762aa06cb95@kernel.org>
Date: Mon, 10 Nov 2025 07:39:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmem: core: fix GPIO descriptor resource leak
To: Haotian Zhang <vulab@iscas.ac.cn>, srini@kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20251028165526.534-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20251028165526.534-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/28/25 4:55 PM, Haotian Zhang wrote:
> The driver calls gpiod_get_optional() in nvmem_register() but never
> calls gpiod_put() in nvmem_device_release() or in the register error
> path. This leads to a GPIO descriptor resource leak.
> 
> Add gpiod_put() in nvmem_device_release() and in the register error
> path to fix the resource leak.
> 
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")

Missing cc stable

--srini> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/nvmem/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 387c88c55259..597598db88f4 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1043,6 +1043,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	if (config->compat)
>  		nvmem_sysfs_remove_compat(nvmem, config);
>  err_put_device:
> +	gpiod_put(nvmem->wp_gpio);
>  	put_device(&nvmem->dev);
>  
>  	return ERR_PTR(rval);
> @@ -1062,6 +1063,7 @@ static void nvmem_device_release(struct kref *kref)
>  
>  	nvmem_device_remove_all_cells(nvmem);
>  	nvmem_destroy_layout(nvmem);
> +	gpiod_put(nvmem->wp_gpio);
>  	device_unregister(&nvmem->dev);
>  }
>  



