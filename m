Return-Path: <linux-kernel+bounces-839040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9ACBB0AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0554B189B5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53CA25F780;
	Wed,  1 Oct 2025 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnFdWvwj"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9D212B31
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328572; cv=none; b=lzzqNWp677hg96c11qOqBpNmoj3dzUpEw5wWevkVekO99uwgdAOtiv7solOipHjSniBe7YW7Iw8CXCwk8g2EXeJS1w+xEDA4R6gH5ZGb/33IOu6Dsx67eitk0F2b9x1ESX595RtqZL/87tY/+V2HL0l27uYm7Gahh0JxHZ3mSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328572; c=relaxed/simple;
	bh=r//BOeg6hJFiIpgXCGuyUcHwsmeUXaZtItuSCfFTHEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNy3ZwxW7EVBJaWGZJPp3B8aVS2uLxVXdr9zXbQ6bfnIrxak4BmPpHLjSFK714P3XBY7r+l54X1S66P0JpORFfUMtqfpOrRMY+kQnpMEaREGxbQZdVtdHCDBmTaavUldtQqOfefqD1JhWhPmCKht//YkmYU7J6parQ1nbtbEeeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AnFdWvwj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so929561a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759328570; x=1759933370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZWPPQ16OuhZ6r+akwzEf9yapy+ye4jCYQdCK+8Qq+M=;
        b=AnFdWvwjLnuMnEgtdiqGt28oZTIphJMJUYJBikA82HLCyxwwrzonbv5yZD1H0aJJtg
         eTcbUjd+0fkjE+TaiRrb7NdXz1xpGukphjKGkhkVU9B1p6YODCHMRXDD+zCXfNwmtdpC
         jiBfpLQaA3Yh8IqtlIekQ0andiiorSBV6auLv3gzc6Go2TXsyw4s9cqMuGaZCBRTpvZz
         AseDC0oD0z0o5T9BrUM1i4nNYC8m5zypDiHa1tU/t1DW3bVrPRESTLSAKOLLJd7LfwJY
         pzyCFIeZ+1yAS5334k2OPVOZhx2RtKNW2CImP5aAfd80Y7AD+NuoL7Zf63oJpKjmgvLB
         nE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328570; x=1759933370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZWPPQ16OuhZ6r+akwzEf9yapy+ye4jCYQdCK+8Qq+M=;
        b=d7nVUYnDqjn/JNetUb4Bn+6qG4HxgFDZZ1rbETqGovqT4RuctpuNfUQGAXoU3cfYNP
         bkuraacLW9DyeMYzc+v/QDUgVZAscR+M+zL8BeVKnS/wqu/8PVnD85Hua57PQUs0y4nf
         yph6wgo+vzIDZenmh6/mo/hrkOV6n5YWIWcG22TlyqO5WrSvNraqB5EeEgNDwtvi8HQA
         7aHOM7fsiGQxDSUy6H5mVhTFRbjJgZrEZV7C4SsfO4xxRoZghWlkpwpT45LVzTDaebZv
         J1hCWDLmwYnRMWQSNl2PJ8GCbcKVl1xdqfTEF1U+BxE9mCbFHFHNKROJV69BvnuVGk9G
         REtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjfvqlWKnqIc9BUNYmQjc4fEhbf03NCBmGzSpaZwC6mbfS3jiEWlGgqyz2mFl4ALJFAVQmlJTjNapSHso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaE9/MUKJ10EUbQHKsqQh5XQSThdRscuIkR5XMfB3+dh3tx+o
	hNC+CXY40KAvIYBgvFOlWlzSYh4jTzwI5xxIS9wC+A8wMQt2YuZcOKcaVF6GK0FYSGs=
