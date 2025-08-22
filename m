Return-Path: <linux-kernel+bounces-781651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC3B3150E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073216056EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A42C026D;
	Fri, 22 Aug 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzazrvfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A91263F22
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857899; cv=none; b=KyEXkTw3LhFkne9mJZlK4lFXPxZehGYSikRKcqVwFYvzYOpwV1/HuD5Lh90hkImWoiZsqpfgD6avJ9rIgCkHllaZY7HmpghHBjJrD5NXBHa13seIUIXKRb78J9SXBwhnWYq+sAMCX3VuxNQj0JFToEOqAjX9ejHeizoIAAnlShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857899; c=relaxed/simple;
	bh=1fB27n5JTMjVzGa/sTr3HtsBVkgmIvD/LusC6aVNuMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbUwYhmu29Sifej3uPQmjB8frbNerNN2woKzqGPkm8XDrqH7b5Ssx2DOmL5J/WUuCkDb/mbcWa8JUYYORvg9n6cwmZEyGcpDSdG2RsmzRA2SRYuNFdXybB/Wqw5evZm/zlwG6tnA/yi4UJ5+gG6lbm1VhoNYl8PfY0TTktZcdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzazrvfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9CEC4CEED;
	Fri, 22 Aug 2025 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755857898;
	bh=1fB27n5JTMjVzGa/sTr3HtsBVkgmIvD/LusC6aVNuMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzazrvfBhQctEI2vRi4/G+q8Ayv22aSTeDVUPajlFIkTi5MrPnmJLvTZ3FUA2vMkh
	 AfB3iHWpsrTa7JO+n/mKg1zx2JuDbTgD2IeApU+1rFcfw/oQVb2SwsQb24cES6wSQ/
	 4XsTUDn4RAbVor3qQqehPCXTsWhzARGO5VSxC3xmJuyVmbldzf4+XUsHTknj9PeiWG
	 g/eylqQvMWtam+SrECS4tOgsRryDIC6Y/kScWqLVacPuCjZO5cjxt0bkZyc60GF2pw
	 Z1rPuhHtCDZU7Kk9hE7IispjjJXitmWu9dH5/qPOzysY+lO+3WF2r36uDeWfHfDtG1
	 A2N7DwX+B+O/A==
Date: Fri, 22 Aug 2025 09:18:14 -0100
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
Message-ID: <wccu37vpmx7ylxwkivizw2yplxg5syupi5ugmrms7zvrk23wzs@ogtt3fybbmjo>
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

looks good to me:

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi

