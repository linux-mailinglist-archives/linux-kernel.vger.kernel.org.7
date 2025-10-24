Return-Path: <linux-kernel+bounces-869055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69403C06D16
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF7EF505740
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48530ACE9;
	Fri, 24 Oct 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjgZfDZY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E12E238D22
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317830; cv=none; b=ojc5lx0MmszBdudpupxs74BWLCjt85Lsr9h7pxWF1klkheAht4HEvOpJyHxPtguzCPj+MHA7++Qdy7dDE2v6z6CkryJVJDDVgsDYMk6gbn1P6KvzUI2qNFITCMcZqKd/MmD46pxdIfLNvlfOD5585Stp/LVTJ25OKoEwLU2Wd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317830; c=relaxed/simple;
	bh=2Gdzw3WVYRJrj+tAW+aUSUhL3LT+JzMOvceW8cfS41A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So/OSRNOjk4aBtw1uDZV+4z2t31ovZLSSeB88rur/YDapGaRAkLZVOtLaubkWr1SSrmJrUYPaWgTMNRUbiHmrge9+yKCEkhfyKLxc1e9pQECjqX9IMlxB9a5/nNZ3uZ+wt5OkHmopwa2T0F1HHZCPPz8Bo19uKz98o2QKWczk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cjgZfDZY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7835321bc98so1770646b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761317827; x=1761922627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fNgqejn0snMI7/1tTSNTK/NI2vBJ1tJBuHbuhBMpg0I=;
        b=cjgZfDZYlYl7XU3ffN0p5RhEpf1FGTswWJCxJXxgHJHkhdBzYKOgpiuFnh1ie7Hv3j
         e2qhWOfEkyK+xupmo5KpPe+G+czFh16yuUyPTAtQZVjNb7FLk7nu0OKNiMteUmWPGkhy
         4AB9zcXItlvIKMXwDjXXZ6Sjc4XQEgA7gY4TeKtC+1ndZGlrYSjE8mUJb0ScrBuySAG1
         MTeeR9Ru94fnRdG1ztL4fRrGaWxJW1xtIKbDfFkvGLSCLByCO7ccLSWC++kka7YmipZM
         4dHfespCVtH2MDFqb89Q44Kv/BgpahmhauAvBoUHyOBoqWI5FK8aJfgNr5omJc80W+zk
         AIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317827; x=1761922627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNgqejn0snMI7/1tTSNTK/NI2vBJ1tJBuHbuhBMpg0I=;
        b=NfM3wmlSB125AelaCNDQQHKLdMh8N+Ad6qsMM0krZ+kExISCAhnlTxmzP7z+n/VZBO
         RXAe35Fmtfa5QNKEdi+8+DeyOkmz6vw/YfCuv9Wu3CTOSaq/bQGI1YJoV0xh8VMdkRLj
         weaChcUU5UaXcpoyC9BMjTPMf95/cX3pZX6OHWdNW3uZQwiZ/FlzLGgSj9V+NGqnI6Ze
         Nxfyxtnkto87X2L3YjaONoAQzXKZVHejfmTKqug8g+Re8++NoLsGpP905AAMBPPUfwqj
         5TfUQyTaeO09r8L40cQ+Jj2CkwFDNFwwDV4nHRbfKsKUed1FBieRG6PcdXPXQWx2nM2g
         uT7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXIEbpwTbXGKIXZNqO7LKdZLeCak8WqXdKGoWtzZzf38kL6JuT2bh/U9VbRniUwM12fYRHQGjDnJUzXrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyassESXDkgNxyEE/X/r0n1XyHESDk2xRDxsyDiLXxFjcOJ31MM
	DqSg/04DoncB4la3H/bd9rCFNXZIuYXXX5pBch2bMld0o8L0SbmYHZEt3/lPsKg6nVY=
