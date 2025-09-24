Return-Path: <linux-kernel+bounces-830954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F12B9AFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EFA14E2A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBC2314B61;
	Wed, 24 Sep 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KBl6wunw"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D330E859
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733848; cv=none; b=rXIhQ3+hUdhQZr+SaJ8czaCWXhNejfra12f2Q/QK2K272MlGpFDB/CW4+Gl+rnjfwERjFm1LcD0/2RXdQInJ5vtXRCxHB3oq3/dnvlp1zTSeaQlJECC63B3ZKtCtd5uLG6/YRtnkdYMLpQE0gv9Rupul/DlVjRe8cUlVLFHkz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733848; c=relaxed/simple;
	bh=HYExp4oXUsQAT4HO6WQsgWUuJ0hNRivj9oi+MVWi8Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ0oKE4gHM461wxy0SVWE0ROWOyKPDPR3zehxERn456aI+Xcx1rkx+FE3qkQC4AgcdOkwzD2aflk77Whi8Dx72ZrkoE2yZRDBtDNA8mYrWvmLkfegs9NFedhtqV5FQrJCwVJwzrwRG0x589Iz2bnbHUcqyhMtO83ur5FUaWMbt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KBl6wunw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6349e3578adso316334a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758733845; x=1759338645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5p9OhedmlgnqtH6MtrKzkYKSqLa11Xwu0UHh8KLtW4=;
        b=KBl6wunw+4EA/FhnKCiGh3Pe911aEGb5RwLEQyEoyMZ/hDLfCT1T2xs1JTgbE/EEwH
         nrXaTRMZ0FQci8kQnfiQvKtawKWOSCaUVL+8QVYp04Azkw5LIVQNpntF3VAfc2PZZIOL
         g4ED/gDlLiWufK9vWLbdpwQppZzUu3e2Jzd7/gEA+qiRcDWWetWtgSvftfkFPmsdJ8Lm
         zhYgsZAT+Klz+qjcYuSOyjxNu+KoCmICh05SWANc0TMHrYiT+JVTQBYaXS4mNoVGSPCZ
         B1GXwDGXK0jjrXJX5aQjsy+K2CFGRrXrKPoF3Zn57bKdr3/5nzko/ZJL3n+OG3vrDDNq
         fz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733845; x=1759338645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5p9OhedmlgnqtH6MtrKzkYKSqLa11Xwu0UHh8KLtW4=;
        b=eV4TSkfUwsUwOK5i5Es44GwhHwLO5n8xhIX2+rbkb8NKFz4kg3rK0pNu7vsI8ko/vt
         xrJteyv6V9b3TFUCW2CBFIXhRC5YnbJZ1TpsocwL4QtatZ9QGyPvvJmO68ineGHP9Dfc
         hwIetCrDcnIN4PM+PDNC/5otBYhIt7okxmLk6rjMvRrxPjd29r/lfTWOmDP2m6wsLY3Y
         /ZAh95Ox3LzhhNJHbFkyI4dsGw4ulYrRXzQEZZbUQc5P3xeFOQZ8NXLYGo2ySNcXRz8p
         F1Iz2+dKeOO3bpuPQWiI+rihzDbij+YdomnRGJ9VGl9Qnl39K4SceO3QTGXBW9tbKPZL
         TacA==
X-Forwarded-Encrypted: i=1; AJvYcCUK5wZptCw5FAJoVMt841v0VmbDcR5qjkZUQIXHXqwTRFGSUwUkrDSzFWiT5ckdussNDK/ihWwv0aJYIRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbwOsc9AEvTMuTVtzf95UuxVwIJoAUDeUswvUI6qoIaXTqYdc/
	YxsLcMsQRiGyRobyjwqozuHRgds03wXSpNVbbLQL8iHkFH2n0m+b3mU5D2aJKb/iJUcF1ZRTHyG
	Q/Wtq5RQ5pMn0RT7vYWeHHRkfzLAXLpwDZxeaaktMFQ==
