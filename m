Return-Path: <linux-kernel+bounces-822603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF65EB84422
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87812466865
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A12882DB;
	Thu, 18 Sep 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DszInJVe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7A723ABA0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193449; cv=none; b=rO5abHtjwfYWGd5ADkON9ZYhcMqZnBtcU2Y2XfjRTrp+NOuY9ETiA0JDzy/QvjY5fL/eBGoInebgQvDmuEX08+5jZYY8J6TkJNtLN3pF452OAP2uykevslt2mz8QGt3NfGxSrF2lBQRqakMIo9T758dzyH/TOr5avVTHUQzWPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193449; c=relaxed/simple;
	bh=KCM2an48/bEFBf8NS7uq6k/rwlRWv7+LUFybPERbT9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoPnOd1eMjHklOEcn/b5etuzPk5xWcb+gaL/5Z0i62lx4tKdAUfYBpOyUu8zpwnsJJktEPuIL+u7yVfIB/ugfqLX4LZHhkQB585tSBNL2Onodlj0oqButjNMQ4XXIQNQHFW1pFlsbGiGPqDRTrigUX1GE9rbiWZRmrnEB7Q0SUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DszInJVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398A7C4CEEB;
	Thu, 18 Sep 2025 11:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758193448;
	bh=KCM2an48/bEFBf8NS7uq6k/rwlRWv7+LUFybPERbT9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DszInJVedDqIo9ecQpafmUEKYnRlqKAGgF9vtF+tMzodzbGhTryFMiKR1RiQKN+Wt
	 +kmWJNflvgrf8kzc7bUZcd0otxxM9bU3STK6LqeEJ6azTLS6NYjF27koSDY0xLEA9h
	 XxxV1YxeYHZvj92g/7oT1vZloB0YvEh+3C1zFz00qAFr4ReHrdI3+oCjY1YyKBLZpj
	 HTqNYRpY+XbpIUKq1DbHXCNVAP4EWV/ngsouhcIaP1YDbyB/JM4syD9B3RatAp6Pu9
	 +zQql+vcpfBZUaEthnFQ9gh75wnSdKjb8qSd5tDh4lcTv2knVxxbkfMDy1IQQhFFfs
	 LTOkGJhqFSikw==
Date: Thu, 18 Sep 2025 13:04:05 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, 
	"tursulin@ursulin.net" <tursulin@ursulin.net>, "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"chentao325@qq.com" <chentao325@qq.com>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Message-ID: <fumkp34yvnyibpeyfqbiactmjhkuvpzhj52l45xjzygjwv6zny@ooydqcmamfr5>
References: <20250822030651.28099-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822030651.28099-1-chentaotao@didiglobal.com>

Hi Taotao,

Both patches merged to drm-intel-gt-next.

Thank you,
Andi

On Fri, Aug 22, 2025 at 03:06:59AM +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> Without O_LARGEFILE, file->f_op->write_iter calls
> generic_write_check_limits(), which enforces a 2GB (MAX_NON_LFS) limit,
> causing -EFBIG on large writes.
> 
> In shmem_pwrite(), this error is later masked as -EIO due to the error
> handling order, leading to igt failures like gen9_exec_parse(bb-large).
> 
> Set O_LARGEFILE in __create_shmem() to prevent -EFBIG on large writes.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508081029.343192ec-lkp@intel.com
> Fixes: 048832a3f400 ("drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter")
> Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>
> ---
> v2:
>  - Add force_o_largefile() guard before setting O_LARGEFILE
> 
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index e3d188455f67..b9dae15c1d16 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -514,6 +514,13 @@ static int __create_shmem(struct drm_i915_private *i915,
>  	if (IS_ERR(filp))
>  		return PTR_ERR(filp);
>  
> +	/*
> +	 * Prevent -EFBIG by allowing large writes beyond MAX_NON_LFS on shmem
> +	 * objects by setting O_LARGEFILE.
> +	 */
> +	if (force_o_largefile())
> +		filp->f_flags |= O_LARGEFILE;
> +
>  	obj->filp = filp;
>  	return 0;
>  }
> -- 
> 2.34.1