X-Gm-Gg: ASbGncu/1/SfsWEJZgr/z7WxqojfQUvHdY+4OoD9gtNnALEQEe6z9KZ0zfA4OmPMz7W
	IjZkOf4rlQrcMiL/8ItxVjOFhqDaXXiyd5DDFCrPDBcrccGINKjiHp+pZAfWOcdoULKNVoLGFRF
	/TV6hhRTgDJ3jXWt56CpJp/F+OSye2FROVWAB6IXb9dH49sC3pZu0xrdmS4rUZDgZs6S/mnsmSg
	BZEXRk0JY2WF/LxdhTSu6MQI4MUVbD1Fe/mpgEk41yfWamUs8Xiwqy7eTyRD1sOltt3BoAPCj95
	LS9CtKjR29WvMvwOdvaYJaIZAbo9zZPnKQiEKxnBhpgNCcoVXm3+2Jrb1JIGmH6ctFem7o/IKBs
	+5ofgdRtT6nVQqbfLYShmQL8l4ACsaO10OZdXXj/qgPnkzRCW0Q41ObbRC3OIKJslXho2y3Wo7W
	/LfBQjfObQzdvKZw==
X-Google-Smtp-Source: AGHT+IGnvRnOZR3DiY7JhKO8SRec8hM8slbNby+lqNU1ekdPW6OjTB5ZanBZl2r0I0MYXIlNVfB9eQ==
X-Received: by 2002:a05:6a00:22cf:b0:781:1481:897d with SMTP id d2e1a72fcca58-7a220b16cd0mr40051833b3a.17.1761317827102;
        Fri, 24 Oct 2025 07:57:07 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:c4aa:f655:2dba:5bb5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a64d75sm6192792b3a.13.2025.10.24.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:57:06 -0700 (PDT)
Date: Fri, 24 Oct 2025 08:57:03 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <Frank.Li@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] remoteproc: imx_rproc: misc clean up
Message-ID: <aPuTv5RCWo3eGc5y@p14s>
References: <20251024-imx_rproc_c4-v4-0-af83ed3fdbba@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-imx_rproc_c4-v4-0-af83ed3fdbba@nxp.com>

On Fri, Oct 24, 2025 at 10:51:27AM +0800, Peng Fan wrote:
> This is the 3rd series to cleanup the driver.
> 
> Patch 1: simplify clock enable logic
> Patch 2: Add a platform detach ops which will be easier to support new
>          platforms
> Patch 3: Enable runtime for all
> Patch 4: Drop method assignment
> 
> This is the last patchset to do the clean up for imx_rproc.c.
> After imx_dsp_rproc.c moved to use platform ops with swith-case removed,
> the method entry from dcfg could be removed in the end.
> 
> Tested V3 on
> i.MX8MP-EVK, i.MX93-11x11-EVK.
> 
> Tested V1/V2 on
> i.MX8MP-EVK, i.MX8MM-EVK, i.MX93-11x11-EVK, i.MX8QXP-MEK, and i.MX8ULP-EVK.
> 
> Thanks to Daniel and Frank for the internal reviewing.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v4:
> - Drop patch 5 which updates MAINTAINERS entry.
> - Add R-b for patch 3
> - Link to v3: https://lore.kernel.org/linux-remoteproc/20251015-imx-rproc-c3_1-v3-0-b4baa247358d@nxp.com/T/#m68811fc8e9fc92d2c091926b0d5e699e8d888fc6
> 
> Changes in v3:
> - Rebased to latest next branch
> - Resolve the conflicts in patch 3 to enable runtime PM for i.MX family.
> - Add A-b for patch 5
> - Link to v2: https://lore.kernel.org/linux-remoteproc/20250920-imx_rproc_c2-v2-0-3351c4c96df5@nxp.com/#t
> 
> Changes in v2:
> - Add R-b from Daniel and Frank
> - Update comment in patch 1 (from Daniel)
> - Update commit log in patch 4 (from Daniel)
> - Include Shengjiu as maintainer
> - Link to v1: https://lore.kernel.org/r/20250918-imx_rproc_c2-v1-0-deec8183185f@nxp.com
> 
> ---
> Peng Fan (4):
>       remoteproc: imx_rproc: Simplify clock enable logic using dcfg flags
>       remoteproc: imx_rproc: Make detach operation platform-specific
>       remoteproc: imx_rproc: Enable PM runtime support unconditionally
>       remoteproc: imx_rproc: Remove the assignement to method
> 
>  drivers/remoteproc/imx_rproc.c | 90 +++++++++++++++++-------------------------
>  drivers/remoteproc/imx_rproc.h |  2 +
>  2 files changed, 38 insertions(+), 54 deletions(-)

Applied.

Thanks,
Mathieu

> ---
> base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
> change-id: 20251024-imx_rproc_c4-89967b4158b6
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