X-Gm-Gg: ASbGncu2sT+YHvdF7ztQXM4DofsbGAt4r5jbRbQjhoTElKzrflmA0Nk/o+tKwMQpfcq
	D+9KTbMDPTjyMoYOly2GZBQaAp45j8x4WvM7YXjz2CtYkaonHmOO1nIE8jyuhLlxUfRPtcKBFRj
	5mk+a8UwBlUgFvqXL8wjZ0vhDOxIgq1ygBWX5B16Rb8OnduI+lSQ60e5mzE8JHrdo56TfDZWtKP
	m32hqmrnd0P09wmRUpQQpU+FGcQtAR7F+Gh40lFWAK7tjZetvreoD92ruui5kPXSJFdsNnQ1SRK
	7v+1o+hx5LVnl6httERMbItRMmcMm+2ewaOOUIGt
X-Google-Smtp-Source: AGHT+IHZl+DbJWqzsW4usvg5XU8XG95/QBxRsXHVNuqnHskrM2O5sL7CTEM1KL/dJojrWYwbNX3q4vepU43szuZh3Cg=
X-Received: by 2002:a05:6402:5612:b0:634:66c8:9e7d with SMTP id
 4fb4d7f45d1cf-6349faa3493mr143723a12.36.1758733845069; Wed, 24 Sep 2025
 10:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-imx_rproc_c2-v2-0-d31c437507e5@nxp.com> <20250924164650.GA2711@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250924164650.GA2711@nxa18884-linux.ap.freescale.net>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 24 Sep 2025 11:10:33 -0600
X-Gm-Features: AS18NWBF6pgBTDh35FbgLrsaT57uZ-qc2vyxmLVdoUBaK9TLl5St00uV6e6iIsQ
Message-ID: <CANLsYkzWQEWKM-_iff7wY-sk_OERFiAMSrXP6Cyf8vJfXqunjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] remoteproc: imx_rproc: Use device managed API to
 clean up the driver
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Bjorn Andersson <andersson@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Hiago De Franco <hiago.franco@toradex.com>, 
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 09:35, Peng Fan <peng.fan@oss.nxp.com> wrote:
>
> Hi Mathieu, Bjorn
>
> On Tue, Sep 23, 2025 at 01:16:32PM +0800, Peng Fan wrote:
> >This is the 2nd series to cleanup the driver.
> >
> >---
> >Changes in v2:
> >- Address a build warning in patch 4/6
> >- Add R-b from Frank and Daniel
> >- Link to v1: https://lore.kernel.org/r/20250917-imx_rproc_c2-v1-0-00ce23dc9c6e@nxp.com
> >
> >---
> >Peng Fan (6):
> >      remoteproc: imx_rproc: Fix runtime PM cleanup order and error handling
> >      remoteproc: imx_rproc: Use devm_add_action_or_reset() for workqueue cleanup
> >      remoteproc: imx_rproc: Use devm_add_action_or_reset() for mailbox cleanup
> >      remoteproc: imx_rproc: Use devm_clk_get_enabled() and simplify cleanup
> >      remoteproc: imx_rproc: Use devm_add_action_or_reset() for scu cleanup
> >      remoteproc: imx_rproc: Use devm_rproc_add() helper
>
>
> Sorry for early ping - I just wanted to check if there's any chance for this
> patchset to be included in 6.18, along with the other cleanup patchset [1].

It seems very unlikely.  I am currently looking into how the PM
runtime framework behaves to address my own questions about this patch
[1].  Furthermore, I am worried about the usage of the device
management framework when it comes to freeing memory.  I will get back
to you with comments on that front when I know we are doing the right
thing with the PM runtime framework.

I dropped the 3rd cleanup patchset.  More than once I asked you to
submit only one patchset at a time and you still refuse to take notice
of my request.

Mathieu

[1]. "remoteproc: imx_rproc: Fix runtime PM cleanup order and error handling"

>
> Both patchsets have received Reviewed-by tags, have been tested, and
> successfully passed builds (arm64 gcc) with each patch applied incrementally.
>
> [1] https://lore.kernel.org/linux-remoteproc/20250920-imx_rproc_c2-v2-0-3351c4c96df5@nxp.com/T/#ma16bb8a38300f6eb333ee04f00d57805aee3c114
>
> Thanks
> Peng
>
> >
> > drivers/remoteproc/imx_rproc.c | 128 ++++++++++++++++++-----------------------
> > 1 file changed, 57 insertions(+), 71 deletions(-)
> >---
> >base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> >change-id: 20250916-imx_rproc_c2-2b9ad7882f4d
> >
> >Best regards,
> >--
> >Peng Fan <peng.fan@nxp.com>
> >

