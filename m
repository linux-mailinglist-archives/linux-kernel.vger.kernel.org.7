Return-Path: <linux-kernel+bounces-686001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C2AD91CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B723A3C15
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285B1E990E;
	Fri, 13 Jun 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMWCRMed"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC227D3F4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749829606; cv=none; b=usVG16mzXe1Na7cOb/3DRz2pYL/jZCcbJDMaH4HpX+8+qmUlWrBjABzx+s7473PSomoUapIwam29rJVCTSfRodso5yh8NFIGxxYEuQH5fpJln9Xme+ZceviOYU3/mTlf+hR8li8FbXgeA1+e5mIrJbAQr+3uimKSuMrtUTxdlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749829606; c=relaxed/simple;
	bh=IDtANgWDsmydreziIfLyfgieuHG1n33t6/scdMwRLWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHQqYYnkRN0kfx8Ng0emDtCq+vyNZML7FYZpUaCvAmV5rP/6sLQ4cGOJICIVbVYdNfxaMvuTmmeYRvGaapZTxa7IWQmyOHz6WwAZszb6gacOzwH0Qu7puUQDgtNM9ThXrrpw2GbsbWIKPaLk1iU+hqEeZjSqZNtllKcZLWrPvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMWCRMed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B23C4CEE3;
	Fri, 13 Jun 2025 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749829603;
	bh=IDtANgWDsmydreziIfLyfgieuHG1n33t6/scdMwRLWg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dMWCRMedP6ZuLWCyvPAyztxL+6NvsbWNfoC2dt9pCYTQD/jr71lTneut+FdZQItLH
	 S/iMjkvc9p/bCWZ3hiQN+SGGBAZmyRdlalMWfK5pc1uFJYfYuZgoPMk+JeTG/UfwlA
	 sgpFr2nr6BsLOlzyrJde/L3PXCPk2xJDK2JrSgVmRPHWjvGZBd1C0SvMbGvly1QIjv
	 Vy6KUAnZIq5BJ5KtG7Dzk9jSXzTyMP4ceelEG22fmrfCsRmcy+18HSNAL6emLZaaw5
	 SwSljwYL4+4CYS3l7tGJxEuqhxph8scxg19H3M4bZw3cnmCE37Lo+thMfHsxZVEwua
	 IMMJCY2bXD+EA==
Message-ID: <d1b19770-dbee-47d0-a146-409de76dee42@kernel.org>
Date: Fri, 13 Jun 2025 17:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/nouveau/bl: increase buffer size to avoid truncate
 warning
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>,
 Pierre Moreau <pierre.morrow@free.fr>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Philip Li <philip.li@intel.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Timur Tabi <ttabi@nvidia.com>
References: <20250610-jk-nouveua-drm-bl-snprintf-fix-v2-1-7fdd4b84b48e@intel.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250610-jk-nouveua-drm-bl-snprintf-fix-v2-1-7fdd4b84b48e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/25 11:54 PM, Jacob Keller wrote:
> The nouveau_get_backlight_name() function generates a unique name for the
> backlight interface, appending an id from 1 to 99 for all backlight devices
> after the first.
> 
> GCC 15 (and likely other compilers) produce the following
> -Wformat-truncation warning:
> 
> nouveau_backlight.c: In function ‘nouveau_backlight_init’:
> nouveau_backlight.c:56:69: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Werror=format-truncation=]
>     56 |                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
>        |                                                                     ^~
> In function ‘nouveau_get_backlight_name’,
>      inlined from ‘nouveau_backlight_init’ at nouveau_backlight.c:351:7:
> nouveau_backlight.c:56:56: note: directive argument in the range [1, 2147483647]
>     56 |                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
>        |                                                        ^~~~~~~~~~~~~~~~
> nouveau_backlight.c:56:17: note: ‘snprintf’ output between 14 and 23 bytes into a destination of size 15
>     56 |                 snprintf(backlight_name, BL_NAME_SIZE, "nv_backlight%d", nb);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The warning started appearing after commit ab244be47a8f ("drm/nouveau:
> Fix a potential theorical leak in nouveau_get_backlight_name()") This fix
> for the ida usage removed the explicit value check for ids larger than 99.
> The compiler is unable to intuit that the ida_alloc_max() limits the
> returned value range between 0 and 99.
> 
> Because the compiler can no longer infer that the number ranges from 0 to
> 99, it thinks that it could use as many as 11 digits (10 + the potential -
> sign for negative numbers).
> 
> The warning has gone unfixed for some time, with at least one kernel test
> robot report. The code breaks W=1 builds, which is especially frustrating
> with the introduction of CONFIG_WERROR.
> 
> The string is stored temporarily on the stack and then copied into the
> device name. Its not a big deal to use 11 more bytes of stack rounding out
> to an even 24 bytes. Increase BL_NAME_SIZE to 24 to avoid the truncation
> warning. This fixes the W=1 builds that include this driver.
> 
> Compile tested only.
> 
> Fixes: ab244be47a8f ("drm/nouveau: Fix a potential theorical leak in nouveau_get_backlight_name()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312050324.0kv4PnfZ-lkp@intel.com/
> Suggested-by: Timur Tabi <ttabi@nvidia.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Applied to drm-misc-fixes, thanks!