X-Gm-Gg: ASbGncuelOxurz0jfd/4UvGQ+l1gHALb8Okf/qZdTmz+6tJSLnYiaevLeYrNiQb/D4y
	uUkcPRS54i5GwiQt2N3EhQulZWUs/2trCSRZt2bDwKQy5zVpfFcXRoFrVqGqtOQAZIP525y0b6l
	25sRafRLYBm3POe8Cn+6VVtZJlDpNXMyzpFfnTWqDlsxtITQNVjZiz4btkzThresGuwAyDGOdKB
	Ge0Zya2e7SROOZ0LsiGghVO5TxNrCkkOgFtGtLJtLaVueMWlQgWKOAWF9jcFf/jNpmlBjtVmclr
	GbbgYWxOxptOdJL6i4HGS/GR1Ek8mI4Q956J01iTTb1Hz6GTAbisg0Mg4LViJ2x0zMRnoanGm+F
	XOsMPzJOJ0sd65kx2si9+hWaaJGlO24/BdAWyJrQc2ayRm+7+Znmuv2rHAozZulbG0ZO7T8qIof
	X/ftVCvM09r8MjC2069CL4S0jhzdLduOLofkVAwVRKcbqDF+b/
X-Google-Smtp-Source: AGHT+IHqVeD/wJUVy5+C2bUJIvZQddubc9m4Xd4Qgoes6H6s3Vr0Kf8vrqdjy3H/lxWJPRN6L5BOvg==
X-Received: by 2002:a17:902:f546:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-28e7f440582mr49997025ad.56.1759328569779;
        Wed, 01 Oct 2025 07:22:49 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:8417:c9b5:17c4:6237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6aca043sm186020025ad.138.2025.10.01.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:22:49 -0700 (PDT)
Date: Wed, 1 Oct 2025 08:22:46 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] remoteproc: imx_rproc: Use device managed API to
 clean up the driver
Message-ID: <aN05NsINB25lW_Lg@p14s>
References: <20250926-imx_rproc_v3-v3-0-4c0ec279cc5f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-imx_rproc_v3-v3-0-4c0ec279cc5f@nxp.com>

On Fri, Sep 26, 2025 at 08:33:14PM +0800, Peng Fan wrote:
> Tested on
> i.MX8MP-EVK, i.MX8MM-EVK, i.MX93-11x11-EVK, i.MX8QXP-MEK, and i.MX8ULP-EVK.
> 
> Retested all the patches for V3 on above platforms. And pass build
> with patch incremental applied with ARM64 defconfig. pass build for
> imx_v6_v7_defconfig with all patches applied.
> 
> This is the 2nd series to cleanup the driver.
> 
> Patch 1:
> Fix the runtime usage. This is not critical bug fix, so it could be
> defered to 6.18.
> 
> Patch 2-6:
> Use devres managed API to cleanup the error handling path and remove path.
> 
> Thanks to Ulf for the suggestion on the runtime PM fix in patch 1.
> Thanks to Daniel and Frank for the internal reviewing.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v3:
> - Follow Ulf's suggestion to address the runtime PM in patch 1, and add
>   Ulf's suggested-by tag. I dropped Frank and Daniel's tag in patch 1.
> - With the changes in patch 1, the remove() is kept, then there are very
>   minor conflicts when picking remaining patches in V2, so I still keep
>   R-b tag from Frank and Daniel for patch 2-6.
> - Link to v2: https://lore.kernel.org/r/20250923-imx_rproc_c2-v2-0-d31c437507e5@nxp.com
> 
> Changes in v2:
> - Address a build warning in patch 4/6
> - Add R-b from Frank and Daniel
> - Link to v1: https://lore.kernel.org/r/20250917-imx_rproc_c2-v1-0-00ce23dc9c6e@nxp.com
> 
> ---
> Peng Fan (6):
>       remoteproc: imx_rproc: Fix runtime PM cleanup and improve remove path
>       remoteproc: imx_rproc: Use devm_add_action_or_reset() for workqueue cleanup
>       remoteproc: imx_rproc: Use devm_add_action_or_reset() for mailbox cleanup
>       remoteproc: imx_rproc: Use devm_clk_get_enabled() and simplify cleanup
>       remoteproc: imx_rproc: Use devm_add_action_or_reset() for scu cleanup
>       remoteproc: imx_rproc: Use devm_rproc_add() helper
> 
>  drivers/remoteproc/imx_rproc.c | 100 +++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 53 deletions(-)

I will apply this set when 6.18-rc1 comes out.

Mathieu


> ---
> base-commit: 8e2755d7779a95dd61d8997ebce33ff8b1efd3fb
> change-id: 20250926-imx_rproc_v3-a50abed3288a
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

