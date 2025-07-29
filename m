Return-Path: <linux-kernel+bounces-749191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5BB14B43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDB127A56E5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E7285C86;
	Tue, 29 Jul 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAH4sVpl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF525BEE7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781270; cv=none; b=DBlYQcqC1fYpOkSk8HQPP+mqdwL2OmThtaJo6dWN3CTKwtkqhNKeJWxetJqTRSEwPb47fZgamIBkdibih36gZIR9KSnCHM8t56u3UKW/ua/o/nXx4FplcoER2n653tAXKNu4vAuXlQ42LX+gp8LnaLkSYTCgljzbnytOvmIMQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781270; c=relaxed/simple;
	bh=+0s+HjDr+e7ICK4hmchmjiUogqHAoKWfG974lL09Jtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQpZQOLRor1vzH7cASSrG5kSeCHDl4EwK82cXGncu8aK+yu9Q4tBlC3W7D+MmYRd1pTHeuRG9KmBBH+NootoHBnC6Oaf0kcqWjtNdpGZ1ID606Yd9qqu6vDopWo/uSHa0NVyuLH00o1CBqr8ZNy9t/qX8UY5zuO/uKCO6q3KEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAH4sVpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBFFC4CEF5;
	Tue, 29 Jul 2025 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753781270;
	bh=+0s+HjDr+e7ICK4hmchmjiUogqHAoKWfG974lL09Jtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MAH4sVplXov3SKYIxe48/h6d9MSUjjOX/iAawbq2KfVInw8ToD6mdIoKPkgz1pWsI
	 a1SjEBCzjOcLahb6qBd9WyD08J3qMQDEENdMLqPEWsKTPNEleqHHm2Xxp9o3SF+o+j
	 jEykkws7jxKIolZmB/Y5do3nLstYHqEIe89c7dG/QHtqqOFgjXITlMCQKSJTNTb8nG
	 yikCB0COrmPh9VK1hmMmnSNYZCTF4EpKIrF9si+Cb3Z1cObFeHO+5XKLRGRWWFxJ8P
	 BmPJHuEDsBHVPGFDiA0Noz6VQRXKLEFx1ERjUrLbW0XgabYqv0nq9x/fEN97MTXQPf
	 Vnw5/5ixomrqA==
Date: Tue, 29 Jul 2025 14:57:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: jens.wiklander@linaro.org, balint.dobszay@arm.com,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
Message-ID: <aIiUEGt2uVF9yi1W@sumit-X1>
References: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>

On Wed, Jul 23, 2025 at 02:22:41PM +0800, Pei Xiao wrote:
> When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-allocated
> pages array is not freed, resulting in a memory leak.
> 
> Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/tee/tee_shm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 915239b033f5..2a7d253d9c55 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -230,7 +230,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
>  	if (!pages) {
>  		rc = -ENOMEM;
> -		goto err;
> +		goto err_pages;
>  	}
>  
>  	for (i = 0; i < nr_pages; i++)
> @@ -243,11 +243,13 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, size_t size, size_t align,
>  		rc = shm_register(shm->ctx, shm, pages, nr_pages,
>  				  (unsigned long)shm->kaddr);
>  		if (rc)
> -			goto err;
> +			goto err_kfree;
>  	}
>  
>  	return 0;
> -err:
> +err_kfree:
> +	kfree(pages);
> +err_pages:
>  	free_pages_exact(shm->kaddr, shm->size);
>  	shm->kaddr = NULL;
>  	return rc;
> -- 
> 2.25.1
> 

