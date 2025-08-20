Return-Path: <linux-kernel+bounces-778239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC1AB2E2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFD1188E12F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB26334398;
	Wed, 20 Aug 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/i5HDTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3209333437D;
	Wed, 20 Aug 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709428; cv=none; b=cD0BcLpJHo0foGcIwNyDT1NaRyUKLvKcWIPsvzDfPYLl4QPuufxhwlY083bGy5TTcvZEtwqmdMh7XFLuu1Fsv/SSuKRfau8sUSnnTL3UsUbAsfHgxJOCEonr0w2ZAqc0yykk0csrVmW8/YyH6MUrz9X3kuzdiYAta6jC3QZtMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709428; c=relaxed/simple;
	bh=F8pzRaXPC9gDWVwA2CxtyHusLyWewb8f3lbaL+++X+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd+iJDew8iCdQAx6vgchU5bn5UU1o7QHKm/n1QM82itqNJIaHIj2M/fp1y7cpo5ZR2w3eiiGo6oJCSpJ8ZcPpegWbNCmtQxMKYtgZVTgc0VUbdTJKO9/FvEzJrH8IKAKo/OlvAYz9K0ulQxuqFvDw429f3pgJH4ndGPqmmmteg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/i5HDTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AC6C4CEE7;
	Wed, 20 Aug 2025 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755709427;
	bh=F8pzRaXPC9gDWVwA2CxtyHusLyWewb8f3lbaL+++X+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/i5HDTV2jl50h2a7hFLz1TuEFIBZnzHfAq6lCD30LhaSlBZatmOyZYGj0XTmSvTO
	 rswI3c2XTr4N54qAUp+8VMrcDlvpIcGOt8jpcI788lckwwNI37UteDU51bw4roSYqv
	 8M3dnEQNGtXk7Q4vuxM/914TTCbMXsnNFXMJ4HBblKjLP/kwhAxqqxH+SRY4MfY7DV
	 9hKGoSJAQq0zUpKz2dAkgpYCDw4BXaWxRapCsChisKA4ZKLZzd6X6RSmDbM79AGlA3
	 1w+VYDY6EUCQE12eplBcjjtHGsGHnC+7tpGhVPGhRn43bmmLnCOlN2pl1P2OTAi1vU
	 mxcpXYt5G8Tgw==
Date: Wed, 20 Aug 2025 16:03:44 -0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>, 
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "tursulin@ursulin.net" <tursulin@ursulin.net>, 
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "lkp@intel.com" <lkp@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"oliver.sang@intel.com" <oliver.sang@intel.com>
Subject: Re: [PATCH 2/2] drm/i915: Fix incorrect error handling in
 shmem_pwrite()
Message-ID: <k53h44tbytos5tvvbg263qpbkl4xzjcsj35fmpzxxie7dn7z65@ombf4w6za4ui>
References: <20250811093050.38930-1-chentaotao@didiglobal.com>
 <20250811093050.38930-2-chentaotao@didiglobal.com>
 <aJtKbg28QMPgvunP@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtKbg28QMPgvunP@intel.com>

Hi Rodrigo,

...

> > @@ -441,12 +441,12 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
> >  	written = file->f_op->write_iter(&kiocb, &iter);
> >  	BUG_ON(written == -EIOCBQUEUED);
> >  
> > -	if (written != size)
> > -		return -EIO;
> > -
> >  	if (written < 0)
> >  		return written;
> >  
> > +	if (written != size)
> > +		return -EIO;
> 
> That's awkward...
> 
> I mean, you are right that we cannot overwrite what is returned from the
> write_iter function. But perhaps this != check here should be before?
> 
> Or it at least deserves a comment in the code telling what's the intent
> here. why != size is -EIO... but it was already written :/

The check (written < 0) is completely useless after (written !=
size), so that I think the patch is correct.

Andi

> > +
> >  	return 0;
> >  }
> >  
> > -- 
> > 2.34.1

