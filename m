Return-Path: <linux-kernel+bounces-778248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3530B2E30A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CB6A213E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF4334709;
	Wed, 20 Aug 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyeacAxq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B02332C300;
	Wed, 20 Aug 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709839; cv=none; b=lqmf5ie0md2vShhQ0Czb+Gn8XBNEWO8oupMI0RNaC7iSNgZoEJA4MAS/g60t5lbQ2l8YCv+98WWtwgoHjIHWOczBI7IQOpQmnhJ5s9p8HQYPjGdnpj4+BJFgFgiBVWoj/TOaeXAMdUzDLBeEeOI/LgWsSkv9z7pXJB2L1CidfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709839; c=relaxed/simple;
	bh=8yBYVlTmuSfYyKpGmWLZFO2hyNANnEjDzENZL8tfRTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKhTMofcM4pC6TXsb/R6nqtnL5U+bdf6dFJ05z1CRt2kwegLyfeclV41EjwlV8a9ZVvfPyN58gXk0vJ3Xs+0lXSgCWfVDDwNUTA8UIfe/SP77b0A7+AkLd0V95PwE1NaTaN4UJyekhq1lROCbTf6q3FyKEUBh/7ChcaUXoll/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyeacAxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FBEC4CEE7;
	Wed, 20 Aug 2025 17:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709836;
	bh=8yBYVlTmuSfYyKpGmWLZFO2hyNANnEjDzENZL8tfRTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyeacAxqb/19ouF28LEr7auDF68bzFfdtqyhL+r1Bzmm+d5f3GoIOl5ete9PZ7CjC
	 0Wu9aOwHTtAerDU0dkjO5Nb4/iZLv9qt2pOi0tV6QMwIZqFE4fMqkB6Ix3ogcj3kDP
	 UujfUxWLrAHd2BkY/eM4tK0CULpY2Y0bSjBVl0NosHXwFW1SQhT9yYm37MiOqBC9/Y
	 jE3dYpjFScLJPu6iJg8IP6efFpjMpAud2PkXRFY0dbJFm8s5OXLi/eOUbLQWBuplhd
	 kNfi/dBaB3I7NyfgIax2kRWfOPXpPUDUSTYgP4K60KzmFxJqsSFPmIo2TK5DXe7Jg+
	 mpKGefU62J/Ig==
Date: Wed, 20 Aug 2025 16:10:30 -0100
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, 
	"tursulin@ursulin.net" <tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, 
	"lkp@intel.com" <lkp@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"oliver.sang@intel.com" <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] drm/i915: Fix incorrect error handling in
 shmem_pwrite()
Message-ID: <nd2sd2vdwif242wslgkaonuvskawho36bp6j6a4caghauzx6f5@dgkaow5idqxt>
References: <20250811093050.38930-1-chentaotao@didiglobal.com>
 <20250811093050.38930-2-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811093050.38930-2-chentaotao@didiglobal.com>

Hi Taotao,

On Mon, Aug 11, 2025 at 09:31:00AM +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> shmem_pwrite() currently checks for short writes before negative error
> codes, which can overwrite real errors (e.g., -EFBIG) with -EIO.
> Reorder the checks to return negative errors first, then handle short
> writes.
> 
> Fixes: 048832a3f400 ("drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter")

I don't think we need the Fixes: tag here, in any case we return
an error and -EIO is somehow correct.

With the Fixes removed:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi

> Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 2b53aad915f5..702532eef207 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -441,12 +441,12 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
>  	written = file->f_op->write_iter(&kiocb, &iter);
>  	BUG_ON(written == -EIOCBQUEUED);
>  
> -	if (written != size)
> -		return -EIO;
> -
>  	if (written < 0)
>  		return written;
>  
> +	if (written != size)
> +		return -EIO;
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1

