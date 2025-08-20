Return-Path: <linux-kernel+bounces-778571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EBCB2E787
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD293174727
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8642DE707;
	Wed, 20 Aug 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3SMjdvp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626427145F;
	Wed, 20 Aug 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725514; cv=none; b=QD9wqdhJmirvnU5e7tuKprKsNucV4JeH1Y1C1BapI8GU0AV2z7z9b6G4xCwbJqoiZefXmfcZlh2ZACm1CjCZg8HMawQWitZfsJwM1hmniaIjrIoEIKylaQ+ufTYI/b/5RppGNg4jz5gFG9Y2jIBXaw5rw0luB2IHpNNeSeyehaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725514; c=relaxed/simple;
	bh=zJUri91BEY/rz/OKXIaJA70xWSYlsm2TWcaN+ekl5no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fELVuqwS8TDWqc01+bCQhJ+DekEZ9z2ZzyDJugp/HdkDWvf8GKQeHdknVJRfUraTJWId9ynIjmDSm+LxnrzuvOxbpBVCkkB6ewnG4Dke0t0HpoiO62Xa7eNlJKHKtHRkbcTjafnLpWOU4gzZyQOSfb5OvCu8lkO57QsfRzFAtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3SMjdvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1082FC4CEE7;
	Wed, 20 Aug 2025 21:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755725514;
	bh=zJUri91BEY/rz/OKXIaJA70xWSYlsm2TWcaN+ekl5no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3SMjdvpoytEKqPLGfVHtuTQ2dTjNiVHWsV7EYbfOJv/JScycBNnTe0SPnxhvrr//
	 oyLPLoulJLTS9RhjQgBfr9APvvosHCmWdIA3ewP7YatvZand/4uwmNP4WNK/yn194r
	 2tdKTG1xkNvxzaGSE/bII1DcBiHx80LP0uSa3tAkRy6wxzku7YH3q6vUna/fJC17Kb
	 K3dZK0OyP19BW/qYOOQLobDyO+OoOhOj2avIgd4q6LozYws68YHr0Tsx3SmoHbKk9c
	 8/O2dJ5h5sqvmlhx1jm9Qr5S4t/y8ILb0hzBleaWLSyttxW4xVFNoUr+zJy1FA82EQ
	 f4qZoAcZrt/Gg==
Date: Wed, 20 Aug 2025 20:31:49 -0100
From: Andi Shyti <andi.shyti@kernel.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, 
	"tursulin@ursulin.net" <tursulin@ursulin.net>, "airlied@gmail.com" <airlied@gmail.com>, 
	"simona@ffwll.ch" <simona@ffwll.ch>, "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, 
	"lkp@intel.com" <lkp@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"oliver.sang@intel.com" <oliver.sang@intel.com>
Subject: Re: [PATCH 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Message-ID: <r5xlolrlcu76f7c2a2wu75rrdekgdmxgxv6dh7jydpvb3x7ili@bzjzdhokv5xq>
References: <20250811093050.38930-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811093050.38930-1-chentaotao@didiglobal.com>

Hi Taotao,

> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508081029.343192ec-lkp@intel.com

...

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index e3d188455f67..2b53aad915f5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -514,6 +514,11 @@ static int __create_shmem(struct drm_i915_private *i915,
>  	if (IS_ERR(filp))
>  		return PTR_ERR(filp);
>  
> +	/*
> +	 * Prevent -EFBIG by allowing large writes beyond MAX_NON_LFS on shmem
> +	 * objects by setting O_LARGEFILE.
> +	 */
> +	filp->f_flags |= O_LARGEFILE;

I don't have anything against this, but is it really fixing the
issue? I thought that O_LARGEFILE is ignored in 64 bit machines,
while here the failure is happening in 64 bit machines.

Besides, where do you see in the LKP logs the -EFBIG error
message?

Andi

>  	obj->filp = filp;
>  	return 0;
>  }
> -- 
> 2.34.1

