Return-Path: <linux-kernel+bounces-816876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E0B579CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FB616776B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFD305044;
	Mon, 15 Sep 2025 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um+iNDaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703BA2E2EEF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937839; cv=none; b=X9f653BYVjng5H6/vNgaSLiMtYnTIbSAAmuhRzpz0LgDQGUlPSixJBH8CcxqQKGhA/vySODLrQ7/NLsHV5bxZJS831oT00Ep3ms4ZErUFGg5Jl19BHc+sLPZpgHkmQ/L+B27OdHI1GwPW+4Ls6fzqlFvjKswkqFdmivKV4gJKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937839; c=relaxed/simple;
	bh=tTfy69vuxcsU0PPDO3wtMtWUyYHQN7GhuK5IHt9W66w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zprek4FhfzOrjI5i5sXH555/6T4jUD+yG1wSWRp6wGWT6U3YMAwDWIykM1mmsM/hXqVsAz7ahLKMgGoJ8AX2h1gackyH5nvzQvmORq6d+ws/es1nFZSd7ECRAwfQhhqRp+3azACrTItAXFho06Q/E7q9P1MTPUZvTEJvLGUQbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um+iNDaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD70C4CEF1;
	Mon, 15 Sep 2025 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937839;
	bh=tTfy69vuxcsU0PPDO3wtMtWUyYHQN7GhuK5IHt9W66w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=um+iNDaY5sm+GI9HU+djJgAGEmA9bdYR1bLywEgyWVD9icTvUIamHBufH4D7TrB4h
	 NFT5JcBypNaV222BxoAm6IVKhLNi2ybdCUKXGAUXiF5VU0ASS3XFv8jUyqNLzoYlCO
	 vq3QgtHm5idvE55znTw+A/uFOwjc3Z8vZO9lqq115dPSJqAUObxMbOJcn44IRX/1J3
	 Shk7WHjYKrWWAsMNvhzhYiGkGvKWFMx5k9TJswCLYJjLPmGfro+k9ETBPxzAM84Ycf
	 4molWQjeSug33NlkJ2Np5aH+ipu9v+cog81j8a7HQmn8EvmhWM5heCYc4WJHtalgcK
	 SvLSdMVI7IhlQ==
Date: Mon, 15 Sep 2025 14:03:56 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Taotao Chen <chentao325@qq.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, 
	"joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>, "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>, 
	"tursulin@ursulin.net" <tursulin@ursulin.net>, "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>, chentaotao <chentaotao@didiglobal.com>
Subject: Re: [PATCH v2 1/2] drm/i915: set O_LARGEFILE in __create_shmem()
Message-ID: <eijc4lnkdfsk6l4go2psyt4g6ufrha7sijeearcvuo7nqrbkby@kqod2veuvaco>
References: <20250822030651.28099-1-chentaotao@didiglobal.com>
 <tencent_EA6C39EF0B78D46EA32051C7151E859A2F08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_EA6C39EF0B78D46EA32051C7151E859A2F08@qq.com>

Hi Taotao,

> > Without O_LARGEFILE, file->f_op->write_iter calls
> > generic_write_check_limits(), which enforces a 2GB (MAX_NON_LFS) limit,
> > causing -EFBIG on large writes.
> > 
> > In shmem_pwrite(), this error is later masked as -EIO due to the error
> > handling order, leading to igt failures like gen9_exec_parse(bb-large).
> > 
> > Set O_LARGEFILE in __create_shmem() to prevent -EFBIG on large writes.
> > 
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202508081029.343192ec-lkp@intel.com
> > Fixes: 048832a3f400 ("drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter")
> > Signed-off-by: Taotao Chen <chentaotao@didiglobal.com>

...

> Just a gentle ping on this patch. Any further comments or plans to pick it
> up?

Unfortunately your patch has not been picked up by our CI, now I
re-run the test.

In any case, your second patch can't be merged yet because your
previous one(*) has been applied to the wrong branch from
Christian while it should have gone through drm-intel-gt-next.
Now we need to wait for a backmerge.

In any case, if the tests succeed, I can already apply your first
patch so that it gets included in the Wednesday's pull request.

While the second patch, that is not a fix, has plenty of time and
can wait the backmerge.

Andi

(*) 048832a3f400 ("drm/i915: Refactor shmem_pwrite() to use kiocb and write_iter")

